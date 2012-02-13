From: ben-i2c@fluff.org (Ben Dooks)
Date: Mon, 13 Feb 2012 23:37:26 +0000
Subject: [RFC PATCH 5/7] ARM: davinci: i2c: add OF support
In-Reply-To: <1327308967-8092-6-git-send-email-hs@denx.de>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-6-git-send-email-hs@denx.de>
Message-ID: <20120213233726.GK2999@freya.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2012 at 09:56:05AM +0100, Heiko Schocher wrote:
> add of support for the davinci i2c driver.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: linux-i2c at vger.kernel.org
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Wolfgang Denk <wd@denx.de>
> ---
>  .../devicetree/bindings/arm/davinci/i2c.txt        |   39 ++++++++++++++++++
>  drivers/i2c/busses/i2c-davinci.c                   |   43 ++++++++++++++++++++
>  2 files changed, 82 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/davinci/i2c.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/davinci/i2c.txt b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
> new file mode 100644
> index 0000000..94ec670
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
> @@ -0,0 +1,39 @@
> +* Texas Instruments Davinci I2C
> +
> +This file provides information, what the device node for the
> +davinci i2c interface contain.
> +
> +Required properties:
> +- compatible: "ti,davinci-i2c";
> +- reg : Offset and length of the register set for the device
> +- id: id of the controller
> +
> +Recommended properties :
> +- interrupts : <a b> where a is the interrupt number and b is a
> +  field that represents an encoding of the sense and level
> +  information for the interrupt.
> +- interrupt-parent : the phandle for the interrupt controller that
> +  services interrupts for this device.
> +- clock-frequency : desired I2C bus clock frequency in Hz.

> +Optional properties:
> +- bus-delay: bus delay in usec

bus_delay sounds rather like frequency in a different name, what is it for?

 +- pinmux-handle: Contains a handle to configure the pinmux settings.
> +
> +Example (enbw_cmc board):
> +	i2c at 1c22000 {
> +		compatible = "ti,davinci-i2c";
> +		reg = <0x22000 0x1000>;
> +		clock-frequency = <100000>;
> +		interrupts = <15 2>;
> +		interrupt-parent = <&intc>;
> +		id = <1>;
> +		pinmux-handle = <&i2c1_pins>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		dtt at 48 {
> +				compatible = "national,lm75";
> +				reg = <0x48>;
> +			};
> +	};
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index a76d85f..6f59fae 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -38,9 +38,12 @@
>  #include <linux/slab.h>
>  #include <linux/cpufreq.h>
>  #include <linux/gpio.h>
> +#include <linux/of_i2c.h>
> +#include <linux/of_device.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/i2c.h>
> +#include <mach/mux.h>
>  
>  /* ----- global defines ----------------------------------------------- */
>  
> @@ -635,6 +638,16 @@ static struct i2c_algorithm i2c_davinci_algo = {
>  	.functionality	= i2c_davinci_func,
>  };
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id davinci_i2c_of_match[] = {
> +	{.compatible = "ti,davinci-i2c", },
> +	{},
> +}
> +MODULE_DEVICE_TABLE(of, davinci_i2c_of_match);
> +#else
> +#define davinci_i2c_of_match NULL
> +#endif

see of_match_ptr() and you won't need the #else.

>  static int davinci_i2c_probe(struct platform_device *pdev)
>  {
>  	struct davinci_i2c_dev *dev;
> @@ -676,7 +689,34 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  	dev->irq = irq->start;
>  	platform_set_drvdata(pdev, dev);
>  
> +	if ((dev->dev->platform_data == NULL) &&
> +		(pdev->dev.of_node)) {

If there's platform_data an of_node, what happens then?

> +		struct device_node *pinmux_np;
> +		struct davinci_i2c_platform_data *pdata;
> +		u32 prop;
> +
> +		dev->dev->platform_data = &davinci_i2c_platform_data_default;
> +		pdata = &davinci_i2c_platform_data_default;
> +		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
> +			&prop))
> +			pdata->bus_freq = prop / 1000;
> +		if (!of_property_read_u32(pdev->dev.of_node, "bus-delay",
> +			&prop))
> +			pdata->bus_delay = prop;
> +		if (!of_property_read_u32(pdev->dev.of_node, "id",
> +			&prop)) {
> +			pdev->id = prop;
> +			pdev->dev.init_name = kzalloc(20, GFP_KERNEL);
> +			sprintf((char *)pdev->dev.init_name,
> +				"i2c_davinci.%d", pdev->id);
> +		}

Is this _really_ necessary, looks a bit of a hack to me.

> +		pinmux_np = of_parse_phandle(pdev->dev.of_node,
> +				"pinmux-handle", 0);
> +		if (pinmux_np)
> +			davinci_cfg_reg_of(pinmux_np);
> +	}
>  	dev->clk = clk_get(&pdev->dev, NULL);
> +
>  	if (IS_ERR(dev->clk)) {
>  		r = -ENODEV;
>  		goto err_free_mem;
> @@ -711,6 +751,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  	adap->algo = &i2c_davinci_algo;
>  	adap->dev.parent = &pdev->dev;
>  	adap->timeout = DAVINCI_I2C_TIMEOUT;
> +	adap->dev.of_node = pdev->dev.of_node;
>  
>  	adap->nr = pdev->id;
>  	r = i2c_add_numbered_adapter(adap);
> @@ -718,6 +759,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "failure adding adapter\n");
>  		goto err_free_irq;
>  	}
> +	of_i2c_register_devices(adap);
>  
>  	return 0;
>  
> @@ -809,6 +851,7 @@ static struct platform_driver davinci_i2c_driver = {
>  		.name	= "i2c_davinci",
>  		.owner	= THIS_MODULE,
>  		.pm	= davinci_i2c_pm_ops,
> +		.of_match_table = davinci_i2c_of_match,
>  	},
>  };
>  
> -- 
> 1.7.7.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
