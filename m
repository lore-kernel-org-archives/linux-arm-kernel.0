From: zdevai@gmail.com (Zoltan Devai)
Date: Sun, 16 Oct 2011 16:10:34 +0200
Subject: [PATCH 2/9] ARM: SPMP8000: Add machine base files
In-Reply-To: <201110111644.56505.arnd@arndb.de>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-3-git-send-email-zoss@devai.org>
	<201110111644.56505.arnd@arndb.de>
Message-ID: <CAGVye5PjCZRgdmP+VCXifw_MnW1rAN41BPWfJvk9CAuXBt4ggw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/11 Arnd Bergmann <arnd@arndb.de>:
> On Sunday 09 October 2011, Zoltan Devai wrote:
>> +
>> +/* Static mappings:
>> + * SCU: timer needs clk support which is inited in init_early
>> + * UART: needed for earlyprintk
>> + */
>> +static struct map_desc io_desc[] __initdata = {
>> + ? ? {
>> + ? ? ? ? ? ? .virtual ? ? ? ?= IO_ADDRESS(SPMP8000_SCU_A_BASE),
>> + ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(SPMP8000_SCU_A_BASE),
>> + ? ? ? ? ? ? .length ? ? ? ? = SPMP8000_SCU_A_SIZE,
>> + ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
>> + ? ? }, {
>> + ? ? ? ? ? ? .virtual ? ? ? ?= IO_ADDRESS(SPMP8000_SCU_B_BASE),
>> + ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(SPMP8000_SCU_B_BASE),
>> + ? ? ? ? ? ? .length ? ? ? ? = SPMP8000_SCU_B_SIZE,
>> + ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
>> + ? ? }, {
>> + ? ? ? ? ? ? .virtual ? ? ? ?= IO_ADDRESS(SPMP8000_SCU_C_BASE),
>> + ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(SPMP8000_SCU_C_BASE),
>> + ? ? ? ? ? ? .length ? ? ? ? = SPMP8000_SCU_C_SIZE,
>> + ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
>> + ? ? },
>
> With Nicolas Pitre's rework of the MMIO space handling, I think it
> would be nice to just use a single area that spans all of the devices
> so you can do an optimized ioremap and huge TLBs. Unfortunately
> that series won't make it into 3.2, but if you just set up a large
> area now, it will automatically work.
What do you mean by 'all of the devices' ?
These three, or all MMIO peripherals ?
These are at addresses 0x90005000, 0x92005000 and 0x93007000.
So either a 50 or 256 MB area, but both seem like a waste of
virtual memory space.

>> +#ifdef CONFIG_DEBUG_LL
>> + ? ? {
>> + ? ? ? ? ? ? .virtual ? ? ? ?= IO_ADDRESS(SPMP8000_UARTC0_BASE),
>> + ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(SPMP8000_UARTC0_BASE),
>> + ? ? ? ? ? ? .length ? ? ? ? = SPMP8000_UARTC0_SIZE,
>> + ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE,
>> + ? ? },
>> +#endif
>> +};
>>
> And it would be nice to move this into a separate file that handles the
> early debug code, as prima2 does.
Prima2 doesn't have other static mappings. In my case, that would
mean a separate map_desc table in lluart.c and an
#ifdef CONFIG_DEBUG_LL in the map_io call.
Is it worth it ?

BTW, the static mappings are only needed to be able to set up the
clk stuff in init_early. That in turn is only needed for the timer code to
determinate its input clock.
If I would hard-code the timer clock rate in its driver (the bootloader is
very unlikely to change), then I could init the clk driver from
machine_init and get rid of these mappings.
How about that ?

BTW2,
shouldn't the timer driver also go to drivers/clocksource ?

>> +#ifndef __MACH_SPMP8000_DMA_H__
>> +#define __MACH_SPMP8000_DMA_H__
>> +
>> +enum spmp8000_dma_controller {
>> + ? ? SPMP8000_APBDMA_A ? ? ? = 0,
>> + ? ? SPMP8000_APBDMA_C,
>> +};
...
> Please separate the dma controller out for now into a separate patch.
> We really need to have proper device tree bindings so we can avoid the
> silly filter functions and do something better. That needs some more
> discussion and any help on the interface is very much appreciated.
OK

>> diff --git a/arch/arm/mach-spmp8000/include/mach/gpio.h b/arch/arm/mach-spmp8000/include/mach/gpio.h
>> new file mode 100644
>
>> +#ifndef __MACH_SPMP8000_GPIO_H__
>> +#define __MACH_SPMP8000_GPIO_H__
>> +
>> +#include <asm-generic/gpio.h>
>> +
>> +#define gpio_get_value ? ? ? ? ? ? ? __gpio_get_value
>> +#define gpio_set_value ? ? ? ? ? ? ? __gpio_set_value
>> +#define gpio_cansleep ? ? ? ? ? ? ? ?__gpio_cansleep
>> +#define gpio_to_irq ? ? ? ? ?__gpio_to_irq
>> +
>> +#endif /* __MACH_SPMP8000_GPIO_H__ */
>
> I think this can become an empty file now, with Russell's latest cleanup
> going into 3.2.
I didn't find that in either your or Russell's tree, where should I look
for it ?

>> +/* Vitual to physical translation of statically mapped space */
>> +#define IO_ADDRESS(x) ? ? ? ? ? ? ? ?((x) | 0xF0000000)
>
> Better make this return a 'void __iomem *', e.g. by doing
>
> #define IO_ADDRESS(x) ? (((x) & 0x0fffffff) + ((void __iomem *)0xf0000000)
This is used by map_desc, so it needs to return an int.
I use IO_PTR for the pointer version, but maybe the naming is misleading.

>> +/* Needed for the static mappings and uncompress.h */
>> +#define SPMP8000_UARTC0_BASE 0x92B04000
>> +#define SPMP8000_UARTC0_SIZE SZ_4K
>> +#define SPMP8000_SCU_C_BASE ?0x92005000
>> +#define SPMP8000_SCU_C_SIZE ?SZ_4K
>> +#define SPMP8000_SCU_A_BASE ?0x93007000
>> +#define SPMP8000_SCU_A_SIZE ?SZ_4K
>> +#define SPMP8000_SCU_B_BASE ?0x90005000
>> +#define SPMP8000_SCU_B_SIZE ?SZ_4K
>
> Do you need these all so early that you cannot get the location from the device
> tree?
See the reason above

>> +/* FIXME This should go away */
>> +#define IO_SPACE_LIMIT ?0
>> +
>> +#define __mem_pci(a) ? ?(a)
>> +#define __io(a) ? ? ? ? __typesafe_io(a)
>> +
>
> I think you should better define __io() to NULL.
OK

>> +++ b/arch/arm/mach-spmp8000/include/mach/regs-timer.h
>> @@ -0,0 +1,32 @@
>> +/*
>> + * SPMP8000 timer support
>> + *
>> + * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + *
>> + * These timer reg definitions are used by the timer and pwm drivers
>> + */
>> +#ifndef __MACH_SPMP8000_REGS_TIMER_H__
>> +#define __MACH_SPMP8000_REGS_TIMER_H__
>> +
>> +#define SPMP8000_TMRB(tnum) ?(tnum * 0x20)
>> +#define SPMP8000_TMRB_CTR ? ?0x00
>> +#define SPMP8000_TMRB_CTR_TE BIT(0)
>> +#define SPMP8000_TMRB_CTR_IE BIT(1)
>> +#define SPMP8000_TMRB_CTR_OE BIT(2)
>> +#define SPMP8000_TMRB_CTR_PWMON ? ? ?BIT(3)
>> +#define SPMP8000_TMRB_CTR_UD BIT(4)
>> +#define SPMP8000_TMRB_CTR_UDS ? ? ? ?BIT(5)
>> +#define SPMP8000_TMRB_CTR_OM BIT(6)
>> +#define SPMP8000_TMRB_CTR_ES_SH ? ? ?8
>> +#define SPMP8000_TMRB_CTR_M_SH ? ? ? 10
>> +#define SPMP8000_TMRB_PSR ? ?0x04
>> +#define SPMP8000_TMRB_LDR ? ?0x08
>> +#define SPMP8000_TMRB_VLR ? ?0x08
>> +#define SPMP8000_TMRB_ISR ? ?0x0C
>> +#define SPMP8000_TMRB_CMP ? ?0x10
>> +
>> +#endif /* __MACH_SPMP8000_REGS_TIMER_H__ */
>
> No need for this header, just move the definitions into the timer driver.
It's also used by the pwm driver (pwm is just a timer with a HW output pin)
as the header indicates. Not a lots of lines, so I can include it in both
if you think that's more appropriate.

>> diff --git a/arch/arm/mach-spmp8000/include/mach/scu.h b/arch/arm/mach-spmp8000/include/mach/scu.h
>> new file mode 100644
>> index 0000000..e3a98d4
>> --- /dev/null
>> +++ b/arch/arm/mach-spmp8000/include/mach/scu.h
>> @@ -0,0 +1,146 @@
>> +/*
>> + * SPMP8000 System Control Unit register definitions
>> + * SCUs are a random collection of reset, clock, gpio, pinmux, etc. controllers
>> + * so that these definitions are needed at several places.
>
>> +struct scu_reg_t {
>> + ? ? void *base;
>> + ? ? void *clken;
>> +};
>> +
>> +extern struct scu_reg_t scu_regs[];
>> +
>> +#define REG_SCU_BASE(x) ? ? ? ? ? ? ?scu_regs[x].base
>> +#define REG_SCU_CLKEN(x) ? ? scu_regs[x].clken
>> +#define REG_SCU_A_ID ? ? ? ? 0
>> +#define REG_SCU_B_ID ? ? ? ? 1
>> +#define REG_SCU_C_ID ? ? ? ? 2
>> +#define REG_SCU_A(x) ? ? ? ? (scu_regs[REG_SCU_A_ID].base + x)
>> +#define REG_SCU_B(x) ? ? ? ? (scu_regs[REG_SCU_B_ID].base + x)
>> +#define REG_SCU_C(x) ? ? ? ? (scu_regs[REG_SCU_C_ID].base + x)
>
> I would prefer having ?this in core.c, so the base addresses can
> remain private to that file instead of exporting them to
> all of the kernel.
I'll get rid of these macros altogether, they're not really nice.

>> +#define SCU_A_PERI_RST ? ? ? ? ? ? ? 0x00
>> +#define SCU_A_PERI_CLKEN ? ? 0x04
>> +#define SCU_A_PERI_DGCLKEN ? 0x0C
>> +
>> +#define SCU_A_APLL_CFG ? ? ? ? ? ? ? 0x44
>> +#define APLL_CFG_P ? ? ? ? ? BIT(0)
>> +#define APLL_CFG_S ? ? ? ? ? BIT(1)
>> +#define APLL_CFG_F ? ? ? ? ? BIT(2)
>> +#define APLL_CFG_E ? ? ? ? ? BIT(3)
>
> The BIT() definition is really just mean for kernel-internal bitops,
> not so much for device registers.
>
> My recommended style of this is
>
> #define APLL_CFG_P ? ? ? ? ? ? ?0x00000001
> #define APLL_CFG_S ? ? ? ? ? ? ?0x00000002
> #define APLL_CFG_F ? ? ? ? ? ? ?0x00000004
> #define APLL_CFG_E ? ? ? ? ? ? ?0x00000008
Are you sure about this ?
I recall reading a recommendation to use BIT() as its less
error-prone, easier matched with the datasheet and properly typed.
Also:
kernel$ grep -R " BIT(" drivers/ | wc -l
2186

>> diff --git a/arch/arm/mach-spmp8000/include/mach/system.h b/arch/arm/mach-spmp8000/include/mach/system.h
>> new file mode 100644
>> index 0000000..be53ff3
>> --- /dev/null
>> +++ b/arch/arm/mach-spmp8000/include/mach/system.h
>> @@ -0,0 +1,45 @@
>> +/*
>> + * SPMP8000 system.h
>> + *
>> + * Copyright (C) 2011 Zoltan Devai <zoss@devai.org>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#ifndef __MACH_SPMP8000_SYSTEM_H__
>> +#define __MACH_SPMP8000_SYSTEM_H__
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/io.h>
>> +
>> +#define SPMP8000_WDT_BASE ? ?0x90001000
>> +#define SPMP8000_WDT_SIZE ? ?0x1000
>
> These have to be removed. For device drivers, you should normally
> use of_iomap to get at the registers.
>
>> +#define SPMP8000_WDT_CTR ? ? 0x00
>> +#define SPMP8000_WDT_CTR_TE ?BIT(0)
>> +#define SPMP8000_WDT_CTR_RE ?BIT(3)
>> +
>> +static inline void arch_idle(void)
>> +{
>> + ? ? cpu_do_idle();
>> +}
>> +
>> +static inline void arch_reset(char mode, const char *cmd)
>> +{
>> + ? ? void *base;
>> +
>> + ? ? base = ioremap(SPMP8000_WDT_BASE, SPMP8000_WDT_SIZE);
>> + ? ? if (!base) {
>> + ? ? ? ? ? ? pr_err("spmp8000: Can't ioremap watchdog regs for reset. "
>> + ? ? ? ? ? ? ? ? ? ? "Halt.");
>> + ? ? ? ? ? ? while (1);
>> + ? ? }
>> +
>> + ? ? /* Trigger a watchdog reset */
>> + ? ? writel(SPMP8000_WDT_CTR_RE | SPMP8000_WDT_CTR_TE,
>> + ? ? ? ? ? ? ? ? ? ? base + SPMP8000_WDT_CTR);
>> +}
>
> Using the watchdog for arch_reset is clever, but unfortunately not
> too common otherwise, so you have to play tricks. I would try
> locating the device and ioremapping it from core.c and then
> export a function to set the register that is used both by
> the arch_reset function and by the watchdog driver. The latter
> can still bind to the platform_device, but it then doesn't have
> to do an extra of_iomap.
OK
