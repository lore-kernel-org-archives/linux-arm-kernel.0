From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 01 Oct 2013 17:12:19 +0900
Subject: [PATCH 03/10] ARM: shmobile: r8a7791 IRQC platform device support
In-Reply-To: <20131001081143.4136.46925.sendpatchset@w520>
References: <20131001081143.4136.46925.sendpatchset@w520>
Message-ID: <20131001081219.4136.26850.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a platform device for the r8a7791 IRQC hardware
driving IRQ pins IRQ0 to IRQ9. The Linux interrupt
number is statically assigned to allow board code
written in C to make use of static interrupt numbers.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7791.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- 0002/arch/arm/mach-shmobile/setup-r8a7791.c
+++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2013-10-01 16:45:32.000000000 +0900
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
@@ -132,6 +158,7 @@ void __init r8a7791_add_dt_devices(void)
 void __init r8a7791_add_standard_devices(void)
 {
 	r8a7791_add_dt_devices();
+	r8a7791_register_irqc(0);
 }
 
 void __init r8a7791_init_early(void)
