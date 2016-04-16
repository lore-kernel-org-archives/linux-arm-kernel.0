From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 16 Apr 2016 18:11:47 +0200
Subject: [PATCH] i2c: exynos5: Fix possible ABBA deadlock by keeping I2C
 clock prepared
In-Reply-To: <1460757887-18128-1-git-send-email-javier@osg.samsung.com>
References: <1460757887-18128-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20160416161147.GA2794@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 06:04:47PM -0400, Javier Martinez Canillas wrote:
> The exynos5 I2C controller driver always prepares and enables a clock
> before using it and then disables unprepares it when the clock is not
> used anymore.
> 
> But this can cause a possible ABBA deadlock in some scenarios since a
> driver that uses regmap to access its I2C registers, will first grab
> the regmap lock and then the I2C xfer function will grab the prepare
> lock when preparing the I2C clock. But since the clock driver also
> uses regmap for I2C accesses, preparing a clock will first grab the
> prepare lock and then the regmap lock when using the regmap API.
> 
> An example of this happens on the Exynos5422 Odroid XU board where a
> s2mps11 PMIC is used and both the s2mps11 regulators and clk drivers
> share the same I2C regmap.
> 
> The possible deadlock is reported by the kernel lockdep:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(sec_core:428:(regmap)->lock);
>                                 lock(prepare_lock);
>                                 lock(sec_core:428:(regmap)->lock);
>    lock(prepare_lock);
> 
>   *** DEADLOCK ***
> 
> Fix this by only preparing the clock on probe and {en,dis}able in the
> rest of the driver.
> 
> This patch is similar to commit 34e81ad5f0b6 ("i2c: s3c2410: fix ABBA
> deadlock by keeping clock prepared") that fixes the same bug in other
> driver for an I2C controller found in Samsung SoCs.

I wish this would be fixed by introducing more granular clock locks
(e.g. per controller) instead of implementing another workaround.
I think this driver shouldn't care about this deadlock... although I see
that this is the simplest solution for now.

> 
> Reported-by: Anand Moon <linux.amoon@gmail.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  drivers/i2c/busses/i2c-exynos5.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
> index b29c7500461a..602633747149 100644
> --- a/drivers/i2c/busses/i2c-exynos5.c
> +++ b/drivers/i2c/busses/i2c-exynos5.c
> @@ -671,7 +671,9 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
>  		return -EIO;
>  	}
>  
> -	clk_prepare_enable(i2c->clk);
> +	ret = clk_enable(i2c->clk);
> +	if (ret)
> +		return ret;
>  
>  	for (i = 0; i < num; i++, msgs++) {
>  		stop = (i == num - 1);
> @@ -695,7 +697,7 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
>  	}
>  
>   out:
> -	clk_disable_unprepare(i2c->clk);
> +	clk_disable(i2c->clk);
>  	return ret;
>  }
>  
> @@ -799,6 +801,10 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, i2c);
>  
> +	clk_disable(i2c->clk);
> +
> +	return 0;
> +
>   err_clk:
>  	clk_disable_unprepare(i2c->clk);
>  	return ret;
> @@ -810,6 +816,8 @@ static int exynos5_i2c_remove(struct platform_device *pdev)
>  
>  	i2c_del_adapter(&i2c->adap);
>  
> +	clk_unprepare(i2c->clk);
> +
>  	return 0;
>  }

Please unprepare the clock when suspending. There is no point of having
it prepared in that level.

Best regards,
Krzysztof
