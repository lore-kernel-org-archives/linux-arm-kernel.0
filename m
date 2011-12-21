From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 21 Dec 2011 16:13:48 +0100
Subject: [RFC PATCH] ARM: new architecture for Energy Micro's EFM32 Cortex-M3
 SoCs
Message-ID: <1324480428-13344-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

currently this relies on the bootloader to enable all necessary clocks
because there is no functional clk API, yet.

Other than that my machine comes up, but the 1 MiB of RAM is very tight,
so I have to stick to XIP.

Also note that this depends on ARMv7M support that is picked from
Catalin's repository. I didn't come around yet to rework them into a
shape acceptable for mainline. I ported them to 3.2-rc and needed a few
more hacks (e.g. I don't have a bootloader, so I added a little
assembler bootloader that is included at the start of my xipImage).
If you're interested in the details I can publish my tree I think.

Best regards
Uwe

 arch/arm/Kconfig                               |   11 ++-
 arch/arm/Kconfig.debug                         |    8 +
 arch/arm/Makefile                              |    1 +
 arch/arm/boot/dts/efm32gg-dk3750.dts           |   41 ++++++
 arch/arm/mach-efm32/Makefile                   |    3 +
 arch/arm/mach-efm32/Makefile.boot              |    1 +
 arch/arm/mach-efm32/clk.c                      |   30 +++++
 arch/arm/mach-efm32/common.h                   |    7 +
 arch/arm/mach-efm32/dtmachine.c                |   47 +++++++
 arch/arm/mach-efm32/include/mach/debug-macro.S |   32 +++++
 arch/arm/mach-efm32/include/mach/entry-macro.S |   12 ++
 arch/arm/mach-efm32/include/mach/io.h          |    7 +
 arch/arm/mach-efm32/include/mach/irqs.h        |    6 +
 arch/arm/mach-efm32/include/mach/system.h      |   18 +++
 arch/arm/mach-efm32/include/mach/timex.h       |    7 +
 arch/arm/mach-efm32/time.c                     |  166 ++++++++++++++++++++++++
 arch/arm/mm/Kconfig                            |    2 +-
 17 files changed, 397 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/efm32gg-dk3750.dts
 create mode 100644 arch/arm/mach-efm32/Makefile
 create mode 100644 arch/arm/mach-efm32/Makefile.boot
 create mode 100644 arch/arm/mach-efm32/clk.c
 create mode 100644 arch/arm/mach-efm32/common.h
 create mode 100644 arch/arm/mach-efm32/dtmachine.c
 create mode 100644 arch/arm/mach-efm32/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-efm32/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-efm32/include/mach/io.h
 create mode 100644 arch/arm/mach-efm32/include/mach/irqs.h
 create mode 100644 arch/arm/mach-efm32/include/mach/system.h
 create mode 100644 arch/arm/mach-efm32/include/mach/timex.h
 create mode 100644 arch/arm/mach-efm32/time.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8555445..68de356 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -400,6 +400,15 @@ config ARCH_EBSA110
 	  Ethernet interface, two PCMCIA sockets, two serial ports and a
 	  parallel port.
 
+config ARCH_EFM32
+	bool "EnergyMicro Cortex M3 Platform"
+	depends on !MMU
+	select CPU_V7M
+	select ARM_NVIC
+	select GENERIC_CLOCKEVENTS
+	select NO_DMA
+	select CLKSRC_MMIO
+
 config ARCH_EP93XX
 	bool "EP93xx-based"
 	select CPU_ARM920T
@@ -1699,7 +1708,7 @@ source "mm/Kconfig"
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order" if ARCH_SHMOBILE
 	range 11 64 if ARCH_SHMOBILE
-	default "9" if SA1111
+	default "9" if SA1111 || ARCH_EFM32
 	default "11"
 	help
 	  The kernel memory allocator divides physically contiguous memory
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index c5213e7..cdec99b 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -128,6 +128,14 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to the second serial port on these devices.
 
+	config DEBUG_EFM32_USART1
+		bool "Kernel low-level debugging messages via USART1"
+		depends on ARCH_EFM32
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to the second serial port on efm32 based
+		  machines.
+
 	config DEBUG_HIGHBANK_UART
 		bool "Kernel low-level debugging messages via Highbank UART"
 		depends on ARCH_HIGHBANK
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 042fdec..b955c46 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -142,6 +142,7 @@ machine-$(CONFIG_ARCH_CNS3XXX)		:= cns3xxx
 machine-$(CONFIG_ARCH_DAVINCI)		:= davinci
 machine-$(CONFIG_ARCH_DOVE)		:= dove
 machine-$(CONFIG_ARCH_EBSA110)		:= ebsa110
+machine-$(CONFIG_ARCH_EFM32)		:= efm32
 machine-$(CONFIG_ARCH_EP93XX)		:= ep93xx
 machine-$(CONFIG_ARCH_GEMINI)		:= gemini
 machine-$(CONFIG_ARCH_H720X)		:= h720x
diff --git a/arch/arm/boot/dts/efm32gg-dk3750.dts b/arch/arm/boot/dts/efm32gg-dk3750.dts
new file mode 100644
index 0000000..a4aa4f3
--- /dev/null
+++ b/arch/arm/boot/dts/efm32gg-dk3750.dts
@@ -0,0 +1,41 @@
+/dts-v1/;
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Energy Micro Giant Gecko Development Kit";
+	compatible = "efm32,dk3750";
+
+	aliases {
+		serial1 = &uart1;
+	};
+
+	nvic: nv-interrupt-controller at 0xe0000000  {
+		compatible = "arm,cortex-m3-nvic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0xe0000000 0x4000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyefm1,115200 init=/linuxrc ignore_loglevel ihash_entries=64 dhash_entries=64";
+	};
+
+	memory {
+		reg = <0x80000000 0x100000>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&nvic>;
+		ranges;
+
+		uart1: uart at 0x4000c400 { /* USART1 */
+			compatible = "efm32,usart";
+			reg = <0x4000c400 0x400>;
+			interrupts = <15>;
+			status = "ok";
+		};
+	};
+};
diff --git a/arch/arm/mach-efm32/Makefile b/arch/arm/mach-efm32/Makefile
new file mode 100644
index 0000000..10a3426
--- /dev/null
+++ b/arch/arm/mach-efm32/Makefile
@@ -0,0 +1,3 @@
+obj-y += clk.o time.o
+
+obj-$(CONFIG_OF) += dtmachine.o
diff --git a/arch/arm/mach-efm32/Makefile.boot b/arch/arm/mach-efm32/Makefile.boot
new file mode 100644
index 0000000..385e93a
--- /dev/null
+++ b/arch/arm/mach-efm32/Makefile.boot
@@ -0,0 +1 @@
+dtb-$(CONFIG_MACH_EFM32GG_DK3750) += efm32gg-dk3750.dtb
diff --git a/arch/arm/mach-efm32/clk.c b/arch/arm/mach-efm32/clk.c
new file mode 100644
index 0000000..86fadc8
--- /dev/null
+++ b/arch/arm/mach-efm32/clk.c
@@ -0,0 +1,30 @@
+#include <linux/clk.h>
+#include <linux/export.h>
+
+struct clk *clk_get(struct device *dev, const char *id)
+{
+	return NULL;
+}
+EXPORT_SYMBOL(clk_get);
+
+int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return 14000000;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+void clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_put);
diff --git a/arch/arm/mach-efm32/common.h b/arch/arm/mach-efm32/common.h
new file mode 100644
index 0000000..f545224
--- /dev/null
+++ b/arch/arm/mach-efm32/common.h
@@ -0,0 +1,7 @@
+#ifdef __ASSEMBLER__
+#define IOMEM(addr)     (addr)
+#else
+#define IOMEM(addr)     ((void __force __iomem *)(addr))
+#endif
+
+extern struct sys_timer efm32_timer;
diff --git a/arch/arm/mach-efm32/dtmachine.c b/arch/arm/mach-efm32/dtmachine.c
new file mode 100644
index 0000000..42d091c
--- /dev/null
+++ b/arch/arm/mach-efm32/dtmachine.c
@@ -0,0 +1,47 @@
+#include <linux/kernel.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/irqdomain.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
+
+#include <asm/hardware/nvic.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+
+#include "common.h"
+
+static void __init efm32_nvic_add_irq_domain(struct device_node *np,
+		struct device_node *interrupt_parent)
+{
+	irq_domain_add_simple(np, 0);
+}
+
+static const struct of_device_id efm32_irq_match[] __initconst = {
+	{
+		.compatible = "arm,cortex-m3-nvic",
+		.data = efm32_nvic_add_irq_domain,
+	}, {
+		/* sentinel */
+	}
+};
+
+static void __init efm32_init(void)
+{
+	int ret;
+
+	of_irq_init(efm32_irq_match);
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *const efm32gg_compat[] __initconst = {
+	"efm32,dk3750",
+	NULL
+};
+
+DT_MACHINE_START(EFM32DT, "EFM32 (Device Tree Support)")
+	.init_irq = nvic_init,
+	.timer = &efm32_timer,
+	.init_machine = efm32_init,
+	.dt_compat = efm32gg_compat,
+MACHINE_END
diff --git a/arch/arm/mach-efm32/include/mach/debug-macro.S b/arch/arm/mach-efm32/include/mach/debug-macro.S
new file mode 100644
index 0000000..cbf37f3
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/debug-macro.S
@@ -0,0 +1,32 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+		.macro	addruart,rx,tmp
+		mov	\rx,      #0x40000000
+		orr	\rx, \rx, #0x0000C400		/* USART1 */
+		.endm
+
+#define	USARTn_DR	0x34
+#define	USARTn_FR	0x10
+#define	USARTn_FR_TXFF	0x0020
+
+		.macro	senduart,rd,rx
+		strb	\rd, [\rx, #USARTn_DR]
+		.endm
+
+		.macro	waituart,rd,rx
+1001:		ldr	\rd, [\rx, #USARTn_FR]
+		tst	\rd, #USARTn_FR_TXFF
+		it eq
+		beq	1001b
+		.endm
+
+		.macro	busyuart,rd,rx
+1001:		ldr	\rd, [\rx, USARTn_FR]
+		tst	\rd, USARTn_FR_TXFF
+		it ne
+		bne	1001b
+		.endm
diff --git a/arch/arm/mach-efm32/include/mach/entry-macro.S b/arch/arm/mach-efm32/include/mach/entry-macro.S
new file mode 100644
index 0000000..75b304a
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/entry-macro.S
@@ -0,0 +1,12 @@
+/*
+ *
+ */
+#include <asm/hardware/gic.h>
+
+		.macro	get_irqnr_preamble, base, tmp
+		ldr	\base, =gic_cpu_base_addr
+		ldr	\base, [\base]
+		.endm
+
+		.macro	arch_ret_to_user, tmp1, tmp2
+		.endm
diff --git a/arch/arm/mach-efm32/include/mach/io.h b/arch/arm/mach-efm32/include/mach/io.h
new file mode 100644
index 0000000..00b6af6
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/io.h
@@ -0,0 +1,7 @@
+#ifndef __MACH_IO_H__
+#define __MACH_IO_H__
+
+#define __io(a)			__typesafe_io(a)
+#define __mem_pci(a)		(a)
+
+#endif /* __MACH_IO_H__ */
diff --git a/arch/arm/mach-efm32/include/mach/irqs.h b/arch/arm/mach-efm32/include/mach/irqs.h
new file mode 100644
index 0000000..5fa84db
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/irqs.h
@@ -0,0 +1,6 @@
+#ifndef __MACH_IRQS_H__
+#define __MACH_IRQS_H__
+
+#define NR_IRQS			37
+
+#endif /* __MACH_IRQS_H__ */
diff --git a/arch/arm/mach-efm32/include/mach/system.h b/arch/arm/mach-efm32/include/mach/system.h
new file mode 100644
index 0000000..619222c
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/system.h
@@ -0,0 +1,18 @@
+#ifndef __MACH_SYSTEM_H__
+#define __MACH_SYSTEM_H__
+
+#include <asm/io.h>
+
+static inline void arch_idle(void)
+{
+	cpu_do_idle();
+}
+
+static inline void arch_reset(char mode, const char *cmd)
+{
+	/* XXX: move this to (say) cpuv7m_reset */
+	dsb();
+	__raw_writel(0x05fa0004, (void __iomem *)0xe000ed0c);
+	dsb();
+}
+#endif /* __MACH_SYSTEM_H__ */
diff --git a/arch/arm/mach-efm32/include/mach/timex.h b/arch/arm/mach-efm32/include/mach/timex.h
new file mode 100644
index 0000000..b408dce
--- /dev/null
+++ b/arch/arm/mach-efm32/include/mach/timex.h
@@ -0,0 +1,7 @@
+#ifndef __MACH_TIMEX_H__
+#define __MACH_TIMEX_H__
+
+/* just a bogus value */
+#define CLOCK_TICK_RATE	12345678
+
+#endif /* __MACH_TIMEX_H__ */
diff --git a/arch/arm/mach-efm32/time.c b/arch/arm/mach-efm32/time.c
new file mode 100644
index 0000000..65f93a3
--- /dev/null
+++ b/arch/arm/mach-efm32/time.c
@@ -0,0 +1,166 @@
+#include <linux/kernel.h>
+#include <linux/clocksource.h>
+#include <linux/clockchips.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/stringify.h>
+
+#include <asm/mach/time.h>
+
+#include <common.h>
+
+#define BASEADDR_TIMER(n)		IOMEM(0x40010000 + (n) * 0x400)
+
+#define TIMERn_CTRL			0x00
+#define TIMERn_CTRL_PRESC(val)			(((val) & 0xf) << 24)
+#define TIMERn_CTRL_PRESC_1024			TIMERn_CTRL_PRESC(10)
+#define TIMERn_CTRL_CLKSEL(val)			(((val) & 0x3) << 16)
+#define TIMERn_CTRL_CLKSEL_PRESCHFPERCLK	TIMERn_CTRL_CLKSEL(0)
+#define TIMERn_CTRL_OSMEN			0x00000010
+#define TIMERn_CTRL_MODE(val)			(((val) & 0x3) <<  0)
+#define TIMERn_CTRL_MODE_UP			TIMERn_CTRL_MODE(0)
+#define TIMERn_CTRL_MODE_DOWN			TIMERn_CTRL_MODE(1)
+
+#define TIMERn_CMD			0x04
+#define TIMERn_CMD_START			0x1
+#define TIMERn_CMD_STOP				0x2
+
+#define TIMERn_IEN			0x0c
+#define TIMERn_IF			0x10
+#define TIMERn_IFS			0x14
+#define TIMERn_IFC			0x18
+#define TIMERn_IRQ_UF				0x2
+#define TIMERn_IRQ_OF				0x1
+
+#define TIMERn_TOP			0x1c
+#define TIMERn_CNT			0x24
+
+#define TIMER_CLOCKSOURCE	1
+#define TIMER_CLOCKEVENT	2
+#define IRQ_CLOCKEVENT		13
+
+static void efm32_timer_write(unsigned timerno, u32 val, unsigned offset)
+{
+	__raw_writel(val, BASEADDR_TIMER(timerno) + offset);
+}
+
+static void efm32_clock_event_set_mode(enum clock_event_mode mode,
+		struct clock_event_device *unused)
+{
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		efm32_timer_write(TIMER_CLOCKEVENT,
+				TIMERn_CMD_STOP, TIMERn_CMD);
+		efm32_timer_write(TIMER_CLOCKEVENT, 137, TIMERn_TOP);
+		efm32_timer_write(TIMER_CLOCKEVENT,
+				TIMERn_CTRL_PRESC_1024 |
+				TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
+				TIMERn_CTRL_MODE_DOWN, TIMERn_CTRL);
+		efm32_timer_write(TIMER_CLOCKEVENT,
+				TIMERn_CMD_START, TIMERn_CMD);
+		break;
+
+	case CLOCK_EVT_MODE_ONESHOT:
+		efm32_timer_write(TIMER_CLOCKEVENT,
+				TIMERn_CMD_STOP, TIMERn_CMD);
+		efm32_timer_write(TIMER_CLOCKEVENT,
+				TIMERn_CTRL_PRESC_1024 |
+				TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
+				TIMERn_CTRL_OSMEN |
+				TIMERn_CTRL_MODE_DOWN, TIMERn_CTRL);
+		break;
+
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		efm32_timer_write(TIMER_CLOCKEVENT, TIMERn_CMD_STOP,
+				TIMERn_CMD);
+		break;
+
+	case CLOCK_EVT_MODE_RESUME:
+		break;
+	}
+}
+
+static int efm32_clock_event_set_next_event(unsigned long evt,
+		struct clock_event_device *unused)
+{
+	/* writing START to CMD restarts a running timer, too */
+	efm32_timer_write(TIMER_CLOCKEVENT, evt, TIMERn_TOP);
+	efm32_timer_write(TIMER_CLOCKEVENT, TIMERn_CMD_START, TIMERn_CMD);
+
+	return 0;
+}
+
+static struct clock_event_device efm32_clock_event_device = {
+	.name = "efm32 clockevent (" __stringify(TIMER_CLOCKEVENT) ")",
+	.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_MODE_PERIODIC,
+	.set_mode = efm32_clock_event_set_mode,
+	.set_next_event = efm32_clock_event_set_next_event,
+	.rating = 200,
+};
+
+static irqreturn_t efm32_clock_event_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = &efm32_clock_event_device;
+
+	/* ack irq */
+	efm32_timer_write(TIMER_CLOCKEVENT, TIMERn_IRQ_UF, TIMERn_IFC);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction efm32_clock_event_irq = {
+	.name = "efm32 clockevent",
+	.flags = IRQF_TIMER,
+	.handler = efm32_clock_event_handler,
+	.dev_id = &efm32_clock_event_device,
+};
+
+/*
+ * XXX: use clk_ API to get frequency and enabling of the clocks used.
+ * Here the reset defaults are used:
+ * - freq_{HFPERCLK} = freq_{HFCLK}
+ *   (CMU_HFPERCLKDIV_HFPERCLKDIV = 0x0)
+ * - freq_{HFCLK} = freq_{HFRCO}
+ *   (CMU_CTRL_HFCLKDIV = 0x0, CMU_STATUS_HFRCOSEL = 0x1)
+ * - freq_{HFRCO} = 14MHz
+ *   (CMU_HFRCOCTRL_BAND = 0x3)
+ *
+ * So the HFPERCLK runs at 14MHz. The timer has an additional prescaler
+ * programmed to /1024. This make the timer run at
+ *
+ * 	14 MHz / 1024 = 13671.875 Hz
+ *
+ */
+static void __init efm32_timer_init(void)
+{
+	/* enable CMU_HFPERCLKEN0_TIMERn for clocksource via bit-band */
+	__raw_writel(1, IOMEM(0x43900894 + 4 * TIMER_CLOCKSOURCE));
+
+	efm32_timer_write(TIMER_CLOCKSOURCE,
+			TIMERn_CTRL_PRESC_1024 |
+			TIMERn_CTRL_CLKSEL_PRESCHFPERCLK |
+			TIMERn_CTRL_MODE_UP, TIMERn_CTRL);
+	efm32_timer_write(TIMER_CLOCKSOURCE, TIMERn_CMD_START, TIMERn_CMD);
+
+	clocksource_mmio_init(BASEADDR_TIMER(TIMER_CLOCKSOURCE) + TIMERn_CNT,
+			"efm32 timer", 13672, 200, 16,
+			clocksource_mmio_readl_up);
+
+	/* enable CMU_HFPERCLKEN0_TIMERn for clockevent via bit-band */
+	__raw_writel(1, IOMEM(0x43900894 + 4 * TIMER_CLOCKEVENT));
+
+	efm32_timer_write(TIMER_CLOCKEVENT, TIMERn_IRQ_UF, TIMERn_IEN);
+
+	setup_irq(IRQ_CLOCKEVENT, &efm32_clock_event_irq);
+
+	/* XXX: tune min_delta */
+	clockevents_config_and_register(&efm32_clock_event_device,
+			13672, 0xf, 0xffff);
+}
+
+struct sys_timer efm32_timer = {
+	.init = efm32_timer_init,
+};
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 2bc1a68..5b81e46 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -432,7 +432,7 @@ config CPU_V7
 # ARMv7
 config CPU_V7M
 	bool "Support ARMv7-M processors"
-	depends on MACH_REALVIEW_EB && EXPERIMENTAL
+	depends on (MACH_REALVIEW_EB && EXPERIMENTAL) || ARCH_EFM32
 	select THUMB2_KERNEL
 	select ARM_THUMB
 	select CPU_32v7M
-- 
1.7.7.3
