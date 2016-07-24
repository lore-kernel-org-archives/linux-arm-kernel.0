From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 24 Jul 2016 11:30:25 -0400
Subject: [PATCH v5 11/15] binfmt_flat: add MMU-specific support
In-Reply-To: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
References: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1469374229-21585-12-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not much else to do at this point except for the different stack setups.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
---
 fs/binfmt_flat.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index aa7971ce6a..7b999aebad 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -537,7 +537,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 	 * case,  and then the fully copied to RAM case which lumps
 	 * it all together.
 	 */
-	if ((flags & (FLAT_FLAG_RAM|FLAT_FLAG_GZIP)) == 0) {
+	if (!IS_ENABLED(CONFIG_MMU) && !(flags & (FLAT_FLAG_RAM|FLAT_FLAG_GZIP))) {
 		/*
 		 * this should give us a ROM ptr,  but if it doesn't we don't
 		 * really care
@@ -677,7 +677,9 @@ static int load_flat_file(struct linux_binprm *bprm,
 		 */
 		current->mm->start_brk = datapos + data_len + bss_len;
 		current->mm->brk = (current->mm->start_brk + 3) & ~3;
+#ifndef CONFIG_MMU
 		current->mm->context.end_brk = memp + memp_size - stack_len;
+#endif
 	}
 
 	if (flags & FLAT_FLAG_KTRACE) {
@@ -870,7 +872,7 @@ static int load_flat_binary(struct linux_binprm *bprm)
 {
 	struct lib_info libinfo;
 	struct pt_regs *regs = current_pt_regs();
-	unsigned long stack_len;
+	unsigned long stack_len = 0;
 	unsigned long start_addr;
 	int res;
 	int i, j;
@@ -884,7 +886,9 @@ static int load_flat_binary(struct linux_binprm *bprm)
 	 * pedantic and include space for the argv/envp array as it may have
 	 * a lot of entries.
 	 */
-	stack_len = PAGE_SIZE * MAX_ARG_PAGES - bprm->p;  /* the strings */
+#ifndef CONFIG_MMU
+	stack_len += PAGE_SIZE * MAX_ARG_PAGES - bprm->p; /* the strings */
+#endif
 	stack_len += (bprm->argc + 1) * sizeof(char *);   /* the argv array */
 	stack_len += (bprm->envc + 1) * sizeof(char *);   /* the envp array */
 	stack_len = ALIGN(stack_len, FLAT_STACK_ALIGN);
@@ -912,6 +916,11 @@ static int load_flat_binary(struct linux_binprm *bprm)
 
 	set_binfmt(&flat_format);
 
+#ifdef CONFIG_MMU
+	res = setup_arg_pages(bprm, STACK_TOP, EXSTACK_DEFAULT);
+	if (!res)
+		res = create_flat_tables(bprm, bprm->p);
+#else
 	/* Stash our initial stack pointer into the mm structure */
 	current->mm->start_stack =
 		((current->mm->context.end_brk + stack_len + 3) & ~3) - 4;
@@ -921,6 +930,7 @@ static int load_flat_binary(struct linux_binprm *bprm)
 	res = transfer_args_to_stack(bprm, &current->mm->start_stack);
 	if (!res)
 		res = create_flat_tables(bprm, current->mm->start_stack);
+#endif
 	if (res)
 		return res;
 
-- 
2.7.4
