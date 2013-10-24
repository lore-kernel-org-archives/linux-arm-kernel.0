From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 24 Oct 2013 08:51:50 +0200
Subject: [PATCHv5][ 1/4] Input: tsc2007: Add device tree support.
In-Reply-To: <52684B33.6040109@gmail.com>
References: <1382530220-27881-1-git-send-email-denis@eukrea.com>
 <52684B33.6040109@gmail.com>
Message-ID: <20131024085150.11a81974@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Rob Herring wrote:
> On 10/23/2013 07:10 AM, Denis Carikli wrote:
[...]
> > diff --git
a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > new file mode 100644
> > index 0000000..fadd3f6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
> > @@ -0,0 +1,44 @@
> > +* Texas Instruments tsc2007 touchscreen controller
> > +
> > +Required properties:
> > +- compatible: must be "ti,tsc2007".
> > +- reg: I2C address of the chip.
> > +- pinctrl-0: Should specify pin control groups used for this controller
> > +  (see pinctrl bindings[0]).
> > +- pinctrl-names: Should contain only one value - "default"
> > +  (see pinctrl bindings[0]).
> 
> I'm confused why an i2c slave needs pinctl binding?
> 
for the pendetect GPIO.

[...]
> > diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
> > index 0b67ba4..0625fe1 100644
> > --- a/drivers/input/touchscreen/tsc2007.c
> > +++ b/drivers/input/touchscreen/tsc2007.c
> > @@ -26,6 +26,9 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/i2c.h>
> >  #include <linux/i2c/tsc2007.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of.h>
> > +#include <linux/of_gpio.h>
> >  
> >  #define TSC2007_MEASURE_TEMP0		(0x0 << 4)
> >  #define TSC2007_MEASURE_AUX		(0x2 << 4)
> > @@ -74,7 +77,10 @@ struct tsc2007 {
> >  	u16			max_rt;
> >  	unsigned long		poll_delay;
> >  	unsigned long		poll_period;
> > +	int			fuzzy;
> > +	char			of;
> >  
> > +	unsigned		gpio;
> >  	int			irq;
> >  
> >  	wait_queue_head_t	wait;
[...]
> > @@ -273,34 +295,65 @@ static void tsc2007_close(struct input_dev *input_dev)
> >  	tsc2007_stop(ts);
> >  }
> >  
> > -static int tsc2007_probe(struct i2c_client *client,
> > -				   const struct i2c_device_id *id)
> > +#ifdef CONFIG_OF
> > +static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 *ts,
> > +			    struct device_node *np)
> >  {
> > -	struct tsc2007 *ts;
> > -	struct tsc2007_platform_data *pdata = client->dev.platform_data;
> > -	struct input_dev *input_dev;
> > -	int err;
> > -
> > -	if (!pdata) {
> > -		dev_err(&client->dev, "platform data is required!\n");
> > +	int err = 0;
> > +	u32 val32;
> > +	u64 val64;
> > +
> > +	if (!of_property_read_u32(np, "max-rt", &val32))
> > +		ts->max_rt = val32;
> > +	else
> > +		ts->max_rt = MAX_12BIT;
> 
> These functions don't overwrite the value if the property isn't present.
> So you can set the values to the defaults and just pass the variable
> (i.e. ts->max_rt) to of_property_read_u32 directly.
> 
Not quite. Since max_rt is an u16 you can't pass it to
of_property_read_u32(). And using of_property_read_u16() requires the
abominable DT notation: "/bits/ 16 <value>;"


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
