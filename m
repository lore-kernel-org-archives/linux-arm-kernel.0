From: peter.korsgaard@barco.com (Peter Korsgaard)
Date: Tue, 23 Oct 2012 21:51:56 +0200
Subject: [PATCH 1/2] i2c: mux: Add dt support to i2c-mux-gpio driver
In-Reply-To: <1350910413-23925-2-git-send-email-maxime.ripard@free-electrons.com>(Maxime
 Ripard's message of "Mon, 22 Oct 2012 14:53:32 +0200")
References: <1350910413-23925-1-git-send-email-maxime.ripard@free-electrons.com><1350910413-23925-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <87liexrmoz.fsf@thor.barco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "MR" == Maxime Ripard <maxime.ripard@free-electrons.com> writes:

Hi Maxime,

I'm fine with the idea, but a few comments:


MR> Allow the i2c-mux-gpio to be used by a device tree enabled device. The
MR> bindings are inspired by the one found in the i2c-mux-pinctrl driver.

MR> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
MR> ---
MR>  .../devicetree/bindings/i2c/i2c-mux-gpio.txt       |   81 ++++++++++
MR>  drivers/i2c/muxes/i2c-mux-gpio.c                   |  169 +++++++++++++++-----
MR>  2 files changed, 211 insertions(+), 39 deletions(-)
MR>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt

MR> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
MR> new file mode 100644
MR> index 0000000..335fc4e
MR> --- /dev/null
MR> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
MR> @@ -0,0 +1,81 @@
MR> +GPIO-based I2C Bus Mux
MR> +
MR> +This binding describes an I2C bus multiplexer that uses GPIOs to
MR> +route the I2C signals.
MR> +
MR> +                                  +-----+  +-----+
MR> +                                  | dev |  | dev |
MR> +    +------------+                +-----+  +-----+
MR> +    | SoC        |                   |        |
MR> +    |            |          /--------+--------+
MR> +    |   +------+ |  +------+    child bus A, on GPIO value set to 0
MR> +    |   | I2C  |-|--| Mux  |
MR> +    |   +------+ |  +--+---+    child bus B, on GPIO value set to 1
MR> +    |            |     |    \----------+--------+--------+
MR> +    |   +------+ |     |               |        |        |
MR> +    |   | GPIO |-|-----+            +-----+  +-----+  +-----+
MR> +    |   +------+ |                  | dev |  | dev |  | dev |
MR> +    +------------+                  +-----+  +-----+  +-----+
MR> +
MR> +Required properties:
MR> +- compatible: i2c-mux-gpio
MR> +- i2c-parent: The phandle of the I2C bus that this multiplexer's master-side
MR> +  port is connected to.
MR> +- mux-gpios: list of gpios to use to control the muxer

s/to use to/used to/


MR> +* Standard I2C mux properties. See mux.txt in this directory.
MR> +* I2C child bus nodes. See mux.txt in this directory.
MR> +
MR> +Optional properties:
MR> +- idle-state: value to set to the muxer when idle. When no value is

How about 'bitmask defining mux state when idle' instead?


MR> +  given, it defaults to the last value used.
MR> +
MR> +For each i2c child node, an I2C child bus will be created. They will
MR> +be numbered based on the reg property of each node.

As far as I can see they are dynamically assigned numbers in the order
they are listed in the dt.


MR> +
MR> +Whenever an access is made to a device on a child bus, the value set
MR> +in the revelant node's reg property will be output using the list of
MR> +GPIOs, the first in the list holding the most-significant value.

Isn't it the other way around, E.G. first gpio in mux-gpios controlled
by LSB of reg property, next gpio by lsb+1,  ..?



MR> +
MR> +If an idle state is defined, using the idle-state (optional) property,
MR> +whenever an access is not being made to a device on a child bus, the
MR> +idle value will be programmed into the GPIOs.

s/idle value will be programmed into the GPIOS/GPIOS set according to
the idle value bitmask/


MR> +
MR> +If an idle state is not defined, the most recently used value will be
MR> +left programmed into hardware whenever no access is being made of a

s/of a/to a/


MR> +device on a child bus.
MR> +
MR> +Example:
MR> +	i2cmux {
MR> +		compatible = "i2c-mux-gpio";
MR> +		#address-cells = <1>;
MR> +		#size-cells = <0>;
MR> +		mux-gpios = <&gpio1 22 0 &gpio1 23 0>;
MR> +		i2c-parent = <&i2c1>;
MR> +
MR> +		i2c at 1 {
MR> +			reg = <1>;
MR> +			#address-cells = <1>;
MR> +			#size-cells = <0>;
MR> +
MR> +			ssd1307: oled at 3c {
MR> +				compatible = "solomon,ssd1307fb-i2c";
MR> +				reg = <0x3c>;
MR> +				pwms = <&pwm 4 3000>;
MR> +				reset-gpios = <&gpio2 7 1>;
MR> +				reset-active-low;
MR> +			};
MR> +		};
MR> +
MR> +		i2c at 3 {
MR> +			reg = <3>;
MR> +			#address-cells = <1>;
MR> +			#size-cells = <0>;
MR> +
MR> +			pca9555: pca9555 at 20 {
MR> +				compatible = "nxp,pca9555";
MR> +				gpio-controller;
MR> +				#gpio-cells = <2>;
MR> +				reg = <0x20>;
MR> +			};
MR> +		};
MR> +	};
MR> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
MR> index 566a675..7ebef01 100644
MR> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
MR> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
MR> @@ -16,11 +16,13 @@
MR>  #include <linux/module.h>
MR>  #include <linux/slab.h>
MR>  #include <linux/gpio.h>
MR> +#include <linux/of_i2c.h>
MR> +#include <linux/of_gpio.h>
 
MR>  struct gpiomux {
MR>  	struct i2c_adapter *parent;
MR>  	struct i2c_adapter **adap; /* child busses */
MR> -	struct i2c_mux_gpio_platform_data data;
MR> +	struct i2c_mux_gpio_platform_data *data;


Why this change? I don't see why it is needed and the patch would be a
lot easier to review without all the s/.data/->data/ noise.


MR>  	unsigned gpio_base;
MR>  };
 
MR> @@ -28,8 +30,8 @@ static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
MR>  {
MR>  	int i;
 
MR> -	for (i = 0; i < mux->data.n_gpios; i++)
MR> -		gpio_set_value(mux->gpio_base + mux->data.gpios[i],
MR> +	for (i = 0; i < mux->data->n_gpios; i++)
MR> +		gpio_set_value(mux->gpio_base + mux->data->gpios[i],
MR>  			       val & (1 << i));
MR>  }
 
MR> @@ -37,7 +39,7 @@ static int i2c_mux_gpio_select(struct i2c_adapter *adap, void *data, u32 chan)
MR>  {
MR>  	struct gpiomux *mux = data;
 
MR> -	i2c_mux_gpio_set(mux, mux->data.values[chan]);
MR> +	i2c_mux_gpio_set(mux, mux->data->values[chan]);
 
MR>  	return 0;
MR>  }
MR> @@ -46,7 +48,7 @@ static int i2c_mux_gpio_deselect(struct i2c_adapter *adap, void *data, u32 chan)
MR>  {
MR>  	struct gpiomux *mux = data;
 
MR> -	i2c_mux_gpio_set(mux, mux->data.idle);
MR> +	i2c_mux_gpio_set(mux, mux->data->idle);
 
MR>  	return 0;
MR>  }
MR> @@ -57,29 +59,118 @@ static int __devinit match_gpio_chip_by_label(struct gpio_chip *chip,
MR>  	return !strcmp(chip->label, data);
MR>  }
 
MR> +#ifdef CONFIG_OF
MR> +static int __devinit i2c_mux_gpio_probe_dt(struct gpiomux *mux,
MR> +					struct platform_device *pdev)
MR> +{
MR> +	struct device_node *np = pdev->dev.of_node;
MR> +	struct device_node *adapter_np, *child;
MR> +	struct i2c_adapter *adapter;
MR> +	unsigned *values, *gpios;
MR> +	int i = 0;
MR> +
MR> +	if (!np)
MR> +		return 0;
MR> +
MR> +	mux->data = devm_kzalloc(&pdev->dev, sizeof(*mux->data),
MR> +				GFP_KERNEL);
MR> +	if (!mux->data) {
MR> +		dev_err(&pdev->dev, "Cannot allocate platform_data");
MR> +		return -ENOMEM;
MR> +	}
MR> +
MR> +	adapter_np = of_parse_phandle(np, "i2c-parent", 0);
MR> +	if (!adapter_np) {
MR> +		dev_err(&pdev->dev, "Cannot parse i2c-parent\n");
MR> +		return -ENODEV;
MR> +	}
MR> +	adapter = of_find_i2c_adapter_by_node(adapter_np);
MR> +	if (!adapter) {
MR> +		dev_err(&pdev->dev, "Cannot find parent bus\n");
MR> +		return -ENODEV;
MR> +	}
MR> +	mux->data->parent = i2c_adapter_id(adapter);
MR> +	put_device(&adapter->dev);
MR> +
MR> +	mux->data->n_values = of_get_child_count(np);
MR> +
MR> +	values = devm_kzalloc(&pdev->dev,
MR> +			      sizeof(*mux->data->values) * mux->data->n_values,
MR> +			      GFP_KERNEL);
MR> +	if (!values) {
MR> +		dev_err(&pdev->dev, "Cannot allocate values array");
MR> +		return -ENOMEM;
MR> +	}
MR> +
MR> +	for_each_child_of_node(np, child) {
MR> +		of_property_read_u32(child, "reg", values + i);
MR> +		i++;
MR> +	}
MR> +	mux->data->values = values;
MR> +
MR> +	if (of_property_read_u32(np, "idle-state", &mux->data->idle))
MR> +		mux->data->idle = I2C_MUX_GPIO_NO_IDLE;
MR> +
MR> +	mux->data->n_gpios = of_gpio_named_count(np, "mux-gpios");
MR> +	if (mux->data->n_gpios < 0) {
MR> +		dev_err(&pdev->dev, "Missing mux-gpios property in the DT.\n");
MR> +		return -EINVAL;
MR> +	}
MR> +
MR> +	gpios = devm_kzalloc(&pdev->dev,
MR> +			     sizeof(*mux->data->gpios) * mux->data->n_gpios,
MR> +                             GFP_KERNEL);
MR> +	if (!gpios) {
MR> +		dev_err(&pdev->dev, "Cannot allocate gpios array");
MR> +		return -ENOMEM;
MR> +	}
MR> +
MR> +	for (i = 0; i < mux->data->n_gpios; i++)
MR> +		gpios[i] = of_get_named_gpio(np, "mux-gpios", i);
MR> +
MR> +	mux->data->gpios = gpios;
MR> +
MR> +	return 0;
MR> +}
MR> +#else
MR> +static int __devinit i2c_mux_gpio_probe_dt(struct gpiomux *mux,
MR> +					struct platform_device *pdev)
MR> +{
MR> +	return 0;
MR> +}
MR> +#endif
MR> +
MR>  static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
MR>  {
MR>  	struct gpiomux *mux;
MR> -	struct i2c_mux_gpio_platform_data *pdata;
MR>  	struct i2c_adapter *parent;
MR>  	int (*deselect) (struct i2c_adapter *, void *, u32);
MR>  	unsigned initial_state, gpio_base;
MR>  	int i, ret;
 
MR> -	pdata = pdev->dev.platform_data;
MR> -	if (!pdata) {
MR> -		dev_err(&pdev->dev, "Missing platform data\n");
MR> -		return -ENODEV;
MR> +	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
MR> +	if (!mux) {
MR> +		dev_err(&pdev->dev, "Cannot allocate gpiomux structure");
MR> +		return -ENOMEM;
MR> +	}
MR> +
MR> +	platform_set_drvdata(pdev, mux);
MR> +
MR> +	mux->data = pdev->dev.platform_data;
MR> +	if (!mux->data) {
MR> +		ret = i2c_mux_gpio_probe_dt(mux, pdev);
MR> +		if (ret < 0)
MR> +			return ret;
MR>  	}
 
MR>  	/*
MR>  	 * If a GPIO chip name is provided, the GPIO pin numbers provided are
MR>  	 * relative to its base GPIO number. Otherwise they are absolute.
MR>  	 */
MR> -	if (pdata->gpio_chip) {
MR> +	if (mux->data->gpio_chip) {
MR>  		struct gpio_chip *gpio;
 
MR> -		gpio = gpiochip_find(pdata->gpio_chip,
MR> +		gpio = gpiochip_find(mux->data->gpio_chip,
MR>  				     match_gpio_chip_by_label);
MR>  		if (!gpio)
MR>  			return -EPROBE_DEFER;
MR> @@ -89,49 +180,44 @@ static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
MR>  		gpio_base = 0;
MR>  	}
 
MR> -	parent = i2c_get_adapter(pdata->parent);
MR> +	parent = i2c_get_adapter(mux->data->parent);
MR>  	if (!parent) {
MR>  		dev_err(&pdev->dev, "Parent adapter (%d) not found\n",
MR> -			pdata->parent);
MR> +			mux->data->parent);
MR>  		return -ENODEV;
MR>  	}
 
MR> -	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
MR> -	if (!mux) {
MR> -		ret = -ENOMEM;
MR> -		goto alloc_failed;
MR> -	}
MR> -
mux-> parent = parent;
MR> -	mux->data = *pdata;
mux-> gpio_base = gpio_base;
MR> +
mux-> adap = devm_kzalloc(&pdev->dev,
MR> -				 sizeof(*mux->adap) * pdata->n_values,
MR> +				 sizeof(*mux->adap) * mux->data->n_values,
MR>  				 GFP_KERNEL);
MR>  	if (!mux->adap) {
MR> +		dev_err(&pdev->dev, "Cannot allocate i2c_adapter structure");
MR>  		ret = -ENOMEM;
MR>  		goto alloc_failed;
MR>  	}
 
MR> -	if (pdata->idle != I2C_MUX_GPIO_NO_IDLE) {
MR> -		initial_state = pdata->idle;
MR> +	if (mux->data->idle != I2C_MUX_GPIO_NO_IDLE) {
MR> +		initial_state = mux->data->idle;
MR>  		deselect = i2c_mux_gpio_deselect;
MR>  	} else {
MR> -		initial_state = pdata->values[0];
MR> +		initial_state = mux->data->values[0];
MR>  		deselect = NULL;
MR>  	}
 
MR> -	for (i = 0; i < pdata->n_gpios; i++) {
MR> -		ret = gpio_request(gpio_base + pdata->gpios[i], "i2c-mux-gpio");
MR> +	for (i = 0; i < mux->data->n_gpios; i++) {
MR> +		ret = gpio_request(gpio_base + mux->data->gpios[i], "i2c-mux-gpio");
MR>  		if (ret)
MR>  			goto err_request_gpio;
MR> -		gpio_direction_output(gpio_base + pdata->gpios[i],
MR> +		gpio_direction_output(gpio_base + mux->data->gpios[i],
MR>  				      initial_state & (1 << i));
MR>  	}
 
MR> -	for (i = 0; i < pdata->n_values; i++) {
MR> -		u32 nr = pdata->base_nr ? (pdata->base_nr + i) : 0;
MR> -		unsigned int class = pdata->classes ? pdata->classes[i] : 0;
MR> +	for (i = 0; i < mux->data->n_values; i++) {
MR> +		u32 nr = mux->data->base_nr ? (mux->data->base_nr + i) : 0;
MR> +		unsigned int class = mux->data->classes ? mux->data->classes[i] : 0;
 
mux-> adap[i] = i2c_add_mux_adapter(parent, &pdev->dev, mux, nr,
MR>  						   i, class,
MR> @@ -144,19 +230,17 @@ static int __devinit i2c_mux_gpio_probe(struct platform_device *pdev)
MR>  	}
 
MR>  	dev_info(&pdev->dev, "%d port mux on %s adapter\n",
MR> -		 pdata->n_values, parent->name);
MR> -
MR> -	platform_set_drvdata(pdev, mux);
MR> +		 mux->data->n_values, parent->name);
 
MR>  	return 0;
 
MR>  add_adapter_failed:
MR>  	for (; i > 0; i--)
MR>  		i2c_del_mux_adapter(mux->adap[i - 1]);
MR> -	i = pdata->n_gpios;
MR> +	i = mux->data->n_gpios;
MR>  err_request_gpio:
MR>  	for (; i > 0; i--)
MR> -		gpio_free(gpio_base + pdata->gpios[i - 1]);
MR> +		gpio_free(gpio_base + mux->data->gpios[i - 1]);
MR>  alloc_failed:
MR>  	i2c_put_adapter(parent);
 
MR> @@ -168,11 +252,11 @@ static int __devexit i2c_mux_gpio_remove(struct platform_device *pdev)
MR>  	struct gpiomux *mux = platform_get_drvdata(pdev);
MR>  	int i;
 
MR> -	for (i = 0; i < mux->data.n_values; i++)
MR> +	for (i = 0; i < mux->data->n_values; i++)
MR>  		i2c_del_mux_adapter(mux->adap[i]);
 
MR> -	for (i = 0; i < mux->data.n_gpios; i++)
MR> -		gpio_free(mux->gpio_base + mux->data.gpios[i]);
MR> +	for (i = 0; i < mux->data->n_gpios; i++)
MR> +		gpio_free(mux->gpio_base + mux->data->gpios[i]);
 
MR>  	platform_set_drvdata(pdev, NULL);
MR>  	i2c_put_adapter(mux->parent);
MR> @@ -180,12 +264,19 @@ static int __devexit i2c_mux_gpio_remove(struct platform_device *pdev)
MR>  	return 0;
MR>  }
 
MR> +static const struct of_device_id i2c_mux_gpio_of_match[] __devinitconst = {
MR> +	{ .compatible = "i2c-mux-gpio", },
MR> +	{},
MR> +};
MR> +MODULE_DEVICE_TABLE(of, i2c_mux_gpio_of_match);
MR> +
MR>  static struct platform_driver i2c_mux_gpio_driver = {
MR>  	.probe	= i2c_mux_gpio_probe,
MR>  	.remove	= __devexit_p(i2c_mux_gpio_remove),
MR>  	.driver	= {
MR>  		.owner	= THIS_MODULE,
MR>  		.name	= "i2c-mux-gpio",
MR> +		.of_match_table = of_match_ptr(i2c_mux_gpio_of_match),
MR>  	},
MR>  };
 
MR> -- 
MR> 1.7.9.5


-- 
Sorry about disclaimer - It's out of my control.
Bye, Peter Korsgaard


DISCLAIMER:
Unless indicated otherwise, the information contained in this message is privileged and confidential, and is intended only for the use of the addressee(s) named above and others who have been specifically authorized to receive it. If you are not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this message and/or attachments is strictly prohibited. The company accepts no liability for any damage caused by any virus transmitted by this email. Furthermore, the company does not warrant a proper and complete transmission of this information, nor does it accept liability for any delays. If you have received this message in error, please contact the sender and delete the message. Thank you.
