From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 24 Jul 2016 11:30:18 -0400
Subject: [PATCH v5 04/15] elf_fdpic_transfer_args_to_stack(): make it generic
In-Reply-To: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
References: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1469374229-21585-5-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This copying of arguments and environment is common to both NOMMU
binary formats we support. Let's make the elf_fdpic version available
to the flat format as well.

While at it, improve the code a bit not to copy below the actual
data area.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
---
 fs/binfmt_elf_fdpic.c   | 38 ++------------------------------------
 fs/exec.c               | 33 +++++++++++++++++++++++++++++++++
 include/linux/binfmts.h |  2 ++
 3 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 203589311b..464a972e88 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -67,8 +67,6 @@ static int create_elf_fdpic_tables(struct linux_binprm *, struct mm_struct *,
 				   struct elf_fdpic_params *);
 
 #ifndef CONFIG_MMU
-static int elf_fdpic_transfer_args_to_stack(struct linux_binprm *,
-					    unsigned long *);
 static int elf_fdpic_map_file_constdisp_on_uclinux(struct elf_fdpic_params *,
 						   struct file *,
 						   struct mm_struct *);
@@ -515,8 +513,9 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	sp = mm->start_stack;
 
 	/* stack the program arguments and environment */
-	if (elf_fdpic_transfer_args_to_stack(bprm, &sp) < 0)
+	if (transfer_args_to_stack(bprm, &sp) < 0)
 		return -EFAULT;
+	sp &= ~15;
 #endif
 
 	/*
@@ -711,39 +710,6 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 
 /*****************************************************************************/
 /*
- * transfer the program arguments and environment from the holding pages onto
- * the stack
- */
-#ifndef CONFIG_MMU
-static int elf_fdpic_transfer_args_to_stack(struct linux_binprm *bprm,
-					    unsigned long *_sp)
-{
-	unsigned long index, stop, sp;
-	char *src;
-	int ret = 0;
-
-	stop = bprm->p >> PAGE_SHIFT;
-	sp = *_sp;
-
-	for (index = MAX_ARG_PAGES - 1; index >= stop; index--) {
-		src = kmap(bprm->page[index]);
-		sp -= PAGE_SIZE;
-		if (copy_to_user((void *) sp, src, PAGE_SIZE) != 0)
-			ret = -EFAULT;
-		kunmap(bprm->page[index]);
-		if (ret < 0)
-			goto out;
-	}
-
-	*_sp = (*_sp - (MAX_ARG_PAGES * PAGE_SIZE - bprm->p)) & ~15;
-
-out:
-	return ret;
-}
-#endif
-
-/*****************************************************************************/
-/*
  * load the appropriate binary image (executable or interpreter) into memory
  * - we assume no MMU is available
  * - if no other PIC bits are set in params->hdr->e_flags
diff --git a/fs/exec.c b/fs/exec.c
index 887c1c955d..ef0df2f092 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -762,6 +762,39 @@ out_unlock:
 }
 EXPORT_SYMBOL(setup_arg_pages);
 
+#else
+
+/*
+ * Transfer the program arguments and environment from the holding pages
+ * onto the stack. The provided stack pointer is adjusted accordingly.
+ */
+int transfer_args_to_stack(struct linux_binprm *bprm,
+			   unsigned long *sp_location)
+{
+	unsigned long index, stop, sp;
+	int ret = 0;
+
+	stop = bprm->p >> PAGE_SHIFT;
+	sp = *sp_location;
+
+	for (index = MAX_ARG_PAGES - 1; index >= stop; index--) {
+		unsigned int offset = index == stop ? bprm->p & ~PAGE_MASK : 0;
+		char *src = kmap(bprm->page[index]) + offset;
+		sp -= PAGE_SIZE - offset;
+		if (copy_to_user((void *) sp, src, PAGE_SIZE - offset) != 0)
+			ret = -EFAULT;
+		kunmap(bprm->page[index]);
+		if (ret)
+			goto out;
+	}
+
+	*sp_location = sp;
+
+out:
+	return ret;
+}
+EXPORT_SYMBOL(transfer_args_to_stack);
+
 #endif /* CONFIG_MMU */
 
 static struct file *do_open_execat(int fd, struct filename *name, int flags)
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 314b3caa70..1303b570b1 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -113,6 +113,8 @@ extern int suid_dumpable;
 extern int setup_arg_pages(struct linux_binprm * bprm,
 			   unsigned long stack_top,
 			   int executable_stack);
+extern int transfer_args_to_stack(struct linux_binprm *bprm,
+				  unsigned long *sp_location);
 extern int bprm_change_interp(char *interp, struct linux_binprm *bprm);
 extern int copy_strings_kernel(int argc, const char *const *argv,
 			       struct linux_binprm *bprm);
-- 
2.7.4
