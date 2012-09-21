From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Sep 2012 10:37:03 -0600
Subject: [PATCH 2/3] i2c: mux: Add dt support to i2c-mux-gpio driver
In-Reply-To: <1348241535-27754-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1348241535-27754-1-git-send-email-maxime.ripard@free-electrons.com>
 <1348241535-27754-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <505C97AF.9060701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2012 09:32 AM, Maxime Ripard wrote:
> Allow the i2c-mux-gpio to be used by a device tree enabled device. The
> bindings are inspired by the one found in the i2c-mux-pinctrl driver.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-gpio.txt
> @@ -0,0 +1,86 @@
> +GPIO-based I2C Bus Mux
> +
> +This binding describes an I2C bus multiplexer that uses GPIOs to
> +route the I2C signals.
> +
> +                                 +-----+  +-----+
> +                                 | dev |  | dev |
> +    +------------------------+   +-----+  +-----+
> +    | SoC                    |      |        |
> +    |                   /----|------+--------+
> +    |   +---+   +------+     | child bus A, on GPIO value set to 0
> +    |   |I2C|---| Mux  |     |
> +    |   +---+   +--+---+     | child bus B, on GPIO value set to 1
> +    |              |    \----|------+--------+--------+
> +    |   +------+   |         |      |        |        |
> +    |   | GPIO |---+         |  +-----+  +-----+  +-----+
> +    |   +------+             |  | dev |  | dev |  | dev |
> +    +------------------------+  +-----+  +-----+  +-----+

The "Mux" box should be outside the SoC, since it isn't part of the SoC
itself but something external.

> +Required properties:
> +- compatible: i2c-mux-gpio
> +- i2c-parent: The phandle of the I2C bus that this multiplexer's master-side
> +  port is connected to.
> +
> +Also required are:
> +
> +- muxer-gpios: list of gpios to use to control the muxer

Perhaps just "mux-gpios"? Bikeshedding, I know...

> +* Standard I2C mux properties. See mux.txt in this directory.
> +
> +* I2C child bus nodes. See mux.txt in this directory.
> +
> +For each i2c child nodes, an I2C child bus will be created. They will
> +be numbered based on the reg property of each nodes.

s/nodes/node/ in both of the two lines above.

> +Whenever an access is made to a device on a child bus, the value set
> +in the revelant node's reg property will be outputed using the list of

s/outputed/output/

> +GPIOs, the first in the list holding the most-significant value.
> +
> +If an idle state is defined, using the idle-state (optional) property,

The idle-state property isn't documented in the list of properties above.

> +whenever an access is not being made to a device on a child bus, the
> +idle value will be programmed into the GPIOs.
> +
> +If an idle state is not defined, the most recently used value will be
> +left programmed into hardware whenever no access is being made of a
> +device on a child bus.
> +
> +Example:
> +	i2cmux {
> +		compatible = "i2c-mux-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		muxer-gpios = <&gpio1 22 0 &gpio1 23 0>;
> +		i2c-parent = <&i2c1>;
> +
> +		i2c at 0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		i2c at 1 {
> +		      reg = <1>;
> +		      #address-cells = <1>;
> +		      #size-cells = <0>;
> +		};

The indentation above is a mix of TABs and spaces, and is inconsistent
between nodes; just TABs would be best.

> +
> +		i2c at 2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};

I'm not sure it's a good idea to have example bus nodes that are empty;
why not leave out two of the options, and put some device on each of the
buses that is defined?


> +		i2c at 3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			pca9555: pca9555 at 20 {
> +				compatible = "nxp,pca9555";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				reg = <0x20>;
> +			};
> +		};
> +	};

> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c

> +#ifdef CONFIG_OF
> +static int __devinit i2c_mux_gpio_probe_dt(struct gpiomux *mux,
> +					struct platform_device *pdev)

> +	mux->data->n_values = of_get_child_count(np);
> +
> +	values = devm_kzalloc(&pdev->dev, sizeof(*mux->data->values), GFP_KERNEL);

Don't you need to multiply the size by mux->data->n_values?

> +	gpios = devm_kzalloc(&pdev->dev, mux->data->n_gpios, GFP_KERNEL);

Don't you need to multiple the size by sizeof(*gpios) here?
