From: chunkeey@gmail.com (Christian Lamparter)
Date: Sat, 19 May 2018 11:18:53 +0200
Subject: [PATCH 4/5] pinctrl: actions: Add gpio support for Actions S900
 SoC
In-Reply-To: <20180518023056.7869-5-manivannan.sadhasivam@linaro.org>
References: <20180518023056.7869-1-manivannan.sadhasivam@linaro.org>
 <20180518023056.7869-5-manivannan.sadhasivam@linaro.org>
Message-ID: <12834501.5lBvNSZm06@debian64>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 18, 2018 4:30:55 AM CEST Manivannan Sadhasivam wrote:
> Add gpio support to pinctrl driver for Actions Semi S900 SoC.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> [...]
> +static int owl_gpio_init(struct owl_pinctrl *pctrl)
> +{
> +	struct gpio_chip *chip;
> +	int ret;
> +
> +	chip = &pctrl->chip;
> +	chip->base = -1;
> +	chip->ngpio = pctrl->soc->ngpios;
> +	chip->label = dev_name(pctrl->dev);
> +	chip->parent = pctrl->dev;
> +	chip->owner = THIS_MODULE;
> +	chip->of_node = pctrl->dev->of_node;
> +
> +	ret = gpiochip_add_data(&pctrl->chip, pctrl);
> +	if (ret) {
> +		dev_err(pctrl->dev, "failed to register gpiochip\n");
> +		return ret;
> +	}
> +
> +	ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev),
> +							0, 0, chip->ngpio);
> +	if (ret) {
> +		dev_err(pctrl->dev, "failed to add pin range\n");
> +		gpiochip_remove(&pctrl->chip);
> +		return ret;
> +	}
> +
gpiochip_add_pin_range()? That's not going to work with gpio-hogs. 

But, you can easily test this. Just add a gpio-hog [0] 
( Section 2. gpio-controller nodes) into the Devicetree's
pinctrl node.

something like: (No idea if GPIO1 is already used, but any free
gpio will do)
| 		[...]
|		pinctrl at e01b0000 {
|			compatible = "actions,s900-pinctrl";
|			reg = <0x0 0xe01b0000 0x0 0x1000>;
|			clocks = <&cmu CLK_GPIO>;
|			gpio-controller;
|			#gpio-cells = <2>;
|
|			line_b {
|				gpio-hog;
|				gpios = <1 GPIO_ACTIVE_HIGH>;
|				output-low;
|				line-name = "foo-bar-gpio";
|			};
|		};

The pinctrl probe will fail. You can fix this by
replacing the gpiochip_add_pin_range() and use
the gpio-ranges [0] property to define the range.

[0] <https://www.kernel.org/doc/Documentation/devicetree/bindings/gpio/gpio.txt>
