From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 30 Jun 2011 15:19:17 +0800
Subject: [PATCH v2] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <201106292329.44447.arnd@arndb.de>
References: <1309231954-23260-1-git-send-email-bs14@csr.com>
	<201106292329.44447.arnd@arndb.de>
Message-ID: <BANLkTinfKCMcutMDQ+mpdD4EUy9mCpZs+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
Thanks.

2011/6/30 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 28 June 2011, Barry Song wrote:
>> This patch adds the basic support for this SoC and EVB board based on device
>> tree. It is following the ZYNQ of Grant Likely in some degree.
>
> Hi Barry,
>
> There are a few more things I noticed this time around, and some comments
> about code that changed since v1.
>
>> the device hierarchy in SiRFprimaII is as below
>>
>> AXI(0-0x3FFFFFFF)
>> ? ? ? ? ? ? memory
>> AXI(0x40000000-0xC0000000)
>> ? ? ? ? ? ? CPUIF(sirf-iobus)
>> ? ? ? ? ? ? ? ? ? ? ? ? ?INTC
>> ? ? ? ? ? ? ? ? ? ? ? ? ?MEMC
>> ? ? ? ? ? ? ? ? ? ? ? ? ?LCD
>> ? ? ? ? ? ? ? ? ? ? ? ? ?VPP
>> ? ? ? ? ? ? ? ? ? ? ? ? ?GRAPHIC
>> ? ? ? ? ? ? ? ? ? ? ? ? ?MULTIMEDIA
>> ? ? ? ? ? ? ? ? ? ? ? ? ?GPS
>> ? ? ? ? ? ? ? ? ? ? ? ? ?UART
>> ? ? ? ? ? ? ? ? ? ? ? ? ?...
>> ? ? ? ? ? ? ? ? ? ? ? ? ?hard-coded PCI bridge
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?SD/MMC
>> ? ? ? ? ? ? ? ? ? ? ? ? ?rtc-iobrg
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?RTC
>>
>
> Is this really just one bus with a huge address space, or rather some
> nested buses? I'd prefer to have the device tree representation as
> close as possible to the actual layout.

there are two AXI buses in prima2. AXI-1 connect to memory, AXI-2 is
transferred to CSR self-defined IOBUS by CPUIF, then 1 intterupt
controller and 9 IO bridges are connected to the IOBUS .
The 9 IO bridges are SYSIOBG, PERIIOBG,CPURTCIOBG, UUSIOBG, GRAPHIOBG,
MEDIAIOBG, DSPIOBG, DISPIOBG, MEMIOBG. Every iobrg connect to a group
of controllers.
For example, DISPIOBG connect to VPP and LCD, SYSIOBG connect to CLKC,
RSTC, RSC and CPHIFBG, DSPIOBG connect to DSPIF, GPS and DSP.
PERIIOBG connect to TIMER, NAND, AUDIO, UART0, UART1, UART2, USP0,
USP1, USP2, SPI0, I2C0, I2C1, GPIO, *SYS2PCI* and so on. Then
*SYS2PCI* connect to SD.

The indendation descible the device hierarchy
AXI-1
         Memory
AXI-2
         interrupt controller
         IOBG...
                  xxxx
         IOBG...
                  xxxx
         IOBG...
                  xxxx
         IOBG...
                  xxxx
         IOBG...
                  xxxx
         IOBG...
                  SYS2PCI
                            SD

i have get the IC guy Weizeng involved, maybe he can explain better than me :-)

>
> This also includes using bus-local addresses for the 'reg' properties,
> rather than global addresses.
>
>> ?1. clock: use dev_id instead of con_id
>> ?2. Kconfig: delete ISA_DMA
>> ?3. irq: implement int controller based on DT
>> ? ? ? ?move to GENERIC_IRQ_CHIP framework
>> ?4. timer: implement timer based on DT
>> ?5. entry-macro.S: use get_irqnr_preamble to load the base address only once
>> ? ? per IRQ exception.
>> ?6. others:
>> ? ? ? use readl_relaxed instead of __raw_readl
>> ? ? ? adjust Kconfig order for PRIMA2
>> ? ? ? use clk_get_sys instead of clk_get for system level clock
>> ? ? ? use BUG_ON(IS_ERR(clk)) instead of BUG_ON(IS_ERR_OR_NULL(clk));
>> ? ? ? fix typo for CLOCK_TICK_RATE
>> ? ? ? ("sirf,xxx", "sirf,prima2-xxx") ?instead of ("sirf,xxx") in dts
>>
>
> Good progress!
>
>> new file mode 100644
>> index 0000000..1777e98
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/prima2-cb.dts
>> @@ -0,0 +1,50 @@
>> +/dts-v1/;
>> +/ {
>> + ? ? model = "SIRF Prima2 EVB";
>> + ? ? compatible = "sirf,prima2-cb", "sirf,prima2";
>> + ? ? #address-cells = <1>;
>> + ? ? #size-cells = <1>;
>> + ? ? interrupt-parent = <&intc>;
>> +
>> + ? ? memory {
>> + ? ? ? ? ? ? reg = <0x00000000 0x20000000>;
>> + ? ? };
>> +
>> + ? ? chosen {
>> + ? ? ? ? ? ? bootargs = "mem=512M real_root=/dev/mmcblk0p2 console=ttyS1 earlyprintk";
>> + ? ? ? ? ? ? linux,stdout-path = &uart1;
>> + ? ? };
>> +
>> + ? ? amba {
>> + ? ? ? ? ? ? compatible = "simple-bus";
>> + ? ? ? ? ? ? #address-cells = <1>;
>> + ? ? ? ? ? ? #size-cells = <1>;
>> + ? ? ? ? ? ? ranges;
>> +
>> + ? ? ? ? ? ? intc: interrupt-controller at 0x80020000 {
>> + ? ? ? ? ? ? ? ? ? ? interrupt-controller;
>> + ? ? ? ? ? ? ? ? ? ? compatible = "sirf,intc", "sirf,prima2-intc";
>> + ? ? ? ? ? ? ? ? ? ? reg = <0x80020000 0x1000>;
>> + ? ? ? ? ? ? ? ? ? ? #interrupt-cells = <1>;
>> + ? ? ? ? ? ? };
>
> Some more commends on the device tree properties:
>
> I think the namespace for the compatible values is supposed to start with
> the stock ticker name of the company making the device as a unique
> identifier. This means you'd have to use
> "csrxf,sirf-intc", "csrxf,sirf-prima2-intc" as the value, instead
> of starting with the product name. I don't know exactly how strictly
> we apply that rule, but I've taken the devicetree-discuss at lists.ozlabs.org
> mailing list on Cc, maybe someone can clarify.

in fact, SiRF is a company name. it was merged into CSR 4 years ago.
Due to history reason, now the SoC names are still headed by sirf.
the logo in SiRFprimaII chip is CSR.
So the "SiRF" of SiRFprimaII should mean two things: old company name,
 heritable CPU production-line. Anyway, "csr, sirf-intc" seems to make
more senses than "sirf, intc".

could we change "csrxf,sirf-intc", "csrxf,sirf-prima2-intc" to
"csr,sirf-intc", "csr,sirf-prima2-intc"?

>
>> + ? ? ? ? ? ? timer0: timer at 0xb0020000 {
>> + ? ? ? ? ? ? ? ? ? ? compatible = "sirf,tick", "sirf,prima2-tick";
>> + ? ? ? ? ? ? ? ? ? ? reg = <0xb0020000 0x1000>;
>> + ? ? ? ? ? ? ? ? ? ? interrupts = <0>;
>> + ? ? ? ? ? ? };
>> +
>> + ? ? ? ? ? ? uart0: uart at 0xb0050000 {
>> + ? ? ? ? ? ? ? ? ? ? compatible = "sirf,uart", "sirf,prima2-uart";
>> + ? ? ? ? ? ? ? ? ? ? reg = <0xb0050000 0x1000>;
>> + ? ? ? ? ? ? ? ? ? ? interrupts = <17>;
>> + ? ? ? ? ? ? };
>> +
>> + ? ? ? ? ? ? uart1: uart at 0xb0060000 {
>> + ? ? ? ? ? ? ? ? ? ? compatible = "sirf,uart", "sirf,prima2-uart";
>> + ? ? ? ? ? ? ? ? ? ? reg = <0xb0060000 0x1000>;
>> + ? ? ? ? ? ? ? ? ? ? interrupts = <18>;
>> + ? ? ? ? ? ? };
>> + ? ? };
>> +};
>
> When you use local addresses, this would become something like
>
> ? ? ? ?axi1 {
> ? ? ? ? ? ? ? ?compatible = "simple-bus";
> ? ? ? ? ? ? ? ?#address-cells = <1>;
> ? ? ? ? ? ? ? ?#size-cells = <1>;
> ? ? ? ? ? ? ? ?ranges <0 0x80000000 0x10000000>;
>
> ? ? ? ? ? ? ? ?intc: interrupt-controller at 20000 {
> ? ? ? ? ? ? ? ? ? ? ? ?interrupt-controller;
> ? ? ? ? ? ? ? ? ? ? ? ?compatible = "sirf,intc", "sirf,prima2-intc";
> ? ? ? ? ? ? ? ? ? ? ? ?reg = <0x20000 0x1000>;
> ? ? ? ? ? ? ? ? ? ? ? ?#interrupt-cells = <1>;
> ? ? ? ? ? ? ? ?};
> ? ? ? ?}
> ? ? ? ?axi2 {
> ? ? ? ? ? ? ? ?compatible = "simple-bus";
> ? ? ? ? ? ? ? ?#address-cells = <1>;
> ? ? ? ? ? ? ? ?#size-cells = <1>;
> ? ? ? ? ? ? ? ?ranges <0 0xb0000000 0x10000000>;
>
> ? ? ? ? ? ? ? ?timer0: timer at 20000 {
> ? ? ? ? ? ? ? ? ? ? ? ?reg = <0x20000 0x1000>;
> ? ? ? ? ? ? ? ?};
>
> ? ? ? ? ? ? ? ?uart0: uart at 50000 {
> ? ? ? ? ? ? ? ? ? ? ? ?reg = <0x50000 0x1000>;
> ? ? ? ? ? ? ? ?};
>
> ? ? ? ? ? ? ? ?uart1: uart at 60000 {
> ? ? ? ? ? ? ? ? ? ? ? ?reg = <0x60000 0x1000>;
> ? ? ? ? ? ? ? ?};
> ? ? ? ?};
>

Ok. i will send the full DT in patch v3.

>
>
>> +
>> diff --git a/arch/arm/mach-prima2/Makefile b/arch/arm/mach-prima2/Makefile
>> new file mode 100644
>> index 0000000..c51d60d
>> --- /dev/null
>> +++ b/arch/arm/mach-prima2/Makefile
>> @@ -0,0 +1 @@
>> +obj-y := timer.o irq.o clock.o common.o board_dt.o
>
> Minor detail:
>
> better put these in a list with one file per line, like
>
> obj-y ? += timer.o
> obj-y ? += irq.o
>
> That makes the list more consistent when you add conditional files.

Then it could be:
obj-y += timer.o
obj-y += irq.o
obj-y += clock.o
obj-y += common.o
obj-$(CONFIG_CACHE_L2X0) := l2x0.o

>
>> +++ b/arch/arm/mach-prima2/board_dt.c
>> @@ -0,0 +1,28 @@
>> +/*
>> + * This file contains code for boards with device tree support.
>> + *
>> + * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#include <linux/of.h>
>> +#include <asm/mach/arch.h>
>> +#include <asm/mach-types.h>
>> +#include <mach/hardware.h>
>> +#include "common.h"
>> +
>> +static const char *prima2cb_dt_match[] __initdata = {
>> + ? ? ? "sirf,prima2-cb",
>> + ? ? ? NULL
>> +};
>> +
>> +MACHINE_START(PRIMA2_EVB, "prima2cb")
>> + ? ? ? .boot_params ? ?= SIRFSOC_SDRAM_PA + 0x100,
>> + ? ? ? .init_early ? ? = sirfsoc_init_clk,
>> + ? ? ? .map_io ? ? ? ? = sirfsoc_map_io,
>> + ? ? ? .init_irq ? ? ? = sirfsoc_of_init_irq,
>> + ? ? ? .timer ? ? ? ? ?= &sirfsoc_timer,
>> + ? ? ? .init_machine ? = sirfsoc_mach_init,
>> + ? ? ? .dt_compat ? ? ?= prima2cb_dt_match,
>> +MACHINE_END
>
> How about removing the remaining board file entirely and merging the contents into
> common.c? We don't want to have board specific files any more, so the naming
> and the split is rather obsolete.
>
> It probably makes sense to pick a new name for the combined file, too, but I
> can't think of a good one. Maybe one of platform.c, prima2.c or core.c.

i am not sure the original purpose of board_dt.c. and i am guessing
whether Grant created that single board file to contain multiple
boards. For example:

MACHINE_START(PRIMA2_XXX, "prima2xxx")
       .boot_params    = SIRFSOC_SDRAM_PA + 0x100,
       .init_early     = sirfsoc_init_clk,
       .map_io         = sirfsoc_map_io,
       .init_irq       = sirfsoc_of_init_irq,
       .timer          = &sirfsoc_timer,
       .init_machine   = sirfsoc_mach_init,
       .dt_compat      = prima2xxx_dt_match,
MACHINE_END

MACHINE_START(PRIMA2_YYY, "prima2yyy")
       .boot_params    = SIRFSOC_SDRAM_PA + 0x100,
       .init_early     = sirfsoc_init_clk,
       .map_io         = sirfsoc_map_io,
       .init_irq       = sirfsoc_of_init_irq,
       .timer          = &sirfsoc_timer,
       .init_machine   = sirfsoc_mach_init,
       .dt_compat      = prima2yyy_dt_match,
MACHINE_END

MACHINE_START(PRIMA2_ZZZ, "prima2zzz)
       .boot_params    = SIRFSOC_SDRAM_PA + 0x100,
       .init_early     = sirfsoc_init_clk,
       .map_io         = sirfsoc_map_io,
       .init_irq       = sirfsoc_of_init_irq,
       .timer          = &sirfsoc_timer,
       .init_machine   = sirfsoc_mach_init,
       .dt_compat      = prima2zzz_dt_match,
MACHINE_END

>
>> +#define IOTABLE_ENTRY(region) {\
>> + ? ? .virtual ? ? ? ?= SIRFSOC_##region##_VA_BASE, \
>> + ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(SIRFSOC_##region##_PA_BASE),\
>> + ? ? .length ? ? ? ? = SIRFSOC_##region##_SIZE, \
>> + ? ? .type ? ? ? ? ? = MT_DEVICE, \
>> +}
>> +
>> +static struct map_desc sirfsoc_iodesc[] __initdata = {
>> + ? ? IOTABLE_ENTRY(UART1),
>> + ? ? IOTABLE_ENTRY(CLOCK),
>> + ? ? IOTABLE_ENTRY(RSTC),
>> +#ifdef CONFIG_CACHE_L2X0
>> + ? ? IOTABLE_ENTRY(L2CC),
>> +#endif
>> +};
>
> I've thought about this some more, and I think you can get rid of most
> entries in the global table after all:
>
> * sirfsoc_init_clk() can get the physical address from the device tree
> and call iotable_init for just one entry.

Ok.
>
> * RSTC does not seem to be needed early at all, you can simply ioremap it.
>
Ok.

> * L2CC is only accessed from an arch_initcall, which is late enough
> ?for ioremap.
>
> * UART1 is only needed for early printk, so I would put the function
> ?that does this remaining iotable_init() call into a separate file
> ?that only gets compiled when that is enabled.
>
>> +void __init sirfsoc_map_io(void)
>> +{
>> + ? ? iotable_init(sirfsoc_iodesc, ARRAY_SIZE(sirfsoc_iodesc));
>> +}
>> +
>> +#define L2X0_ADDR_FILTERING_START ? ? ? 0xC00
>> +#define L2X0_ADDR_FILTERING_END ? ? ? ? 0xC04
>> +
>> +static int __init sirfsoc_init(void)
>> +{
>> +#ifdef CONFIG_CACHE_L2X0
>> + ? ? if (!(readl_relaxed(SIRFSOC_L2CC_VA_BASE + L2X0_CTRL) & 1)) {
>> + ? ? ? ? ? ? /*
>> + ? ? ? ? ? ? ?* set the physical memory windows L2 cache will cover
>> + ? ? ? ? ? ? ?*/
>> + ? ? ? ? ? ? writel_relaxed(PHYS_OFFSET + 1024 * 1024 * 1024,
>> + ? ? ? ? ? ? ? ? ? ? SIRFSOC_L2CC_VA_BASE + L2X0_ADDR_FILTERING_END);
>> + ? ? ? ? ? ? writel_relaxed(PHYS_OFFSET | 0x1,
>> + ? ? ? ? ? ? ? ? ? ? SIRFSOC_L2CC_VA_BASE + L2X0_ADDR_FILTERING_START);
>> +
>> + ? ? ? ? ? ? writel_relaxed(0,
>> + ? ? ? ? ? ? ? ? ? ? SIRFSOC_L2CC_VA_BASE + L2X0_TAG_LATENCY_CTRL);
>> + ? ? ? ? ? ? writel_relaxed(0,
>> + ? ? ? ? ? ? ? ? ? ? SIRFSOC_L2CC_VA_BASE + L2X0_DATA_LATENCY_CTRL);
>> + ? ? }
>> + ? ? l2x0_init((void __iomem *)SIRFSOC_L2CC_VA_BASE, 0x00040000,
>> + ? ? ? ? ? ? 0x00000000);
>> +#endif
>> +
>> + ? ? return 0;
>> +}
>> +arch_initcall(sirfsoc_init);
>
> I would also suggest moving the l2x0 code into a new l2x0.c file that
> is conditionally compiled. In the header file, you then do
>
> #ifdef CONFIG_CACHE_L2X0
> extern void sirfsoc_l2x0_init(void);
> #else
> static inline void sirfsoc_l2x0_init(void) {}
> #endif

yes.

after creating a new file named mach-prima2/l2x0.c,  it seems we only
need to change Makefile to:
obj-$(CONFIG_CACHE_L2X0) := l2x0.o
the head file is not needed.

Currently, rob's OF-based L2 cache is not merged yet. then i only
write the following:

static int __init sirfsoc_of_l2x_init(void)
{
        struct device_node *np;
        void __iomem *sirfsoc_l2x_base;

        np = of_find_matching_node(NULL, l2x_ids);
        if (!np)
                panic("unable to find compatible intc node in dtb\n");

        sirfsoc_l2x_base = of_iomap(np, 0);
        if (!sirfsoc_l2x_base)
                panic("unable to map l2x cpu registers\n");

        of_node_put(np);

        if (!(readl_relaxed(sirfsoc_l2x_base + L2X0_CTRL) & 1)) {
                /*
                 * set the physical memory windows L2 cache will cover
                 */
                writel_relaxed(PLAT_PHYS_OFFSET + 1024 * 1024 * 1024,
                        sirfsoc_l2x_base + L2X0_ADDR_FILTERING_END);
                writel_relaxed(PLAT_PHYS_OFFSET | 0x1,
                        sirfsoc_l2x_base + L2X0_ADDR_FILTERING_START);

                writel_relaxed(0,
                        sirfsoc_l2x_base + L2X0_TAG_LATENCY_CTRL);
                writel_relaxed(0,
                        sirfsoc_l2x_base + L2X0_DATA_LATENCY_CTRL);
        }
        l2x0_init((void __iomem *)sirfsoc_l2x_base, 0x00040000,
                0x00000000);

        return 0;
}
early_initcall(sirfsoc_of_l2x_init);

After Rob's patch is merged, i think sirfsoc_of_l2x_init can be much simpler.

>
>> +#ifndef __ASM_ARCH_IRQS_H
>> +#define __ASM_ARCH_IRQS_H
>> +
>> +#define SIRFSOC_INTENAL_IRQ_START ?0
>> +#define SIRFSOC_INTENAL_IRQ_END ? ?59
>
> Typo, I assume: INTERNAL, not INTENAL

Yes.

>
>
>> +
>> +static struct of_device_id intc_ids[] ?= {
>> + ? ? { .compatible = "sirf,intc" },
>> + ? ? { .compatible = "sirf,prima2-intc" },
>> +};
>
> You should only list one of these in the driver: The idea is that as
> long as all variants of the hardware are identical, you can just list
> the most general name (sirf,intc), and if you need to tell the difference
> you list the more specific names and add a .data=... member that you
> use to differentiate between them. Note that it's usually easier to
> change the code than to change the device tree, so we want to have
> the full list in the device tree, but the code just needs to pick
> one that fits the purpose.

Ok.

>
> It's the same for the other drivers.
>
>> +static void __init sirfsoc_of_timer_map(void);
>
> You can remove this forward declaration if you move the sched_clock()
> function down.

Ok

>
> ? ? ? ?Arnd
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
