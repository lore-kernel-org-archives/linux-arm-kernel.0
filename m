From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 6 Apr 2010 13:05:46 +0200
Subject: arch/arm/mach-mx3/clock-imx35.c
In-Reply-To: <201004051029.24242.a.babich@rez.ru>
References: <201004051029.24242.a.babich@rez.ru>
Message-ID: <20100406110546.GC3688@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Added alkml to cc:]

Please do not send patches to me directly without ccing the list.

On Mon, Apr 05, 2010 at 10:29:24AM +0600, Alexei Babich wrote:
> Good morning, Sascha.
> I propose a patch for get_rate_uart () UART for iMX35:
> 
> ----
> diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
> index 9f3e943..04bff7c 100644
> --- a/arch/arm/mach-mx3/clock-imx35.c
> +++ b/arch/arm/mach-mx3/clock-imx35.c
> @@ -185,7 +185,7 @@ static unsigned long get_rate_uart(struct clk *clk)
>  {
>         unsigned long pdr3 = __raw_readl(CCM_BASE + CCM_PDR3);
>         unsigned long pdr4 = __raw_readl(CCM_BASE + CCM_PDR4);
> -       unsigned long div = get_3_3_div(pdr4 >> 10);
> +       unsigned long div = ((pdr4 >> 10) & 0x3f) + 1;

The get_3_3_div function was implemented based on an old datasheet which
describes the dividers as

(div[5:3] + 1) * (div[2:0] + 1)

Looking at the current datasheet it seems that Freescale dropped this
completely and the actual divider is just register value + 1.

I don't know if there is hardware around which needs get_3_3_div or if
we can drop this function completely. Does anyone have information about
this?

Anyway, this is not the only place affected. The otg clock, perclk0, csi
and sdhc clock need a fix aswell.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
