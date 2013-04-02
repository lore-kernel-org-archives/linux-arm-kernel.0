From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:23 +0900
Subject: [PATCH 27/30] ARM: shmobile: r8a7790 IRQC support
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-28-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add IRQC interrupt controller support to r8a7790 by
hooking up a single IRQC instances to handle 4 external
IRQ signals. The IRQC controller is tied to SPIs of
the GIC. On r8a7790 the external IRQ pins routing is
handled by the PFC which is excluded from this patch.

Both platform devices and DT devices are added in this
patch. The platform device versions are used to provide
a static interrupt map configuration for board code
written in C.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi         |    9 +++++++++
 arch/arm/mach-shmobile/Kconfig         |    1 +
 arch/arm/mach-shmobile/setup-r8a7790.c |   21 +++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 1c58ffb..a1e0e0c 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -51,4 +51,13 @@
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
+		interrupts = <0 0 4>, <0 1 4>, <0 2 4>,	<0 3 4>;
+	};
 };
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 749dfb4..ccaea6a 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -57,6 +57,7 @@ config ARCH_R8A7790
 	select CPU_V7
 	select ARM_ARCH_TIMER
 	select SH_CLK_CPG
+	select RENESAS_IRQC
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 3bb5bf1..9b4ccd7 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/serial_sci.h>
+#include <linux/platform_data/irq-renesas-irqc.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a7790.h>
@@ -74,6 +75,25 @@ static inline void r8a7790_register_scif(int idx)
 				      sizeof(struct plat_sci_port));
 }
 
+static struct renesas_irqc_config irqc0_data = {
+	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
+};
+
+static struct resource irqc0_resources[] = {
+	DEFINE_RES_MEM(0xe61c0000, 0x200), /* IRQC Event Detector Block_0 */
+	DEFINE_RES_IRQ(gic_spi(0)), /* IRQ0 */
+	DEFINE_RES_IRQ(gic_spi(1)), /* IRQ1 */
+	DEFINE_RES_IRQ(gic_spi(2)), /* IRQ2 */
+	DEFINE_RES_IRQ(gic_spi(3)), /* IRQ3 */
+};
+
+#define r8a7790_register_irqc(idx)					\
+	platform_device_register_resndata(&platform_bus, "renesas_irqc", \
+					  idx, irqc##idx##_resources,	\
+					  ARRAY_SIZE(irqc##idx##_resources), \
+					  &irqc##idx##_data,		\
+					  sizeof(struct renesas_irqc_config))
+
 void __init r8a7790_add_standard_devices(void)
 {
 	r8a7790_register_scif(SCIFA0);
@@ -84,6 +104,7 @@ void __init r8a7790_add_standard_devices(void)
 	r8a7790_register_scif(SCIFA2);
 	r8a7790_register_scif(SCIF0);
 	r8a7790_register_scif(SCIF1);
+	r8a7790_register_irqc(0);
 }
 
 #ifdef CONFIG_USE_OF
-- 
1.7.10.4
