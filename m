From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 16 Jun 2017 11:28:37 +0100
Subject: [PATCH v3 2/6] irqchip: meson: add support for gpio interrupt
 controller
In-Reply-To: <1497607375.3086.40.camel@baylibre.com>
References: <20170615161804.32658-1-jbrunet@baylibre.com>
 <20170615161804.32658-3-jbrunet@baylibre.com>
 <d37dae42-77df-72b7-0898-a4873ccbbcce@arm.com>
 <1497607375.3086.40.camel@baylibre.com>
Message-ID: <b9b1508c-7a1d-6c72-de9b-4e853a495f64@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/06/17 11:02, Jerome Brunet wrote:
> On Fri, 2017-06-16 at 10:35 +0100, Marc Zyngier wrote:
>> + Heiner.
>>
>> On 15/06/17 17:18, Jerome Brunet wrote:
>>> Add support for the interrupt gpio controller found on Amlogic's meson
>>> SoC family.
>>>
>>> Unlike what the IP name suggest, it is not directly linked to the gpio
>>> subsystem. This separate controller is able to spy on the SoC pad. It is
>>> essentially a 256 to 8 router with a filtering block to select level or
>>> edge and polarity. The number of actual mappable inputs depends on the
>>> SoC.
>>>
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>> ---
>>>  drivers/irqchip/Kconfig          |   8 +
>>>  drivers/irqchip/Makefile         |   1 +
>>>  drivers/irqchip/irq-meson-gpio.c | 407
>>> +++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 416 insertions(+)
>>>  create mode 100644 drivers/irqchip/irq-meson-gpio.c
>>>
>>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>>> index 478f8ace2664..be577a7512cc 100644
>>> --- a/drivers/irqchip/Kconfig
>>> +++ b/drivers/irqchip/Kconfig
>>> @@ -301,3 +301,11 @@ config QCOM_IRQ_COMBINER
>>>  	help
>>>  	  Say yes here to add support for the IRQ combiner devices embedded
>>>  	  in Qualcomm Technologies chips.
>>> +
>>> +config MESON_IRQ_GPIO
>>> +       bool "Meson GPIO Interrupt Multiplexer"
>>> +       depends on ARCH_MESON || COMPILE_TEST
>>> +       select IRQ_DOMAIN
>>> +       select IRQ_DOMAIN_HIERARCHY
>>> +       help
>>> +         Support Meson SoC Family GPIO Interrupt Multiplexer
>>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>>> index b64c59b838a0..95bf2715850e 100644
>>> --- a/drivers/irqchip/Makefile
>>> +++ b/drivers/irqchip/Makefile
>>> @@ -76,3 +76,4 @@ obj-$(CONFIG_EZNPS_GIC)			+= irq-
>>> eznps.o
>>>  obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o
>>>  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
>>>  obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
>>> +obj-$(CONFIG_MESON_IRQ_GPIO)		+= irq-meson-gpio.o
>>> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-
>>> gpio.c
>>> new file mode 100644
>>> index 000000000000..3b6d0ffec357
>>> --- /dev/null
>>> +++ b/drivers/irqchip/irq-meson-gpio.c
>>> @@ -0,0 +1,407 @@
>>> +/*
>>> + * Copyright (c) 2015 Endless Mobile, Inc.
>>> + * Author: Carlo Caione <carlo@endlessm.com>
>>> + * Copyright (c) 2016 BayLibre, SAS.
>>> + * Author: Jerome Brunet <jbrunet@baylibre.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of version 2 of the GNU General Public License as
>>> + * published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful, but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> + * General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>>> + * The full GNU General Public License is included in this distribution
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
>>> +#define NUM_UPSTREAM_IRQ 8
>>> +#define MAX_INPUT_MUX 256
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
>>> +	unsigned int nr_hwirq;
>>> +};
>>> +
>>> +static const struct meson_gpio_irq_params meson8b_params = {
>>> +	.nr_hwirq = 119,
>>> +};
>>> +
>>> +static const struct meson_gpio_irq_params gxbb_params = {
>>> +	.nr_hwirq = 133,
>>> +};
>>> +
>>> +static const struct meson_gpio_irq_params gxl_params = {
>>> +	.nr_hwirq = 110,
>>> +};
>>> +
>>> +static const struct of_device_id meson_irq_gpio_matches[] = {
>>> +	{ .compatible = "amlogic,meson8b-gpio-intc", .data =
>>> &meson8b_params },
>>> +	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data =
>>> &gxbb_params },
>>> +	{ .compatible = "amlogic,meson-gxl-gpio-intc", .data = &gxl_params
>>> },
>>> +	{ }
>>> +};
>>> +
>>> +struct meson_gpio_irq_controller {
>>> +	unsigned int nr_hwirq;
>>> +	void __iomem *base;
>>> +	u32 upstream_irq[NUM_UPSTREAM_IRQ];
>>> +	DECLARE_BITMAP(map, NUM_UPSTREAM_IRQ);
>>
>> upstream_irq doesn't mean much. You use "channel" elsewhere, which makes
>> a bit more sense (and map could become channel_map).
>>
>> This NUM_UPSTREAM_IRQ could potentially become a SoC-specific parameter
>> (I wouldn't be surprised if a new SoC would have more of these).
> 
> I kind of hesitated on this.
> 
> The way the channel settings are entangled in the registers (2 reg for channel
> select, 1 for filtering) make it unlikely to change this way, at least no w/o
> some other change that would require some other adaptation.
> 
> Also, there this comment in "include/linux/bitmap.h" :
> 
>  * Note that nbits should be always a compile time evaluable constant.
>  * Otherwise many inlines will generate horrible code.

It is actually not that bad (at least on arm64, I checked a while ago),
and you're not using this on any fast path.

> 
> Finally there was your advice from the v2 to not make the driver unnecessarily
> complicated.
> 
> I figured that if we ever get chip with a different number of irq, no to
> different so that it can reasonably fit in this driver, the rework would not be
> that complicated. 
> 
> Would you agree ?

Fine by me.

>>
>>> +	spinlock_t lock;
>>> +};
>>> +
>>> +static void meson_gpio_irq_update_bits(struct meson_gpio_irq_controller
>>> *ctl,
>>> +				       unsigned int reg, u32 mask, u32 val)
>>> +{
>>> +	u32 tmp;
>>> +
>>> +	tmp = readl_relaxed(ctl->base + reg);
>>> +	tmp &= ~mask;
>>> +	tmp |= val;
>>> +	writel_relaxed(tmp, ctl->base + reg);
>>> +}
>>> +
>>> +static int
>>> +meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
>>> +			       unsigned long  hwirq,
>>> +			       u32 **parent_hwirq)
>>> +{
>>> +	unsigned int reg, channel;
>>> +	unsigned long flags;
>>> +
>>> +	spin_lock_irqsave(&ctl->lock, flags);
>>
>> You don't seem to take this spinlock in interrupt context. In that case,
>> you don't need to use the _irqsave version. Same thing for the set_type
>> callback.
>>
> 
> Ok. I also hesitated with the raw_spinlock version, which is used in several
> other irqchip. I could not really understand when one should be used over the
> other. Seems to be linked to the RT patch as far as I understood.
> 
> Is this version the one I should use ?

You should use the raw version if you're taking this in an interrupt
context where you really cannot sleep (since RT spinlocks become
sleepable). In your case, you're always in a context where you it
doesn't really matter. So the normal spinlock should the the trick.

>>> +
>>> +	/* Find a free channel */
>>> +	channel = find_first_zero_bit(ctl->map, NUM_UPSTREAM_IRQ);
>>> +	if (channel >= NUM_UPSTREAM_IRQ) {
>>> +		spin_unlock_irqrestore(&ctl->lock, flags);
>>> +		pr_err("No channel available\n");
>>> +		return -ENOSPC;
>>> +	}
>>> +
>>> +	/* Mark the channel as used */
>>> +	set_bit(channel, ctl->map);
>>> +
>>> +	/*
>>> +	 * Setup the mux of the channel to route the signal of the pad
>>> +	 * to the appropriate input of the GIC
>>> +	 */
>>> +	reg = (channel < 4) ? REG_PIN_03_SEL : REG_PIN_47_SEL;
>>
>> Make a helper for this (channel_to_reg?).
> 
> Ok. why not.
> 
>>
>>> +	meson_gpio_irq_update_bits(ctl, reg,
>>> +				   0xff << REG_PIN_SEL_SHIFT(channel),
>>> +				   hwirq << REG_PIN_SEL_SHIFT(channel));
>>> +
>>> +	/* Get the parent hwirq number assigned to this channel */
>>> +	*parent_hwirq = &(ctl->upstream_irq[channel]);
>>
>> A comment explaining how this simplifies the channel number computation
>> at runtime would be great, it took me a moment to understand how this works.
> 
> Indeed, it took me a while to get back into it as well.
> To be fair, it was your idea initially :P

Meh. I've grown a lot of white hair since then...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
