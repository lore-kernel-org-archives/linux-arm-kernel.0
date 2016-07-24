From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 24 Jul 2016 11:30:20 -0400
Subject: [PATCH v5 06/15] binfmt_flat: clean up create_flat_tables() and stack
 accesses
In-Reply-To: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
References: <1469374229-21585-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1469374229-21585-7-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In addition to better code clarity, this brings proper usage of
user memory accessors everywhere the stack is touched. This is essential
for making this work on MMU systems.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
---
 fs/binfmt_flat.c | 117 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 63 insertions(+), 54 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index a002e1a3b9..5dc7968a42 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -103,50 +103,58 @@ static int flat_core_dump(struct coredump_params *cprm)
 /*
  * create_flat_tables() parses the env- and arg-strings in new user
  * memory and creates the pointer tables from them, and puts their
- * addresses on the "stack", returning the new stack pointer value.
+ * addresses on the "stack", recording the new stack pointer value.
  */
 
-static unsigned long create_flat_tables(
-	unsigned long pp,
-	struct linux_binprm *bprm)
+static int create_flat_tables(struct linux_binprm *bprm, unsigned long arg_start)
 {
-	unsigned long *argv, *envp;
-	unsigned long *sp;
-	char *p = (char *)pp;
-	int argc = bprm->argc;
-	int envc = bprm->envc;
-	char uninitialized_var(dummy);
-
-	sp = (unsigned long *)p;
-	sp -= (envc + argc + 2) + 1 + (flat_argvp_envp_on_stack() ? 2 : 0);
-	sp = (unsigned long *) ((unsigned long)sp & -FLAT_STACK_ALIGN);
-	argv = sp + 1 + (flat_argvp_envp_on_stack() ? 2 : 0);
-	envp = argv + (argc + 1);
+	char __user *p;
+	unsigned long __user *sp;
+	long i, len;
 
+	p = (char __user *)arg_start;
+	sp = (unsigned long __user *)current->mm->start_stack;
+
+	sp -= bprm->envc + 1;
+	sp -= bprm->argc + 1;
+	sp -= flat_argvp_envp_on_stack() ? 2 : 0;
+	sp -= 1;  /* &argc */
+
+	current->mm->start_stack = (unsigned long)sp & -FLAT_STACK_ALIGN;
+	sp = (unsigned long __user *)current->mm->start_stack;
+
+	__put_user(bprm->argc, sp++);
 	if (flat_argvp_envp_on_stack()) {
-		put_user((unsigned long) envp, sp + 2);
-		put_user((unsigned long) argv, sp + 1);
-	}
-
-	put_user(argc, sp);
-	current->mm->arg_start = (unsigned long) p;
-	while (argc-- > 0) {
-		put_user((unsigned long) p, argv++);
-		do {
-			get_user(dummy, p); p++;
-		} while (dummy);
-	}
-	put_user((unsigned long) NULL, argv);
-	current->mm->arg_end = current->mm->env_start = (unsigned long) p;
-	while (envc-- > 0) {
-		put_user((unsigned long)p, envp); envp++;
-		do {
-			get_user(dummy, p); p++;
-		} while (dummy);
-	}
-	put_user((unsigned long) NULL, envp);
-	current->mm->env_end = (unsigned long) p;
-	return (unsigned long)sp;
+		unsigned long argv, envp;
+		argv = (unsigned long)(sp + 2);
+		envp = (unsigned long)(sp + 2 + bprm->argc + 1);
+		__put_user(argv, sp++);
+		__put_user(envp, sp++);
+	}
+
+	current->mm->arg_start = (unsigned long)p;
+	for (i = bprm->argc; i > 0; i--) {
+		__put_user((unsigned long)p, sp++);
+		len = strnlen_user(p, MAX_ARG_STRLEN);
+		if (!len || len > MAX_ARG_STRLEN)
+			return -EINVAL;
+		p += len;
+	}
+	__put_user(0, sp++);
+	current->mm->arg_end = (unsigned long)p;
+
+	current->mm->env_start = (unsigned long) p;
+	for (i = bprm->envc; i > 0; i--) {
+		__put_user((unsigned long)p, sp++);
+		len = strnlen_user(p, MAX_ARG_STRLEN);
+		if (!len || len > MAX_ARG_STRLEN)
+			return -EINVAL;
+		p += len;
+	}
+	__put_user(0, sp++);
+	current->mm->env_end = (unsigned long)p;
+
+	return 0;
 }
 
 /****************************************************************************/
@@ -846,7 +854,7 @@ static int load_flat_binary(struct linux_binprm *bprm)
 {
 	struct lib_info libinfo;
 	struct pt_regs *regs = current_pt_regs();
-	unsigned long sp, stack_len;
+	unsigned long stack_len;
 	unsigned long start_addr;
 	int res;
 	int i, j;
@@ -860,11 +868,10 @@ static int load_flat_binary(struct linux_binprm *bprm)
 	 * pedantic and include space for the argv/envp array as it may have
 	 * a lot of entries.
 	 */
-#define TOP_OF_ARGS (PAGE_SIZE * MAX_ARG_PAGES - sizeof(void *))
-	stack_len = TOP_OF_ARGS - bprm->p;             /* the strings */
-	stack_len += (bprm->argc + 1) * sizeof(char *); /* the argv array */
-	stack_len += (bprm->envc + 1) * sizeof(char *); /* the envp array */
-	stack_len += FLAT_STACK_ALIGN - 1;  /* reserve for upcoming alignment */
+	stack_len = PAGE_SIZE * MAX_ARG_PAGES - bprm->p;  /* the strings */
+	stack_len += (bprm->argc + 1) * sizeof(char *);   /* the argv array */
+	stack_len += (bprm->envc + 1) * sizeof(char *);   /* the envp array */
+	stack_len = ALIGN(stack_len, FLAT_STACK_ALIGN);
 
 	res = load_flat_file(bprm, &libinfo, 0, &stack_len);
 	if (res < 0)
@@ -882,16 +889,18 @@ static int load_flat_binary(struct linux_binprm *bprm)
 
 	set_binfmt(&flat_format);
 
-	sp = ((current->mm->context.end_brk + stack_len + 3) & ~3) - 4;
-	pr_debug("sp=%lx\n", sp);
+	/* Stash our initial stack pointer into the mm structure */
+	current->mm->start_stack =
+		((current->mm->context.end_brk + stack_len + 3) & ~3) - 4;
+	pr_debug("sp=%lx\n", current->mm->start_stack);
 
 	/* copy the arg pages onto the stack */
-	res = transfer_args_to_stack(bprm, &sp);
+	res = transfer_args_to_stack(bprm, &current->mm->start_stack);
+	if (!res)
+		res = create_flat_tables(bprm, current->mm->start_stack);
 	if (res)
 		return res;
 
-	sp = create_flat_tables(sp, bprm);
-
 	/* Fake some return addresses to ensure the call chain will
 	 * initialise library in order for us.  We are required to call
 	 * lib 1 first, then 2, ... and finally the main program (id 0).
@@ -902,15 +911,15 @@ static int load_flat_binary(struct linux_binprm *bprm)
 	for (i = MAX_SHARED_LIBS-1; i > 0; i--) {
 		if (libinfo.lib_list[i].loaded) {
 			/* Push previos first to call address */
-			--sp;	put_user(start_addr, (unsigned long *)sp);
+			unsigned long __user *sp;
+			current->mm->start_stack -= sizeof(unsigned long);
+			sp = (unsigned long __user *)current->mm->start_stack;
+			__put_user(start_addr, sp);
 			start_addr = libinfo.lib_list[i].entry;
 		}
 	}
 #endif
 
-	/* Stash our initial stack pointer into the mm structure */
-	current->mm->start_stack = sp;
-
 #ifdef FLAT_PLAT_INIT
 	FLAT_PLAT_INIT(regs);
 #endif
-- 
2.7.4
