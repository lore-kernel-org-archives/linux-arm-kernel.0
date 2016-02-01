From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Mon, 1 Feb 2016 22:49:16 +0000
Subject: [PATCH 05/11] drivers: pinctrl: add driver for Allwinner A64 SoC
In-Reply-To: <20160201182754.GA14737@excalibur.cnev.de>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-6-git-send-email-andre.przywara@arm.com>
 <20160201182754.GA14737@excalibur.cnev.de>
Message-ID: <56AFE0EC.8080207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/16 18:27, Karsten Merker wrote:

Hi Karsten,

thank you very much for your feedback!

> On Mon, Feb 01, 2016 at 05:39:24PM +0000, Andre Przywara wrote:
>> Based on the Allwinner A64 user manual and on the previous sunxi
>> pinctrl drivers this introduces the pin multiplex assignments for
>> the ARMv8 Allwinner A64 SoC.
>> Port A is apparently used for the fixed function DRAM controller, so
>> the ports start at B here (the manual mentions "n from 1 to 7", so
>> not starting at 0).
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
>>  arch/arm64/Kconfig.platforms                       |   1 +
>>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>>  drivers/pinctrl/sunxi/pinctrl-a64.c                | 606 +++++++++++++++++++++
>>  5 files changed, 613 insertions(+)
>>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-a64.c
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
>> index 9213b27..9050002 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
>> @@ -21,6 +21,7 @@ Required properties:
>>    "allwinner,sun9i-a80-r-pinctrl"
>>    "allwinner,sun8i-a83t-pinctrl"
>>    "allwinner,sun8i-h3-pinctrl"
>> +  "allwinner,a64-pinctrl"
> 
> Hello,
> 
> on all other Allwinner SoCs we use the SoC family as part of the
> compatible, as well as in the names of the Kconfig options. To
> keep things consistent, I would like to propose doing the same on
> Arm64, i.e. using allwinner,sun50i-a64-pinctrl instead of
> allwinner,a64-pinctrl.

Yes, I have been told this already. However I don't like this idea so
much, for the following reasons:
a) It is mostly redundant. The actual SoC (marketing) name is unique,
there is no sun6i-a20 or sun7i-a23.
b) It is not even helpful. If I got Maxime correctly, then the newer
sunxi generation numbers depend on the ARM _cores_ used in the SoC,
which is frankly the least interesting part from a Linux support
perspective. I would see some sense if it would reflect the generation
of IP blocks used, but so it is even more confusing to see that
sun7i-a20 and sun8i-a23 are related, but sun8i-h3 is a completely
different beast. The Allwinner marketing name tells you that, but the
sunxi one does not.
c) It is very confusing for people not dealing with it everyday. Just
because I own a BananaPi I know that the A20 is sun7i, but I am totally
lost when it comes to all the other names. And even now it took me about
a minute to find the appropriate Wiki page which explains part of that
story.
d) Most importantly ;-): It kills TAB completion, unless you know the
sunxi number, which is mostly not true as pointed out in c)

So while I see that just a<somenumber> is not really very specific, I'd
rather do away with current naming scheme for the future. In this
particular case we have the vendor name as a name space identifier
already, so there is no possible confusion with ARM Cortex naming, for
instance.

Also as this is now moving into the arm64 world, I'd like to use the
opportunity to fix things that are not really optimal, the naming is one
of them.

>>  - reg: Should contain the register physical address and length for the
>>    pin controller.
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index fc7cf4b..03f0f9d 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -2,6 +2,7 @@ menu "Platform selection"
>>  
>>  config ARCH_SUNXI
>>  	bool "Allwinner sunxi 64-bit SoC Family"
>> +	select PINCTRL_A64
> 
> Same as above, just with the name of the Kconfig option.
> s/PINCTRL_A64/PINCTRL_SUN50I_A64/ ?

I can see the reasoning behind this particular one, as A64 is not very
specific. And indeed I had planned to replace this, but forgot it over
merging all the stuff together. However I'd rather go with the generic
"sunxi" as a stub name (PINCTRL_SUNXI_A64), as the "50" in there is now
completely stupi^Wconfusing and also kills my favorite sun.i regexp ;-)
I can see that the term "sunxi" is a shorthand for Allwinner in Linux,
so it looks reasonable to me to use that.

>>  	select SUNXI_MMC
>>  	help
>>  	  This enables support for Allwinner sunxi based SoCs like the A64.
>> diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
>> index f8dbc8b..68873f2 100644
>> --- a/drivers/pinctrl/sunxi/Kconfig
>> +++ b/drivers/pinctrl/sunxi/Kconfig
>> @@ -64,4 +64,8 @@ config PINCTRL_SUN9I_A80_R
>>  	depends on RESET_CONTROLLER
>>  	select PINCTRL_SUNXI_COMMON
>>  
>> +config PINCTRL_A64
> 
> see above
> 
>> +	bool
>> +	select PINCTRL_SUNXI_COMMON
>> +
>>  endif
>> diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
>> index ef82f22..e00ccde 100644
>> --- a/drivers/pinctrl/sunxi/Makefile
>> +++ b/drivers/pinctrl/sunxi/Makefile
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_PINCTRL_SUN7I_A20)		+= pinctrl-sun7i-a20.o
>>  obj-$(CONFIG_PINCTRL_SUN8I_A23)		+= pinctrl-sun8i-a23.o
>>  obj-$(CONFIG_PINCTRL_SUN8I_A23_R)	+= pinctrl-sun8i-a23-r.o
>>  obj-$(CONFIG_PINCTRL_SUN8I_A33)		+= pinctrl-sun8i-a33.o
>> +obj-$(CONFIG_PINCTRL_A64)		+= pinctrl-a64.o
> 
> see above

same as above, I'd like to go with pinctrl-sunxi-a64.o.

>>  obj-$(CONFIG_PINCTRL_SUN8I_A83T)	+= pinctrl-sun8i-a83t.o
>>  obj-$(CONFIG_PINCTRL_SUN8I_H3)		+= pinctrl-sun8i-h3.o
>>  obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-a64.c b/drivers/pinctrl/sunxi/pinctrl-a64.c
>> new file mode 100644
>> index 0000000..e72b079
>> --- /dev/null
>> +++ b/drivers/pinctrl/sunxi/pinctrl-a64.c
>> @@ -0,0 +1,606 @@
>> +/*
>> + * Allwinner A64 SoCs pinctrl driver.
>> + *
>> + * Copyright (C) 2016 - ARM Ltd.
>> + * Author: Andre Przywara <andre.przywara@arm.com>
>> + *
>> + * Based on pinctrl-sun7i-a20.c, which is:
>> + * Copyright (C) 2014 Maxime Ripard <maxime.ripard@free-electrons.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pinctrl/pinctrl.h>
>> +
>> +#include "pinctrl-sunxi.h"
>> +
>> +static const struct sunxi_desc_pin a64_pins[] = {
>> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(B, 0),
>> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
>> +		  SUNXI_FUNCTION(0x1, "gpio_out"),

....

>> +		  SUNXI_FUNCTION_IRQ_BANK(0x6, 2, 11)),	/* EINT11 */
>> +};
>> +
>> +static const struct sunxi_pinctrl_desc a64_pinctrl_data = {
>> +	.pins = a64_pins,
>> +	.npins = ARRAY_SIZE(a64_pins),
>> +	.irq_banks = 3,
>> +};
>> +
>> +static int a64_pinctrl_probe(struct platform_device *pdev)
>> +{
>> +	return sunxi_pinctrl_init(pdev,
>> +				  &a64_pinctrl_data);
>> +}
>> +
>> +static const struct of_device_id a64_pinctrl_match[] = {
>> +	{ .compatible = "allwinner,a64-pinctrl", },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, a64_pinctrl_match);
>> +
>> +static struct platform_driver a64_pinctrl_driver = {
>> +	.probe	= a64_pinctrl_probe,
>> +	.driver	= {
>> +		.name		= "a64-pinctrl",
>> +		.of_match_table	= a64_pinctrl_match,
>> +	},
>> +};
>> +module_platform_driver(a64_pinctrl_driver);
>> +
>> +MODULE_AUTHOR("Andre Przywara <andre.przywara@arm.com>");
>> +MODULE_DESCRIPTION("Allwinner A64 pinctrl driver");
>> +MODULE_LICENSE("GPL");
> 
> For the above function names one could also think about using the
> existing naming scheme including the SoC family as we do in the
> other sunxi pinctrl drivers, but as they are only internal to the
> driver, that would really just be a matter of cosmetics :-).

Indeed ;-) And it is more to type and may potentially break 80 character
lines, so if you don't mind, I keep it that way (or could add a "sunxi_"
if that is really asked for).

Thanks for looking at this and your input!

Cheers,
Andre.
