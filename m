From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 20 Apr 2016 11:01:14 +0200
Subject: [PATCH 1/2] i2c: s3c2410: Print errno code in error logs
In-Reply-To: <1461096641-19788-1-git-send-email-javier@osg.samsung.com>
References: <1461096641-19788-1-git-send-email-javier@osg.samsung.com>
Message-ID: <5717455A.1000007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2016 10:10 PM, Javier Martinez Canillas wrote:
> The driver not always prints the error code in case of a failure but this
> information can be very useful for debugging. So let's print if available.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
> Hello,
> 
> This patch and 2/2 were only build tested because I don't have access to
> a board using this IP block. I just noticed these issues when comparing
> the i2c-s3c2410 driver with i2c-exynos5 where I did some fixes recently.
> 
> I think the patches are simple enough that is safe to pick them but of
> course testing will be highly appreciated.
> 
> Best regards,
> Javier
> 
>  drivers/i2c/busses/i2c-s3c2410.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index 362a6de54833..4b873fe9a75b 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -944,7 +944,7 @@ static int s3c24xx_i2c_cpufreq_transition(struct notifier_block *nb,
>  		i2c_unlock_adapter(&i2c->adap);
>  
>  		if (ret < 0)
> -			dev_err(i2c->dev, "cannot find frequency\n");
> +			dev_err(i2c->dev, "cannot find frequency (%d)\n", ret);
>  		else
>  			dev_info(i2c->dev, "setting freq %d\n", got);
>  	}
> @@ -995,7 +995,8 @@ static int s3c24xx_i2c_parse_dt_gpio(struct s3c24xx_i2c *i2c)
>  
>  		ret = gpio_request(gpio, "i2c-bus");
>  		if (ret) {
> -			dev_err(i2c->dev, "gpio [%d] request failed\n", gpio);
> +			dev_err(i2c->dev, "gpio [%d] request failed (%d)\n",
> +				gpio, ret);
>  			goto free_gpio;
>  		}
>  	}

The changes above are okay. Below - do not make sense. Just think...
What do you want to improve? The probe failure already prints errno!


Just look at crafted example (error triggered manually):
[    0.135443] s3c-i2c 13860000.i2c: I2C clock enable failed (-100)
[    0.135484] s3c-i2c: probe of 13860000.i2c failed with error -100

Best regards,
Krzysztof

> @@ -1199,7 +1200,7 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>  	ret = s3c24xx_i2c_init(i2c);
>  	clk_disable(i2c->clk);
>  	if (ret != 0) {
> -		dev_err(&pdev->dev, "I2C controller init failed\n");
> +		dev_err(&pdev->dev, "I2C controller init failed (%d)\n", ret);
>  		return ret;
>  	}
>  	/* find the IRQ for this unit (note, this relies on the init call to
> @@ -1209,7 +1210,7 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>  	if (!(i2c->quirks & QUIRK_POLL)) {
>  		i2c->irq = ret = platform_get_irq(pdev, 0);
>  		if (ret <= 0) {
> -			dev_err(&pdev->dev, "cannot find IRQ\n");
> +			dev_err(&pdev->dev, "cannot find IRQ (%d)\n", ret);
>  			clk_unprepare(i2c->clk);
>  			return ret;
>  		}
> @@ -1218,7 +1219,8 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>  				dev_name(&pdev->dev), i2c);
>  
>  		if (ret != 0) {
> -			dev_err(&pdev->dev, "cannot claim IRQ %d\n", i2c->irq);
> +			dev_err(&pdev->dev, "cannot claim IRQ %d (%d)\n",
> +				i2c->irq, ret);
>  			clk_unprepare(i2c->clk);
>  			return ret;
>  		}
> @@ -1226,7 +1228,8 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>  
>  	ret = s3c24xx_i2c_register_cpufreq(i2c);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to register cpufreq notifier\n");
> +		dev_err(&pdev->dev, "failed to register cpufreq notifier (%d)\n",
> +			ret);
>  		clk_unprepare(i2c->clk);
>  		return ret;
>  	}
> @@ -1246,7 +1249,8 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>  
>  	ret = i2c_add_numbered_adapter(&i2c->adap);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to add bus to i2c core\n");
> +		dev_err(&pdev->dev, "failed to add bus to i2c core (%d)\n",
> +			ret);
>  		pm_runtime_disable(&pdev->dev);
>  		s3c24xx_i2c_deregister_cpufreq(i2c);
>  		clk_unprepare(i2c->clk);
> 
