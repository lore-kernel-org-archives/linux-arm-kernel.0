From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:06:59 +0900
Subject: [PATCH 03/30] ARM: shmobile: r8a73a4 IRQC support V2
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add IRQC interrupt controller support to r8a73a4 by
hooking up two IRQC instances to handle 58 external
IRQ signals. There IRQC controllers are tied to SPIs
of the GIC. On r8a73a4 exact IRQ pin routing is handled
by the PFC which is excluded from this patch.

Both platform devices and DT devices are added in this
patch. The platform device versions are used to provide
a static interrupt map configuration for board code
written in C.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi         |   32 ++++++++++++
 arch/arm/mach-shmobile/Kconfig         |    1 +
 arch/arm/mach-shmobile/setup-r8a73a4.c |   84 ++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 72c58c1..4c68ba1 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -52,4 +52,36 @@
 				<1 11 0xf08>,
 				<1 10 0xf08>;
 	};
+
+	irqc0: interrupt-controller at e61c0000 {
+		compatible = "renesas,irqc";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xe61c0000 0x200>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 0 4>, <0 1 4>, <0 2 4>,	<0 3 4>,
+				<0 4 4>, <0 5 4>, <0 6 4>, <0 7 4>,
+				<0 8 4>, <0 9 4>, <0 10 4>, <0 11 4>,
+				<0 12 4>, <0 13 4>, <0 14 4>, <0 15 4>,
+				<0 16 4>, <0 17 4>, <0 18 4>, <0 19 4>,
+				<0 20 4>, <0 21 4>, <0 22 4>, <0 23 4>,
+				<0 24 4>, <0 25 4>, <0 26 4>, <0 27 4>,
+				<0 28 4>, <0 29 4>, <0 30 4>, <0 31 4>;
+	};
+
+	irqc1: interrupt-controller at e61c0200 {
+		compatible = "renesas,irqc";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xe61c0200 0x200>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 32 4>, <0 33 4>, <0 34 4>, <0 35 4>,
+				<0 36 4>, <0 37 4>, <0 38 4>, <0 39 4>,
+				<0 40 4>, <0 41 4>, <0 42 4>, <0 43 4>,
+				<0 44 4>, <0 45 4>, <0 46 4>, <0 47 4>,
+				<0 48 4>, <0 49 4>, <0 50 4>, <0 51 4>,
+				<0 52 4>, <0 53 4>, <0 54 4>, <0 55 4>,
+				<0 56 4>, <0 57 4>;
+	};
+
 };
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 663d27b..17a59cd 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -24,6 +24,7 @@ config ARCH_R8A73A4
 	select CPU_V7
 	select ARM_ARCH_TIMER
 	select SH_CLK_CPG
+	select RENESAS_IRQC
 
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 746a3dc..da5ae16 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -21,6 +21,7 @@
 #include <linux/irqchip.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/irq-renesas-irqc.h>
 #include <linux/serial_sci.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
@@ -63,6 +64,87 @@ static inline void r8a73a4_register_scif(int idx)
 				      sizeof(struct plat_sci_port));
 }
 
+static const struct renesas_irqc_config irqc0_data = {
+	.irq_base = irq_pin(0), /* IRQ0 -> IRQ31 */
+};
+
+static const struct resource irqc0_resources[] = {
+	DEFINE_RES_MEM(0xe61c0000, 0x200), /* IRQC Event Detector Block_0 */
+	DEFINE_RES_IRQ(gic_spi(0)), /* IRQ0 */
+	DEFINE_RES_IRQ(gic_spi(1)), /* IRQ1 */
+	DEFINE_RES_IRQ(gic_spi(2)), /* IRQ2 */
+	DEFINE_RES_IRQ(gic_spi(3)), /* IRQ3 */
+	DEFINE_RES_IRQ(gic_spi(4)), /* IRQ4 */
+	DEFINE_RES_IRQ(gic_spi(5)), /* IRQ5 */
+	DEFINE_RES_IRQ(gic_spi(6)), /* IRQ6 */
+	DEFINE_RES_IRQ(gic_spi(7)), /* IRQ7 */
+	DEFINE_RES_IRQ(gic_spi(8)), /* IRQ8 */
+	DEFINE_RES_IRQ(gic_spi(9)), /* IRQ9 */
+	DEFINE_RES_IRQ(gic_spi(10)), /* IRQ10 */
+	DEFINE_RES_IRQ(gic_spi(11)), /* IRQ11 */
+	DEFINE_RES_IRQ(gic_spi(12)), /* IRQ12 */
+	DEFINE_RES_IRQ(gic_spi(13)), /* IRQ13 */
+	DEFINE_RES_IRQ(gic_spi(14)), /* IRQ14 */
+	DEFINE_RES_IRQ(gic_spi(15)), /* IRQ15 */
+	DEFINE_RES_IRQ(gic_spi(16)), /* IRQ16 */
+	DEFINE_RES_IRQ(gic_spi(17)), /* IRQ17 */
+	DEFINE_RES_IRQ(gic_spi(18)), /* IRQ18 */
+	DEFINE_RES_IRQ(gic_spi(19)), /* IRQ19 */
+	DEFINE_RES_IRQ(gic_spi(20)), /* IRQ20 */
+	DEFINE_RES_IRQ(gic_spi(21)), /* IRQ21 */
+	DEFINE_RES_IRQ(gic_spi(22)), /* IRQ22 */
+	DEFINE_RES_IRQ(gic_spi(23)), /* IRQ23 */
+	DEFINE_RES_IRQ(gic_spi(24)), /* IRQ24 */
+	DEFINE_RES_IRQ(gic_spi(25)), /* IRQ25 */
+	DEFINE_RES_IRQ(gic_spi(26)), /* IRQ26 */
+	DEFINE_RES_IRQ(gic_spi(27)), /* IRQ27 */
+	DEFINE_RES_IRQ(gic_spi(28)), /* IRQ28 */
+	DEFINE_RES_IRQ(gic_spi(29)), /* IRQ29 */
+	DEFINE_RES_IRQ(gic_spi(30)), /* IRQ30 */
+	DEFINE_RES_IRQ(gic_spi(31)), /* IRQ31 */
+};
+
+static const struct renesas_irqc_config irqc1_data = {
+	.irq_base = irq_pin(32), /* IRQ32 -> IRQ57 */
+};
+
+static const struct resource irqc1_resources[] = {
+	DEFINE_RES_MEM(0xe61c0200, 0x200), /* IRQC Event Detector Block_1 */
+	DEFINE_RES_IRQ(gic_spi(32)), /* IRQ32 */
+	DEFINE_RES_IRQ(gic_spi(33)), /* IRQ33 */
+	DEFINE_RES_IRQ(gic_spi(34)), /* IRQ34 */
+	DEFINE_RES_IRQ(gic_spi(35)), /* IRQ35 */
+	DEFINE_RES_IRQ(gic_spi(36)), /* IRQ36 */
+	DEFINE_RES_IRQ(gic_spi(37)), /* IRQ37 */
+	DEFINE_RES_IRQ(gic_spi(38)), /* IRQ38 */
+	DEFINE_RES_IRQ(gic_spi(39)), /* IRQ39 */
+	DEFINE_RES_IRQ(gic_spi(40)), /* IRQ40 */
+	DEFINE_RES_IRQ(gic_spi(41)), /* IRQ41 */
+	DEFINE_RES_IRQ(gic_spi(42)), /* IRQ42 */
+	DEFINE_RES_IRQ(gic_spi(43)), /* IRQ43 */
+	DEFINE_RES_IRQ(gic_spi(44)), /* IRQ44 */
+	DEFINE_RES_IRQ(gic_spi(45)), /* IRQ45 */
+	DEFINE_RES_IRQ(gic_spi(46)), /* IRQ46 */
+	DEFINE_RES_IRQ(gic_spi(47)), /* IRQ47 */
+	DEFINE_RES_IRQ(gic_spi(48)), /* IRQ48 */
+	DEFINE_RES_IRQ(gic_spi(49)), /* IRQ49 */
+	DEFINE_RES_IRQ(gic_spi(50)), /* IRQ50 */
+	DEFINE_RES_IRQ(gic_spi(51)), /* IRQ51 */
+	DEFINE_RES_IRQ(gic_spi(52)), /* IRQ52 */
+	DEFINE_RES_IRQ(gic_spi(53)), /* IRQ53 */
+	DEFINE_RES_IRQ(gic_spi(54)), /* IRQ54 */
+	DEFINE_RES_IRQ(gic_spi(55)), /* IRQ55 */
+	DEFINE_RES_IRQ(gic_spi(56)), /* IRQ56 */
+	DEFINE_RES_IRQ(gic_spi(57)), /* IRQ57 */
+};
+
+#define r8a73a4_register_irqc(idx)					\
+	platform_device_register_resndata(&platform_bus, "renesas_irqc", \
+					  idx, irqc##idx##_resources,	\
+					  ARRAY_SIZE(irqc##idx##_resources), \
+					  &irqc##idx##_data,		\
+					  sizeof(struct renesas_irqc_config))
+
 void __init r8a73a4_add_standard_devices(void)
 {
 	r8a73a4_register_scif(SCIFA0);
@@ -71,6 +153,8 @@ void __init r8a73a4_add_standard_devices(void)
 	r8a73a4_register_scif(SCIFB1);
 	r8a73a4_register_scif(SCIFB2);
 	r8a73a4_register_scif(SCIFB3);
+	r8a73a4_register_irqc(0);
+	r8a73a4_register_irqc(1);
 }
 
 #ifdef CONFIG_USE_OF
-- 
1.7.10.4
