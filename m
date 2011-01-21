From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 21 Jan 2011 09:21:26 +0100
Subject: [PATCH] ux500: add DB5500 PMU resources
Message-ID: <1295598086-23672-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the PMU resources necessary to get perf working with
the DB5500 ASIC.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
Reduced version not including the problematic DB8500 PMU, picking
some low-hanging fruit...
---
 arch/arm/mach-ux500/cpu-db5500.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

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
-- 
1.7.3.2
