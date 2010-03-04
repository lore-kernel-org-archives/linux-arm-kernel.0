From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: ICST: merge common ICST VCO structures
References: <git-1267729916-c5a2fd4062e2ee2088f38ac4e60a5669c1c8ac56@rmk-PC>
Message-ID: <git-1267729916-d7b7baa36d825d0372850f49532dd8991b625e57@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The structures for the ICST307 and ICST525 VCO devices are
identical, so merge them together.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/icst307.c                      |   14 +++++-----
 arch/arm/common/icst525.c                      |   14 +++++-----
 arch/arm/include/asm/hardware/icst.h           |   32 ++++++++++++++++++++++++
 arch/arm/include/asm/hardware/icst307.h        |   21 +++------------
 arch/arm/include/asm/hardware/icst525.h        |   21 +++------------
 arch/arm/mach-integrator/clock.c               |    5 ++-
 arch/arm/mach-integrator/cpu.c                 |   10 +++---
 arch/arm/mach-integrator/impd1.c               |    4 +-
 arch/arm/mach-integrator/include/mach/clkdev.h |    6 ++--
 arch/arm/mach-integrator/integrator_cp.c       |    4 +-
 arch/arm/mach-realview/clock.c                 |    4 +-
 arch/arm/mach-realview/clock.h                 |    7 +++--
 arch/arm/mach-realview/core.c                  |    4 +-
 arch/arm/mach-versatile/clock.c                |    4 +-
 arch/arm/mach-versatile/clock.h                |    7 +++--
 arch/arm/mach-versatile/core.c                 |    4 +-
 16 files changed, 85 insertions(+), 76 deletions(-)
 create mode 100644 arch/arm/include/asm/hardware/icst.h

diff --git a/arch/arm/common/icst307.c b/arch/arm/common/icst307.c
index 6d094c1..2eebd96 100644
--- a/arch/arm/common/icst307.c
+++ b/arch/arm/common/icst307.c
@@ -24,7 +24,7 @@
  */
 static unsigned char s2div[8] = { 10, 2, 8, 4, 5, 7, 3, 6 };
 
-unsigned long icst307_khz(const struct icst307_params *p, struct icst307_vco vco)
+unsigned long icst307_khz(const struct icst_params *p, struct icst_vco vco)
 {
 	return p->ref * 2 * (vco.v + 8) / ((vco.r + 2) * s2div[vco.s]);
 }
@@ -36,10 +36,10 @@ EXPORT_SYMBOL(icst307_khz);
  */
 static unsigned char idx2s[8] = { 1, 6, 3, 4, 7, 5, 2, 0 };
 
-struct icst307_vco
-icst307_khz_to_vco(const struct icst307_params *p, unsigned long freq)
+struct icst_vco
+icst307_khz_to_vco(const struct icst_params *p, unsigned long freq)
 {
-	struct icst307_vco vco = { .s = 1, .v = p->vd_max, .r = p->rd_max };
+	struct icst_vco vco = { .s = 1, .v = p->vd_max, .r = p->rd_max };
 	unsigned long f;
 	unsigned int i = 0, rd, best = (unsigned int)-1;
 
@@ -96,10 +96,10 @@ icst307_khz_to_vco(const struct icst307_params *p, unsigned long freq)
 
 EXPORT_SYMBOL(icst307_khz_to_vco);
 
-struct icst307_vco
-icst307_ps_to_vco(const struct icst307_params *p, unsigned long period)
+struct icst_vco
+icst307_ps_to_vco(const struct icst_params *p, unsigned long period)
 {
-	struct icst307_vco vco = { .s = 1, .v = p->vd_max, .r = p->rd_max };
+	struct icst_vco vco = { .s = 1, .v = p->vd_max, .r = p->rd_max };
 	unsigned long f, ps;
 	unsigned int i = 0, rd, best = (unsigned int)-1;
 
diff --git a/arch/arm/common/icst525.c b/arch/arm/common/icst525.c
index 3d377c5..fd5c2e7 100644
--- a/arch/arm/common/icst525.c
+++ b/arch/arm/common/icst525.c
@@ -21,7 +21,7 @@
  */
 static unsigned char s2div[8] = { 10, 2, 8, 4, 5, 7, 9, 6 };
 
-unsigned long icst525_khz(const struct icst525_params *p, struct icst525_vco vco)
+unsigned long icst525_khz(const struct icst_params *p, struct icst_vco vco)
 {
 	return p->ref * 2 * (vco.v + 8) / ((vco.r + 2) * s2div[vco.s]);
 }
@@ -33,10 +33,10 @@ EXPORT_SYMBOL(icst525_khz);
  */
 static unsigned char idx2s[] = { 1, 3, 4, 7, 5, 2, 6, 0 };
 
-struct icst525_vco
-icst525_khz_to_vco(const struct icst525_params *p, unsigned long freq)
+struct icst_vco
+icst525_khz_to_vco(const struct icst_params *p, unsigned long freq)
 {
-	struct icst525_vco vco = { .s = 1, .v = p->vd_max, .r = p->rd_max };
+	struct icst_vco vco = { .s = 1, .v = p->vd_max, .r = p->rd_max };
 	unsigned long f;
 	unsigned int i = 0, rd, best = (unsigned int)-1;
 
@@ -94,10 +94,10 @@ icst525_khz_to_vco(const struct icst525_params *p, unsigned long freq)
 
 EXPORT_SYMBOL(icst525_khz_to_vco);
 
-struct icst525_vco
-icst525_ps_to_vco(const struct icst525_params *p, unsigned long period)
+struct icst_vco
+icst525_ps_to_vco(const struct icst_params *p, unsigned long period)
 {
-	struct icst525_vco vco = { .s = 1, .v = p->vd_max, .r = p->rd_max };
+	struct icst_vco vco = { .s = 1, .v = p->vd_max, .r = p->rd_max };
 	unsigned long f, ps;
 	unsigned int i = 0, rd, best = (unsigned int)-1;
 
diff --git a/arch/arm/include/asm/hardware/icst.h b/arch/arm/include/asm/hardware/icst.h
new file mode 100644
index 0000000..65b1edd
--- /dev/null
+++ b/arch/arm/include/asm/hardware/icst.h
@@ -0,0 +1,32 @@
+/*
+ *  arch/arm/include/asm/hardware/icst.h
+ *
+ *  Copyright (C) 2003 Deep Blue Solutions, Ltd, All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  Support functions for calculating clocks/divisors for the ICST
+ *  clock generators.  See http://www.icst.com/ for more information
+ *  on these devices.
+ */
+#ifndef ASMARM_HARDWARE_ICST_H
+#define ASMARM_HARDWARE_ICST_H
+
+struct icst_params {
+	unsigned long	ref;
+	unsigned long	vco_max;	/* inclusive */
+	unsigned short	vd_min;		/* inclusive */
+	unsigned short	vd_max;		/* inclusive */
+	unsigned char	rd_min;		/* inclusive */
+	unsigned char	rd_max;		/* inclusive */
+};
+
+struct icst_vco {
+	unsigned short	v;
+	unsigned char	r;
+	unsigned char	s;
+};
+
+#endif
diff --git a/arch/arm/include/asm/hardware/icst307.h b/arch/arm/include/asm/hardware/icst307.h
index 554f128..85932e9 100644
--- a/arch/arm/include/asm/hardware/icst307.h
+++ b/arch/arm/include/asm/hardware/icst307.h
@@ -16,23 +16,10 @@
 #ifndef ASMARM_HARDWARE_ICST307_H
 #define ASMARM_HARDWARE_ICST307_H
 
-struct icst307_params {
-	unsigned long	ref;
-	unsigned long	vco_max;	/* inclusive */
-	unsigned short	vd_min;		/* inclusive */
-	unsigned short	vd_max;		/* inclusive */
-	unsigned char	rd_min;		/* inclusive */
-	unsigned char	rd_max;		/* inclusive */
-};
+#include <asm/hardware/icst.h>
 
-struct icst307_vco {
-	unsigned short	v;
-	unsigned char	r;
-	unsigned char	s;
-};
-
-unsigned long icst307_khz(const struct icst307_params *p, struct icst307_vco vco);
-struct icst307_vco icst307_khz_to_vco(const struct icst307_params *p, unsigned long freq);
-struct icst307_vco icst307_ps_to_vco(const struct icst307_params *p, unsigned long period);
+unsigned long icst307_khz(const struct icst_params *p, struct icst_vco vco);
+struct icst_vco icst307_khz_to_vco(const struct icst_params *p, unsigned long freq);
+struct icst_vco icst307_ps_to_vco(const struct icst_params *p, unsigned long period);
 
 #endif
diff --git a/arch/arm/include/asm/hardware/icst525.h b/arch/arm/include/asm/hardware/icst525.h
index 58f0dc4..170deb2 100644
--- a/arch/arm/include/asm/hardware/icst525.h
+++ b/arch/arm/include/asm/hardware/icst525.h
@@ -14,23 +14,10 @@
 #ifndef ASMARM_HARDWARE_ICST525_H
 #define ASMARM_HARDWARE_ICST525_H
 
-struct icst525_params {
-	unsigned long	ref;
-	unsigned long	vco_max;	/* inclusive */
-	unsigned short	vd_min;		/* inclusive */
-	unsigned short	vd_max;		/* inclusive */
-	unsigned char	rd_min;		/* inclusive */
-	unsigned char	rd_max;		/* inclusive */
-};
+#include <asm/hardware/icst.h>
 
-struct icst525_vco {
-	unsigned short	v;
-	unsigned char	r;
-	unsigned char	s;
-};
-
-unsigned long icst525_khz(const struct icst525_params *p, struct icst525_vco vco);
-struct icst525_vco icst525_khz_to_vco(const struct icst525_params *p, unsigned long freq);
-struct icst525_vco icst525_ps_to_vco(const struct icst525_params *p, unsigned long period);
+unsigned long icst525_khz(const struct icst_params *p, struct icst_vco vco);
+struct icst_vco icst525_khz_to_vco(const struct icst_params *p, unsigned long freq);
+struct icst_vco icst525_ps_to_vco(const struct icst_params *p, unsigned long period);
 
 #endif
diff --git a/arch/arm/mach-integrator/clock.c b/arch/arm/mach-integrator/clock.c
index 989ecf5..bb70b64 100644
--- a/arch/arm/mach-integrator/clock.c
+++ b/arch/arm/mach-integrator/clock.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/mutex.h>
 
+#include <asm/hardware/icst525.h>
 #include <asm/clkdev.h>
 #include <mach/clkdev.h>
 
@@ -36,7 +37,7 @@ EXPORT_SYMBOL(clk_get_rate);
 
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	struct icst525_vco vco;
+	struct icst_vco vco;
 	vco = icst525_khz_to_vco(clk->params, rate / 1000);
 	return icst525_khz(clk->params, vco) * 1000;
 }
@@ -47,7 +48,7 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	int ret = -EIO;
 
 	if (clk->setvco) {
-		struct icst525_vco vco;
+		struct icst_vco vco;
 
 		vco = icst525_khz_to_vco(clk->params, rate / 1000);
 		clk->rate = icst525_khz(clk->params, vco) * 1000;
diff --git a/arch/arm/mach-integrator/cpu.c b/arch/arm/mach-integrator/cpu.c
index 7f1b73b..c4e5deb 100644
--- a/arch/arm/mach-integrator/cpu.c
+++ b/arch/arm/mach-integrator/cpu.c
@@ -31,7 +31,7 @@ static struct cpufreq_driver integrator_driver;
 #define CM_STAT IO_ADDRESS(INTEGRATOR_HDR_STAT)
 #define CM_LOCK IO_ADDRESS(INTEGRATOR_HDR_LOCK)
 
-static const struct icst525_params lclk_params = {
+static const struct icst_params lclk_params = {
 	.ref		= 24000,
 	.vco_max	= 320000,
 	.vd_min		= 8,
@@ -40,7 +40,7 @@ static const struct icst525_params lclk_params = {
 	.rd_max		= 24,
 };
 
-static const struct icst525_params cclk_params = {
+static const struct icst_params cclk_params = {
 	.ref		= 24000,
 	.vco_max	= 320000,
 	.vd_min		= 12,
@@ -54,7 +54,7 @@ static const struct icst525_params cclk_params = {
  */
 static int integrator_verify_policy(struct cpufreq_policy *policy)
 {
-	struct icst525_vco vco;
+	struct icst_vco vco;
 
 	cpufreq_verify_within_limits(policy, 
 				     policy->cpuinfo.min_freq, 
@@ -80,7 +80,7 @@ static int integrator_set_target(struct cpufreq_policy *policy,
 {
 	cpumask_t cpus_allowed;
 	int cpu = policy->cpu;
-	struct icst525_vco vco;
+	struct icst_vco vco;
 	struct cpufreq_freqs freqs;
 	u_int cm_osc;
 
@@ -156,7 +156,7 @@ static unsigned int integrator_get(unsigned int cpu)
 	cpumask_t cpus_allowed;
 	unsigned int current_freq;
 	u_int cm_osc;
-	struct icst525_vco vco;
+	struct icst_vco vco;
 
 	cpus_allowed = current->cpus_allowed;
 
diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 0058c93..dfb961b 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -40,7 +40,7 @@ struct impd1_module {
 	struct clk_lookup *clks[3];
 };
 
-static const struct icst525_params impd1_vco_params = {
+static const struct icst_params impd1_vco_params = {
 	.ref		= 24000,	/* 24 MHz */
 	.vco_max	= 200000,	/* 200 MHz */
 	.vd_min		= 12,
@@ -49,7 +49,7 @@ static const struct icst525_params impd1_vco_params = {
 	.rd_max		= 120,
 };
 
-static void impd1_setvco(struct clk *clk, struct icst525_vco vco)
+static void impd1_setvco(struct clk *clk, struct icst_vco vco)
 {
 	struct impd1_module *impd1 = clk->data;
 	int vconr = clk - impd1->vcos;
diff --git a/arch/arm/mach-integrator/include/mach/clkdev.h b/arch/arm/mach-integrator/include/mach/clkdev.h
index 9293e41..89ea938 100644
--- a/arch/arm/mach-integrator/include/mach/clkdev.h
+++ b/arch/arm/mach-integrator/include/mach/clkdev.h
@@ -2,14 +2,14 @@
 #define __ASM_MACH_CLKDEV_H
 
 #include <linux/module.h>
-#include <asm/hardware/icst525.h>
+#include <asm/hardware/icst.h>
 
 struct clk {
 	unsigned long		rate;
 	struct module		*owner;
-	const struct icst525_params *params;
+	const struct icst_params *params;
 	void			*data;
-	void			(*setvco)(struct clk *, struct icst525_vco vco);
+	void			(*setvco)(struct clk *, struct icst_vco vco);
 };
 
 static inline int __clk_get(struct clk *clk)
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index c0161df..15bfbe2 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -268,7 +268,7 @@ static void __init intcp_init_irq(void)
 #define CM_LOCK IO_ADDRESS(INTEGRATOR_HDR_LOCK)
 #define CM_AUXOSC IO_ADDRESS(INTEGRATOR_HDR_BASE + 0x1c)
 
-static const struct icst525_params cp_auxvco_params = {
+static const struct icst_params cp_auxvco_params = {
 	.ref		= 24000,
 	.vco_max	= 320000,
 	.vd_min 	= 8,
@@ -277,7 +277,7 @@ static const struct icst525_params cp_auxvco_params = {
 	.rd_max 	= 65,
 };
 
-static void cp_auxvco_set(struct clk *clk, struct icst525_vco vco)
+static void cp_auxvco_set(struct clk *clk, struct icst_vco vco)
 {
 	u32 val;
 
diff --git a/arch/arm/mach-realview/clock.c b/arch/arm/mach-realview/clock.c
index a704311..8364657 100644
--- a/arch/arm/mach-realview/clock.c
+++ b/arch/arm/mach-realview/clock.c
@@ -41,7 +41,7 @@ EXPORT_SYMBOL(clk_get_rate);
 
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	struct icst307_vco vco;
+	struct icst_vco vco;
 	vco = icst307_khz_to_vco(clk->params, rate / 1000);
 	return icst307_khz(clk->params, vco) * 1000;
 }
@@ -52,7 +52,7 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	int ret = -EIO;
 
 	if (clk->setvco) {
-		struct icst307_vco vco;
+		struct icst_vco vco;
 
 		vco = icst307_khz_to_vco(clk->params, rate / 1000);
 		clk->rate = icst307_khz(clk->params, vco) * 1000;
diff --git a/arch/arm/mach-realview/clock.h b/arch/arm/mach-realview/clock.h
index ebbb0f0..fa64c85 100644
--- a/arch/arm/mach-realview/clock.h
+++ b/arch/arm/mach-realview/clock.h
@@ -8,12 +8,13 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <asm/hardware/icst.h>
+
 struct module;
-struct icst307_params;
 
 struct clk {
 	unsigned long		rate;
-	const struct icst307_params *params;
+	const struct icst_params *params;
 	void			*data;
-	void			(*setvco)(struct clk *, struct icst307_vco vco);
+	void			(*setvco)(struct clk *, struct icst_vco vco);
 };
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 90bd4ef..ac50474 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -273,7 +273,7 @@ struct mmci_platform_data realview_mmc1_plat_data = {
 /*
  * Clock handling
  */
-static const struct icst307_params realview_oscvco_params = {
+static const struct icst_params realview_oscvco_params = {
 	.ref		= 24000,
 	.vco_max	= 200000,
 	.vd_min		= 4 + 8,
@@ -282,7 +282,7 @@ static const struct icst307_params realview_oscvco_params = {
 	.rd_max		= 127 + 2,
 };
 
-static void realview_oscvco_set(struct clk *clk, struct icst307_vco vco)
+static void realview_oscvco_set(struct clk *clk, struct icst_vco vco)
 {
 	void __iomem *sys_lock = __io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_LOCK_OFFSET;
 	void __iomem *sys_osc;
diff --git a/arch/arm/mach-versatile/clock.c b/arch/arm/mach-versatile/clock.c
index c50a44e..530e16a 100644
--- a/arch/arm/mach-versatile/clock.c
+++ b/arch/arm/mach-versatile/clock.c
@@ -42,7 +42,7 @@ EXPORT_SYMBOL(clk_get_rate);
 
 long clk_round_rate(struct clk *clk, unsigned long rate)
 {
-	struct icst307_vco vco;
+	struct icst_vco vco;
 	vco = icst307_khz_to_vco(clk->params, rate / 1000);
 	return icst307_khz(clk->params, vco) * 1000;
 }
@@ -53,7 +53,7 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	int ret = -EIO;
 
 	if (clk->setvco) {
-		struct icst307_vco vco;
+		struct icst_vco vco;
 
 		vco = icst307_khz_to_vco(clk->params, rate / 1000);
 		clk->rate = icst307_khz(clk->params, vco) * 1000;
diff --git a/arch/arm/mach-versatile/clock.h b/arch/arm/mach-versatile/clock.h
index 03468fd..aed7e22 100644
--- a/arch/arm/mach-versatile/clock.h
+++ b/arch/arm/mach-versatile/clock.h
@@ -8,13 +8,14 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <asm/hardware/icst.h>
+
 struct module;
-struct icst307_params;
 
 struct clk {
 	unsigned long		rate;
-	const struct icst307_params *params;
+	const struct icst_params *params;
 	u32			oscoff;
 	void			*data;
-	void			(*setvco)(struct clk *, struct icst307_vco vco);
+	void			(*setvco)(struct clk *, struct icst_vco vco);
 };
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index b77bc40..ded7134 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -379,7 +379,7 @@ static struct mmci_platform_data mmc0_plat_data = {
 /*
  * Clock handling
  */
-static const struct icst307_params versatile_oscvco_params = {
+static const struct icst_params versatile_oscvco_params = {
 	.ref		= 24000,
 	.vco_max	= 200000,
 	.vd_min		= 4 + 8,
@@ -388,7 +388,7 @@ static const struct icst307_params versatile_oscvco_params = {
 	.rd_max		= 127 + 2,
 };
 
-static void versatile_oscvco_set(struct clk *clk, struct icst307_vco vco)
+static void versatile_oscvco_set(struct clk *clk, struct icst_vco vco)
 {
 	void __iomem *sys = __io_address(VERSATILE_SYS_BASE);
 	void __iomem *sys_lock = sys + VERSATILE_SYS_LOCK_OFFSET;
