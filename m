From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 1 Jul 2011 14:20:12 +0800
Subject: [PATCH v2] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <201106301236.25822.arnd@arndb.de>
References: <1309231954-23260-1-git-send-email-bs14@csr.com>
	<201106292329.44447.arnd@arndb.de>
	<BANLkTinfKCMcutMDQ+mpdD4EUy9mCpZs+w@mail.gmail.com>
	<201106301236.25822.arnd@arndb.de>
Message-ID: <BANLkTikoMu3ccUxj5KRmKzdReQcBqK4Y9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

2011/6/30 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 30 June 2011, Barry Song wrote:
>
>> > Is this really just one bus with a huge address space, or rather some
>> > nested buses? I'd prefer to have the device tree representation as
>> > close as possible to the actual layout.
>>
>> there are two AXI buses in prima2. AXI-1 connect to memory, AXI-2 is
>> transferred to CSR self-defined IOBUS by CPUIF, then 1 intterupt
>> controller and 9 IO bridges are connected to the IOBUS .
>> The 9 IO bridges are SYSIOBG, PERIIOBG,CPURTCIOBG, UUSIOBG, GRAPHIOBG,
>> MEDIAIOBG, DSPIOBG, DISPIOBG, MEMIOBG. Every iobrg connect to a group
>> of controllers.
>> For example, DISPIOBG connect to VPP and LCD, SYSIOBG connect to CLKC,
>> RSTC, RSC and CPHIFBG, DSPIOBG connect to DSPIF, GPS and DSP.
>> PERIIOBG connect to TIMER, NAND, AUDIO, UART0, UART1, UART2, USP0,
>> USP1, USP2, SPI0, I2C0, I2C1, GPIO, *SYS2PCI* and so on. Then
>> *SYS2PCI* connect to SD.
>>
>> The indendation descible the device hierarchy
>> AXI-1
>> ? ? ? ? ?Memory
>> AXI-2
>> ? ? ? ? ?interrupt controller
>> ? ? ? ? ?IOBG...
>> ? ? ? ? ? ? ? ? ? xxxx
>> ? ? ? ? ?IOBG...
>> ? ? ? ? ? ? ? ? ? xxxx
>> ? ? ? ? ?IOBG...
>> ? ? ? ? ? ? ? ? ? xxxx
>> ? ? ? ? ?IOBG...
>> ? ? ? ? ? ? ? ? ? xxxx
>> ? ? ? ? ?IOBG...
>> ? ? ? ? ? ? ? ? ? xxxx
>> ? ? ? ? ?IOBG...
>> ? ? ? ? ? ? ? ? ? SYS2PCI
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? SD
>>
>> i have get the IC guy Weizeng involved, maybe he can explain better than me :-)
>
> I think it would be good to represent the IOBG devices in the device tree then.
> You don't need to represent AXI-1 because memory is special anyway, and I would
> not bother to list SYS2PCI if the intention of that block was to hide the fact
> that it's PCI behind it. Properly instantiating it as a PCI bridge would be
> a lot of work that is probably not worth it.
>
> My usual plea to hardware developers: Please make the registers
> autodiscoverable from software! On an AMBA bus, please use the PrimeCell
> register layout. If you always have an IOBG device behind, they should
> all have the same identifier for that kind of bus bridge.
>
> For the IOBG, it would be ideal to have a similar way of finding and
> configuring the connected hardware, including:
>
> * unique identifier for each distinct IP block
> * revision of that block
> * MMIO ranges and sizes, relative to the bus
> * interrupt numbers, relative to a local interrupt controller
> * location identifier (like PCI bus/device/fn number) that can be
> ?referred to by other devices
> * clock management for that device
> * power management for that device
>
> If your IODB infrastructure already has this, you should create a new
> bus-type for this in Linux, which will let you detect all devices
> in a consistent manner without having to list them in the device tree.

IO bridges in prima2 don't have that. Configuration is hardcoded now.
but we have learned so much from you and hope to improve our future IC
design.

>
>> > I think the namespace for the compatible values is supposed to start with
>> > the stock ticker name of the company making the device as a unique
>> > identifier. This means you'd have to use
>> > "csrxf,sirf-intc", "csrxf,sirf-prima2-intc" as the value, instead
>> > of starting with the product name. I don't know exactly how strictly
>> > we apply that rule, but I've taken the devicetree-discuss at lists.ozlabs.org
>> > mailing list on Cc, maybe someone can clarify.
>>
>> in fact, SiRF is a company name. it was merged into CSR 4 years ago.
>> Due to history reason, now the SoC names are still headed by sirf.
>> the logo in SiRFprimaII chip is CSR.
>> So the "SiRF" of SiRFprimaII should mean two things: old company name,
>> ?heritable CPU production-line. Anyway, "csr, sirf-intc" seems to make
>> more senses than "sirf, intc".
>>
>> could we change "csrxf,sirf-intc", "csrxf,sirf-prima2-intc" to
>> "csr,sirf-intc", "csr,sirf-prima2-intc"?
>
> Not sure how strict we interpret the rules about stock ticker symbols.
> 'CSR' on wallstreet is 'China Security & Surveillance Tech. Inc'. If they
> ever decide to produce embedded Linux machines, we'd get a conflict, unless
> they also use "csst" (their .com domain name) as a prefix.
>
>> > better put these in a list with one file per line, like
>> >
>> > obj-y ? += timer.o
>> > obj-y ? += irq.o
>> >
>> > That makes the list more consistent when you add conditional files.
>>
>> Then it could be:
>> obj-y += timer.o
>> obj-y += irq.o
>> obj-y += clock.o
>> obj-y += common.o
>> obj-$(CONFIG_CACHE_L2X0) := l2x0.o

Now it is changed to:

+obj-y := timer.o
+obj-y += irq.o
+obj-y += clock.o
+obj-y += rstc.o
+obj-y += prima2.o
+obj-$(CONFIG_CACHE_L2X0) += l2x0.o
+obj-$(CONFIG_DEBUG_LL) += lluart.o

For clock, i have moved the static mapping to clock.c:

diff --git a/arch/arm/mach-prima2/clock.c b/arch/arm/mach-prima2/clock.c
new file mode 100644
index 0000000..f4676bc
--- /dev/null
+++ b/arch/arm/mach-prima2/clock.c
...
+
+static void __init sirfsoc_clk_init(void)
+{
+	clkdev_add_table(onchip_clks, ARRAY_SIZE(onchip_clks));
+}
+
+static struct of_device_id clkc_ids[] = {
+	{ .compatible = "sirf,clkc" },
+};
+
+void __init sirfsoc_of_clk_init(void)
+{
+	struct device_node *np;
+	struct resource res;
+	struct map_desc sirfsoc_clkc_iodesc = {
+		.virtual = SIRFSOC_CLOCK_VA_BASE,
+		.type    = MT_DEVICE,
+	};
+
+	np = of_find_matching_node(NULL, clkc_ids);
+	if (!np)
+		panic("unable to find compatible clkc node in dtb\n");
+
+	if (of_address_to_resource(np, 0, &res))
+		panic("unable to find clkc range in dtb");
+	of_node_put(np);
+
+	sirfsoc_clkc_iodesc.pfn = __phys_to_pfn(res.start);
+	sirfsoc_clkc_iodesc.length = 1 + res.end - res.start;
+
+	iotable_init(&sirfsoc_clkc_iodesc, 1);
+
+	sirfsoc_clk_init();
+}

It looks like we can new a common function named as of_io_earlymap()
or something in drivers/of/address.c. of_iomap() does ioremap,
of_io_earlymap() does early static mapping?
Then all SoCs can call this function to do early static mapping. if
so, some lines can be deleted in sirfsoc_of_clk_init(). How do you
think about newing the function in drivers/of/address.c?

For DEBUG_LL uart, i have moved the static mapping to a new file named
lluart.c too:
+#include <linux/kernel.h>
+#include <asm/page.h>
+#include <asm/mach/map.h>
+#include <mach/map.h>
+#include <mach/uart.h>
+
+void __init sirfsoc_map_lluart(void)
+{
+	struct map_desc sirfsoc_lluart_map = {
+		.virtual        = SIRFSOC_UART1_VA_BASE,
+		.pfn            = __phys_to_pfn(SIRFSOC_UART1_PA_BASE),
+		.length         = SIRFSOC_UART1_SIZE,
+		.type           = MT_DEVICE,
+	};
+
+	iotable_init(&sirfsoc_lluart_map, 1);
+}
+

only when DEBUG_LL is selected, this file will be compiled. Otherwise,
an empty sirfsoc_map_lluart is used:
--- /dev/null
+++ b/arch/arm/mach-prima2/common.h
@@ -0,0 +1,26 @@
+/*
+ * This file contains common function prototypes to avoid externs in
the c files.
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef __MACH_PRIMA2_COMMON_H__
+#define __MACH_PRIMA2_COMMON_H__
+
+#include <linux/init.h>
+#include <asm/mach/time.h>
+
+extern struct sys_timer sirfsoc_timer;
+
+extern void __init sirfsoc_of_irq_init(void);
+extern void __init sirfsoc_of_clk_init(void);
+
+#ifndef CONFIG_DEBUG_LL
+static inline void sirfsoc_map_lluart(void)  {}
+#else
+extern void __init sirfsoc_map_lluart(void);
+#endif
+
+#endif

For rstc, it is the reset controller in prima2, every bit can reset a
special component in the SoC. i move the mapping to a new rstc.c file
too. But APIs, which every driver will call to reset itself,  in rstc
is not full finished:
+/*
+ * reset controller for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+void __iomem *sirfsoc_rstc_base;
+
+static struct of_device_id rstc_ids[]  = {
+	{ .compatible = "sirf,rstc" },
+};
+
+static int __init sirfsoc_of_rstc_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, rstc_ids);
+	if (!np)
+		panic("unable to find compatible rstc node in dtb\n");
+
+	sirfsoc_rstc_base = of_iomap(np, 0);
+	if (!sirfsoc_rstc_base)
+		panic("unable to map rstc cpu registers\n");
+
+	of_node_put(np);
+
+	return 0;
+}
+early_initcall(sirfsoc_of_rstc_init);
+
+/* TODO:
+ * add APIs to control reset of every module
+ */

>
>
> Right. Note that you have a := in there, which needs to be +=.
>
>
>> > It probably makes sense to pick a new name for the combined file, too, but I
>> > can't think of a good one. Maybe one of platform.c, prima2.c or core.c.
>>
>> i am not sure the original purpose of board_dt.c. and i am guessing
>> whether Grant created that single board file to contain multiple
>> boards. For example:
>>
>> MACHINE_START(PRIMA2_XXX, "prima2xxx")
>> ? ? ? ?.boot_params ? ?= SIRFSOC_SDRAM_PA + 0x100,
>> ? ? ? ?.init_early ? ? = sirfsoc_init_clk,
>> ? ? ? ?.map_io ? ? ? ? = sirfsoc_map_io,
>> ? ? ? ?.init_irq ? ? ? = sirfsoc_of_init_irq,
>> ? ? ? ?.timer ? ? ? ? ?= &sirfsoc_timer,
>> ? ? ? ?.init_machine ? = sirfsoc_mach_init,
>> ? ? ? ?.dt_compat ? ? ?= prima2xxx_dt_match,
>> MACHINE_END
>>
>> MACHINE_START(PRIMA2_YYY, "prima2yyy")
>> ? ? ? ?.boot_params ? ?= SIRFSOC_SDRAM_PA + 0x100,
>> ? ? ? ?.init_early ? ? = sirfsoc_init_clk,
>> ? ? ? ?.map_io ? ? ? ? = sirfsoc_map_io,
>> ? ? ? ?.init_irq ? ? ? = sirfsoc_of_init_irq,
>> ? ? ? ?.timer ? ? ? ? ?= &sirfsoc_timer,
>> ? ? ? ?.init_machine ? = sirfsoc_mach_init,
>> ? ? ? ?.dt_compat ? ? ?= prima2yyy_dt_match,
>> MACHINE_END
>
> No, this wouldn't make any sense when the only difference is the dt_compat
> field: At that point you would just list all the possible boards in the
> global dt_match table.

Yes. i have rename common.c to prima2.c and now there is no any
map_desc table due to the above changes, so it is now much shorter:

diff --git a/arch/arm/mach-prima2/prima2.c b/arch/arm/mach-prima2/prima2.c
new file mode 100644
index 0000000..f6b04a1
--- /dev/null
+++ b/arch/arm/mach-prima2/prima2.c
@@ -0,0 +1,40 @@
+/*
+ * Defines machines for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include "common.h"
+
+static struct of_device_id sirfsoc_of_bus_ids[] __initdata = {
+	{ .compatible = "simple-bus", },
+	{},
+};
+
+void __init sirfsoc_mach_init(void)
+{
+	of_platform_bus_probe(NULL, sirfsoc_of_bus_ids, NULL);
+}
+
+static const char *prima2cb_dt_match[] __initdata = {
+       "sirf,prima2-cb",
+       NULL
+};
+
+MACHINE_START(PRIMA2_EVB, "prima2cb")
+	.boot_params	= 0x00000100,
+	.init_early     = sirfsoc_of_clk_init,
+	.map_io		= sirfsoc_map_lluart,
+	.init_irq	= sirfsoc_of_irq_init,
+	.timer		= &sirfsoc_timer,
+	.init_machine	= sirfsoc_mach_init,
+	.dt_compat      = prima2cb_dt_match,
+MACHINE_END

>
>> after creating a new file named mach-prima2/l2x0.c, ?it seems we only
>> need to change Makefile to:
>> obj-$(CONFIG_CACHE_L2X0) := l2x0.o
>> the head file is not needed.
>>
>> Currently, rob's OF-based L2 cache is not merged yet. then i only
>> write the following:
>>
>> static int __init sirfsoc_of_l2x_init(void)
>> {
>> ? ? ? ? struct device_node *np;
>> ? ? ? ? void __iomem *sirfsoc_l2x_base;
>>
>> ? ? ? ? np = of_find_matching_node(NULL, l2x_ids);
>> ? ? ? ? if (!np)
>> ? ? ? ? ? ? ? ? panic("unable to find compatible intc node in dtb\n");
>>
>> ? ? ? ? sirfsoc_l2x_base = of_iomap(np, 0);
>> ? ? ? ? if (!sirfsoc_l2x_base)
>> ? ? ? ? ? ? ? ? panic("unable to map l2x cpu registers\n");
>>
>> ? ? ? ? of_node_put(np);
>>
>> ? ? ? ? if (!(readl_relaxed(sirfsoc_l2x_base + L2X0_CTRL) & 1)) {
>> ? ? ? ? ? ? ? ? /*
>> ? ? ? ? ? ? ? ? ?* set the physical memory windows L2 cache will cover
>> ? ? ? ? ? ? ? ? ?*/
>> ? ? ? ? ? ? ? ? writel_relaxed(PLAT_PHYS_OFFSET + 1024 * 1024 * 1024,
>> ? ? ? ? ? ? ? ? ? ? ? ? sirfsoc_l2x_base + L2X0_ADDR_FILTERING_END);
>> ? ? ? ? ? ? ? ? writel_relaxed(PLAT_PHYS_OFFSET | 0x1,
>> ? ? ? ? ? ? ? ? ? ? ? ? sirfsoc_l2x_base + L2X0_ADDR_FILTERING_START);
>>
>> ? ? ? ? ? ? ? ? writel_relaxed(0,
>> ? ? ? ? ? ? ? ? ? ? ? ? sirfsoc_l2x_base + L2X0_TAG_LATENCY_CTRL);
>> ? ? ? ? ? ? ? ? writel_relaxed(0,
>> ? ? ? ? ? ? ? ? ? ? ? ? sirfsoc_l2x_base + L2X0_DATA_LATENCY_CTRL);
>> ? ? ? ? }
>> ? ? ? ? l2x0_init((void __iomem *)sirfsoc_l2x_base, 0x00040000,
>> ? ? ? ? ? ? ? ? 0x00000000);
>>
>> ? ? ? ? return 0;
>> }
>> early_initcall(sirfsoc_of_l2x_init);
>>
>> After Rob's patch is merged, i think sirfsoc_of_l2x_init can be much simpler.
>>
> Yes. Rob/Olof, what's the status of that patch?
>
> ? ? ? ?Arnd
>

After we get aggrement on DT node name(csr/csrxf/csr.l ?), i will send
patch v3 with all those all changes and full DT. Really thank you very
much!

-barry
