From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 17 Aug 2017 03:23:45 -0400
Subject: [PATCH v2 6/8] ARM: enable elf_fdpic on systems with an MMU
In-Reply-To: <20170817072347.19990-1-nicolas.pitre@linaro.org>
References: <20170817072347.19990-1-nicolas.pitre@linaro.org>
Message-ID: <20170817072347.19990-7-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide the necessary changes to be able to execute ELF-FDPIC binaries
on ARM systems with an MMU.

The default for CONFIG_BINFMT_ELF_FDPIC is also set to n if the regular
ELF loader is already configured so not to force FDPIC support on
everyone. Given that CONFIG_BINFMT_ELF depends on CONFIG_MMU, this means
CONFIG_BINFMT_ELF_FDPIC will still default to y when !MMU.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/mmu.h |  4 ++++
 arch/arm/kernel/elf.c      | 22 ++++++++++++++++++++++
 fs/Kconfig.binfmt          |  4 ++--
 fs/binfmt_elf_fdpic.c      |  5 +++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index e0eb16680a..bdec37c6ac 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -14,6 +14,10 @@ typedef struct {
 #ifdef CONFIG_VDSO
 	unsigned long	vdso;
 #endif
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	unsigned long	exec_fdpic_loadmap;
+	unsigned long	interp_fdpic_loadmap;
+#endif
 } mm_context_t;
 
 #ifdef CONFIG_CPU_HAS_ASID
diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
index 52fb98358d..569e69ece5 100644
--- a/arch/arm/kernel/elf.c
+++ b/arch/arm/kernel/elf.c
@@ -3,6 +3,7 @@
 #include <linux/personality.h>
 #include <linux/binfmts.h>
 #include <linux/elf.h>
+#include <linux/elf-fdpic.h>
 #include <asm/system_info.h>
 
 int elf_check_arch(const struct elf32_hdr *x)
@@ -89,3 +90,24 @@ int arm_elf_read_implies_exec(int executable_stack)
 	return 0;
 }
 EXPORT_SYMBOL(arm_elf_read_implies_exec);
+
+#if defined(CONFIG_MMU) && defined(CONFIG_BINFMT_ELF_FDPIC)
+
+void elf_fdpic_arch_lay_out_mm(struct elf_fdpic_params *exec_params,
+			       struct elf_fdpic_params *interp_params,
+			       unsigned long *start_stack,
+			       unsigned long *start_brk)
+{
+	elf_set_personality(&exec_params->hdr);
+
+	exec_params->load_addr = 0x8000;
+	interp_params->load_addr = ELF_ET_DYN_BASE;
+	*start_stack = TASK_SIZE - SZ_16M;
+
+	if ((exec_params->flags & ELF_FDPIC_FLAG_ARRANGEMENT) == ELF_FDPIC_FLAG_INDEPENDENT) {
+		exec_params->flags &= ~ELF_FDPIC_FLAG_ARRANGEMENT;
+		exec_params->flags |= ELF_FDPIC_FLAG_CONSTDISP;
+	}
+}
+
+#endif
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 6ef70ce8e9..58c2bbd385 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -34,8 +34,8 @@ config ARCH_BINFMT_ELF_STATE
 
 config BINFMT_ELF_FDPIC
 	bool "Kernel support for FDPIC ELF binaries"
-	default y
-	depends on ((ARM && !MMU) || FRV || BLACKFIN || (SUPERH32 && !MMU) || C6X)
+	default y if !BINFMT_ELF
+	depends on (ARM || FRV || BLACKFIN || (SUPERH32 && !MMU) || C6X)
 	select ELFCORE
 	help
 	  ELF FDPIC binaries are based on ELF, but allow the individual load
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index cf93a4fad0..692e2a1fd2 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -377,6 +377,11 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 				 executable_stack);
 	if (retval < 0)
 		goto error;
+#ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
+	retval = arch_setup_additional_pages(bprm, !!interpreter_name);
+	if (retval < 0)
+		goto error;
+#endif
 #endif
 
 	/* load the executable and interpreter into memory */
-- 
2.9.5
