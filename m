From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 14 Feb 2012 05:06:54 +0100
Subject: [PATCH 1/4 v2] i2c/gpio: add DT support
In-Reply-To: <20120213230948.GC2999@freya.fluff.org>
References: <1328754308-7365-1-git-send-email-plagnioj@jcrosoft.com>
 <20120213230948.GC2999@freya.fluff.org>
Message-ID: <20120214040654.GF3378@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23:09 Mon 13 Feb     , Ben Dooks wrote:
> On Thu, Feb 09, 2012 at 03:25:05AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: linux-i2c at vger.kernel.org
> > Cc: devicetree-discuss at lists.ozlabs.org
> > ---
> > v2:
> > 
> > 	use devm
> > 	update DT bindings to i2c-gpio and sda-open-drain...
> > 	update against "of: introduce helper to manage boolean"
> > 
> > Best Regards,
> > J.
> >  .../devicetree/bindings/gpio/gpio_i2c.txt          |   32 +++++++
> >  drivers/i2c/busses/i2c-gpio.c                      |   95 +++++++++++++++----
> >  2 files changed, 107 insertions(+), 20 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/gpio_i2c.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio_i2c.txt b/Documentation/devicetree/bindings/gpio/gpio_i2c.txt
> > new file mode 100644
> > index 0000000..9710ed2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/gpio_i2c.txt
> > @@ -0,0 +1,32 @@
> > +Device-Tree bindings for i2c gpio driver
> > +
> > +Required properties:
> > +	- compatible = "i2c-gpio";
> > +	- gpios: sda and scl gpio
> > +
> > +
> > +Optional properties:
> > +	- i2c-gpio,sda-open-drain: sda as open drain
> > +	- i2c-gpio,scl-open-drain: scl as open drain
> > +	- i2c-gpio,scl-output-only: scl as output only
> > +	- udelay: delay between GPIO operations (may depend on each platform)
> > +	- timeout: timeout to get data (ms)
> > +
> > +Example nodes:
> > +
> > +i2c-gpio at 0 {
> > +	compatible = "i2c-gpio";
> > +	gpios = <&pioA 23 0 /* sda */
> > +		 &pioA 24 0 /* scl */
> > +		>;
> > +	i2c-gpio,sda-open-drain;
> > +	i2c-gpio,scl-open-drain;
> > +	udelay = <2>;		/* ~100 kHz */
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +
> > +	rv3029c2 at 56 {
> > +		compatible = "rv3029c2";
> > +		reg = <0x56>;
> > +	};
> > +};
> > diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
> > index a651779..d7032c1 100644
> > --- a/drivers/i2c/busses/i2c-gpio.c
> > +++ b/drivers/i2c/busses/i2c-gpio.c
> > @@ -14,8 +14,15 @@
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/gpio.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/of_i2c.h>
> > -#include <asm/gpio.h>
> > +struct i2c_gpio_private_data {
> > +	struct i2c_adapter adap;
> > +	struct i2c_algo_bit_data bit_data;
> > +	struct i2c_gpio_platform_data pdata;
> > +};
> >  
> >  /* Toggle SDA by changing the direction of the pin */
> >  static void i2c_gpio_setsda_dir(void *data, int state)
> > @@ -78,24 +85,63 @@ static int i2c_gpio_getscl(void *data)
> >  	return gpio_get_value(pdata->scl_pin);
> >  }
> >  
> > +static int __devinit of_i2c_gpio_probe(struct device_node *np,
> > +			     struct i2c_gpio_platform_data *pdata)
> > +{
> > +	u32 reg;
> > +
> > +	if (of_gpio_count(np) < 2)
> > +		return -ENODEV;
> 
> Hmm, there's no error print and unless updated recently I think the
> driver core will not produce any warnings if ->probe returns an
> -ENODEV. I would prefer to see this printing a warning as for the
> case below if an GPIO fails to be found.
> 
> Maybe return -EINVAL as it is not a valid configuration.
> 
> > +
> > +	pdata->sda_pin = of_get_gpio(np, 0);
> > +	pdata->scl_pin = of_get_gpio(np, 1);
> > +
> > +	if (pdata->sda_pin < 0 || pdata->scl_pin < 0) {
> > +		pr_err("%s: invalid GPIO pins, sda=%d/scl=%d\n",
> > +		       np->full_name, pdata->sda_pin, pdata->scl_pin);
> > +		return -ENODEV;
> > +	}
> > +
> > +	if (of_property_read_u32(np, "udelay", &reg))
> > +		pdata->udelay = reg;
> 
> This sounds like a "linux" specific property. I would think about
> giving it a name like frequency, or ask Grant if we have a base set
> of properties that a i2c controller should think about implementing.
as example in the doc it's the delay between each gpio operations and it's
platform specific. put frequency will assume you specify the frequency of the
bus you want but we can not calculate here (platform specific).
> 
> > +	if (of_property_read_u32(np, "timeout", &reg))
> > +		pdata->timeout = msecs_to_jiffies(reg);
> > +
> > +	pdata->sda_is_open_drain =
> > +		!!of_property_read_bool(np, "i2c-gpio,sda-open-drain");
> > +	pdata->scl_is_open_drain =
> > +		!!of_property_read_bool(np, "i2c-gpio,scl-open-drain");
> > +	pdata->scl_is_output_only =
> > +		!!of_property_read_bool(np, "i2c-gpio,scl-output-only");
> 
> I hate !!, why does of_property_read_bool() not return a bool? Also,
> why can't I find of_property_read_bool() in include/linux/* ?
because it's an other patch
> 
> Also, does of_property_read_bool() consitently return a useful value if
> the property does not exist, or is not readable? I am most concerned
> with the behaviour if one of these properties has un-parsable contents.
it's use read_u32

and return false if read_u32 return -EINVAL

Best Regards,
J.
