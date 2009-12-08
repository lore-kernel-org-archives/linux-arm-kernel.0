From: Ladislav.Michl@seznam.cz (Ladislav Michl)
Date: Tue, 8 Dec 2009 14:17:46 +0100
Subject: [PATCH] [NAND] S3C2410: Fix NFC clock enable/disable imbalance
	(2nd try)
In-Reply-To: <200912081301.25597.jbe@pengutronix.de>
References: <200912081056.40210.jbe@pengutronix.de>
	<200912081123.06630.jbe@pengutronix.de>
	<200912081301.25597.jbe@pengutronix.de>
Message-ID: <20091208131746.GA1975@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2009 at 01:01:25PM +0100, Juergen Beisert wrote:
> When unmounting an mtd filesystem the s3c2410_nand_select_chip() function
> gets called again with "chip == -1". In this case the current code disables
> the NFC clock at least a second time, so it does not work anymore.
> Clock disabling should only happen if it was really enabled.
> 
> Due to a lack of a query function if a clock is already enabled (and how often),
> we must count enable/disable calls by our own here.
> 
> Note: Other enable/disable sequences can be found in the power management
> functions. I'm not sure if they interfere with this local enable/disable count.
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> Acked-by: Wolfram Sang <wsa@pengutronix.de>
> 
> ---
>  drivers/mtd/nand/s3c2410.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.32/drivers/mtd/nand/s3c2410.c
> ===================================================================
> --- linux-2.6.32.orig/drivers/mtd/nand/s3c2410.c
> +++ linux-2.6.32/drivers/mtd/nand/s3c2410.c
> @@ -329,12 +329,15 @@ static void s3c2410_nand_select_chip(str
>  	struct s3c2410_nand_mtd *nmtd;
>  	struct nand_chip *this = mtd->priv;
>  	unsigned long cur;
> +	static int clock_enable_cnt = 0;

It probably does not matter a lot, since there seem to be only one
nand controller and associated clock per system, but it would be
cleaner to move this variable into struct s3c2410_nand_info to allow
this driver eventually service multiple instances of nand controller.

>  	nmtd = this->priv;
>  	info = nmtd->info;
>  
> -	if (chip != -1 && allow_clk_stop(info))
> +	if (chip != -1 && allow_clk_stop(info)) {
>  		clk_enable(info->clk);
> +		clock_enable_cnt++;
> +	}
>  
>  	cur = readl(info->sel_reg);
>  
> @@ -356,8 +359,10 @@ static void s3c2410_nand_select_chip(str
>  
>  	writel(cur, info->sel_reg);
>  
> -	if (chip == -1 && allow_clk_stop(info))
> +	if (chip == -1 && allow_clk_stop(info) && clock_enable_cnt > 0) {
>  		clk_disable(info->clk);
> +		clock_enable_cnt--;
> +	}
>  }
>  
>  /* s3c2410_nand_hwcontrol
> 
> -- 
> Pengutronix e.K.                              | Juergen Beisert             |
> Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
> Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
