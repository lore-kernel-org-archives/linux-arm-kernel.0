From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 08 Mar 2012 03:51:32 -0700
Subject: [PATCH 07/15] ARM: OMAP4: hwmod data: add the Slimbus IP blocks
In-Reply-To: <20120308104918.14753.69281.stgit@dusk>
References: <20120308104918.14753.69281.stgit@dusk>
Message-ID: <20120308105131.14753.60810.stgit@dusk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Beno?t Cousson <b-cousson@ti.com>

Add the Slimbus hwmods and associated interconnect data.  The Slimbus
IP blocks implement a two-wire serial interface.

Signed-off-by: Beno?t Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  163 ++++++++++++++++++++++++++++
 1 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index adacc09..283c5b2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -270,8 +270,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  prm
  *  scrm
  *  sl2if
- *  slimbus1
- *  slimbus2
  *  usb_host_fs
  *  usb_host_hs
  *  usb_phy_cm
@@ -2219,6 +2217,110 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 };
 
 /*
+ * 'slimbus' class
+ * bidirectional, multi-drop, multi-channel two-line serial interface between
+ * the device and external components
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_slimbus_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_RESET_STATUS | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap44xx_slimbus_hwmod_class = {
+	.name	= "slimbus",
+	.sysc	= &omap44xx_slimbus_sysc,
+};
+
+/* slimbus1 */
+static struct omap_hwmod_irq_info omap44xx_slimbus1_irqs[] = {
+	{ .irq = 97 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_slimbus1_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 84 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx1", .dma_req = 85 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx2", .dma_req = 86 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx3", .dma_req = 87 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx0", .dma_req = 88 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx1", .dma_req = 89 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx2", .dma_req = 90 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx3", .dma_req = 91 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
+static struct omap_hwmod_opt_clk slimbus1_opt_clks[] = {
+	{ .role = "fclk_1", .clk = "slimbus1_fclk_1" },
+	{ .role = "fclk_0", .clk = "slimbus1_fclk_0" },
+	{ .role = "fclk_2", .clk = "slimbus1_fclk_2" },
+	{ .role = "slimbus_clk", .clk = "slimbus1_slimbus_clk" },
+};
+
+static struct omap_hwmod omap44xx_slimbus1_hwmod = {
+	.name		= "slimbus1",
+	.class		= &omap44xx_slimbus_hwmod_class,
+	.clkdm_name	= "abe_clkdm",
+	.mpu_irqs	= omap44xx_slimbus1_irqs,
+	.sdma_reqs	= omap44xx_slimbus1_sdma_reqs,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM1_ABE_SLIMBUS_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_ABE_SLIMBUS_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= slimbus1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(slimbus1_opt_clks),
+};
+
+/* slimbus2 */
+static struct omap_hwmod_irq_info omap44xx_slimbus2_irqs[] = {
+	{ .irq = 98 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap44xx_slimbus2_sdma_reqs[] = {
+	{ .name = "tx0", .dma_req = 92 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx1", .dma_req = 93 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx2", .dma_req = 94 + OMAP44XX_DMA_REQ_START },
+	{ .name = "tx3", .dma_req = 95 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx0", .dma_req = 96 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx1", .dma_req = 97 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx2", .dma_req = 98 + OMAP44XX_DMA_REQ_START },
+	{ .name = "rx3", .dma_req = 99 + OMAP44XX_DMA_REQ_START },
+	{ .dma_req = -1 }
+};
+
+static struct omap_hwmod_opt_clk slimbus2_opt_clks[] = {
+	{ .role = "fclk_1", .clk = "slimbus2_fclk_1" },
+	{ .role = "fclk_0", .clk = "slimbus2_fclk_0" },
+	{ .role = "slimbus_clk", .clk = "slimbus2_slimbus_clk" },
+};
+
+static struct omap_hwmod omap44xx_slimbus2_hwmod = {
+	.name		= "slimbus2",
+	.class		= &omap44xx_slimbus_hwmod_class,
+	.clkdm_name	= "l4_per_clkdm",
+	.mpu_irqs	= omap44xx_slimbus2_irqs,
+	.sdma_reqs	= omap44xx_slimbus2_sdma_reqs,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_L4PER_SLIMBUS2_CLKCTRL_OFFSET,
+			.context_offs = OMAP4_RM_L4PER_SLIMBUS2_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= slimbus2_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(slimbus2_opt_clks),
+};
+
+/*
  * 'smartreflex' class
  * smartreflex module (monitor silicon performance and outputs a measure of
  * performance error)
@@ -4452,6 +4554,60 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc5 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_addr_space omap44xx_slimbus1_addrs[] = {
+	{
+		.pa_start	= 0x4012c000,
+		.pa_end		= 0x4012c3ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_abe -> slimbus1 */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__slimbus1 = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_slimbus1_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_slimbus1_addrs,
+	.user		= OCP_USER_MPU,
+};
+
+static struct omap_hwmod_addr_space omap44xx_slimbus1_dma_addrs[] = {
+	{
+		.pa_start	= 0x4902c000,
+		.pa_end		= 0x4902c3ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_abe -> slimbus1 (dma) */
+static struct omap_hwmod_ocp_if omap44xx_l4_abe__slimbus1_dma = {
+	.master		= &omap44xx_l4_abe_hwmod,
+	.slave		= &omap44xx_slimbus1_hwmod,
+	.clk		= "ocp_abe_iclk",
+	.addr		= omap44xx_slimbus1_dma_addrs,
+	.user		= OCP_USER_SDMA,
+};
+
+static struct omap_hwmod_addr_space omap44xx_slimbus2_addrs[] = {
+	{
+		.pa_start	= 0x48076000,
+		.pa_end		= 0x480763ff,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* l4_per -> slimbus2 */
+static struct omap_hwmod_ocp_if omap44xx_l4_per__slimbus2 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_slimbus2_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_slimbus2_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_addr_space omap44xx_smartreflex_core_addrs[] = {
 	{
 		.pa_start	= 0x4a0dd000,
@@ -5084,6 +5240,9 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__mmc3,
 	&omap44xx_l4_per__mmc4,
 	&omap44xx_l4_per__mmc5,
+	&omap44xx_l4_abe__slimbus1,
+	&omap44xx_l4_abe__slimbus1_dma,
+	&omap44xx_l4_per__slimbus2,
 	&omap44xx_l4_cfg__smartreflex_core,
 	&omap44xx_l4_cfg__smartreflex_iva,
 	&omap44xx_l4_cfg__smartreflex_mpu,
