From: robherring2@gmail.com (Rob Herring)
Date: Wed, 07 Mar 2012 13:30:46 -0600
Subject: [PATCH 1/5 v2] i2c/gpio: add DT support
In-Reply-To: <20120307172223.GB17087@game.jcrosoft.org>
References: <1330525221-25651-1-git-send-email-plagnioj@jcrosoft.com>
 <4F5797F4.2040104@gmail.com> <20120307172223.GB17087@game.jcrosoft.org>
Message-ID: <4F57B766.3010701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2012 11:22 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 11:16 Wed 07 Mar     , Rob Herring wrote:
>> On 02/29/2012 08:20 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>>> Cc: linux-i2c at vger.kernel.org
>>> Cc: devicetree-discuss at lists.ozlabs.org
>>> ---
>>> v2:
>>>
>>> 	use devm_kzalloc
>>> 	use i2c-gpio
>>> 	use time name in the properties
>>>
>>> Best Regars,
>>> J.
>>>  .../devicetree/bindings/gpio/gpio_i2c.txt          |   32 +++++++
>>>  drivers/i2c/busses/i2c-gpio.c                      |   95 +++++++++++++++----
>>>  2 files changed, 107 insertions(+), 20 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio_i2c.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/gpio_i2c.txt b/Documentation/devicetree/bindings/gpio/gpio_i2c.txt
>>> new file mode 100644
>>> index 0000000..27e1b1a
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpio/gpio_i2c.txt
>>> @@ -0,0 +1,32 @@
>>> +Device-Tree bindings for i2c gpio driver
>>> +
>>> +Required properties:
>>> +	- compatible = "i2c-gpio";
>>> +	- gpios: sda and scl gpio
>>> +
>>> +
>>> +Optional properties:
>>> +	- i2c-gpio,sda-open-drain: sda as open drain
>>> +	- i2c-gpio,scl-open-drain: scl as open drain
>>> +	- i2c-gpio,scl-output-only: scl as output only
>>> +	- udelay: delay between GPIO operations (may depend on each platform)
>>
>> i2c-gpio,delay-us
>>
>>> +	- i2c-algo-bit,timeout-milliseconds: timeout to get data
>>
>> i2c-gpio,timeout-ms
> it's algo-bit speficic no i2c-gpio that's why I use i2c-algo-bit

Don't bring Linux into the binding. I would have to look at the Linux
driver to understand your reasoning.

>>
>>> +
>>> +Example nodes:
>>> +
>>> +i2c-gpio at 0 {
>>
>> Should be "i2c at 0"
> ok
>>
>>> +	compatible = "i2c-gpio";
>>> +	gpios = <&pioA 23 0 /* sda */
>>> +		 &pioA 24 0 /* scl */
>>> +		>;
>>> +	i2c-gpio,sda-open-drain;
>>> +	i2c-gpio,scl-open-drain;
>>> +	udelay = <2>;		/* ~100 kHz */
>>> +	#address-cells = <1>;
>>> +	#size-cells = <0>;
>>> +
>>> +	rv3029c2 at 56 {
>>> +		compatible = "rv3029c2";
>>> +		reg = <0x56>;
>>> +	};
>>> +};
>>> diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
>>> index a651779..71adba5 100644
>>> --- a/drivers/i2c/busses/i2c-gpio.c
>>> +++ b/drivers/i2c/busses/i2c-gpio.c
>>> @@ -14,8 +14,15 @@
>>>  #include <linux/module.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/platform_device.h>
>>> +#include <linux/gpio.h>
>>> +#include <linux/of_gpio.h>
>>> +#include <linux/of_i2c.h>
>>>  
>>> -#include <asm/gpio.h>
>>> +struct i2c_gpio_private_data {
>>> +	struct i2c_adapter adap;
>>> +	struct i2c_algo_bit_data bit_data;
>>> +	struct i2c_gpio_platform_data pdata;
>>> +};
>>>  
>>>  /* Toggle SDA by changing the direction of the pin */
>>>  static void i2c_gpio_setsda_dir(void *data, int state)
>>> @@ -78,24 +85,63 @@ static int i2c_gpio_getscl(void *data)
>>>  	return gpio_get_value(pdata->scl_pin);
>>>  }
>>>  
>>> +static int __devinit of_i2c_gpio_probe(struct device_node *np,
>>> +			     struct i2c_gpio_platform_data *pdata)
>>> +{
>>> +	u32 reg;
>>> +
>>> +	if (of_gpio_count(np) < 2)
>>> +		return -ENODEV;
>>> +
>>> +	pdata->sda_pin = of_get_gpio(np, 0);
>>> +	pdata->scl_pin = of_get_gpio(np, 1);
>>> +
>>> +	if (pdata->sda_pin < 0 || pdata->scl_pin < 0) {
>>> +		pr_err("%s: invalid GPIO pins, sda=%d/scl=%d\n",
>>> +		       np->full_name, pdata->sda_pin, pdata->scl_pin);
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	if (of_property_read_u32(np, "udelay", &reg))
>>> +		pdata->udelay = reg;
>>
>> Why not of_property_read_u32(np, "udelay", &pdata->udelay)?
>>
>> Also, reg may not be initialized here.
> if udelay have any error we keep udelay as 0
> 

Right, so there is no init issue with reg, but still you can just right
this and get rid of the if:

of_property_read_u32(np, "udelay", &pdata->udelay);

If there's an error, the value will be unchanged.

Rob

> Best Regards,
> J.
