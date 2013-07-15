From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 15 Jul 2013 23:43:01 +0200
Subject: [PATCH 19/22] Input: tsc2007: Add device tree support.
In-Reply-To: <1373900227-341-20-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-20-git-send-email-denis@eukrea.com>
Message-ID: <20130715214301.GF10995@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 04:57:04PM +0200, Denis Carikli wrote:
> Set the of_match_table for this driver so that devices can be described
>   in the device tree.
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  .../bindings/input/touchscreen/tsc2007.txt         |   44 +++++
>  drivers/input/touchscreen/tsc2007.c                |  205 ++++++++++++++++----
>  2 files changed, 206 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> new file mode 100644
> index 0000000..d67b33f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> @@ -0,0 +1,44 @@
> +* Texas Instruments tsc2007 touchscreen controller
> +
> +Required properties:
> +- compatible: must be "ti,tsc2007".
> +- reg: I2C address of the chip.
> +- pinctrl-0: Should specify pin control groups used for this controller
> +  (see pinctrl bindings[0]).
> +- pinctrl-names: Should contain only one value - "default"
> +  (see pinctrl bindings[0]).
> +- interrupt-parent: the phandle for the interrupt controller
> +  (see interrupt binding[1]).
> +- interrupts: interrupt to which the chip is connected
> +  (see interrupt binding[1]).
> +- x-plate-ohms: X-plate resistance in ohms.
> +
> +Optional properties:
> +- gpios: the interrupt gpio the chip is connected to (trough the penirq pin)
> +  (see GPIO binding[2] for more details).
> +- max-rt: maximum pressure.
> +- fuzzy: specifies the fuzz value that is used to filter noise from the event
> +  stream.
> +- poll-period: how much time to wait(in millisecond) before reading again the
> +  values from the tsc2007.
> +
> +[0]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> +[1]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +[2]: Documentation/devicetree/bindings/gpio/gpio.txt
> +
> +Example:
> +	&i2c1 {
> +		/* ... */
> +		tsc2007 at 49 {
> +			compatible = "ti,tsc2007";
> +			reg = <0x49>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_tsc2007_1>;
> +			interrupt-parent = <&gpio4>;
> +			interrupts = <0x0 0x8>;
> +			gpios = <&gpio4 0 0>;
> +			x-plate-ohms = <180>;
> +		};
> +
> +		/* ... */
> +	};
> diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
> index 0b67ba4..c0af04b 100644
> --- a/drivers/input/touchscreen/tsc2007.c
> +++ b/drivers/input/touchscreen/tsc2007.c
> @@ -26,6 +26,9 @@
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c/tsc2007.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
>  
>  #define TSC2007_MEASURE_TEMP0		(0x0 << 4)
>  #define TSC2007_MEASURE_AUX		(0x2 << 4)
> @@ -74,7 +77,10 @@ struct tsc2007 {
>  	u16			max_rt;
>  	unsigned long		poll_delay;
>  	unsigned long		poll_period;
> +	int			fuzzy;
> +	char			of;
>  
> +	unsigned		gpio;
>  	int			irq;
>  
>  	wait_queue_head_t	wait;
> @@ -84,6 +90,14 @@ struct tsc2007 {
>  	void			(*clear_penirq)(void);
>  };
>  
> +static int tsc2007_get_pendown_state_dt(struct tsc2007  *ts)
> +{
> +	if (ts->gpio >= 0)
> +		return !gpio_get_value(ts->gpio);
> +	else
> +		return true;
> +}
> +
>  static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
>  {
>  	s32 data;
> @@ -158,6 +172,9 @@ static bool tsc2007_is_pen_down(struct tsc2007 *ts)
>  	 * to fall back on the pressure reading.
>  	 */
>  
> +	if (ts->of)
> +		return tsc2007_get_pendown_state_dt(ts);

Initializing tsc->gpio to an illegal gpio for the non dt case makes
ts->of unnecessary and the core driver dt agnostic.

> -static int tsc2007_probe(struct i2c_client *client,
> -				   const struct i2c_device_id *id)
> +#ifdef CONFIG_OF
> +static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 *ts,
> +			    struct device_node *np)
>  {
> -	struct tsc2007 *ts;
> -	struct tsc2007_platform_data *pdata = client->dev.platform_data;
> -	struct input_dev *input_dev;
> -	int err;
> -
> -	if (!pdata) {
> -		dev_err(&client->dev, "platform data is required!\n");
> +	int err = 0;
> +	struct pinctrl *pinctrl;
> +	u32 val32;
> +	u64 val64;
> +
> +	if (!of_property_read_u32(np, "max-rt", &val32))
> +		ts->max_rt = val32;
> +	else
> +		ts->max_rt = MAX_12BIT;
> +
> +	if (!of_property_read_u32(np, "fuzzy", &val32))
> +		ts->fuzzy = val32;
> +
> +	if (!of_property_read_u64(np, "poll-period", &val64))
> +		ts->poll_period = val64;
> +	else
> +		ts->poll_period = 1;
> +
> +	if (!of_property_read_u32(np, "x-plate-ohms", &val32))
> +		ts->x_plate_ohms = val32;
> +	else {
> +		dev_err(&client->dev,
> +			"x-plate-ohms is not set up in the devicetree."
> +			" (err %d).", err);
>  		return -EINVAL;
>  	}

if one path of an if/else needs braces the other should have braces
aswell.

>  
> -	if (!i2c_check_functionality(client->adapter,
> -				     I2C_FUNC_SMBUS_READ_WORD_DATA))
> -		return -EIO;
> -
> -	ts = kzalloc(sizeof(struct tsc2007), GFP_KERNEL);
> -	input_dev = input_allocate_device();
> -	if (!ts || !input_dev) {
> -		err = -ENOMEM;
> -		goto err_free_mem;
> +	pinctrl = devm_pinctrl_get_select_default(&client->dev);
> +	if (IS_ERR(pinctrl)) {
> +		err = PTR_ERR(pinctrl);
> +		return err;

The driver core will do this for you already.

>  	}
>  
> -	ts->client = client;
> -	ts->irq = client->irq;
> -	ts->input = input_dev;
> -	init_waitqueue_head(&ts->wait);
> +	ts->gpio = of_get_gpio(np, 0);
> +	if (ts->gpio < 0)
> +		pr_err("GPIO not found (of_get_gpio returned %d)\n", ts->gpio);

use dev_err.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
