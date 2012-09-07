From: balbi@ti.com (Felipe Balbi)
Date: Fri, 7 Sep 2012 20:25:02 +0300
Subject: [PATCH] ARM: dts: OMAP4: Add reg and interrupts for every nodes
In-Reply-To: <20120907170621.GZ1303@atomide.com>
References: <504A11E4.6000406@ti.com>
 <20120907170621.GZ1303@atomide.com>
Message-ID: <20120907172500.GB9208@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 07, 2012 at 10:06:22AM -0700, Tony Lindgren wrote:
> * Benoit Cousson <b-cousson@ti.com> [120907 08:26]:
> > Thanks to Vaibhav <hvaibhav@ti.com> omap_device fix
> > (ARM: OMAP: omap_device: Fix up resource names when booted with devicetre),
> > we can now specify reg and interrupts using standard device tree
> > attributes.
> > 
> > Update the OMAP4 dtsi file with missing reg and interrupts attributes.
> > 
> > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Felipe Balbi <balbi@ti.com>
> > ---
> > 
> > Hi Tony,
> > 
> > This is the first step toward reduction of the hwmod data inside mach-omap2.
> > OMAP2/3/4 data still need to be there for legacy boards, but it will allow
> > OMAP5/AM33XX pure DT board to reduce the amount of data provided by hwmod.
> 
> That's good to hear, that should cut down the data by some hundreds of lines :)

more than you think, I guess :-)

commit ed674f12d10f8ebb52758d122ed196a8f0ddabc6
Author: Felipe Balbi <balbi@ti.com>
Date:   Fri Sep 7 20:21:36 2012 +0300

    DO NOT APPLY
    
    $ sed -i '/omap_hwmod_addr_space/,/};/d' arch/arm/mach-omap2/omap_hwmod_44xx_data.c
    $ sed -i '/omap_hwmod_irq_info/,/};/d' arch/arm/mach-omap2/omap_hwmod_44xx_data.c
    $ sed -i '/.mpu_irqs.*$/d' arch/arm/mach-omap2/omap_hwmod_44xx_data.c
    $ sed -i '/.addr.*$/d' arch/arm/mach-omap2/omap_hwmod_44xx_data.c
    
    NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 242aee4..9c63898 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -79,16 +79,11 @@ static struct omap_hwmod_class omap44xx_dmm_hwmod_class = {
 };
 
 /* dmm */
-static struct omap_hwmod_irq_info omap44xx_dmm_irqs[] = {
-	{ .irq = 113 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_dmm_hwmod = {
 	.name		= "dmm",
 	.class		= &omap44xx_dmm_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
-	.mpu_irqs	= omap44xx_dmm_irqs,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_MEMIF_DMM_CLKCTRL_OFFSET,
@@ -141,17 +136,11 @@ static struct omap_hwmod omap44xx_l3_instr_hwmod = {
 };
 
 /* l3_main_1 */
-static struct omap_hwmod_irq_info omap44xx_l3_main_1_irqs[] = {
-	{ .name = "dbg_err", .irq = 9 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "app_err", .irq = 10 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 	.name		= "l3_main_1",
 	.class		= &omap44xx_l3_hwmod_class,
 	.clkdm_name	= "l3_1_clkdm",
-	.mpu_irqs	= omap44xx_l3_main_1_irqs,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3_1_L3_1_CLKCTRL_OFFSET,
@@ -315,10 +304,6 @@ static struct omap_hwmod_class omap44xx_aess_hwmod_class = {
 };
 
 /* aess */
-static struct omap_hwmod_irq_info omap44xx_aess_irqs[] = {
-	{ .irq = 99 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_aess_sdma_reqs[] = {
 	{ .name = "fifo0", .dma_req = 100 + OMAP44XX_DMA_REQ_START },
@@ -336,7 +321,6 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 	.name		= "aess",
 	.class		= &omap44xx_aess_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.mpu_irqs	= omap44xx_aess_irqs,
 	.sdma_reqs	= omap44xx_aess_sdma_reqs,
 	.main_clk	= "aess_fck",
 	.prcm = {
@@ -359,10 +343,6 @@ static struct omap_hwmod_class omap44xx_c2c_hwmod_class = {
 };
 
 /* c2c */
-static struct omap_hwmod_irq_info omap44xx_c2c_irqs[] = {
-	{ .irq = 88 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_c2c_sdma_reqs[] = {
 	{ .dma_req = 68 + OMAP44XX_DMA_REQ_START },
@@ -373,7 +353,6 @@ static struct omap_hwmod omap44xx_c2c_hwmod = {
 	.name		= "c2c",
 	.class		= &omap44xx_c2c_hwmod_class,
 	.clkdm_name	= "d2d_clkdm",
-	.mpu_irqs	= omap44xx_c2c_irqs,
 	.sdma_reqs	= omap44xx_c2c_sdma_reqs,
 	.prcm = {
 		.omap4 = {
@@ -437,16 +416,11 @@ static struct omap_hwmod_class omap44xx_ctrl_module_hwmod_class = {
 };
 
 /* ctrl_module_core */
-static struct omap_hwmod_irq_info omap44xx_ctrl_module_core_irqs[] = {
-	{ .irq = 8 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_ctrl_module_core_hwmod = {
 	.name		= "ctrl_module_core",
 	.class		= &omap44xx_ctrl_module_hwmod_class,
 	.clkdm_name	= "l4_cfg_clkdm",
-	.mpu_irqs	= omap44xx_ctrl_module_core_irqs,
 };
 
 /* ctrl_module_pad_core */
@@ -525,19 +499,11 @@ static struct omap_dma_dev_attr dma_dev_attr = {
 };
 
 /* dma_system */
-static struct omap_hwmod_irq_info omap44xx_dma_system_irqs[] = {
-	{ .name = "0", .irq = 12 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "1", .irq = 13 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "2", .irq = 14 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "3", .irq = 15 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.name		= "dma_system",
 	.class		= &omap44xx_dma_hwmod_class,
 	.clkdm_name	= "l3_dma_clkdm",
-	.mpu_irqs	= omap44xx_dma_system_irqs,
 	.main_clk	= "l3_div_ck",
 	.prcm = {
 		.omap4 = {
@@ -569,10 +535,6 @@ static struct omap_hwmod_class omap44xx_dmic_hwmod_class = {
 };
 
 /* dmic */
-static struct omap_hwmod_irq_info omap44xx_dmic_irqs[] = {
-	{ .irq = 114 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_dmic_sdma_reqs[] = {
 	{ .dma_req = 66 + OMAP44XX_DMA_REQ_START },
@@ -583,7 +545,6 @@ static struct omap_hwmod omap44xx_dmic_hwmod = {
 	.name		= "dmic",
 	.class		= &omap44xx_dmic_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.mpu_irqs	= omap44xx_dmic_irqs,
 	.sdma_reqs	= omap44xx_dmic_sdma_reqs,
 	.main_clk	= "dmic_fck",
 	.prcm = {
@@ -605,10 +566,6 @@ static struct omap_hwmod_class omap44xx_dsp_hwmod_class = {
 };
 
 /* dsp */
-static struct omap_hwmod_irq_info omap44xx_dsp_irqs[] = {
-	{ .irq = 28 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_rst_info omap44xx_dsp_resets[] = {
 	{ .name = "dsp", .rst_shift = 0 },
@@ -619,7 +576,6 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
 	.name		= "dsp",
 	.class		= &omap44xx_dsp_hwmod_class,
 	.clkdm_name	= "tesla_clkdm",
-	.mpu_irqs	= omap44xx_dsp_irqs,
 	.rst_lines	= omap44xx_dsp_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_resets),
 	.main_clk	= "dsp_fck",
@@ -697,10 +653,6 @@ static struct omap_hwmod_class omap44xx_dispc_hwmod_class = {
 };
 
 /* dss_dispc */
-static struct omap_hwmod_irq_info omap44xx_dss_dispc_irqs[] = {
-	{ .irq = 25 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_dss_dispc_sdma_reqs[] = {
 	{ .dma_req = 5 + OMAP44XX_DMA_REQ_START },
@@ -716,7 +668,6 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap44xx_dispc_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
-	.mpu_irqs	= omap44xx_dss_dispc_irqs,
 	.sdma_reqs	= omap44xx_dss_dispc_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
@@ -750,10 +701,6 @@ static struct omap_hwmod_class omap44xx_dsi_hwmod_class = {
 };
 
 /* dss_dsi1 */
-static struct omap_hwmod_irq_info omap44xx_dss_dsi1_irqs[] = {
-	{ .irq = 53 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_dss_dsi1_sdma_reqs[] = {
 	{ .dma_req = 74 + OMAP44XX_DMA_REQ_START },
@@ -768,7 +715,6 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.name		= "dss_dsi1",
 	.class		= &omap44xx_dsi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
-	.mpu_irqs	= omap44xx_dss_dsi1_irqs,
 	.sdma_reqs	= omap44xx_dss_dsi1_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
@@ -782,10 +728,6 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 };
 
 /* dss_dsi2 */
-static struct omap_hwmod_irq_info omap44xx_dss_dsi2_irqs[] = {
-	{ .irq = 84 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_dss_dsi2_sdma_reqs[] = {
 	{ .dma_req = 83 + OMAP44XX_DMA_REQ_START },
@@ -800,7 +742,6 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.name		= "dss_dsi2",
 	.class		= &omap44xx_dsi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
-	.mpu_irqs	= omap44xx_dss_dsi2_irqs,
 	.sdma_reqs	= omap44xx_dss_dsi2_sdma_reqs,
 	.main_clk	= "dss_dss_clk",
 	.prcm = {
@@ -834,10 +775,6 @@ static struct omap_hwmod_class omap44xx_hdmi_hwmod_class = {
 };
 
 /* dss_hdmi */
-static struct omap_hwmod_irq_info omap44xx_dss_hdmi_irqs[] = {
-	{ .irq = 101 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_dss_hdmi_sdma_reqs[] = {
 	{ .dma_req = 75 + OMAP44XX_DMA_REQ_START },
@@ -857,7 +794,6 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	 * set idle mode by software.
 	 */
 	.flags		= HWMOD_SWSUP_SIDLE,
-	.mpu_irqs	= omap44xx_dss_hdmi_irqs,
 	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
 	.main_clk	= "dss_48mhz_clk",
 	.prcm = {
@@ -961,16 +897,11 @@ static struct omap_hwmod_class omap44xx_elm_hwmod_class = {
 };
 
 /* elm */
-static struct omap_hwmod_irq_info omap44xx_elm_irqs[] = {
-	{ .irq = 4 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_elm_hwmod = {
 	.name		= "elm",
 	.class		= &omap44xx_elm_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_elm_irqs,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_ELM_CLKCTRL_OFFSET,
@@ -994,17 +925,12 @@ static struct omap_hwmod_class omap44xx_emif_hwmod_class = {
 };
 
 /* emif1 */
-static struct omap_hwmod_irq_info omap44xx_emif1_irqs[] = {
-	{ .irq = 110 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_emif1_hwmod = {
 	.name		= "emif1",
 	.class		= &omap44xx_emif_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.mpu_irqs	= omap44xx_emif1_irqs,
 	.main_clk	= "ddrphy_ck",
 	.prcm = {
 		.omap4 = {
@@ -1016,17 +942,12 @@ static struct omap_hwmod omap44xx_emif1_hwmod = {
 };
 
 /* emif2 */
-static struct omap_hwmod_irq_info omap44xx_emif2_irqs[] = {
-	{ .irq = 111 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_emif2_hwmod = {
 	.name		= "emif2",
 	.class		= &omap44xx_emif_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.mpu_irqs	= omap44xx_emif2_irqs,
 	.main_clk	= "ddrphy_ck",
 	.prcm = {
 		.omap4 = {
@@ -1067,16 +988,11 @@ static struct omap_hwmod_class omap44xx_fdif_hwmod_class = {
 };
 
 /* fdif */
-static struct omap_hwmod_irq_info omap44xx_fdif_irqs[] = {
-	{ .irq = 69 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_fdif_hwmod = {
 	.name		= "fdif",
 	.class		= &omap44xx_fdif_hwmod_class,
 	.clkdm_name	= "iss_clkdm",
-	.mpu_irqs	= omap44xx_fdif_irqs,
 	.main_clk	= "fdif_fck",
 	.prcm = {
 		.omap4 = {
@@ -1117,10 +1033,6 @@ static struct omap_gpio_dev_attr gpio_dev_attr = {
 };
 
 /* gpio1 */
-static struct omap_hwmod_irq_info omap44xx_gpio1_irqs[] = {
-	{ .irq = 29 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio1_dbclk" },
@@ -1130,7 +1042,6 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.mpu_irqs	= omap44xx_gpio1_irqs,
 	.main_clk	= "gpio1_ick",
 	.prcm = {
 		.omap4 = {
@@ -1145,10 +1056,6 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 };
 
 /* gpio2 */
-static struct omap_hwmod_irq_info omap44xx_gpio2_irqs[] = {
-	{ .irq = 30 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio2_dbclk" },
@@ -1159,7 +1066,6 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap44xx_gpio2_irqs,
 	.main_clk	= "gpio2_ick",
 	.prcm = {
 		.omap4 = {
@@ -1174,10 +1080,6 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 };
 
 /* gpio3 */
-static struct omap_hwmod_irq_info omap44xx_gpio3_irqs[] = {
-	{ .irq = 31 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio3_dbclk" },
@@ -1188,7 +1090,6 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap44xx_gpio3_irqs,
 	.main_clk	= "gpio3_ick",
 	.prcm = {
 		.omap4 = {
@@ -1203,10 +1104,6 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 };
 
 /* gpio4 */
-static struct omap_hwmod_irq_info omap44xx_gpio4_irqs[] = {
-	{ .irq = 32 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio4_dbclk" },
@@ -1217,7 +1114,6 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap44xx_gpio4_irqs,
 	.main_clk	= "gpio4_ick",
 	.prcm = {
 		.omap4 = {
@@ -1232,10 +1128,6 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 };
 
 /* gpio5 */
-static struct omap_hwmod_irq_info omap44xx_gpio5_irqs[] = {
-	{ .irq = 33 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio5_dbclk" },
@@ -1246,7 +1138,6 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap44xx_gpio5_irqs,
 	.main_clk	= "gpio5_ick",
 	.prcm = {
 		.omap4 = {
@@ -1261,10 +1152,6 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 };
 
 /* gpio6 */
-static struct omap_hwmod_irq_info omap44xx_gpio6_irqs[] = {
-	{ .irq = 34 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
 	{ .role = "dbclk", .clk = "gpio6_dbclk" },
@@ -1275,7 +1162,6 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.mpu_irqs	= omap44xx_gpio6_irqs,
 	.main_clk	= "gpio6_ick",
 	.prcm = {
 		.omap4 = {
@@ -1310,10 +1196,6 @@ static struct omap_hwmod_class omap44xx_gpmc_hwmod_class = {
 };
 
 /* gpmc */
-static struct omap_hwmod_irq_info omap44xx_gpmc_irqs[] = {
-	{ .irq = 20 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_gpmc_sdma_reqs[] = {
 	{ .dma_req = 3 + OMAP44XX_DMA_REQ_START },
@@ -1325,7 +1207,6 @@ static struct omap_hwmod omap44xx_gpmc_hwmod = {
 	.class		= &omap44xx_gpmc_hwmod_class,
 	.clkdm_name	= "l3_2_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.mpu_irqs	= omap44xx_gpmc_irqs,
 	.sdma_reqs	= omap44xx_gpmc_sdma_reqs,
 	.prcm = {
 		.omap4 = {
@@ -1357,16 +1238,11 @@ static struct omap_hwmod_class omap44xx_gpu_hwmod_class = {
 };
 
 /* gpu */
-static struct omap_hwmod_irq_info omap44xx_gpu_irqs[] = {
-	{ .irq = 21 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_gpu_hwmod = {
 	.name		= "gpu",
 	.class		= &omap44xx_gpu_hwmod_class,
 	.clkdm_name	= "l3_gfx_clkdm",
-	.mpu_irqs	= omap44xx_gpu_irqs,
 	.main_clk	= "gpu_fck",
 	.prcm = {
 		.omap4 = {
@@ -1397,17 +1273,12 @@ static struct omap_hwmod_class omap44xx_hdq1w_hwmod_class = {
 };
 
 /* hdq1w */
-static struct omap_hwmod_irq_info omap44xx_hdq1w_irqs[] = {
-	{ .irq = 58 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_hdq1w_hwmod = {
 	.name		= "hdq1w",
 	.class		= &omap44xx_hdq1w_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_INIT_NO_RESET, /* XXX temporary */
-	.mpu_irqs	= omap44xx_hdq1w_irqs,
 	.main_clk	= "hdq1w_fck",
 	.prcm = {
 		.omap4 = {
@@ -1443,18 +1314,11 @@ static struct omap_hwmod_class omap44xx_hsi_hwmod_class = {
 };
 
 /* hsi */
-static struct omap_hwmod_irq_info omap44xx_hsi_irqs[] = {
-	{ .name = "mpu_p1", .irq = 67 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "mpu_p2", .irq = 68 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "mpu_dma", .irq = 71 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_hsi_hwmod = {
 	.name		= "hsi",
 	.class		= &omap44xx_hsi_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.mpu_irqs	= omap44xx_hsi_irqs,
 	.main_clk	= "hsi_fck",
 	.prcm = {
 		.omap4 = {
@@ -1495,10 +1359,6 @@ static struct omap_i2c_dev_attr i2c_dev_attr = {
 };
 
 /* i2c1 */
-static struct omap_hwmod_irq_info omap44xx_i2c1_irqs[] = {
-	{ .irq = 56 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_i2c1_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 26 + OMAP44XX_DMA_REQ_START },
@@ -1511,7 +1371,6 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.mpu_irqs	= omap44xx_i2c1_irqs,
 	.sdma_reqs	= omap44xx_i2c1_sdma_reqs,
 	.main_clk	= "i2c1_fck",
 	.prcm = {
@@ -1525,10 +1384,6 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 };
 
 /* i2c2 */
-static struct omap_hwmod_irq_info omap44xx_i2c2_irqs[] = {
-	{ .irq = 57 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_i2c2_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 28 + OMAP44XX_DMA_REQ_START },
@@ -1541,7 +1396,6 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.mpu_irqs	= omap44xx_i2c2_irqs,
 	.sdma_reqs	= omap44xx_i2c2_sdma_reqs,
 	.main_clk	= "i2c2_fck",
 	.prcm = {
@@ -1555,10 +1409,6 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 };
 
 /* i2c3 */
-static struct omap_hwmod_irq_info omap44xx_i2c3_irqs[] = {
-	{ .irq = 61 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_i2c3_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 24 + OMAP44XX_DMA_REQ_START },
@@ -1571,7 +1421,6 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.mpu_irqs	= omap44xx_i2c3_irqs,
 	.sdma_reqs	= omap44xx_i2c3_sdma_reqs,
 	.main_clk	= "i2c3_fck",
 	.prcm = {
@@ -1585,10 +1434,6 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 };
 
 /* i2c4 */
-static struct omap_hwmod_irq_info omap44xx_i2c4_irqs[] = {
-	{ .irq = 62 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_i2c4_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 123 + OMAP44XX_DMA_REQ_START },
@@ -1601,7 +1446,6 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.mpu_irqs	= omap44xx_i2c4_irqs,
 	.sdma_reqs	= omap44xx_i2c4_sdma_reqs,
 	.main_clk	= "i2c4_fck",
 	.prcm = {
@@ -1624,10 +1468,6 @@ static struct omap_hwmod_class omap44xx_ipu_hwmod_class = {
 };
 
 /* ipu */
-static struct omap_hwmod_irq_info omap44xx_ipu_irqs[] = {
-	{ .irq = 100 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_rst_info omap44xx_ipu_resets[] = {
 	{ .name = "cpu0", .rst_shift = 0 },
@@ -1639,7 +1479,6 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
 	.name		= "ipu",
 	.class		= &omap44xx_ipu_hwmod_class,
 	.clkdm_name	= "ducati_clkdm",
-	.mpu_irqs	= omap44xx_ipu_irqs,
 	.rst_lines	= omap44xx_ipu_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_resets),
 	.main_clk	= "ipu_fck",
@@ -1684,10 +1523,6 @@ static struct omap_hwmod_class omap44xx_iss_hwmod_class = {
 };
 
 /* iss */
-static struct omap_hwmod_irq_info omap44xx_iss_irqs[] = {
-	{ .irq = 24 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_iss_sdma_reqs[] = {
 	{ .name = "1", .dma_req = 8 + OMAP44XX_DMA_REQ_START },
@@ -1705,7 +1540,6 @@ static struct omap_hwmod omap44xx_iss_hwmod = {
 	.name		= "iss",
 	.class		= &omap44xx_iss_hwmod_class,
 	.clkdm_name	= "iss_clkdm",
-	.mpu_irqs	= omap44xx_iss_irqs,
 	.sdma_reqs	= omap44xx_iss_sdma_reqs,
 	.main_clk	= "iss_fck",
 	.prcm = {
@@ -1729,12 +1563,6 @@ static struct omap_hwmod_class omap44xx_iva_hwmod_class = {
 };
 
 /* iva */
-static struct omap_hwmod_irq_info omap44xx_iva_irqs[] = {
-	{ .name = "sync_1", .irq = 103 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "sync_0", .irq = 104 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "mailbox_0", .irq = 107 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_rst_info omap44xx_iva_resets[] = {
 	{ .name = "seq0", .rst_shift = 0 },
@@ -1746,7 +1574,6 @@ static struct omap_hwmod omap44xx_iva_hwmod = {
 	.name		= "iva",
 	.class		= &omap44xx_iva_hwmod_class,
 	.clkdm_name	= "ivahd_clkdm",
-	.mpu_irqs	= omap44xx_iva_irqs,
 	.rst_lines	= omap44xx_iva_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_iva_resets),
 	.main_clk	= "iva_fck",
@@ -1783,16 +1610,11 @@ static struct omap_hwmod_class omap44xx_kbd_hwmod_class = {
 };
 
 /* kbd */
-static struct omap_hwmod_irq_info omap44xx_kbd_irqs[] = {
-	{ .irq = 120 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_kbd_hwmod = {
 	.name		= "kbd",
 	.class		= &omap44xx_kbd_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.mpu_irqs	= omap44xx_kbd_irqs,
 	.main_clk	= "kbd_fck",
 	.prcm = {
 		.omap4 = {
@@ -1824,16 +1646,11 @@ static struct omap_hwmod_class omap44xx_mailbox_hwmod_class = {
 };
 
 /* mailbox */
-static struct omap_hwmod_irq_info omap44xx_mailbox_irqs[] = {
-	{ .irq = 26 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_mailbox_hwmod = {
 	.name		= "mailbox",
 	.class		= &omap44xx_mailbox_hwmod_class,
 	.clkdm_name	= "l4_cfg_clkdm",
-	.mpu_irqs	= omap44xx_mailbox_irqs,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4CFG_MAILBOX_CLKCTRL_OFFSET,
@@ -1866,11 +1683,6 @@ static struct omap_hwmod_class omap44xx_mcasp_hwmod_class = {
 };
 
 /* mcasp */
-static struct omap_hwmod_irq_info omap44xx_mcasp_irqs[] = {
-	{ .name = "arevt", .irq = 108 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "axevt", .irq = 109 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_mcasp_sdma_reqs[] = {
 	{ .name = "axevt", .dma_req = 7 + OMAP44XX_DMA_REQ_START },
@@ -1882,7 +1694,6 @@ static struct omap_hwmod omap44xx_mcasp_hwmod = {
 	.name		= "mcasp",
 	.class		= &omap44xx_mcasp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.mpu_irqs	= omap44xx_mcasp_irqs,
 	.sdma_reqs	= omap44xx_mcasp_sdma_reqs,
 	.main_clk	= "mcasp_fck",
 	.prcm = {
@@ -1914,10 +1725,6 @@ static struct omap_hwmod_class omap44xx_mcbsp_hwmod_class = {
 };
 
 /* mcbsp1 */
-static struct omap_hwmod_irq_info omap44xx_mcbsp1_irqs[] = {
-	{ .name = "common", .irq = 17 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_mcbsp1_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 32 + OMAP44XX_DMA_REQ_START },
@@ -1934,7 +1741,6 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.mpu_irqs	= omap44xx_mcbsp1_irqs,
 	.sdma_reqs	= omap44xx_mcbsp1_sdma_reqs,
 	.main_clk	= "mcbsp1_fck",
 	.prcm = {
@@ -1949,10 +1755,6 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 };
 
 /* mcbsp2 */
-static struct omap_hwmod_irq_info omap44xx_mcbsp2_irqs[] = {
-	{ .name = "common", .irq = 22 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_mcbsp2_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 16 + OMAP44XX_DMA_REQ_START },
@@ -1969,7 +1771,6 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.mpu_irqs	= omap44xx_mcbsp2_irqs,
 	.sdma_reqs	= omap44xx_mcbsp2_sdma_reqs,
 	.main_clk	= "mcbsp2_fck",
 	.prcm = {
@@ -1984,10 +1785,6 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 };
 
 /* mcbsp3 */
-static struct omap_hwmod_irq_info omap44xx_mcbsp3_irqs[] = {
-	{ .name = "common", .irq = 23 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_mcbsp3_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 18 + OMAP44XX_DMA_REQ_START },
@@ -2004,7 +1801,6 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.mpu_irqs	= omap44xx_mcbsp3_irqs,
 	.sdma_reqs	= omap44xx_mcbsp3_sdma_reqs,
 	.main_clk	= "mcbsp3_fck",
 	.prcm = {
@@ -2019,10 +1815,6 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 };
 
 /* mcbsp4 */
-static struct omap_hwmod_irq_info omap44xx_mcbsp4_irqs[] = {
-	{ .name = "common", .irq = 16 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_mcbsp4_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 30 + OMAP44XX_DMA_REQ_START },
@@ -2039,7 +1831,6 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 	.name		= "mcbsp4",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_mcbsp4_irqs,
 	.sdma_reqs	= omap44xx_mcbsp4_sdma_reqs,
 	.main_clk	= "mcbsp4_fck",
 	.prcm = {
@@ -2075,10 +1866,6 @@ static struct omap_hwmod_class omap44xx_mcpdm_hwmod_class = {
 };
 
 /* mcpdm */
-static struct omap_hwmod_irq_info omap44xx_mcpdm_irqs[] = {
-	{ .irq = 112 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_mcpdm_sdma_reqs[] = {
 	{ .name = "up_link", .dma_req = 64 + OMAP44XX_DMA_REQ_START },
@@ -2090,7 +1877,6 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	.name		= "mcpdm",
 	.class		= &omap44xx_mcpdm_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.mpu_irqs	= omap44xx_mcpdm_irqs,
 	.sdma_reqs	= omap44xx_mcpdm_sdma_reqs,
 	.main_clk	= "mcpdm_fck",
 	.prcm = {
@@ -2125,10 +1911,6 @@ static struct omap_hwmod_class omap44xx_mcspi_hwmod_class = {
 };
 
 /* mcspi1 */
-static struct omap_hwmod_irq_info omap44xx_mcspi1_irqs[] = {
-	{ .irq = 65 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_mcspi1_sdma_reqs[] = {
 	{ .name = "tx0", .dma_req = 34 + OMAP44XX_DMA_REQ_START },
@@ -2151,7 +1933,6 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 	.name		= "mcspi1",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_mcspi1_irqs,
 	.sdma_reqs	= omap44xx_mcspi1_sdma_reqs,
 	.main_clk	= "mcspi1_fck",
 	.prcm = {
@@ -2165,10 +1946,6 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 };
 
 /* mcspi2 */
-static struct omap_hwmod_irq_info omap44xx_mcspi2_irqs[] = {
-	{ .irq = 66 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_mcspi2_sdma_reqs[] = {
 	{ .name = "tx0", .dma_req = 42 + OMAP44XX_DMA_REQ_START },
@@ -2187,7 +1964,6 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 	.name		= "mcspi2",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_mcspi2_irqs,
 	.sdma_reqs	= omap44xx_mcspi2_sdma_reqs,
 	.main_clk	= "mcspi2_fck",
 	.prcm = {
@@ -2201,10 +1977,6 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 };
 
 /* mcspi3 */
-static struct omap_hwmod_irq_info omap44xx_mcspi3_irqs[] = {
-	{ .irq = 91 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_mcspi3_sdma_reqs[] = {
 	{ .name = "tx0", .dma_req = 14 + OMAP44XX_DMA_REQ_START },
@@ -2223,7 +1995,6 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 	.name		= "mcspi3",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_mcspi3_irqs,
 	.sdma_reqs	= omap44xx_mcspi3_sdma_reqs,
 	.main_clk	= "mcspi3_fck",
 	.prcm = {
@@ -2237,10 +2008,6 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 };
 
 /* mcspi4 */
-static struct omap_hwmod_irq_info omap44xx_mcspi4_irqs[] = {
-	{ .irq = 48 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_mcspi4_sdma_reqs[] = {
 	{ .name = "tx0", .dma_req = 69 + OMAP44XX_DMA_REQ_START },
@@ -2257,7 +2024,6 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 	.name		= "mcspi4",
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_mcspi4_irqs,
 	.sdma_reqs	= omap44xx_mcspi4_sdma_reqs,
 	.main_clk	= "mcspi4_fck",
 	.prcm = {
@@ -2293,10 +2059,6 @@ static struct omap_hwmod_class omap44xx_mmc_hwmod_class = {
 };
 
 /* mmc1 */
-static struct omap_hwmod_irq_info omap44xx_mmc1_irqs[] = {
-	{ .irq = 83 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_mmc1_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 60 + OMAP44XX_DMA_REQ_START },
@@ -2313,7 +2075,6 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.name		= "mmc1",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.mpu_irqs	= omap44xx_mmc1_irqs,
 	.sdma_reqs	= omap44xx_mmc1_sdma_reqs,
 	.main_clk	= "mmc1_fck",
 	.prcm = {
@@ -2327,10 +2088,6 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 };
 
 /* mmc2 */
-static struct omap_hwmod_irq_info omap44xx_mmc2_irqs[] = {
-	{ .irq = 86 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_mmc2_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 46 + OMAP44XX_DMA_REQ_START },
@@ -2342,7 +2099,6 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.name		= "mmc2",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.mpu_irqs	= omap44xx_mmc2_irqs,
 	.sdma_reqs	= omap44xx_mmc2_sdma_reqs,
 	.main_clk	= "mmc2_fck",
 	.prcm = {
@@ -2355,10 +2111,6 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 };
 
 /* mmc3 */
-static struct omap_hwmod_irq_info omap44xx_mmc3_irqs[] = {
-	{ .irq = 94 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_mmc3_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 76 + OMAP44XX_DMA_REQ_START },
@@ -2370,7 +2122,6 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	.name		= "mmc3",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_mmc3_irqs,
 	.sdma_reqs	= omap44xx_mmc3_sdma_reqs,
 	.main_clk	= "mmc3_fck",
 	.prcm = {
@@ -2383,10 +2134,6 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 };
 
 /* mmc4 */
-static struct omap_hwmod_irq_info omap44xx_mmc4_irqs[] = {
-	{ .irq = 96 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_mmc4_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 56 + OMAP44XX_DMA_REQ_START },
@@ -2398,7 +2145,6 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	.name		= "mmc4",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_mmc4_irqs,
 	.sdma_reqs	= omap44xx_mmc4_sdma_reqs,
 	.main_clk	= "mmc4_fck",
 	.prcm = {
@@ -2411,10 +2157,6 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 };
 
 /* mmc5 */
-static struct omap_hwmod_irq_info omap44xx_mmc5_irqs[] = {
-	{ .irq = 59 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_mmc5_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 58 + OMAP44XX_DMA_REQ_START },
@@ -2426,7 +2168,6 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	.name		= "mmc5",
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_mmc5_irqs,
 	.sdma_reqs	= omap44xx_mmc5_sdma_reqs,
 	.main_clk	= "mmc5_fck",
 	.prcm = {
@@ -2448,19 +2189,12 @@ static struct omap_hwmod_class omap44xx_mpu_hwmod_class = {
 };
 
 /* mpu */
-static struct omap_hwmod_irq_info omap44xx_mpu_irqs[] = {
-	{ .name = "pl310", .irq = 0 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_mpu_hwmod = {
 	.name		= "mpu",
 	.class		= &omap44xx_mpu_hwmod_class,
 	.clkdm_name	= "mpuss_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.mpu_irqs	= omap44xx_mpu_irqs,
 	.main_clk	= "dpll_mpu_m2_ck",
 	.prcm = {
 		.omap4 = {
@@ -2552,10 +2286,6 @@ static struct omap_hwmod omap44xx_cm_core_hwmod = {
 };
 
 /* prm */
-static struct omap_hwmod_irq_info omap44xx_prm_irqs[] = {
-	{ .irq = 11 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_rst_info omap44xx_prm_resets[] = {
 	{ .name = "rst_global_warm_sw", .rst_shift = 0 },
@@ -2565,7 +2295,6 @@ static struct omap_hwmod_rst_info omap44xx_prm_resets[] = {
 static struct omap_hwmod omap44xx_prm_hwmod = {
 	.name		= "prm",
 	.class		= &omap44xx_prcm_hwmod_class,
-	.mpu_irqs	= omap44xx_prm_irqs,
 	.rst_lines	= omap44xx_prm_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_prm_resets),
 };
@@ -2631,10 +2360,6 @@ static struct omap_hwmod_class omap44xx_slimbus_hwmod_class = {
 };
 
 /* slimbus1 */
-static struct omap_hwmod_irq_info omap44xx_slimbus1_irqs[] = {
-	{ .irq = 97 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_slimbus1_sdma_reqs[] = {
 	{ .name = "tx0", .dma_req = 84 + OMAP44XX_DMA_REQ_START },
@@ -2659,7 +2384,6 @@ static struct omap_hwmod omap44xx_slimbus1_hwmod = {
 	.name		= "slimbus1",
 	.class		= &omap44xx_slimbus_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.mpu_irqs	= omap44xx_slimbus1_irqs,
 	.sdma_reqs	= omap44xx_slimbus1_sdma_reqs,
 	.prcm = {
 		.omap4 = {
@@ -2673,10 +2397,6 @@ static struct omap_hwmod omap44xx_slimbus1_hwmod = {
 };
 
 /* slimbus2 */
-static struct omap_hwmod_irq_info omap44xx_slimbus2_irqs[] = {
-	{ .irq = 98 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_slimbus2_sdma_reqs[] = {
 	{ .name = "tx0", .dma_req = 92 + OMAP44XX_DMA_REQ_START },
@@ -2700,7 +2420,6 @@ static struct omap_hwmod omap44xx_slimbus2_hwmod = {
 	.name		= "slimbus2",
 	.class		= &omap44xx_slimbus_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_slimbus2_irqs,
 	.sdma_reqs	= omap44xx_slimbus2_sdma_reqs,
 	.prcm = {
 		.omap4 = {
@@ -2744,16 +2463,11 @@ static struct omap_smartreflex_dev_attr smartreflex_core_dev_attr = {
 	.sensor_voltdm_name   = "core",
 };
 
-static struct omap_hwmod_irq_info omap44xx_smartreflex_core_irqs[] = {
-	{ .irq = 19 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	.name		= "smartreflex_core",
 	.class		= &omap44xx_smartreflex_hwmod_class,
 	.clkdm_name	= "l4_ao_clkdm",
-	.mpu_irqs	= omap44xx_smartreflex_core_irqs,
 
 	.main_clk	= "smartreflex_core_fck",
 	.prcm = {
@@ -2771,16 +2485,11 @@ static struct omap_smartreflex_dev_attr smartreflex_iva_dev_attr = {
 	.sensor_voltdm_name	= "iva",
 };
 
-static struct omap_hwmod_irq_info omap44xx_smartreflex_iva_irqs[] = {
-	{ .irq = 102 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	.name		= "smartreflex_iva",
 	.class		= &omap44xx_smartreflex_hwmod_class,
 	.clkdm_name	= "l4_ao_clkdm",
-	.mpu_irqs	= omap44xx_smartreflex_iva_irqs,
 	.main_clk	= "smartreflex_iva_fck",
 	.prcm = {
 		.omap4 = {
@@ -2797,16 +2506,11 @@ static struct omap_smartreflex_dev_attr smartreflex_mpu_dev_attr = {
 	.sensor_voltdm_name	= "mpu",
 };
 
-static struct omap_hwmod_irq_info omap44xx_smartreflex_mpu_irqs[] = {
-	{ .irq = 18 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	.name		= "smartreflex_mpu",
 	.class		= &omap44xx_smartreflex_hwmod_class,
 	.clkdm_name	= "l4_ao_clkdm",
-	.mpu_irqs	= omap44xx_smartreflex_mpu_irqs,
 	.main_clk	= "smartreflex_mpu_fck",
 	.prcm = {
 		.omap4 = {
@@ -2903,16 +2607,11 @@ static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
 };
 
 /* timer1 */
-static struct omap_hwmod_irq_info omap44xx_timer1_irqs[] = {
-	{ .irq = 37 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.name		= "timer1",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.mpu_irqs	= omap44xx_timer1_irqs,
 	.main_clk	= "timer1_fck",
 	.prcm = {
 		.omap4 = {
@@ -2925,16 +2624,11 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 };
 
 /* timer2 */
-static struct omap_hwmod_irq_info omap44xx_timer2_irqs[] = {
-	{ .irq = 38 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_timer2_hwmod = {
 	.name		= "timer2",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_timer2_irqs,
 	.main_clk	= "timer2_fck",
 	.prcm = {
 		.omap4 = {
@@ -2946,16 +2640,11 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 };
 
 /* timer3 */
-static struct omap_hwmod_irq_info omap44xx_timer3_irqs[] = {
-	{ .irq = 39 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_timer3_hwmod = {
 	.name		= "timer3",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_timer3_irqs,
 	.main_clk	= "timer3_fck",
 	.prcm = {
 		.omap4 = {
@@ -2967,16 +2656,11 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
 };
 
 /* timer4 */
-static struct omap_hwmod_irq_info omap44xx_timer4_irqs[] = {
-	{ .irq = 40 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_timer4_hwmod = {
 	.name		= "timer4",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_timer4_irqs,
 	.main_clk	= "timer4_fck",
 	.prcm = {
 		.omap4 = {
@@ -2988,16 +2672,11 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
 };
 
 /* timer5 */
-static struct omap_hwmod_irq_info omap44xx_timer5_irqs[] = {
-	{ .irq = 41 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_timer5_hwmod = {
 	.name		= "timer5",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.mpu_irqs	= omap44xx_timer5_irqs,
 	.main_clk	= "timer5_fck",
 	.prcm = {
 		.omap4 = {
@@ -3009,16 +2688,11 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 };
 
 /* timer6 */
-static struct omap_hwmod_irq_info omap44xx_timer6_irqs[] = {
-	{ .irq = 42 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_timer6_hwmod = {
 	.name		= "timer6",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.mpu_irqs	= omap44xx_timer6_irqs,
 
 	.main_clk	= "timer6_fck",
 	.prcm = {
@@ -3031,16 +2705,11 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 };
 
 /* timer7 */
-static struct omap_hwmod_irq_info omap44xx_timer7_irqs[] = {
-	{ .irq = 43 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_timer7_hwmod = {
 	.name		= "timer7",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.mpu_irqs	= omap44xx_timer7_irqs,
 	.main_clk	= "timer7_fck",
 	.prcm = {
 		.omap4 = {
@@ -3052,16 +2721,11 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 };
 
 /* timer8 */
-static struct omap_hwmod_irq_info omap44xx_timer8_irqs[] = {
-	{ .irq = 44 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_timer8_hwmod = {
 	.name		= "timer8",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.mpu_irqs	= omap44xx_timer8_irqs,
 	.main_clk	= "timer8_fck",
 	.prcm = {
 		.omap4 = {
@@ -3074,16 +2738,11 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
 };
 
 /* timer9 */
-static struct omap_hwmod_irq_info omap44xx_timer9_irqs[] = {
-	{ .irq = 45 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_timer9_hwmod = {
 	.name		= "timer9",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_timer9_irqs,
 	.main_clk	= "timer9_fck",
 	.prcm = {
 		.omap4 = {
@@ -3096,16 +2755,11 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
 };
 
 /* timer10 */
-static struct omap_hwmod_irq_info omap44xx_timer10_irqs[] = {
-	{ .irq = 46 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_timer10_hwmod = {
 	.name		= "timer10",
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_timer10_irqs,
 	.main_clk	= "timer10_fck",
 	.prcm = {
 		.omap4 = {
@@ -3118,16 +2772,11 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 };
 
 /* timer11 */
-static struct omap_hwmod_irq_info omap44xx_timer11_irqs[] = {
-	{ .irq = 47 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_timer11_hwmod = {
 	.name		= "timer11",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_timer11_irqs,
 	.main_clk	= "timer11_fck",
 	.prcm = {
 		.omap4 = {
@@ -3162,10 +2811,6 @@ static struct omap_hwmod_class omap44xx_uart_hwmod_class = {
 };
 
 /* uart1 */
-static struct omap_hwmod_irq_info omap44xx_uart1_irqs[] = {
-	{ .irq = 72 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_uart1_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 48 + OMAP44XX_DMA_REQ_START },
@@ -3177,7 +2822,6 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 	.name		= "uart1",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_uart1_irqs,
 	.sdma_reqs	= omap44xx_uart1_sdma_reqs,
 	.main_clk	= "uart1_fck",
 	.prcm = {
@@ -3190,10 +2834,6 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 };
 
 /* uart2 */
-static struct omap_hwmod_irq_info omap44xx_uart2_irqs[] = {
-	{ .irq = 73 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_uart2_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 50 + OMAP44XX_DMA_REQ_START },
@@ -3205,7 +2845,6 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 	.name		= "uart2",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_uart2_irqs,
 	.sdma_reqs	= omap44xx_uart2_sdma_reqs,
 	.main_clk	= "uart2_fck",
 	.prcm = {
@@ -3218,10 +2857,6 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 };
 
 /* uart3 */
-static struct omap_hwmod_irq_info omap44xx_uart3_irqs[] = {
-	{ .irq = 74 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_uart3_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 52 + OMAP44XX_DMA_REQ_START },
@@ -3234,7 +2869,6 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.mpu_irqs	= omap44xx_uart3_irqs,
 	.sdma_reqs	= omap44xx_uart3_sdma_reqs,
 	.main_clk	= "uart3_fck",
 	.prcm = {
@@ -3247,10 +2881,6 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 };
 
 /* uart4 */
-static struct omap_hwmod_irq_info omap44xx_uart4_irqs[] = {
-	{ .irq = 70 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_dma_info omap44xx_uart4_sdma_reqs[] = {
 	{ .name = "tx", .dma_req = 54 + OMAP44XX_DMA_REQ_START },
@@ -3262,7 +2892,6 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	.name		= "uart4",
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.mpu_irqs	= omap44xx_uart4_irqs,
 	.sdma_reqs	= omap44xx_uart4_sdma_reqs,
 	.main_clk	= "uart4_fck",
 	.prcm = {
@@ -3302,17 +2931,11 @@ static struct omap_hwmod_class omap44xx_usb_host_fs_hwmod_class = {
 };
 
 /* usb_host_fs */
-static struct omap_hwmod_irq_info omap44xx_usb_host_fs_irqs[] = {
-	{ .name = "std", .irq = 89 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "smi", .irq = 90 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_usb_host_fs_hwmod = {
 	.name		= "usb_host_fs",
 	.class		= &omap44xx_usb_host_fs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.mpu_irqs	= omap44xx_usb_host_fs_irqs,
 	.main_clk	= "usb_host_fs_fck",
 	.prcm = {
 		.omap4 = {
@@ -3346,11 +2969,6 @@ static struct omap_hwmod_class omap44xx_usb_host_hs_hwmod_class = {
 };
 
 /* usb_host_hs */
-static struct omap_hwmod_irq_info omap44xx_usb_host_hs_irqs[] = {
-	{ .name = "ohci-irq", .irq = 76 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "ehci-irq", .irq = 77 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_usb_host_hs_hwmod = {
 	.name		= "usb_host_hs",
@@ -3364,7 +2982,6 @@ static struct omap_hwmod omap44xx_usb_host_hs_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.mpu_irqs	= omap44xx_usb_host_hs_irqs,
 
 	/*
 	 * Errata: USBHOST Configured In Smart-Idle Can Lead To a Deadlock
@@ -3439,11 +3056,6 @@ static struct omap_hwmod_class omap44xx_usb_otg_hs_hwmod_class = {
 };
 
 /* usb_otg_hs */
-static struct omap_hwmod_irq_info omap44xx_usb_otg_hs_irqs[] = {
-	{ .name = "mc", .irq = 92 + OMAP44XX_IRQ_GIC_START },
-	{ .name = "dma", .irq = 93 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_opt_clk usb_otg_hs_opt_clks[] = {
 	{ .role = "xclk", .clk = "usb_otg_hs_xclk" },
@@ -3454,7 +3066,6 @@ static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
 	.class		= &omap44xx_usb_otg_hs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
-	.mpu_irqs	= omap44xx_usb_otg_hs_irqs,
 	.main_clk	= "usb_otg_hs_ick",
 	.prcm = {
 		.omap4 = {
@@ -3488,16 +3099,11 @@ static struct omap_hwmod_class omap44xx_usb_tll_hs_hwmod_class = {
 	.sysc	= &omap44xx_usb_tll_hs_sysc,
 };
 
-static struct omap_hwmod_irq_info omap44xx_usb_tll_hs_irqs[] = {
-	{ .name = "tll-irq", .irq = 78 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_usb_tll_hs_hwmod = {
 	.name		= "usb_tll_hs",
 	.class		= &omap44xx_usb_tll_hs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.mpu_irqs	= omap44xx_usb_tll_hs_irqs,
 	.main_clk	= "usb_tll_hs_ick",
 	.prcm = {
 		.omap4 = {
@@ -3533,16 +3139,11 @@ static struct omap_hwmod_class omap44xx_wd_timer_hwmod_class = {
 };
 
 /* wd_timer2 */
-static struct omap_hwmod_irq_info omap44xx_wd_timer2_irqs[] = {
-	{ .irq = 80 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
 	.name		= "wd_timer2",
 	.class		= &omap44xx_wd_timer_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.mpu_irqs	= omap44xx_wd_timer2_irqs,
 	.main_clk	= "wd_timer2_fck",
 	.prcm = {
 		.omap4 = {
@@ -3554,16 +3155,11 @@ static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
 };
 
 /* wd_timer3 */
-static struct omap_hwmod_irq_info omap44xx_wd_timer3_irqs[] = {
-	{ .irq = 36 + OMAP44XX_IRQ_GIC_START },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
 	.name		= "wd_timer3",
 	.class		= &omap44xx_wd_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.mpu_irqs	= omap44xx_wd_timer3_irqs,
 	.main_clk	= "wd_timer3_fck",
 	.prcm = {
 		.omap4 = {
@@ -3579,21 +3175,12 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
  * interfaces
  */
 
-static struct omap_hwmod_addr_space omap44xx_c2c_target_fw_addrs[] = {
-	{
-		.pa_start	= 0x4a204000,
-		.pa_end		= 0x4a2040ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* c2c -> c2c_target_fw */
 static struct omap_hwmod_ocp_if omap44xx_c2c__c2c_target_fw = {
 	.master		= &omap44xx_c2c_hwmod,
 	.slave		= &omap44xx_c2c_target_fw_hwmod,
 	.clk		= "div_core_ck",
-	.addr		= omap44xx_c2c_target_fw_addrs,
 	.user		= OCP_USER_MPU,
 };
 
@@ -3613,21 +3200,12 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_1__dmm = {
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dmm_addrs[] = {
-	{
-		.pa_start	= 0x4e000000,
-		.pa_end		= 0x4e0007ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* mpu -> dmm */
 static struct omap_hwmod_ocp_if omap44xx_mpu__dmm = {
 	.master		= &omap44xx_mpu_hwmod,
 	.slave		= &omap44xx_dmm_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_dmm_addrs,
 	.user		= OCP_USER_MPU,
 };
 
@@ -3647,21 +3225,12 @@ static struct omap_hwmod_ocp_if omap44xx_dmm__emif_fw = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_emif_fw_addrs[] = {
-	{
-		.pa_start	= 0x4a20c000,
-		.pa_end		= 0x4a20c0ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_cfg -> emif_fw */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__emif_fw = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_emif_fw_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_emif_fw_addrs,
 	.user		= OCP_USER_MPU,
 };
 
@@ -3737,21 +3306,12 @@ static struct omap_hwmod_ocp_if omap44xx_mmc2__l3_main_1 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_l3_main_1_addrs[] = {
-	{
-		.pa_start	= 0x44000000,
-		.pa_end		= 0x44000fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* mpu -> l3_main_1 */
 static struct omap_hwmod_ocp_if omap44xx_mpu__l3_main_1 = {
 	.master		= &omap44xx_mpu_hwmod,
 	.slave		= &omap44xx_l3_main_1_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_l3_main_1_addrs,
 	.user		= OCP_USER_MPU,
 };
 
@@ -3827,21 +3387,12 @@ static struct omap_hwmod_ocp_if omap44xx_iva__l3_main_2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_l3_main_2_addrs[] = {
-	{
-		.pa_start	= 0x44800000,
-		.pa_end		= 0x44801fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l3_main_1 -> l3_main_2 */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_2 = {
 	.master		= &omap44xx_l3_main_1_hwmod,
 	.slave		= &omap44xx_l3_main_2_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_l3_main_2_addrs,
 	.user		= OCP_USER_MPU,
 };
 
@@ -3877,21 +3428,12 @@ static struct omap_hwmod_ocp_if omap44xx_usb_otg_hs__l3_main_2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_l3_main_3_addrs[] = {
-	{
-		.pa_start	= 0x45000000,
-		.pa_end		= 0x45000fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l3_main_1 -> l3_main_3 */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_1__l3_main_3 = {
 	.master		= &omap44xx_l3_main_1_hwmod,
 	.slave		= &omap44xx_l3_main_3_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_l3_main_3_addrs,
 	.user		= OCP_USER_MPU,
 };
 
@@ -3975,57 +3517,30 @@ static struct omap_hwmod_ocp_if omap44xx_mpu__mpu_private = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_ocp_wp_noc_addrs[] = {
-	{
-		.pa_start	= 0x4a102000,
-		.pa_end		= 0x4a10207f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_cfg -> ocp_wp_noc */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp_wp_noc = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_ocp_wp_noc_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_ocp_wp_noc_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_aess_addrs[] = {
-	{
-		.pa_start	= 0x401f1000,
-		.pa_end		= 0x401f13ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> aess */
 static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_abe__aess = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_aess_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_aess_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_aess_dma_addrs[] = {
-	{
-		.pa_start	= 0x490f1000,
-		.pa_end		= 0x490f13ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> aess (dma) */
 static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_abe__aess_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_aess_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_aess_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
@@ -4037,167 +3552,84 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__c2c = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_counter_32k_addrs[] = {
-	{
-		.pa_start	= 0x4a304000,
-		.pa_end		= 0x4a30401f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_wkup -> counter_32k */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__counter_32k = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_counter_32k_hwmod,
 	.clk		= "l4_wkup_clk_mux_ck",
-	.addr		= omap44xx_counter_32k_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_ctrl_module_core_addrs[] = {
-	{
-		.pa_start	= 0x4a002000,
-		.pa_end		= 0x4a0027ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_cfg -> ctrl_module_core */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ctrl_module_core = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_ctrl_module_core_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_ctrl_module_core_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_ctrl_module_pad_core_addrs[] = {
-	{
-		.pa_start	= 0x4a100000,
-		.pa_end		= 0x4a1007ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_cfg -> ctrl_module_pad_core */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ctrl_module_pad_core = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_ctrl_module_pad_core_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_ctrl_module_pad_core_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_ctrl_module_wkup_addrs[] = {
-	{
-		.pa_start	= 0x4a30c000,
-		.pa_end		= 0x4a30c7ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_wkup -> ctrl_module_wkup */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__ctrl_module_wkup = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_ctrl_module_wkup_hwmod,
 	.clk		= "l4_wkup_clk_mux_ck",
-	.addr		= omap44xx_ctrl_module_wkup_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_ctrl_module_pad_wkup_addrs[] = {
-	{
-		.pa_start	= 0x4a31e000,
-		.pa_end		= 0x4a31e7ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_wkup -> ctrl_module_pad_wkup */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__ctrl_module_pad_wkup = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_ctrl_module_pad_wkup_hwmod,
 	.clk		= "l4_wkup_clk_mux_ck",
-	.addr		= omap44xx_ctrl_module_pad_wkup_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_debugss_addrs[] = {
-	{
-		.pa_start	= 0x54160000,
-		.pa_end		= 0x54167fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l3_instr -> debugss */
 static struct omap_hwmod_ocp_if omap44xx_l3_instr__debugss = {
 	.master		= &omap44xx_l3_instr_hwmod,
 	.slave		= &omap44xx_debugss_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_debugss_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dma_system_addrs[] = {
-	{
-		.pa_start	= 0x4a056000,
-		.pa_end		= 0x4a056fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_cfg -> dma_system */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dma_system = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_dma_system_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dma_system_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dmic_addrs[] = {
-	{
-		.name		= "mpu",
-		.pa_start	= 0x4012e000,
-		.pa_end		= 0x4012e07f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> dmic */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_dmic_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_dmic_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dmic_dma_addrs[] = {
-	{
-		.name		= "dma",
-		.pa_start	= 0x4902e000,
-		.pa_end		= 0x4902e07f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> dmic (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__dmic_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_dmic_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_dmic_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
@@ -4225,579 +3657,291 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__dsp = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_dma_addrs[] = {
-	{
-		.pa_start	= 0x58000000,
-		.pa_end		= 0x5800007f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l3_main_2 -> dss */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_hwmod,
 	.clk		= "dss_fck",
-	.addr		= omap44xx_dss_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_addrs[] = {
-	{
-		.pa_start	= 0x48040000,
-		.pa_end		= 0x4804007f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> dss */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_dss_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dss_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_dispc_dma_addrs[] = {
-	{
-		.pa_start	= 0x58001000,
-		.pa_end		= 0x58001fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l3_main_2 -> dss_dispc */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dispc = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_dispc_hwmod,
 	.clk		= "dss_fck",
-	.addr		= omap44xx_dss_dispc_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_dispc_addrs[] = {
-	{
-		.pa_start	= 0x48041000,
-		.pa_end		= 0x48041fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> dss_dispc */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_dispc = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_dss_dispc_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dss_dispc_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_dsi1_dma_addrs[] = {
-	{
-		.pa_start	= 0x58004000,
-		.pa_end		= 0x580041ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l3_main_2 -> dss_dsi1 */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi1 = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_dsi1_hwmod,
 	.clk		= "dss_fck",
-	.addr		= omap44xx_dss_dsi1_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_dsi1_addrs[] = {
-	{
-		.pa_start	= 0x48044000,
-		.pa_end		= 0x480441ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> dss_dsi1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_dsi1 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_dss_dsi1_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dss_dsi1_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_dsi2_dma_addrs[] = {
-	{
-		.pa_start	= 0x58005000,
-		.pa_end		= 0x580051ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l3_main_2 -> dss_dsi2 */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_dsi2 = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_dsi2_hwmod,
 	.clk		= "dss_fck",
-	.addr		= omap44xx_dss_dsi2_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_dsi2_addrs[] = {
-	{
-		.pa_start	= 0x48045000,
-		.pa_end		= 0x480451ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> dss_dsi2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_dsi2 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_dss_dsi2_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dss_dsi2_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_hdmi_dma_addrs[] = {
-	{
-		.pa_start	= 0x58006000,
-		.pa_end		= 0x58006fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l3_main_2 -> dss_hdmi */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_hdmi = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_hdmi_hwmod,
 	.clk		= "dss_fck",
-	.addr		= omap44xx_dss_hdmi_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_hdmi_addrs[] = {
-	{
-		.pa_start	= 0x48046000,
-		.pa_end		= 0x48046fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> dss_hdmi */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_hdmi = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_dss_hdmi_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dss_hdmi_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_rfbi_dma_addrs[] = {
-	{
-		.pa_start	= 0x58002000,
-		.pa_end		= 0x580020ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l3_main_2 -> dss_rfbi */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_rfbi = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_rfbi_hwmod,
 	.clk		= "dss_fck",
-	.addr		= omap44xx_dss_rfbi_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_rfbi_addrs[] = {
-	{
-		.pa_start	= 0x48042000,
-		.pa_end		= 0x480420ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> dss_rfbi */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_rfbi = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_dss_rfbi_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dss_rfbi_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_venc_dma_addrs[] = {
-	{
-		.pa_start	= 0x58003000,
-		.pa_end		= 0x580030ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l3_main_2 -> dss_venc */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__dss_venc = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_dss_venc_hwmod,
 	.clk		= "dss_fck",
-	.addr		= omap44xx_dss_venc_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_dss_venc_addrs[] = {
-	{
-		.pa_start	= 0x48043000,
-		.pa_end		= 0x480430ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> dss_venc */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_venc = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_dss_venc_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_dss_venc_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_elm_addrs[] = {
-	{
-		.pa_start	= 0x48078000,
-		.pa_end		= 0x48078fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> elm */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__elm = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_elm_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_elm_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_emif1_addrs[] = {
-	{
-		.pa_start	= 0x4c000000,
-		.pa_end		= 0x4c0000ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* emif_fw -> emif1 */
 static struct omap_hwmod_ocp_if omap44xx_emif_fw__emif1 = {
 	.master		= &omap44xx_emif_fw_hwmod,
 	.slave		= &omap44xx_emif1_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_emif1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_emif2_addrs[] = {
-	{
-		.pa_start	= 0x4d000000,
-		.pa_end		= 0x4d0000ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* emif_fw -> emif2 */
 static struct omap_hwmod_ocp_if omap44xx_emif_fw__emif2 = {
 	.master		= &omap44xx_emif_fw_hwmod,
 	.slave		= &omap44xx_emif2_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_emif2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_fdif_addrs[] = {
-	{
-		.pa_start	= 0x4a10a000,
-		.pa_end		= 0x4a10a1ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_cfg -> fdif */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__fdif = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_fdif_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_fdif_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_gpio1_addrs[] = {
-	{
-		.pa_start	= 0x4a310000,
-		.pa_end		= 0x4a3101ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_wkup -> gpio1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__gpio1 = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_gpio1_hwmod,
 	.clk		= "l4_wkup_clk_mux_ck",
-	.addr		= omap44xx_gpio1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_gpio2_addrs[] = {
-	{
-		.pa_start	= 0x48055000,
-		.pa_end		= 0x480551ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> gpio2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio2 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio2_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_gpio2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_gpio3_addrs[] = {
-	{
-		.pa_start	= 0x48057000,
-		.pa_end		= 0x480571ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> gpio3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio3 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio3_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_gpio3_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_gpio4_addrs[] = {
-	{
-		.pa_start	= 0x48059000,
-		.pa_end		= 0x480591ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> gpio4 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio4 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio4_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_gpio4_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_gpio5_addrs[] = {
-	{
-		.pa_start	= 0x4805b000,
-		.pa_end		= 0x4805b1ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> gpio5 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio5 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio5_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_gpio5_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_gpio6_addrs[] = {
-	{
-		.pa_start	= 0x4805d000,
-		.pa_end		= 0x4805d1ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> gpio6 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__gpio6 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_gpio6_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_gpio6_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_gpmc_addrs[] = {
-	{
-		.pa_start	= 0x50000000,
-		.pa_end		= 0x500003ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l3_main_2 -> gpmc */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__gpmc = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_gpmc_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_gpmc_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_gpu_addrs[] = {
-	{
-		.pa_start	= 0x56000000,
-		.pa_end		= 0x5600ffff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l3_main_2 -> gpu */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__gpu = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_gpu_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_gpu_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_hdq1w_addrs[] = {
-	{
-		.pa_start	= 0x480b2000,
-		.pa_end		= 0x480b201f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> hdq1w */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__hdq1w = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_hdq1w_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_hdq1w_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_hsi_addrs[] = {
-	{
-		.pa_start	= 0x4a058000,
-		.pa_end		= 0x4a05bfff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_cfg -> hsi */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__hsi = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_hsi_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_hsi_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_i2c1_addrs[] = {
-	{
-		.pa_start	= 0x48070000,
-		.pa_end		= 0x480700ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> i2c1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c1 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_i2c1_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_i2c1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_i2c2_addrs[] = {
-	{
-		.pa_start	= 0x48072000,
-		.pa_end		= 0x480720ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> i2c2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c2 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_i2c2_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_i2c2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_i2c3_addrs[] = {
-	{
-		.pa_start	= 0x48060000,
-		.pa_end		= 0x480600ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> i2c3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c3 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_i2c3_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_i2c3_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_i2c4_addrs[] = {
-	{
-		.pa_start	= 0x48350000,
-		.pa_end		= 0x483500ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> i2c4 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__i2c4 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_i2c4_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_i2c4_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -4809,21 +3953,12 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__ipu = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_iss_addrs[] = {
-	{
-		.pa_start	= 0x52000000,
-		.pa_end		= 0x520000ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l3_main_2 -> iss */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__iss = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_iss_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_iss_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -4835,423 +3970,210 @@ static struct omap_hwmod_ocp_if omap44xx_iva__sl2if = {
 	.user		= OCP_USER_IVA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_iva_addrs[] = {
-	{
-		.pa_start	= 0x5a000000,
-		.pa_end		= 0x5a07ffff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l3_main_2 -> iva */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__iva = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_iva_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_iva_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_kbd_addrs[] = {
-	{
-		.pa_start	= 0x4a31c000,
-		.pa_end		= 0x4a31c07f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_wkup -> kbd */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__kbd = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_kbd_hwmod,
 	.clk		= "l4_wkup_clk_mux_ck",
-	.addr		= omap44xx_kbd_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mailbox_addrs[] = {
-	{
-		.pa_start	= 0x4a0f4000,
-		.pa_end		= 0x4a0f41ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_cfg -> mailbox */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__mailbox = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_mailbox_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_mailbox_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcasp_addrs[] = {
-	{
-		.pa_start	= 0x40128000,
-		.pa_end		= 0x401283ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> mcasp */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcasp = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcasp_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_mcasp_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcasp_dma_addrs[] = {
-	{
-		.pa_start	= 0x49028000,
-		.pa_end		= 0x490283ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> mcasp (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcasp_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcasp_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_mcasp_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcbsp1_addrs[] = {
-	{
-		.name		= "mpu",
-		.pa_start	= 0x40122000,
-		.pa_end		= 0x401220ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> mcbsp1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp1 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcbsp1_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_mcbsp1_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcbsp1_dma_addrs[] = {
-	{
-		.name		= "dma",
-		.pa_start	= 0x49022000,
-		.pa_end		= 0x490220ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> mcbsp1 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp1_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcbsp1_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_mcbsp1_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcbsp2_addrs[] = {
-	{
-		.name		= "mpu",
-		.pa_start	= 0x40124000,
-		.pa_end		= 0x401240ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> mcbsp2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp2 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcbsp2_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_mcbsp2_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcbsp2_dma_addrs[] = {
-	{
-		.name		= "dma",
-		.pa_start	= 0x49024000,
-		.pa_end		= 0x490240ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> mcbsp2 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp2_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcbsp2_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_mcbsp2_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcbsp3_addrs[] = {
-	{
-		.name		= "mpu",
-		.pa_start	= 0x40126000,
-		.pa_end		= 0x401260ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> mcbsp3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp3 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcbsp3_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_mcbsp3_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcbsp3_dma_addrs[] = {
-	{
-		.name		= "dma",
-		.pa_start	= 0x49026000,
-		.pa_end		= 0x490260ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> mcbsp3 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcbsp3_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcbsp3_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_mcbsp3_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcbsp4_addrs[] = {
-	{
-		.pa_start	= 0x48096000,
-		.pa_end		= 0x480960ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> mcbsp4 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mcbsp4 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_mcbsp4_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_mcbsp4_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcpdm_addrs[] = {
-	{
-		.pa_start	= 0x40132000,
-		.pa_end		= 0x4013207f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> mcpdm */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcpdm = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcpdm_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_mcpdm_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcpdm_dma_addrs[] = {
-	{
-		.pa_start	= 0x49032000,
-		.pa_end		= 0x4903207f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> mcpdm (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__mcpdm_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_mcpdm_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_mcpdm_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcspi1_addrs[] = {
-	{
-		.pa_start	= 0x48098000,
-		.pa_end		= 0x480981ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> mcspi1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi1 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_mcspi1_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_mcspi1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcspi2_addrs[] = {
-	{
-		.pa_start	= 0x4809a000,
-		.pa_end		= 0x4809a1ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> mcspi2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi2 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_mcspi2_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_mcspi2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcspi3_addrs[] = {
-	{
-		.pa_start	= 0x480b8000,
-		.pa_end		= 0x480b81ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> mcspi3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi3 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_mcspi3_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_mcspi3_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mcspi4_addrs[] = {
-	{
-		.pa_start	= 0x480ba000,
-		.pa_end		= 0x480ba1ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> mcspi4 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mcspi4 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_mcspi4_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_mcspi4_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mmc1_addrs[] = {
-	{
-		.pa_start	= 0x4809c000,
-		.pa_end		= 0x4809c3ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> mmc1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc1 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_mmc1_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_mmc1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mmc2_addrs[] = {
-	{
-		.pa_start	= 0x480b4000,
-		.pa_end		= 0x480b43ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> mmc2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc2 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_mmc2_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_mmc2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mmc3_addrs[] = {
-	{
-		.pa_start	= 0x480ad000,
-		.pa_end		= 0x480ad3ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> mmc3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc3 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_mmc3_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_mmc3_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mmc4_addrs[] = {
-	{
-		.pa_start	= 0x480d1000,
-		.pa_end		= 0x480d13ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> mmc4 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc4 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_mmc4_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_mmc4_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_mmc5_addrs[] = {
-	{
-		.pa_start	= 0x480d5000,
-		.pa_end		= 0x480d53ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> mmc5 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__mmc5 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_mmc5_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_mmc5_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -5271,93 +4193,48 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__ocp2scp_usb_phy = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_prcm_mpu_addrs[] = {
-	{
-		.pa_start	= 0x48243000,
-		.pa_end		= 0x48243fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* mpu_private -> prcm_mpu */
 static struct omap_hwmod_ocp_if omap44xx_mpu_private__prcm_mpu = {
 	.master		= &omap44xx_mpu_private_hwmod,
 	.slave		= &omap44xx_prcm_mpu_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_prcm_mpu_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_cm_core_aon_addrs[] = {
-	{
-		.pa_start	= 0x4a004000,
-		.pa_end		= 0x4a004fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_wkup -> cm_core_aon */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__cm_core_aon = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_cm_core_aon_hwmod,
 	.clk		= "l4_wkup_clk_mux_ck",
-	.addr		= omap44xx_cm_core_aon_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_cm_core_addrs[] = {
-	{
-		.pa_start	= 0x4a008000,
-		.pa_end		= 0x4a009fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_cfg -> cm_core */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__cm_core = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_cm_core_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_cm_core_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_prm_addrs[] = {
-	{
-		.pa_start	= 0x4a306000,
-		.pa_end		= 0x4a307fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_wkup -> prm */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__prm = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_prm_hwmod,
 	.clk		= "l4_wkup_clk_mux_ck",
-	.addr		= omap44xx_prm_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_scrm_addrs[] = {
-	{
-		.pa_start	= 0x4a30a000,
-		.pa_end		= 0x4a30a7ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_wkup -> scrm */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__scrm = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_scrm_hwmod,
 	.clk		= "l4_wkup_clk_mux_ck",
-	.addr		= omap44xx_scrm_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -5369,609 +4246,300 @@ static struct omap_hwmod_ocp_if omap44xx_l3_main_2__sl2if = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_slimbus1_addrs[] = {
-	{
-		.pa_start	= 0x4012c000,
-		.pa_end		= 0x4012c3ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> slimbus1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__slimbus1 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_slimbus1_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_slimbus1_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_slimbus1_dma_addrs[] = {
-	{
-		.pa_start	= 0x4902c000,
-		.pa_end		= 0x4902c3ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> slimbus1 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__slimbus1_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_slimbus1_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_slimbus1_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_slimbus2_addrs[] = {
-	{
-		.pa_start	= 0x48076000,
-		.pa_end		= 0x480763ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> slimbus2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__slimbus2 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_slimbus2_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_slimbus2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_smartreflex_core_addrs[] = {
-	{
-		.pa_start	= 0x4a0dd000,
-		.pa_end		= 0x4a0dd03f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_cfg -> smartreflex_core */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_core = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_smartreflex_core_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_smartreflex_core_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_smartreflex_iva_addrs[] = {
-	{
-		.pa_start	= 0x4a0db000,
-		.pa_end		= 0x4a0db03f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_cfg -> smartreflex_iva */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_iva = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_smartreflex_iva_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_smartreflex_iva_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_smartreflex_mpu_addrs[] = {
-	{
-		.pa_start	= 0x4a0d9000,
-		.pa_end		= 0x4a0d903f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_cfg -> smartreflex_mpu */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_mpu = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_smartreflex_mpu_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_smartreflex_mpu_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_spinlock_addrs[] = {
-	{
-		.pa_start	= 0x4a0f6000,
-		.pa_end		= 0x4a0f6fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_cfg -> spinlock */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__spinlock = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_spinlock_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_spinlock_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_timer1_addrs[] = {
-	{
-		.pa_start	= 0x4a318000,
-		.pa_end		= 0x4a31807f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_wkup -> timer1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__timer1 = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_timer1_hwmod,
 	.clk		= "l4_wkup_clk_mux_ck",
-	.addr		= omap44xx_timer1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_timer2_addrs[] = {
-	{
-		.pa_start	= 0x48032000,
-		.pa_end		= 0x4803207f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> timer2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__timer2 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_timer2_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_timer2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_timer3_addrs[] = {
-	{
-		.pa_start	= 0x48034000,
-		.pa_end		= 0x4803407f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> timer3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__timer3 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_timer3_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_timer3_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_timer4_addrs[] = {
-	{
-		.pa_start	= 0x48036000,
-		.pa_end		= 0x4803607f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> timer4 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__timer4 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_timer4_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_timer4_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_timer5_addrs[] = {
-	{
-		.pa_start	= 0x40138000,
-		.pa_end		= 0x4013807f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> timer5 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer5 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_timer5_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_timer5_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_timer5_dma_addrs[] = {
-	{
-		.pa_start	= 0x49038000,
-		.pa_end		= 0x4903807f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> timer5 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer5_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_timer5_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_timer5_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_timer6_addrs[] = {
-	{
-		.pa_start	= 0x4013a000,
-		.pa_end		= 0x4013a07f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> timer6 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer6 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_timer6_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_timer6_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_timer6_dma_addrs[] = {
-	{
-		.pa_start	= 0x4903a000,
-		.pa_end		= 0x4903a07f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> timer6 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer6_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_timer6_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_timer6_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_timer7_addrs[] = {
-	{
-		.pa_start	= 0x4013c000,
-		.pa_end		= 0x4013c07f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> timer7 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer7 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_timer7_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_timer7_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_timer7_dma_addrs[] = {
-	{
-		.pa_start	= 0x4903c000,
-		.pa_end		= 0x4903c07f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> timer7 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer7_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_timer7_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_timer7_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_timer8_addrs[] = {
-	{
-		.pa_start	= 0x4013e000,
-		.pa_end		= 0x4013e07f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> timer8 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer8 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_timer8_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_timer8_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_timer8_dma_addrs[] = {
-	{
-		.pa_start	= 0x4903e000,
-		.pa_end		= 0x4903e07f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> timer8 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__timer8_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_timer8_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_timer8_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_timer9_addrs[] = {
-	{
-		.pa_start	= 0x4803e000,
-		.pa_end		= 0x4803e07f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> timer9 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__timer9 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_timer9_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_timer9_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_timer10_addrs[] = {
-	{
-		.pa_start	= 0x48086000,
-		.pa_end		= 0x4808607f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> timer10 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__timer10 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_timer10_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_timer10_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_timer11_addrs[] = {
-	{
-		.pa_start	= 0x48088000,
-		.pa_end		= 0x4808807f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> timer11 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__timer11 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_timer11_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_timer11_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_uart1_addrs[] = {
-	{
-		.pa_start	= 0x4806a000,
-		.pa_end		= 0x4806a0ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> uart1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__uart1 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_uart1_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_uart1_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_uart2_addrs[] = {
-	{
-		.pa_start	= 0x4806c000,
-		.pa_end		= 0x4806c0ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> uart2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__uart2 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_uart2_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_uart2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_uart3_addrs[] = {
-	{
-		.pa_start	= 0x48020000,
-		.pa_end		= 0x480200ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> uart3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__uart3 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_uart3_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_uart3_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_uart4_addrs[] = {
-	{
-		.pa_start	= 0x4806e000,
-		.pa_end		= 0x4806e0ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_per -> uart4 */
 static struct omap_hwmod_ocp_if omap44xx_l4_per__uart4 = {
 	.master		= &omap44xx_l4_per_hwmod,
 	.slave		= &omap44xx_uart4_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_uart4_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_usb_host_fs_addrs[] = {
-	{
-		.pa_start	= 0x4a0a9000,
-		.pa_end		= 0x4a0a93ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_cfg -> usb_host_fs */
 static struct omap_hwmod_ocp_if __maybe_unused omap44xx_l4_cfg__usb_host_fs = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_usb_host_fs_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_usb_host_fs_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_usb_host_hs_addrs[] = {
-	{
-		.name		= "uhh",
-		.pa_start	= 0x4a064000,
-		.pa_end		= 0x4a0647ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{
-		.name		= "ohci",
-		.pa_start	= 0x4a064800,
-		.pa_end		= 0x4a064bff,
-	},
-	{
-		.name		= "ehci",
-		.pa_start	= 0x4a064c00,
-		.pa_end		= 0x4a064fff,
-	},
-	{}
-};
 
 /* l4_cfg -> usb_host_hs */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_host_hs = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_usb_host_hs_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_usb_host_hs_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_usb_otg_hs_addrs[] = {
-	{
-		.pa_start	= 0x4a0ab000,
-		.pa_end		= 0x4a0ab003,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_cfg -> usb_otg_hs */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_otg_hs = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_usb_otg_hs_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_usb_otg_hs_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_usb_tll_hs_addrs[] = {
-	{
-		.name		= "tll",
-		.pa_start	= 0x4a062000,
-		.pa_end		= 0x4a063fff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{}
-};
 
 /* l4_cfg -> usb_tll_hs */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__usb_tll_hs = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_usb_tll_hs_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_usb_tll_hs_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_wd_timer2_addrs[] = {
-	{
-		.pa_start	= 0x4a314000,
-		.pa_end		= 0x4a31407f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_wkup -> wd_timer2 */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__wd_timer2 = {
 	.master		= &omap44xx_l4_wkup_hwmod,
 	.slave		= &omap44xx_wd_timer2_hwmod,
 	.clk		= "l4_wkup_clk_mux_ck",
-	.addr		= omap44xx_wd_timer2_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space omap44xx_wd_timer3_addrs[] = {
-	{
-		.pa_start	= 0x40130000,
-		.pa_end		= 0x4013007f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> wd_timer3 */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3 = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_wd_timer3_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_wd_timer3_addrs,
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_addr_space omap44xx_wd_timer3_dma_addrs[] = {
-	{
-		.pa_start	= 0x49030000,
-		.pa_end		= 0x4903007f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
 
 /* l4_abe -> wd_timer3 (dma) */
 static struct omap_hwmod_ocp_if omap44xx_l4_abe__wd_timer3_dma = {
 	.master		= &omap44xx_l4_abe_hwmod,
 	.slave		= &omap44xx_wd_timer3_hwmod,
 	.clk		= "ocp_abe_iclk",
-	.addr		= omap44xx_wd_timer3_dma_addrs,
 	.user		= OCP_USER_SDMA,
 };
 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120907/15b11f38/attachment-0001.sig>
