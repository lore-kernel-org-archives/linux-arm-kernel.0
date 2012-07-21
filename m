From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 21 Jul 2012 14:55:47 +0200
Subject: [PATCH] I2C: MV64XYZ: Add Device Tree support
In-Reply-To: <1342803657-16611-1-git-send-email-andrew@lunn.ch>
References: <1342803657-16611-1-git-send-email-andrew@lunn.ch>
Message-ID: <20120721125547.GA18592@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 20, 2012 at 07:00:57PM +0200, Andrew Lunn wrote:
> Extends the driver to get properties from device tree. Rather than
> pass the N & M factors in DT, use the more standard clock-frequency
> property. Calculate N & M at run time. In order to do this, we need to
> know tclk. So the driver uses clk_get() etc in order to get the clock
> and clk_get_rate() to determine the tclk rate. Not all platforms
> however have CLK, so some #ifdefery is needed to ensure the driver
> still compiles when CLK is not available.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> - Replaced the timeout property in DT, with a hard coded 1 second.
> - Put all the OF code together.
> - Split the ARM parts from the driver itself.
> - Dropped Sebastian Hesselbarth Acked-by, since the changes are not trivial.
> - Change MV64XXX to MV64XYZ in the Subject to try to get it past the list
>   spam filter.

:)

> 
> This patch and the ARM counter part patch, plus all the DT changes to
> make us of it can be found in:
> 
> git://github.com/lunn/linux.git v3.5-rc7-for-next-v5
> 
> This patch is not yet rebased on i2c-embedded/for-next. I will do this
> once there is a general acceptance of this patch.
> 
>  Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   19 ++-
>  drivers/i2c/busses/i2c-mv64xxx.c                   |  135 +++++++++++++++++++-
>  2 files changed, 148 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> index b891ee2..0f79450 100644
> --- a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> @@ -1,4 +1,4 @@
> -* I2C
> +* Marvell MMP I2C controller
>  
>  Required properties :
>  
> @@ -32,3 +32,20 @@ Examples:
>  		interrupts = <58>;
>  	};
>  
> +* Marvell MV64XXX I2C controller
> +
> +Required properties :
> +
> + - reg             : Offset and length of the register set for the device
> + - compatible      : Should be "marvell,mv64xxx-i2c"
> + - interrupts      : The interrupt number
> + - clock-frequency : Desired I2C bus clock frequency in Hz.
> +
> +Examples:
> +
> +	i2c at 11000 {
> +		compatible = "marvell,mv64xxx-i2c";
> +		reg = <0x11000 0x20>;
> +		interrupts = <29>;
> +		clock-frequency = <100000>;
> +	};
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> index 4f44a33..e5449be 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -18,6 +18,11 @@
>  #include <linux/mv643xx_i2c.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_i2c.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
>  
>  /* Register defines */
>  #define	MV64XXX_I2C_REG_SLAVE_ADDR			0x00
> @@ -98,6 +103,9 @@ struct mv64xxx_i2c_data {
>  	int			rc;
>  	u32			freq_m;
>  	u32			freq_n;
> +#if defined(CONFIG_HAVE_CLK)
> +	struct clk              *clk;
> +#endif
>  	wait_queue_head_t	waitq;
>  	spinlock_t		lock;
>  	struct i2c_msg		*msg;
> @@ -521,6 +529,83 @@ mv64xxx_i2c_unmap_regs(struct mv64xxx_i2c_data *drv_data)
>  	drv_data->reg_base_p = 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static int __devinit
> +mv64xxx_calc_freq(const int tclk, const int n, const int m)
> +{
> +	return tclk / (10 * (m + 1) * (2 << n));
> +}
> +
> +static bool __devinit
> +mv64xxx_find_baud_factors(const int req_freq, const int tclk, int *best_n,
> +			  int *best_m)
> +{
> +	int freq, delta, best_delta = INT_MAX;
> +	int m, n;
> +
> +	for (n = 0; n <= 7; n++)
> +		for (m = 0; m <= 15; m++) {
> +			freq = mv64xxx_calc_freq(tclk, n, m);
> +			delta = req_freq - freq;
> +			if (delta >= 0 && delta < best_delta) {
> +				*best_m = m;
> +				*best_n = n;
> +				best_delta = delta;
> +			}
> +			if (best_delta == 0)
> +				return true;
> +		}
> +	if (best_delta == INT_MAX)
> +		return false;
> +	return true;
> +}
> +
> +static int __devinit
> +mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
> +		  struct device_node *np)
> +{
> +	int bus_freq;
> +	int tclk;
> +	int rc = 0;
> +
> +	/* CLK is mandatory when using DT to describe the i2c bus. We
> +	 * need to know tclk in order to calculate bus clock
> +	 * factors.
> +	 */
> +#if !defined(CONFIG_HAVE_CLK)
> +	/* Have OF but no CLK */
> +	rc = -ENODEV;

return -ENODEV?

> +#else
> +	if (IS_ERR(drv_data->clk)) {
> +		rc = -ENODEV;
> +		goto out;
> +	}
> +	tclk = clk_get_rate(drv_data->clk);
> +	of_property_read_u32(np, "clock-frequency", &bus_freq);
> +	if (!mv64xxx_find_baud_factors(bus_freq, tclk,
> +				       &drv_data->freq_n, &drv_data->freq_m)) {
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +	drv_data->irq = irq_of_parse_and_map(np, 0);
> +
> +	/* Its not yet defined how timeouts will be specified in device tree.
> +	 * So hard code the value to 1 second.
> +	 */
> +	drv_data->adapter.timeout = HZ;
> +out:
> +	return rc;
> +#endif
> +}
> +#else /* CONFIG_OF */
> +static int __devinit
> +mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
> +		  struct device_node *np)
> +{
> +	return -ENODEV;
> +}
> +#endif /* CONFIG_OF */
> +
>  static int __devinit
>  mv64xxx_i2c_probe(struct platform_device *pd)
>  {
> @@ -528,7 +613,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  	struct mv64xxx_i2c_pdata	*pdata = pd->dev.platform_data;
>  	int	rc;
>  
> -	if ((pd->id != 0) || !pdata)
> +	if ((!pdata && !pd->dev.of_node) || (pdata && (pd->id != 0)))
>  		return -ENODEV;
>  
>  	drv_data = kzalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
> @@ -546,19 +631,36 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  	init_waitqueue_head(&drv_data->waitq);
>  	spin_lock_init(&drv_data->lock);
>  
> -	drv_data->freq_m = pdata->freq_m;
> -	drv_data->freq_n = pdata->freq_n;
> -	drv_data->irq = platform_get_irq(pd, 0);
> +#if defined(CONFIG_HAVE_CLK)
> +	/* Not all platforms have a clk */
> +	drv_data->clk = clk_get(&pd->dev, NULL);
> +	if (!IS_ERR(drv_data->clk)) {
> +		clk_prepare(drv_data->clk);
> +		clk_enable(drv_data->clk);
> +	}
> +#endif
> +	if (pdata) {
> +		drv_data->freq_m = pdata->freq_m;
> +		drv_data->freq_n = pdata->freq_n;
> +		drv_data->irq = platform_get_irq(pd, 0);
> +		drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
> +	}
> +	if (pd->dev.of_node) {

else if?

> +		rc = mv64xxx_of_config(drv_data, pd->dev.of_node);
> +		if (rc)
> +			goto exit_unmap_regs;
> +	}
>  	if (drv_data->irq < 0) {
>  		rc = -ENXIO;
>  		goto exit_unmap_regs;
>  	}
> +
>  	drv_data->adapter.dev.parent = &pd->dev;
>  	drv_data->adapter.algo = &mv64xxx_i2c_algo;
>  	drv_data->adapter.owner = THIS_MODULE;
>  	drv_data->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_SPD;
> -	drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);
>  	drv_data->adapter.nr = pd->id;
> +	drv_data->adapter.dev.of_node = pd->dev.of_node;
>  	platform_set_drvdata(pd, drv_data);
>  	i2c_set_adapdata(&drv_data->adapter, drv_data);
>  
> @@ -577,11 +679,20 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  		goto exit_free_irq;
>  	}
>  
> +	of_i2c_register_devices(&drv_data->adapter);
> +
>  	return 0;
>  
>  	exit_free_irq:
>  		free_irq(drv_data->irq, drv_data);
>  	exit_unmap_regs:
> +#if defined(CONFIG_HAVE_CLK)
> +	/* Not all platforms have a clk */
> +	if (!IS_ERR(drv_data->clk)) {
> +		clk_disable(drv_data->clk);
> +		clk_unprepare(drv_data->clk);
> +	}
> +#endif
>  		mv64xxx_i2c_unmap_regs(drv_data);
>  	exit_kfree:
>  		kfree(drv_data);
> @@ -597,17 +708,31 @@ mv64xxx_i2c_remove(struct platform_device *dev)
>  	rc = i2c_del_adapter(&drv_data->adapter);
>  	free_irq(drv_data->irq, drv_data);
>  	mv64xxx_i2c_unmap_regs(drv_data);
> +#if defined(CONFIG_HAVE_CLK)
> +	/* Not all platforms have a clk */
> +	if (!IS_ERR(drv_data->clk)) {
> +		clk_disable(drv_data->clk);
> +		clk_unprepare(drv_data->clk);
> +	}
> +#endif
>  	kfree(drv_data);
>  
>  	return rc;
>  }
>  
> +static const struct of_device_id mv64xxx_i2c_of_match_table[] __devinitdata = {
> +	{ .compatible = "marvell,mv64xxx-i2c", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mv64xxx_i2c_of_match_table);
> +
>  static struct platform_driver mv64xxx_i2c_driver = {
>  	.probe	= mv64xxx_i2c_probe,
>  	.remove	= __devexit_p(mv64xxx_i2c_remove),
>  	.driver	= {
>  		.owner	= THIS_MODULE,
>  		.name	= MV64XXX_I2C_CTLR_NAME,
> +		.of_match_table = of_match_ptr(mv64xxx_i2c_of_match_table),
>  	},
>  };

Rest looks good to me and it should be safe to rebase now.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120721/b124e636/attachment.sig>
