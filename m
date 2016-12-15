From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 15 Dec 2016 14:33:47 +0200
Subject: [PATCH v2] i2c: designware: add reset interface
In-Reply-To: <1481792388-13781-1-git-send-email-zhangfei.gao@linaro.org>
References: <1479789700-19532-1-git-send-email-zhangfei.gao@linaro.org>
 <1481792388-13781-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1481805227.9552.15.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-12-15 at 16:59 +0800, Zhangfei Gao wrote:
> Some platforms like hi3660 need do reset first to allow accessing
> registers

Patch itself looks good, but would be nice to have it tested.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
> ?drivers/i2c/busses/i2c-designware-core.h????|??1 +
> ?drivers/i2c/busses/i2c-designware-platdrv.c | 28
> ++++++++++++++++++++++++----
> ?2 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-core.h
> b/drivers/i2c/busses/i2c-designware-core.h
> index 0d44d2a..94b14fa 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -80,6 +80,7 @@ struct dw_i2c_dev {
> ?	void __iomem		*base;
> ?	struct completion	cmd_complete;
> ?	struct clk		*clk;
> +	struct reset_control	*rst;
> ?	u32			(*get_clk_rate_khz) (struct
> dw_i2c_dev *dev);
> ?	struct dw_pci_controller *controller;
> ?	int			cmd_err;
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 0b42a12..e9016ae 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -38,6 +38,7 @@
> ?#include <linux/pm_runtime.h>
> ?#include <linux/property.h>
> ?#include <linux/io.h>
> +#include <linux/reset.h>
> ?#include <linux/slab.h>
> ?#include <linux/acpi.h>
> ?#include <linux/platform_data/i2c-designware.h>
> @@ -176,6 +177,14 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
> ?	dev->irq = irq;
> ?	platform_set_drvdata(pdev, dev);
> ?
> +	dev->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
> +	if (IS_ERR(dev->rst)) {
> +		if (PTR_ERR(dev->rst) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +	} else {
> +		reset_control_deassert(dev->rst);
> +	}
> +
> ?	/* fast mode by default because of legacy reasons */
> ?	dev->clk_freq = 400000;
> ?
> @@ -207,12 +216,13 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
> ?	????&& dev->clk_freq != 1000000 && dev->clk_freq != 3400000)
> {
> ?		dev_err(&pdev->dev,
> ?			"Only 100kHz, 400kHz, 1MHz and 3.4MHz
> supported");
> -		return -EINVAL;
> +		r = -EINVAL;
> +		goto exit_reset;
> ?	}
> ?
> ?	r = i2c_dw_eval_lock_support(dev);
> ?	if (r)
> -		return r;
> +		goto exit_reset;
> ?
> ?	dev->functionality =
> ?		I2C_FUNC_I2C |
> @@ -270,10 +280,18 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
> ?	}
> ?
> ?	r = i2c_dw_probe(dev);
> -	if (r && !dev->pm_runtime_disabled)
> -		pm_runtime_disable(&pdev->dev);
> +	if (r)
> +		goto exit_probe;
> ?
> ?	return r;
> +
> +exit_probe:
> +	if (!dev->pm_runtime_disabled)
> +		pm_runtime_disable(&pdev->dev);
> +exit_reset:
> +	if (!IS_ERR_OR_NULL(dev->rst))
> +		reset_control_assert(dev->rst);
> +	return r;
> ?}
> ?
> ?static int dw_i2c_plat_remove(struct platform_device *pdev)
> @@ -290,6 +308,8 @@ static int dw_i2c_plat_remove(struct
> platform_device *pdev)
> ?	pm_runtime_put_sync(&pdev->dev);
> ?	if (!dev->pm_runtime_disabled)
> ?		pm_runtime_disable(&pdev->dev);
> +	if (!IS_ERR_OR_NULL(dev->rst))
> +		reset_control_assert(dev->rst);
> ?
> ?	return 0;
> ?}

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
