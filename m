From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 17 Aug 2017 03:23:44 -0400
Subject: [PATCH v2 5/8] ARM: add ELF_FDPIC support
In-Reply-To: <20170817072347.19990-1-nicolas.pitre@linaro.org>
References: <20170817072347.19990-1-nicolas.pitre@linaro.org>
Message-ID: <20170817072347.19990-6-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This includes the necessary code to recognise the FDPIC format on ARM
and the ptrace command definitions used by the common ptrace code.

Based on patches originally from Mickael Guene <mickael.guene@st.com>.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/elf.h         | 12 ++++++++++++
 arch/arm/include/asm/mmu.h         |  4 ++++
 arch/arm/include/uapi/asm/ptrace.h |  4 ++++
 fs/Kconfig.binfmt                  |  2 +-
 4 files changed, 21 insertions(+), 1 deletion(-)

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
2.9.5
