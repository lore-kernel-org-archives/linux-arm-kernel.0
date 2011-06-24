From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 24 Jun 2011 10:28:34 +0800
Subject: [PATCH] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <20110621162228.GI23234@n2100.arm.linux.org.uk>
References: <1308556402-10955-1-git-send-email-bs14@csr.com>
	<20110621162228.GI23234@n2100.arm.linux.org.uk>
Message-ID: <BANLkTimDAjHFbkGQB0w1LSMJjMXGVr+81A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/22 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> Some comments inline, nothing really serious...
>
> On Mon, Jun 20, 2011 at 12:53:22AM -0700, Barry Song wrote:
>> +config ARCH_PRIMA2
>> + ? ? bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
>> + ? ? select CPU_V7
>> + ? ? select GENERIC_TIME
>> + ? ? select GENERIC_CLOCKEVENTS
>> + ? ? select CLKDEV_LOOKUP
>> + ? ? select USE_OF
>> + ? ? select ISA_DMA_API
>
> Do you really provide the old ISA DMA API? ?Unless you're intending to use
> existing ISA drivers with their ISA DMA, you shouldn't define this.
>
>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> index f5b2b39..79e6edf 100644
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -191,6 +191,7 @@ machine-$(CONFIG_ARCH_VEXPRESS) ? ? ? ? ? := vexpress
>> ?machine-$(CONFIG_ARCH_VT8500) ? ? ? ? ? ? ? ?:= vt8500
>> ?machine-$(CONFIG_ARCH_W90X900) ? ? ? ? ? ? ? := w90x900
>> ?machine-$(CONFIG_ARCH_NUC93X) ? ? ? ? ? ? ? ?:= nuc93x
>> +machine-$(CONFIG_ARCH_PRIMA2) ? ? ? ? ? ? ? ?:= prima2
>
> The comment at the start of this list says:
>
> # Machine directory name. ?This list is sorted alphanumerically
> # by CONFIG_* macro name.
>
> and I thank the NUC93x people for also missing it. ?Please ignore the
> NUC93x entry and place yours appropriately.
>
>> diff --git a/arch/arm/boot/dts/prima2-cb.dts b/arch/arm/boot/dts/prima2-cb.dts
>> new file mode 100644
>> index 0000000..6e8b17c
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/prima2-cb.dts
>> @@ -0,0 +1,44 @@
>> +/dts-v1/;
>> +/ {
>> + ? ? ? ?model = "SIRF Prima2 EVB";
>> + ? ? ? ?compatible = "sirf,prima2-cb", "sirf,prima2";
>> + ? ? #address-cells = <1>;
>> + ? ? #size-cells = <1>;
>> + ? ? interrupt-parent = <&intc>;
>> +
>> + ? ? ? ?memory {
>> + ? ? ? ? ? ? ? ?reg = <0x00000000 0x20000000>;
>> + ? ? ? ?};
>> +
>> + ? ? chosen {
>> + ? ? ? ? ? ? bootargs = "mem=512M real_root=/dev/mmcblk0p2 console=ttyS1 earlyprintk";
>> + ? ? ? ? ? ? linux,stdout-path = &uart1;
>> + ? ? };
>> +
>> + ? ? amba {
>
> You declare that you have an AMBA bus, does it have primcells on it?
> Should you be selecting ARM_AMBA in your kconfig?

Russell,
the chip has no primecells on it. And it seems we don't need ARM_AMBA.
PrimaII uses AXI protocol, but has no AMBA IP controller. and many IP
are self-defined.  Nothing in the chip really has AMBA periph id.
its layout is like
AXI(0-0x3FFFFFFF)
             memory
AXI(0x40000000-0xC0000000)
             CPUIF(sirf-iobus)
                          INTC
                          MEMC
                          LCD
                          VPP
                          GRAPHIC
                          MULTIMEDIA
                          GPS
                          UART
                          ...
                          hard-coded PCI bridge
                                  SD/MMC
                          rtc-iobrg
                                  RTC

>
>> diff --git a/arch/arm/mach-prima2/include/mach/entry-macro.S b/arch/arm/mach-prima2/include/mach/entry-macro.S
>> new file mode 100644
>> index 0000000..af5611b
>> --- /dev/null
>> +++ b/arch/arm/mach-prima2/include/mach/entry-macro.S
>> @@ -0,0 +1,28 @@
>> +/*
>> + * arch/arm/mach-prima2/include/mach/entry-macro.S
>> + *
>> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#include <mach/hardware.h>
>> +
>> +#define SIRFSOC_INT_ID 0x38
>> +
>> + ? ? .macro ?get_irqnr_and_base, irqnr, irqstat, base, tmp
>> + ? ? ? ?ldr \base, =SIRFSOC_INTR_VA_BASE
>
> Consider using get_irqnr_preamble to load the base address only once per
> IRQ exception.
>
>> diff --git a/arch/arm/mach-prima2/include/mach/isa-dma.h b/arch/arm/mach-prima2/include/mach/isa-dma.h
>> new file mode 100644
>> index 0000000..f07e264
>> --- /dev/null
>> +++ b/arch/arm/mach-prima2/include/mach/isa-dma.h
>> @@ -0,0 +1,14 @@
>> +/*
>> + * arch/arm/mach-prima2/include/mach/io.h
>> + *
>> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#ifndef __MACH_PRIMA2_ISADMA_H
>> +#define __MACH_PRIMA2_ISADMA_H
>> +
>> +#define MAX_DMA_CHANNELS 32
>> +
>> +#endif
>
> You don't need this if you don't define ISA_DMA_API.
>
>> diff --git a/arch/arm/mach-prima2/include/mach/uncompress.h b/arch/arm/mach-prima2/include/mach/uncompress.h
>> new file mode 100644
>> index 0000000..e08d7b8
>> --- /dev/null
>> +++ b/arch/arm/mach-prima2/include/mach/uncompress.h
>> @@ -0,0 +1,42 @@
>> +/*
>> + * arch/arm/mach-prima2/include/mach/uncompress.h
>> + *
>> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#ifndef __ASM_ARCH_UNCOMPRESS_H
>> +#define __ASM_ARCH_UNCOMPRESS_H
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/io.h>
>> +#include <asm/processor.h>
>> +#include <mach/hardware.h>
>> +#include <mach/uart.h>
>
> If you include all that, then you're in for problems with the decompressor.
> The decompressor is a _really_ limited environment, and most stuff from
> linux/ or platfform stuff will not be available.
>
>> diff --git a/arch/arm/mach-prima2/irq.c b/arch/arm/mach-prima2/irq.c
>> new file mode 100644
>> index 0000000..af65481
>> --- /dev/null
>> +++ b/arch/arm/mach-prima2/irq.c
>> @@ -0,0 +1,81 @@
> ...
>> +#define SIRFSOC_INT_PENDING0 ? ? ? ? ? ?0x0000
>> +#define SIRFSOC_INT_PENDING1 ? ? ? ? ? ?0x0004
>> +#define SIRFSOC_INT_IRQ_PENDING0 ? ? ? ?0x0008
>> +#define SIRFSOC_INT_IRQ_PENDING1 ? ? ? ?0x000C
>> +#define SIRFSOC_INT_FIQ_PENDING0 ? ? ? ?0x0010
>> +#define SIRFSOC_INT_FIQ_PENDING1 ? ? ? ?0x0014
>> +#define SIRFSOC_INT_RISC_MASK0 ? ? ? ? ?0x0018
>> +#define SIRFSOC_INT_RISC_MASK1 ? ? ? ? ?0x001C
>> +#define SIRFSOC_INT_RISC_LEVEL0 ? ? ? ? 0x0020
>> +#define SIRFSOC_INT_RISC_LEVEL1 ? ? ? ? 0x0024
>> +
>> +static void sirfsoc_irq_ack(struct irq_data *d)
>> +{
>> +}
>> +
>> +static void sirfsoc_irq_mask(struct irq_data *d)
>> +{
>> + ? ? unsigned long mask;
>> +
>> + ? ? mask = __raw_readl(SIRFSOC_INTR_VA_BASE + SIRFSOC_INT_RISC_MASK0 + (d->irq / 32) * 4) &
>> + ? ? ? ? ? ? ~(1 << ( d->irq % 32));
>> + ? ? __raw_writel(mask, SIRFSOC_INTR_VA_BASE + SIRFSOC_INT_RISC_MASK0 + (d->irq / 32) * 4);
>> +}
>> +
>> +static void sirfsoc_irq_unmask(struct irq_data *d)
>> +{
>> + ? ? unsigned long mask;
>> +
>> + ? ? mask = __raw_readl(SIRFSOC_INTR_VA_BASE + SIRFSOC_INT_RISC_MASK0 + (d->irq / 32) * 4) |
>> + ? ? ? ? ? ? (1 << ( d->irq % 32));
>> + ? ? __raw_writel(mask, SIRFSOC_INTR_VA_BASE + SIRFSOC_INT_RISC_MASK0 + (d->irq / 32) * 4);
>> +}
>> +
>> +int sirfsoc_irq_settype(struct irq_data *d, unsigned int type)
>> +{
>> + ? ? /*
>> + ? ? ?* Interrupt handler doesnt support setting trigger type
>> + ? ? ?*/
>> + ? ? if (type == IRQ_TYPE_NONE)
>> + ? ? ? ? ? ? return 0;
>> +
>> + ? ? return -EINVAL;
>> +}
>> +
>> +static struct irq_chip sirfsoc_irq_chip = {
>> + ? ? .name = "SiRF SoC",
>> + ? ? .irq_ack = sirfsoc_irq_ack,
>> + ? ? .irq_mask = sirfsoc_irq_mask,
>> + ? ? .irq_unmask = sirfsoc_irq_unmask,
>> + ? ? .irq_set_type = sirfsoc_irq_settype,
>> +};
>
> Can you use the recently introduced generic irqchips stuff for this?
>
>> diff --git a/arch/arm/mach-prima2/timer.c b/arch/arm/mach-prima2/timer.c
>> new file mode 100644
>> index 0000000..f73928f
>> --- /dev/null
>> +++ b/arch/arm/mach-prima2/timer.c
>> @@ -0,0 +1,181 @@
> ...
>> +/* initialize the kernel jiffy timer source */
>> +static void __init sirfsoc_timer_init(void)
>> +{
>> + ? ? unsigned long rate;
>> + ? ? /* timer's input clock is io clock */
>> + ? ? struct clk *clk = clk_get(NULL, "io");
>
> Rather than going down this broken path of specifying clock names as
> connection IDs, it would be better to obtain it by function:
> ? ? ? ?struct clk *clk = clk_get_sys("timer", NULL);
>
> Experience shows that people think that naming the clock signals themselves
> and passing strings around to drivers is easier. ?After a few years they
> find that what they thought was easy, is actually inflexible and has
> become a huge problem which they need to rework. ?(Samsung folk are
> currently going through this pain.)
>
> So please, don't fall into the trap of "lets give each clock signal a name
> and look up only by clock name". ?Use the device names as the primary
> matching and don't allow yourself to get into the trap of passing clock
> names around.
>
>> +
>> + ? ? BUG_ON(IS_ERR_OR_NULL(clk));
>
> ? ? ? ?BUG_ON(IS_ERR(clk));
>
> If clk_get() may return NULL, then clk_get_rate() should be able to eat
> that value without choking.
>
>> +
>> + ? ? rate = clk_get_rate(clk);
>> + ? ? clk_put(clk);
>
> It's much preferable not to clk_put() a clock which you're going to
> continue using.
>
>> +
>> + ? ? BUG_ON(rate < CLOCK_TICK_RATE);
>> + ? ? BUG_ON(rate % CLOCK_TICK_RATE);
>> +
>> + ? ? __raw_writel(rate / CLOCK_TICK_RATE / 2 - 1, SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_DIV);
>> + ? ? __raw_writel(0, SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_COUNTER_LO);
>> + ? ? __raw_writel(0, SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_COUNTER_HI);
>> + ? ? __raw_writel(BIT(0), SIRFSOC_TIMER_VA_BASE + SIRFSOC_TIMER_STATUS);
>> +
>> + ? ? if (clocksource_register_hz(&sirfsoc_clocksource, CLOCK_TICK_RATE))
>> + ? ? ? ? ? ? BUG();
>
> Confused. ?CLOCK_TICK_RATE is defined to be 100 * HZ, so 10kHz. ?Do
> your timers really tick at 10kHz? ?That seems needlessly slow for a
> 64-bit counter. ?Also consider BUG_ON()
>
>> +
>> + ? ? if (setup_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq))
>> + ? ? ? ? ? ? BUG();
>
> BUG_ON() here too.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
