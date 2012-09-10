From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 10 Sep 2012 11:49:19 -0700
Subject: [PATCH V2 1/2] hwmon: Add devicetree bindings to gpio-fan
In-Reply-To: <1347285112-13542-2-git-send-email-jm@lentin.co.uk>
References: <1347035675-23907-1-git-send-email-jm@lentin.co.uk>
 <1347285112-13542-1-git-send-email-jm@lentin.co.uk>
 <1347285112-13542-2-git-send-email-jm@lentin.co.uk>
Message-ID: <20120910184919.GA30872@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 02:51:51PM +0100, Jamie Lentin wrote:
> Allow a gpio-fan to be defined in devicetree, see binding documentation
> for details.
> 
> Changes since V1:-
> * Don't hide return codes [Guenter Roeck]
> * Remove typecast noise [Guenter Roeck]
> * Use of_find_property instead of counting u32s [Guenter Roeck]
> * Don't count GPIOs twice [Andrew Lunn]
> * Use of_prop_next_u32 to get records in a more obvious fashion
> * Use CONFIG_OF_GPIO instead of CONFIG_OF
> * Apply __devinitdata to of_gpio_fan_match [Andrew Lunn]
> 

Jamie,

As suggested by others, after ---, please

> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
>  .../devicetree/bindings/gpio/gpio-fan.txt          |   25 +++++
>  drivers/hwmon/gpio-fan.c                           |  116 ++++++++++++++++++++
>  2 files changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-fan.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-fan.txt b/Documentation/devicetree/bindings/gpio/gpio-fan.txt
> new file mode 100644
> index 0000000..2dd457a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-fan.txt
> @@ -0,0 +1,25 @@
> +Bindings for fan connected to GPIO lines
> +
> +Required properties:
> +- compatible : "gpio-fan"
> +- gpios: Specifies the pins that map to bits in the control value,
> +  ordered MSB-->LSB.
> +- gpio-fan,speed-map: A mapping of possible fan RPM speeds and the
> +  control value that should be set to achieve them. This array
> +  must have the RPM values in ascending order.
> +
> +Optional properties:
> +- alarm-gpios: This pin going active indicates something is wrong with
> +  the fan, and a udev event will be fired.
> +
> +Examples:
> +
> +	gpio_fan {
> +		compatible = "gpio-fan";
> +		gpios = <&gpio1 14 1
> +			 &gpio1 13 1>;
> +		gpio-fan,speed-map = <0    0
> +				      3000 1
> +				      6000 2>;
> +		alarm-gpios = <&gpio1 15 1>;
> +	};
> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
> index 2f4b01b..f0a803b 100644
> --- a/drivers/hwmon/gpio-fan.c
> +++ b/drivers/hwmon/gpio-fan.c
> @@ -31,6 +31,8 @@
>  #include <linux/hwmon.h>
>  #include <linux/gpio.h>
>  #include <linux/gpio-fan.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_gpio.h>
>  
>  struct gpio_fan_data {
>  	struct platform_device	*pdev;
> @@ -400,14 +402,127 @@ static ssize_t show_name(struct device *dev,
>  
>  static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
>  
> +
> +#ifdef CONFIG_OF_GPIO
> +/*
> + * Translate OpenFirmware node properties into platform_data
> + */
> +static int gpio_fan_get_of_pdata(struct device *dev,
> +			    struct gpio_fan_platform_data *pdata)
> +{
> +	struct device_node *node;
> +	struct gpio_fan_speed  *speed;

s/  / /

> +	unsigned *ctrl;
> +	unsigned i;
> +	u32 u;
> +	struct property *prop;
> +	const __be32 *p;
> +
> +	node = dev->of_node;
> +
> +	/* Fill GPIO pin array */
> +	pdata->num_ctrl = of_gpio_count(node);

All other callers of this function check if the result is > 0.

Thanks,
Guenter
