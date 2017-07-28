From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Fri, 28 Jul 2017 13:40:15 +0300
Subject: [PATCH] i2c: use dev_get_drvdata() to get private data in
 suspend/resume hooks
In-Reply-To: <1501172184-17102-1-git-send-email-yamada.masahiro@socionext.com>
References: <1501172184-17102-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1501238415.29303.279.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-07-28 at 01:16 +0900, Masahiro Yamada wrote:
> Several drivers call to_platform_device() to get platform_device
> and pass it to platform_get_drvdata().??In platform_get_drvdata(),
> the platform_device is converted back to struct device again.
> 
> Use dev_get_drvdata() to avoid platform_device/device dance.
> 

I think it should be split on per driver basis.

In any case,

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

(for DesignWare only)

> ?drivers/i2c/busses/i2c-designware-platdrv.c | 6 ++----

> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 2ea6d0d25a01..abe1eca8d689 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -428,8 +428,7 @@ static void dw_i2c_plat_complete(struct device
> *dev)
> ?#ifdef CONFIG_PM
> ?static int dw_i2c_plat_suspend(struct device *dev)
> ?{
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
> +	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
> ?
> ?	i_dev->disable(i_dev);
> ?	i2c_dw_plat_prepare_clk(i_dev, false);
> @@ -439,8 +438,7 @@ static int dw_i2c_plat_suspend(struct device *dev)
> ?
> ?static int dw_i2c_plat_resume(struct device *dev)
> ?{
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
> +	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
> ?
> ?	i2c_dw_plat_prepare_clk(i_dev, true);
> ?	i_dev->init(i_dev);
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
