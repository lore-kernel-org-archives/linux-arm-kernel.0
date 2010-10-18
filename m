From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 18 Oct 2010 19:23:55 +0200
Subject: [PATCH] ARM: print FPGA info on plat-versatile variants
Message-ID: <1287422635-21492-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a small piece of code that displays some basic FPGA
characteristics for the Integrator, Versatile, RealView and
Versatile Express reference platforms, then hooks it into
respective platform startup code.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-integrator/core.c                |    2 +
 arch/arm/mach-realview/core.c                  |    2 +
 arch/arm/mach-versatile/core.c                 |    2 +
 arch/arm/mach-vexpress/v2m.c                   |    2 +
 arch/arm/plat-versatile/Makefile               |    2 +-
 arch/arm/plat-versatile/fpga-id.c              |  123 ++++++++++++++++++++++++
 arch/arm/plat-versatile/include/plat/fpga-id.h |    1 +
 7 files changed, 133 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-versatile/fpga-id.c
 create mode 100644 arch/arm/plat-versatile/include/plat/fpga-id.h

diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 8f4fb6d..4272bfd 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -32,6 +32,7 @@
 #include <asm/leds.h>
 #include <asm/mach/time.h>
 #include <asm/pgtable.h>
+#include <plat/fpga-id.h>
 
 static struct amba_pl010_data integrator_uart_data;
 
@@ -149,6 +150,7 @@ static int __init integrator_init(void)
 {
 	int i;
 
+	versatile_fpga_probe(IO_ADDRESS(INTEGRATOR_SC_ID));
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 07c0815..87f3822 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -51,6 +51,7 @@
 #include <mach/platform.h>
 #include <mach/irqs.h>
 #include <plat/timer-sp.h>
+#include <plat/fpga-id.h>
 
 #include "core.h"
 
@@ -694,6 +695,7 @@ void __init realview_timer_init(unsigned int timer_irq)
 
 	sp804_clocksource_init(timer3_va_base);
 	sp804_clockevents_init(timer0_va_base, timer_irq);
+	versatile_fpga_probe(__io_address(REALVIEW_SYS_ID));
 }
 
 /*
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index e38acb0..8d62a57 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -50,6 +50,7 @@
 #include <mach/hardware.h>
 #include <mach/platform.h>
 #include <plat/timer-sp.h>
+#include <plat/fpga-id.h>
 
 #include "core.h"
 
@@ -922,6 +923,7 @@ static void __init versatile_timer_init(void)
 
 	sp804_clocksource_init(TIMER3_VA_BASE);
 	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMERINT0_1);
+	versatile_fpga_probe(__io_address(VERSATILE_SYS_ID));
 }
 
 struct sys_timer versatile_timer = {
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 7eaa232..26e206c 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -23,6 +23,7 @@
 #include <mach/motherboard.h>
 
 #include <plat/timer-sp.h>
+#include <plat/fpga-id.h>
 
 #include "core.h"
 
@@ -55,6 +56,7 @@ static void __init v2m_timer_init(void)
 
 	sp804_clocksource_init(MMIO_P2V(V2M_TIMER1));
 	sp804_clockevents_init(MMIO_P2V(V2M_TIMER0), IRQ_V2M_TIMER0);
+	versatile_fpga_probe(MMIO_P2V(V2M_SYS_ID));
 }
 
 struct sys_timer v2m_timer = {
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 5cf88e8..8fe7b01 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,4 +1,4 @@
-obj-y	:= clock.o
+obj-y	:= clock.o fpga-id.o
 obj-$(CONFIG_ARM_TIMER_SP804) += timer-sp.o
 obj-$(CONFIG_ARCH_REALVIEW) += sched-clock.o
 obj-$(CONFIG_ARCH_VERSATILE) += sched-clock.o
diff --git a/arch/arm/plat-versatile/fpga-id.c b/arch/arm/plat-versatile/fpga-id.c
new file mode 100644
index 0000000..909f95d
--- /dev/null
+++ b/arch/arm/plat-versatile/fpga-id.c
@@ -0,0 +1,123 @@
+/*
+ * Some simple code to read out the FPGA ID of the Integrator,
+ * Versatile, RealView or RealView Express systems during boot
+ * and print it to the console.
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ * Author: Linus Walleij <linus.walleij@stericsson.com>
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <asm/mach-types.h>
+
+struct versatile_fpga_id {
+	u8 man:4;
+	u8 rev:4;
+	u16 board:12;
+	u8 var:4;
+	u8 arch:4;
+	u8 fpga_build;
+};
+
+static struct versatile_fpga_id fpga_id;
+
+static inline bool integrator_or_versatile(void)
+{
+	return machine_is_integrator() ||
+		machine_is_versatile_pb() ||
+		machine_is_versatile_ab();
+}
+
+void __init versatile_fpga_probe(void __iomem *sysid_reg)
+{
+	u32 val;
+
+	val = readl(sysid_reg);
+	/* The Integrator and Versatile have an older register layout */
+	if (machine_is_integrator()) {
+		fpga_id.man = (val >> 24) & 0x0FU;
+		fpga_id.board = (val >> 12) & 0x0FU;
+		fpga_id.arch = (val >> 16) & 0x0FF;
+		fpga_id.fpga_build = (val >> 4) & 0xFFU;
+		fpga_id.rev = val & 0x0FU;
+	} else if (machine_is_versatile_pb() ||
+		   machine_is_versatile_ab()) {
+		/* Versatile PB is for example 0x41007004 */
+		fpga_id.man = (val >> 24) & 0x0FU;
+		fpga_id.board = (val >> 12) & 0x0FU;
+		fpga_id.arch = val & 0x0FU;
+		fpga_id.fpga_build = (val >> 4) & 0xFFU;
+	} else {
+		/* RealView or Versatile Express */
+		fpga_id.rev = (val >> 28) & 0x0FU;
+		fpga_id.board = (val >> 16) & 0xFFFU;
+		fpga_id.var = (val >> 12) & 0x0FU;
+		fpga_id.arch = (val >> 8) & 0x0FU;
+		fpga_id.fpga_build = val & 0xFFU;
+	}
+
+	pr_info("RealView system FPGA\n");
+
+	/* Manufacturer */
+	if (integrator_or_versatile())
+		pr_info("    manufacturer: %02x\n", fpga_id.man);
+		
+	/* Single letter revision */
+	if (fpga_id.rev == 0x0F)
+		pr_info("    revision: ALL\n");
+	else
+		pr_info("    revision: %c\n", 'A' + fpga_id.rev);
+
+	switch (fpga_id.board) {
+	case 1:
+		/* Integrator */
+		pr_info("    board: XC4062\n");
+		break;
+	case 2:
+		/* Integrator */
+		pr_info("    board: XC4085\n");
+		break;
+	case 7:
+		/* Versatile */
+		pr_info("    board: XC2V2000\n");
+		break;
+	default:
+		/*
+		 * This is BCD-coded according to the PBX-A9 manual
+		 * and examples, IDs used in RealView and Versatile
+		 * Express.
+		 */
+		pr_info("    board: HBI-%03x\n", fpga_id.board);
+		break;
+	}
+
+	/* Single letter variant */
+	if (!integrator_or_versatile()) {
+		if (fpga_id.var == 0x0F)
+			pr_info("    variant: ALL\n");
+		else
+			pr_info("    variant: %c\n", 'A' + fpga_id.rev);
+	}
+
+	switch (fpga_id.arch) {
+	case 0:
+		pr_info("    architecture: ASB LE\n");
+		break;
+	case 1:
+		pr_info("    architecture: AHB LE\n");
+		break;
+	case 4:
+		pr_info("    architecture: AHB\n");
+		break;
+	case 5:
+		pr_info("    architecture: AXI\n");
+		break;
+	default:
+		pr_info("    architecture: %01x (unknown)\n", fpga_id.arch);
+		break;
+	}
+
+	/* This is BCD-coded according to the PBX-A9 manual */
+	pr_info("    FPGA build %02x\n", fpga_id.fpga_build);
+}
diff --git a/arch/arm/plat-versatile/include/plat/fpga-id.h b/arch/arm/plat-versatile/include/plat/fpga-id.h
new file mode 100644
index 0000000..466a59c
--- /dev/null
+++ b/arch/arm/plat-versatile/include/plat/fpga-id.h
@@ -0,0 +1 @@
+void versatile_fpga_probe(void __iomem *sysid_reg);
-- 
1.7.2.3
