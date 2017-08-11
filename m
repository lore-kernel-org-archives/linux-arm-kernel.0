From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 11 Aug 2017 17:11:19 -0500
Subject: [PATCH 2/4] i2c: davinci: Add PM Runtime Support
In-Reply-To: <20170802221753.13786-3-fcooper@ti.com>
References: <20170802221753.13786-1-fcooper@ti.com>
 <20170802221753.13786-3-fcooper@ti.com>
Message-ID: <613570e5-706a-3a54-5cb1-a8f05deb52a3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/02/2017 05:17 PM, Franklin S Cooper Jr wrote:
> This patch adds PM runtime support to the I2C Davinci driver.
> 
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>   drivers/i2c/busses/i2c-davinci.c | 61 ++++++++++++++++++++++++++++++++++------
>   1 file changed, 53 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index 5749aac..62ff869 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -36,6 +36,7 @@
>   #include <linux/gpio.h>
>   #include <linux/of_device.h>
>   #include <linux/platform_data/i2c-davinci.h>
> +#include <linux/pm_runtime.h>
>   
>   /* ----- global defines ----------------------------------------------- */
>   
> @@ -122,6 +123,9 @@
>   /* set the SDA GPIO low */
>   #define DAVINCI_I2C_DCLR_PDCLR1	BIT(1)
>   
> +/* timeout for pm runtime autosuspend */
> +#define DAVINCI_I2C_PM_TIMEOUT	1000	/* ms */
> +
>   struct davinci_i2c_dev {
>   	struct device           *dev;
>   	void __iomem		*base;
> @@ -541,10 +545,17 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>   
>   	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
>   
> +	ret = pm_runtime_get_sync(dev->dev);
> +	if (ret < 0) {
> +		dev_err(dev->dev, "Failed to runtime_get device: %d\n", ret);
> +		pm_runtime_put_noidle(dev->dev);
> +		return ret;
> +	}
> +
>   	ret = i2c_davinci_wait_bus_not_busy(dev);
>   	if (ret < 0) {
>   		dev_warn(dev->dev, "timeout waiting for bus ready\n");
> -		return ret;
> +		goto out;
>   	}
>   
>   	for (i = 0; i < num; i++) {
> @@ -552,14 +563,19 @@ i2c_davinci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>   		dev_dbg(dev->dev, "%s [%d/%d] ret: %d\n", __func__, i + 1, num,
>   			ret);
>   		if (ret < 0)
> -			return ret;
> +			goto out;
>   	}
>   
> +	ret = num;
>   #ifdef CONFIG_CPU_FREQ
>   	complete(&dev->xfr_complete);
>   #endif
>   
> -	return num;
> +out:
> +	pm_runtime_mark_last_busy(dev->dev);
> +	pm_runtime_put_autosuspend(dev->dev);
> +
> +	return ret;
>   }
>   
>   static u32 i2c_davinci_func(struct i2c_adapter *adap)
> @@ -599,6 +615,9 @@ static irqreturn_t i2c_davinci_isr(int this_irq, void *dev_id)
>   	int count = 0;
>   	u16 w;
>   
> +	if (pm_runtime_suspended(dev->dev))
> +		return IRQ_NONE;
> +
>   	while ((stat = davinci_i2c_read_reg(dev, DAVINCI_I2C_IVR_REG))) {
>   		dev_dbg(dev->dev, "%s: stat=0x%x\n", __func__, stat);
>   		if (count++ == 100) {
> @@ -802,7 +821,6 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>   	dev->clk = devm_clk_get(&pdev->dev, NULL);
>   	if (IS_ERR(dev->clk))
>   		return PTR_ERR(dev->clk);
> -	clk_prepare_enable(dev->clk);
>   
>   	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	dev->base = devm_ioremap_resource(&pdev->dev, mem);
> @@ -811,6 +829,17 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>   		goto err_unuse_clocks;
>   	}
>   
> +	pm_runtime_enable(dev->dev);
> +	pm_runtime_set_autosuspend_delay(dev->dev,
> +					 DAVINCI_I2C_PM_TIMEOUT);
> +	pm_runtime_use_autosuspend(dev->dev);

Pls, move autosuspend configuration before pm_runtime_enable()

> +
> +	r = pm_runtime_get_sync(dev->dev);
> +	if (r < 0) {
> +		dev_err(dev->dev, "failed to runtime_get device: %d\n", r);
> +		goto err_unuse_clocks;
> +	}
> +

Otherwise looks good to me.

-- 
regards,
-grygorii
