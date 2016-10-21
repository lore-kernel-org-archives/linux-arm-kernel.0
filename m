From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Oct 2016 11:28:32 +0100
Subject: [PATCH v2 1/9] irqchip: meson: add support for gpio interrupt
 controller
In-Reply-To: <1477039751.15560.88.camel@baylibre.com>
References: <1476890480-8884-1-git-send-email-jbrunet@baylibre.com>
 <1476890480-8884-2-git-send-email-jbrunet@baylibre.com>
 <ec297647-1ab7-7e6b-5945-be8360f92421@arm.com>
 <1477039751.15560.88.camel@baylibre.com>
Message-ID: <54f2ddee-e5ca-7c3d-7321-7390611975fd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/10/16 09:49, Jerome Brunet wrote:
> On Thu, 2016-10-20 at 17:33 +0100, Marc Zyngier wrote:
>> Jerome,
>>
>> On 19/10/16 16:21, Jerome Brunet wrote:
>>>
>>> Add support for the interrupt gpio controller found on Amlogic's
>>> meson
>>> SoC family.
>>>
>>> Unlike what the IP name suggest, it is not directly linked to the
>>> gpio
>>> subsystem. It is actually an independent IP that is able to spy on
>>> the
>>> SoC pad. For that purpose, it can mux and filter (edge or level and
>>> polarity) any single SoC pad to one of the 8 GIC's interrupts it
>>> owns.
>>>
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>> ---
>>>  drivers/irqchip/Kconfig          |   9 +
>>>  drivers/irqchip/Makefile         |   1 +
>>>  drivers/irqchip/irq-meson-gpio.c | 423
>>> +++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 433 insertions(+)
>>>  create mode 100644 drivers/irqchip/irq-meson-gpio.c
>>>
>>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>>> index 82b0b5daf3f5..168837263e80 100644
>>> --- a/drivers/irqchip/Kconfig
>>> +++ b/drivers/irqchip/Kconfig
>>> @@ -279,3 +279,12 @@ config EZNPS_GIC
>>>  config STM32_EXTI
>>>  	bool
>>>  	select IRQ_DOMAIN
>>> +
>>> +config MESON_GPIO_IRQ
>>> +       bool "Meson GPIO Interrupt Multiplexer"
>>> +       depends on ARCH_MESON || COMPILE_TEST
>>> +       select IRQ_DOMAIN
>>> +       select IRQ_DOMAIN_HIERARCHY
>>> +       help
>>> +         Support Meson SoC Family GPIO Interrupt Multiplexer
>>> +
>>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>>> index e4dbfc85abdb..33f913d037d0 100644
>>> --- a/drivers/irqchip/Makefile
>>> +++ b/drivers/irqchip/Makefile
>>> @@ -74,3 +74,4 @@ obj-$(CONFIG_LS_SCFG_MSI)		+= irq-
>>> ls-scfg-msi.o
>>>  obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
>>>  obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o
>>>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>>> +obj-$(CONFIG_MESON_GPIO_IRQ)		+= irq-meson-gpio.o
>>> diff --git a/drivers/irqchip/irq-meson-gpio.c
>>> b/drivers/irqchip/irq-meson-gpio.c
>>> new file mode 100644
>>> index 000000000000..869b4df8c483
>>> --- /dev/null
>>> +++ b/drivers/irqchip/irq-meson-gpio.c
>>> @@ -0,0 +1,423 @@
>>> +/*
>>> + * Copyright (c) 2015 Endless Mobile, Inc.
>>> + * Author: Carlo Caione <carlo@endlessm.com>
>>> + * Copyright (c) 2016 BayLibre, SAS.
>>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> modify
>>> + * it under the terms of version 2 of the GNU General Public
>>> License as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> GNU
>>> + * General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public
>>> License
>>> + * along with this program; if not, see <http://www.gnu.org/licens
>>> es/>.
>>> + * The full GNU General Public License is included in this
>>> distribution
>>> + * in the file called COPYING.
>>> + */
>>> +
>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>> +
>>> +#include <linux/io.h>
>>> +#include <linux/module.h>
>>> +#include <linux/irq.h>
>>> +#include <linux/irqdomain.h>
>>> +#include <linux/irqchip.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_address.h>
>>> +
>>> +#define IRQ_FREE (-1)
>>> +
>>> +#define REG_EDGE_POL	0x00
>>> +#define REG_PIN_03_SEL	0x04
>>> +#define REG_PIN_47_SEL	0x08
>>> +#define REG_FILTER_SEL	0x0c
>>> +
>>> +#define REG_EDGE_POL_MASK(x)	(BIT(x) | BIT(16 + (x)))
>>> +#define REG_EDGE_POL_EDGE(x)	BIT(x)
>>> +#define REG_EDGE_POL_LOW(x)	BIT(16 + (x))
>>> +#define REG_PIN_SEL_SHIFT(x)	(((x) % 4) * 8)
>>> +#define REG_FILTER_SEL_SHIFT(x)	((x) * 4)
>>> +
>>> +struct meson_gpio_irq_params {
>>> +	unsigned int nhwirq;
>>> +	irq_hw_number_t *source;
>>> +	int nsource;
>>> +};
>>> +
>>> +struct meson_gpio_irq_domain {
>>
>> The name of that structure is utterly confusing, as it doesn't
>> contain
>> anything related to an IRQ domain. Can you please clarify its usage?
> 
> This structure is holding the data of the controller. The name is
> indeed misleading, I will change this. What about
> 'meson_gpio_irq_pdata' or 'meson_gpio_irq_controller' ?
> 
>>
>>>
>>> +	void __iomem *base;
>>> +	int *map;
>>> +	const struct meson_gpio_irq_params *params;
>>> +};
>>> +
>>> +struct meson_gpio_irq_chip_data {
>>> +	void __iomem *base;
>>> +	int index;
>>> +};
>>> +
>>> +static irq_hw_number_t meson_parent_hwirqs[] = {
>>> +	64, 65, 66, 67, 68, 69, 70, 71,
>>> +};
>>
>> If that a guarantee that these numbers will always represent the
>> parent interrupt?
> 
> At the moment, the 3 supported SoC use these parent interrupts, but we
> have absolutely no idea (or guarantee) that is will remain the same, or
> even contiguous, in the upcoming SoC (like the GXM or GXL)
> 
> I reckon, it is likely that manufacturer will keep on using these
> parent irqs for a while but I would prefer not make an assumption about
> it in the driver.
> 
> If a SoC get a different set of interrupts I would have added a new
> table like this and passed it to the appropriate params :
> 
> static irq_hw_number_t meson_new_parent_hwirqs[] = {
> 	143, 144, 150, 151, 152, 173, 178, 179,
> };
> 
>> It feels a bit odd not to get that information directly from
>> the device tree, in the form of a device specific property. Something
>> like:
>>
>> 	upstream-interrupts = <64 65 66 ... >;
>>
> 
> I wondered about putting this information in DT or in the driver for a
> while. Maybe DT would be a more suitable place holder for these data
> (parent irq and number of provided hwirq) but I was under the
> understanding that we should now put these information in the driver
> and use the compatible property to get the appropriate parameters.
> 
> I'd love to get the view of the DT guys on this.
> 
> Also, since we already need to put some information about the pin the
> pinctrl driver (to get the appropriate mux value of each pad), I
> thought It would make sense to have the same approach here.
> 
> If there is some kind of policy saying this should be in DT, I'd be
> happy to make the change.
> 
>> or even as a base/range:
>>
>> 	upstream-interrupts = <64 8>;
> 
> I would prefer to avoid using ranges as we have no guarantee the
> manufacturer will keep the parent irqs contiguous in the future.
> 
>>
>> Also, how does it work if you have more than a single device like
>> this?
>> This driver seems a do a great deal of dynamic allocation, and yet
>> its
>> core resource is completely static... Please pick a side! ;-)
> 
> I don't think we could have more than one instance per device and I
> certainly did not have this case in mind while writing the code. If it
> was the case someday, I guess having two compatibles would do the trick
> :)

This has nothing to do with compatible strings. Your current approach of
defining a static list of interrupts and then dynamically allocating
things that point directly to it feels wrong. just define a second
instance of this IP to be convinced of it.

So either you support something that is fully dynamic (supporting
multiple instances at every level), or you only support *one*, and
everything becomes mostly static.

> 
>>
>>>
>>> +
>>> +static const struct meson_gpio_irq_params meson8_params = {
>>> +	.nhwirq  = 134,
>>> +	.source  = meson_parent_hwirqs,
>>> +	.nsource = ARRAY_SIZE(meson_parent_hwirqs),
>>
>> I find it utterly confusing that you are calling source something
>> that is an output for this controller. 
> 
> I had the call sequence (GIC->GPIO_IRQ->handler) in mind while writing
> it. I see your point and it is indeed confusing, I'll find something
> better

It infinitely better to describe the signal path rather than the call
stack (which is actually GIC->GPIO_IRQ->GIC->handler).

[...]


>>>
>>> +
>>> +		cd = kzalloc(sizeof(*cd), GFP_KERNEL);
>>> +		if (!cd)
>>> +			return -ENOMEM;
>>> +
>>> +		cd->base = domain_data->base;
>>> +		cd->index = index;
>>
>> So what is the exact purpose of this structure? The base address is
>> essentially a global, or could be directly derived from the domain.
>> The
>> index is only used in set_type, and is the index of the pin connected
>> to
>> the GIC. It looks to me like you could have:
>>
>> 		irq_hw_number_t *out_line =
>> &meson_parent_hwirqs[index];
> 
> meson_parent_hwirq is only declared this way to avoid writing the
> parent irqs 3 times (in each SoC params). 
> Using it this way would make it global and imply it is the same
> whatever the SoC. This something I can't guarantee and I would prefer
> to avoid that.

Well, let's face it: It is global (see my earlier rant). And if you
device to support multiple instances, you can attach the parent array at
the irq domain level, and still perform that same index calculation.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
