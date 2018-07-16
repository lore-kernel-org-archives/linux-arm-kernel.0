From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Mon, 16 Jul 2018 14:17:05 +0530
Subject: [PATCH v6 5/6] Uprobes/sdt: Prevent multiple reference counter for
 same uprobe
In-Reply-To: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
References: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
Message-ID: <20180716084706.28244-6-ravi.bangoria@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We assume to have only one reference counter for one uprobe. Don't
allow user to register multiple uprobes having same inode+offset
but different reference counter.

Though, existing tools which already support SDT events creates
normal uprobe and updates reference counter on their own. Allow 0 as
a special value for reference counter offset. I.e. two uprobes, one
having ref_ctr_offset=0 and the other having non-zero ref_ctr_offset
can coexists. This gives user a flexibility to either depend on
kernel uprobe infrastructure to maintain reference counter or just
use normal uprobe and maintain reference counter on his own.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/events/uprobes.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 84da8512a974..563cc3e625b3 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -63,6 +63,8 @@ static struct percpu_rw_semaphore dup_mmap_sem;
 
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
+/* Reference counter offset is reloaded with non-zero value. */
+#define REF_CTR_OFF_RELOADED	1
 
 struct uprobe {
 	struct rb_node		rb_node;	/* node in the rb tree */
@@ -476,9 +478,23 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		return ret;
 
 	ret = verify_opcode(old_page, vaddr, &opcode);
-	if (ret <= 0)
+	if (ret < 0)
 		goto put_old;
 
+	/*
+	 * If instruction is already patched but reference counter offset
+	 * has been reloaded to non-zero value, increment the reference
+	 * counter and return.
+	 */
+	if (ret == 0) {
+		if (is_register &&
+		    test_bit(REF_CTR_OFF_RELOADED, &uprobe->flags)) {
+			WARN_ON(!uprobe->ref_ctr_offset);
+			ret = update_ref_ctr(uprobe, mm, true);
+		}
+		goto put_old;
+	}
+
 	/* We are going to replace instruction, update ref_ctr. */
 	if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
 		ret = update_ref_ctr(uprobe, mm, is_register);
@@ -679,6 +695,30 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	cur_uprobe = insert_uprobe(uprobe);
 	/* a uprobe exists for this inode:offset combination */
 	if (cur_uprobe) {
+		/*
+		 * If inode+offset matches, ref_ctr_offset must match as
+		 * well. Though, 0 is a special value for ref_ctr_offset.
+		 */
+		if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset &&
+		    cur_uprobe->ref_ctr_offset != 0 &&
+		    uprobe->ref_ctr_offset != 0) {
+			pr_warn("Err: Reference counter mismatch.\n");
+			put_uprobe(cur_uprobe);
+			kfree(uprobe);
+			return ERR_PTR(-EINVAL);
+		}
+
+		/*
+		 * If existing uprobe->ref_ctr_offset is 0 and user is
+		 * registering same uprobe with non-zero ref_ctr_offset,
+		 * set new ref_ctr_offset to existing uprobe.
+		 */
+
+		if (!cur_uprobe->ref_ctr_offset && uprobe->ref_ctr_offset) {
+			cur_uprobe->ref_ctr_offset = uprobe->ref_ctr_offset;
+			set_bit(REF_CTR_OFF_RELOADED, &cur_uprobe->flags);
+		}
+
 		kfree(uprobe);
 		uprobe = cur_uprobe;
 	}
@@ -971,6 +1011,7 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 	bool is_register = !!new;
 	struct map_info *info;
 	int err = 0;
+	bool installed = false;
 
 	percpu_down_write(&dup_mmap_sem);
 	info = build_map_info(uprobe->inode->i_mapping,
@@ -1000,8 +1041,10 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 		if (is_register) {
 			/* consult only the "caller", new consumer. */
 			if (consumer_filter(new,
-					UPROBE_FILTER_REGISTER, mm))
+					UPROBE_FILTER_REGISTER, mm)) {
 				err = install_breakpoint(uprobe, mm, vma, info->vaddr);
+				installed = true;
+			}
 		} else if (test_bit(MMF_HAS_UPROBES, &mm->flags)) {
 			if (!filter_chain(uprobe,
 					UPROBE_FILTER_UNREGISTER, mm))
@@ -1016,6 +1059,8 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 	}
  out:
 	percpu_up_write(&dup_mmap_sem);
+	if (installed)
+		clear_bit(REF_CTR_OFF_RELOADED, &uprobe->flags);
 	return err;
 }
 
@@ -1093,6 +1138,9 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 	uprobe = alloc_uprobe(inode, offset, ref_ctr_offset);
 	if (!uprobe)
 		return -ENOMEM;
+	if (IS_ERR(uprobe))
+		return PTR_ERR(uprobe);
+
 	/*
 	 * We can race with uprobe_unregister()->delete_uprobe().
 	 * Check uprobe_is_active() and retry if it is false.
-- 
2.14.4
