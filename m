From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Sep 2012 03:52:36 +0000 (UTC)
Subject: [PATCH 1/5] ARM: OMAP2/3: hwmod: add RNG integration data
In-Reply-To: <alpine.DEB.2.00.1209190110550.13435@utopia.booyaka.com>
References: <20120827232922.15045.56522.stgit@dusk.lan>
 <20120827233606.15045.59388.stgit@dusk.lan>
 <alpine.DEB.2.00.1209190110550.13435@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1209190349070.17283@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Sep 2012, Paul Walmsley wrote:

> On Mon, 27 Aug 2012, Paul Walmsley wrote:
> 
> > Add integration data for the hardware random number generator IP block
> > on some OMAP SoCs.  This appears to be present on OMAP2xxx and OMAP3xxx
> > SoCs, although it is not so easy to tell.  It may also be present on
> > other OMAP2+ SoCs.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> Found out what was causing the "omap_hwmod: rng: cannot be enabled for 
> reset (3)" messages; the CM code didn't recognize the CM_IDLEST4 register 
> as a valid idle status register, and returned an error.  Here's an updated 
> version of the patch that fixes the problem.

... and fixing that and the RNG interface clock ultimately causes 
imprecise external aborts whenever the SYSSTATUS register is read during 
initial OCP softreset.  Tried a few different approaches to fixing this 
without any luck; it wouldn't surprise me if the RNG needed a custom reset 
function to enable its clocks internally first.  For the time being, I've 
just marked this HWMOD_INIT_NO_RESET in the data, with a big comment. 
Updated patch below.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Tue, 18 Sep 2012 17:38:26 -0600
Subject: [PATCH] ARM: OMAP2xxx: hwmod/CM: add RNG integration data

Add integration data for the hardware random number generator IP block
on some OMAP SoCs.  This appears to be present on at least OMAP2xxx
and OMAP3xxx SoCs, although it is not so easy to tell.  It may also be
present on other OMAP2+ SoCs.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm2xxx_3xxx.c                  |    2 +-
 arch/arm/mach-omap2/cm2xxx_3xxx.h                  |    1 +
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    1 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    1 +
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |   17 ++++++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   44 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    5 ++-
 7 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
index 389f9f8..f01aa44 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -36,7 +36,7 @@
 #define OMAP2XXX_APLL_AUTOIDLE_LOW_POWER_STOP		0x3
 
 static const u8 cm_idlest_offs[] = {
-	CM_IDLEST1, CM_IDLEST2, OMAP2430_CM_IDLEST3
+	CM_IDLEST1, CM_IDLEST2, OMAP2430_CM_IDLEST3, OMAP24XX_CM_IDLEST4
 };
 
 u32 omap2_cm_read_mod_reg(s16 module, u16 idx)
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm2xxx_3xxx.h
index 088bbad..57b2f3c 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.h
@@ -71,6 +71,7 @@
 #define OMAP24XX_CM_FCLKEN2				0x0004
 #define OMAP24XX_CM_ICLKEN4				0x001c
 #define OMAP24XX_CM_AUTOIDLE4				0x003c
+#define OMAP24XX_CM_IDLEST4				0x002c
 
 #define OMAP2430_CM_IDLEST3				0x0028
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 50cfab6..5a53287 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -587,6 +587,7 @@ static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs[] __initdata = {
 	&omap2420_l4_core__mcbsp1,
 	&omap2420_l4_core__mcbsp2,
 	&omap2420_l4_core__msdi1,
+	&omap2xxx_l4_core__rng,
 	&omap2420_l4_core__hdq1w,
 	&omap2420_l4_wkup__counter_32k,
 	NULL,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 58b5bc1..256d8f6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -947,6 +947,7 @@ static struct omap_hwmod_ocp_if *omap2430_hwmod_ocp_ifs[] __initdata = {
 	&omap2430_l4_core__mcbsp4,
 	&omap2430_l4_core__mcbsp5,
 	&omap2430_l4_core__hdq1w,
+	&omap2xxx_l4_core__rng,
 	&omap2430_l4_wkup__counter_32k,
 	NULL,
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
index 5178e40..c83d6c5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
@@ -129,6 +129,15 @@ struct omap_hwmod_addr_space omap2xxx_mcbsp2_addrs[] = {
 	{ }
 };
 
+static struct omap_hwmod_addr_space omap2_rng_addr_space[] = {
+	{
+		.pa_start	= 0x480a0000,
+		.pa_end		= 0x480a004f,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
 /*
  * Common interconnect data
  */
@@ -372,3 +381,11 @@ struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_venc = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_core -> rng */
+struct omap_hwmod_ocp_if omap2xxx_l4_core__rng = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2xxx_rng_hwmod,
+	.clk		= "rng_ick",
+	.addr		= omap2_rng_addr_space,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index afad69c..546cf57 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -745,3 +745,47 @@ struct omap_hwmod omap2xxx_counter_32k_hwmod = {
 	},
 	.class		= &omap2xxx_counter_hwmod_class,
 };
+
+/* RNG */
+
+static struct omap_hwmod_class_sysconfig omap2_rng_sysc = {
+	.rev_offs	= 0x3c,
+	.sysc_offs	= 0x40,
+	.syss_offs	= 0x44,
+	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSC_HAS_AUTOIDLE |
+			   SYSS_HAS_RESET_STATUS),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2_rng_hwmod_class = {
+	.name		= "rng",
+	.sysc		= &omap2_rng_sysc,
+};
+
+static struct omap_hwmod_irq_info omap2_rng_mpu_irqs[] = {
+	{ .irq = 52 },
+	{ .irq = -1 }
+};
+
+struct omap_hwmod omap2xxx_rng_hwmod = {
+	.name		= "rng",
+	.mpu_irqs	= omap2_rng_mpu_irqs,
+	.main_clk	= "l4_ck",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 4,
+			.module_bit = OMAP24XX_EN_RNG_SHIFT,
+			.idlest_reg_id = 4,
+			.idlest_idle_bit = OMAP24XX_ST_RNG_SHIFT,
+		},
+	},
+	/*
+	 * XXX The first read from the SYSSTATUS register of the RNG
+	 * after the SYSCONFIG SOFTRESET bit is set triggers an
+	 * imprecise external abort.  It's unclear why this happens.
+	 * Until this is analyzed, skip the IP block reset.
+	 */
+	.flags		= HWMOD_INIT_NO_RESET,
+	.class		= &omap2_rng_hwmod_class,
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_common_data.h b/arch/arm/mach-omap2/omap_hwmod_common_data.h
index e7e8eea..4363610 100644
--- a/arch/arm/mach-omap2/omap_hwmod_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_common_data.h
@@ -2,9 +2,8 @@
  * omap_hwmod_common_data.h - OMAP hwmod common macros and declarations
  *
  * Copyright (C) 2010-2011 Nokia Corporation
+ * Copyright (C) 2010-2012 Texas Instruments, Inc.
  * Paul Walmsley
- *
- * Copyright (C) 2010-2011 Texas Instruments, Inc.
  * Beno?t Cousson
  *
  * This program is free software; you can redistribute it and/or modify
@@ -76,6 +75,7 @@ extern struct omap_hwmod omap2xxx_gpio4_hwmod;
 extern struct omap_hwmod omap2xxx_mcspi1_hwmod;
 extern struct omap_hwmod omap2xxx_mcspi2_hwmod;
 extern struct omap_hwmod omap2xxx_counter_32k_hwmod;
+extern struct omap_hwmod omap2xxx_rng_hwmod;
 
 /* Common interface data across OMAP2xxx */
 extern struct omap_hwmod_ocp_if omap2xxx_l3_main__l4_core;
@@ -102,6 +102,7 @@ extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_dispc;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_rfbi;
 extern struct omap_hwmod_ocp_if omap2xxx_l4_core__dss_venc;
+extern struct omap_hwmod_ocp_if omap2xxx_l4_core__rng;
 
 /* Common IP block data */
 extern struct omap_hwmod_dma_info omap2_uart1_sdma_reqs[];
-- 
1.7.10.4
