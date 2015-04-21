From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 21 Apr 2015 12:31:55 +0200
Subject: Question about checking rate_spi in pwrap_init_reg_clock
In-Reply-To: <1429581487.5994.1.camel@ingics.com>
References: <1429581487.5994.1.camel@ingics.com>
Message-ID: <20150421103155.GX6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 09:58:07AM +0800, Axel Lin wrote:
> hi,
> The implementation in pwrap_init_reg_clock seems has off-by-one bug.
> If rate_spi is 26000000, current code set ck_mhz to 18 rather than 26.
> 
> I guess it needs below fix, but I'm not 100% sure as I don't have the datasheet.
> Can someone confirm if this is a bug or not?

Yes, seems to be a bug. Thanks for noting. Will you send a formal patch
or should I do it?

sascha

> 
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index db5be1e..e910e19 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -568,9 +568,9 @@ static int pwrap_init_reg_clock(struct pmic_wrapper *wrp)
>  
>  	rate_spi = clk_get_rate(wrp->clk_spi);
>  
> -	if (rate_spi > 26000000)
> +	if (rate_spi >= 26000000)
>  		ck_mhz = 26;
> -	else if (rate_spi > 18000000)
> +	else if (rate_spi >= 18000000)
>  		ck_mhz = 18;
>  	else
>  		ck_mhz = 0;
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
