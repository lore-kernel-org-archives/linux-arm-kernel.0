From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 10 Oct 2013 00:41:08 +0200
Subject: [PATCH] sh-pfc: r8a7791 PFC support
In-Reply-To: <20131008040824.3480.69707.sendpatchset@w520>
References: <20131008040824.3480.69707.sendpatchset@w520>
Message-ID: <1876860.l29tzQeBi6@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

Thank you for the patch.

On Tuesday 08 October 2013 13:08:24 Magnus Damm wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> 
> Add PFC support for the r8a7791 SoC including pin groups for
> on-chip devices such as MSIOF, SCIF, USB, MMC, VIN, SDHI, DU.
> 
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Kunihito Higashiyama <kunihito.higashiyama.ur@renesas.com>
> Signed-off-by: Yoshikazu Fujikawa <yoshikazu.fujikawa.ue@renesas.com>
> Signed-off-by: Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>
> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> [damm at opensource.se: Forward ported to upstream, reused existing sh-pfc
> macros] Signed-off-by: Magnus Damm <damm@opensource.se>

I'll trust you for having reviewed all the data tables :-D

> ---
> 
>  Written against renesas-devel-20131004
> 
>  Based on the following broken out patches from BSP v0.5.0:
>  0739, 0766, 0771, 0774, 0777, 0782, 0798, 1056, 1057, 1235, 1261, 1271
> 
>  drivers/pinctrl/sh-pfc/Kconfig       |    5
>  drivers/pinctrl/sh-pfc/Makefile      |    1
>  drivers/pinctrl/sh-pfc/core.c        |    3
>  drivers/pinctrl/sh-pfc/core.h        |    1
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 4327 +++++++++++++++++++++++++++++++
>  5 files changed, 4337 insertions(+)
> 

[snip]

> --- 0001/drivers/pinctrl/sh-pfc/core.c
> +++ work/drivers/pinctrl/sh-pfc/core.c	2013-10-08 12:43:03.000000000 +0900
> @@ -558,6 +558,9 @@ static const struct platform_device_id s
>  #ifdef CONFIG_PINCTRL_PFC_R8A7790
>  	{ "pfc-r8a7790", (kernel_ulong_t)&r8a7790_pinmux_info },
>  #endif
> +#ifdef CONFIG_PINCTRL_PFC_R8A7791
> +	{ "pfc-r8a7791", (kernel_ulong_t)&r8a7791_pinmux_info },
> +#endif
>  #ifdef CONFIG_PINCTRL_PFC_SH7203
>  	{ "pfc-sh7203", (kernel_ulong_t)&sh7203_pinmux_info },
>  #endif

You should also update the sh_pfc_of_table array.

> --- /dev/null
> +++ work/drivers/pinctrl/sh-pfc/pfc-r8a7791.c	2013-10-08 
12:46:46.000000000
> +0900 @@ -0,0 +1,4327 @@
> +/*
> + * arch/arm/cpu/armv7/rmobile/pfc-r8a7791.c

The file seems to have moved :-) You can probably just remove the file name, 
it doesn't add much and only asks for getting outdated.

> + *     This file is r8a7791 processor support - PFC hardware block.
> + *
> + * Copyright (C) 2013 Renesas Electronics Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software Foundation,
> + * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

You can remove the last two paragraphs.

> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/platform_data/gpio-rcar.h>
> +
> +#include "core.h"
> +#include "sh_pfc.h"

[snip]

> +static struct sh_pfc_pin pinmux_pins[] = {
> +	PINMUX_GPIO_GP_ALL(),
> +};

[snip]

> +/* - ETH
> -------------------------------------------------------------------- */
> +static const unsigned int eth_link_pins[] = {
> +	/* LINK */
> +	RCAR_GP_PIN(5, 18),
> +};
> +static const unsigned int eth_link_mux[] = {
> +	ETH_LINK_MARK,
> +};
> +static const unsigned int eth_magic_pins[] = {
> +	/* MAGIC */

I've seen an errata for a different SoC that renamed the ethernet "magic" pin 
to "wol" (wake-on-lan). Could you check whether that has been done for R8A7791 
as well ?

> +	RCAR_GP_PIN(5, 22),
> +};
> +static const unsigned int eth_magic_mux[] = {
> +	ETH_MAGIC_MARK,
> +};
> +static const unsigned int eth_mdio_pins[] = {
> +	/* MDC, MDIO */
> +	RCAR_GP_PIN(5, 24), RCAR_GP_PIN(5, 13),
> +};
> +static const unsigned int eth_mdio_mux[] = {
> +	ETH_MDC_MARK, ETH_MDIO_MARK,
> +};
> +static const unsigned int eth_rmii_pins[] = {
> +	/* RXD[0:1], RX_ER, CRS_DV, TXD[0:1], TX_EN, REF_CLK */
> +	RCAR_GP_PIN(5, 16), RCAR_GP_PIN(5, 17), RCAR_GP_PIN(5, 15),
> +	RCAR_GP_PIN(5, 14), RCAR_GP_PIN(5, 23), RCAR_GP_PIN(5, 20),
> +	RCAR_GP_PIN(5, 21), RCAR_GP_PIN(5, 19),
> +};
> +static const unsigned int eth_rmii_mux[] = {
> +	ETH_RXD0_MARK, ETH_RXD1_MARK, ETH_RX_ER_MARK, ETH_CRS_DV_MARK,
> +	ETH_TXD0_MARK, ETH_TXD1_MARK, ETH_TX_EN_MARK, ETH_REFCLK_MARK,
> +};

[snip]

> +/* - VIN0
> ------------------------------------------------------------------- */
> +static const unsigned int vin0_data_g_pins[] = {
> +	RCAR_GP_PIN(4, 13), RCAR_GP_PIN(4, 14), RCAR_GP_PIN(4, 15),
> +	RCAR_GP_PIN(4, 16), RCAR_GP_PIN(4, 17), RCAR_GP_PIN(4, 18),
> +	RCAR_GP_PIN(4, 19), RCAR_GP_PIN(4, 20),
> +};
> +static const unsigned int vin0_data_g_mux[] = {
> +	VI0_G0_MARK, VI0_G1_MARK, VI0_G2_MARK,
> +	VI0_G3_MARK, VI0_G4_MARK, VI0_G5_MARK,
> +	VI0_G6_MARK, VI0_G7_MARK,
> +};
> +static const unsigned int vin0_data_r_pins[] = {
> +	RCAR_GP_PIN(4, 21), RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 23),
> +	RCAR_GP_PIN(4, 24), RCAR_GP_PIN(4, 25), RCAR_GP_PIN(4, 26),
> +	RCAR_GP_PIN(4, 27), RCAR_GP_PIN(4, 28),
> +};
> +static const unsigned int vin0_data_r_mux[] = {
> +	VI0_R0_MARK, VI0_R1_MARK, VI0_R2_MARK,
> +	VI0_R3_MARK, VI0_R4_MARK, VI0_R5_MARK,
> +	VI0_R6_MARK, VI0_R7_MARK,
> +};
> +static const unsigned int vin0_data_b_pins[] = {
> +	RCAR_GP_PIN(4, 5), RCAR_GP_PIN(4, 6), RCAR_GP_PIN(4, 7),
> +	RCAR_GP_PIN(4, 8), RCAR_GP_PIN(4, 9), RCAR_GP_PIN(4, 10),
> +	RCAR_GP_PIN(4, 11), RCAR_GP_PIN(4, 12),
> +};
> +static const unsigned int vin0_data_b_mux[] = {
> +	VI0_DATA0_VI0_B0_MARK, VI0_DATA1_VI0_B1_MARK, VI0_DATA2_VI0_B2_MARK,
> +	VI0_DATA3_VI0_B3_MARK, VI0_DATA4_VI0_B4_MARK, VI0_DATA5_VI0_B5_MARK,
> +	VI0_DATA6_VI0_B6_MARK, VI0_DATA7_VI0_B7_MARK,
> +};

The red, green and blue signals need to be used together, shouldn't they be 
grouped ?

> +static const unsigned int vin0_hsync_signal_pins[] = {
> +	RCAR_GP_PIN(4, 3),
> +};
> +static const unsigned int vin0_hsync_signal_mux[] = {
> +	VI0_HSYNC_N_MARK,
> +};
> +static const unsigned int vin0_vsync_signal_pins[] = {
> +	RCAR_GP_PIN(4, 4),
> +};
> +static const unsigned int vin0_vsync_signal_mux[] = {
> +	VI0_VSYNC_N_MARK,
> +};

Same for hsync and vsync. You could also s/_signal// here and below.

> +static const unsigned int vin0_field_signal_pins[] = {
> +	RCAR_GP_PIN(4, 2),
> +};
> +static const unsigned int vin0_field_signal_mux[] = {
> +	VI0_FIELD_MARK,
> +};
> +static const unsigned int vin0_data_enable_pins[] = {
> +	RCAR_GP_PIN(4, 1),
> +};
> +static const unsigned int vin0_data_enable_mux[] = {
> +	VI0_CLKENB_MARK,
> +};
> +static const unsigned int vin0_clk_pins[] = {
> +	RCAR_GP_PIN(4, 0),
> +};
> +static const unsigned int vin0_clk_mux[] = {
> +	VI0_CLK_MARK,
> +};
> +/* - VIN1
> ------------------------------------------------------------------- */
> +static const unsigned int vin1_data_pins[] = {
> +	RCAR_GP_PIN(5, 5), RCAR_GP_PIN(5, 6), RCAR_GP_PIN(5, 7),
> +	RCAR_GP_PIN(5, 8), RCAR_GP_PIN(5, 9), RCAR_GP_PIN(5, 10),
> +	RCAR_GP_PIN(5, 11), RCAR_GP_PIN(5, 12),
> +};
> +static const unsigned int vin1_data_mux[] = {
> +	VI1_DATA0_B_MARK, VI1_DATA1_B_MARK, VI1_DATA2_B_MARK,
> +	VI1_DATA3_B_MARK, VI1_DATA4_B_MARK, VI1_DATA5_B_MARK,
> +	VI1_DATA6_B_MARK, VI1_DATA7_B_MARK,
> +};
> +static const unsigned int vin1_clk_pins[] = {
> +	RCAR_GP_PIN(5, 4),
> +};
> +static const unsigned int vin1_clk_mux[] = {
> +	VI1_CLK_MARK,
> +};

No synchronization signals for vin1 ?

> +static const struct sh_pfc_pin_group pinmux_groups[] = {
> +	SH_PFC_PIN_GROUP(du_rgb666),
> +	SH_PFC_PIN_GROUP(du_rgb888),
> +	SH_PFC_PIN_GROUP(du_clk_out_0),
> +	SH_PFC_PIN_GROUP(du_clk_out_1),
> +	SH_PFC_PIN_GROUP(du_sync_1),
> +	SH_PFC_PIN_GROUP(du_cde_disp),
> +	SH_PFC_PIN_GROUP(du1_clk_in),
> +	SH_PFC_PIN_GROUP(du0_clk_in),

du0 should come before du1.

> +	SH_PFC_PIN_GROUP(eth_link),
> +	SH_PFC_PIN_GROUP(eth_magic),
> +	SH_PFC_PIN_GROUP(eth_mdio),
> +	SH_PFC_PIN_GROUP(eth_rmii),
> +	SH_PFC_PIN_GROUP(intc_irq0),
> +	SH_PFC_PIN_GROUP(intc_irq1),
> +	SH_PFC_PIN_GROUP(intc_irq2),
> +	SH_PFC_PIN_GROUP(intc_irq3),
> +	SH_PFC_PIN_GROUP(mmc_data1),
> +	SH_PFC_PIN_GROUP(mmc_data4),
> +	SH_PFC_PIN_GROUP(mmc_data8),
> +	SH_PFC_PIN_GROUP(mmc_ctrl),
> +	SH_PFC_PIN_GROUP(msiof0_clk),
> +	SH_PFC_PIN_GROUP(msiof0_sync),
> +	SH_PFC_PIN_GROUP(msiof0_ss1),
> +	SH_PFC_PIN_GROUP(msiof0_ss2),
> +	SH_PFC_PIN_GROUP(msiof0_rx),
> +	SH_PFC_PIN_GROUP(msiof0_tx),
> +	SH_PFC_PIN_GROUP(msiof1_clk),
> +	SH_PFC_PIN_GROUP(msiof1_sync),
> +	SH_PFC_PIN_GROUP(msiof1_ss1),
> +	SH_PFC_PIN_GROUP(msiof1_ss2),
> +	SH_PFC_PIN_GROUP(msiof1_rx),
> +	SH_PFC_PIN_GROUP(msiof1_tx),
> +	SH_PFC_PIN_GROUP(msiof2_clk),
> +	SH_PFC_PIN_GROUP(msiof2_sync),
> +	SH_PFC_PIN_GROUP(msiof2_ss1),
> +	SH_PFC_PIN_GROUP(msiof2_ss2),
> +	SH_PFC_PIN_GROUP(msiof2_rx),
> +	SH_PFC_PIN_GROUP(msiof2_tx),
> +	SH_PFC_PIN_GROUP(scif0_data),
> +	SH_PFC_PIN_GROUP(scif0_data_b),
> +	SH_PFC_PIN_GROUP(scif0_data_c),
> +	SH_PFC_PIN_GROUP(scif0_data_d),
> +	SH_PFC_PIN_GROUP(scif0_data_e),
> +	SH_PFC_PIN_GROUP(scif1_data),
> +	SH_PFC_PIN_GROUP(scif1_data_b),
> +	SH_PFC_PIN_GROUP(scif1_clk_b),
> +	SH_PFC_PIN_GROUP(scif1_data_c),
> +	SH_PFC_PIN_GROUP(scif1_data_d),
> +	SH_PFC_PIN_GROUP(scif2_data),
> +	SH_PFC_PIN_GROUP(scif2_data_b),
> +	SH_PFC_PIN_GROUP(scif2_clk_b),
> +	SH_PFC_PIN_GROUP(scif2_data_c),
> +	SH_PFC_PIN_GROUP(scif2_data_e),
> +	SH_PFC_PIN_GROUP(scif3_data),
> +	SH_PFC_PIN_GROUP(scif3_clk),
> +	SH_PFC_PIN_GROUP(scif3_data_b),
> +	SH_PFC_PIN_GROUP(scif3_clk_b),
> +	SH_PFC_PIN_GROUP(scif3_data_c),
> +	SH_PFC_PIN_GROUP(scif3_data_d),
> +	SH_PFC_PIN_GROUP(scif4_data),
> +	SH_PFC_PIN_GROUP(scif4_data_b),
> +	SH_PFC_PIN_GROUP(scif4_data_c),
> +	SH_PFC_PIN_GROUP(scif5_data),
> +	SH_PFC_PIN_GROUP(scif5_data_b),
> +	SH_PFC_PIN_GROUP(scifa0_data),
> +	SH_PFC_PIN_GROUP(scifa0_data_b),
> +	SH_PFC_PIN_GROUP(scifa1_data),
> +	SH_PFC_PIN_GROUP(scifa1_clk),
> +	SH_PFC_PIN_GROUP(scifa1_data_b),
> +	SH_PFC_PIN_GROUP(scifa1_clk_b),
> +	SH_PFC_PIN_GROUP(scifa1_data_c),
> +	SH_PFC_PIN_GROUP(scifa2_data),
> +	SH_PFC_PIN_GROUP(scifa2_clk),
> +	SH_PFC_PIN_GROUP(scifa2_data_b),
> +	SH_PFC_PIN_GROUP(scifa3_data),
> +	SH_PFC_PIN_GROUP(scifa3_clk),
> +	SH_PFC_PIN_GROUP(scifa3_data_b),
> +	SH_PFC_PIN_GROUP(scifa3_clk_b),
> +	SH_PFC_PIN_GROUP(scifa3_data_c),
> +	SH_PFC_PIN_GROUP(scifa3_clk_c),
> +	SH_PFC_PIN_GROUP(scifa4_data),
> +	SH_PFC_PIN_GROUP(scifa4_data_b),
> +	SH_PFC_PIN_GROUP(scifa4_data_c),
> +	SH_PFC_PIN_GROUP(scifa5_data),
> +	SH_PFC_PIN_GROUP(scifa5_data_b),
> +	SH_PFC_PIN_GROUP(scifa5_data_c),
> +	SH_PFC_PIN_GROUP(scifb0_data),
> +	SH_PFC_PIN_GROUP(scifb0_clk),
> +	SH_PFC_PIN_GROUP(scifb0_ctrl),
> +	SH_PFC_PIN_GROUP(scifb0_data_b),
> +	SH_PFC_PIN_GROUP(scifb0_clk_b),
> +	SH_PFC_PIN_GROUP(scifb0_ctrl_b),
> +	SH_PFC_PIN_GROUP(scifb0_data_c),
> +	SH_PFC_PIN_GROUP(scifb0_clk_c),
> +	SH_PFC_PIN_GROUP(scifb0_data_d),
> +	SH_PFC_PIN_GROUP(scifb0_clk_d),
> +	SH_PFC_PIN_GROUP(scifb1_data),
> +	SH_PFC_PIN_GROUP(scifb1_clk),
> +	SH_PFC_PIN_GROUP(scifb1_ctrl),
> +	SH_PFC_PIN_GROUP(scifb1_data_b),
> +	SH_PFC_PIN_GROUP(scifb1_clk_b),
> +	SH_PFC_PIN_GROUP(scifb1_data_c),
> +	SH_PFC_PIN_GROUP(scifb1_clk_c),
> +	SH_PFC_PIN_GROUP(scifb1_data_d),
> +	SH_PFC_PIN_GROUP(scifb2_data),
> +	SH_PFC_PIN_GROUP(scifb2_clk),
> +	SH_PFC_PIN_GROUP(scifb2_ctrl),
> +	SH_PFC_PIN_GROUP(scifb2_data_b),
> +	SH_PFC_PIN_GROUP(scifb2_clk_b),
> +	SH_PFC_PIN_GROUP(scifb2_ctrl_b),
> +	SH_PFC_PIN_GROUP(scifb2_data_c),
> +	SH_PFC_PIN_GROUP(scifb2_clk_c),
> +	SH_PFC_PIN_GROUP(scifb2_data_d),
> +	SH_PFC_PIN_GROUP(sdhi0_data1),
> +	SH_PFC_PIN_GROUP(sdhi0_data4),
> +	SH_PFC_PIN_GROUP(sdhi0_ctrl),
> +	SH_PFC_PIN_GROUP(sdhi0_cd),
> +	SH_PFC_PIN_GROUP(sdhi0_wp),
> +	SH_PFC_PIN_GROUP(sdhi1_data1),
> +	SH_PFC_PIN_GROUP(sdhi1_data4),
> +	SH_PFC_PIN_GROUP(sdhi1_ctrl),
> +	SH_PFC_PIN_GROUP(sdhi1_cd),
> +	SH_PFC_PIN_GROUP(sdhi1_wp),
> +	SH_PFC_PIN_GROUP(sdhi2_data1),
> +	SH_PFC_PIN_GROUP(sdhi2_data4),
> +	SH_PFC_PIN_GROUP(sdhi2_ctrl),
> +	SH_PFC_PIN_GROUP(sdhi2_cd),
> +	SH_PFC_PIN_GROUP(sdhi2_wp),
> +	SH_PFC_PIN_GROUP(usb0_pwen),
> +	SH_PFC_PIN_GROUP(usb0_ovc),
> +	SH_PFC_PIN_GROUP(usb1_pwen),
> +	SH_PFC_PIN_GROUP(usb1_ovc),
> +	SH_PFC_PIN_GROUP(vin0_data_g),
> +	SH_PFC_PIN_GROUP(vin0_data_r),
> +	SH_PFC_PIN_GROUP(vin0_data_b),
> +	SH_PFC_PIN_GROUP(vin0_hsync_signal),
> +	SH_PFC_PIN_GROUP(vin0_vsync_signal),
> +	SH_PFC_PIN_GROUP(vin0_field_signal),
> +	SH_PFC_PIN_GROUP(vin0_data_enable),
> +	SH_PFC_PIN_GROUP(vin0_clk),
> +	SH_PFC_PIN_GROUP(vin1_data),
> +	SH_PFC_PIN_GROUP(vin1_clk),
> +};
> +
> +static const char * const du_groups[] = {
> +	"du_rgb666",
> +	"du_rgb888",
> +	"du_clk_out_0",
> +	"du_clk_out_1",
> +	"du_sync_1",
> +	"du_cde_disp",
> +};
> +
> +static const char * const du1_groups[] = {
> +	"du1_clk_in",
> +};
> +
> +static const char * const du0_groups[] = {
> +	"du0_clk_in",
> +};

And here too.

-- 
Regards,

Laurent Pinchart
