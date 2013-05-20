From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 20 May 2013 18:39:24 +0800
Subject: [PATCH V2 1/6] ARM: tegra: add an assembly marco to check Tegra SoC ID
In-Reply-To: <1369046369-12489-1-git-send-email-josephl@nvidia.com>
References: <1369046369-12489-1-git-send-email-josephl@nvidia.com>
Message-ID: <1369046369-12489-2-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some Tegra SoC ID checking code around the low level assembly
code. Adding a marco to replace them. For the single image to support all
the Tegra series, we may also need the marco in other common code. So we
make it become a marco for the usage.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V2:
* refine the tegra_get_soc_id marco
---
 arch/arm/mach-tegra/fuse.h          | 22 ++++++++++++----------
 arch/arm/mach-tegra/reset-handler.S | 25 +++++++++----------------
 arch/arm/mach-tegra/sleep.h         |  9 +++++++++
 3 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-tegra/fuse.h b/arch/arm/mach-tegra/fuse.h
index aacc00d..def7968 100644
--- a/arch/arm/mach-tegra/fuse.h
+++ b/arch/arm/mach-tegra/fuse.h
@@ -19,16 +19,6 @@
 #ifndef __MACH_TEGRA_FUSE_H
 #define __MACH_TEGRA_FUSE_H
 
-enum tegra_revision {
-	TEGRA_REVISION_UNKNOWN = 0,
-	TEGRA_REVISION_A01,
-	TEGRA_REVISION_A02,
-	TEGRA_REVISION_A03,
-	TEGRA_REVISION_A03p,
-	TEGRA_REVISION_A04,
-	TEGRA_REVISION_MAX,
-};
-
 #define SKU_ID_T20	8
 #define SKU_ID_T25SE	20
 #define SKU_ID_AP25	23
@@ -40,6 +30,17 @@ enum tegra_revision {
 #define TEGRA30		0x30
 #define TEGRA114	0x35
 
+#ifndef __ASSEMBLY__
+enum tegra_revision {
+	TEGRA_REVISION_UNKNOWN = 0,
+	TEGRA_REVISION_A01,
+	TEGRA_REVISION_A02,
+	TEGRA_REVISION_A03,
+	TEGRA_REVISION_A03p,
+	TEGRA_REVISION_A04,
+	TEGRA_REVISION_MAX,
+};
+
 extern int tegra_sku_id;
 extern int tegra_cpu_process_id;
 extern int tegra_core_process_id;
@@ -72,5 +73,6 @@ void tegra114_init_speedo_data(void);
 #else
 static inline void tegra114_init_speedo_data(void) {}
 #endif
+#endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index e6de88a..40af405 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -22,11 +22,11 @@
 #include <asm/hardware/cache-l2x0.h>
 
 #include "flowctrl.h"
+#include "fuse.h"
 #include "iomap.h"
 #include "reset.h"
 #include "sleep.h"
 
-#define APB_MISC_GP_HIDREV	0x804
 #define PMC_SCRATCH41	0x140
 
 #define RESET_DATA(x)	((TEGRA_RESET_##x)*4)
@@ -49,10 +49,8 @@ ENTRY(tegra_resume)
 
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
 	/* Are we on Tegra20? */
-	mov32	r6, TEGRA_APB_MISC_BASE
-	ldr	r0, [r6, #APB_MISC_GP_HIDREV]
-	and	r0, r0, #0xff00
-	cmp	r0, #(0x20 << 8)
+	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
+	cmp	r6, #TEGRA20
 	beq	1f				@ Yes
 	/* Clear the flow controller flags for this CPU. */
 	mov32	r2, TEGRA_FLOW_CTRL_BASE + FLOW_CTRL_CPU0_CSR	@ CPU0 CSR
@@ -98,7 +96,7 @@ ENTRY(__tegra_cpu_reset_handler_start)
  * Register usage within the reset handler:
  *
  *      Others: scratch
- *      R6  = SoC ID << 8
+ *      R6  = SoC ID
  *      R7  = CPU present (to the OS) mask
  *      R8  = CPU in LP1 state mask
  *      R9  = CPU in LP2 state mask
@@ -115,12 +113,10 @@ ENTRY(__tegra_cpu_reset_handler)
 
 	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
 
-	mov32	r6, TEGRA_APB_MISC_BASE
-	ldr	r6, [r6, #APB_MISC_GP_HIDREV]
-	and	r6, r6, #0xff00
+	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 t20_check:
-	cmp	r6, #(0x20 << 8)
+	cmp	r6, #TEGRA20
 	bne	after_t20_check
 t20_errata:
 	# Tegra20 is a Cortex-A9 r1p1
@@ -136,7 +132,7 @@ after_t20_check:
 #endif
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
 t30_check:
-	cmp	r6, #(0x30 << 8)
+	cmp	r6, #TEGRA30
 	bne	after_t30_check
 t30_errata:
 	# Tegra30 is a Cortex-A9 r2p9
@@ -163,7 +159,7 @@ after_errata:
 
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 	/* Are we on Tegra20? */
-	cmp	r6, #(0x20 << 8)
+	cmp	r6, #TEGRA20
 	bne	1f
 	/* If not CPU0, don't let CPU0 reset CPU1 now that CPU1 is coming up. */
 	mov32	r5, TEGRA_PMC_BASE
@@ -210,10 +206,7 @@ __die:
 	mov32	r7, TEGRA_CLK_RESET_BASE
 
 	/* Are we on Tegra20? */
-	mov32	r6, TEGRA_APB_MISC_BASE
-	ldr	r0, [r6, #APB_MISC_GP_HIDREV]
-	and	r0, r0, #0xff00
-	cmp	r0, #(0x20 << 8)
+	cmp	r6, #TEGRA20
 	bne	1f
 
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
diff --git a/arch/arm/mach-tegra/sleep.h b/arch/arm/mach-tegra/sleep.h
index 2080fb1..f9f2164 100644
--- a/arch/arm/mach-tegra/sleep.h
+++ b/arch/arm/mach-tegra/sleep.h
@@ -85,6 +85,15 @@
 	dsb
 .endm
 
+/* Macro to check Tegra revision */
+#define APB_MISC_GP_HIDREV	0x804
+.macro tegra_get_soc_id base, tmp1
+	mov32	\tmp1, \base
+	ldr	\tmp1, [\tmp1, #APB_MISC_GP_HIDREV]
+	and	\tmp1, \tmp1, #0xff00
+	mov	\tmp1, \tmp1, lsr #8
+.endm
+
 /* Macro to resume & re-enable L2 cache */
 #ifndef L2X0_CTRL_EN
 #define L2X0_CTRL_EN	1
-- 
1.8.2.2
