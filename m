From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 16 Dec 2010 10:51:05 +0100
Subject: [PATCH v6 08/15] ARM: mxs: Add iomux support
In-Reply-To: <1292244903-30392-6-git-send-email-shawn.guo@freescale.com>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
	<1292244903-30392-6-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101216095105.GG1940@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Mon, Dec 13, 2010 at 08:55:02PM +0800, Shawn Guo wrote:
> +/*
> + * The naming convention for the pad modes is MX28_PAD_<padname>__<padmode>
> + * If <padname> or <padmode> refers to a GPIO, it is named GPIO_<unit>_<num>
> + * See also iomux.h
> + *
> + *							    BANK PIN     MUX            VOL          MA            PULL
> + */
> +/* DUART */
> +#define MX28_PAD_PWM0__DUART_RX			MXS_IOMUX_PAD(3, 16, PAD_MUXSEL_2,    PAD_3V3,     PAD_4MA,      PAD_NOPULL)
> +#define MX28_PAD_PWM1__DUART_TX			MXS_IOMUX_PAD(3, 17, PAD_MUXSEL_2,    PAD_3V3,     PAD_4MA,      PAD_NOPULL)
> +
> +/* FEC */
> +#define MX28_PAD_ENET0_MDC__ENET0_MDC		MXS_IOMUX_PAD(4, 0,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET0_MDIO__ENET0_MDIO		MXS_IOMUX_PAD(4, 1,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET0_RX_EN__ENET0_RX_EN	MXS_IOMUX_PAD(4, 2,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET0_RXD0__ENET0_RXD0		MXS_IOMUX_PAD(4, 3,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET0_RXD1__ENET0_RXD1		MXS_IOMUX_PAD(4, 4,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET0_TX_EN__ENET0_TX_EN	MXS_IOMUX_PAD(4, 6,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET0_TXD0__ENET0_TXD0		MXS_IOMUX_PAD(4, 7,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET0_TXD1__ENET0_TXD1		MXS_IOMUX_PAD(4, 8,  PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +#define MX28_PAD_ENET_CLK__ENET_CLK		MXS_IOMUX_PAD(4, 16, PAD_MUXSEL_0,    PAD_3V3,     PAD_8MA,      PAD_PULLUP)
> +
> +/* GPIO */
> +#define MX28_PAD_SSP1_DATA3__GPIO_2_15		MXS_IOMUX_PAD(2, 15, PAD_MUXSEL_GPIO, PAD_3V3,     PAD_4MA,      PAD_NOPULL)
> +#define MX28_PAD_ENET0_RX_CLK__GPIO_4_13	MXS_IOMUX_PAD(4, 13, PAD_MUXSEL_GPIO, PAD_3V3,     PAD_4MA,      PAD_NOPULL)

Can we please have a defined order for these definitions?  I suggest to
sort by the arguments to MXS_IOMUX_PAD.

Moreover to be able to benefit from iomux_cfg_t being an integer type it
would be great to have the generic defines use PAD_VOL_NONE, PAD_MA_NONE
and PAD_NOPULL and let these constants have the value 0 to be able to
simply say:

	static const mxs_iomux_cfg_t my_pads[] = {
		MX28_PAD_SSP1_DATA3__GPIO_2_15 | PAD_PULLUP,
		...
	};

And it would be nice to get all pad definitions at once generated from
the Freescale Excel sheet.  Lothar Wa?mann already did that based on one
of your first versions of this series.  I can provide it to you via
private mail if you think this might be easier for you.  For plat-mxc
starting with the complete definitions prooved to be the better approach
because otherwise you get many merge conflicts and typing errors.

BTW, when Lothar did the conversion he found one mismatch between your
patch and the Excel sheet.  You had MX28_PAD_ENET_CLK__ENET_CLK while
the table had MX28_PAD_ENET_CLK__CLKCTRL_ENET.  I didn't check which of
these is consistent with the reference manual.

(Most of these suggestions are from Lothar, I'm just the messenger here,
but I'm of the same mind.)

Best regards,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
