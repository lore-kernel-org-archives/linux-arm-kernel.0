From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Thu,  9 Aug 2018 09:48:54 +0530
Subject: [PATCH v8 4/6] Uprobes/sdt: Prevent multiple reference counter for
 same uprobe
In-Reply-To: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
Message-ID: <20180809041856.1547-5-ravi.bangoria@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We assume to have only one reference counter for one uprobe.
Don't allow user to register multiple uprobes having same
inode+offset but different reference counter.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/events/uprobes.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 61b0481ef417..492a0e005b4d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -689,6 +689,12 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	cur_uprobe = insert_uprobe(uprobe);
 	/* a uprobe exists for this inode:offset combination */
 	if (cur_uprobe) {
+		if (cur_uprobe->ref_ctr_offset != uprobe->ref_ctr_offset) {
+			pr_warn("Reference counter offset mismatch.\n");
+			put_uprobe(cur_uprobe);
+			kfree(uprobe);
+			return ERR_PTR(-EINVAL);
+		}
 		kfree(uprobe);
 		uprobe = cur_uprobe;
 	}
@@ -1103,6 +1109,9 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
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
