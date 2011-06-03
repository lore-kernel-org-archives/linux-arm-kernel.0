From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 3 Jun 2011 10:20:21 -0600
Subject: [RFC 3/3] ARM:Tegra: Device Tree Support: Initialize from wm8903
	the device tree
In-Reply-To: <20110512074917.GA16250@opensource.wolfsonmicro.com>
References: <20110511231905.10362.12844.stgit@riker>
	<20110511232711.10362.53256.stgit@riker>
	<20110512074917.GA16250@opensource.wolfsonmicro.com>
Message-ID: <BANLkTimAtYw9KAunOzMApyTuaHWqHO9EoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2011 at 1:49 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, May 11, 2011 at 04:27:18PM -0700, John Bonesio wrote:
>> This patch makes it so the wm8903 is initialized from it's device tree node.
>>
>> Signed-off-by: John Bonesio<bones@secretlab.ca>
>> ---
>>
>> ?arch/arm/boot/dts/tegra-harmony.dts | ? 17 ++++++
>> ?sound/soc/codecs/wm8903.c ? ? ? ? ? | ? 93 +++++++++++++++++++++++++++++++++--
>
> This needs to be sent separately to the relevant mailing lists and
> maintainers. ?You can't go making substantial changes to drivers without
> even telling the maintainers about it - this will apply to any device
> tree work you're doing. ?In this case one of the maintainers happens to
> be me, but even so.
>
>> + ? ? ? ? ? ? ? ? ? ? interrupts = < 347 >;
>> + ? ? ? ? ? ? ? ? ? ? irq-active-low = <0>;
>> + ? ? ? ? ? ? ? ? ? ? micdet-cfg = <0>;
>> + ? ? ? ? ? ? ? ? ? ? micdet-delay = <100>;
>
> Some of this looks like chip default, why is it being configured?
>
>> + ? ? ? ? ? ? ? ? ? ? ? gpio-controller;
>> + ? ? ? ? ? ? ? ? ? ? ? #gpio-cells = <2>;
>
> The fact that this device is a GPIO controller is a physical property of
> the device, we shouldn't need to be putting it into the device tree.
>
>> + ? ? ? ? ? ? ? ? ? ? gpio-num-cfg = < 5 >;
>
> Similarly here, the device has a fixed number of GPIOs.
>
>> + ? ? ? ? ? ? ? ? ? ? /* #define WM8903_GPIO_NO_CONFIG 0x8000 */
>> + ? ? ? ? ? ? ? ? ? ? gpio-cfg = < 0x8000 0x8000 0 0x8000 0x8000 >;
>
> This doesn't seem great for usability. ?I'd suggest key/value pairs
> rather than an array.
>
>> - ? ? if (pdata && pdata->gpio_base)
>> + ? ? wm8903->gpio_chip.base = -1;
>> + ? ? if (pdata && pdata->gpio_base) {
>> ? ? ? ? ? ? ? wm8903->gpio_chip.base = pdata->gpio_base;
>> - ? ? else
>> - ? ? ? ? ? ? wm8903->gpio_chip.base = -1;
>> + ? ? } else if (codec->dev->of_node) {
>> + ? ? ? ? ? ? prop = of_get_property(codec->dev->of_node, "gpio-base", NULL);
>> + ? ? ? ? ? ? if (prop)
>> + ? ? ? ? ? ? ? ? ? ? wm8903->gpio_chip.base = be32_to_cpup(prop);
>> + ? ? }
>
> We have to do manual endianness conversions to read from the device
> tree? ?Oh, well.
>
>> +
>> + ? ? ? ? ? ? prop = of_get_property(codec->dev->of_node, "interrupts", NULL);
>> + ? ? ? ? ? ? if (prop)
>> + ? ? ? ? ? ? ? ? ? ? wm8903->irq = be32_to_cpup(prop);
>> +
>
> We have a standard way of passing the IRQ number to I2C devices, surely
> we should make sure that works at the bus level rather than having to
> replicate this code everywhere?

Yes actually there is.  The code in drivers/of/of_i2c.c already
correctly populates the i2c_client irq from the device tree.  This
hunk can be completely removed.

g.
