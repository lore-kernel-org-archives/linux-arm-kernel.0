From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 26 Jan 2017 23:43:47 +0800
Subject: [PATCH v2 3/7] clk: sunxi-ng: add support for Allwinner H5 SoC
In-Reply-To: <20170126154353.55238-1-icenowy@aosc.xyz>
References: <20170126154353.55238-1-icenowy@aosc.xyz>
Message-ID: <20170126154353.55238-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H5 is a SoC that features a CCU like H3, but with MMC phase
clocks removed (for new MMC controller) and a new bus gate/reset
imported.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
A giant rewrite since v1.
It now do not use a dedicated driver for H5, but altered the CCU driver
of H3 to support H5.

 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 drivers/clk/sunxi-ng/Kconfig                       |   6 +-
 drivers/clk/sunxi-ng/Makefile                      |   2 +-
 .../sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} | 179 ++++++++++++++++++---
 .../sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} |  15 +-
 include/dt-bindings/clock/sun8i-h3-ccu.h           | 146 +----------------
 include/dt-bindings/clock/sunxi-h3-h5-ccu.h        | 148 +++++++++++++++++
 include/dt-bindings/reset/sun8i-h3-ccu.h           | 104 +-----------
 include/dt-bindings/reset/sunxi-h3-h5-ccu.h        | 106 ++++++++++++
 9 files changed, 431 insertions(+), 276 deletions(-)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} (80%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} (82%)
 mode change 100644 => 120000 include/dt-bindings/clock/sun8i-h3-ccu.h
 create mode 100644 include/dt-bindings/clock/sunxi-h3-h5-ccu.h
 mode change 100644 => 120000 include/dt-bindings/reset/sun8i-h3-ccu.h
 create mode 100644 include/dt-bindings/reset/sunxi-h3-h5-ccu.h

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index f6032cf63f12..a33a4a5ecffa 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -9,6 +9,7 @@ Required properties :
 		- "allwinner,sun8i-h3-ccu"
 		- "allwinner,sun8i-v3s-ccu"
 		- "allwinner,sun50i-a64-ccu"
+		- "allwinner,sun50i-h5-ccu"
 
 - reg: Must contain the registers base address and length
 - clocks: phandle to the oscillators feeding the CCU. Two are needed:
diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 71f11cd1647b..bdf18e846731 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -108,8 +108,8 @@ config SUN8I_A33_CCU
 	select SUNXI_CCU_PHASE
 	default MACH_SUN8I
 
-config SUN8I_H3_CCU
-	bool "Support for the Allwinner H3 CCU"
+config SUNXI_H3_H5_CCU
+	bool "Support for the Allwinner H3/H5 CCU"
 	select SUNXI_CCU_DIV
 	select SUNXI_CCU_NK
 	select SUNXI_CCU_NKM
@@ -117,7 +117,7 @@ config SUN8I_H3_CCU
 	select SUNXI_CCU_NM
 	select SUNXI_CCU_MP
 	select SUNXI_CCU_PHASE
-	default MACH_SUN8I
+	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
 
 config SUN8I_V3S_CCU
 	bool "Support for the Allwinner V3s CCU"
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index a8afdf9c7668..cdc3359abbfe 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -23,5 +23,5 @@ obj-$(CONFIG_SUN5I_CCU)		+= ccu-sun5i.o
 obj-$(CONFIG_SUN6I_A31_CCU)	+= ccu-sun6i-a31.o
 obj-$(CONFIG_SUN8I_A23_CCU)	+= ccu-sun8i-a23.o
 obj-$(CONFIG_SUN8I_A33_CCU)	+= ccu-sun8i-a33.o
-obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
+obj-$(CONFIG_SUNXI_H3_H5_CCU)	+= ccu-sunxi-h3-h5.o
 obj-$(CONFIG_SUN8I_V3S_CCU)	+= ccu-sun8i-v3s.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c
similarity index 80%
rename from drivers/clk/sunxi-ng/ccu-sun8i-h3.c
rename to drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c
index a26c8a19fe93..b7b9f85f5c9f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c
@@ -27,7 +27,7 @@
 #include "ccu_nm.h"
 #include "ccu_phase.h"
 
-#include "ccu-sun8i-h3.h"
+#include "ccu-sunxi-h3-h5.h"
 
 static SUNXI_CCU_NKMP_WITH_GATE_LOCK(pll_cpux_clk, "pll-cpux",
 				     "osc24M", 0x000,
@@ -47,7 +47,7 @@ static SUNXI_CCU_NKMP_WITH_GATE_LOCK(pll_cpux_clk, "pll-cpux",
  * We don't have any need for the variable divider for now, so we just
  * hardcode it to match with the clock names
  */
-#define SUN8I_H3_PLL_AUDIO_REG	0x008
+#define SUNXI_H3_H5_PLL_AUDIO_REG	0x008
 
 static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
 				   "osc24M", 0x008,
@@ -300,8 +300,10 @@ static SUNXI_CCU_GATE(bus_uart2_clk,	"bus-uart2",	"apb2",
 		      0x06c, BIT(18), 0);
 static SUNXI_CCU_GATE(bus_uart3_clk,	"bus-uart3",	"apb2",
 		      0x06c, BIT(19), 0);
-static SUNXI_CCU_GATE(bus_scr_clk,	"bus-scr",	"apb2",
+static SUNXI_CCU_GATE(bus_scr0_clk,	"bus-scr0",	"apb2",
 		      0x06c, BIT(20), 0);
+static SUNXI_CCU_GATE(bus_scr1_clk,	"bus-scr1",	"apb2",
+		      0x06c, BIT(21), 0);
 
 static SUNXI_CCU_GATE(bus_ephy_clk,	"bus-ephy",	"ahb1",
 		      0x070, BIT(0), 0);
@@ -484,7 +486,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(mbus_clk, "mbus", mbus_parents,
 static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
 			     0x1a0, 0, 3, BIT(31), 0);
 
-static struct ccu_common *sun8i_h3_ccu_clks[] = {
+static struct ccu_common *sunxi_h3_h5_ccu_clks[] = {
 	&pll_cpux_clk.common,
 	&pll_audio_base_clk.common,
 	&pll_video_clk.common,
@@ -546,7 +548,8 @@ static struct ccu_common *sun8i_h3_ccu_clks[] = {
 	&bus_uart1_clk.common,
 	&bus_uart2_clk.common,
 	&bus_uart3_clk.common,
-	&bus_scr_clk.common,
+	&bus_scr0_clk.common,
+	&bus_scr1_clk.common,
 	&bus_ephy_clk.common,
 	&bus_dbg_clk.common,
 	&ths_clk.common,
@@ -677,7 +680,7 @@ static struct clk_hw_onecell_data sun8i_h3_hw_clks = {
 		[CLK_BUS_UART1]		= &bus_uart1_clk.common.hw,
 		[CLK_BUS_UART2]		= &bus_uart2_clk.common.hw,
 		[CLK_BUS_UART3]		= &bus_uart3_clk.common.hw,
-		[CLK_BUS_SCR]		= &bus_scr_clk.common.hw,
+		[CLK_BUS_SCR0]		= &bus_scr0_clk.common.hw,
 		[CLK_BUS_EPHY]		= &bus_ephy_clk.common.hw,
 		[CLK_BUS_DBG]		= &bus_dbg_clk.common.hw,
 		[CLK_THS]		= &ths_clk.common.hw,
@@ -730,7 +733,123 @@ static struct clk_hw_onecell_data sun8i_h3_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun8i_h3_ccu_resets[] = {
+static struct clk_hw_onecell_data sun50i_h5_hw_clks = {
+	.hws	= {
+		[CLK_PLL_CPUX]		= &pll_cpux_clk.common.hw,
+		[CLK_PLL_AUDIO_BASE]	= &pll_audio_base_clk.common.hw,
+		[CLK_PLL_AUDIO]		= &pll_audio_clk.hw,
+		[CLK_PLL_AUDIO_2X]	= &pll_audio_2x_clk.hw,
+		[CLK_PLL_AUDIO_4X]	= &pll_audio_4x_clk.hw,
+		[CLK_PLL_AUDIO_8X]	= &pll_audio_8x_clk.hw,
+		[CLK_PLL_VIDEO]		= &pll_video_clk.common.hw,
+		[CLK_PLL_VE]		= &pll_ve_clk.common.hw,
+		[CLK_PLL_DDR]		= &pll_ddr_clk.common.hw,
+		[CLK_PLL_PERIPH0]	= &pll_periph0_clk.common.hw,
+		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.hw,
+		[CLK_PLL_GPU]		= &pll_gpu_clk.common.hw,
+		[CLK_PLL_PERIPH1]	= &pll_periph1_clk.common.hw,
+		[CLK_PLL_DE]		= &pll_de_clk.common.hw,
+		[CLK_CPUX]		= &cpux_clk.common.hw,
+		[CLK_AXI]		= &axi_clk.common.hw,
+		[CLK_AHB1]		= &ahb1_clk.common.hw,
+		[CLK_APB1]		= &apb1_clk.common.hw,
+		[CLK_APB2]		= &apb2_clk.common.hw,
+		[CLK_AHB2]		= &ahb2_clk.common.hw,
+		[CLK_BUS_CE]		= &bus_ce_clk.common.hw,
+		[CLK_BUS_DMA]		= &bus_dma_clk.common.hw,
+		[CLK_BUS_MMC0]		= &bus_mmc0_clk.common.hw,
+		[CLK_BUS_MMC1]		= &bus_mmc1_clk.common.hw,
+		[CLK_BUS_MMC2]		= &bus_mmc2_clk.common.hw,
+		[CLK_BUS_NAND]		= &bus_nand_clk.common.hw,
+		[CLK_BUS_DRAM]		= &bus_dram_clk.common.hw,
+		[CLK_BUS_EMAC]		= &bus_emac_clk.common.hw,
+		[CLK_BUS_TS]		= &bus_ts_clk.common.hw,
+		[CLK_BUS_HSTIMER]	= &bus_hstimer_clk.common.hw,
+		[CLK_BUS_SPI0]		= &bus_spi0_clk.common.hw,
+		[CLK_BUS_SPI1]		= &bus_spi1_clk.common.hw,
+		[CLK_BUS_OTG]		= &bus_otg_clk.common.hw,
+		[CLK_BUS_EHCI0]		= &bus_ehci0_clk.common.hw,
+		[CLK_BUS_EHCI1]		= &bus_ehci1_clk.common.hw,
+		[CLK_BUS_EHCI2]		= &bus_ehci2_clk.common.hw,
+		[CLK_BUS_EHCI3]		= &bus_ehci3_clk.common.hw,
+		[CLK_BUS_OHCI0]		= &bus_ohci0_clk.common.hw,
+		[CLK_BUS_OHCI1]		= &bus_ohci1_clk.common.hw,
+		[CLK_BUS_OHCI2]		= &bus_ohci2_clk.common.hw,
+		[CLK_BUS_OHCI3]		= &bus_ohci3_clk.common.hw,
+		[CLK_BUS_VE]		= &bus_ve_clk.common.hw,
+		[CLK_BUS_TCON0]		= &bus_tcon0_clk.common.hw,
+		[CLK_BUS_TCON1]		= &bus_tcon1_clk.common.hw,
+		[CLK_BUS_DEINTERLACE]	= &bus_deinterlace_clk.common.hw,
+		[CLK_BUS_CSI]		= &bus_csi_clk.common.hw,
+		[CLK_BUS_TVE]		= &bus_tve_clk.common.hw,
+		[CLK_BUS_HDMI]		= &bus_hdmi_clk.common.hw,
+		[CLK_BUS_DE]		= &bus_de_clk.common.hw,
+		[CLK_BUS_GPU]		= &bus_gpu_clk.common.hw,
+		[CLK_BUS_MSGBOX]	= &bus_msgbox_clk.common.hw,
+		[CLK_BUS_SPINLOCK]	= &bus_spinlock_clk.common.hw,
+		[CLK_BUS_CODEC]		= &bus_codec_clk.common.hw,
+		[CLK_BUS_SPDIF]		= &bus_spdif_clk.common.hw,
+		[CLK_BUS_PIO]		= &bus_pio_clk.common.hw,
+		[CLK_BUS_THS]		= &bus_ths_clk.common.hw,
+		[CLK_BUS_I2S0]		= &bus_i2s0_clk.common.hw,
+		[CLK_BUS_I2S1]		= &bus_i2s1_clk.common.hw,
+		[CLK_BUS_I2S2]		= &bus_i2s2_clk.common.hw,
+		[CLK_BUS_I2C0]		= &bus_i2c0_clk.common.hw,
+		[CLK_BUS_I2C1]		= &bus_i2c1_clk.common.hw,
+		[CLK_BUS_I2C2]		= &bus_i2c2_clk.common.hw,
+		[CLK_BUS_UART0]		= &bus_uart0_clk.common.hw,
+		[CLK_BUS_UART1]		= &bus_uart1_clk.common.hw,
+		[CLK_BUS_UART2]		= &bus_uart2_clk.common.hw,
+		[CLK_BUS_UART3]		= &bus_uart3_clk.common.hw,
+		[CLK_BUS_SCR0]		= &bus_scr0_clk.common.hw,
+		[CLK_BUS_SCR1]		= &bus_scr1_clk.common.hw,
+		[CLK_BUS_EPHY]		= &bus_ephy_clk.common.hw,
+		[CLK_BUS_DBG]		= &bus_dbg_clk.common.hw,
+		[CLK_THS]		= &ths_clk.common.hw,
+		[CLK_NAND]		= &nand_clk.common.hw,
+		[CLK_MMC0]		= &mmc0_clk.common.hw,
+		[CLK_MMC1]		= &mmc1_clk.common.hw,
+		[CLK_MMC2]		= &mmc2_clk.common.hw,
+		[CLK_TS]		= &ts_clk.common.hw,
+		[CLK_CE]		= &ce_clk.common.hw,
+		[CLK_SPI0]		= &spi0_clk.common.hw,
+		[CLK_SPI1]		= &spi1_clk.common.hw,
+		[CLK_I2S0]		= &i2s0_clk.common.hw,
+		[CLK_I2S1]		= &i2s1_clk.common.hw,
+		[CLK_I2S2]		= &i2s2_clk.common.hw,
+		[CLK_SPDIF]		= &spdif_clk.common.hw,
+		[CLK_USB_PHY0]		= &usb_phy0_clk.common.hw,
+		[CLK_USB_PHY1]		= &usb_phy1_clk.common.hw,
+		[CLK_USB_PHY2]		= &usb_phy2_clk.common.hw,
+		[CLK_USB_PHY3]		= &usb_phy3_clk.common.hw,
+		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
+		[CLK_USB_OHCI1]		= &usb_ohci1_clk.common.hw,
+		[CLK_USB_OHCI2]		= &usb_ohci2_clk.common.hw,
+		[CLK_USB_OHCI3]		= &usb_ohci3_clk.common.hw,
+		[CLK_DRAM]		= &dram_clk.common.hw,
+		[CLK_DRAM_VE]		= &dram_ve_clk.common.hw,
+		[CLK_DRAM_CSI]		= &dram_csi_clk.common.hw,
+		[CLK_DRAM_DEINTERLACE]	= &dram_deinterlace_clk.common.hw,
+		[CLK_DRAM_TS]		= &dram_ts_clk.common.hw,
+		[CLK_DE]		= &de_clk.common.hw,
+		[CLK_TCON0]		= &tcon_clk.common.hw,
+		[CLK_TVE]		= &tve_clk.common.hw,
+		[CLK_DEINTERLACE]	= &deinterlace_clk.common.hw,
+		[CLK_CSI_MISC]		= &csi_misc_clk.common.hw,
+		[CLK_CSI_SCLK]		= &csi_sclk_clk.common.hw,
+		[CLK_CSI_MCLK]		= &csi_mclk_clk.common.hw,
+		[CLK_VE]		= &ve_clk.common.hw,
+		[CLK_AC_DIG]		= &ac_dig_clk.common.hw,
+		[CLK_AVS]		= &avs_clk.common.hw,
+		[CLK_HDMI]		= &hdmi_clk.common.hw,
+		[CLK_HDMI_DDC]		= &hdmi_ddc_clk.common.hw,
+		[CLK_MBUS]		= &mbus_clk.common.hw,
+		[CLK_GPU]		= &gpu_clk.common.hw,
+	},
+	.num	= CLK_NUMBER,
+};
+
+static struct ccu_reset_map sunxi_h3_h5_ccu_resets[] = {
 	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
 	[RST_USB_PHY1]		=  { 0x0cc, BIT(1) },
 	[RST_USB_PHY2]		=  { 0x0cc, BIT(2) },
@@ -790,27 +909,39 @@ static struct ccu_reset_map sun8i_h3_ccu_resets[] = {
 	[RST_BUS_UART1]		=  { 0x2d8, BIT(17) },
 	[RST_BUS_UART2]		=  { 0x2d8, BIT(18) },
 	[RST_BUS_UART3]		=  { 0x2d8, BIT(19) },
-	[RST_BUS_SCR]		=  { 0x2d8, BIT(20) },
+	[RST_BUS_SCR0]		=  { 0x2d8, BIT(20) },
+	[RST_BUS_SCR1]		=  { 0x2d8, BIT(21) },
 };
 
 static const struct sunxi_ccu_desc sun8i_h3_ccu_desc = {
-	.ccu_clks	= sun8i_h3_ccu_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_ccu_clks),
+	.ccu_clks	= sunxi_h3_h5_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sunxi_h3_h5_ccu_clks),
 
 	.hw_clks	= &sun8i_h3_hw_clks,
 
-	.resets		= sun8i_h3_ccu_resets,
-	.num_resets	= ARRAY_SIZE(sun8i_h3_ccu_resets),
+	.resets		= sunxi_h3_h5_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sunxi_h3_h5_ccu_resets),
+};
+
+static const struct sunxi_ccu_desc sun50i_h5_ccu_desc = {
+	.ccu_clks	= sunxi_h3_h5_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sunxi_h3_h5_ccu_clks),
+
+	.hw_clks	= &sun50i_h5_hw_clks,
+
+	.resets		= sunxi_h3_h5_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sunxi_h3_h5_ccu_resets),
 };
 
-static struct ccu_mux_nb sun8i_h3_cpu_nb = {
+static struct ccu_mux_nb sunxi_h3_h5_cpu_nb = {
 	.common		= &cpux_clk.common,
 	.cm		= &cpux_clk.mux,
 	.delay_us	= 1, /* > 8 clock cycles at 24 MHz */
 	.bypass_index	= 1, /* index of 24 MHz oscillator */
 };
 
-static void __init sun8i_h3_ccu_setup(struct device_node *node)
+static void __init sunxi_h3_h5_ccu_init(struct device_node *node,
+				  const struct sunxi_ccu_desc *desc)
 {
 	void __iomem *reg;
 	u32 val;
@@ -823,14 +954,26 @@ static void __init sun8i_h3_ccu_setup(struct device_node *node)
 	}
 
 	/* Force the PLL-Audio-1x divider to 4 */
-	val = readl(reg + SUN8I_H3_PLL_AUDIO_REG);
+	val = readl(reg + SUNXI_H3_H5_PLL_AUDIO_REG);
 	val &= ~GENMASK(19, 16);
-	writel(val | (3 << 16), reg + SUN8I_H3_PLL_AUDIO_REG);
+	writel(val | (3 << 16), reg + SUNXI_H3_H5_PLL_AUDIO_REG);
 
-	sunxi_ccu_probe(node, reg, &sun8i_h3_ccu_desc);
+	sunxi_ccu_probe(node, reg, desc);
 
 	ccu_mux_notifier_register(pll_cpux_clk.common.hw.clk,
-				  &sun8i_h3_cpu_nb);
+				  &sunxi_h3_h5_cpu_nb);
+}
+
+static void __init sun8i_h3_ccu_setup(struct device_node *node)
+{
+	sunxi_h3_h5_ccu_init(node, &sun8i_h3_ccu_desc);
 }
 CLK_OF_DECLARE(sun8i_h3_ccu, "allwinner,sun8i-h3-ccu",
 	       sun8i_h3_ccu_setup);
+
+static void __init sun50i_h5_ccu_setup(struct device_node *node)
+{
+	sunxi_h3_h5_ccu_init(node, &sun50i_h5_ccu_desc);
+}
+CLK_OF_DECLARE(sun50i_h5_ccu, "allwinner,sun50i-h5-ccu",
+	       sun50i_h5_ccu_setup);
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h b/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.h
similarity index 82%
rename from drivers/clk/sunxi-ng/ccu-sun8i-h3.h
rename to drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.h
index 78be712c7487..e5a78cc66d6b 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h
+++ b/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.h
@@ -14,11 +14,11 @@
  * GNU General Public License for more details.
  */
 
-#ifndef _CCU_SUN8I_H3_H_
-#define _CCU_SUN8I_H3_H_
+#ifndef _CCU_SUNXI_H3_H5_H_
+#define _CCU_SUNXI_H3_H5_H_
 
-#include <dt-bindings/clock/sun8i-h3-ccu.h>
-#include <dt-bindings/reset/sun8i-h3-ccu.h>
+#include <dt-bindings/clock/sunxi-h3-h5-ccu.h>
+#include <dt-bindings/reset/sunxi-h3-h5-ccu.h>
 
 #define CLK_PLL_CPUX		0
 #define CLK_PLL_AUDIO_BASE	1
@@ -57,6 +57,9 @@
 
 /* And the GPU module clock is exported */
 
-#define CLK_NUMBER		(CLK_GPU + 1)
+/* New clocks imported in H5 */
+/* The SCR1 bus gate is exported */
 
-#endif /* _CCU_SUN8I_H3_H_ */
+#define CLK_NUMBER		(CLK_BUS_SCR1 + 1)
+
+#endif /* _CCU_SUNXI_H3_H5_H_ */
diff --git a/include/dt-bindings/clock/sun8i-h3-ccu.h b/include/dt-bindings/clock/sun8i-h3-ccu.h
deleted file mode 100644
index efb7ba2bd515..000000000000
--- a/include/dt-bindings/clock/sun8i-h3-ccu.h
+++ /dev/null
@@ -1,145 +0,0 @@
-/*
- * Copyright (C) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#ifndef _DT_BINDINGS_CLK_SUN8I_H3_H_
-#define _DT_BINDINGS_CLK_SUN8I_H3_H_
-
-#define CLK_CPUX		14
-
-#define CLK_BUS_CE		20
-#define CLK_BUS_DMA		21
-#define CLK_BUS_MMC0		22
-#define CLK_BUS_MMC1		23
-#define CLK_BUS_MMC2		24
-#define CLK_BUS_NAND		25
-#define CLK_BUS_DRAM		26
-#define CLK_BUS_EMAC		27
-#define CLK_BUS_TS		28
-#define CLK_BUS_HSTIMER		29
-#define CLK_BUS_SPI0		30
-#define CLK_BUS_SPI1		31
-#define CLK_BUS_OTG		32
-#define CLK_BUS_EHCI0		33
-#define CLK_BUS_EHCI1		34
-#define CLK_BUS_EHCI2		35
-#define CLK_BUS_EHCI3		36
-#define CLK_BUS_OHCI0		37
-#define CLK_BUS_OHCI1		38
-#define CLK_BUS_OHCI2		39
-#define CLK_BUS_OHCI3		40
-#define CLK_BUS_VE		41
-#define CLK_BUS_TCON0		42
-#define CLK_BUS_TCON1		43
-#define CLK_BUS_DEINTERLACE	44
-#define CLK_BUS_CSI		45
-#define CLK_BUS_TVE		46
-#define CLK_BUS_HDMI		47
-#define CLK_BUS_DE		48
-#define CLK_BUS_GPU		49
-#define CLK_BUS_MSGBOX		50
-#define CLK_BUS_SPINLOCK	51
-#define CLK_BUS_CODEC		52
-#define CLK_BUS_SPDIF		53
-#define CLK_BUS_PIO		54
-#define CLK_BUS_THS		55
-#define CLK_BUS_I2S0		56
-#define CLK_BUS_I2S1		57
-#define CLK_BUS_I2S2		58
-#define CLK_BUS_I2C0		59
-#define CLK_BUS_I2C1		60
-#define CLK_BUS_I2C2		61
-#define CLK_BUS_UART0		62
-#define CLK_BUS_UART1		63
-#define CLK_BUS_UART2		64
-#define CLK_BUS_UART3		65
-#define CLK_BUS_SCR		66
-#define CLK_BUS_EPHY		67
-#define CLK_BUS_DBG		68
-
-#define CLK_THS			69
-#define CLK_NAND		70
-#define CLK_MMC0		71
-#define CLK_MMC0_SAMPLE		72
-#define CLK_MMC0_OUTPUT		73
-#define CLK_MMC1		74
-#define CLK_MMC1_SAMPLE		75
-#define CLK_MMC1_OUTPUT		76
-#define CLK_MMC2		77
-#define CLK_MMC2_SAMPLE		78
-#define CLK_MMC2_OUTPUT		79
-#define CLK_TS			80
-#define CLK_CE			81
-#define CLK_SPI0		82
-#define CLK_SPI1		83
-#define CLK_I2S0		84
-#define CLK_I2S1		85
-#define CLK_I2S2		86
-#define CLK_SPDIF		87
-#define CLK_USB_PHY0		88
-#define CLK_USB_PHY1		89
-#define CLK_USB_PHY2		90
-#define CLK_USB_PHY3		91
-#define CLK_USB_OHCI0		92
-#define CLK_USB_OHCI1		93
-#define CLK_USB_OHCI2		94
-#define CLK_USB_OHCI3		95
-
-#define CLK_DRAM_VE		97
-#define CLK_DRAM_CSI		98
-#define CLK_DRAM_DEINTERLACE	99
-#define CLK_DRAM_TS		100
-#define CLK_DE			101
-#define CLK_TCON0		102
-#define CLK_TVE			103
-#define CLK_DEINTERLACE		104
-#define CLK_CSI_MISC		105
-#define CLK_CSI_SCLK		106
-#define CLK_CSI_MCLK		107
-#define CLK_VE			108
-#define CLK_AC_DIG		109
-#define CLK_AVS			110
-#define CLK_HDMI		111
-#define CLK_HDMI_DDC		112
-
-#define CLK_GPU			114
-
-#endif /* _DT_BINDINGS_CLK_SUN8I_H3_H_ */
diff --git a/include/dt-bindings/clock/sun8i-h3-ccu.h b/include/dt-bindings/clock/sun8i-h3-ccu.h
new file mode 120000
index 000000000000..ef38232141e4
--- /dev/null
+++ b/include/dt-bindings/clock/sun8i-h3-ccu.h
@@ -0,0 +1 @@
+sunxi-h3-h5-ccu.h
\ No newline at end of file
diff --git a/include/dt-bindings/clock/sunxi-h3-h5-ccu.h b/include/dt-bindings/clock/sunxi-h3-h5-ccu.h
new file mode 100644
index 000000000000..4899eacef71d
--- /dev/null
+++ b/include/dt-bindings/clock/sunxi-h3-h5-ccu.h
@@ -0,0 +1,148 @@
+/*
+ * Copyright (C) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SUNXI_H3_H5_H_
+#define _DT_BINDINGS_CLK_SUNXI_H3_H5_H_
+
+#define CLK_CPUX		14
+
+#define CLK_BUS_CE		20
+#define CLK_BUS_DMA		21
+#define CLK_BUS_MMC0		22
+#define CLK_BUS_MMC1		23
+#define CLK_BUS_MMC2		24
+#define CLK_BUS_NAND		25
+#define CLK_BUS_DRAM		26
+#define CLK_BUS_EMAC		27
+#define CLK_BUS_TS		28
+#define CLK_BUS_HSTIMER		29
+#define CLK_BUS_SPI0		30
+#define CLK_BUS_SPI1		31
+#define CLK_BUS_OTG		32
+#define CLK_BUS_EHCI0		33
+#define CLK_BUS_EHCI1		34
+#define CLK_BUS_EHCI2		35
+#define CLK_BUS_EHCI3		36
+#define CLK_BUS_OHCI0		37
+#define CLK_BUS_OHCI1		38
+#define CLK_BUS_OHCI2		39
+#define CLK_BUS_OHCI3		40
+#define CLK_BUS_VE		41
+#define CLK_BUS_TCON0		42
+#define CLK_BUS_TCON1		43
+#define CLK_BUS_DEINTERLACE	44
+#define CLK_BUS_CSI		45
+#define CLK_BUS_TVE		46
+#define CLK_BUS_HDMI		47
+#define CLK_BUS_DE		48
+#define CLK_BUS_GPU		49
+#define CLK_BUS_MSGBOX		50
+#define CLK_BUS_SPINLOCK	51
+#define CLK_BUS_CODEC		52
+#define CLK_BUS_SPDIF		53
+#define CLK_BUS_PIO		54
+#define CLK_BUS_THS		55
+#define CLK_BUS_I2S0		56
+#define CLK_BUS_I2S1		57
+#define CLK_BUS_I2S2		58
+#define CLK_BUS_I2C0		59
+#define CLK_BUS_I2C1		60
+#define CLK_BUS_I2C2		61
+#define CLK_BUS_UART0		62
+#define CLK_BUS_UART1		63
+#define CLK_BUS_UART2		64
+#define CLK_BUS_UART3		65
+#define CLK_BUS_SCR0		66
+#define CLK_BUS_EPHY		67
+#define CLK_BUS_DBG		68
+
+#define CLK_THS			69
+#define CLK_NAND		70
+#define CLK_MMC0		71
+#define CLK_MMC0_SAMPLE		72
+#define CLK_MMC0_OUTPUT		73
+#define CLK_MMC1		74
+#define CLK_MMC1_SAMPLE		75
+#define CLK_MMC1_OUTPUT		76
+#define CLK_MMC2		77
+#define CLK_MMC2_SAMPLE		78
+#define CLK_MMC2_OUTPUT		79
+#define CLK_TS			80
+#define CLK_CE			81
+#define CLK_SPI0		82
+#define CLK_SPI1		83
+#define CLK_I2S0		84
+#define CLK_I2S1		85
+#define CLK_I2S2		86
+#define CLK_SPDIF		87
+#define CLK_USB_PHY0		88
+#define CLK_USB_PHY1		89
+#define CLK_USB_PHY2		90
+#define CLK_USB_PHY3		91
+#define CLK_USB_OHCI0		92
+#define CLK_USB_OHCI1		93
+#define CLK_USB_OHCI2		94
+#define CLK_USB_OHCI3		95
+
+#define CLK_DRAM_VE		97
+#define CLK_DRAM_CSI		98
+#define CLK_DRAM_DEINTERLACE	99
+#define CLK_DRAM_TS		100
+#define CLK_DE			101
+#define CLK_TCON0		102
+#define CLK_TVE			103
+#define CLK_DEINTERLACE		104
+#define CLK_CSI_MISC		105
+#define CLK_CSI_SCLK		106
+#define CLK_CSI_MCLK		107
+#define CLK_VE			108
+#define CLK_AC_DIG		109
+#define CLK_AVS			110
+#define CLK_HDMI		111
+#define CLK_HDMI_DDC		112
+
+#define CLK_GPU			114
+
+/* New clocks imported in H5 */
+#define CLK_BUS_SCR1		115
+
+#endif /* _DT_BINDINGS_CLK_SUNXI_H3_H5_H_ */
diff --git a/include/dt-bindings/reset/sun8i-h3-ccu.h b/include/dt-bindings/reset/sun8i-h3-ccu.h
deleted file mode 100644
index 6b7af80c26ec..000000000000
--- a/include/dt-bindings/reset/sun8i-h3-ccu.h
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- * Copyright (C) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#ifndef _DT_BINDINGS_RST_SUN8I_H3_H_
-#define _DT_BINDINGS_RST_SUN8I_H3_H_
-
-#define RST_USB_PHY0		0
-#define RST_USB_PHY1		1
-#define RST_USB_PHY2		2
-#define RST_USB_PHY3		3
-
-#define RST_MBUS		4
-
-#define RST_BUS_CE		5
-#define RST_BUS_DMA		6
-#define RST_BUS_MMC0		7
-#define RST_BUS_MMC1		8
-#define RST_BUS_MMC2		9
-#define RST_BUS_NAND		10
-#define RST_BUS_DRAM		11
-#define RST_BUS_EMAC		12
-#define RST_BUS_TS		13
-#define RST_BUS_HSTIMER		14
-#define RST_BUS_SPI0		15
-#define RST_BUS_SPI1		16
-#define RST_BUS_OTG		17
-#define RST_BUS_EHCI0		18
-#define RST_BUS_EHCI1		19
-#define RST_BUS_EHCI2		20
-#define RST_BUS_EHCI3		21
-#define RST_BUS_OHCI0		22
-#define RST_BUS_OHCI1		23
-#define RST_BUS_OHCI2		24
-#define RST_BUS_OHCI3		25
-#define RST_BUS_VE		26
-#define RST_BUS_TCON0		27
-#define RST_BUS_TCON1		28
-#define RST_BUS_DEINTERLACE	29
-#define RST_BUS_CSI		30
-#define RST_BUS_TVE		31
-#define RST_BUS_HDMI0		32
-#define RST_BUS_HDMI1		33
-#define RST_BUS_DE		34
-#define RST_BUS_GPU		35
-#define RST_BUS_MSGBOX		36
-#define RST_BUS_SPINLOCK	37
-#define RST_BUS_DBG		38
-#define RST_BUS_EPHY		39
-#define RST_BUS_CODEC		40
-#define RST_BUS_SPDIF		41
-#define RST_BUS_THS		42
-#define RST_BUS_I2S0		43
-#define RST_BUS_I2S1		44
-#define RST_BUS_I2S2		45
-#define RST_BUS_I2C0		46
-#define RST_BUS_I2C1		47
-#define RST_BUS_I2C2		48
-#define RST_BUS_UART0		49
-#define RST_BUS_UART1		50
-#define RST_BUS_UART2		51
-#define RST_BUS_UART3		52
-#define RST_BUS_SCR		53
-
-#endif /* _DT_BINDINGS_RST_SUN8I_H3_H_ */
diff --git a/include/dt-bindings/reset/sun8i-h3-ccu.h b/include/dt-bindings/reset/sun8i-h3-ccu.h
new file mode 120000
index 000000000000..ef38232141e4
--- /dev/null
+++ b/include/dt-bindings/reset/sun8i-h3-ccu.h
@@ -0,0 +1 @@
+sunxi-h3-h5-ccu.h
\ No newline at end of file
diff --git a/include/dt-bindings/reset/sunxi-h3-h5-ccu.h b/include/dt-bindings/reset/sunxi-h3-h5-ccu.h
new file mode 100644
index 000000000000..1084c157c062
--- /dev/null
+++ b/include/dt-bindings/reset/sunxi-h3-h5-ccu.h
@@ -0,0 +1,106 @@
+/*
+ * Copyright (C) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef _DT_BINDINGS_RST_SUNXI_H3_H5_H_
+#define _DT_BINDINGS_RST_SUNXI_H3_H5_H_
+
+#define RST_USB_PHY0		0
+#define RST_USB_PHY1		1
+#define RST_USB_PHY2		2
+#define RST_USB_PHY3		3
+
+#define RST_MBUS		4
+
+#define RST_BUS_CE		5
+#define RST_BUS_DMA		6
+#define RST_BUS_MMC0		7
+#define RST_BUS_MMC1		8
+#define RST_BUS_MMC2		9
+#define RST_BUS_NAND		10
+#define RST_BUS_DRAM		11
+#define RST_BUS_EMAC		12
+#define RST_BUS_TS		13
+#define RST_BUS_HSTIMER		14
+#define RST_BUS_SPI0		15
+#define RST_BUS_SPI1		16
+#define RST_BUS_OTG		17
+#define RST_BUS_EHCI0		18
+#define RST_BUS_EHCI1		19
+#define RST_BUS_EHCI2		20
+#define RST_BUS_EHCI3		21
+#define RST_BUS_OHCI0		22
+#define RST_BUS_OHCI1		23
+#define RST_BUS_OHCI2		24
+#define RST_BUS_OHCI3		25
+#define RST_BUS_VE		26
+#define RST_BUS_TCON0		27
+#define RST_BUS_TCON1		28
+#define RST_BUS_DEINTERLACE	29
+#define RST_BUS_CSI		30
+#define RST_BUS_TVE		31
+#define RST_BUS_HDMI0		32
+#define RST_BUS_HDMI1		33
+#define RST_BUS_DE		34
+#define RST_BUS_GPU		35
+#define RST_BUS_MSGBOX		36
+#define RST_BUS_SPINLOCK	37
+#define RST_BUS_DBG		38
+#define RST_BUS_EPHY		39
+#define RST_BUS_CODEC		40
+#define RST_BUS_SPDIF		41
+#define RST_BUS_THS		42
+#define RST_BUS_I2S0		43
+#define RST_BUS_I2S1		44
+#define RST_BUS_I2S2		45
+#define RST_BUS_I2C0		46
+#define RST_BUS_I2C1		47
+#define RST_BUS_I2C2		48
+#define RST_BUS_UART0		49
+#define RST_BUS_UART1		50
+#define RST_BUS_UART2		51
+#define RST_BUS_UART3		52
+#define RST_BUS_SCR0		53
+
+/* New resets imported in H5 */
+#define RST_BUS_SCR1		54
+
+#endif /* _DT_BINDINGS_RST_SUNXI_H3_H5_H_ */
-- 
2.11.0
