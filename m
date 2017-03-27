From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 27 Mar 2017 20:19:49 +0200
Subject: [PATCH v2 1/2] mtd: nand: orion: fix clk handling
In-Reply-To: <20170327180208.13414-1-gmbnomis@gmail.com>
References: <20170327180208.13414-1-gmbnomis@gmail.com>
Message-ID: <20170327181949.isafnqsnxkzed5nv@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> @@ -145,15 +151,13 @@ static int __init orion_nand_probe(struct platform_device *pdev)
>  	if (board->dev_ready)
>  		nc->dev_ready = board->dev_ready;
>  
> -	platform_set_drvdata(pdev, mtd);
> +	platform_set_drvdata(pdev, info);
>  
>  	/* Not all platforms can gate the clock, so it is not
>  	   an error if the clock does not exists. */
> -	clk = clk_get(&pdev->dev, NULL);
> -	if (!IS_ERR(clk)) {
> -		clk_prepare_enable(clk);
> -		clk_put(clk);
> -	}
> +	info->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (!IS_ERR(info->clk))
> +		clk_prepare_enable(info->clk);

you could to the following here instead:

	info->clk = devm_clk_get(&pdev->dev, NULL);
	if (IS_ERR(info->clk))
		/*
		 * We ignore all errors here, that's wrong but only for
		 * one commit.
		 */
		info->clk = NULL;

	ret = clk_prepare_enable(info->clk);
	if (ret) ...

>  	ret = nand_scan(mtd, 1);
>  	if (ret)
> @@ -169,26 +173,22 @@ static int __init orion_nand_probe(struct platform_device *pdev)
>  	return 0;
>  
>  no_dev:
> -	if (!IS_ERR(clk)) {
> -		clk_disable_unprepare(clk);
> -		clk_put(clk);
> -	}
> +	if (!IS_ERR(info->clk))
> +		clk_disable_unprepare(info->clk);

this simplifies to

	clk_disable_unprepare(info->clk);

then.

>  
>  	return ret;
>  }
>  
>  static int orion_nand_remove(struct platform_device *pdev)
>  {
> -	struct mtd_info *mtd = platform_get_drvdata(pdev);
> -	struct clk *clk;
> +	struct orion_nand_info *info = platform_get_drvdata(pdev);
> +	struct nand_chip *chip = &info->chip;
> +	struct mtd_info *mtd = nand_to_mtd(chip);
>  
>  	nand_release(mtd);
>  
> -	clk = clk_get(&pdev->dev, NULL);
> -	if (!IS_ERR(clk)) {
> -		clk_disable_unprepare(clk);
> -		clk_put(clk);
> -	}
> +	if (!IS_ERR(info->clk))
> +		clk_disable_unprepare(info->clk);

ditto.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
