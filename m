From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 20 Jul 2012 12:35:13 +0200
Subject: [PATCHv3] I2C: MV64XXX: Add Device Tree support
In-Reply-To: <1342430205-13702-2-git-send-email-andrew@lunn.ch>
References: <1342430205-13702-1-git-send-email-andrew@lunn.ch>
 <1342430205-13702-2-git-send-email-andrew@lunn.ch>
Message-ID: <20120720103513.GA5971@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Mon, Jul 16, 2012 at 11:16:45AM +0200, Andrew Lunn wrote:
> Extends the driver to get properties from device tree. Rather than
> pass the N & M factors in DT, use the more standard clock-frequency
> property. Calculate N & M at run time. In order to do this, we need to

Thanks.

> know tclk. So the driver uses clk_get() etc in order to get the clock
> and clk_get_rate() to determine the tclk rate. Not all platforms
> however have CLK, so some #ifdefery is needed to ensure the driver
> still compiles when CLK is not available.
> 
> Also extend the kirkwood DT support to supply the needed properties. A
> default clock-frequency is 400KHz, which some platforms might need to
> override to 100KHz if they have devices which do not support fast
> mode.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>

Has Sebastian acked THIS patch? Didn't saw such a mail? If it was a
previous patch which he acked, I'd like it to be resent, since the
divider calculation is new.

> ---
> v2: Removed duplicate interrupt in DT.
> v3: Use clock-frequency property, instead of explicit n & m baud factors.
> 
> i2c fix.
> ---
>  Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   21 +++-
>  arch/arm/boot/dts/kirkwood.dtsi                    |   11 ++
>  arch/arm/mach-kirkwood/board-dt.c                  |    2 +
>  arch/arm/mach-kirkwood/common.c                    |    2 +
>  arch/arm/plat-orion/common.c                       |    1 +
>  drivers/i2c/busses/i2c-mv64xxx.c                   |  107 +++++++++++++++++++-

As said in another mail, please split up arch/arm and i2c-stuff.

>  6 files changed, 138 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> index b891ee2..885f340 100644
> --- a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> @@ -1,4 +1,4 @@
> -* I2C
> +* Marvell MMP I2C controller
>  
>  Required properties :
>  
> @@ -32,3 +32,22 @@ Examples:
>  		interrupts = <58>;
>  	};
>  
> +* Marvell MV64XXX I2C controller
> +
> +Required properties :
> +
> + - reg             : Offset and length of the register set for the device
> + - compatible      : Should be "marvell,mv64xxx-i2c"
> + - interrupts      : Te interrupt number
> + - clock-frequency : Desired I2C bus clock frequency in Hz.
> + - timeout-ms      : How long to wait for a transaction to complete

If you don't really need "timeout-ms", I'd ask you to drop it. I haven't
made up my mind how to handle those timeouts yet. They should be
per-slave and not per-bus, but the core cannot handle this yet. And even
though I am tempted to accept a per-bus-timeout, getting the binding
right is not something we can come up with before the next merge window.
I am suspecting a default value could do for now?

> +
> +Examples:
> +
> +	i2c at 11000 {
> +		compatible = "marvell,mv64xxx-i2c";
> +		reg = <0x11000 0x20>;
> +		interrupts = <29>;
> +		clock-frequency = <100000>;
> +		timeout-ms = <1000>;
> +	};
> diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
> index a3350fd..bc57d81 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -82,5 +82,16 @@
>  			/* set partition map and/or chip-delay in board dts */
>  			status = "disabled";
>  		};
> +
> +		i2c at 11000 {
> +			compatible = "marvell,mv64xxx-i2c";
> +			reg = <0x11000 0x20>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <29>;
> +			clock-frequency = <400000>;
> +			timeout-ms = <1000>;
> +			status = "disable";
> +		};
>  	};
>  };
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index 8f8da5d..24c8fdd 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -28,6 +28,8 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
>  
>  struct of_dev_auxdata kirkwood_auxdata_lookup[] __initdata = {
>  	OF_DEV_AUXDATA("marvell,orion-spi", 0xf1010600, "orion_spi.0", NULL),
> +	OF_DEV_AUXDATA("marvell,mv64xxx-i2c", 0xf1011000, "mv64xxx_i2c.0",
> +		       NULL),
>  	{},
>  };
>  
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index f261cd2..078d9c6 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -17,6 +17,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/clk-provider.h>
>  #include <linux/spinlock.h>
> +#include <linux/mv643xx_i2c.h>
>  #include <net/dsa.h>
>  #include <asm/page.h>
>  #include <asm/timex.h>
> @@ -241,6 +242,7 @@ void __init kirkwood_clk_init(void)
>  	orion_clkdev_add("0", "pcie", pex0);
>  	orion_clkdev_add("1", "pcie", pex1);
>  	orion_clkdev_add(NULL, "kirkwood-i2s", audio);
> +	orion_clkdev_add(NULL, MV64XXX_I2C_CTLR_NAME ".0", runit);
>  }
>  
>  /*****************************************************************************
> diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
> index c179378..d245a87 100644
> --- a/arch/arm/plat-orion/common.c
> +++ b/arch/arm/plat-orion/common.c
> @@ -47,6 +47,7 @@ void __init orion_clkdev_init(struct clk *tclk)
>  	orion_clkdev_add(NULL, MV643XX_ETH_NAME ".2", tclk);
>  	orion_clkdev_add(NULL, MV643XX_ETH_NAME ".3", tclk);
>  	orion_clkdev_add(NULL, "orion_wdt", tclk);
> +	orion_clkdev_add(NULL, MV64XXX_I2C_CTLR_NAME ".0", tclk);
>  }
>  
>  /* Fill in the resources structure and link it into the platform
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> index 4f44a33..e97246b 100644
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
> @@ -98,6 +103,7 @@ struct mv64xxx_i2c_data {
>  	int			rc;
>  	u32			freq_m;
>  	u32			freq_n;
> +	struct clk              *clk;
>  	wait_queue_head_t	waitq;
>  	spinlock_t		lock;
>  	struct i2c_msg		*msg;
> @@ -521,6 +527,36 @@ mv64xxx_i2c_unmap_regs(struct mv64xxx_i2c_data *drv_data)
>  	drv_data->reg_base_p = 0;
>  }
>  
> +#ifdef CONFIG_OF

Hooray, we have one big CONFIG_OF block, so we could move other stuff
here? See below.

> +static int __devinit
> +calc_freq(const int tclk, const int n, const int m)
> +{
> +	return tclk / (10 * (m + 1) * (2 << n));
> +}
> +
> +static bool __devinit
> +find_baud_factors(const int req_freq, const int tclk, int *best_n, int *best_m)
> +{
> +	int freq, delta, best_delta = INT_MAX;
> +	int m, n;
> +
> +	for (n = 0; n <= 7; n++)
> +		for (m = 0; m <= 15; m++) {
> +			freq = calc_freq(tclk, n, m);
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
> +#endif
>  static int __devinit
>  mv64xxx_i2c_probe(struct platform_device *pd)
>  {
> @@ -528,7 +564,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  	struct mv64xxx_i2c_pdata	*pdata = pd->dev.platform_data;
>  	int	rc;
>  
> -	if ((pd->id != 0) || !pdata)
> +	if ((!pdata && !pd->dev.of_node) || (pdata && (pd->id != 0)))
>  		return -ENODEV;

(extra points if you rebase your patch on top of this patch
d61a9095155e832287552a9e565b8756ee293c46 from my next tree:
git://git.pengutronix.de/git/wsa/linux.git i2c-embedded/for-next)

>  
>  	drv_data = kzalloc(sizeof(struct mv64xxx_i2c_data), GFP_KERNEL);
> @@ -546,19 +582,64 @@ mv64xxx_i2c_probe(struct platform_device *pd)
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

Call this code only when CONFIG_OF?

> +#endif
> +	if (pdata) {
> +		drv_data->freq_m = pdata->freq_m;
> +		drv_data->freq_n = pdata->freq_n;
> +		drv_data->irq = platform_get_irq(pd, 0);
> +	}
> +#ifdef CONFIG_OF
> +	if (pd->dev.of_node) {

Move this stuff into a seperate function and put it into the big
CONFIG_OF block? That should make the code a lot more readable?

> +		int bus_freq;
> +		int tclk;
> +		/* CLK is mandatory when using DT to describe the i2c
> +		 * bus. We need to know tclk in order to calculate bus
> +		 * clock factors. */
> +#if defined(CONFIG_HAVE_CLK)
> +		if (IS_ERR(drv_data->clk)) {
> +			rc = -ENODEV;
> +			goto exit_unmap_regs;
> +		}
> +		tclk = clk_get_rate(drv_data->clk);
> +		of_property_read_u32(pd->dev.of_node, "clock-frequency",
> +				     &bus_freq);
> +		if (!find_baud_factors(bus_freq, tclk,
> +				       &drv_data->freq_n, &drv_data->freq_m)) {
> +			rc = -EINVAL;
> +			goto exit_unmap_regs;
> +		}
> +		drv_data->irq = irq_of_parse_and_map(pd->dev.of_node, 0);
> +#else
> +		/* Have OF but no CLK */
> +		rc = -ENODEV;
> +		goto exit_unmap_regs;
> +#endif
> +	}
> +#endif
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
> +	if (pd->dev.of_node)
> +		drv_data->adapter.timeout = msecs_to_jiffies(
> +			of_property_read_u32(pd->dev.of_node, "timeout-ms",
> +					     &drv_data->freq_n));
> +	else
> +		drv_data->adapter.timeout = msecs_to_jiffies(pdata->timeout);

This should also go into the new function.

>  	drv_data->adapter.nr = pd->id;
> +	drv_data->adapter.dev.of_node = pd->dev.of_node;
>  	platform_set_drvdata(pd, drv_data);
>  	i2c_set_adapdata(&drv_data->adapter, drv_data);
>  
> @@ -577,6 +658,8 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  		goto exit_free_irq;
>  	}
>  
> +	of_i2c_register_devices(&drv_data->adapter);
> +
>  	return 0;
>  
>  	exit_free_irq:
> @@ -597,17 +680,31 @@ mv64xxx_i2c_remove(struct platform_device *dev)
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
>  
> -- 
> 1.7.10
> 

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120720/2e239bae/attachment-0001.sig>
