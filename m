From: robherring2@gmail.com (Rob Herring)
Date: Wed, 23 Oct 2013 17:18:27 -0500
Subject: [PATCHv5][ 1/4] Input: tsc2007: Add device tree support.
In-Reply-To: <1382530220-27881-1-git-send-email-denis@eukrea.com>
References: <1382530220-27881-1-git-send-email-denis@eukrea.com>
Message-ID: <52684B33.6040109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2013 07:10 AM, Denis Carikli wrote:
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input at vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Lothar Wa?mann <LW@KARO-electronics.de>
> Cc: Eric B?nard <eric@eukrea.com>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
> ChangeLog v4->v5:
> - Most of the "if (ts->of)" were replaced by wrapping them in the
>   tsc2007_is_pen_down_valid and tsc2007_is_pen_down functions.
> - Some whitespace cleanups.
> - The devm_kzalloc call was fixed to make it compile.
> ---
>  .../bindings/input/touchscreen/tsc2007.txt         |   44 +++++
>  drivers/input/touchscreen/tsc2007.c                |  194 +++++++++++++++-----
>  2 files changed, 197 insertions(+), 41 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> new file mode 100644
> index 0000000..fadd3f6
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

I'm confused why an i2c slave needs pinctl binding?

> +- interrupt-parent: the phandle for the interrupt controller
> +  (see interrupt binding[1]).
> +- interrupts: interrupt to which the chip is connected
> +  (see interrupt binding[1]).
> +- ti,x-plate-ohms: X-plate resistance in ohms.
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
> +			ti,x-plate-ohms = <180>;
> +		};
> +
> +		/* ... */
> +	};
> diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
> index 0b67ba4..0625fe1 100644
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
> @@ -84,6 +90,11 @@ struct tsc2007 {
>  	void			(*clear_penirq)(void);
>  };
>  
> +static int tsc2007_get_pendown_state_dt(struct tsc2007 *ts)
> +{
> +	return !gpio_get_value(ts->gpio);
> +}
> +
>  static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
>  {
>  	s32 data;
> @@ -142,6 +153,14 @@ static u32 tsc2007_calculate_pressure(struct tsc2007 *tsc, struct ts_event *tc)
>  	return rt;
>  }
>  
> +static bool tsc2007_is_pen_down_valid(struct tsc2007 *ts)
> +{
> +	if (ts->of)
> +		return gpio_is_valid(ts->gpio);
> +	else
> +		return ts->get_pendown_state ? true : false;
> +}
> +
>  static bool tsc2007_is_pen_down(struct tsc2007 *ts)
>  {
>  	/*
> @@ -158,10 +177,13 @@ static bool tsc2007_is_pen_down(struct tsc2007 *ts)
>  	 * to fall back on the pressure reading.
>  	 */
>  
> -	if (!ts->get_pendown_state)
> +	if (!tsc2007_is_pen_down_valid(ts))
>  		return true;
>  
> -	return ts->get_pendown_state();
> +	if (ts->of)
> +		return tsc2007_get_pendown_state_dt(ts);
> +	else
> +		return ts->get_pendown_state();
>  }
>  
>  static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
> @@ -178,7 +200,7 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>  
>  		rt = tsc2007_calculate_pressure(ts, &tc);
>  
> -		if (rt == 0 && !ts->get_pendown_state) {
> +		if(!rt && !tsc2007_is_pen_down_valid(ts)) {
>  			/*
>  			 * If pressure reported is 0 and we don't have
>  			 * callback to check pendown state, we have to
> @@ -228,7 +250,7 @@ static irqreturn_t tsc2007_hard_irq(int irq, void *handle)
>  {
>  	struct tsc2007 *ts = handle;
>  
> -	if (!ts->get_pendown_state || likely(ts->get_pendown_state()))
> +	if (tsc2007_is_pen_down(ts))
>  		return IRQ_WAKE_THREAD;
>  
>  	if (ts->clear_penirq)
> @@ -273,34 +295,65 @@ static void tsc2007_close(struct input_dev *input_dev)
>  	tsc2007_stop(ts);
>  }
>  
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
> +	u32 val32;
> +	u64 val64;
> +
> +	if (!of_property_read_u32(np, "max-rt", &val32))
> +		ts->max_rt = val32;
> +	else
> +		ts->max_rt = MAX_12BIT;

These functions don't overwrite the value if the property isn't present.
So you can set the values to the defaults and just pass the variable
(i.e. ts->max_rt) to of_property_read_u32 directly.

Rob
