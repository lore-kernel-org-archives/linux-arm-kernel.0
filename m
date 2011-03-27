From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 28 Mar 2011 00:11:35 +0100
Subject: [PATCH] I2C: Samsung: Add support for PM_runtime in the I2C
	driver.
In-Reply-To: <1301257963-17196-1-git-send-email-amit.kachhap@linaro.org>
References: <1301257963-17196-1-git-send-email-amit.kachhap@linaro.org>
Message-ID: <20110327231135.GG9995@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 27, 2011 at 04:32:43PM -0400, Amit Daniel Kachhap wrote:
> This patch adds PM runtime management support in the I2C driver.
> The functionality of the driver is not modified much but some extra I2C
> states are added for PM runtime. The runtime suspend keeps the interrupt
> for the I2C interface disabled.

ok, whilst this looks ok, it's too late for the current merge window,
so will go into the -next for the next kernel
 
> Signed-off-by:  Amit Daniel Kachhap <amit.kachhap@linaro.org>
> ---
>  drivers/i2c/busses/i2c-s3c2410.c |   61 +++++++++++++++++++++++++++++++++-----
>  1 files changed, 53 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index 6c00c10..8ebe621 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -35,6 +35,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
> +#include <linux/pm_runtime.h>
>  
>  #include <asm/irq.h>
>  
> @@ -48,7 +49,9 @@ enum s3c24xx_i2c_state {
>  	STATE_START,
>  	STATE_READ,
>  	STATE_WRITE,
> -	STATE_STOP
> +	STATE_STOP,
> +	STATE_STANDBY,
> +	STATE_SUSPEND
>  };
>  
>  enum s3c24xx_i2c_type {
> @@ -59,7 +62,6 @@ enum s3c24xx_i2c_type {
>  struct s3c24xx_i2c {
>  	spinlock_t		lock;
>  	wait_queue_head_t	wait;
> -	unsigned int		suspended:1;
>  
>  	struct i2c_msg		*msg;
>  	unsigned int		msg_num;
> @@ -400,8 +402,13 @@ static int i2s_s3c_irq_nextbyte(struct s3c24xx_i2c *i2c, unsigned long iicstat)
>  				i2c->msg++;
>  			}
>  		}
> +		break;
>  
> +	default:
> +		dev_err(i2c->dev, "%s: called with invalid state\n", __func__);
> +		goto out;
>  		break;
> +
>  	}
>  
>  	/* acknowlegde the IRQ and get back on with the work */
> @@ -485,7 +492,7 @@ static int s3c24xx_i2c_doxfer(struct s3c24xx_i2c *i2c,
>  	int spins = 20;
>  	int ret;
>  
> -	if (i2c->suspended)
> +	if (i2c->state == STATE_SUSPEND)
>  		return -EIO;
>  
>  	ret = s3c24xx_i2c_set_master(i2c);
> @@ -555,12 +562,14 @@ static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
>  	int ret;
>  
>  	clk_enable(i2c->clk);
> +	pm_runtime_get_sync(i2c->dev);
>  
>  	for (retry = 0; retry < adap->retries; retry++) {
>  
>  		ret = s3c24xx_i2c_doxfer(i2c, msgs, num);
>  
>  		if (ret != -EAGAIN) {
> +			pm_runtime_put_sync(i2c->dev);
>  			clk_disable(i2c->clk);
>  			return ret;
>  		}
> @@ -570,6 +579,7 @@ static int s3c24xx_i2c_xfer(struct i2c_adapter *adap,
>  		udelay(100);
>  	}
>  
> +	pm_runtime_put_sync(i2c->dev);
>  	clk_disable(i2c->clk);
>  	return -EREMOTEIO;
>  }
> @@ -912,10 +922,14 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>  		goto err_cpufreq;
>  	}
>  
> +	/*Set Initial I2C state*/
> +	i2c->state = STATE_STANDBY;
> +
>  	platform_set_drvdata(pdev, i2c);
>  
>  	dev_info(&pdev->dev, "%s: S3C I2C adapter\n", dev_name(&i2c->adap.dev));
>  	clk_disable(i2c->clk);
> +	pm_runtime_enable(&pdev->dev);
>  	return 0;
>  
>   err_cpufreq:
> @@ -956,6 +970,7 @@ static int s3c24xx_i2c_remove(struct platform_device *pdev)
>  
>  	clk_disable(i2c->clk);
>  	clk_put(i2c->clk);
> +	pm_runtime_disable(&pdev->dev);
>  
>  	iounmap(i2c->regs);
>  
> @@ -972,9 +987,9 @@ static int s3c24xx_i2c_suspend_noirq(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
>  
> -	i2c->suspended = 1;
> -
> +	i2c->state = STATE_SUSPEND;
>  	return 0;
> +
>  }
>  
>  static int s3c24xx_i2c_resume(struct device *dev)
> @@ -982,17 +997,47 @@ static int s3c24xx_i2c_resume(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
>  
> -	i2c->suspended = 0;
>  	clk_enable(i2c->clk);
>  	s3c24xx_i2c_init(i2c);
> +	i2c->state = STATE_STANDBY;
>  	clk_disable(i2c->clk);
>  
>  	return 0;
>  }
>  
> +static int s3c_i2c_runtime_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
> +
> +	i2c->state = STATE_STANDBY;
> +	s3c24xx_i2c_disable_irq(i2c);
> +	s3c24xx_i2c_disable_ack(i2c);
> +
> +	return 0;
> +}
> +
> +static int s3c_i2c_runtime_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
> +
> +	if (i2c->state != STATE_STANDBY)
> +		return 0;
> +
> +	/*No major activity in runtime resume because all the registers are
> +	re-initialised for each i2c transfer, so just changing the state*/
> +	i2c->state = STATE_IDLE;
> +
> +	return 0;
> +}
> +
> +
>  static const struct dev_pm_ops s3c24xx_i2c_dev_pm_ops = {
> -	.suspend_noirq = s3c24xx_i2c_suspend_noirq,
> -	.resume = s3c24xx_i2c_resume,
> +	.suspend_noirq		= s3c24xx_i2c_suspend_noirq,
> +	.resume			= s3c24xx_i2c_resume,
> +	.runtime_suspend	= s3c_i2c_runtime_suspend,
> +	.runtime_resume		= s3c_i2c_runtime_resume,
>  };
>  
>  #define S3C24XX_DEV_PM_OPS (&s3c24xx_i2c_dev_pm_ops)
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
