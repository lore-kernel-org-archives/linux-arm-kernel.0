From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 28 Jul 2017 23:51:50 -0400
Subject: [PATCH 4/4] ARM: add ELF_FDPIC support
In-Reply-To: <20170729035150.5214-1-nicolas.pitre@linaro.org>
References: <20170729035150.5214-1-nicolas.pitre@linaro.org>
Message-ID: <20170729035150.5214-5-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This includes the necessary code to recognise the FDPIC format on ARM,
the handling of signal return code where function pointers are actually
function descriptor pointers, and the ptrace command definitions used
by the common ptrace code.

Based on patches originally from Mickael Guene <mickael.guene@st.com>.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/elf.h         | 12 ++++++++++++
 arch/arm/include/asm/mmu.h         |  4 ++++
 arch/arm/include/uapi/asm/ptrace.h |  4 ++++
 arch/arm/kernel/signal.c           | 28 ++++++++++++++++++++++++++++
 arch/arm/kernel/sigreturn_codes.S  | 22 ++++++++++++++++++++++
 fs/Kconfig.binfmt                  |  2 +-
 6 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index e2786acf82..ad0ca4f2ba 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -100,6 +100,11 @@ struct elf32_hdr;
 extern int elf_check_arch(const struct elf32_hdr *);
 #define elf_check_arch elf_check_arch
 
+#define ELFOSABI_ARM_FDPIC  65	/* ARM FDPIC platform */
+#define elf_check_fdpic(x)  ((x)->e_ident[EI_OSABI] == ELFOSABI_ARM_FDPIC)
+#define elf_check_const_displacement(x)  ((x)->e_flags & EF_ARM_PIC)
+#define ELF_FDPIC_CORE_EFLAGS  0
+
 #define vmcore_elf64_check_arch(x) (0)
 
 extern int arm_elf_read_implies_exec(int);
@@ -120,6 +125,13 @@ int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs);
    have no such handler.  */
 #define ELF_PLAT_INIT(_r, load_addr)	(_r)->ARM_r0 = 0
 
+#define ELF_FDPIC_PLAT_INIT(_r, _exec_map_addr, _interp_map_addr, dynamic_addr) \
+	do { \
+		(_r)->ARM_r7 = _exec_map_addr; \
+		(_r)->ARM_r8 = _interp_map_addr; \
+		(_r)->ARM_r9 = dynamic_addr; \
+	} while(0)
+
 extern void elf_set_personality(const struct elf32_hdr *);
 #define SET_PERSONALITY(ex)	elf_set_personality(&(ex))
 
diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index a5b4742105..e0eb16680a 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -33,6 +33,10 @@ typedef struct {
  */
 typedef struct {
 	unsigned long	end_brk;
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	unsigned long	exec_fdpic_loadmap;
+	unsigned long	interp_fdpic_loadmap;
+#endif
 } mm_context_t;
 
 #endif
diff --git a/arch/arm/include/uapi/asm/ptrace.h b/arch/arm/include/uapi/asm/ptrace.h
index 5af0ed1b82..3173eb9751 100644
--- a/arch/arm/include/uapi/asm/ptrace.h
+++ b/arch/arm/include/uapi/asm/ptrace.h
@@ -31,6 +31,10 @@
 #define PTRACE_SETVFPREGS	28
 #define PTRACE_GETHBPREGS	29
 #define PTRACE_SETHBPREGS	30
+#define PTRACE_GETFDPIC		31
+
+#define PTRACE_GETFDPIC_EXEC	0
+#define PTRACE_GETFDPIC_INTERP	1
 
 /*
  * PSR bits
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 7b8f214142..1deb6a3ab8 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -23,6 +23,7 @@
 #include <asm/vfp.h>
 
 extern const unsigned long sigreturn_codes[7];
+extern const unsigned long sigreturn_fdpic_codes[6];
 
 static unsigned long signal_return_offset;
 
@@ -323,9 +324,20 @@ setup_return(struct pt_regs *regs, struct ksignal *ksig,
 	     unsigned long __user *rc, void __user *frame)
 {
 	unsigned long handler = (unsigned long)ksig->ka.sa.sa_handler;
+	unsigned long handler_fdpic_GOT;
 	unsigned long retcode;
 	int thumb = 0;
 	unsigned long cpsr = regs->ARM_cpsr & ~(PSR_f | PSR_E_BIT);
+	bool fdpic = IS_ENABLED(CONFIG_BINFMT_ELF_FDPIC) &&
+		     (current->personality & FDPIC_FUNCPTRS);
+
+	if (fdpic) {
+		unsigned long __user *fdpic_func_desc =
+					(unsigned long __user *)handler;
+		if (__get_user(handler, &fdpic_func_desc[0]) ||
+		    __get_user(handler_fdpic_GOT, &fdpic_func_desc[1]))
+			return 1;
+	}
 
 	cpsr |= PSR_ENDSTATE;
 
@@ -365,6 +377,20 @@ setup_return(struct pt_regs *regs, struct ksignal *ksig,
 
 	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
 		retcode = (unsigned long)ksig->ka.sa.sa_restorer;
+		if (fdpic) {
+			/* We need code to process the function descriptor */
+			const unsigned long *opcodes = sigreturn_fdpic_codes;
+			opcodes += thumb + (thumb << 1);
+			if (__put_user(opcodes[0], rc) ||
+			    __put_user(opcodes[1], rc+1) ||
+			    __put_user(opcodes[2], rc+2) ||
+			    __put_user(retcode, rc+3))
+				return 1;
+			/* Last word is not executed, hence 3 words to flush */
+			flush_icache_range((unsigned long)rc,
+					   (unsigned long)(rc + 3));
+			retcode = (unsigned long)rc + thumb;
+		}
 	} else {
 		unsigned int idx = thumb << 1;
 
@@ -408,6 +434,8 @@ setup_return(struct pt_regs *regs, struct ksignal *ksig,
 	regs->ARM_sp = (unsigned long)frame;
 	regs->ARM_lr = retcode;
 	regs->ARM_pc = handler;
+	if (fdpic)
+		regs->ARM_r9 = handler_fdpic_GOT;
 	regs->ARM_cpsr = cpsr;
 
 	return 0;
diff --git a/arch/arm/kernel/sigreturn_codes.S b/arch/arm/kernel/sigreturn_codes.S
index b84d0cb136..9bbb5bb883 100644
--- a/arch/arm/kernel/sigreturn_codes.S
+++ b/arch/arm/kernel/sigreturn_codes.S
@@ -100,3 +100,25 @@ ARM_OK(	swi	#(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE)	)
 	.space	4
 
 	.size	sigreturn_codes, . - sigreturn_codes
+
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+
+	.global	sigreturn_fdpic_codes
+	.type	sigreturn_fdpic_codes, #object
+	.align
+sigreturn_fdpic_codes:
+
+ARM_OK(	.arm )
+ARM_OK(	ldr	ip, [pc, #4] )	/* get function descriptor */
+ARM_OK(	ldr	r9, [ip, #4] )	/* setup GOT register */
+ARM_OK(	ldr	pc, [ip] )	/* branch to function */
+
+	.org	sigreturn_fdpic_codes + 3*4
+	.thumb
+	ldr	ip, [pc, #8]	/* get function descriptor */
+	ldr	r9, [ip, #4]	/* setup GOT register */
+	ldr	pc, [ip]	/* branch to function */
+
+	.size	sigreturn_fdpic_codes, . - sigreturn_fdpic_codes
+
+#endif
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index b2f82cf6bf..6ef70ce8e9 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -35,7 +35,7 @@ config ARCH_BINFMT_ELF_STATE
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
 	default y
-	depends on (FRV || BLACKFIN || (SUPERH32 && !MMU) || C6X)
+	depends on ((ARM && !MMU) || FRV || BLACKFIN || (SUPERH32 && !MMU) || C6X)
 	select ELFCORE
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load
-- 
2.9.4
