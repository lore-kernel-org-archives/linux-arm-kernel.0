From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 4 Jul 2011 10:55:55 +0800
Subject: [PATCH v2] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <201107011819.43316.arnd@arndb.de>
References: <1309231954-23260-1-git-send-email-bs14@csr.com>
	<201106301236.25822.arnd@arndb.de>
	<BANLkTikoMu3ccUxj5KRmKzdReQcBqK4Y9Q@mail.gmail.com>
	<201107011819.43316.arnd@arndb.de>
Message-ID: <CAGsJ_4yHrYRQKO7tMeJhjj_aEhV69xnJSZzuHhq8hnBrmnG+dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/2 Arnd Bergmann <arnd@arndb.de>:
> On Friday 01 July 2011, Barry Song wrote:
>> It looks like we can new a common function named as of_io_earlymap()
>> or something in drivers/of/address.c. of_iomap() does ioremap,
>> of_io_earlymap() does early static mapping?
>> Then all SoCs can call this function to do early static mapping. if
>> so, some lines can be deleted in sirfsoc_of_clk_init(). How do you
>> think about newing the function in drivers/of/address.c?
>
> I think that's a good idea, but the ARM specific implementation cannot
> be in common code. Other architectures have stuff similar to iotable_init
> in asm/fixmap.h. If we decide on a function prototype for this, the
> implementation can be arch/*/.
>
> How about this:
>
> extern void of_set_fixmap(struct device_node *np, int index,
> ? ? ? ?unsigned long of_fixmap_offset, pgprot_t flags);
>
>> For DEBUG_LL uart, i have moved the static mapping to a new file named
>> lluart.c too:
>> +#include <linux/kernel.h>
>> +#include <asm/page.h>
>> +#include <asm/mach/map.h>
>> +#include <mach/map.h>
>> +#include <mach/uart.h>
>> +
>> +void __init sirfsoc_map_lluart(void)
>> +{
>> + ? ? ? struct map_desc sirfsoc_lluart_map = {
>> + ? ? ? ? ? ? ? .virtual ? ? ? ?= SIRFSOC_UART1_VA_BASE,
>> + ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(SIRFSOC_UART1_PA_BASE),
>> + ? ? ? ? ? ? ? .length ? ? ? ? = SIRFSOC_UART1_SIZE,
>> + ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
>> + ? ? ? };
>> +
>> + ? ? ? iotable_init(&sirfsoc_lluart_map, 1);
>> +}
>> +
>>
>> only when DEBUG_LL is selected, this file will be compiled. Otherwise,
>> an empty sirfsoc_map_lluart is used:
>
> Ok, sounds good.
>
>> +/* TODO:
>> + * add APIs to control reset of every module
>> + */
>
> Hmm, how about this: You enumerate every bit in the reset registers, and
> then add a device tree property to the devices where this is needed containing
> the number. Then you just need a simple interface like
>
> void sirfsoc_reset_device(struct device *dev)
> {
> ? ? ? ?int len, i;
> ? ? ? ?unsigned int *reset_bits = of_get_property(dev->of_node, "reset-bit", &len);
>
> ? ? ? ?for (i = 0; i<len/4; i++)
> ? ? ? ? ? ? ? ?sirfsoc_reset_line(reset_bits[i]);
> }

Great idea. in fact there is only one reset bit for every device. So
maybe the rstc.c can be:
/*
 * reset controller for CSR SiRFprimaII
 *
 * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
 *
 * Licensed under GPLv2 or later.
 */

#include <linux/kernel.h>
#include <linux/mutex.h>
#include <linux/io.h>
#include <linux/delay.h>
#include <linux/device.h>
#include <linux/of.h>
#include <linux/of_address.h>

void __iomem *sirfsoc_rstc_base;
static DEFINE_MUTEX(rstc_lock);

static struct of_device_id rstc_ids[]  = {
	{ .compatible = "sirf,rstc" },
};

static int __init sirfsoc_of_rstc_init(void)
{
	struct device_node *np;

	np = of_find_matching_node(NULL, rstc_ids);
	if (!np)
		panic("unable to find compatible rstc node in dtb\n");

	sirfsoc_rstc_base = of_iomap(np, 0);
	if (!sirfsoc_rstc_base)
		panic("unable to map rstc cpu registers\n");

	of_node_put(np);

	return 0;
}
early_initcall(sirfsoc_of_rstc_init);

int sirfsoc_reset_device(struct device *dev)
{
	const unsigned int *prop = of_get_property(dev->of_node, "reset-bit", NULL);
	unsigned int reset_bit;

	if (!prop)
		return -ENODEV;

	reset_bit = be32_to_cpup(prop);

	mutex_lock(&rstc_lock);

	/*
	 * Writing 1 to this bit resets corresponding block.
	 * Writing 0 to this bit de-asserts reset signal of
	 * the corresponding block.
	 */
	writel(sirfsoc_rstc_base + (reset_bit / 32) * 4,
		readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) | reset_bit);
	msleep(10);
	writel(sirfsoc_rstc_base + (reset_bit / 32) * 4,
		readl(sirfsoc_rstc_base + (reset_bit / 32) * 4) & ~reset_bit);

	mutex_unlock(&rstc_lock);

	return 0;
}
>
>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <asm/mach-types.h>
>> +#include <asm/mach/arch.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include "common.h"
>> +
>> +static struct of_device_id sirfsoc_of_bus_ids[] __initdata = {
>> + ? ? ? { .compatible = "simple-bus", },
>> + ? ? ? {},
>> +};
>> +
>> +void __init sirfsoc_mach_init(void)
>> +{
>> + ? ? ? of_platform_bus_probe(NULL, sirfsoc_of_bus_ids, NULL);
>> +}
>> +
>> +static const char *prima2cb_dt_match[] __initdata = {
>> + ? ? ? "sirf,prima2-cb",
>> + ? ? ? NULL
>> +};
>> +
>> +MACHINE_START(PRIMA2_EVB, "prima2cb")
>> + ? ? ? .boot_params ? ?= 0x00000100,
>> + ? ? ? .init_early ? ? = sirfsoc_of_clk_init,
>> + ? ? ? .map_io ? ? ? ? = sirfsoc_map_lluart,
>> + ? ? ? .init_irq ? ? ? = sirfsoc_of_irq_init,
>> + ? ? ? .timer ? ? ? ? ?= &sirfsoc_timer,
>> + ? ? ? .init_machine ? = sirfsoc_mach_init,
>> + ? ? ? .dt_compat ? ? ?= prima2cb_dt_match,
>> +MACHINE_END
>
> Very nice!
>
> ? ? ? ?Arnd
