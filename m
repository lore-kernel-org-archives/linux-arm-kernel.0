From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Dec 2013 18:25:12 +0100
Subject: [PATCH 1/5] ARM: versatile: move GPIO2 and GPIO3 to core
Message-ID: <1387560312-21425-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move GPIO2 and GPIO3 to be registered from the core as this is
certainly available on Versatile AB as well, not just the PB.
GPIO2 is used for reading board status and GPIO3 is unused,
but it does not hurt to register it anyway.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-versatile/core.c         | 16 ++++++++++++++++
 arch/arm/mach-versatile/versatile_pb.c | 21 ---------------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 3b0572f30d56..a335126ae18f 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -570,6 +570,16 @@ static struct pl061_platform_data gpio1_plat_data = {
 	.irq_base	= IRQ_GPIO1_START,
 };
 
+static struct pl061_platform_data gpio2_plat_data = {
+	.gpio_base	= 16,
+	.irq_base	= IRQ_GPIO2_START,
+};
+
+static struct pl061_platform_data gpio3_plat_data = {
+	.gpio_base	= 24,
+	.irq_base	= IRQ_GPIO3_START,
+};
+
 static struct pl022_ssp_controller ssp0_plat_data = {
 	.bus_id = 0,
 	.enable_dma = 0,
@@ -596,6 +606,8 @@ static struct pl022_ssp_controller ssp0_plat_data = {
 #define WATCHDOG_IRQ	{ IRQ_WDOGINT }
 #define GPIO0_IRQ	{ IRQ_GPIOINT0 }
 #define GPIO1_IRQ	{ IRQ_GPIOINT1 }
+#define GPIO2_IRQ	{ IRQ_GPIOINT2 }
+#define GPIO3_IRQ	{ IRQ_GPIOINT3 }
 #define RTC_IRQ		{ IRQ_RTCINT }
 
 /*
@@ -622,6 +634,8 @@ APB_DEVICE(sctl,  "dev:e0",  SCTL,     NULL);
 APB_DEVICE(wdog,  "dev:e1",  WATCHDOG, NULL);
 APB_DEVICE(gpio0, "dev:e4",  GPIO0,    &gpio0_plat_data);
 APB_DEVICE(gpio1, "dev:e5",  GPIO1,    &gpio1_plat_data);
+APB_DEVICE(gpio2, "dev:e6",  GPIO2,    &gpio2_plat_data);
+APB_DEVICE(gpio3, "dev:e7",  GPIO3,    &gpio3_plat_data);
 APB_DEVICE(rtc,   "dev:e8",  RTC,      NULL);
 APB_DEVICE(sci0,  "dev:f0",  SCI,      NULL);
 APB_DEVICE(uart0, "dev:f1",  UART0,    NULL);
@@ -641,6 +655,8 @@ static struct amba_device *amba_devs[] __initdata = {
 	&wdog_device,
 	&gpio0_device,
 	&gpio1_device,
+	&gpio2_device,
+	&gpio3_device,
 	&rtc_device,
 	&sci0_device,
 	&ssp0_device,
diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
index 611d140c8695..9a53d0bd9144 100644
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ b/arch/arm/mach-versatile/versatile_pb.c
@@ -47,27 +47,11 @@ static struct mmci_platform_data mmc1_plat_data = {
 	.gpio_cd	= -1,
 };
 
-static struct pl061_platform_data gpio2_plat_data = {
-	.gpio_base	= 16,
-	.irq_base	= IRQ_GPIO2_START,
-};
-
-static struct pl061_platform_data gpio3_plat_data = {
-	.gpio_base	= 24,
-	.irq_base	= IRQ_GPIO3_START,
-};
-
 #define UART3_IRQ	{ IRQ_SIC_UART3 }
 #define SCI1_IRQ	{ IRQ_SIC_SCI3 }
 #define MMCI1_IRQ	{ IRQ_MMCI1A, IRQ_SIC_MMCI1B }
 
 /*
- * These devices are connected via the core APB bridge
- */
-#define GPIO2_IRQ	{ IRQ_GPIOINT2 }
-#define GPIO3_IRQ	{ IRQ_GPIOINT3 }
-
-/*
  * These devices are connected via the DMA APB bridge
  */
 
@@ -76,14 +60,9 @@ APB_DEVICE(uart3, "fpga:09", UART3,    NULL);
 APB_DEVICE(sci1,  "fpga:0a", SCI1,     NULL);
 APB_DEVICE(mmc1,  "fpga:0b", MMCI1,    &mmc1_plat_data);
 
-/* DevChip Primecells */
-APB_DEVICE(gpio2, "dev:e6",  GPIO2,    &gpio2_plat_data);
-APB_DEVICE(gpio3, "dev:e7",  GPIO3,    &gpio3_plat_data);
 
 static struct amba_device *amba_devs[] __initdata = {
 	&uart3_device,
-	&gpio2_device,
-	&gpio3_device,
 	&sci1_device,
 	&mmc1_device,
 };
-- 
1.8.3.1
