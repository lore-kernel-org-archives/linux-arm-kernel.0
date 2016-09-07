From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 7 Sep 2016 15:24:11 +0800
Subject: [PATCH v2 6/7] clk: sunxi-ng: Add A23 CCU
In-Reply-To: <20160906121837.7517-7-maxime.ripard@free-electrons.com>
References: <20160906121837.7517-1-maxime.ripard@free-electrons.com>
 <20160906121837.7517-7-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64jDTWB4faaBdCBCcFrt1WNf=PYwc16kpgsUhaMRudHnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2016 at 8:18 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Add support for the clock unit found in the A23. Due to the similarities
> with the A33, it also shares its clock IDs to allow sharing the DTSI.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

[...]

> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
> new file mode 100644
> index 000000000000..e9f2d7785001
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
> @@ -0,0 +1,732 @@

[...]

> +static struct clk_hw_onecell_data sun8i_a23_hw_clks = {
> +       .hws    = {
> +               [CLK_PLL_CPUX]          = &pll_cpux_clk.common.hw,
> +               [CLK_PLL_AUDIO_BASE]    = &pll_audio_base_clk.common.hw,
> +               [CLK_PLL_AUDIO]         = &pll_audio_clk.hw,
> +               [CLK_PLL_AUDIO_2X]      = &pll_audio_2x_clk.hw,
> +               [CLK_PLL_AUDIO_4X]      = &pll_audio_4x_clk.hw,
> +               [CLK_PLL_AUDIO_8X]      = &pll_audio_8x_clk.hw,
> +               [CLK_PLL_VIDEO]         = &pll_video_clk.common.hw,
> +               [CLK_PLL_VIDEO_2X]      = &pll_video_2x_clk.hw,
> +               [CLK_PLL_VE]            = &pll_ve_clk.common.hw,
> +               [CLK_PLL_DDR0]          = &pll_ddr_clk.common.hw,
> +               [CLK_PLL_PERIPH]        = &pll_periph_clk.common.hw,
> +               [CLK_PLL_PERIPH_2X]     = &pll_periph_2x_clk.hw,
> +               [CLK_PLL_GPU]           = &pll_gpu_clk.common.hw,
> +               [CLK_PLL_MIPI]          = &pll_mipi_clk.common.hw,
> +               [CLK_PLL_HSIC]          = &pll_hsic_clk.common.hw,
> +               [CLK_PLL_DE]            = &pll_de_clk.common.hw,
> +               [CLK_CPUX]              = &cpux_clk.common.hw,
> +               [CLK_AXI]               = &axi_clk.common.hw,
> +               [CLK_AHB1]              = &ahb1_clk.common.hw,
> +               [CLK_APB1]              = &apb1_clk.common.hw,
> +               [CLK_APB2]              = &apb2_clk.common.hw,
> +               [CLK_BUS_MIPI_DSI]      = &bus_mipi_dsi_clk.common.hw,
> +               [CLK_BUS_DMA]           = &bus_dma_clk.common.hw,
> +               [CLK_BUS_MMC0]          = &bus_mmc0_clk.common.hw,
> +               [CLK_BUS_MMC1]          = &bus_mmc1_clk.common.hw,
> +               [CLK_BUS_MMC2]          = &bus_mmc2_clk.common.hw,
> +               [CLK_BUS_NAND]          = &bus_nand_clk.common.hw,
> +               [CLK_BUS_DRAM]          = &bus_dram_clk.common.hw,
> +               [CLK_BUS_HSTIMER]       = &bus_hstimer_clk.common.hw,
> +               [CLK_BUS_SPI0]          = &bus_spi0_clk.common.hw,
> +               [CLK_BUS_SPI1]          = &bus_spi1_clk.common.hw,
> +               [CLK_BUS_OTG]           = &bus_otg_clk.common.hw,
> +               [CLK_BUS_EHCI]          = &bus_ehci_clk.common.hw,
> +               [CLK_BUS_OHCI]          = &bus_ohci_clk.common.hw,
> +               [CLK_BUS_VE]            = &bus_ve_clk.common.hw,
> +               [CLK_BUS_LCD]           = &bus_lcd_clk.common.hw,
> +               [CLK_BUS_CSI]           = &bus_csi_clk.common.hw,
> +               [CLK_BUS_DE_BE]         = &bus_de_be_clk.common.hw,
> +               [CLK_BUS_DE_FE]         = &bus_de_fe_clk.common.hw,
> +               [CLK_BUS_GPU]           = &bus_gpu_clk.common.hw,
> +               [CLK_BUS_MSGBOX]        = &bus_msgbox_clk.common.hw,

A23 manual and Allwinner sources say there is a bus gate for SPINLOCK.
Tested it myself, and it indeed exists.

> +               [CLK_BUS_DRC]           = &bus_drc_clk.common.hw,
> +               [CLK_BUS_CODEC]         = &bus_codec_clk.common.hw,
> +               [CLK_BUS_PIO]           = &bus_pio_clk.common.hw,
> +               [CLK_BUS_I2S0]          = &bus_i2s0_clk.common.hw,
> +               [CLK_BUS_I2S1]          = &bus_i2s1_clk.common.hw,
> +               [CLK_BUS_I2C0]          = &bus_i2c0_clk.common.hw,
> +               [CLK_BUS_I2C1]          = &bus_i2c1_clk.common.hw,
> +               [CLK_BUS_I2C2]          = &bus_i2c2_clk.common.hw,
> +               [CLK_BUS_UART0]         = &bus_uart0_clk.common.hw,
> +               [CLK_BUS_UART1]         = &bus_uart1_clk.common.hw,
> +               [CLK_BUS_UART2]         = &bus_uart2_clk.common.hw,
> +               [CLK_BUS_UART3]         = &bus_uart3_clk.common.hw,
> +               [CLK_BUS_UART4]         = &bus_uart4_clk.common.hw,
> +               [CLK_NAND]              = &nand_clk.common.hw,
> +               [CLK_MMC0]              = &mmc0_clk.common.hw,
> +               [CLK_MMC0_SAMPLE]       = &mmc0_sample_clk.common.hw,
> +               [CLK_MMC0_OUTPUT]       = &mmc0_output_clk.common.hw,
> +               [CLK_MMC1]              = &mmc1_clk.common.hw,
> +               [CLK_MMC1_SAMPLE]       = &mmc1_sample_clk.common.hw,
> +               [CLK_MMC1_OUTPUT]       = &mmc1_output_clk.common.hw,
> +               [CLK_MMC2]              = &mmc2_clk.common.hw,
> +               [CLK_MMC2_SAMPLE]       = &mmc2_sample_clk.common.hw,
> +               [CLK_MMC2_OUTPUT]       = &mmc2_output_clk.common.hw,
> +               [CLK_SPI0]              = &spi0_clk.common.hw,
> +               [CLK_SPI1]              = &spi1_clk.common.hw,
> +               [CLK_I2S0]              = &i2s0_clk.common.hw,
> +               [CLK_I2S1]              = &i2s1_clk.common.hw,
> +               [CLK_USB_PHY0]          = &usb_phy0_clk.common.hw,
> +               [CLK_USB_PHY1]          = &usb_phy1_clk.common.hw,
> +               [CLK_USB_HSIC]          = &usb_hsic_clk.common.hw,
> +               [CLK_USB_HSIC_12M]      = &usb_hsic_12M_clk.common.hw,
> +               [CLK_USB_OHCI]          = &usb_ohci_clk.common.hw,
> +               [CLK_DRAM_VE]           = &dram_ve_clk.common.hw,
> +               [CLK_DRAM_CSI]          = &dram_csi_clk.common.hw,
> +               [CLK_DRAM_DRC]          = &dram_drc_clk.common.hw,
> +               [CLK_DRAM_DE_FE]        = &dram_de_fe_clk.common.hw,
> +               [CLK_DRAM_DE_BE]        = &dram_de_be_clk.common.hw,
> +               [CLK_DE_BE]             = &de_be_clk.common.hw,
> +               [CLK_DE_FE]             = &de_fe_clk.common.hw,
> +               [CLK_LCD_CH0]           = &lcd_ch0_clk.common.hw,
> +               [CLK_LCD_CH1]           = &lcd_ch1_clk.common.hw,
> +               [CLK_CSI_SCLK]          = &csi_sclk_clk.common.hw,
> +               [CLK_CSI_MCLK]          = &csi_mclk_clk.common.hw,
> +               [CLK_VE]                = &ve_clk.common.hw,
> +               [CLK_AC_DIG]            = &ac_dig_clk.common.hw,
> +               [CLK_AVS]               = &avs_clk.common.hw,
> +               [CLK_MBUS]              = &mbus_clk.common.hw,
> +               [CLK_DSI_SCLK]          = &dsi_sclk_clk.common.hw,
> +               [CLK_DSI_DPHY]          = &dsi_dphy_clk.common.hw,
> +               [CLK_DRC]               = &drc_clk.common.hw,
> +               [CLK_GPU]               = &gpu_clk.common.hw,
> +               [CLK_ATS]               = &ats_clk.common.hw,
> +       },
> +       .num    = CLK_NUMBER,
> +};
> +
> +static struct ccu_reset_map sun8i_a23_ccu_resets[] = {
> +       [RST_USB_PHY0]          =  { 0x0cc, BIT(0) },
> +       [RST_USB_PHY1]          =  { 0x0cc, BIT(1) },
> +       [RST_USB_HSIC]          =  { 0x0cc, BIT(2) },
> +
> +       [RST_MBUS]              =  { 0x0fc, BIT(31) },
> +
> +       [RST_BUS_MIPI_DSI]      =  { 0x2c0, BIT(1) },
> +       [RST_BUS_DMA]           =  { 0x2c0, BIT(6) },
> +       [RST_BUS_MMC0]          =  { 0x2c0, BIT(8) },
> +       [RST_BUS_MMC1]          =  { 0x2c0, BIT(9) },
> +       [RST_BUS_MMC2]          =  { 0x2c0, BIT(10) },
> +       [RST_BUS_NAND]          =  { 0x2c0, BIT(13) },
> +       [RST_BUS_DRAM]          =  { 0x2c0, BIT(14) },
> +       [RST_BUS_HSTIMER]       =  { 0x2c0, BIT(19) },
> +       [RST_BUS_SPI0]          =  { 0x2c0, BIT(20) },
> +       [RST_BUS_SPI1]          =  { 0x2c0, BIT(21) },
> +       [RST_BUS_OTG]           =  { 0x2c0, BIT(24) },
> +       [RST_BUS_EHCI]          =  { 0x2c0, BIT(26) },
> +       [RST_BUS_OHCI]          =  { 0x2c0, BIT(29) },
> +
> +       [RST_BUS_VE]            =  { 0x2c4, BIT(0) },
> +       [RST_BUS_LCD]           =  { 0x2c4, BIT(4) },
> +       [RST_BUS_CSI]           =  { 0x2c4, BIT(8) },
> +       [RST_BUS_DE_BE]         =  { 0x2c4, BIT(12) },
> +       [RST_BUS_DE_FE]         =  { 0x2c4, BIT(14) },
> +       [RST_BUS_GPU]           =  { 0x2c4, BIT(20) },

Allwinner sources say there is a reset control for MSGBOX.
Tested it myself, and it indeed exists.

> +       [RST_BUS_SPINLOCK]      =  { 0x2c4, BIT(22) },
> +       [RST_BUS_DRC]           =  { 0x2c4, BIT(25) },
> +
> +       [RST_BUS_LVDS]          =  { 0x2c8, BIT(0) },
> +
> +       [RST_BUS_CODEC]         =  { 0x2d0, BIT(0) },
> +       [RST_BUS_I2S0]          =  { 0x2d0, BIT(12) },
> +       [RST_BUS_I2S1]          =  { 0x2d0, BIT(13) },
> +
> +       [RST_BUS_I2C0]          =  { 0x2d4, BIT(0) },
> +       [RST_BUS_I2C1]          =  { 0x2d4, BIT(1) },
> +       [RST_BUS_I2C2]          =  { 0x2d4, BIT(2) },
> +       [RST_BUS_UART0]         =  { 0x2d4, BIT(16) },
> +       [RST_BUS_UART1]         =  { 0x2d4, BIT(17) },
> +       [RST_BUS_UART2]         =  { 0x2d4, BIT(18) },
> +       [RST_BUS_UART3]         =  { 0x2d4, BIT(19) },
> +       [RST_BUS_UART4]         =  { 0x2d4, BIT(20) },
> +};

[...]

Other than these 2 bits, this patch looks good.

Regards
ChenYu
