From: mylene.josserand@bootlin.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue,  3 Apr 2018 08:18:26 +0200
Subject: [PATCH v5 03/13] ARM: sunxi: smp: Move cpu_resume assembly entry into
 file
In-Reply-To: <20180403061836.3926-1-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
Message-ID: <20180403061836.3926-4-mylene.josserand@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the CPU resume assembly function into the assembly file
to remove all assembly code from C code.

Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/headsmp.S |  5 +++++
 arch/arm/mach-sunxi/mc_smp.c  | 11 +----------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
index 119005b5dff9..79890fbe5613 100644
--- a/arch/arm/mach-sunxi/headsmp.S
+++ b/arch/arm/mach-sunxi/headsmp.S
@@ -73,3 +73,8 @@ ENTRY(sunxi_mc_smp_secondary_startup)
 	bl	sunxi_mc_smp_cluster_cache_enable
 	b	secondary_startup
 ENDPROC(sunxi_mc_smp_secondary_startup)
+
+ENTRY(sunxi_mc_smp_resume)
+	bl	sunxi_mc_smp_cluster_cache_enable
+	b	cpu_resume
+ENDPROC(sunxi_mc_smp_resume)
diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 9cc6c8fc6db7..727968d6a3e5 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -73,6 +73,7 @@ static void __iomem *prcm_base;
 static void __iomem *sram_b_smp_base;
 
 extern void sunxi_mc_smp_secondary_startup(void);
+extern void sunxi_mc_smp_resume(void);
 
 static bool sunxi_core_is_cortex_a15(unsigned int core, unsigned int cluster)
 {
@@ -572,16 +573,6 @@ static bool __init sunxi_mc_smp_cpu_table_init(void)
  */
 typedef typeof(cpu_reset) phys_reset_t;
 
-static void __init __naked sunxi_mc_smp_resume(void)
-{
-	asm volatile(
-		"bl	sunxi_mc_smp_cluster_cache_enable\n"
-		"b	cpu_resume"
-		/* Let compiler know about sunxi_mc_smp_cluster_cache_enable */
-		:: "i" (sunxi_mc_smp_cluster_cache_enable)
-	);
-}
-
 static int __init nocache_trampoline(unsigned long __unused)
 {
 	phys_reset_t phys_reset;
-- 
2.11.0
