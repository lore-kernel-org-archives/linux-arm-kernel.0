From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 18 Sep 2012 08:51:59 -0600
Subject: [PATCH] i2c: i2c-gpio: fix issue when DT node greater than 1
In-Reply-To: <1347958949-5598-1-git-send-email-voice.shen@atmel.com>
References: <1347958949-5598-1-git-send-email-voice.shen@atmel.com>
Message-ID: <50588A8F.30203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2012 03:02 AM, Bo Shen wrote:
> When i2c-gpio node number is greater than 1, the second can not sucessfully
> regiter
> 
> Using alias method to get the pdev->id, or else the second device will use
> the same id which will cause fail to register

pdev->id shouldn't be used at all with device tree. Why does
registration fail without this change?

> diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
> index e62d2d9..051fbb3 100644
> --- a/drivers/i2c/busses/i2c-gpio.c
> +++ b/drivers/i2c/busses/i2c-gpio.c
> @@ -136,6 +136,7 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
>  		ret = of_i2c_gpio_probe(pdev->dev.of_node, pdata);
>  		if (ret)
>  			return ret;
> +		pdev->id = of_alias_get_id(pdev->dev.of_node, "i2c-gpio");
>  	} else {
>  		if (!pdev->dev.platform_data)
>  			return -ENXIO;
> 
