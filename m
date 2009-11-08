From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Mon, 9 Nov 2009 03:09:55 +0530
Subject: [PATCH] arm nomadik: Introduce plat-nomadik, MTU code re-organization
Message-ID: <1257716395.29221.10.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Date: Mon, 9 Nov 2009 14:37:28 +0530

Introduce the plat-nomadik folder for ST-Ericsson
machines including the existing nomadik 8815 architecture.
This also moves the existing MTU (MultiTimerUnit)
of nomadik 8815 to the proposed plat-nomadik and adds
HAS_MTU. The patch has been re-based to 2.6.32-rc6

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Alessandro Rubini <rubini@unipv.it>
---
 arch/arm/Kconfig                                   |    1 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/mach-nomadik/Kconfig                      |    2 +-
 arch/arm/mach-nomadik/Makefile                     |    2 +-
 arch/arm/mach-nomadik/board-nhk8815.c              |   27 +++++++++++++++
 arch/arm/mach-nomadik/include/mach/setup.h         |    2 +-
 arch/arm/plat-nomadik/Kconfig                      |   22 ++++++++++++
 arch/arm/plat-nomadik/Makefile                     |    5 +++
 .../mach => plat-nomadik/include/plat}/mtu.h       |    9 +++--
 arch/arm/{mach-nomadik => plat-nomadik}/timer.c    |   35 +++++--------------
 10 files changed, 74 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/plat-nomadik/Kconfig
 create mode 100644 arch/arm/plat-nomadik/Makefile
 rename arch/arm/{mach-nomadik/include/mach => plat-nomadik/include/plat}/mtu.h (90%)
 rename arch/arm/{mach-nomadik => plat-nomadik}/timer.c (81%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..76cd466 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -787,6 +787,7 @@ source "arch/arm/mach-at91/Kconfig"
 source "arch/arm/plat-mxc/Kconfig"
 
 source "arch/arm/mach-nomadik/Kconfig"
+source "arch/arm/plat-nomadik/Kconfig"
 
 source "arch/arm/mach-netx/Kconfig"
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a73caaf..1bee36f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -176,6 +176,7 @@ machine-$(CONFIG_ARCH_MXC91231)		:= mxc91231
 plat-$(CONFIG_ARCH_MXC)		:= mxc
 plat-$(CONFIG_ARCH_OMAP)	:= omap
 plat-$(CONFIG_PLAT_IOP)		:= iop
+plat-$(CONFIG_PLAT_NOMADIK)	:= nomadik
 plat-$(CONFIG_PLAT_ORION)	:= orion
 plat-$(CONFIG_PLAT_PXA)		:= pxa
 plat-$(CONFIG_PLAT_S3C24XX)	:= s3c24xx s3c
diff --git a/arch/arm/mach-nomadik/Kconfig b/arch/arm/mach-nomadik/Kconfig
index 2a02b49..3c5e0f5 100644
--- a/arch/arm/mach-nomadik/Kconfig
+++ b/arch/arm/mach-nomadik/Kconfig
@@ -5,13 +5,13 @@ menu "Nomadik boards"
 config MACH_NOMADIK_8815NHK
 	bool "ST 8815 Nomadik Hardware Kit (evaluation board)"
 	select NOMADIK_8815
+	select HAS_MTU
 
 endmenu
 
 config NOMADIK_8815
 	bool
 
-
 config I2C_BITBANG_8815NHK
 	tristate "Driver for bit-bang busses found on the 8815 NHK"
 	depends on I2C && MACH_NOMADIK_8815NHK
diff --git a/arch/arm/mach-nomadik/Makefile b/arch/arm/mach-nomadik/Makefile
index 4120409..36f67fb 100644
--- a/arch/arm/mach-nomadik/Makefile
+++ b/arch/arm/mach-nomadik/Makefile
@@ -7,7 +7,7 @@
 
 # Object file lists.
 
-obj-y			+= clock.o timer.o gpio.o
+obj-y			+= clock.o gpio.o
 
 # Cpu revision
 obj-$(CONFIG_NOMADIK_8815) += cpu-8815.o
diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index 6bfd537..1163944 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -25,11 +25,18 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/flash.h>
+
+#include <plat/mtu.h>
+
 #include <mach/setup.h>
 #include <mach/nand.h>
 #include <mach/fsmc.h>
 #include "clock.h"
 
+/* Initial value for SRC control register: all timers use MXTAL/8 source */
+#define SRC_CR_INIT_MASK	0x00007fff
+#define SRC_CR_INIT_VAL		0x2aaa8000
+
 /* These adresses span 16MB, so use three individual pages */
 static struct resource nhk8815_nand_resources[] = {
 	{
@@ -239,6 +246,26 @@ static struct platform_device *nhk8815_platform_devices[] __initdata = {
 	/* will add more devices */
 };
 
+static void __init nomadik_timer_init(void)
+{
+	u32 src_cr;
+
+	/* Configure timer sources in "system reset controller" ctrl reg */
+	src_cr = readl(io_p2v(NOMADIK_SRC_BASE));
+	src_cr &= SRC_CR_INIT_MASK;
+	src_cr |= SRC_CR_INIT_VAL;
+	writel(src_cr, io_p2v(NOMADIK_SRC_BASE));
+
+	/* Save global pointer to mtu, used by platform timer code */
+	mtu_base = io_p2v(NOMADIK_MTU0_BASE);
+
+	nmdk_timer_init();
+}
+
+static struct sys_timer nomadik_timer = {
+	.init	= nomadik_timer_init,
+};
+
 static void __init nhk8815_platform_init(void)
 {
 	int i;
diff --git a/arch/arm/mach-nomadik/include/mach/setup.h b/arch/arm/mach-nomadik/include/mach/setup.h
index a4e468c..b7897ed 100644
--- a/arch/arm/mach-nomadik/include/mach/setup.h
+++ b/arch/arm/mach-nomadik/include/mach/setup.h
@@ -15,7 +15,7 @@
 extern void cpu8815_map_io(void);
 extern void cpu8815_platform_init(void);
 extern void cpu8815_init_irq(void);
-extern struct sys_timer nomadik_timer;
+extern void nmdk_timer_init(void);
 
 #endif /* NOMADIK_8815 */
 
diff --git a/arch/arm/plat-nomadik/Kconfig b/arch/arm/plat-nomadik/Kconfig
new file mode 100644
index 0000000..e27ee31
--- /dev/null
+++ b/arch/arm/plat-nomadik/Kconfig
@@ -0,0 +1,22 @@
+# We keep common IP's here for Nomadik and other similar
+# familiy of processors from ST-Ericsson. At the moment we have
+# just MTU, others to follow soon.
+
+config PLAT_NOMADIK
+	bool
+	depends on ARCH_NOMADIK
+	default y
+	help
+	  Common platform code for Nomadik and other ST-Ericsson
+	  platforms.
+
+if PLAT_NOMADIK
+
+config HAS_MTU
+	bool
+	help
+	  Support for Multi Timer Unit. MTU provides access
+	  to multiple interrupt generating programmable
+	  32-bit free running decrementing counters.
+
+endif
diff --git a/arch/arm/plat-nomadik/Makefile b/arch/arm/plat-nomadik/Makefile
new file mode 100644
index 0000000..37c7cdd
--- /dev/null
+++ b/arch/arm/plat-nomadik/Makefile
@@ -0,0 +1,5 @@
+# arch/arm/plat-nomadik/Makefile
+# Copyright 2009 ST-Ericsson
+# Licensed under GPLv2
+
+obj-$(CONFIG_HAS_MTU)	+= timer.o
diff --git a/arch/arm/mach-nomadik/include/mach/mtu.h b/arch/arm/plat-nomadik/include/plat/mtu.h
similarity index 90%
rename from arch/arm/mach-nomadik/include/mach/mtu.h
rename to arch/arm/plat-nomadik/include/plat/mtu.h
index 76da7f0..42c9072 100644
--- a/arch/arm/mach-nomadik/include/mach/mtu.h
+++ b/arch/arm/plat-nomadik/include/plat/mtu.h
@@ -1,5 +1,8 @@
-#ifndef __ASM_ARCH_MTU_H
-#define __ASM_ARCH_MTU_H
+#ifndef __PLAT_MTU_H
+#define __PLAT_MTU_H
+
+/* should be set by the platform code */
+extern void __iomem *mtu_base;
 
 /*
  * The MTU device hosts four different counters, with 4 set of
@@ -41,5 +44,5 @@
 #define MTU_PCELL2	0xff8
 #define MTU_PCELL3	0xffC
 
-#endif /* __ASM_ARCH_MTU_H */
+#endif /* __PLAT_MTU_H */
 
diff --git a/arch/arm/mach-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
similarity index 81%
rename from arch/arm/mach-nomadik/timer.c
rename to arch/arm/plat-nomadik/timer.c
index d1738e7..62f18ad 100644
--- a/arch/arm/mach-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -15,19 +15,14 @@
 #include <linux/clockchips.h>
 #include <linux/jiffies.h>
 #include <asm/mach/time.h>
-#include <mach/mtu.h>
 
-#define TIMER_CTRL	0x80	/* No divisor */
-#define TIMER_PERIODIC	0x40
-#define TIMER_SZ32BIT	0x02
-
-/* Initial value for SRC control register: all timers use MXTAL/8 source */
-#define SRC_CR_INIT_MASK	0x00007fff
-#define SRC_CR_INIT_VAL		0x2aaa8000
+#include <plat/mtu.h>
 
 static u32	nmdk_count;		/* accumulated count */
 static u32	nmdk_cycle;		/* write-once */
-static __iomem void *mtu_base;
+
+/* setup by the platform code */
+void __iomem *mtu_base;
 
 /*
  * clocksource: the MTU device is a decrementing counters, so we negate
@@ -93,7 +88,7 @@ static struct clock_event_device nmdk_clkevt = {
 static irqreturn_t nmdk_timer_interrupt(int irq, void *dev_id)
 {
 	/* ack: "interrupt clear register" */
-	writel( 1 << 0, mtu_base + MTU_ICR);
+	writel(1 << 0, mtu_base + MTU_ICR);
 
 	/* we can't count lost ticks, unfortunately */
 	nmdk_count += nmdk_cycle;
@@ -125,24 +120,14 @@ static void nmdk_timer_reset(void)
 	writel(cr | MTU_CRn_ENA, mtu_base + MTU_CR(0));
 }
 
-static void __init nmdk_timer_init(void)
+void __init nmdk_timer_init(void)
 {
-	u32 src_cr;
 	unsigned long rate;
 	int bits;
 
 	rate = CLOCK_TICK_RATE; /* 2.4MHz */
 	nmdk_cycle = (rate + HZ/2) / HZ;
 
-	/* Configure timer sources in "system reset controller" ctrl reg */
-	src_cr = readl(io_p2v(NOMADIK_SRC_BASE));
-	src_cr &= SRC_CR_INIT_MASK;
-	src_cr |= SRC_CR_INIT_VAL;
-	writel(src_cr, io_p2v(NOMADIK_SRC_BASE));
-
-	/* Save global pointer to mtu, used by functions above */
-	mtu_base = io_p2v(NOMADIK_MTU0_BASE);
-
 	/* Init the timer and register clocksource */
 	nmdk_timer_reset();
 
@@ -150,7 +135,9 @@ static void __init nmdk_timer_init(void)
 	bits =  8*sizeof(nmdk_count);
 	nmdk_clksrc.mask = CLOCKSOURCE_MASK(bits);
 
-	clocksource_register(&nmdk_clksrc);
+	if (clocksource_register(&nmdk_clksrc))
+		printk(KERN_ERR "timer: failed to initialize clock "
+			"source %s\n", nmdk_clksrc.name);
 
 	/* Register irq and clockevents */
 	setup_irq(IRQ_MTU0, &nmdk_timer_irq);
@@ -158,7 +145,3 @@ static void __init nmdk_timer_init(void)
 	nmdk_clkevt.cpumask = cpumask_of(0);
 	clockevents_register_device(&nmdk_clkevt);
 }
-
-struct sys_timer nomadik_timer = {
-	.init		= nmdk_timer_init,
-};
-- 
1.5.6.3
