From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 15 Dec 2011 13:51:08 +0100
Subject: [PATCH 3/5] ux500: register DB5500 PMU dynamically
Message-ID: <1323953468-27121-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

Use platform_device_register_simple() rather than a static
struct, so we create and register the PMU device on-the-fly.

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/cpu-db5500.c |   41 ++++++++++++++++++-------------------
 1 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
index 5323286..18aa5c0 100644
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -46,26 +46,6 @@ static struct map_desc u5500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U5500_PRCMU_TCDM_BASE, SZ_4K),
 };
 
-static struct resource db5500_pmu_resources[] = {
-	[0] = {
-		.start		= IRQ_DB5500_PMU0,
-		.end		= IRQ_DB5500_PMU0,
-		.flags		= IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start		= IRQ_DB5500_PMU1,
-		.end		= IRQ_DB5500_PMU1,
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device db5500_pmu_device = {
-	.name			= "arm-pmu",
-	.id			= ARM_PMU_DEVICE_CPU,
-	.num_resources		= ARRAY_SIZE(db5500_pmu_resources),
-	.resource		= db5500_pmu_resources,
-};
-
 static struct resource mbox0_resources[] = {
 	{
 		.name = "mbox_peer",
@@ -151,7 +131,6 @@ static struct platform_device mbox2_device = {
 };
 
 static struct platform_device *db5500_platform_devs[] __initdata = {
-	&db5500_pmu_device,
 	&mbox0_device,
 	&mbox1_device,
 	&mbox2_device,
@@ -192,6 +171,25 @@ void __init u5500_map_io(void)
 	_PRCMU_BASE = __io_address(U5500_PRCMU_BASE);
 }
 
+static void __init db5500_pmu_init(void)
+{
+	struct resource res[] = {
+		[0] = {
+			.start		= IRQ_DB5500_PMU0,
+			.end		= IRQ_DB5500_PMU0,
+			.flags		= IORESOURCE_IRQ,
+		},
+		[1] = {
+			.start		= IRQ_DB5500_PMU1,
+			.end		= IRQ_DB5500_PMU1,
+			.flags		= IORESOURCE_IRQ,
+		},
+	};
+
+	platform_device_register_simple("arm-pmu", ARM_PMU_DEVICE_CPU,
+					res, ARRAY_SIZE(res));
+}
+
 static int usb_db5500_rx_dma_cfg[] = {
 	DB5500_DMA_DEV4_USB_OTG_IEP_1_9,
 	DB5500_DMA_DEV5_USB_OTG_IEP_2_10,
@@ -217,6 +215,7 @@ static int usb_db5500_tx_dma_cfg[] = {
 void __init u5500_init_devices(void)
 {
 	db5500_add_gpios();
+	db5500_pmu_init();
 	db5500_dma_init();
 	db5500_add_rtc();
 	db5500_add_usb(usb_db5500_rx_dma_cfg, usb_db5500_tx_dma_cfg);
-- 
1.7.3.2
