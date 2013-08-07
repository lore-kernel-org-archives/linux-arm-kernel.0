From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 7 Aug 2013 19:53:37 +0200
Subject: [PATCH 1/8] i2c: imx: use struct representing i2c clk{div,
 val} pair
In-Reply-To: <1375866343-2074-1-git-send-email-b35083@freescale.com>
References: <1375866343-2074-1-git-send-email-b35083@freescale.com>
Message-ID: <20130807175337.GQ26614@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nice improvement of this series.

There are some unnecessary blank lines in the definitions in 7/8 and
8/8, but otherwise:

reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

On Wed, Aug 07, 2013 at 05:05:36PM +0800, Jingchang Lu wrote:
> using struct representing the i2c clk{div, val} pair would
> make the i2c_clk_div array more clear.
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index e242797..9167d43 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -30,6 +30,8 @@
>   *	Copyright (C) 2007 RightHand Technologies, Inc.
>   *	Copyright (C) 2008 Darius Augulis <darius.augulis@teltonika.lt>
>   *
> + *	Copyright 2013 Freescale Semiconductor, Inc.
> + *
>   */
>  
>  /** Includes *******************************************************************
> @@ -95,8 +97,12 @@
>   *
>   * Duplicated divider values removed from list
>   */
> +struct imx_i2c_clk_pair {
> +	u16	div;
> +	u16	val;
> +};
>  
> -static u16 __initdata i2c_clk_div[50][2] = {
> +static struct imx_i2c_clk_pair __initdata i2c_clk_div[] = {
>  	{ 22,	0x20 }, { 24,	0x21 }, { 26,	0x22 }, { 28,	0x23 },
>  	{ 30,	0x00 },	{ 32,	0x24 }, { 36,	0x25 }, { 40,	0x26 },
>  	{ 42,	0x03 }, { 44,	0x27 },	{ 48,	0x28 }, { 52,	0x05 },
> @@ -274,15 +280,15 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
>  	/* Divider value calculation */
>  	i2c_clk_rate = clk_get_rate(i2c_imx->clk);
>  	div = (i2c_clk_rate + rate - 1) / rate;
> -	if (div < i2c_clk_div[0][0])
> +	if (div < i2c_clk_div[0].div)
>  		i = 0;
> -	else if (div > i2c_clk_div[ARRAY_SIZE(i2c_clk_div) - 1][0])
> +	else if (div > i2c_clk_div[ARRAY_SIZE(i2c_clk_div) - 1].div)
>  		i = ARRAY_SIZE(i2c_clk_div) - 1;
>  	else
> -		for (i = 0; i2c_clk_div[i][0] < div; i++);
> +		for (i = 0; i2c_clk_div[i].div < div; i++);
>  
>  	/* Store divider value */
> -	i2c_imx->ifdr = i2c_clk_div[i][1];
> +	i2c_imx->ifdr = i2c_clk_div[i].val;
>  
>  	/*
>  	 * There dummy delay is calculated.
> @@ -290,7 +296,7 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
>  	 * This delay is used in I2C bus disable function
>  	 * to fix chip hardware bug.
>  	 */
> -	i2c_imx->disable_delay = (500000U * i2c_clk_div[i][0]
> +	i2c_imx->disable_delay = (500000U * i2c_clk_div[i].div
>  		+ (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
>  
>  	/* dev_dbg() can't be used, because adapter is not yet registered */
> @@ -298,7 +304,7 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> I2C_CLK=%d, REQ DIV=%d\n",
>  		__func__, i2c_clk_rate, div);
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s> IFDR[IC]=0x%x, REAL DIV=%d\n",
> -		__func__, i2c_clk_div[i][1], i2c_clk_div[i][0]);
> +		__func__, i2c_clk_div[i].val, i2c_clk_div[i].div);
>  #endif
>  }
>  
> -- 
> 1.8.0
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
