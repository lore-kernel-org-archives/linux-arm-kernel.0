From: jbe@pengutronix.de (Juergen Beisert)
Date: Tue, 8 Dec 2009 11:23:06 +0100
Subject: [PATCH] [NAND] S3C2410: Fix NFC clock enable/disable imbalance
In-Reply-To: <200912081056.40210.jbe@pengutronix.de>
References: <200912081056.40210.jbe@pengutronix.de>
Message-ID: <200912081123.06630.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

ups, forget this patch, does't work as expected (thanks Wolfram!). Will try 
again later...

Juergen Beisert wrote:
> When unmounting an mtd filesystem the s3c2410_nand_select_chip() function
> gets called again with "chip == -1". In this case the current code disables
> the NFC clock at least a second time, so it does not work anymore.
> Clock disabling should only happen if it was really enabled.
>
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
>
> ---
>  drivers/mtd/nand/s3c2410.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> Index: linux-2.6.32/drivers/mtd/nand/s3c2410.c
> ===================================================================
> --- linux-2.6.32.orig/drivers/mtd/nand/s3c2410.c
> +++ linux-2.6.32/drivers/mtd/nand/s3c2410.c
> @@ -329,12 +329,16 @@ static void s3c2410_nand_select_chip(str
>  	struct s3c2410_nand_mtd *nmtd;
>  	struct nand_chip *this = mtd->priv;
>  	unsigned long cur;
> +	int clock_enabled;
>
>  	nmtd = this->priv;
>  	info = nmtd->info;
>
> -	if (chip != -1 && allow_clk_stop(info))
> +	if (chip != -1 && allow_clk_stop(info)) {
>  		clk_enable(info->clk);
> +		clock_enabled = 1;
> +	} else
> +		clock_enabled = 0;
>
>  	cur = readl(info->sel_reg);
>
> @@ -356,7 +360,7 @@ static void s3c2410_nand_select_chip(str
>
>  	writel(cur, info->sel_reg);
>
> -	if (chip == -1 && allow_clk_stop(info))
> +	if (chip == -1 && allow_clk_stop(info) && clock_enabled != 0)
>  		clk_disable(info->clk);
>  }

Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
