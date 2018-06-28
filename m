From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Thu, 28 Jun 2018 10:52:00 +0530
Subject: [PATCH v5 01/10] Uprobes: Move uprobe structure to uprobe.h
In-Reply-To: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
Message-ID: <20180628052209.13056-2-ravi.bangoria@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need struct uprobe in some arch specific files. Move it to
uprobe.h from uprobe.c

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 include/linux/uprobes.h | 25 +++++++++++++++++++++++++
 kernel/events/uprobes.c | 24 ------------------------
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 0a294e950df8..044359083a57 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -28,6 +28,7 @@
 #include <linux/rbtree.h>
 #include <linux/types.h>
 #include <linux/wait.h>
+#include <linux/rwsem.h>
 
 struct vm_area_struct;
 struct mm_struct;
@@ -61,6 +62,30 @@ struct uprobe_consumer {
 #ifdef CONFIG_UPROBES
 #include <asm/uprobes.h>
 
+struct uprobe {
+	struct rb_node		rb_node;	/* node in the rb tree */
+	atomic_t		ref;
+	struct rw_semaphore	register_rwsem;
+	struct rw_semaphore	consumer_rwsem;
+	struct list_head	pending_list;
+	struct uprobe_consumer	*consumers;
+	struct inode		*inode;		/* Also hold a ref to inode */
+	loff_t			offset;
+	unsigned long		flags;
+
+	/*
+	 * The generic code assumes that it has two members of unknown type
+	 * owned by the arch-specific code:
+	 *
+	 *	insn -	copy_insn() saves the original instruction here for
+	 *		arch_uprobe_analyze_insn().
+	 *
+	 *	ixol -	potentially modified instruction to execute out of
+	 *		line, copied to xol_area by xol_get_insn_slot().
+	 */
+	struct arch_uprobe	arch;
+};
+
 enum uprobe_task_state {
 	UTASK_RUNNING,
 	UTASK_SSTEP,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index ccc579a7d32e..e6e812304b22 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -64,30 +64,6 @@ static struct percpu_rw_semaphore dup_mmap_sem;
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
 
-struct uprobe {
-	struct rb_node		rb_node;	/* node in the rb tree */
-	atomic_t		ref;
-	struct rw_semaphore	register_rwsem;
-	struct rw_semaphore	consumer_rwsem;
-	struct list_head	pending_list;
-	struct uprobe_consumer	*consumers;
-	struct inode		*inode;		/* Also hold a ref to inode */
-	loff_t			offset;
-	unsigned long		flags;
-
-	/*
-	 * The generic code assumes that it has two members of unknown type
-	 * owned by the arch-specific code:
-	 *
-	 * 	insn -	copy_insn() saves the original instruction here for
-	 *		arch_uprobe_analyze_insn().
-	 *
-	 *	ixol -	potentially modified instruction to execute out of
-	 *		line, copied to xol_area by xol_get_insn_slot().
-	 */
-	struct arch_uprobe	arch;
-};
-
 /*
  * Execute out of line area: anonymous executable mapping installed
  * by the probed task to execute the copy of the original instruction
-- 
2.14.4
