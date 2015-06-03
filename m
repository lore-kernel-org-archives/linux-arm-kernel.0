From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 03 Jun 2015 21:23:58 +0200
Subject: [PATCH 1/7] mtd: pxa3xx_nand: add a non mandatory ECC clock
In-Reply-To: <1433266351-22587-2-git-send-email-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Tue, 2 Jun 2015 19:32:25 +0200")
References: <1433266351-22587-1-git-send-email-antoine.tenart@free-electrons.com>
 <1433266351-22587-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <87bngw61f5.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antoine Tenart <antoine.tenart@free-electrons.com> writes:

> Some controllers (as the coming Berlin nand controller) need to enable
> an ECC clock. Add support for this clock in the pxa3xx nand driver, and
> leave it as non mandatory.
> -	info->clk = devm_clk_get(&pdev->dev, NULL);
> +	info->clk = devm_clk_get(&pdev->dev, "nfc");
>  	if (IS_ERR(info->clk)) {
> -		dev_err(&pdev->dev, "failed to get nand clock\n");
> -		return PTR_ERR(info->clk);
> +		info->clk = devm_clk_get(&pdev->dev, NULL);
> +
> +		if (IS_ERR(info->clk)) {
> +			dev_err(&pdev->dev, "failed to get nand clock\n");
> +			return PTR_ERR(info->clk);
> +		}
I suppose this is done to keep the compatibility with existing pxa3xx/berlin
clock code, which was defined without a con_id. More specifically I'm thinking
of the function clk_find().

Now maybe it would be cleaner to keep you "nfc" change, remove the failback plan
with NULL as an con_id, and change the clock providers. I cannot speak for
berlin/others, but for pxa3xx, this is one 3 hunks change in :
 - drivers/clk/pxa/clk-pxa3xx.c

Cheers.

--
Robert
