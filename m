From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 13 Apr 2014 16:39:52 +0200
Subject: [PATCH 15/29] ARM: orion5x: switch to DT interrupts and timer
In-Reply-To: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397400006-4315-16-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit switches the Orion5x platforms described through DT to use
a DT-defined interrupt controller and timer.

This involves:

 * Describing in the DT the bridge interrupt controller, which is a
   child interrupt controller to the main one, which is used for timer
   and watchdog interrupts.

 * Describing in the DT the timer.

 * Adding in the DT the interrupt specifications for the watchdog.

 * Selecting the ORION_IRQCHIP and ORION_TIMER drivers to be compiled.

 * Change the timer initialization in board-dt.c to use
   clocksource_of_init().

 * Implement a multi-IRQ handler for non-DT platforms in
   mach-orion5x/irq.c.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/orion5x.dtsi   | 19 +++++++++++++++++++
 arch/arm/mach-orion5x/Kconfig    |  2 ++
 arch/arm/mach-orion5x/board-dt.c | 10 ++--------
 arch/arm/mach-orion5x/irq.c      | 28 ++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index ac2ec8f..f25ed91 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -78,6 +78,15 @@
 				status = "disabled";
 			};
 
+			bridge_intc: bridge-interrupt-ctrl at 20110 {
+				compatible = "marvell,orion-bridge-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				reg = <0x20110 0x8>;
+				interrupts = <0>;
+				marvell,#interrupts = <4>;
+			};
+
 			intc: interrupt-controller at 20200 {
 				compatible = "marvell,orion-intc";
 				interrupt-controller;
@@ -85,9 +94,19 @@
 				reg = <0x20200 0x08>;
 			};
 
+			timer at 20300 {
+				compatible = "marvell,orion-timer";
+				reg = <0x20300 0x20>;
+				interrupt-parent = <&bridge_intc>;
+				interrupts = <1>, <2>;
+				clocks = <&core_clk 0>;
+			};
+
 			wdt at 20300 {
 				compatible = "marvell,orion-wdt";
 				reg = <0x20300 0x28>;
+				interrupt-parent = <&bridge_intc>;
+				interrupts = <3>;
 				status = "okay";
 			};
 
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 4f51132..bd65872 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -6,6 +6,8 @@ config ARCH_ORION5X_DT
 	bool "Marvell Orion5x Flattened Device Tree"
 	select USE_OF
 	select ORION_CLK
+	select ORION_IRQCHIP
+	select ORION_TIMER
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Orion5x using flattened device tree.
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index c489661..38b54f1 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -17,6 +17,7 @@
 #include <linux/cpu.h>
 #include <linux/mbus.h>
 #include <linux/clk-provider.h>
+#include <linux/clocksource.h>
 #include <asm/system_misc.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -36,15 +37,10 @@ static struct of_dev_auxdata orion5x_auxdata_lookup[] __initdata = {
 	{},
 };
 
-static void orion5x_dt_init_early(void)
-{
-	orion_time_set_base(TIMER_VIRT_BASE);
-}
-
 static void orion5x_dt_init_time(void)
 {
-	orion5x_timer_init();
 	of_clk_init(NULL);
+	clocksource_of_init();
 	BUG_ON(mvebu_mbus_dt_init());
 }
 
@@ -85,8 +81,6 @@ static const char *orion5x_dt_compat[] = {
 DT_MACHINE_START(ORION5X_DT, "Marvell Orion5x (Flattened Device Tree)")
 	/* Maintainer: Thomas Petazzoni <thomas.petazzoni@free-electrons.com> */
 	.map_io		= orion5x_map_io,
-	.init_early	= orion5x_dt_init_early,
-	.init_irq	= orion_dt_init_irq,
 	.init_time	= orion5x_dt_init_time,
 	.init_machine	= orion5x_dt_init,
 	.restart	= orion5x_restart,
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
index 9654b0c..cd4bac4 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion5x/irq.c
@@ -16,6 +16,7 @@
 #include <mach/bridge-regs.h>
 #include <plat/orion-gpio.h>
 #include <plat/irq.h>
+#include <asm/exception.h>
 #include "common.h"
 
 static int __initdata gpio0_irqs[4] = {
@@ -25,10 +26,37 @@ static int __initdata gpio0_irqs[4] = {
 	IRQ_ORION5X_GPIO_24_31,
 };
 
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+/*
+ * Compiling with both non-DT and DT support enabled, will
+ * break asm irq handler used by non-DT boards. Therefore,
+ * we provide a C-style irq handler even for non-DT boards,
+ * if MULTI_IRQ_HANDLER is set.
+ */
+
+asmlinkage void
+__exception_irq_entry orion5x_legacy_handle_irq(struct pt_regs *regs)
+{
+	u32 stat;
+
+	stat = readl_relaxed(MAIN_IRQ_CAUSE);
+	stat &= readl_relaxed(MAIN_IRQ_MASK);
+	if (stat) {
+		unsigned int hwirq = __fls(stat);
+		handle_IRQ(hwirq, regs);
+		return;
+	}
+}
+#endif
+
 void __init orion5x_init_irq(void)
 {
 	orion_irq_init(0, MAIN_IRQ_MASK);
 
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+	set_handle_irq(orion5x_legacy_handle_irq);
+#endif
+
 	/*
 	 * Initialize gpiolib for GPIOs 0-31.
 	 */
-- 
1.8.3.2
