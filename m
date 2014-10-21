From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 21 Oct 2014 19:00:54 +0200
Subject: [PATCH] spi/atmel: improve the system suspend/resume functions
 implementation
In-Reply-To: <1413863014-1791-1-git-send-email-wenyou.yang@atmel.com>
References: <1413863014-1791-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <54469146.8050402@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/10/2014 05:43, Wenyou Yang :
> To make it cleaner, the system suspend/resume directly call
> the runtime suspend/resume functions
> and remove the wapper of CONFIG_PM_RUNTIME, CONFIG_PM_SLEEP.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

It looks very neat. Thanks Wenyou and Kevin!

If needed:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

even if I admit that I tend to put my confidence in you guys for this
enhancement ;-)

Bye,

> ---
>  drivers/spi/spi-atmel.c |   61 ++++++++++++++++++++---------------------------
>  1 file changed, 26 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 3f50014..6ed1893 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1451,11 +1451,30 @@ static int atmel_spi_remove(struct platform_device *pdev)
>  }
>  
>  #ifdef CONFIG_PM
> -#ifdef CONFIG_PM_SLEEP
> +static int atmel_spi_runtime_suspend(struct device *dev)
> +{
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	struct atmel_spi *as = spi_master_get_devdata(master);
> +
> +	clk_disable_unprepare(as->clk);
> +	pinctrl_pm_select_sleep_state(dev);
> +
> +	return 0;
> +}
> +
> +static int atmel_spi_runtime_resume(struct device *dev)
> +{
> +	struct spi_master *master = dev_get_drvdata(dev);
> +	struct atmel_spi *as = spi_master_get_devdata(master);
> +
> +	pinctrl_pm_select_default_state(dev);
> +
> +	return clk_prepare_enable(as->clk);
> +}
> +
>  static int atmel_spi_suspend(struct device *dev)
>  {
> -	struct spi_master	*master = dev_get_drvdata(dev);
> -	struct atmel_spi	*as = spi_master_get_devdata(master);
> +	struct spi_master *master = dev_get_drvdata(dev);
>  	int ret;
>  
>  	/* Stop the queue running */
> @@ -1465,23 +1484,19 @@ static int atmel_spi_suspend(struct device *dev)
>  		return ret;
>  	}
>  
> -	if (!pm_runtime_suspended(dev)) {
> -		clk_disable_unprepare(as->clk);
> -		pinctrl_pm_select_sleep_state(dev);
> -	}
> +	if (!pm_runtime_suspended(dev))
> +		atmel_spi_runtime_suspend(dev);
>  
>  	return 0;
>  }
>  
>  static int atmel_spi_resume(struct device *dev)
>  {
> -	struct spi_master	*master = dev_get_drvdata(dev);
> -	struct atmel_spi	*as = spi_master_get_devdata(master);
> +	struct spi_master *master = dev_get_drvdata(dev);
>  	int ret;
>  
>  	if (!pm_runtime_suspended(dev)) {
> -		pinctrl_pm_select_default_state(dev);
> -		ret = clk_prepare_enable(as->clk);
> +		ret = atmel_spi_runtime_resume(dev);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1493,30 +1508,6 @@ static int atmel_spi_resume(struct device *dev)
>  
>  	return ret;
>  }
> -#endif
> -
> -#ifdef CONFIG_PM_RUNTIME
> -static int atmel_spi_runtime_suspend(struct device *dev)
> -{
> -	struct spi_master *master = dev_get_drvdata(dev);
> -	struct atmel_spi *as = spi_master_get_devdata(master);
> -
> -	clk_disable_unprepare(as->clk);
> -	pinctrl_pm_select_sleep_state(dev);
> -
> -	return 0;
> -}
> -
> -static int atmel_spi_runtime_resume(struct device *dev)
> -{
> -	struct spi_master *master = dev_get_drvdata(dev);
> -	struct atmel_spi *as = spi_master_get_devdata(master);
> -
> -	pinctrl_pm_select_default_state(dev);
> -
> -	return clk_prepare_enable(as->clk);
> -}
> -#endif
>  
>  static const struct dev_pm_ops atmel_spi_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(atmel_spi_suspend, atmel_spi_resume)
> 


-- 
Nicolas Ferre
