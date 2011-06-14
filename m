From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 14 Jun 2011 11:58:21 +0100
Subject: [RFC PATCH v2 1/5] ARM: mm: Add generic proc/arch struct definition
	macros
In-Reply-To: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
References: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308049105-16080-2-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds some generic macros to reduce boilerplate when
declaring certain common structures in arch/arm/mm/*.S

Thanks to Russell King for outlining what the
define_processor_functions macro could look like.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-macros.S |   79 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 34261f9..3c5ffbb 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -4,6 +4,7 @@
  *  VMA_VM_FLAGS
  *  VM_EXEC
  */
+#include <linux/init.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 
@@ -254,3 +255,81 @@
 	mcr	p15, 0, r0, c7, c10, 1		@ clean L1 D line
 	mcr	p15, 0, ip, c7, c10, 4		@ data write barrier
 	.endm
+
+.macro define_processor_functions name:req, dabort:req, pabort:req, nommu=0, suspend=0
+	.pushsection .text
+
+	__INITDATA
+
+	.type	\name\()_processor_functions, #object
+
+ENTRY(\name\()_processor_functions)
+	.word	\dabort\()_abort
+	.word	\pabort\()_pabort
+	.word	cpu_\name\()_proc_init
+	.word	cpu_\name\()_proc_fin
+	.word	cpu_\name\()_reset
+	.word	cpu_\name\()_do_idle
+	.word	cpu_\name\()_dcache_clean_area
+	.word	cpu_\name\()_switch_mm
+
+	.if \nommu
+	.word	0
+	.else
+	.word	cpu_\name\()_set_pte_ext
+	.endif
+
+	.if \suspend
+	.word	cpu_\name\()_suspend_size
+	.word	cpu_\name\()_do_suspend
+	.word	cpu_\name\()_do_resume
+	.else
+	.word	0
+	.word	0
+	.word	0
+	.endif
+
+	.size	\name\()_processor_functions, . - \name\()_processor_functions
+
+	.popsection
+.endm
+
+.macro define_proc_names name:req, arch:req, elf:req, cpu:req
+	.pushsection .rodata.str, "aMS", 1
+
+	.type \name\()_arch_name, #object
+\name\()_arch_name: .asciz "\arch"
+	.size \name\()_arch_name, . - \name\()_arch_name
+
+	.type \name\()_elf_name, #object
+\name\()_elf_name: .asciz "\elf"
+	.size \name\()_elf_name, . - \name\()_elf_name
+
+	.type \name\()_cpu_name, #object
+\name\()_cpu_name: .asciz "\cpu"
+	.size \name\()_cpu_name, . - \name\()_cpu_name
+
+	.popsection
+.endm
+
+.macro define_cache_functions name:req
+	.pushsection .text
+
+	__INITDATA
+
+	.type	\name\()_cache_fns, #object
+ENTRY(\name\()_cache_fns)
+	.long	\name\()_flush_icache_all
+	.long	\name\()_flush_kern_cache_all
+	.long	\name\()_flush_user_cache_all
+	.long	\name\()_flush_user_cache_range
+	.long	\name\()_coherent_kern_range
+	.long	\name\()_coherent_user_range
+	.long	\name\()_flush_kern_dcache_area
+	.long	\name\()_dma_map_area
+	.long	\name\()_dma_unmap_area
+	.long	\name\()_dma_flush_range
+	.size	\name\()_cache_fns, . - \name\()_cache_fns
+
+	.popsection
+.endm
-- 
1.7.4.1
