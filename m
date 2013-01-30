From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 30 Jan 2013 13:10:29 -0700
Subject: [PATCH 4/4] pinctrl/abx500: destroy mutex if returning early
 due to error
In-Reply-To: <1359574822-15729-1-git-send-email-linus.walleij@stericsson.com>
References: <1359574822-15729-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <51097E35.6080100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2013 12:40 PM, Linus Walleij wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> Current failure path neglects to mutex_destroy() before returning
> an error due to an invalid parameter or an error received from
> gpiochip_add(). This patch aims to remedy that behaviour.

> diff --git a/drivers/pinctrl/pinctrl-abx500.c b/drivers/pinctrl/pinctrl-abx500.c

> @@ -1155,11 +1155,13 @@ static int abx500_gpio_probe(struct platform_device *pdev)
>  	default:
>  		dev_err(&pdev->dev, "Unsupported pinctrl sub driver (%d)\n",
>  				(int) platid->driver_data);
> +		mutex_destroy(&pct->lock);
>  		return -EINVAL;

Especially given there's already a label out_free which performs this
mutex_destroy(), those last two lines would be better as:

ret = -EINVAL;
goto out_free;

>  	}
>  
>  	if (!pct->soc) {
>  		dev_err(&pdev->dev, "Invalid SOC data\n");
> +		mutex_destroy(&pct->lock);
>  		return -EINVAL;

Same there.

>  	}
>  
> @@ -1176,6 +1178,7 @@ static int abx500_gpio_probe(struct platform_device *pdev)
>  	ret = gpiochip_add(&pct->chip);
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to add gpiochip: %d\n", ret);
> +		mutex_destroy(&pct->lock);
>  		goto out_rem_irq;

And here, just change the goto target to out_free rather than adding the
mutex_destroy() call.
