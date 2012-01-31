From: hs@denx.de (Heiko Schocher)
Date: Tue, 31 Jan 2012 08:14:28 +0100
Subject: [RFC PATCH 5/7] ARM: davinci: i2c: add OF support
In-Reply-To: <20120130200436.GU28397@ponder.secretlab.ca>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-6-git-send-email-hs@denx.de>
 <20120130200436.GU28397@ponder.secretlab.ca>
Message-ID: <4F2794D4.8060103@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Grant,

Grant Likely wrote:
> On Mon, Jan 23, 2012 at 09:56:05AM +0100, Heiko Schocher wrote:
>> add of support for the davinci i2c driver.
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> Cc: davinci-linux-open-source at linux.davincidsp.com
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: linux-i2c at vger.kernel.org
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Cc: Wolfram Sang <w.sang@pengutronix.de>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Wolfgang Denk <wd@denx.de>
> 
> Hi Heiko,
> 
> comments below.

Thanks!

>> ---
>>  .../devicetree/bindings/arm/davinci/i2c.txt        |   39 ++++++++++++++++++
>>  drivers/i2c/busses/i2c-davinci.c                   |   43 ++++++++++++++++++++
>>  2 files changed, 82 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/davinci/i2c.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/davinci/i2c.txt b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
>> new file mode 100644
>> index 0000000..94ec670
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/davinci/i2c.txt
>> @@ -0,0 +1,39 @@
>> +* Texas Instruments Davinci I2C
>> +
>> +This file provides information, what the device node for the
>> +davinci i2c interface contain.
>> +
>> +Required properties:
>> +- compatible: "ti,davinci-i2c";
>> +- reg : Offset and length of the register set for the device
>> +- id: id of the controller
> 
> Don't use an 'id' property.  i2c bus numbers should be dynamically
> assigned when using the device tree.

Yep, removed!

>> +
>> +Recommended properties :
>> +- interrupts : <a b> where a is the interrupt number and b is a
>> +  field that represents an encoding of the sense and level
>> +  information for the interrupt.
> 
> This is inaccurate.  It is entirely defined by the interrupt
> controller.  All you need to say here is that this is a standard
> interrupts property.

fixed.

>> +- interrupt-parent : the phandle for the interrupt controller that
>> +  services interrupts for this device.
> 
> Don't even mention this one.  It can often be inherited from a parent
> node.

deleted.

[...]
>> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
>> index a76d85f..6f59fae 100644
>> --- a/drivers/i2c/busses/i2c-davinci.c
>> +++ b/drivers/i2c/busses/i2c-davinci.c
>> @@ -38,9 +38,12 @@
>>  #include <linux/slab.h>
>>  #include <linux/cpufreq.h>
>>  #include <linux/gpio.h>
>> +#include <linux/of_i2c.h>
>> +#include <linux/of_device.h>
>>  
>>  #include <mach/hardware.h>
>>  #include <mach/i2c.h>
>> +#include <mach/mux.h>
>>  
>>  /* ----- global defines ----------------------------------------------- */
>>  
>> @@ -635,6 +638,16 @@ static struct i2c_algorithm i2c_davinci_algo = {
>>  	.functionality	= i2c_davinci_func,
>>  };
>>  
>> +#if defined(CONFIG_OF)
>> +static const struct of_device_id davinci_i2c_of_match[] = {
>> +	{.compatible = "ti,davinci-i2c", },
>> +	{},
>> +}
>> +MODULE_DEVICE_TABLE(of, davinci_i2c_of_match);
>> +#else
>> +#define davinci_i2c_of_match NULL
>> +#endif
> 
> The #else clause can be dropped if you use the of_match_ptr() macro
> when referencing it.

removed.

>> +
>>  static int davinci_i2c_probe(struct platform_device *pdev)
>>  {
>>  	struct davinci_i2c_dev *dev;
>> @@ -676,7 +689,34 @@ static int davinci_i2c_probe(struct platform_device *pdev)
>>  	dev->irq = irq->start;
>>  	platform_set_drvdata(pdev, dev);
>>  
>> +	if ((dev->dev->platform_data == NULL) &&
>> +		(pdev->dev.of_node)) {
>> +		struct device_node *pinmux_np;
>> +		struct davinci_i2c_platform_data *pdata;
>> +		u32 prop;
>> +
>> +		dev->dev->platform_data = &davinci_i2c_platform_data_default;
> 
> Don't do this.  What if a davinci part shows up with two i2c busses?
> Use devm_kzalloc() instead.

Fixed.

>> +		pdata = &davinci_i2c_platform_data_default;
>> +		if (!of_property_read_u32(pdev->dev.of_node, "clock-frequency",
>> +			&prop))
>> +			pdata->bus_freq = prop / 1000;
>> +		if (!of_property_read_u32(pdev->dev.of_node, "bus-delay",
>> +			&prop))
>> +			pdata->bus_delay = prop;
>> +		if (!of_property_read_u32(pdev->dev.of_node, "id",
>> +			&prop)) {
>> +			pdev->id = prop;
>> +			pdev->dev.init_name = kzalloc(20, GFP_KERNEL);
>> +			sprintf((char *)pdev->dev.init_name,
>> +				"i2c_davinci.%d", pdev->id);
> 
> Blech!  Drop this.  Leave the core code to set the device name.

completely removed.

>>  	dev->clk = clk_get(&pdev->dev, NULL);
>> +
>>  	if (IS_ERR(dev->clk)) {
> 
> Nit: unrelated whitespace change

Ups, good catch, fixed.

[...]

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
