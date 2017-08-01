From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 1 Aug 2017 13:49:22 +0200
Subject: [PATCH 2/6] mtd: oxnas_nand: Handle
 clk_prepare_enable/clk_disable_unprepare.
In-Reply-To: <1501587447-21079-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1501587447-21079-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <e30bab37-4aea-fad4-2ea0-912508bdaa80@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2017 01:37 PM, Arvind Yadav wrote:
>  - clk_prepare_enable() can fail here and we must check its return value.
>  - oxnas_nand_probe() can fail here and we must disable clock.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/mtd/nand/oxnas_nand.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/nand/oxnas_nand.c b/drivers/mtd/nand/oxnas_nand.c
> index 1b207aa..7061bb2 100644
> --- a/drivers/mtd/nand/oxnas_nand.c
> +++ b/drivers/mtd/nand/oxnas_nand.c
> @@ -112,14 +112,19 @@ static int oxnas_nand_probe(struct platform_device *pdev)
>  	if (count > 1)
>  		return -EINVAL;
>  
> -	clk_prepare_enable(oxnas->clk);
> +	err = clk_prepare_enable(oxnas->clk);
> +	if (err)
> +		return err;
> +
>  	device_reset_optional(&pdev->dev);
>  
>  	for_each_child_of_node(np, nand_np) {
>  		chip = devm_kzalloc(&pdev->dev, sizeof(struct nand_chip),
>  				    GFP_KERNEL);
> -		if (!chip)
> -			return -ENOMEM;
> +		if (!chip) {
> +			err = -ENOMEM;
> +			goto err_clk_unprepare;
> +		}
>  
>  		chip->controller = &oxnas->base;
>  
> @@ -139,12 +144,12 @@ static int oxnas_nand_probe(struct platform_device *pdev)
>  		/* Scan to find existence of the device */
>  		err = nand_scan(mtd, 1);
>  		if (err)
> -			return err;
> +			goto err_clk_unprepare;
>  
>  		err = mtd_device_register(mtd, NULL, 0);
>  		if (err) {
>  			nand_release(mtd);
> -			return err;
> +			goto err_clk_unprepare;
>  		}
>  
>  		oxnas->chips[nchips] = chip;
> @@ -152,12 +157,18 @@ static int oxnas_nand_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Exit if no chips found */
> -	if (!nchips)
> -		return -ENODEV;
> +	if (!nchips) {
> +		err = -ENODEV;
> +		goto err_clk_unprepare;
> +	}
>  
>  	platform_set_drvdata(pdev, oxnas);
>  
>  	return 0;
> +
> +err_clk_unprepare:
> +	clk_disable_unprepare(oxnas->clk);
> +	return err;
>  }
>  
>  static int oxnas_nand_remove(struct platform_device *pdev)
> 

Indeed, Thanks,
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
