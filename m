From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 12 Sep 2013 09:38:06 +0900
Subject: [PATCH] ARM: shmobile: r8a7791 IRQC support
Message-ID: <20130912003806.24022.63355.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add support for r8a7791 IRQ pins IRQ0 -> IRQ9 via
the IRQC driver in drivers/irqchip/irq-renesas-irqc.c

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-20130906

 arch/arm/boot/dts/r8a7791.dtsi                |   18 ++++++++++++++
 arch/arm/mach-shmobile/Kconfig                |    1 
 arch/arm/mach-shmobile/board-koelsch.c        |    2 -
 arch/arm/mach-shmobile/include/mach/r8a7791.h |    1 
 arch/arm/mach-shmobile/setup-r8a7791.c        |   32 +++++++++++++++++++++++++
 5 files changed, 53 insertions(+), 1 deletion(-)

--- 0001/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2013-09-12 09:02:03.000000000 +0900
@@ -38,4 +38,22 @@
 			<0 0xf1006000 0 0x2000>;
 		interrupts = <1 9 0xf04>;
 	};
+
+	irqc0: interrupt-controller at e61c0000 {
+		compatible = "renesas,irqc";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0 0xe61c0000 0 0x200>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 0 4>,
+			      <0 1 4>,
+			      <0 2 4>,
+			      <0 3 4>,
+			      <0 12 4>,
+			      <0 13 4>,
+			      <0 14 4>,
+			      <0 15 4>,
+			      <0 16 4>,
+			      <0 17 4>;
+	};
 };
--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-09-12 09:02:03.000000000 +0900
@@ -106,6 +106,7 @@ config ARCH_R8A7791
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
+	select RENESAS_IRQC
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
--- 0001/arch/arm/mach-shmobile/board-koelsch.c
+++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-09-12 09:04:06.000000000 +0900
@@ -29,7 +29,7 @@
 static void __init koelsch_add_standard_devices(void)
 {
 	r8a7791_clock_init();
-	r8a7791_add_dt_devices();
+	r8a7791_add_standard_devices();
 }
 
 static const char * const koelsch_boards_compat_dt[] __initconst = {
--- 0001/arch/arm/mach-shmobile/include/mach/r8a7791.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7791.h	2013-09-12 09:03:39.000000000 +0900
@@ -1,6 +1,7 @@
 #ifndef __ASM_R8A7791_H__
 #define __ASM_R8A7791_H__
 
+void r8a7791_add_standard_devices(void);
 void r8a7791_add_dt_devices(void);
 void r8a7791_clock_init(void);
 void r8a7791_init_early(void);
--- 0001/arch/arm/mach-shmobile/setup-r8a7791.c
+++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2013-09-12 09:03:12.000000000 +0900
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/irq-renesas-irqc.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <mach/common.h>
@@ -109,6 +110,31 @@ static const struct resource cmt00_resou
 					  &cmt##idx##_platform_data,	\
 					  sizeof(struct sh_timer_config))
 
+static struct renesas_irqc_config irqc0_data = {
+	.irq_base = irq_pin(0), /* IRQ0 -> IRQ9 */
+};
+
+static struct resource irqc0_resources[] = {
+	DEFINE_RES_MEM(0xe61c0000, 0x200), /* IRQC Event Detector Block_0 */
+	DEFINE_RES_IRQ(gic_spi(0)), /* IRQ0 */
+	DEFINE_RES_IRQ(gic_spi(1)), /* IRQ1 */
+	DEFINE_RES_IRQ(gic_spi(2)), /* IRQ2 */
+	DEFINE_RES_IRQ(gic_spi(3)), /* IRQ3 */
+	DEFINE_RES_IRQ(gic_spi(12)), /* IRQ4 */
+	DEFINE_RES_IRQ(gic_spi(13)), /* IRQ5 */
+	DEFINE_RES_IRQ(gic_spi(14)), /* IRQ6 */
+	DEFINE_RES_IRQ(gic_spi(15)), /* IRQ7 */
+	DEFINE_RES_IRQ(gic_spi(16)), /* IRQ8 */
+	DEFINE_RES_IRQ(gic_spi(17)), /* IRQ9 */
+};
+
+#define r8a7791_register_irqc(idx)					\
+	platform_device_register_resndata(&platform_bus, "renesas_irqc", \
+					  idx, irqc##idx##_resources,	\
+					  ARRAY_SIZE(irqc##idx##_resources), \
+					  &irqc##idx##_data,		\
+					  sizeof(struct renesas_irqc_config))
+
 void __init r8a7791_add_dt_devices(void)
 {
 	r8a7791_register_scif(SCIFA0);
@@ -129,6 +155,12 @@ void __init r8a7791_add_dt_devices(void)
 	r8a7791_register_cmt(00);
 }
 
+void __init r8a7791_add_standard_devices(void)
+{
+	r8a7791_add_dt_devices();
+	r8a7791_register_irqc(0);
+}
+
 void __init r8a7791_init_early(void)
 {
 #ifndef CONFIG_ARM_ARCH_TIMER
