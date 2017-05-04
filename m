From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 May 2017 16:23:40 +0200
Subject: [PATCH v2 08/10] clk: sunxi-ng: support R40 SoC
In-Reply-To: <20170504135006.16483-9-icenowy@aosc.io>
References: <20170504135006.16483-1-icenowy@aosc.io>
 <20170504135006.16483-9-icenowy@aosc.io>
Message-ID: <20170504142340.ckugq267n7phuzqi@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 04, 2017 at 09:50:04PM +0800, Icenowy Zheng wrote:
> From: Icenowy Zheng <icenowy@aosc.xyz>
> 
> Allwinner R40 SoC have a clock controller module in the style of the
> SoCs beyond sun6i, however, it's more rich and complex.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Fixes according to the SoC's user manual.
> 
>  drivers/clk/sunxi-ng/Kconfig              |   10 +
>  drivers/clk/sunxi-ng/Makefile             |    1 +
>  drivers/clk/sunxi-ng/ccu-sun8i-r40.c      | 1153 +++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun8i-r40.h      |   68 ++
>  include/dt-bindings/clock/sun8i-r40-ccu.h |  191 +++++
>  include/dt-bindings/reset/sun8i-r40-ccu.h |  129 ++++
>  6 files changed, 1552 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r40.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r40.h
>  create mode 100644 include/dt-bindings/clock/sun8i-r40-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun8i-r40-ccu.h
> 
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 64088e599404..e6884eafde44 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -140,6 +140,16 @@ config SUN8I_V3S_CCU
>  	default MACH_SUN8I
>  	depends on MACH_SUN8I || COMPILE_TEST
>  
> +config SUN8I_R40_CCU
> +	bool "Support for the Allwinner R40 CCU"
> +	select SUNXI_CCU_DIV
> +	select SUNXI_CCU_NK
> +	select SUNXI_CCU_NKM
> +	select SUNXI_CCU_NKMP
> +	select SUNXI_CCU_NM
> +	select SUNXI_CCU_MP
> +	default MACH_SUN8I
> +
>  config SUN9I_A80_CCU
>  	bool "Support for the Allwinner A80 CCU"
>  	select SUNXI_CCU_DIV
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 0ec02fe14c50..aa00b641484e 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_SUN8I_A33_CCU)	+= ccu-sun8i-a33.o
>  obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
>  obj-$(CONFIG_SUN8I_V3S_CCU)	+= ccu-sun8i-v3s.o
>  obj-$(CONFIG_SUN8I_R_CCU)	+= ccu-sun8i-r.o
> +obj-$(CONFIG_SUN8I_R40_CCU)	+= ccu-sun8i-r40.o
>  obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80.o
>  obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80-de.o
>  obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80-usb.o
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
> new file mode 100644
> index 000000000000..0cc1b1ab7c3f
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
> @@ -0,0 +1,1153 @@
> +/*
> + * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.xyz>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_address.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_reset.h"
> +
> +#include "ccu_div.h"
> +#include "ccu_gate.h"
> +#include "ccu_mp.h"
> +#include "ccu_mult.h"
> +#include "ccu_nk.h"
> +#include "ccu_nkm.h"
> +#include "ccu_nkmp.h"
> +#include "ccu_nm.h"
> +#include "ccu_phase.h"
> +
> +#include "ccu-sun8i-r40.h"
> +
> +static SUNXI_CCU_NKMP_WITH_GATE_LOCK(pll_cpu_clk, "pll-cpu",
> +				     "osc24M", 0x000,
> +				     8, 5,	/* N */
> +				     4, 2,	/* K */
> +				     0, 2,	/* M */
> +				     16, 2,	/* P */
> +				     BIT(31),	/* gate */
> +				     BIT(28),	/* lock */
> +				     0);
> +
> +/*
> + * The Audio PLL is supposed to have 4 outputs: 3 fixed factors from
> + * the base (2x, 4x and 8x), and one variable divider (the one true
> + * pll audio).
> + *
> + * We don't have any need for the variable divider for now, so we just
> + * hardcode it to match with the clock names
> + */
> +#define SUN8I_R40_PLL_AUDIO_REG	0x008
> +
> +static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
> +				   "osc24M", 0x008,
> +				   8, 7,	/* N */
> +				   0, 5,	/* M */
> +				   BIT(31),	/* gate */
> +				   BIT(28),	/* lock */
> +				   0);
> +
> +static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video0_clk, "pll-video0",
> +					"osc24M", 0x0010,
> +					8, 7,		/* N */
> +					0, 4,		/* M */
> +					BIT(24),	/* frac enable */
> +					BIT(25),	/* frac select */
> +					270000000,	/* frac rate 0 */
> +					297000000,	/* frac rate 1 */
> +					BIT(31),	/* gate */
> +					BIT(28),	/* lock */
> +					0);
> +
> +static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
> +					"osc24M", 0x0018,
> +					8, 7,		/* N */
> +					0, 4,		/* M */
> +					BIT(24),	/* frac enable */
> +					BIT(25),	/* frac select */
> +					270000000,	/* frac rate 0 */
> +					297000000,	/* frac rate 1 */
> +					BIT(31),	/* gate */
> +					BIT(28),	/* lock */
> +					0);
> +
> +static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_ddr0_clk, "pll-ddr0",
> +				    "osc24M", 0x020,
> +				    8, 5,	/* N */
> +				    4, 2,	/* K */
> +				    0, 2,	/* M */
> +				    BIT(31),	/* gate */
> +				    BIT(28),	/* lock */
> +				    0);
> +
> +/* According to the BSP driver, pll-periph{0,1} have M at 0:1 */
> +static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_periph0_clk, "pll-periph0",
> +				    "osc24M", 0x028,
> +				    8, 5,	/* N */
> +				    4, 2,	/* K */
> +				    0, 2,	/* M */
> +				    BIT(31),	/* gate */
> +				    BIT(28),	/* lock */
> +				    0);
> +
> +static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_periph1_clk, "pll-periph1",
> +				    "osc24M", 0x02c,
> +				    8, 5,	/* N */
> +				    4, 2,	/* K */
> +				    0, 2,	/* M */
> +				    BIT(31),	/* gate */
> +				    BIT(28),	/* lock */
> +				    0);
> +
> +static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_video1_clk, "pll-video1",
> +					"osc24M", 0x030,
> +					8, 7,		/* N */
> +					0, 4,		/* M */
> +					BIT(24),	/* frac enable */
> +					BIT(25),	/* frac select */
> +					270000000,	/* frac rate 0 */
> +					297000000,	/* frac rate 1 */
> +					BIT(31),	/* gate */
> +					BIT(28),	/* lock */
> +					CLK_SET_RATE_UNGATE);
> +
> +/*
> + * For the special bit in gate part, please see the BSP source code at
> + * https://github.com/BPI-SINOVOIP/BPI-M2U-bsp/blob/master/linux-sunxi/drivers/clk/sunxi/clk-sun8iw11.c#L665
> + */

Please don't put URLs in there. They are meant to be broken.

> +static CLK_FIXED_FACTOR(osc24m_2x_clk, "osc24M-2x",
> +			"osc24M", 1, 2, 0);

There's a single user for this. You should just be using a factor to
the parent clock, there's no need to introduce a new clock.

> +static CLK_FIXED_FACTOR(osc24m_32k_clk, "osc24M-32k",
> +			"osc24M", 750, 1, 0);

This is fed from a 16MHz clock, likely the internal oscillator, that
is muxed from the RTC...

> +static struct clk_hw_onecell_data sun8i_r40_hw_clks = {
> +	.hws	= {
> +		[CLK_OSC24M_2X]		= &osc24m_2x_clk.hw,
> +		[CLK_OSC24M_32K]	= &osc24m_32k_clk.hw,

Which means that you should be a consumer of the RTC clock, not feed
it.

> +		[CLK_PLL_CPU]		= &pll_cpu_clk.common.hw,
> +		[CLK_PLL_AUDIO_BASE]	= &pll_audio_base_clk.common.hw,
> +		[CLK_PLL_AUDIO]		= &pll_audio_clk.hw,
> +		[CLK_PLL_AUDIO_2X]	= &pll_audio_2x_clk.hw,
> +		[CLK_PLL_AUDIO_4X]	= &pll_audio_4x_clk.hw,
> +		[CLK_PLL_AUDIO_8X]	= &pll_audio_8x_clk.hw,
> +		[CLK_PLL_VIDEO0]	= &pll_video0_clk.common.hw,
> +		[CLK_PLL_VIDEO0_2X]	= &pll_video0_2x_clk.hw,
> +		[CLK_PLL_VE]		= &pll_ve_clk.common.hw,
> +		[CLK_PLL_DDR0]		= &pll_ddr0_clk.common.hw,
> +		[CLK_PLL_PERIPH0]	= &pll_periph0_clk.common.hw,
> +		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.hw,
> +		[CLK_PLL_PERIPH1]	= &pll_periph1_clk.common.hw,
> +		[CLK_PLL_PERIPH1_2X]	= &pll_periph1_2x_clk.hw,
> +		[CLK_PLL_VIDEO1]	= &pll_video1_clk.common.hw,
> +		[CLK_PLL_VIDEO1_2X]	= &pll_video1_2x_clk.hw,
> +		[CLK_PLL_SATA]		= &pll_sata_clk.common.hw,
> +		[CLK_PLL_GPU]		= &pll_gpu_clk.common.hw,
> +		[CLK_PLL_MIPI]		= &pll_mipi_clk.common.hw,
> +		[CLK_PLL_DE]		= &pll_de_clk.common.hw,
> +		[CLK_PLL_DDR1]		= &pll_ddr1_clk.common.hw,
> +		[CLK_CPU]		= &cpu_clk.common.hw,
> +		[CLK_AXI]		= &axi_clk.common.hw,
> +		[CLK_AHB1]		= &ahb1_clk.common.hw,
> +		[CLK_APB1]		= &apb1_clk.common.hw,
> +		[CLK_APB2]		= &apb2_clk.common.hw,
> +		[CLK_BUS_MIPI_DSI]	= &bus_mipi_dsi_clk.common.hw,
> +		[CLK_BUS_CE]		= &bus_ce_clk.common.hw,
> +		[CLK_BUS_DMA]		= &bus_dma_clk.common.hw,
> +		[CLK_BUS_MMC0]		= &bus_mmc0_clk.common.hw,
> +		[CLK_BUS_MMC1]		= &bus_mmc1_clk.common.hw,
> +		[CLK_BUS_MMC2]		= &bus_mmc2_clk.common.hw,
> +		[CLK_BUS_MMC3]		= &bus_mmc3_clk.common.hw,
> +		[CLK_BUS_NAND]		= &bus_nand_clk.common.hw,
> +		[CLK_BUS_DRAM]		= &bus_dram_clk.common.hw,
> +		[CLK_BUS_EMAC]		= &bus_emac_clk.common.hw,
> +		[CLK_BUS_TS]		= &bus_ts_clk.common.hw,
> +		[CLK_BUS_HSTIMER]	= &bus_hstimer_clk.common.hw,
> +		[CLK_BUS_SPI0]		= &bus_spi0_clk.common.hw,
> +		[CLK_BUS_SPI1]		= &bus_spi1_clk.common.hw,
> +		[CLK_BUS_SPI2]		= &bus_spi2_clk.common.hw,
> +		[CLK_BUS_SPI3]		= &bus_spi3_clk.common.hw,
> +		[CLK_BUS_SATA]		= &bus_sata_clk.common.hw,
> +		[CLK_BUS_OTG]		= &bus_otg_clk.common.hw,
> +		[CLK_BUS_EHCI0]		= &bus_ehci0_clk.common.hw,
> +		[CLK_BUS_EHCI1]		= &bus_ehci1_clk.common.hw,
> +		[CLK_BUS_EHCI2]		= &bus_ehci2_clk.common.hw,
> +		[CLK_BUS_OHCI0]		= &bus_ohci0_clk.common.hw,
> +		[CLK_BUS_OHCI1]		= &bus_ohci1_clk.common.hw,
> +		[CLK_BUS_OHCI2]		= &bus_ohci2_clk.common.hw,
> +		[CLK_BUS_VE]		= &bus_ve_clk.common.hw,
> +		[CLK_BUS_DE_MP]		= &bus_de_mp_clk.common.hw,
> +		[CLK_BUS_DEINTERLACE]	= &bus_deinterlace_clk.common.hw,
> +		[CLK_BUS_CSI0]		= &bus_csi0_clk.common.hw,
> +		[CLK_BUS_CSI1]		= &bus_csi1_clk.common.hw,
> +		[CLK_BUS_HDMI_SLOW]	= &bus_hdmi_slow_clk.common.hw,
> +		[CLK_BUS_HDMI]		= &bus_hdmi_clk.common.hw,
> +		[CLK_BUS_DE]		= &bus_de_clk.common.hw,
> +		[CLK_BUS_TVE0]		= &bus_tve0_clk.common.hw,
> +		[CLK_BUS_TVE1]		= &bus_tve1_clk.common.hw,
> +		[CLK_BUS_TVE_TOP]	= &bus_tve_top_clk.common.hw,
> +		[CLK_BUS_GMAC]		= &bus_gmac_clk.common.hw,
> +		[CLK_BUS_GPU]		= &bus_gpu_clk.common.hw,
> +		[CLK_BUS_TVD0]		= &bus_tvd0_clk.common.hw,
> +		[CLK_BUS_TVD1]		= &bus_tvd1_clk.common.hw,
> +		[CLK_BUS_TVD2]		= &bus_tvd2_clk.common.hw,
> +		[CLK_BUS_TVD3]		= &bus_tvd3_clk.common.hw,
> +		[CLK_BUS_TVD_TOP]	= &bus_tvd_top_clk.common.hw,
> +		[CLK_BUS_TCON0]		= &bus_tcon0_clk.common.hw,
> +		[CLK_BUS_TCON1]		= &bus_tcon1_clk.common.hw,
> +		[CLK_BUS_TVE0_TCON]	= &bus_tve0_tcon_clk.common.hw,
> +		[CLK_BUS_TVE1_TCON]	= &bus_tve1_tcon_clk.common.hw,
> +		[CLK_BUS_TCON_TOP]	= &bus_tcon_top_clk.common.hw,
> +		[CLK_BUS_CODEC]		= &bus_codec_clk.common.hw,
> +		[CLK_BUS_SPDIF]		= &bus_spdif_clk.common.hw,
> +		[CLK_BUS_AC97]		= &bus_ac97_clk.common.hw,
> +		[CLK_BUS_PIO]		= &bus_pio_clk.common.hw,
> +		[CLK_BUS_IR0]		= &bus_ir0_clk.common.hw,
> +		[CLK_BUS_IR1]		= &bus_ir1_clk.common.hw,
> +		[CLK_BUS_THS]		= &bus_ths_clk.common.hw,
> +		[CLK_BUS_KEYPAD]	= &bus_keypad_clk.common.hw,
> +		[CLK_BUS_I2S0]		= &bus_i2s0_clk.common.hw,
> +		[CLK_BUS_I2S1]		= &bus_i2s1_clk.common.hw,
> +		[CLK_BUS_I2S2]		= &bus_i2s2_clk.common.hw,
> +		[CLK_BUS_I2C0]		= &bus_i2c0_clk.common.hw,
> +		[CLK_BUS_I2C1]		= &bus_i2c1_clk.common.hw,
> +		[CLK_BUS_I2C2]		= &bus_i2c2_clk.common.hw,
> +		[CLK_BUS_I2C3]		= &bus_i2c3_clk.common.hw,
> +		[CLK_BUS_CAN]		= &bus_can_clk.common.hw,
> +		[CLK_BUS_SCR]		= &bus_scr_clk.common.hw,
> +		[CLK_BUS_PS20]		= &bus_ps20_clk.common.hw,
> +		[CLK_BUS_PS21]		= &bus_ps21_clk.common.hw,
> +		[CLK_BUS_I2C4]		= &bus_i2c4_clk.common.hw,
> +		[CLK_BUS_UART0]		= &bus_uart0_clk.common.hw,
> +		[CLK_BUS_UART1]		= &bus_uart1_clk.common.hw,
> +		[CLK_BUS_UART2]		= &bus_uart2_clk.common.hw,
> +		[CLK_BUS_UART3]		= &bus_uart3_clk.common.hw,
> +		[CLK_BUS_UART4]		= &bus_uart4_clk.common.hw,
> +		[CLK_BUS_UART5]		= &bus_uart5_clk.common.hw,
> +		[CLK_BUS_UART6]		= &bus_uart6_clk.common.hw,
> +		[CLK_BUS_UART7]		= &bus_uart7_clk.common.hw,
> +		[CLK_BUS_DBG]		= &bus_dbg_clk.common.hw,
> +		[CLK_THS]		= &ths_clk.common.hw,
> +		[CLK_NAND]		= &nand_clk.common.hw,
> +		[CLK_MMC0]		= &mmc0_clk.common.hw,
> +		[CLK_MMC1]		= &mmc1_clk.common.hw,
> +		[CLK_MMC2]		= &mmc2_clk.common.hw,
> +		[CLK_MMC3]		= &mmc3_clk.common.hw,
> +		[CLK_TS]		= &ts_clk.common.hw,
> +		[CLK_CE]		= &ce_clk.common.hw,
> +		[CLK_SPI0]		= &spi0_clk.common.hw,
> +		[CLK_SPI1]		= &spi1_clk.common.hw,
> +		[CLK_SPI2]		= &spi2_clk.common.hw,
> +		[CLK_SPI3]		= &spi3_clk.common.hw,
> +		[CLK_I2S0]		= &i2s0_clk.common.hw,
> +		[CLK_I2S1]		= &i2s1_clk.common.hw,
> +		[CLK_I2S2]		= &i2s2_clk.common.hw,
> +		[CLK_AC97]		= &ac97_clk.common.hw,
> +		[CLK_SPDIF]		= &spdif_clk.common.hw,
> +		[CLK_KEYPAD]		= &keypad_clk.common.hw,
> +		[CLK_SATA]		= &sata_clk.common.hw,
> +		[CLK_USB_PHY0]		= &usb_phy0_clk.common.hw,
> +		[CLK_USB_PHY1]		= &usb_phy1_clk.common.hw,
> +		[CLK_USB_PHY2]		= &usb_phy2_clk.common.hw,
> +		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
> +		[CLK_USB_OHCI1]		= &usb_ohci1_clk.common.hw,
> +		[CLK_USB_OHCI2]		= &usb_ohci2_clk.common.hw,
> +		[CLK_USB_OHCI0_12M]	= &usb_ohci0_12m_clk.common.hw,
> +		[CLK_USB_OHCI1_12M]	= &usb_ohci1_12m_clk.common.hw,
> +		[CLK_USB_OHCI2_12M]	= &usb_ohci2_12m_clk.common.hw,
> +		[CLK_IR0]		= &ir0_clk.common.hw,
> +		[CLK_IR1]		= &ir1_clk.common.hw,
> +		[CLK_DRAM]		= &dram_clk.common.hw,
> +		[CLK_DRAM_VE]		= &dram_ve_clk.common.hw,
> +		[CLK_DRAM_CSI0]		= &dram_csi0_clk.common.hw,
> +		[CLK_DRAM_CSI1]		= &dram_csi1_clk.common.hw,
> +		[CLK_DRAM_TS]		= &dram_ts_clk.common.hw,
> +		[CLK_DRAM_TVD]		= &dram_tvd_clk.common.hw,
> +		[CLK_DRAM_DE_MP]	= &dram_de_mp_clk.common.hw,
> +		[CLK_DRAM_DEINTERLACE]	= &dram_deinterlace_clk.common.hw,
> +		[CLK_DE]		= &de_clk.common.hw,
> +		[CLK_DE_MP]		= &de_mp_clk.common.hw,
> +		[CLK_TCON0]		= &tcon0_clk.common.hw,
> +		[CLK_TCON1]		= &tcon1_clk.common.hw,
> +		[CLK_TCON_TVE0]		= &tcon_tve0_clk.common.hw,
> +		[CLK_TCON_TVE1]		= &tcon_tve1_clk.common.hw,
> +		[CLK_DEINTERLACE]	= &deinterlace_clk.common.hw,
> +		[CLK_CSI1_MCLK]		= &csi1_mclk_clk.common.hw,
> +		[CLK_CSI_SCLK]		= &csi_sclk_clk.common.hw,
> +		[CLK_CSI0_MCLK]		= &csi0_mclk_clk.common.hw,
> +		[CLK_VE]		= &ve_clk.common.hw,
> +		[CLK_ADDA]		= &adda_clk.common.hw,
> +		[CLK_ADDA_4X]		= &adda_4x_clk.common.hw,
> +		[CLK_AVS]		= &avs_clk.common.hw,
> +		[CLK_HDMI]		= &hdmi_clk.common.hw,
> +		[CLK_HDMI_SLOW]		= &hdmi_slow_clk.common.hw,
> +		[CLK_MBUS]		= &mbus_clk.common.hw,
> +		[CLK_MIPI_DSI]		= &mipi_dsi_clk.common.hw,
> +		[CLK_TVE0]		= &tve0_clk.common.hw,
> +		[CLK_TVE1]		= &tve1_clk.common.hw,
> +		[CLK_TVD0]		= &tvd0_clk.common.hw,
> +		[CLK_TVD1]		= &tvd1_clk.common.hw,
> +		[CLK_TVD2]		= &tvd2_clk.common.hw,
> +		[CLK_TVD3]		= &tvd3_clk.common.hw,
> +		[CLK_GPU]		= &gpu_clk.common.hw,
> +		[CLK_OUTA]		= &outa_clk.common.hw,
> +		[CLK_OUTB]		= &outb_clk.common.hw,
> +	},
> +	.num	= CLK_NUMBER,
> +};
> +
> +static struct ccu_reset_map sun8i_r40_ccu_resets[] = {
> +	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
> +	[RST_USB_PHY1]		=  { 0x0cc, BIT(1) },
> +	[RST_USB_PHY2]		=  { 0x0cc, BIT(2) },
> +
> +	[RST_MBUS]		=  { 0x0fc, BIT(31) },
> +
> +	[RST_BUS_MIPI_DSI]	=  { 0x2c0, BIT(1) },
> +	[RST_BUS_CE]		=  { 0x2c0, BIT(5) },
> +	[RST_BUS_DMA]		=  { 0x2c0, BIT(6) },
> +	[RST_BUS_MMC0]		=  { 0x2c0, BIT(8) },
> +	[RST_BUS_MMC1]		=  { 0x2c0, BIT(9) },
> +	[RST_BUS_MMC2]		=  { 0x2c0, BIT(10) },
> +	[RST_BUS_MMC3]		=  { 0x2c0, BIT(11) },
> +	[RST_BUS_NAND]		=  { 0x2c0, BIT(13) },
> +	[RST_BUS_DRAM]		=  { 0x2c0, BIT(14) },
> +	[RST_BUS_EMAC]		=  { 0x2c0, BIT(17) },
> +	[RST_BUS_TS]		=  { 0x2c0, BIT(18) },
> +	[RST_BUS_HSTIMER]	=  { 0x2c0, BIT(19) },
> +	[RST_BUS_SPI0]		=  { 0x2c0, BIT(20) },
> +	[RST_BUS_SPI1]		=  { 0x2c0, BIT(21) },
> +	[RST_BUS_SPI2]		=  { 0x2c0, BIT(22) },
> +	[RST_BUS_SPI3]		=  { 0x2c0, BIT(23) },
> +	[RST_BUS_SATA]		=  { 0x2c0, BIT(24) },
> +	[RST_BUS_OTG]		=  { 0x2c0, BIT(25) },
> +	[RST_BUS_EHCI0]		=  { 0x2c0, BIT(26) },
> +	[RST_BUS_EHCI1]		=  { 0x2c0, BIT(27) },
> +	[RST_BUS_EHCI2]		=  { 0x2c0, BIT(28) },
> +	[RST_BUS_OHCI0]		=  { 0x2c0, BIT(29) },
> +	[RST_BUS_OHCI1]		=  { 0x2c0, BIT(30) },
> +	[RST_BUS_OHCI2]		=  { 0x2c0, BIT(31) },
> +
> +	[RST_BUS_VE]		=  { 0x2c4, BIT(0) },
> +	[RST_BUS_DE_MP]		=  { 0x2c4, BIT(2) },
> +	[RST_BUS_DEINTERLACE]	=  { 0x2c4, BIT(5) },
> +	[RST_BUS_CSI0]		=  { 0x2c4, BIT(8) },
> +	[RST_BUS_CSI1]		=  { 0x2c4, BIT(9) },
> +	[RST_BUS_HDMI_SLOW]	=  { 0x2c4, BIT(10) },
> +	[RST_BUS_HDMI]		=  { 0x2c4, BIT(11) },
> +	[RST_BUS_DE]		=  { 0x2c4, BIT(12) },
> +	[RST_BUS_TVE0]		=  { 0x2c4, BIT(13) },
> +	[RST_BUS_TVE1]		=  { 0x2c4, BIT(14) },
> +	[RST_BUS_TVE_TOP]	=  { 0x2c4, BIT(15) },
> +	[RST_BUS_GMAC]		=  { 0x2c4, BIT(17) },
> +	[RST_BUS_GPU]		=  { 0x2c4, BIT(20) },
> +	[RST_BUS_TVD0]		=  { 0x2c4, BIT(21) },
> +	[RST_BUS_TVD1]		=  { 0x2c4, BIT(22) },
> +	[RST_BUS_TVD2]		=  { 0x2c4, BIT(23) },
> +	[RST_BUS_TVD3]		=  { 0x2c4, BIT(24) },
> +	[RST_BUS_TVD_TOP]	=  { 0x2c4, BIT(25) },
> +	[RST_BUS_TCON0]		=  { 0x2c4, BIT(26) },
> +	[RST_BUS_TCON1]		=  { 0x2c4, BIT(27) },
> +	[RST_BUS_TCON_TVE0]	=  { 0x2c4, BIT(28) },
> +	[RST_BUS_TCON_TVE1]	=  { 0x2c4, BIT(29) },
> +	[RST_BUS_TCON_TOP]	=  { 0x2c4, BIT(30) },
> +	[RST_BUS_DBG]		=  { 0x2c4, BIT(31) },
> +
> +	[RST_BUS_LVDS]		=  { 0x2c8, BIT(0) },
> +
> +	[RST_BUS_CODEC]		=  { 0x2d0, BIT(0) },
> +	[RST_BUS_SPDIF]		=  { 0x2d0, BIT(1) },
> +	[RST_BUS_AC97]		=  { 0x2d0, BIT(2) },
> +	[RST_BUS_IR0]		=  { 0x2d0, BIT(6) },
> +	[RST_BUS_IR1]		=  { 0x2d0, BIT(7) },
> +	[RST_BUS_THS]		=  { 0x2d0, BIT(8) },
> +	[RST_BUS_KEYPAD]	=  { 0x2d0, BIT(10) },
> +	[RST_BUS_I2S0]		=  { 0x2d0, BIT(12) },
> +	[RST_BUS_I2S1]		=  { 0x2d0, BIT(13) },
> +	[RST_BUS_I2S2]		=  { 0x2d0, BIT(14) },
> +
> +	[RST_BUS_I2C0]		=  { 0x2d8, BIT(0) },
> +	[RST_BUS_I2C1]		=  { 0x2d8, BIT(1) },
> +	[RST_BUS_I2C2]		=  { 0x2d8, BIT(2) },
> +	[RST_BUS_I2C3]		=  { 0x2d8, BIT(3) },
> +	[RST_BUS_CAN]		=  { 0x2d8, BIT(4) },
> +	[RST_BUS_SCR]		=  { 0x2d8, BIT(5) },
> +	[RST_BUS_PS20]		=  { 0x2d8, BIT(6) },
> +	[RST_BUS_PS21]		=  { 0x2d8, BIT(7) },
> +	[RST_BUS_I2C4]		=  { 0x2d8, BIT(15) },
> +	[RST_BUS_UART0]		=  { 0x2d8, BIT(16) },
> +	[RST_BUS_UART1]		=  { 0x2d8, BIT(17) },
> +	[RST_BUS_UART2]		=  { 0x2d8, BIT(18) },
> +	[RST_BUS_UART3]		=  { 0x2d8, BIT(19) },
> +	[RST_BUS_UART4]		=  { 0x2d8, BIT(20) },
> +	[RST_BUS_UART5]		=  { 0x2d8, BIT(21) },
> +	[RST_BUS_UART6]		=  { 0x2d8, BIT(22) },
> +	[RST_BUS_UART7]		=  { 0x2d8, BIT(23) },
> +};
> +
> +static const struct sunxi_ccu_desc sun8i_r40_ccu_desc = {
> +	.ccu_clks	= sun8i_r40_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun8i_r40_ccu_clks),
> +
> +	.hw_clks	= &sun8i_r40_hw_clks,
> +
> +	.resets		= sun8i_r40_ccu_resets,
> +	.num_resets	= ARRAY_SIZE(sun8i_r40_ccu_resets),
> +};
> +
> +static struct ccu_mux_nb sun8i_r40_cpu_nb = {
> +	.common		= &cpu_clk.common,
> +	.cm		= &cpu_clk.mux,
> +	.delay_us	= 1, /* > 8 clock cycles at 24 MHz */
> +	.bypass_index	= 1, /* index of 24 MHz oscillator */
> +};
> +
> +static void __init sun8i_r40_ccu_setup(struct device_node *node)
> +{
> +	void __iomem *reg;
> +	u32 val;
> +
> +	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +	if (IS_ERR(reg)) {
> +		pr_err("%s: Could not map the clock registers\n",
> +		       of_node_full_name(node));
> +		return;
> +	}
> +
> +	/* Force the PLL-Audio-1x divider to 4 */
> +	val = readl(reg + SUN8I_R40_PLL_AUDIO_REG);
> +	val &= ~GENMASK(19, 16);
> +	writel(val | (3 << 16), reg + SUN8I_R40_PLL_AUDIO_REG);
> +
> +	sunxi_ccu_probe(node, reg, &sun8i_r40_ccu_desc);
> +
> +	ccu_mux_notifier_register(pll_cpu_clk.common.hw.clk,
> +				  &sun8i_r40_cpu_nb);

Did you test cpufreq on it? IT's likely to miss the gating notifier...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170504/a5481b6a/attachment-0001.sig>
