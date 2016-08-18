From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 18 Aug 2016 13:45:58 +0100
Subject: [PATCH v2 6/8] ARM: V7M: Wire up caches for V7M processors with cache
 support.
In-Reply-To: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
References: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1471524360-31554-7-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Austin <jonathan.austin@arm.com>

This patch does the plumbing required to invoke the V7M cache code added
in earlier patches in this series, although there is no users for that
yet.

In order to honour the I/D cache disable config options, this patch changes
the mechanism by which the CCR is set on boot, to be more like V7A/R.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/glue-cache.h |    4 ----
 arch/arm/kernel/head-nommu.S      |   16 +++++++++++++++-
 arch/arm/mm/Kconfig               |   10 +++++++---
 arch/arm/mm/Makefile              |    2 ++
 arch/arm/mm/proc-v7m.S            |    5 ++---
 5 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
index cab07f6..01c3d92 100644
--- a/arch/arm/include/asm/glue-cache.h
+++ b/arch/arm/include/asm/glue-cache.h
@@ -118,11 +118,7 @@
 #endif
 
 #if defined(CONFIG_CPU_V7M)
-# ifdef _CACHE
 #  define MULTI_CACHE 1
-# else
-#  define _CACHE nop
-# endif
 #endif
 
 #if !defined(_CACHE) && !defined(MULTI_CACHE)
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index fb1a69e..6b4eb27 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -158,7 +158,21 @@ __after_proc_init:
 	bic	r0, r0, #CR_V
 #endif
 	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
-#endif /* CONFIG_CPU_CP15 */
+#elif defined (CONFIG_CPU_V7M)
+	/* For V7M systems we want to modify the CCR similarly to the SCTLR */
+#ifdef CONFIG_CPU_DCACHE_DISABLE
+	bic	r0, r0, #V7M_SCB_CCR_DC
+#endif
+#ifdef CONFIG_CPU_BPREDICT_DISABLE
+	bic	r0, r0, #V7M_SCB_CCR_BP
+#endif
+#ifdef CONFIG_CPU_ICACHE_DISABLE
+	bic	r0, r0, #V7M_SCB_CCR_IC
+#endif
+	movw	r3, #:lower16:(BASEADDR_V7M_SCB + V7M_SCB_CCR)
+	movt	r3, #:upper16:(BASEADDR_V7M_SCB + V7M_SCB_CCR)
+	str	r0, [r3]
+#endif /* CONFIG_CPU_CP15 elif CONFIG_CPU_V7M */
 	ret	lr
 ENDPROC(__after_proc_init)
 	.ltorg
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index d15a7fe..e613122 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -403,6 +403,7 @@ config CPU_V7M
 	bool
 	select CPU_32v7M
 	select CPU_ABRT_NOMMU
+	select CPU_CACHE_V7M
 	select CPU_CACHE_NOP
 	select CPU_PABRT_LEGACY
 	select CPU_THUMBONLY
@@ -518,6 +519,9 @@ config CPU_CACHE_VIPT
 config CPU_CACHE_FA
 	bool
 
+config CPU_CACHE_V7M
+	bool
+
 if MMU
 # The copy-page model
 config CPU_COPY_V4WT
@@ -750,14 +754,14 @@ config CPU_HIGH_VECTOR
 
 config CPU_ICACHE_DISABLE
 	bool "Disable I-Cache (I-bit)"
-	depends on CPU_CP15 && !(CPU_ARM720T || CPU_ARM740T || CPU_XSCALE || CPU_XSC3)
+	depends on (CPU_CP15 && !(CPU_ARM720T || CPU_ARM740T || CPU_XSCALE || CPU_XSC3)) || CPU_V7M
 	help
 	  Say Y here to disable the processor instruction cache. Unless
 	  you have a reason not to or are unsure, say N.
 
 config CPU_DCACHE_DISABLE
 	bool "Disable D-Cache (C-bit)"
-	depends on CPU_CP15 && !SMP
+	depends on (CPU_CP15 && !SMP) || CPU_V7M
 	help
 	  Say Y here to disable the processor data cache. Unless
 	  you have a reason not to or are unsure, say N.
@@ -792,7 +796,7 @@ config CPU_CACHE_ROUND_ROBIN
 
 config CPU_BPREDICT_DISABLE
 	bool "Disable branch prediction"
-	depends on CPU_ARM1020 || CPU_V6 || CPU_V6K || CPU_MOHAWK || CPU_XSC3 || CPU_V7 || CPU_FA526
+	depends on CPU_ARM1020 || CPU_V6 || CPU_V6K || CPU_MOHAWK || CPU_XSC3 || CPU_V7 || CPU_FA526 || CPU_V7M
 	help
 	  Say Y here to disable branch prediction.  If unsure, say N.
 
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 7f76d96..e75abae 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -43,9 +43,11 @@ obj-$(CONFIG_CPU_CACHE_V6)	+= cache-v6.o
 obj-$(CONFIG_CPU_CACHE_V7)	+= cache-v7.o
 obj-$(CONFIG_CPU_CACHE_FA)	+= cache-fa.o
 obj-$(CONFIG_CPU_CACHE_NOP)	+= cache-nop.o
+obj-$(CONFIG_CPU_CACHE_V7M)	+= cache-v7m.o
 
 AFLAGS_cache-v6.o	:=-Wa,-march=armv6
 AFLAGS_cache-v7.o	:=-Wa,-march=armv7-a
+AFLAGS_cache-v7m.o	:=-Wa,-march=armv7-m
 
 obj-$(CONFIG_CPU_COPY_V4WT)	+= copypage-v4wt.o
 obj-$(CONFIG_CPU_COPY_V4WB)	+= copypage-v4wb.o
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 7229d8d..11f5816 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -118,9 +118,8 @@ __v7m_setup:
 
 	@ Configure the System Control Register to ensure 8-byte stack alignment
 	@ Note the STKALIGN bit is either RW or RAO.
-	ldr	r12, [r0, V7M_SCB_CCR]	@ system control register
-	orr	r12, #V7M_SCB_CCR_STKALIGN
-	str	r12, [r0, V7M_SCB_CCR]
+	ldr	r0, [r0, V7M_SCB_CCR]   @ system control register
+	orr	r0, #V7M_SCB_CCR_STKALIGN
 	ret	lr
 ENDPROC(__v7m_setup)
 
-- 
1.7.9.5
