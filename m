From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 8 Feb 2017 09:00:10 +0100
Subject: [PATCH v4 3/9] clk: sunxi-ng: add support for Allwinner H5 SoC
In-Reply-To: <20170207183042.62699-4-icenowy@aosc.xyz>
References: <20170207183042.62699-1-icenowy@aosc.xyz>
 <20170207183042.62699-4-icenowy@aosc.xyz>
Message-ID: <20170208080010.ntaavpe5wbipn4dl@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 08, 2017 at 02:30:36AM +0800, Icenowy Zheng wrote:
> Allwinner H5 is a SoC that features a CCU like H3, but with MMC phase
> clocks removed (for new MMC controller) and a new bus gate/reset
> imported.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes since v3:
> - Add a dedicated reset line list for H5, as SCR1 reset is not valid
>   on H3.
> 
>  .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
>  drivers/clk/sunxi-ng/Kconfig                       |   2 +-
>  drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c             | 206 ++++++++++++++++++++-
>  drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.h             |   5 +-
>  include/dt-bindings/clock/sunxi-h3-h5-ccu.h        |   3 +
>  include/dt-bindings/reset/sunxi-h3-h5-ccu.h        |   3 +
>  6 files changed, 215 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> index bae5668cf427..68512aa398a9 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> @@ -10,6 +10,7 @@ Required properties :
>  		- "allwinner,sun8i-v3s-ccu"
>  		- "allwinner,sun9i-a80-ccu"
>  		- "allwinner,sun50i-a64-ccu"
> +		- "allwinner,sun50i-h5-ccu"
>  
>  - reg: Must contain the registers base address and length
>  - clocks: phandle to the oscillators feeding the CCU. Two are needed:
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index edc5bbbcb5bb..ec3e5f56b6ec 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -117,7 +117,7 @@ config SUNXI_H3_H5_CCU
>  	select SUNXI_CCU_NM
>  	select SUNXI_CCU_MP
>  	select SUNXI_CCU_PHASE
> -	default MACH_SUN8I
> +	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
>  
>  config SUN8I_V3S_CCU
>  	bool "Support for the Allwinner V3s CCU"
> diff --git a/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c b/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c
> index e2d065973794..360709966e8f 100644
> --- a/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c
> +++ b/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c
> @@ -302,6 +302,8 @@ static SUNXI_CCU_GATE(bus_uart3_clk,	"bus-uart3",	"apb2",
>  		      0x06c, BIT(19), 0);
>  static SUNXI_CCU_GATE(bus_scr0_clk,	"bus-scr0",	"apb2",
>  		      0x06c, BIT(20), 0);
> +static SUNXI_CCU_GATE(bus_scr1_clk,	"bus-scr1",	"apb2",
> +		      0x06c, BIT(21), 0);
>  
>  static SUNXI_CCU_GATE(bus_ephy_clk,	"bus-ephy",	"ahb1",
>  		      0x070, BIT(0), 0);
> @@ -547,6 +549,7 @@ static struct ccu_common *sunxi_h3_h5_ccu_clks[] = {
>  	&bus_uart2_clk.common,
>  	&bus_uart3_clk.common,
>  	&bus_scr0_clk.common,
> +	&bus_scr1_clk.common,

There's only one SCR gate in the H3.

>  	&bus_ephy_clk.common,
>  	&bus_dbg_clk.common,
>  	&ths_clk.common,
> @@ -730,7 +733,186 @@ static struct clk_hw_onecell_data sun8i_h3_hw_clks = {
>  	.num	= CLK_NUMBER,
>  };
>  
> -static struct ccu_reset_map sunxi_h3_h5_ccu_resets[] = {
> +static struct clk_hw_onecell_data sun50i_h5_hw_clks = {
> +	.hws	= {
> +		[CLK_PLL_CPUX]		= &pll_cpux_clk.common.hw,
> +		[CLK_PLL_AUDIO_BASE]	= &pll_audio_base_clk.common.hw,
> +		[CLK_PLL_AUDIO]		= &pll_audio_clk.hw,
> +		[CLK_PLL_AUDIO_2X]	= &pll_audio_2x_clk.hw,
> +		[CLK_PLL_AUDIO_4X]	= &pll_audio_4x_clk.hw,
> +		[CLK_PLL_AUDIO_8X]	= &pll_audio_8x_clk.hw,
> +		[CLK_PLL_VIDEO]		= &pll_video_clk.common.hw,
> +		[CLK_PLL_VE]		= &pll_ve_clk.common.hw,
> +		[CLK_PLL_DDR]		= &pll_ddr_clk.common.hw,
> +		[CLK_PLL_PERIPH0]	= &pll_periph0_clk.common.hw,
> +		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.hw,
> +		[CLK_PLL_GPU]		= &pll_gpu_clk.common.hw,
> +		[CLK_PLL_PERIPH1]	= &pll_periph1_clk.common.hw,
> +		[CLK_PLL_DE]		= &pll_de_clk.common.hw,
> +		[CLK_CPUX]		= &cpux_clk.common.hw,
> +		[CLK_AXI]		= &axi_clk.common.hw,
> +		[CLK_AHB1]		= &ahb1_clk.common.hw,
> +		[CLK_APB1]		= &apb1_clk.common.hw,
> +		[CLK_APB2]		= &apb2_clk.common.hw,
> +		[CLK_AHB2]		= &ahb2_clk.common.hw,
> +		[CLK_BUS_CE]		= &bus_ce_clk.common.hw,
> +		[CLK_BUS_DMA]		= &bus_dma_clk.common.hw,
> +		[CLK_BUS_MMC0]		= &bus_mmc0_clk.common.hw,
> +		[CLK_BUS_MMC1]		= &bus_mmc1_clk.common.hw,
> +		[CLK_BUS_MMC2]		= &bus_mmc2_clk.common.hw,
> +		[CLK_BUS_NAND]		= &bus_nand_clk.common.hw,
> +		[CLK_BUS_DRAM]		= &bus_dram_clk.common.hw,
> +		[CLK_BUS_EMAC]		= &bus_emac_clk.common.hw,
> +		[CLK_BUS_TS]		= &bus_ts_clk.common.hw,
> +		[CLK_BUS_HSTIMER]	= &bus_hstimer_clk.common.hw,
> +		[CLK_BUS_SPI0]		= &bus_spi0_clk.common.hw,
> +		[CLK_BUS_SPI1]		= &bus_spi1_clk.common.hw,
> +		[CLK_BUS_OTG]		= &bus_otg_clk.common.hw,
> +		[CLK_BUS_EHCI0]		= &bus_ehci0_clk.common.hw,
> +		[CLK_BUS_EHCI1]		= &bus_ehci1_clk.common.hw,
> +		[CLK_BUS_EHCI2]		= &bus_ehci2_clk.common.hw,
> +		[CLK_BUS_EHCI3]		= &bus_ehci3_clk.common.hw,
> +		[CLK_BUS_OHCI0]		= &bus_ohci0_clk.common.hw,
> +		[CLK_BUS_OHCI1]		= &bus_ohci1_clk.common.hw,
> +		[CLK_BUS_OHCI2]		= &bus_ohci2_clk.common.hw,
> +		[CLK_BUS_OHCI3]		= &bus_ohci3_clk.common.hw,
> +		[CLK_BUS_VE]		= &bus_ve_clk.common.hw,
> +		[CLK_BUS_TCON0]		= &bus_tcon0_clk.common.hw,
> +		[CLK_BUS_TCON1]		= &bus_tcon1_clk.common.hw,
> +		[CLK_BUS_DEINTERLACE]	= &bus_deinterlace_clk.common.hw,
> +		[CLK_BUS_CSI]		= &bus_csi_clk.common.hw,
> +		[CLK_BUS_TVE]		= &bus_tve_clk.common.hw,
> +		[CLK_BUS_HDMI]		= &bus_hdmi_clk.common.hw,
> +		[CLK_BUS_DE]		= &bus_de_clk.common.hw,
> +		[CLK_BUS_GPU]		= &bus_gpu_clk.common.hw,
> +		[CLK_BUS_MSGBOX]	= &bus_msgbox_clk.common.hw,
> +		[CLK_BUS_SPINLOCK]	= &bus_spinlock_clk.common.hw,
> +		[CLK_BUS_CODEC]		= &bus_codec_clk.common.hw,
> +		[CLK_BUS_SPDIF]		= &bus_spdif_clk.common.hw,
> +		[CLK_BUS_PIO]		= &bus_pio_clk.common.hw,
> +		[CLK_BUS_THS]		= &bus_ths_clk.common.hw,
> +		[CLK_BUS_I2S0]		= &bus_i2s0_clk.common.hw,
> +		[CLK_BUS_I2S1]		= &bus_i2s1_clk.common.hw,
> +		[CLK_BUS_I2S2]		= &bus_i2s2_clk.common.hw,
> +		[CLK_BUS_I2C0]		= &bus_i2c0_clk.common.hw,
> +		[CLK_BUS_I2C1]		= &bus_i2c1_clk.common.hw,
> +		[CLK_BUS_I2C2]		= &bus_i2c2_clk.common.hw,
> +		[CLK_BUS_UART0]		= &bus_uart0_clk.common.hw,
> +		[CLK_BUS_UART1]		= &bus_uart1_clk.common.hw,
> +		[CLK_BUS_UART2]		= &bus_uart2_clk.common.hw,
> +		[CLK_BUS_UART3]		= &bus_uart3_clk.common.hw,
> +		[CLK_BUS_SCR0]		= &bus_scr0_clk.common.hw,
> +		[CLK_BUS_SCR1]		= &bus_scr1_clk.common.hw,
> +		[CLK_BUS_EPHY]		= &bus_ephy_clk.common.hw,
> +		[CLK_BUS_DBG]		= &bus_dbg_clk.common.hw,
> +		[CLK_THS]		= &ths_clk.common.hw,
> +		[CLK_NAND]		= &nand_clk.common.hw,
> +		[CLK_MMC0]		= &mmc0_clk.common.hw,
> +		[CLK_MMC1]		= &mmc1_clk.common.hw,
> +		[CLK_MMC2]		= &mmc2_clk.common.hw,
> +		[CLK_TS]		= &ts_clk.common.hw,
> +		[CLK_CE]		= &ce_clk.common.hw,
> +		[CLK_SPI0]		= &spi0_clk.common.hw,
> +		[CLK_SPI1]		= &spi1_clk.common.hw,
> +		[CLK_I2S0]		= &i2s0_clk.common.hw,
> +		[CLK_I2S1]		= &i2s1_clk.common.hw,
> +		[CLK_I2S2]		= &i2s2_clk.common.hw,
> +		[CLK_SPDIF]		= &spdif_clk.common.hw,
> +		[CLK_USB_PHY0]		= &usb_phy0_clk.common.hw,
> +		[CLK_USB_PHY1]		= &usb_phy1_clk.common.hw,
> +		[CLK_USB_PHY2]		= &usb_phy2_clk.common.hw,
> +		[CLK_USB_PHY3]		= &usb_phy3_clk.common.hw,
> +		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
> +		[CLK_USB_OHCI1]		= &usb_ohci1_clk.common.hw,
> +		[CLK_USB_OHCI2]		= &usb_ohci2_clk.common.hw,
> +		[CLK_USB_OHCI3]		= &usb_ohci3_clk.common.hw,
> +		[CLK_DRAM]		= &dram_clk.common.hw,
> +		[CLK_DRAM_VE]		= &dram_ve_clk.common.hw,
> +		[CLK_DRAM_CSI]		= &dram_csi_clk.common.hw,
> +		[CLK_DRAM_DEINTERLACE]	= &dram_deinterlace_clk.common.hw,
> +		[CLK_DRAM_TS]		= &dram_ts_clk.common.hw,
> +		[CLK_DE]		= &de_clk.common.hw,
> +		[CLK_TCON0]		= &tcon_clk.common.hw,
> +		[CLK_TVE]		= &tve_clk.common.hw,
> +		[CLK_DEINTERLACE]	= &deinterlace_clk.common.hw,
> +		[CLK_CSI_MISC]		= &csi_misc_clk.common.hw,
> +		[CLK_CSI_SCLK]		= &csi_sclk_clk.common.hw,
> +		[CLK_CSI_MCLK]		= &csi_mclk_clk.common.hw,
> +		[CLK_VE]		= &ve_clk.common.hw,
> +		[CLK_AC_DIG]		= &ac_dig_clk.common.hw,
> +		[CLK_AVS]		= &avs_clk.common.hw,
> +		[CLK_HDMI]		= &hdmi_clk.common.hw,
> +		[CLK_HDMI_DDC]		= &hdmi_ddc_clk.common.hw,
> +		[CLK_MBUS]		= &mbus_clk.common.hw,
> +		[CLK_GPU]		= &gpu_clk.common.hw,
> +	},
> +	.num	= CLK_NUMBER,
> +};
> +
> +static struct ccu_reset_map sun8i_h3_ccu_resets[] = {
> +	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
> +	[RST_USB_PHY1]		=  { 0x0cc, BIT(1) },
> +	[RST_USB_PHY2]		=  { 0x0cc, BIT(2) },
> +	[RST_USB_PHY3]		=  { 0x0cc, BIT(3) },
> +
> +	[RST_MBUS]		=  { 0x0fc, BIT(31) },
> +
> +	[RST_BUS_CE]		=  { 0x2c0, BIT(5) },
> +	[RST_BUS_DMA]		=  { 0x2c0, BIT(6) },
> +	[RST_BUS_MMC0]		=  { 0x2c0, BIT(8) },
> +	[RST_BUS_MMC1]		=  { 0x2c0, BIT(9) },
> +	[RST_BUS_MMC2]		=  { 0x2c0, BIT(10) },
> +	[RST_BUS_NAND]		=  { 0x2c0, BIT(13) },
> +	[RST_BUS_DRAM]		=  { 0x2c0, BIT(14) },
> +	[RST_BUS_EMAC]		=  { 0x2c0, BIT(17) },
> +	[RST_BUS_TS]		=  { 0x2c0, BIT(18) },
> +	[RST_BUS_HSTIMER]	=  { 0x2c0, BIT(19) },
> +	[RST_BUS_SPI0]		=  { 0x2c0, BIT(20) },
> +	[RST_BUS_SPI1]		=  { 0x2c0, BIT(21) },
> +	[RST_BUS_OTG]		=  { 0x2c0, BIT(23) },
> +	[RST_BUS_EHCI0]		=  { 0x2c0, BIT(24) },
> +	[RST_BUS_EHCI1]		=  { 0x2c0, BIT(25) },
> +	[RST_BUS_EHCI2]		=  { 0x2c0, BIT(26) },
> +	[RST_BUS_EHCI3]		=  { 0x2c0, BIT(27) },
> +	[RST_BUS_OHCI0]		=  { 0x2c0, BIT(28) },
> +	[RST_BUS_OHCI1]		=  { 0x2c0, BIT(29) },
> +	[RST_BUS_OHCI2]		=  { 0x2c0, BIT(30) },
> +	[RST_BUS_OHCI3]		=  { 0x2c0, BIT(31) },
> +
> +	[RST_BUS_VE]		=  { 0x2c4, BIT(0) },
> +	[RST_BUS_TCON0]		=  { 0x2c4, BIT(3) },
> +	[RST_BUS_TCON1]		=  { 0x2c4, BIT(4) },
> +	[RST_BUS_DEINTERLACE]	=  { 0x2c4, BIT(5) },
> +	[RST_BUS_CSI]		=  { 0x2c4, BIT(8) },
> +	[RST_BUS_TVE]		=  { 0x2c4, BIT(9) },
> +	[RST_BUS_HDMI0]		=  { 0x2c4, BIT(10) },
> +	[RST_BUS_HDMI1]		=  { 0x2c4, BIT(11) },
> +	[RST_BUS_DE]		=  { 0x2c4, BIT(12) },
> +	[RST_BUS_GPU]		=  { 0x2c4, BIT(20) },
> +	[RST_BUS_MSGBOX]	=  { 0x2c4, BIT(21) },
> +	[RST_BUS_SPINLOCK]	=  { 0x2c4, BIT(22) },
> +	[RST_BUS_DBG]		=  { 0x2c4, BIT(31) },
> +
> +	[RST_BUS_EPHY]		=  { 0x2c8, BIT(2) },
> +
> +	[RST_BUS_CODEC]		=  { 0x2d0, BIT(0) },
> +	[RST_BUS_SPDIF]		=  { 0x2d0, BIT(1) },
> +	[RST_BUS_THS]		=  { 0x2d0, BIT(8) },
> +	[RST_BUS_I2S0]		=  { 0x2d0, BIT(12) },
> +	[RST_BUS_I2S1]		=  { 0x2d0, BIT(13) },
> +	[RST_BUS_I2S2]		=  { 0x2d0, BIT(14) },
> +
> +	[RST_BUS_I2C0]		=  { 0x2d8, BIT(0) },
> +	[RST_BUS_I2C1]		=  { 0x2d8, BIT(1) },
> +	[RST_BUS_I2C2]		=  { 0x2d8, BIT(2) },
> +	[RST_BUS_UART0]		=  { 0x2d8, BIT(16) },
> +	[RST_BUS_UART1]		=  { 0x2d8, BIT(17) },
> +	[RST_BUS_UART2]		=  { 0x2d8, BIT(18) },
> +	[RST_BUS_UART3]		=  { 0x2d8, BIT(19) },
> +	[RST_BUS_SCR0]		=  { 0x2d8, BIT(20) },
> +};
> +
> +static struct ccu_reset_map sun50i_h5_ccu_resets[] = {
>  	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
>  	[RST_USB_PHY1]		=  { 0x0cc, BIT(1) },
>  	[RST_USB_PHY2]		=  { 0x0cc, BIT(2) },
> @@ -791,6 +973,7 @@ static struct ccu_reset_map sunxi_h3_h5_ccu_resets[] = {
>  	[RST_BUS_UART2]		=  { 0x2d8, BIT(18) },
>  	[RST_BUS_UART3]		=  { 0x2d8, BIT(19) },
>  	[RST_BUS_SCR0]		=  { 0x2d8, BIT(20) },
> +	[RST_BUS_SCR1]		=  { 0x2d8, BIT(21) },
>  };
>  
>  static const struct sunxi_ccu_desc sun8i_h3_ccu_desc = {
> @@ -799,8 +982,18 @@ static const struct sunxi_ccu_desc sun8i_h3_ccu_desc = {
>  
>  	.hw_clks	= &sun8i_h3_hw_clks,
>  
> -	.resets		= sunxi_h3_h5_ccu_resets,
> -	.num_resets	= ARRAY_SIZE(sunxi_h3_h5_ccu_resets),
> +	.resets		= sun8i_h3_ccu_resets,
> +	.num_resets	= ARRAY_SIZE(sun8i_h3_ccu_resets),
> +};
> +
> +static const struct sunxi_ccu_desc sun50i_h5_ccu_desc = {
> +	.ccu_clks	= sunxi_h3_h5_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sunxi_h3_h5_ccu_clks),
> +
> +	.hw_clks	= &sun50i_h5_hw_clks,
> +
> +	.resets		= sun50i_h5_ccu_resets,
> +	.num_resets	= ARRAY_SIZE(sun50i_h5_ccu_resets),
>  };
>  
>  static struct ccu_mux_nb sunxi_h3_h5_cpu_nb = {
> @@ -840,3 +1033,10 @@ static void __init sun8i_h3_ccu_setup(struct device_node *node)
>  }
>  CLK_OF_DECLARE(sun8i_h3_ccu, "allwinner,sun8i-h3-ccu",
>  	       sun8i_h3_ccu_setup);
> +
> +static void __init sun50i_h5_ccu_setup(struct device_node *node)
> +{
> +	sunxi_h3_h5_ccu_init(node, &sun50i_h5_ccu_desc);
> +}
> +CLK_OF_DECLARE(sun50i_h5_ccu, "allwinner,sun50i-h5-ccu",
> +	       sun50i_h5_ccu_setup);
> diff --git a/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.h b/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.h
> index e2a4656d2cf3..e5a78cc66d6b 100644
> --- a/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.h
> +++ b/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.h
> @@ -57,6 +57,9 @@
>  
>  /* And the GPU module clock is exported */
>  
> -#define CLK_NUMBER		(CLK_GPU + 1)
> +/* New clocks imported in H5 */

H5 clocks seems more natural, and you don't have to put it twice.

> +/* The SCR1 bus gate is exported */
> +
> +#define CLK_NUMBER		(CLK_BUS_SCR1 + 1)

This introduces an off-by-one error on the H3

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170208/c9ae8cab/attachment.sig>
