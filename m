From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 8 Feb 2011 09:24:37 +0530
Subject: [PATCHv2 2/2] ux500: DB8500 PMU support
In-Reply-To: <1297137277-26889-1-git-send-email-rabin.vincent@stericsson.com>
References: <1297137277-26889-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1297137277-26889-2-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DB8500 has irqs from two cores ORed into one.  Implement a workaround to handle
this by bouncing the interrupt by setting the affinity to the other core when
the interrupt appears to be spurious on the current core.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/cpu-db8500.c |   51 +++++++++++++++++++++++++++++++++++---
 1 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 706bc95..516126c 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -12,12 +12,14 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/amba/bus.h>
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
 #include <asm/mach/map.h>
+#include <asm/pmu.h>
 #include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
@@ -26,10 +28,6 @@
 #include "devices-db8500.h"
 #include "ste-dma40-db8500.h"
 
-static struct platform_device *platform_devs[] __initdata = {
-	&u8500_dma40_device,
-};
-
 /* minimum static i/o mapping required to boot U8500 platforms */
 static struct map_desc u8500_uart_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_UART0_BASE, SZ_4K),
@@ -91,6 +89,51 @@ void __init u8500_map_io(void)
 		iotable_init(u8500_v2_io_desc, ARRAY_SIZE(u8500_v2_io_desc));
 }
 
+static struct resource db8500_pmu_resources[] = {
+	[0] = {
+		.start		= IRQ_DB8500_PMU,
+		.end		= IRQ_DB8500_PMU,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+/*
+ * The PMU IRQ lines of two cores are wired together into a single interrupt.
+ * Bounce the interrupt to the other core if it's not ours.
+ */
+static irqreturn_t db8500_pmu_handler(int irq, void *dev, irq_handler_t handler)
+{
+	irqreturn_t ret = handler(irq, dev);
+	int other = !smp_processor_id();
+
+	if (ret == IRQ_NONE && cpu_online(other))
+		irq_set_affinity(irq, cpumask_of(other));
+
+	/*
+	 * We should be able to get away with the amount of IRQ_NONEs we give,
+	 * while still having the spurious IRQ detection code kick in if the
+	 * interrupt really starts hitting spuriously.
+	 */
+	return ret;
+}
+
+static struct arm_pmu_platdata db8500_pmu_platdata = {
+	.handle_irq		= db8500_pmu_handler,
+};
+
+static struct platform_device db8500_pmu_device = {
+	.name			= "arm-pmu",
+	.id			= ARM_PMU_DEVICE_CPU,
+	.num_resources		= ARRAY_SIZE(db8500_pmu_resources),
+	.resource		= db8500_pmu_resources,
+	.dev.platform_data	= &db8500_pmu_platdata,
+};
+
+static struct platform_device *platform_devs[] __initdata = {
+	&u8500_dma40_device,
+	&db8500_pmu_device,
+};
+
 static resource_size_t __initdata db8500_gpio_base[] = {
 	U8500_GPIOBANK0_BASE,
 	U8500_GPIOBANK1_BASE,
-- 
1.7.2.dirty
