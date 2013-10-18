From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 18 Oct 2013 10:36:11 +0200
Subject: [Patch v2][ 15/37] Input: tsc2007: Add device tree support.
In-Reply-To: <1382022155-21954-16-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
 <1382022155-21954-16-git-send-email-denis@eukrea.com>
Message-ID: <20131018103611.4c6baabb@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Denis Carikli <denis@eukrea.com> wrote:
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
There is already a property 'ti,x-plate-ohms' (used for ads7846).
Should this be used here too instead of inventing a new one?

[...]
> @@ -175,10 +192,10 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>  
>  		/* pen is down, continue with the measurement */
>  		tsc2007_read_values(ts, &tc);
> -
>  		rt = tsc2007_calculate_pressure(ts, &tc);
>  
> -		if (rt == 0 && !ts->get_pendown_state) {
> +		if ((ts->of && rt == 0 && ts->gpio < 0) ||
... && !gpio_is_valid(ts->gpio)) ||
for consistency?

> @@ -273,34 +294,64 @@ static void tsc2007_close(struct input_dev *input_dev)
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
> +
> +	if (!of_property_read_u32(np, "fuzzy", &val32))
> +		ts->fuzzy = val32;
> +
> +	if (!of_property_read_u64(np, "poll-period", &val64))
> +		ts->poll_period = val64;
> +	else
> +		ts->poll_period = 1;
> +
> +	if (!of_property_read_u32(np, "x-plate-ohms", &val32)) {
> +		ts->x_plate_ohms = val32;
> +	} else {
> +		dev_err(&client->dev,
> +			"x-plate-ohms is not set up in the devicetree."
> +			" (err %d).", err);
>
It's a bad habit to split messages like this, since it makes it harder
to grep the kernel source for a message in a logfile.

>  		return -EINVAL;
>  	}
>  
> -	if (!i2c_check_functionality(client->adapter,
> -				     I2C_FUNC_SMBUS_READ_WORD_DATA))
> -		return -EIO;
> +	ts->gpio = of_get_gpio(np, 0);
> +	if (!gpio_is_valid(ts->gpio))
> +		dev_err(&client->dev, "GPIO not found "
> +			"(of_get_gpio returned %d)\n", ts->gpio);
>  
dito (at least you should be consistent putting the space either in the
end of the first line or in the beginning of the next line!)

[...]
> @@ -309,13 +360,59 @@ static int tsc2007_probe(struct i2c_client *client,
>  	ts->poll_period       = pdata->poll_period ? : 1;
>  	ts->get_pendown_state = pdata->get_pendown_state;
>  	ts->clear_penirq      = pdata->clear_penirq;
> +	ts->fuzzy             = pdata->fuzzy;
>  
>  	if (pdata->x_plate_ohms == 0) {
>  		dev_err(&client->dev, "x_plate_ohms is not set up in platform data");
> -		err = -EINVAL;
> +		return -EINVAL;
> +	}
> +
> +	/* Used to detect if it is probed trough the device tree,
> +	 * in order to be able to use that information in the IRQ handler.
> +	 */
> +	ts->of = 0;
> +
> +	return 0;
> +}
> +
> +static int tsc2007_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct device_node *np = client->dev.of_node;
> +	struct tsc2007_platform_data *pdata = client->dev.platform_data;
> +	struct tsc2007 *ts;
> +	struct input_dev *input_dev;
> +	int err = 0;
> +
> +	ts = kzalloc(sizeof(struct tsc2007), GFP_KERNEL);
>
devm_kzalloc()?

> @@ -389,10 +494,19 @@ static const struct i2c_device_id tsc2007_idtable[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, tsc2007_idtable);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id tsc2007_of_match[] = {
> +	{ .compatible = "ti,tsc2007" },
> +	{ /* sentinel */ },
>
the redundant comma after the last entry in a struct initializer is
useful to ease adding more entries lateron. Since the empty entry
always has to be the last one, the comma doesn't make any sense here.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
