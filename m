From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 08 Mar 2012 03:51:29 -0700
Subject: [PATCH 04/15] ARM: OMAP4: hwmod data: add GPMC
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Message-ID: <20120308105129.14753.577.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Beno?t Cousson <b-cousson@ti.com>

Add the GPMC hwmod and associated interconnect data.   The GPMC is a
programmable parallel-bus memory controller.

Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   67 ++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index ae87401..6a7e26e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -262,7 +262,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  elm
  *  emif1
  *  emif2
- *  gpmc
  *  gpu
  *  mcasp
  *  mpu_c0
@@ -1056,6 +1055,53 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 };
 
 /*
+ * 'gpmc' class
+ * general purpose memory controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_gpmc_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_gpmc_hwmod_class = {
+	.name	= "gpmc",
+	.sysc	= &omap44xx_gpmc_sysc,
+};
+
+/* gpmc */
+static struct omap_hwmod_irq_info omap44xx_gpmc_irqs[] = {
+	{ .irq = 20 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_gpmc_sdma_reqs[] = {
+	{ .dma_req = 3 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
+static struct omap_hwmod omap44xx_gpmc_hwmod = {
+	.name		= "gpmc",
+	.class		= &omap44xx_gpmc_hwmod_class,
+	.clkdm_name	= "l3_2_clkdm",
+	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.mpu_irqs	= omap44xx_gpmc_irqs,
+	.sdma_reqs	= omap44xx_gpmc_sdma_reqs,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L3_2_GPMC_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L3_2_GPMC_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+};
+
+/*
  * 'hdq1w' class
  * hdq / 1-wire serial interface controller
  */
@@ -3712,6 +3758,24 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio6 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_addr_space omap44xx_gpmc_addrs[] = {
+	{
+		.pa_start	= 0x50000000,
+		.pa_end		= 0x500003ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l3_main_2 -> gpmc */
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__gpmc = {
+	.master		= &omap44xx_l3_main_2_hwmod,
+	.slave		= &omap44xx_gpmc_hwmod,
+	.clk		= "l3_div_ck",
+	.addr		= omap44xx_gpmc_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_hdq1w_addrs[] = {
 	{
 		.pa_start	= 0x480b2000,
@@ -4828,6 +4892,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__gpio4,
 	&omap44xx_l4_per__gpio5,
 	&omap44xx_l4_per__gpio6,
+	&omap44xx_l3_main_2__gpmc,
 	&omap44xx_l4_per__hdq1w,
 	&omap44xx_l4_cfg__hsi,
 	&omap44xx_l4_per__i2c1,
