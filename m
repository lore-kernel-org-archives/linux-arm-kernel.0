From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 10 May 2017 12:43:43 +0200
Subject: [PATCH] soc: mediatek: PMIC wrap: Fix error handling
In-Reply-To: <20170219131249.12010-1-christophe.jaillet@wanadoo.fr>
References: <20170219131249.12010-1-christophe.jaillet@wanadoo.fr>
Message-ID: <106d786b-165c-ae5e-5180-3b8126d9e8bc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/02/17 14:12, Christophe JAILLET wrote:
> According to error handling in this function, it is likely that going to
> 'err_out2' was expected here.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to v4.12-next/soc

Sorry for the delay.
Matthias

> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index a5f10936fb9c..285b434449a6 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -1200,7 +1200,8 @@ static int pwrap_probe(struct platform_device *pdev)
>   
>   	if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & PWRAP_STATE_INIT_DONE0)) {
>   		dev_dbg(wrp->dev, "initialization isn't finished\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto err_out2;
>   	}
>   
>   	/* Initialize watchdog, may not be done by the bootloader */
> @@ -1220,8 +1221,10 @@ static int pwrap_probe(struct platform_device *pdev)
>   		goto err_out2;
>   
>   	wrp->regmap = devm_regmap_init(wrp->dev, NULL, wrp, &pwrap_regmap_config);
> -	if (IS_ERR(wrp->regmap))
> -		return PTR_ERR(wrp->regmap);
> +	if (IS_ERR(wrp->regmap)) {
> +		ret = PTR_ERR(wrp->regmap);
> +		goto err_out2;
> +	}
>   
>   	ret = of_platform_populate(np, NULL, NULL, wrp->dev);
>   	if (ret) {
> 
