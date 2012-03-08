From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 08 Mar 2012 03:51:33 -0700
Subject: [PATCH 08/15] ARM: OMAP4: hwmod data: add McASP
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Message-ID: <20120308105132.14753.91529.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Beno?t Cousson <b-cousson@ti.com>

Add the McASP hwmod and associated interconnect data.  The McASP is a
general-purpose audio serial port.

Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   91 ++++++++++++++++++++++++++++
 1 files changed, 90 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 283c5b2..3be64f5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -260,7 +260,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  efuse_ctrl_cust
  *  efuse_ctrl_std
  *  elm
- *  mcasp
  *  mpu_c0
  *  mpu_c1
  *  ocmc_ram
@@ -1669,6 +1668,58 @@ static struct omap_hwmod omap44xx_mailbox_hwmod = {
 };
 
 /*
+ * 'mcasp' class
+ * multi-channel audio serial port controller
+ */
+
+/* The IP is not compliant to type1 / type2 scheme */
+static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_mcasp = {
+	.sidle_shift	= 0,
+};
+
+static struct omap_hwmod_class_sysconfig omap44xx_mcasp_sysc = {
+	.sysc_offs	= 0x0004,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type_mcasp,
+};
+
+static struct omap_hwmod_class omap44xx_mcasp_hwmod_class = {
+	.name	= "mcasp",
+	.sysc	= &omap44xx_mcasp_sysc,
+};
+
+/* mcasp */
+static struct omap_hwmod_irq_info omap44xx_mcasp_irqs[] = {
+	{ .name = "arevt", .irq = 108 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "axevt", .irq = 109 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_mcasp_sdma_reqs[] = {
+	{ .name = "axevt", .dma_req = 7 + OMAP44XX_DMA_REQ_START },
+	{ .name = "arevt", .dma_req = 10 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
+static struct omap_hwmod omap44xx_mcasp_hwmod = {
+	.name		= "mcasp",
+	.class		= &omap44xx_mcasp_hwmod_class,
+	.clkdm_name	= "abe_clkdm",
+	.mpu_irqs	= omap44xx_mcasp_irqs,
+	.sdma_reqs	= omap44xx_mcasp_sdma_reqs,
+	.main_clk	= "mcasp_fck",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM1_ABE_MCASP_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ABE_MCASP_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/*
  * 'mcbsp' class
  * multi channel buffered serial port controller
  */
@@ -4224,6 +4275,42 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__mailbox = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_addr_space omap44xx_mcasp_addrs[] = {
+	{
+		.pa_start	= 0x40128000,
+		.pa_end		= 0x401283ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_abe -> mcasp */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcasp = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_mcasp_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_mcasp_addrs,
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_mcasp_dma_addrs[] = {
+	{
+		.pa_start	= 0x49028000,
+		.pa_end		= 0x490283ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_abe -> mcasp (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcasp_dma = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_mcasp_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_mcasp_dma_addrs,
+	.user		= OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_mcbsp1_addrs[] = {
 	{
 		.name		= "mpu",
@@ -5222,6 +5309,8 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l3_main_2__iva,
 	&omap44xx_l4_wkup__kbd,
 	&omap44xx_l4_cfg__mailbox,
+	&omap44xx_l4_abe__mcasp,
+	&omap44xx_l4_abe__mcasp_dma,
 	&omap44xx_l4_abe__mcbsp1,
 	&omap44xx_l4_abe__mcbsp1_dma,
 	&omap44xx_l4_abe__mcbsp2,
