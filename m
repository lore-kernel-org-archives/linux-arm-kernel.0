From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:09 +0100
Subject: [PATCH v3 01/40] Subject: ARM: mm: proc-macros Add generic
	proc/cache/tlb struct definition macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-2-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds some generic macros to reduce boilerplate when
declaring certain common structures in arch/arm/mm/*.S

Thanks to Russell King for outlining what the
define_processor_functions macro could look like.

Currently, only a few things can be overriden when invoking the
macros, based on the overrides actually required by the existing
CPUs.  More overrides arguments can be added in the future, if
needed.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-macros.S |   76 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 34261f9..fa28d6b 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -254,3 +254,79 @@
 	mcr	p15, 0, r0, c7, c10, 1		@ clean L1 D line
 	mcr	p15, 0, ip, c7, c10, 4		@ data write barrier
 	.endm
+
+.macro define_processor_functions name:req, dabort:req, pabort:req, nommu=0, suspend=0
+	.type	\name\()_processor_functions, #object
+	.align 2
+ENTRY(\name\()_processor_functions)
+	.word	\dabort
+	.word	\pabort
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
+.endm
+
+.macro define_cache_functions name:req, default:req, \
+		flush_kern_dcache_area, dma_map_area, dma_flush_range
+	.align 2
+ 	.type	\name\()_cache_fns, #object
+ENTRY(\name\()_cache_fns)
+	.long	\default\()_flush_icache_all
+	.long	\default\()_flush_kern_cache_all
+	.long	\default\()_flush_user_cache_all
+	.long	\default\()_flush_user_cache_range
+	.long	\default\()_coherent_kern_range
+	.long	\default\()_coherent_user_range
+	.ifb \flush_kern_dcache_area
+		.long	\default\()_flush_kern_dcache_area
+	.else
+		.long	\flush_kern_dcache_area
+	.endif
+	.ifb \dma_map_area
+		.long	\default\()_dma_map_area
+	.else
+		.long	\dma_map_area
+	.endif
+	.long	\default\()_dma_unmap_area
+	.ifb \dma_flush_range
+		.long	\default\()_dma_flush_range
+	.else
+		.long	\dma_flush_range
+	.endif
+	.size	\name\()_cache_fns, . - \name\()_cache_fns
+.endm
+
+.macro define_tlb_functions name:req, flags_up:req, flags_smp
+	.type	\name\()_tlb_fns, #object
+ENTRY(\name\()_tlb_fns)
+	.long	\name\()_flush_user_tlb_range
+	.long	\name\()_flush_kern_tlb_range
+	.ifnb \flags_smp
+		ALT_SMP(.long	\flags_smp )
+		ALT_UP(.long	\flags_up )
+	.else
+		.long	\flags_up
+	.endif
+	.size	\name\()_tlb_fns, . - \name\()_tlb_fns
+.endm
-- 
1.7.4.1
