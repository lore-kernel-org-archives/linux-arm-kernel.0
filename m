From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: ICST: kill duplicate icst code
References: <git-1267729916-85cd101b49493ef8f37bb61c2b28c6905b9852e1@rmk-PC>
Message-ID: <git-1267729916-2dbb324ef24e91a11ed84389718874ece7056fd7@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The only difference between ICST307 and ICST525 are the two arrays
for calculating the S parameter; the code is now identical.  Merge
the two files and kill the duplicated code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                         |    6 +-
 arch/arm/common/Kconfig                  |    5 +-
 arch/arm/common/Makefile                 |    3 +-
 arch/arm/common/{icst307.c => icst.c}    |   19 +++---
 arch/arm/common/icst525.c                |   99 ------------------------------
 arch/arm/include/asm/hardware/icst.h     |   24 +++++++
 arch/arm/include/asm/hardware/icst307.h  |   34 ----------
 arch/arm/include/asm/hardware/icst525.h  |   33 ----------
 arch/arm/mach-integrator/clock.c         |   10 ++--
 arch/arm/mach-integrator/cpu.c           |   20 +++---
 arch/arm/mach-integrator/impd1.c         |    2 +-
 arch/arm/mach-integrator/integrator_cp.c |    2 +-
 arch/arm/mach-realview/clock.c           |   10 ++--
 arch/arm/mach-realview/core.c            |    2 +-
 arch/arm/mach-realview/realview_eb.c     |    1 -
 arch/arm/mach-realview/realview_pb1176.c |    1 -
 arch/arm/mach-realview/realview_pb11mp.c |    1 -
 arch/arm/mach-realview/realview_pba8.c   |    1 -
 arch/arm/mach-versatile/clock.c          |   10 ++--
 arch/arm/mach-versatile/core.c           |    2 +-
 20 files changed, 67 insertions(+), 218 deletions(-)
 rename arch/arm/common/{icst307.c => icst.c} (82%)
 delete mode 100644 arch/arm/common/icst525.c
 delete mode 100644 arch/arm/include/asm/hardware/icst307.h
 delete mode 100644 arch/arm/include/asm/hardware/icst525.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 95ea101..b9ac2c9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -222,7 +222,7 @@ config ARCH_INTEGRATOR
 	select ARCH_HAS_CPUFREQ
 	select HAVE_CLK
 	select COMMON_CLKDEV
-	select ICST525
+	select ICST
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	help
@@ -233,7 +233,7 @@ config ARCH_REALVIEW
 	select ARM_AMBA
 	select HAVE_CLK
 	select COMMON_CLKDEV
-	select ICST307
+	select ICST
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
@@ -246,7 +246,7 @@ config ARCH_VERSATILE
 	select ARM_VIC
 	select HAVE_CLK
 	select COMMON_CLKDEV
-	select ICST307
+	select ICST
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index 4efbb9d..323d2d2 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -12,10 +12,7 @@ config ARM_VIC_NR
 	  The maximum number of VICs available in the system, for
 	  power management.
 
-config ICST525
-	bool
-
-config ICST307
+config ICST
 	bool
 
 config SA1111
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 76be7ff..5e8ad0d 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -4,8 +4,7 @@
 
 obj-$(CONFIG_ARM_GIC)		+= gic.o
 obj-$(CONFIG_ARM_VIC)		+= vic.o
-obj-$(CONFIG_ICST525)		+= icst525.o
-obj-$(CONFIG_ICST307)		+= icst307.o
+obj-$(CONFIG_ICST)		+= icst.o
 obj-$(CONFIG_SA1111)		+= sa1111.o
 obj-$(CONFIG_PCI_HOST_VIA82C505) += via82c505.o
 obj-$(CONFIG_DMABOUNCE)		+= dmabounce.o
diff --git a/arch/arm/common/icst307.c b/arch/arm/common/icst.c
similarity index 82%
rename from arch/arm/common/icst307.c
rename to arch/arm/common/icst.c
index 8332c07..9a7f09c 100644
--- a/arch/arm/common/icst307.c
+++ b/arch/arm/common/icst.c
@@ -17,31 +17,33 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 
-#include <asm/hardware/icst307.h>
+#include <asm/hardware/icst.h>
 
 /*
  * Divisors for each OD setting.
  */
 const unsigned char icst307_s2div[8] = { 10, 2, 8, 4, 5, 7, 3, 6 };
-
+const unsigned char icst525_s2div[8] = { 10, 2, 8, 4, 5, 7, 9, 6 };
 EXPORT_SYMBOL(icst307_s2div);
+EXPORT_SYMBOL(icst525_s2div);
 
-unsigned long icst307_hz(const struct icst_params *p, struct icst_vco vco)
+unsigned long icst_hz(const struct icst_params *p, struct icst_vco vco)
 {
 	return p->ref * 2 * (vco.v + 8) / ((vco.r + 2) * p->s2div[vco.s]);
 }
 
-EXPORT_SYMBOL(icst307_hz);
+EXPORT_SYMBOL(icst_hz);
 
 /*
  * Ascending divisor S values.
  */
 const unsigned char icst307_idx2s[8] = { 1, 6, 3, 4, 7, 5, 2, 0 };
-
+const unsigned char icst525_idx2s[8] = { 1, 3, 4, 7, 5, 2, 6, 0 };
 EXPORT_SYMBOL(icst307_idx2s);
+EXPORT_SYMBOL(icst525_idx2s);
 
 struct icst_vco
-icst307_hz_to_vco(const struct icst_params *p, unsigned long freq)
+icst_hz_to_vco(const struct icst_params *p, unsigned long freq)
 {
 	struct icst_vco vco = { .s = 1, .v = p->vd_max, .r = p->rd_max };
 	unsigned long f;
@@ -54,9 +56,6 @@ icst307_hz_to_vco(const struct icst_params *p, unsigned long freq)
 	do {
 		f = freq * p->s2div[p->idx2s[i]];
 
-		/*
-		 * f must be between 6MHz and 200MHz (3.3 or 5V)
-		 */
 		if (f > p->vco_min && f <= p->vco_max)
 			break;
 	} while (i < 8);
@@ -98,4 +97,4 @@ icst307_hz_to_vco(const struct icst_params *p, unsigned long freq)
 	return vco;
 }
 
-EXPORT_SYMBOL(icst307_hz_to_vco);
+EXPORT_SYMBOL(icst_hz_to_vco);
diff --git a/arch/arm/common/icst525.c b/arch/arm/common/icst525.c
deleted file mode 100644
index 4180255..0000000
--- a/arch/arm/common/icst525.c
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- *  linux/arch/arm/common/icst525.c
- *
- *  Copyright (C) 2003 Deep Blue Solutions, Ltd, All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  Support functions for calculating clocks/divisors for the ICST525
- *  clock generators.  See http://www.icst.com/ for more information
- *  on these devices.
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-
-#include <asm/hardware/icst525.h>
-
-/*
- * Divisors for each OD setting.
- */
-const unsigned char icst525_s2div[8] = { 10, 2, 8, 4, 5, 7, 9, 6 };
-
-EXPORT_SYMBOL(icst525_s2div);
-
-unsigned long icst525_hz(const struct icst_params *p, struct icst_vco vco)
-{
-	return p->ref * 2 * (vco.v + 8) / ((vco.r + 2) * p->s2div[vco.s]);
-}
-
-EXPORT_SYMBOL(icst525_hz);
-
-/*
- * Ascending divisor S values.
- */
-const unsigned char icst525_idx2s[8] = { 1, 3, 4, 7, 5, 2, 6, 0 };
-
-EXPORT_SYMBOL(icst525_idx2s);
-
-struct icst_vco
-icst525_hz_to_vco(const struct icst_params *p, unsigned long freq)
-{
-	struct icst_vco vco = { .s = 1, .v = p->vd_max, .r = p->rd_max };
-	unsigned long f;
-	unsigned int i = 0, rd, best = (unsigned int)-1;
-
-	/*
-	 * First, find the PLL output divisor such
-	 * that the PLL output is within spec.
-	 */
-	do {
-		f = freq * p->s2div[p->idx2s[i]];
-
-		/*
-		 * f must be between 10MHz and
-		 *  320MHz (5V) or 200MHz (3V)
-		 */
-		if (f > p->vco_min && f <= p->vco_max)
-			break;
-	} while (i < 8);
-
-	if (i >= 8)
-		return vco;
-
-	vco.s = p->idx2s[i];
-
-	/*
-	 * Now find the closest divisor combination
-	 * which gives a PLL output of 'f'.
-	 */
-	for (rd = p->rd_min; rd <= p->rd_max; rd++) {
-		unsigned long fref_div, f_pll;
-		unsigned int vd;
-		int f_diff;
-
-		fref_div = (2 * p->ref) / rd;
-
-		vd = (f + fref_div / 2) / fref_div;
-		if (vd < p->vd_min || vd > p->vd_max)
-			continue;
-
-		f_pll = fref_div * vd;
-		f_diff = f_pll - f;
-		if (f_diff < 0)
-			f_diff = -f_diff;
-
-		if ((unsigned)f_diff < best) {
-			vco.v = vd - 8;
-			vco.r = rd - 2;
-			if (f_diff == 0)
-				break;
-			best = f_diff;
-		}
-	}
-
-	return vco;
-}
-
-EXPORT_SYMBOL(icst525_hz_to_vco);
diff --git a/arch/arm/include/asm/hardware/icst.h b/arch/arm/include/asm/hardware/icst.h
index 4d40368..10382a3 100644
--- a/arch/arm/include/asm/hardware/icst.h
+++ b/arch/arm/include/asm/hardware/icst.h
@@ -32,4 +32,28 @@ struct icst_vco {
 	unsigned char	s;
 };
 
+unsigned long icst_hz(const struct icst_params *p, struct icst_vco vco);
+struct icst_vco icst_hz_to_vco(const struct icst_params *p, unsigned long freq);
+
+/*
+ * ICST307 VCO frequency must be between 6MHz and 200MHz (3.3 or 5V).
+ * This frequency is pre-output divider.
+ */
+#define ICST307_VCO_MIN	6000000
+#define ICST307_VCO_MAX	200000000
+
+extern const unsigned char icst307_s2div[];
+extern const unsigned char icst307_idx2s[];
+
+/*
+ * ICST525 VCO frequency must be between 10MHz and 200MHz (3V) or 320MHz (5V).
+ * This frequency is pre-output divider.
+ */
+#define ICST525_VCO_MIN		10000000
+#define ICST525_VCO_MAX_3V	200000000
+#define ICST525_VCO_MAX_5V	320000000
+
+extern const unsigned char icst525_s2div[];
+extern const unsigned char icst525_idx2s[];
+
 #endif
diff --git a/arch/arm/include/asm/hardware/icst307.h b/arch/arm/include/asm/hardware/icst307.h
deleted file mode 100644
index d76fc6e..0000000
--- a/arch/arm/include/asm/hardware/icst307.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- *  arch/arm/include/asm/hardware/icst307.h
- *
- *  Copyright (C) 2003 Deep Blue Solutions, Ltd, All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  Support functions for calculating clocks/divisors for the ICS307
- *  clock generators.  See http://www.icst.com/ for more information
- *  on these devices.
- *
- *  This file is similar to the icst525.h file
- */
-#ifndef ASMARM_HARDWARE_ICST307_H
-#define ASMARM_HARDWARE_ICST307_H
-
-#include <asm/hardware/icst.h>
-
-unsigned long icst307_hz(const struct icst_params *p, struct icst_vco vco);
-struct icst_vco icst307_hz_to_vco(const struct icst_params *p, unsigned long freq);
-
-/*
- * ICST307 VCO frequency must be between 6MHz and 200MHz (3.3 or 5V).
- * This frequency is pre-output divider.
- */
-#define ICST307_VCO_MIN	6000000
-#define ICST307_VCO_MAX	200000000
-
-extern const unsigned char icst307_s2div[];
-extern const unsigned char icst307_idx2s[];
-
-#endif
diff --git a/arch/arm/include/asm/hardware/icst525.h b/arch/arm/include/asm/hardware/icst525.h
deleted file mode 100644
index 2f9b953..0000000
--- a/arch/arm/include/asm/hardware/icst525.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  arch/arm/include/asm/hardware/icst525.h
- *
- *  Copyright (C) 2003 Deep Blue Solutions, Ltd, All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- *  Support functions for calculating clocks/divisors for the ICST525
- *  clock generators.  See http://www.icst.com/ for more information
- *  on these devices.
- */
-#ifndef ASMARM_HARDWARE_ICST525_H
-#define ASMARM_HARDWARE_ICST525_H
-
-#include <asm/hardware/icst.h>
-
-unsigned long icst525_hz(const struct icst_params *p, struct icst_vco vco);
-struct icst_vco icst525_hz_to_vco(const struct icst_params *p, unsigned long freq);
-
-/*
- * ICST525 VCO frequency must be between 10MHz and 200MHz (3V) or 320MHz (5V).
- * This frequency is pre-output divider.
- */
-#define ICST525_VCO_MIN		10000000
-#define ICST525_VCO_MAX_3V	200000000
-#define ICST525_VCO_MAX_5V	320000000
-
-extern const unsigned char icst525_s2div[];
-extern const unsigned char icst525_idx2s[];
-
-#endif
diff --git a/arch/arm/mach-integrator/clock.c b/arch/arm/mach-integrator/clock.c
index a4f80d3..52fc294 100644
--- a/arch/arm/mach-integrator/clock.c
+++ b/arch/arm/mach-integrator/clock.c
@@ -14,7 +14,7 @@
 #include <linux/clk.h>
 #include <linux/mutex.h>
 
-#include <asm/hardware/icst525.h>
+#include <asm/hardware/icst.h>
 #include <asm/clkdev.h>
 #include <mach/clkdev.h>
 
@@ -38,8 +38,8 @@ EXPORT_SYMBOL(clk_get_rate);
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	struct icst_vco vco;
-	vco = icst525_hz_to_vco(clk->params, rate);
-	return icst525_hz(clk->params, vco);
+	vco = icst_hz_to_vco(clk->params, rate);
+	return icst_hz(clk->params, vco);
 }
 EXPORT_SYMBOL(clk_round_rate);
 
@@ -50,8 +50,8 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	if (clk->setvco) {
 		struct icst_vco vco;
 
-		vco = icst525_hz_to_vco(clk->params, rate);
-		clk->rate = icst525_hz(clk->params, vco);
+		vco = icst_hz_to_vco(clk->params, rate);
+		clk->rate = icst_hz(clk->params, vco);
 		clk->setvco(clk, vco);
 		ret = 0;
 	}
diff --git a/arch/arm/mach-integrator/cpu.c b/arch/arm/mach-integrator/cpu.c
index 9481c54..1cb222d 100644
--- a/arch/arm/mach-integrator/cpu.c
+++ b/arch/arm/mach-integrator/cpu.c
@@ -22,7 +22,7 @@
 #include <mach/hardware.h>
 #include <mach/platform.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/icst525.h>
+#include <asm/hardware/icst.h>
 
 static struct cpufreq_driver integrator_driver;
 
@@ -66,11 +66,11 @@ static int integrator_verify_policy(struct cpufreq_policy *policy)
 				     policy->cpuinfo.min_freq, 
 				     policy->cpuinfo.max_freq);
 
-	vco = icst525_hz_to_vco(&cclk_params, policy->max * 1000);
-	policy->max = icst525_hz(&cclk_params, vco) / 1000;
+	vco = icst_hz_to_vco(&cclk_params, policy->max * 1000);
+	policy->max = icst_hz(&cclk_params, vco) / 1000;
 
-	vco = icst525_hz_to_vco(&cclk_params, policy->min * 1000);
-	policy->min = icst525_hz(&cclk_params, vco) / 1000;
+	vco = icst_hz_to_vco(&cclk_params, policy->min * 1000);
+	policy->min = icst_hz(&cclk_params, vco) / 1000;
 
 	cpufreq_verify_within_limits(policy, 
 				     policy->cpuinfo.min_freq, 
@@ -112,17 +112,17 @@ static int integrator_set_target(struct cpufreq_policy *policy,
 	}
 	vco.v = cm_osc & 255;
 	vco.r = 22;
-	freqs.old = icst525_hz(&cclk_params, vco) / 1000;
+	freqs.old = icst_hz(&cclk_params, vco) / 1000;
 
-	/* icst525_hz_to_vco rounds down -- so we need the next
+	/* icst_hz_to_vco rounds down -- so we need the next
 	 * larger freq in case of CPUFREQ_RELATION_L.
 	 */
 	if (relation == CPUFREQ_RELATION_L)
 		target_freq += 999;
 	if (target_freq > policy->max)
 		target_freq = policy->max;
-	vco = icst525_hz_to_vco(&cclk_params, target_freq * 1000);
-	freqs.new = icst525_hz(&cclk_params, vco) / 1000;
+	vco = icst_hz_to_vco(&cclk_params, target_freq * 1000);
+	freqs.new = icst_hz(&cclk_params, vco) / 1000;
 
 	freqs.cpu = policy->cpu;
 
@@ -180,7 +180,7 @@ static unsigned int integrator_get(unsigned int cpu)
 	vco.v = cm_osc & 255;
 	vco.r = 22;
 
-	current_freq = icst525_hz(&cclk_params, vco) / 1000; /* current freq */
+	current_freq = icst_hz(&cclk_params, vco) / 1000; /* current freq */
 
 	set_cpus_allowed(current, cpus_allowed);
 
diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index e24cfc3..3e21102 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -24,7 +24,7 @@
 
 #include <asm/clkdev.h>
 #include <mach/clkdev.h>
-#include <asm/hardware/icst525.h>
+#include <asm/hardware/icst.h>
 #include <mach/lm.h>
 #include <mach/impd1.h>
 #include <asm/sizes.h>
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 9997d1f..a9ab8fd 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -29,7 +29,7 @@
 #include <asm/irq.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/icst525.h>
+#include <asm/hardware/icst.h>
 
 #include <mach/cm.h>
 #include <mach/lm.h>
diff --git a/arch/arm/mach-realview/clock.c b/arch/arm/mach-realview/clock.c
index 2ba0667..18c5459 100644
--- a/arch/arm/mach-realview/clock.c
+++ b/arch/arm/mach-realview/clock.c
@@ -18,7 +18,7 @@
 #include <linux/clk.h>
 #include <linux/mutex.h>
 
-#include <asm/hardware/icst307.h>
+#include <asm/hardware/icst.h>
 
 #include "clock.h"
 
@@ -42,8 +42,8 @@ EXPORT_SYMBOL(clk_get_rate);
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	struct icst_vco vco;
-	vco = icst307_hz_to_vco(clk->params, rate);
-	return icst307_hz(clk->params, vco);
+	vco = icst_hz_to_vco(clk->params, rate);
+	return icst_hz(clk->params, vco);
 }
 EXPORT_SYMBOL(clk_round_rate);
 
@@ -54,8 +54,8 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	if (clk->setvco) {
 		struct icst_vco vco;
 
-		vco = icst307_hz_to_vco(clk->params, rate);
-		clk->rate = icst307_hz(clk->params, vco);
+		vco = icst_hz_to_vco(clk->params, rate);
+		clk->rate = icst_hz(clk->params, vco);
 		clk->setvco(clk, vco);
 		ret = 0;
 	}
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 26d44ca..a8c215a 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -39,7 +39,7 @@
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/hardware/arm_timer.h>
-#include <asm/hardware/icst307.h>
+#include <asm/hardware/icst.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 7d857d3..39d953c 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -32,7 +32,6 @@
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/hardware/gic.h>
-#include <asm/hardware/icst307.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/localtimer.h>
 
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index 44392e5..a93aac5 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -32,7 +32,6 @@
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/hardware/gic.h>
-#include <asm/hardware/icst307.h>
 #include <asm/hardware/cache-l2x0.h>
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index 3e02731..c7c656e 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -32,7 +32,6 @@
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/hardware/gic.h>
-#include <asm/hardware/icst307.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/localtimer.h>
 
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index fe4e25c..3e3aaa3 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -31,7 +31,6 @@
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/hardware/gic.h>
-#include <asm/hardware/icst307.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-versatile/clock.c b/arch/arm/mach-versatile/clock.c
index 82753be..adc67d7 100644
--- a/arch/arm/mach-versatile/clock.c
+++ b/arch/arm/mach-versatile/clock.c
@@ -19,7 +19,7 @@
 #include <linux/mutex.h>
 
 #include <asm/clkdev.h>
-#include <asm/hardware/icst307.h>
+#include <asm/hardware/icst.h>
 
 #include "clock.h"
 
@@ -43,8 +43,8 @@ EXPORT_SYMBOL(clk_get_rate);
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
 	struct icst_vco vco;
-	vco = icst307_hz_to_vco(clk->params, rate);
-	return icst307_hz(clk->params, vco);
+	vco = icst_hz_to_vco(clk->params, rate);
+	return icst_hz(clk->params, vco);
 }
 EXPORT_SYMBOL(clk_round_rate);
 
@@ -55,8 +55,8 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	if (clk->setvco) {
 		struct icst_vco vco;
 
-		vco = icst307_hz_to_vco(clk->params, rate);
-		clk->rate = icst307_hz(clk->params, vco);
+		vco = icst_hz_to_vco(clk->params, rate);
+		clk->rate = icst_hz(clk->params, vco);
 		clk->setvco(clk, vco);
 		ret = 0;
 	}
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 51d7aeb..3c67691 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -38,7 +38,7 @@
 #include <asm/irq.h>
 #include <asm/leds.h>
 #include <asm/hardware/arm_timer.h>
-#include <asm/hardware/icst307.h>
+#include <asm/hardware/icst.h>
 #include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 
