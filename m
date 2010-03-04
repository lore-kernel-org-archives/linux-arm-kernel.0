From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: ICST: use Hz instead of kHz
References: <git-1267729916-f718b3314cc4467ef64dce4a5d988a3d2a5fcf47@rmk-PC>
Message-ID: <git-1267729916-ff35c828640614581186e8105b4b08a1881d8137@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This makes the ICST support fit more nicely with the clk API,
eliminating the need to *1000 and /1000 in places.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/icst307.c                |    8 ++++----
 arch/arm/common/icst525.c                |    8 ++++----
 arch/arm/include/asm/hardware/icst307.h  |    8 ++++----
 arch/arm/include/asm/hardware/icst525.h  |   10 +++++-----
 arch/arm/mach-integrator/clock.c         |    8 ++++----
 arch/arm/mach-integrator/cpu.c           |   22 +++++++++++-----------
 arch/arm/mach-integrator/impd1.c         |    6 +++---
 arch/arm/mach-integrator/integrator_cp.c |    2 +-
 arch/arm/mach-realview/clock.c           |    8 ++++----
 arch/arm/mach-realview/core.c            |    2 +-
 arch/arm/mach-versatile/clock.c          |    8 ++++----
 arch/arm/mach-versatile/core.c           |    2 +-
 12 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm/common/icst307.c b/arch/arm/common/icst307.c
index f6063c9..66c69e5 100644
--- a/arch/arm/common/icst307.c
+++ b/arch/arm/common/icst307.c
@@ -24,12 +24,12 @@
  */
 static unsigned char s2div[8] = { 10, 2, 8, 4, 5, 7, 3, 6 };
 
-unsigned long icst307_khz(const struct icst_params *p, struct icst_vco vco)
+unsigned long icst307_hz(const struct icst_params *p, struct icst_vco vco)
 {
 	return p->ref * 2 * (vco.v + 8) / ((vco.r + 2) * s2div[vco.s]);
 }
 
-EXPORT_SYMBOL(icst307_khz);
+EXPORT_SYMBOL(icst307_hz);
 
 /*
  * Ascending divisor S values.
@@ -37,7 +37,7 @@ EXPORT_SYMBOL(icst307_khz);
 static unsigned char idx2s[8] = { 1, 6, 3, 4, 7, 5, 2, 0 };
 
 struct icst_vco
-icst307_khz_to_vco(const struct icst_params *p, unsigned long freq)
+icst307_hz_to_vco(const struct icst_params *p, unsigned long freq)
 {
 	struct icst_vco vco = { .s = 1, .v = p->vd_max, .r = p->rd_max };
 	unsigned long f;
@@ -94,4 +94,4 @@ icst307_khz_to_vco(const struct icst_params *p, unsigned long freq)
 	return vco;
 }
 
-EXPORT_SYMBOL(icst307_khz_to_vco);
+EXPORT_SYMBOL(icst307_hz_to_vco);
diff --git a/arch/arm/common/icst525.c b/arch/arm/common/icst525.c
index 34dc2e1..c1d22b7 100644
--- a/arch/arm/common/icst525.c
+++ b/arch/arm/common/icst525.c
@@ -21,12 +21,12 @@
  */
 static unsigned char s2div[8] = { 10, 2, 8, 4, 5, 7, 9, 6 };
 
-unsigned long icst525_khz(const struct icst_params *p, struct icst_vco vco)
+unsigned long icst525_hz(const struct icst_params *p, struct icst_vco vco)
 {
 	return p->ref * 2 * (vco.v + 8) / ((vco.r + 2) * s2div[vco.s]);
 }
 
-EXPORT_SYMBOL(icst525_khz);
+EXPORT_SYMBOL(icst525_hz);
 
 /*
  * Ascending divisor S values.
@@ -34,7 +34,7 @@ EXPORT_SYMBOL(icst525_khz);
 static unsigned char idx2s[] = { 1, 3, 4, 7, 5, 2, 6, 0 };
 
 struct icst_vco
-icst525_khz_to_vco(const struct icst_params *p, unsigned long freq)
+icst525_hz_to_vco(const struct icst_params *p, unsigned long freq)
 {
 	struct icst_vco vco = { .s = 1, .v = p->vd_max, .r = p->rd_max };
 	unsigned long f;
@@ -92,4 +92,4 @@ icst525_khz_to_vco(const struct icst_params *p, unsigned long freq)
 	return vco;
 }
 
-EXPORT_SYMBOL(icst525_khz_to_vco);
+EXPORT_SYMBOL(icst525_hz_to_vco);
diff --git a/arch/arm/include/asm/hardware/icst307.h b/arch/arm/include/asm/hardware/icst307.h
index 0c4e37e..0f09618 100644
--- a/arch/arm/include/asm/hardware/icst307.h
+++ b/arch/arm/include/asm/hardware/icst307.h
@@ -18,14 +18,14 @@
 
 #include <asm/hardware/icst.h>
 
-unsigned long icst307_khz(const struct icst_params *p, struct icst_vco vco);
-struct icst_vco icst307_khz_to_vco(const struct icst_params *p, unsigned long freq);
+unsigned long icst307_hz(const struct icst_params *p, struct icst_vco vco);
+struct icst_vco icst307_hz_to_vco(const struct icst_params *p, unsigned long freq);
 
 /*
  * ICST307 VCO frequency must be between 6MHz and 200MHz (3.3 or 5V).
  * This frequency is pre-output divider.
  */
-#define ICST307_VCO_MIN	6000
-#define ICST307_VCO_MAX	200000
+#define ICST307_VCO_MIN	6000000
+#define ICST307_VCO_MAX	200000000
 
 #endif
diff --git a/arch/arm/include/asm/hardware/icst525.h b/arch/arm/include/asm/hardware/icst525.h
index 3b72c13..1000a60 100644
--- a/arch/arm/include/asm/hardware/icst525.h
+++ b/arch/arm/include/asm/hardware/icst525.h
@@ -16,15 +16,15 @@
 
 #include <asm/hardware/icst.h>
 
-unsigned long icst525_khz(const struct icst_params *p, struct icst_vco vco);
-struct icst_vco icst525_khz_to_vco(const struct icst_params *p, unsigned long freq);
+unsigned long icst525_hz(const struct icst_params *p, struct icst_vco vco);
+struct icst_vco icst525_hz_to_vco(const struct icst_params *p, unsigned long freq);
 
 /*
  * ICST525 VCO frequency must be between 10MHz and 200MHz (3V) or 320MHz (5V).
  * This frequency is pre-output divider.
  */
-#define ICST525_VCO_MIN		10000
-#define ICST525_VCO_MAX_3V	200000
-#define ICST525_VCO_MAX_5V	320000
+#define ICST525_VCO_MIN		10000000
+#define ICST525_VCO_MAX_3V	200000000
+#define ICST525_VCO_MAX_5V	320000000
 
 #endif
diff --git a/arch/arm/mach-integrator/clock.c b/arch/arm/mach-integrator/clock.c
index bb70b64..a4f80d3 100644
--- a/arch/arm/mach-integrator/clock.c
+++ b/arch/arm/mach-integrator/clock.c
@@ -38,8 +38,8 @@ EXPORT_SYMBOL(clk_get_rate);
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	struct icst_vco vco;
-	vco = icst525_khz_to_vco(clk->params, rate / 1000);
-	return icst525_khz(clk->params, vco) * 1000;
+	vco = icst525_hz_to_vco(clk->params, rate);
+	return icst525_hz(clk->params, vco);
 }
 EXPORT_SYMBOL(clk_round_rate);
 
@@ -50,8 +50,8 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	if (clk->setvco) {
 		struct icst_vco vco;
 
-		vco = icst525_khz_to_vco(clk->params, rate / 1000);
-		clk->rate = icst525_khz(clk->params, vco) * 1000;
+		vco = icst525_hz_to_vco(clk->params, rate);
+		clk->rate = icst525_hz(clk->params, vco);
 		clk->setvco(clk, vco);
 		ret = 0;
 	}
diff --git a/arch/arm/mach-integrator/cpu.c b/arch/arm/mach-integrator/cpu.c
index 1671b4a..3ebb785 100644
--- a/arch/arm/mach-integrator/cpu.c
+++ b/arch/arm/mach-integrator/cpu.c
@@ -32,7 +32,7 @@ static struct cpufreq_driver integrator_driver;
 #define CM_LOCK IO_ADDRESS(INTEGRATOR_HDR_LOCK)
 
 static const struct icst_params lclk_params = {
-	.ref		= 24000,
+	.ref		= 24000000,
 	.vco_max	= ICST525_VCO_MAX_5V,
 	.vd_min		= 8,
 	.vd_max		= 132,
@@ -41,7 +41,7 @@ static const struct icst_params lclk_params = {
 };
 
 static const struct icst_params cclk_params = {
-	.ref		= 24000,
+	.ref		= 24000000,
 	.vco_max	= ICST525_VCO_MAX_5V,
 	.vd_min		= 12,
 	.vd_max		= 160,
@@ -60,11 +60,11 @@ static int integrator_verify_policy(struct cpufreq_policy *policy)
 				     policy->cpuinfo.min_freq, 
 				     policy->cpuinfo.max_freq);
 
-	vco = icst525_khz_to_vco(&cclk_params, policy->max);
-	policy->max = icst525_khz(&cclk_params, vco);
+	vco = icst525_hz_to_vco(&cclk_params, policy->max * 1000);
+	policy->max = icst525_hz(&cclk_params, vco) / 1000;
 
-	vco = icst525_khz_to_vco(&cclk_params, policy->min);
-	policy->min = icst525_khz(&cclk_params, vco);
+	vco = icst525_hz_to_vco(&cclk_params, policy->min * 1000);
+	policy->min = icst525_hz(&cclk_params, vco) / 1000;
 
 	cpufreq_verify_within_limits(policy, 
 				     policy->cpuinfo.min_freq, 
@@ -106,17 +106,17 @@ static int integrator_set_target(struct cpufreq_policy *policy,
 	}
 	vco.v = cm_osc & 255;
 	vco.r = 22;
-	freqs.old = icst525_khz(&cclk_params, vco);
+	freqs.old = icst525_hz(&cclk_params, vco) / 1000;
 
-	/* icst525_khz_to_vco rounds down -- so we need the next
+	/* icst525_hz_to_vco rounds down -- so we need the next
 	 * larger freq in case of CPUFREQ_RELATION_L.
 	 */
 	if (relation == CPUFREQ_RELATION_L)
 		target_freq += 999;
 	if (target_freq > policy->max)
 		target_freq = policy->max;
-	vco = icst525_khz_to_vco(&cclk_params, target_freq);
-	freqs.new = icst525_khz(&cclk_params, vco);
+	vco = icst525_hz_to_vco(&cclk_params, target_freq * 1000);
+	freqs.new = icst525_hz(&cclk_params, vco) / 1000;
 
 	freqs.cpu = policy->cpu;
 
@@ -174,7 +174,7 @@ static unsigned int integrator_get(unsigned int cpu)
 	vco.v = cm_osc & 255;
 	vco.r = 22;
 
-	current_freq = icst525_khz(&cclk_params, vco); /* current freq */
+	current_freq = icst525_hz(&cclk_params, vco) / 1000; /* current freq */
 
 	set_cpus_allowed(current, cpus_allowed);
 
diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 5aca7eb..ecce3eb 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -41,7 +41,7 @@ struct impd1_module {
 };
 
 static const struct icst_params impd1_vco_params = {
-	.ref		= 24000,	/* 24 MHz */
+	.ref		= 24000000,	/* 24 MHz */
 	.vco_max	= ICST525_VCO_MAX_3V,
 	.vd_min		= 12,
 	.vd_max		= 519,
@@ -73,8 +73,8 @@ static void impd1_setvco(struct clk *clk, struct icst_vco vco)
 	vco.r = (val >> 9) & 0x7f;
 	vco.s = (val >> 16) & 7;
 
-	pr_debug("IM-PD1: VCO%d clock is %ld kHz\n",
-		 vconr, icst525_khz(&impd1_vco_params, vco));
+	pr_debug("IM-PD1: VCO%d clock is %ld Hz\n",
+		 vconr, icst525_hz(&impd1_vco_params, vco));
 #endif
 }
 
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 27f9510..335af99 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -269,7 +269,7 @@ static void __init intcp_init_irq(void)
 #define CM_AUXOSC IO_ADDRESS(INTEGRATOR_HDR_BASE + 0x1c)
 
 static const struct icst_params cp_auxvco_params = {
-	.ref		= 24000,
+	.ref		= 24000000,
 	.vco_max	= ICST525_VCO_MAX_5V,
 	.vd_min 	= 8,
 	.vd_max 	= 263,
diff --git a/arch/arm/mach-realview/clock.c b/arch/arm/mach-realview/clock.c
index 8364657..2ba0667 100644
--- a/arch/arm/mach-realview/clock.c
+++ b/arch/arm/mach-realview/clock.c
@@ -42,8 +42,8 @@ EXPORT_SYMBOL(clk_get_rate);
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	struct icst_vco vco;
-	vco = icst307_khz_to_vco(clk->params, rate / 1000);
-	return icst307_khz(clk->params, vco) * 1000;
+	vco = icst307_hz_to_vco(clk->params, rate);
+	return icst307_hz(clk->params, vco);
 }
 EXPORT_SYMBOL(clk_round_rate);
 
@@ -54,8 +54,8 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	if (clk->setvco) {
 		struct icst_vco vco;
 
-		vco = icst307_khz_to_vco(clk->params, rate / 1000);
-		clk->rate = icst307_khz(clk->params, vco) * 1000;
+		vco = icst307_hz_to_vco(clk->params, rate);
+		clk->rate = icst307_hz(clk->params, vco);
 		clk->setvco(clk, vco);
 		ret = 0;
 	}
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 5a850f0..02d4837 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -274,7 +274,7 @@ struct mmci_platform_data realview_mmc1_plat_data = {
  * Clock handling
  */
 static const struct icst_params realview_oscvco_params = {
-	.ref		= 24000,
+	.ref		= 24000000,
 	.vco_max	= ICST307_VCO_MAX,
 	.vd_min		= 4 + 8,
 	.vd_max		= 511 + 8,
diff --git a/arch/arm/mach-versatile/clock.c b/arch/arm/mach-versatile/clock.c
index 530e16a..82753be 100644
--- a/arch/arm/mach-versatile/clock.c
+++ b/arch/arm/mach-versatile/clock.c
@@ -43,8 +43,8 @@ EXPORT_SYMBOL(clk_get_rate);
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	struct icst_vco vco;
-	vco = icst307_khz_to_vco(clk->params, rate / 1000);
-	return icst307_khz(clk->params, vco) * 1000;
+	vco = icst307_hz_to_vco(clk->params, rate);
+	return icst307_hz(clk->params, vco);
 }
 EXPORT_SYMBOL(clk_round_rate);
 
@@ -55,8 +55,8 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	if (clk->setvco) {
 		struct icst_vco vco;
 
-		vco = icst307_khz_to_vco(clk->params, rate / 1000);
-		clk->rate = icst307_khz(clk->params, vco) * 1000;
+		vco = icst307_hz_to_vco(clk->params, rate);
+		clk->rate = icst307_hz(clk->params, vco);
 		clk->setvco(clk, vco);
 		ret = 0;
 	}
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index f8ed561..ff5d24f 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -380,7 +380,7 @@ static struct mmci_platform_data mmc0_plat_data = {
  * Clock handling
  */
 static const struct icst_params versatile_oscvco_params = {
-	.ref		= 24000,
+	.ref		= 24000000,
 	.vco_max	= ICST307_VCO_MAX,
 	.vd_min		= 4 + 8,
 	.vd_max		= 511 + 8,
