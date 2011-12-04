From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 4 Dec 2011 17:11:23 +0100
Subject: [RFC PATCH 2/3] pinctrl: imx: add pinmux-imx53 support
In-Reply-To: <1322999384-7886-2-git-send-email-b29396@freescale.com>
References: <1322999384-7886-1-git-send-email-b29396@freescale.com>
 <1322999384-7886-2-git-send-email-b29396@freescale.com>
Message-ID: <20111204161123.GS27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 04, 2011 at 07:49:43PM +0800, Dong Aisheng wrote:
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shanw.guo@freescale.com>
> ---
>  drivers/pinctrl/pinmux-imx53.c |  514 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 514 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinmux-imx53.c b/drivers/pinctrl/pinmux-imx53.c
> +
> +/* mx53 pin groups and mux mode */
> +static const unsigned mx53_fec_pins[] = {
> +	MX53_FEC_MDC,
> +	MX53_FEC_MDIO,
> +	MX53_FEC_REF_CLK,
> +	MX53_FEC_RX_ER,
> +	MX53_FEC_CRS_DV,
> +	MX53_FEC_RXD1,
> +	MX53_FEC_RXD0,
> +	MX53_FEC_TX_EN,
> +	MX53_FEC_TXD1,
> +	MX53_FEC_TXD0,
> +};
> +static const unsigned mx53_fec_mux[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

The FEC_MDC could be routed to PAD_KEY_ROW2 or to PAD_FEC_MDC. Also
FEC_MDIO could be routed to either PAD_FEC_MDIO or to PAD_KEY_COL2.
For other fec pins also different options might exist. How does this
fit into this group scheme?

> +
> +static const unsigned mx53_sd1_pins[] = {
> +	MX53_SD1_CMD,
> +	MX53_SD1_CLK,
> +	MX53_SD1_DATA0,
> +	MX53_SD1_DATA1,
> +	MX53_SD1_DATA2,
> +	MX53_SD1_DATA3,
> +
> +};
> +static const unsigned mx53_sd1_mux[] = { 0, 0, 0, 0, 0, 0 };
> +
> +static const unsigned mx53_sd3_pins[] = {
> +	MX53_PATA_DATA8,
> +	MX53_PATA_DATA9,
> +	MX53_PATA_DATA10,
> +	MX53_PATA_DATA11,
> +	MX53_PATA_DATA0,
> +	MX53_PATA_DATA1,
> +	MX53_PATA_DATA2,
> +	MX53_PATA_DATA3,
> +	MX53_PATA_IORDY,
> +	MX53_PATA_RESET_B,
> +
> +};
> +static const unsigned mx53_sd3_mux[] = { 4, 4, 4, 4, 4, 4, 4, 4, 2, 2 };
> +
> +static const unsigned mx53_uart1_pins[] = {
> +	MX53_CSI0_DAT10,
> +	MX53_CSI0_DAT11,
> +};
> +static const unsigned mx53_uart1_mux[] = { 2, 2 };

For uart1 indeed only one routing possibility exists, but look at uart2:

uart2 txd -> PAD_EIM_D26
	  -> PAD_PATA_DMARQ
	  -> PAD_GPIO_7

uart2 rxd -> PAD_EIM_D27
	  -> PAD_PATA_BUFFER_EN
	  -> PAD_GPIO_8

So this at least means that you should not name the array above
mx53_uart1_mux, but something like mx53_uart1_option1,
mx53_uart1_option2 and so on.

Then it's probably possible to use mixtures of different options
for the uart.

I don't think that this grouping of pads to their functions makes
sense. On i.MX every pad is muxed independently and not in groups.
Which pins belong to which function is board specific and not SoC
specific.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
