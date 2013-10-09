From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:49:49 +0900
Subject: [PATCH 08/14] ARM: shmobile: r8a7791 IRQC platform device support
In-Reply-To: <cover.1381293239.git.horms+renesas@verge.net.au>
References: <cover.1381293239.git.horms+renesas@verge.net.au>
Message-ID: <454d320c80fa07c30267711fea08da0d24f28224.1381293239.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a platform device for the r8a7791 IRQC hardware
driving IRQ pins IRQ0 to IRQ9. The Linux interrupt
number is statically assigned to allow board code
written in C to make use of static interrupt numbers.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7791.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index 350dfc4..ba4fa3e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/irq-renesas-irqc.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <mach/common.h>
@@ -109,6 +110,31 @@ static const struct resource cmt00_resources[] __initconst = {
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
-- 
1.8.4
