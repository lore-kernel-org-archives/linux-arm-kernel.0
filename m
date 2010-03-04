From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: ICST: provide definitions for max/min VCO frequencies
References: <git-1267729916-d9e7099903d7e6aeb982cf23eca37d0d92e92484@rmk-PC>
Message-ID: <git-1267729916-f718b3314cc4467ef64dce4a5d988a3d2a5fcf47@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/icst307.c                |    2 +-
 arch/arm/common/icst525.c                |    2 +-
 arch/arm/include/asm/hardware/icst307.h  |    7 +++++++
 arch/arm/include/asm/hardware/icst525.h  |    8 ++++++++
 arch/arm/mach-integrator/cpu.c           |    4 ++--
 arch/arm/mach-integrator/impd1.c         |    2 +-
 arch/arm/mach-integrator/integrator_cp.c |    2 +-
 arch/arm/mach-realview/core.c            |    2 +-
 arch/arm/mach-versatile/core.c           |    2 +-
 9 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/arm/common/icst307.c b/arch/arm/common/icst307.c
index f78f5b5..f6063c9 100644
--- a/arch/arm/common/icst307.c
+++ b/arch/arm/common/icst307.c
@@ -53,7 +53,7 @@ icst307_khz_to_vco(const struct icst_params *p, unsigned long freq)
 		/*
 		 * f must be between 6MHz and 200MHz (3.3 or 5V)
 		 */
-		if (f > 6000 && f <= p->vco_max)
+		if (f > ICST307_VCO_MIN && f <= p->vco_max)
 			break;
 	} while (i < ARRAY_SIZE(idx2s));
 
diff --git a/arch/arm/common/icst525.c b/arch/arm/common/icst525.c
index eadf983..34dc2e1 100644
--- a/arch/arm/common/icst525.c
+++ b/arch/arm/common/icst525.c
@@ -51,7 +51,7 @@ icst525_khz_to_vco(const struct icst_params *p, unsigned long freq)
 		 * f must be between 10MHz and
 		 *  320MHz (5V) or 200MHz (3V)
 		 */
-		if (f > 10000 && f <= p->vco_max)
+		if (f > ICST525_VCO_MIN && f <= p->vco_max)
 			break;
 	} while (i < ARRAY_SIZE(idx2s));
 
diff --git a/arch/arm/include/asm/hardware/icst307.h b/arch/arm/include/asm/hardware/icst307.h
index 8d0820a..0c4e37e 100644
--- a/arch/arm/include/asm/hardware/icst307.h
+++ b/arch/arm/include/asm/hardware/icst307.h
@@ -21,4 +21,11 @@
 unsigned long icst307_khz(const struct icst_params *p, struct icst_vco vco);
 struct icst_vco icst307_khz_to_vco(const struct icst_params *p, unsigned long freq);
 
+/*
+ * ICST307 VCO frequency must be between 6MHz and 200MHz (3.3 or 5V).
+ * This frequency is pre-output divider.
+ */
+#define ICST307_VCO_MIN	6000
+#define ICST307_VCO_MAX	200000
+
 #endif
diff --git a/arch/arm/include/asm/hardware/icst525.h b/arch/arm/include/asm/hardware/icst525.h
index 42a274e..3b72c13 100644
--- a/arch/arm/include/asm/hardware/icst525.h
+++ b/arch/arm/include/asm/hardware/icst525.h
@@ -19,4 +19,12 @@
 unsigned long icst525_khz(const struct icst_params *p, struct icst_vco vco);
 struct icst_vco icst525_khz_to_vco(const struct icst_params *p, unsigned long freq);
 
+/*
+ * ICST525 VCO frequency must be between 10MHz and 200MHz (3V) or 320MHz (5V).
+ * This frequency is pre-output divider.
+ */
+#define ICST525_VCO_MIN		10000
+#define ICST525_VCO_MAX_3V	200000
+#define ICST525_VCO_MAX_5V	320000
+
 #endif
diff --git a/arch/arm/mach-integrator/cpu.c b/arch/arm/mach-integrator/cpu.c
index c4e5deb..1671b4a 100644
--- a/arch/arm/mach-integrator/cpu.c
+++ b/arch/arm/mach-integrator/cpu.c
@@ -33,7 +33,7 @@ static struct cpufreq_driver integrator_driver;
 
 static const struct icst_params lclk_params = {
 	.ref		= 24000,
-	.vco_max	= 320000,
+	.vco_max	= ICST525_VCO_MAX_5V,
 	.vd_min		= 8,
 	.vd_max		= 132,
 	.rd_min		= 24,
@@ -42,7 +42,7 @@ static const struct icst_params lclk_params = {
 
 static const struct icst_params cclk_params = {
 	.ref		= 24000,
-	.vco_max	= 320000,
+	.vco_max	= ICST525_VCO_MAX_5V,
 	.vd_min		= 12,
 	.vd_max		= 160,
 	.rd_min		= 24,
diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index dfb961b..5aca7eb 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -42,7 +42,7 @@ struct impd1_module {
 
 static const struct icst_params impd1_vco_params = {
 	.ref		= 24000,	/* 24 MHz */
-	.vco_max	= 200000,	/* 200 MHz */
+	.vco_max	= ICST525_VCO_MAX_3V,
 	.vd_min		= 12,
 	.vd_max		= 519,
 	.rd_min		= 3,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 15bfbe2..27f9510 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -270,7 +270,7 @@ static void __init intcp_init_irq(void)
 
 static const struct icst_params cp_auxvco_params = {
 	.ref		= 24000,
-	.vco_max	= 320000,
+	.vco_max	= ICST525_VCO_MAX_5V,
 	.vd_min 	= 8,
 	.vd_max 	= 263,
 	.rd_min 	= 3,
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index ac50474..5a850f0 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -275,7 +275,7 @@ struct mmci_platform_data realview_mmc1_plat_data = {
  */
 static const struct icst_params realview_oscvco_params = {
 	.ref		= 24000,
-	.vco_max	= 200000,
+	.vco_max	= ICST307_VCO_MAX,
 	.vd_min		= 4 + 8,
 	.vd_max		= 511 + 8,
 	.rd_min		= 1 + 2,
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index ded7134..f8ed561 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -381,7 +381,7 @@ static struct mmci_platform_data mmc0_plat_data = {
  */
 static const struct icst_params versatile_oscvco_params = {
 	.ref		= 24000,
-	.vco_max	= 200000,
+	.vco_max	= ICST307_VCO_MAX,
 	.vd_min		= 4 + 8,
 	.vd_max		= 511 + 8,
 	.rd_min		= 1 + 2,
