From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 08 Mar 2012 03:51:29 -0700
Subject: [PATCH 03/15] ARM: OMAP4: hwmod data: add HDQ/1-wire
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Message-ID: <20120308105127.14753.19376.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the HDQ/1-wire hwmod and associated interconnect data.  The
HDQ/1-wire IP block is a low-speed serial interconnect.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   61 ++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7f42431..ae87401 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -264,7 +264,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  emif2
  *  gpmc
  *  gpu
- *  hdq1w
  *  mcasp
  *  mpu_c0
  *  mpu_c1
@@ -1057,6 +1056,47 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 };
 
 /*
+ * 'hdq1w' class
+ * hdq / 1-wire serial interface controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_hdq1w_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0014,
+	.syss_offs	= 0x0018,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SOFTRESET |
+			   SYSS_HAS_RESET_STATUS),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_hdq1w_hwmod_class = {
+	.name	= "hdq1w",
+	.sysc	= &omap44xx_hdq1w_sysc,
+};
+
+/* hdq1w */
+static struct omap_hwmod_irq_info omap44xx_hdq1w_irqs[] = {
+	{ .irq = 58 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod omap44xx_hdq1w_hwmod = {
+	.name		= "hdq1w",
+	.class		= &omap44xx_hdq1w_hwmod_class,
+	.clkdm_name	= "l4_per_clkdm",
+	.flags		= HWMOD_INIT_NO_RESET, /* XXX temporary */
+	.mpu_irqs	= omap44xx_hdq1w_irqs,
+	.main_clk	= "hdq1w_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L4PER_HDQ1W_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_HDQ1W_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'hsi' class
  * mipi high-speed synchronous serial interface (multichannel and full-duplex
  * serial if)
@@ -3672,6 +3712,24 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio6 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_addr_space omap44xx_hdq1w_addrs[] = {
+	{
+		.pa_start	= 0x480b2000,
+		.pa_end		= 0x480b201f,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_per -> hdq1w */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__hdq1w = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_hdq1w_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_hdq1w_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_hsi_addrs[] = {
 	{
 		.pa_start	= 0x4a058000,
@@ -4770,6 +4828,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__gpio4,
 	&omap44xx_l4_per__gpio5,
 	&omap44xx_l4_per__gpio6,
+	&omap44xx_l4_per__hdq1w,
 	&omap44xx_l4_cfg__hsi,
 	&omap44xx_l4_per__i2c1,
 	&omap44xx_l4_per__i2c2,
