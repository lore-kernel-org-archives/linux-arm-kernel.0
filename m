From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Tue, 29 Mar 2011 12:30:56 +0200
Subject: [PATCH v4 10/10] NOMMU: implement access_remote_vm
In-Reply-To: <1301394656-24853-1-git-send-email-ithamar.adema@team-embedded.nl>
References: <1301394656-24853-1-git-send-email-ithamar.adema@team-embedded.nl>
Message-ID: <1301394656-24853-11-git-send-email-ithamar.adema@team-embedded.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike Frysinger <vapier@gentoo.org>

Recent vm changes brought in a new function which the core procfs code
utilizes.  So implement it for nommu systems too to avoid link failures.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
This patch was already sent to LKML, but I included it only to keep
the current patchset buildable....
---
 mm/nommu.c |   52 +++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index cb86e7d..c4c542c 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1971,21 +1971,10 @@ int filemap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 }
 EXPORT_SYMBOL(filemap_fault);
 
-/*
- * Access another process' address space.
- * - source/target buffer must be kernel space
- */
-int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
+static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
+		unsigned long addr, void *buf, int len, int write)
 {
 	struct vm_area_struct *vma;
-	struct mm_struct *mm;
-
-	if (addr + len < addr)
-		return 0;
-
-	mm = get_task_mm(tsk);
-	if (!mm)
-		return 0;
 
 	down_read(&mm->mmap_sem);
 
@@ -2010,6 +1999,43 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, in
 	}
 
 	up_read(&mm->mmap_sem);
+
+	return len;
+}
+
+/**
+ * @access_remote_vm - access another process' address space
+ * @mm:		the mm_struct of the target address space
+ * @addr:	start address to access
+ * @buf:	source or destination buffer
+ * @len:	number of bytes to transfer
+ * @write:	whether the access is a write
+ *
+ * The caller must hold a reference on @mm.
+ */
+int access_remote_vm(struct mm_struct *mm, unsigned long addr,
+		void *buf, int len, int write)
+{
+	return __access_remote_vm(NULL, mm, addr, buf, len, write);
+}
+
+/*
+ * Access another process' address space.
+ * - source/target buffer must be kernel space
+ */
+int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write)
+{
+	struct mm_struct *mm;
+
+	if (addr + len < addr)
+		return 0;
+
+	mm = get_task_mm(tsk);
+	if (!mm)
+		return 0;
+
+	len = __access_remote_vm(tsk, mm, addr, buf, len, write);
+
 	mmput(mm);
 	return len;
 }
-- 
1.7.1
