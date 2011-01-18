From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 18 Jan 2011 23:59:39 +0100
Subject: [PATCH] RFC: ux500: add PMU resources
Message-ID: <1295391579-9166-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ux500 SoCs have PMUs, both DB8500 and DB5500. However on the
DB8500 the individual per-core IRQs are not routed: instead they
are OR:ed into one single IRQ.

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
Hi Will especially, I remember discussing this issue with you
back in Florida. IIRC you had some idea on how to go about with
this, like we add some tweak for this board where we don't set
affinity and let the IRQ be declared chained and then each CPU
it's not coming from has to NACK it, do you think it is
feasible and could you sort of point me into the right files
to poke at?
---
 arch/arm/mach-ux500/cpu-db5500.c |   26 ++++++++++++++++++++++++--
 arch/arm/mach-ux500/cpu-db8500.c |   28 ++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
index af04e08..3912354 100644
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -11,6 +11,7 @@
 #include <linux/irq.h>
 
 #include <asm/mach/map.h>
+#include <asm/pmu.h>
 
 #include <plat/gpio.h>
 
@@ -43,6 +44,26 @@ static struct map_desc u5500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U5500_PRCMU_BASE, SZ_4K),
 };
 
+static struct resource db5500_pmu_resources[] = {
+	[0] = {
+		.start		= IRQ_DB5500_PMU0,
+		.end		= IRQ_DB5500_PMU0,
+		.flags		= IORESOURCE_IRQ,
+	},
+	[1] = {
+		.start		= IRQ_DB5500_PMU1,
+		.end		= IRQ_DB5500_PMU1,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device db5500_pmu_device = {
+	.name			= "arm-pmu",
+	.id			= ARM_PMU_DEVICE_CPU,
+	.num_resources		= ARRAY_SIZE(db5500_pmu_resources),
+	.resource		= db5500_pmu_resources,
+};
+
 static struct resource mbox0_resources[] = {
 	{
 		.name = "mbox_peer",
@@ -127,7 +148,8 @@ static struct platform_device mbox2_device = {
 	.num_resources = ARRAY_SIZE(mbox2_resources),
 };
 
-static struct platform_device *u5500_platform_devs[] __initdata = {
+static struct platform_device *db5500_platform_devs[] __initdata = {
+	&db5500_pmu_device,
 	&mbox0_device,
 	&mbox1_device,
 	&mbox2_device,
@@ -172,6 +194,6 @@ void __init u5500_init_devices(void)
 	db5500_dma_init();
 	db5500_add_rtc();
 
-	platform_add_devices(u5500_platform_devs,
+	platform_add_devices(db5500_platform_devs,
 			     ARRAY_SIZE(u5500_platform_devs));
 }
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 1748fbc..a49641c 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 
 #include <asm/mach/map.h>
+#include <asm/pmu.h>
 #include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
@@ -112,6 +113,31 @@ static void __init db8500_add_gpios(void)
 }
 
 /*
+ * The DB8500 PMU has only one IRQ line which is the OR:ed result
+ * from both CPU cores. This means that currently kernel measurements
+ * such as done with perf can onlt be done by locking the subject
+ * task to CPU0.
+ */
+static struct resource db8500_pmu_resources[] = {
+	[0] = {
+		.start		= IRQ_DB8500_PMU,
+		.end		= IRQ_DB8500_PMU,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device db8500_pmu_device = {
+	.name			= "arm-pmu",
+	.id			= ARM_PMU_DEVICE_CPU,
+	.num_resources		= ARRAY_SIZE(db8500_pmu_resources),
+	.resource		= db8500_pmu_resources,
+};
+
+static struct platform_device *db8500_platform_devs[] __initdata = {
+	&db8500_pmu_device,
+};
+
+/*
  * This function is called from the board init
  */
 void __init u8500_init_devices(void)
@@ -121,6 +147,8 @@ void __init u8500_init_devices(void)
 
 	db8500_add_rtc();
 	db8500_add_gpios();
+	platform_add_devices(db8500_platform_devs,
+			     ARRAY_SIZE(db8500_platform_devs));
 
 	platform_device_register_simple("cpufreq-u8500", -1, NULL, 0);
 	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
-- 
1.7.3.2
