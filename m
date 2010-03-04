From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: ICST: move minimum VCO frequency to icst_params
References: <git-1267729916-ff35c828640614581186e8105b4b08a1881d8137@rmk-PC>
Message-ID: <git-1267729916-d6819e2672c1b28c5b4e50c4f22e1895b85881aa@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/icst307.c                |    2 +-
 arch/arm/common/icst525.c                |    2 +-
 arch/arm/include/asm/hardware/icst.h     |    1 +
 arch/arm/mach-integrator/cpu.c           |    2 ++
 arch/arm/mach-integrator/impd1.c         |    1 +
 arch/arm/mach-integrator/integrator_cp.c |    1 +
 arch/arm/mach-realview/core.c            |    1 +
 arch/arm/mach-versatile/core.c           |    1 +
 8 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/icst307.c b/arch/arm/common/icst307.c
index 66c69e5..312485f 100644
--- a/arch/arm/common/icst307.c
+++ b/arch/arm/common/icst307.c
@@ -53,7 +53,7 @@ icst307_hz_to_vco(const struct icst_params *p, unsigned long freq)
 		/*
 		 * f must be between 6MHz and 200MHz (3.3 or 5V)
 		 */
-		if (f > ICST307_VCO_MIN && f <= p->vco_max)
+		if (f > p->vco_min && f <= p->vco_max)
 			break;
 	} while (i < ARRAY_SIZE(idx2s));
 
diff --git a/arch/arm/common/icst525.c b/arch/arm/common/icst525.c
index c1d22b7..da58965 100644
--- a/arch/arm/common/icst525.c
+++ b/arch/arm/common/icst525.c
@@ -51,7 +51,7 @@ icst525_hz_to_vco(const struct icst_params *p, unsigned long freq)
 		 * f must be between 10MHz and
 		 *  320MHz (5V) or 200MHz (3V)
 		 */
-		if (f > ICST525_VCO_MIN && f <= p->vco_max)
+		if (f > p->vco_min && f <= p->vco_max)
 			break;
 	} while (i < ARRAY_SIZE(idx2s));
 
diff --git a/arch/arm/include/asm/hardware/icst.h b/arch/arm/include/asm/hardware/icst.h
index 65b1edd..6707c6a 100644
--- a/arch/arm/include/asm/hardware/icst.h
+++ b/arch/arm/include/asm/hardware/icst.h
@@ -17,6 +17,7 @@
 struct icst_params {
 	unsigned long	ref;
 	unsigned long	vco_max;	/* inclusive */
+	unsigned long	vco_min;	/* exclusive */
 	unsigned short	vd_min;		/* inclusive */
 	unsigned short	vd_max;		/* inclusive */
 	unsigned char	rd_min;		/* inclusive */
diff --git a/arch/arm/mach-integrator/cpu.c b/arch/arm/mach-integrator/cpu.c
index 3ebb785..569306b 100644
--- a/arch/arm/mach-integrator/cpu.c
+++ b/arch/arm/mach-integrator/cpu.c
@@ -34,6 +34,7 @@ static struct cpufreq_driver integrator_driver;
 static const struct icst_params lclk_params = {
 	.ref		= 24000000,
 	.vco_max	= ICST525_VCO_MAX_5V,
+	.vco_min	= ICST525_VCO_MIN,
 	.vd_min		= 8,
 	.vd_max		= 132,
 	.rd_min		= 24,
@@ -43,6 +44,7 @@ static const struct icst_params lclk_params = {
 static const struct icst_params cclk_params = {
 	.ref		= 24000000,
 	.vco_max	= ICST525_VCO_MAX_5V,
+	.vco_min	= ICST525_VCO_MIN,
 	.vd_min		= 12,
 	.vd_max		= 160,
 	.rd_min		= 24,
diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index ecce3eb..036cfb4 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -43,6 +43,7 @@ struct impd1_module {
 static const struct icst_params impd1_vco_params = {
 	.ref		= 24000000,	/* 24 MHz */
 	.vco_max	= ICST525_VCO_MAX_3V,
+	.vco_min	= ICST525_VCO_MIN,
 	.vd_min		= 12,
 	.vd_max		= 519,
 	.rd_min		= 3,
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 335af99..34c120a 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -271,6 +271,7 @@ static void __init intcp_init_irq(void)
 static const struct icst_params cp_auxvco_params = {
 	.ref		= 24000000,
 	.vco_max	= ICST525_VCO_MAX_5V,
+	.vco_min	= ICST525_VCO_MIN,
 	.vd_min 	= 8,
 	.vd_max 	= 263,
 	.rd_min 	= 3,
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 02d4837..3ac4413 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -276,6 +276,7 @@ struct mmci_platform_data realview_mmc1_plat_data = {
 static const struct icst_params realview_oscvco_params = {
 	.ref		= 24000000,
 	.vco_max	= ICST307_VCO_MAX,
+	.vco_min	= ICST307_VCO_MIN,
 	.vd_min		= 4 + 8,
 	.vd_max		= 511 + 8,
 	.rd_min		= 1 + 2,
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index ff5d24f..c4bf680 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -382,6 +382,7 @@ static struct mmci_platform_data mmc0_plat_data = {
 static const struct icst_params versatile_oscvco_params = {
 	.ref		= 24000000,
 	.vco_max	= ICST307_VCO_MAX,
+	.vco_min	= ICST307_VCO_MIN,
 	.vd_min		= 4 + 8,
 	.vd_max		= 511 + 8,
 	.rd_min		= 1 + 2,
