From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Sep 2015 16:34:34 +0200
Subject: [PATCH] spi: atmel: remove warning when !CONFIG_PM_SLEEP
In-Reply-To: <1441873192-18511-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1441873192-18511-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <55FC20FA.1000405@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 10/09/2015 10:19, Alexandre Belloni a ?crit :
> When CONFIG_PM is defined but not CONFIG_PM_SLEEP (this happens when
> CONFIG_SUSPEND is not defined), there is the following warning:
> 
> drivers/spi/spi-atmel.c:1723:12: warning: ?atmel_spi_suspend? defined but not used [-Wunused-function]
> drivers/spi/spi-atmel.c:1741:12: warning: ?atmel_spi_resume? defined but not used [-Wunused-function]
> 
> Enclose both atmel_spi_suspend and atmel_spi_resume in #ifdef
> CONFIG_PM_SLEEP/#endif to solve that.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

No problem on my side:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> ---
>  drivers/spi/spi-atmel.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index bf9ed380bb1c..63318e2afba1 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1720,6 +1720,7 @@ static int atmel_spi_runtime_resume(struct device *dev)
>  	return clk_prepare_enable(as->clk);
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
>  static int atmel_spi_suspend(struct device *dev)
>  {
>  	struct spi_master *master = dev_get_drvdata(dev);
> @@ -1756,6 +1757,7 @@ static int atmel_spi_resume(struct device *dev)
>  
>  	return ret;
>  }
> +#endif
>  
>  static const struct dev_pm_ops atmel_spi_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(atmel_spi_suspend, atmel_spi_resume)
> 


-- 
Nicolas Ferre
