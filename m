From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 27 Apr 2010 09:46:46 +0530
Subject: [PATCH 08/14] ux500: move UART devices to devices.c
In-Reply-To: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272341812-4622-9-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The three PL011 UARTs are common among Ux500 SoCs, so move them to
devices.c.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c         |   28 +++-------------------------
 arch/arm/mach-ux500/devices.c              |   21 +++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/devices.h |    3 +++
 3 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 6bb9a3d..0e595bf 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -26,28 +26,6 @@
 #include <mach/setup.h>
 #include <mach/devices.h>
 
-#define __MEM_4K_RESOURCE(x) \
-	.res = {.start = (x), .end = (x) + SZ_4K - 1, .flags = IORESOURCE_MEM}
-
-/* These are active devices on this board */
-static struct amba_device uart0_device = {
-	.dev = { .init_name = "uart0" },
-	__MEM_4K_RESOURCE(U8500_UART0_BASE),
-	.irq = {IRQ_UART0, NO_IRQ},
-};
-
-static struct amba_device uart1_device = {
-	.dev = { .init_name = "uart1" },
-	__MEM_4K_RESOURCE(U8500_UART1_BASE),
-	.irq = {IRQ_UART1, NO_IRQ},
-};
-
-static struct amba_device uart2_device = {
-	.dev = { .init_name = "uart2" },
-	__MEM_4K_RESOURCE(U8500_UART2_BASE),
-	.irq = {IRQ_UART2, NO_IRQ},
-};
-
 static void ab4500_spi_cs_control(u32 command)
 {
 	/* set the FRM signal, which is CS  - TODO */
@@ -157,9 +135,9 @@ U8500_I2C_PDEVICE(2);
 U8500_I2C_PDEVICE(3);
 
 static struct amba_device *amba_devs[] __initdata = {
-	&uart0_device,
-	&uart1_device,
-	&uart2_device,
+	&ux500_uart0_device,
+	&ux500_uart1_device,
+	&ux500_uart2_device,
 	&u8500_ssp0_device,
 };
 
diff --git a/arch/arm/mach-ux500/devices.c b/arch/arm/mach-ux500/devices.c
index eef686a..374fcce 100644
--- a/arch/arm/mach-ux500/devices.c
+++ b/arch/arm/mach-ux500/devices.c
@@ -14,6 +14,9 @@
 #include <mach/hardware.h>
 #include <mach/setup.h>
 
+#define __MEM_4K_RESOURCE(x) \
+	.res = {.start = (x), .end = (x) + SZ_4K - 1, .flags = IORESOURCE_MEM}
+
 struct amba_device ux500_pl031_device = {
 	.dev = {
 		.init_name = "pl031",
@@ -26,6 +29,24 @@ struct amba_device ux500_pl031_device = {
 	.irq = {IRQ_RTC_RTT, NO_IRQ},
 };
 
+struct amba_device ux500_uart0_device = {
+	.dev = { .init_name = "uart0" },
+	__MEM_4K_RESOURCE(UX500_UART0_BASE),
+	.irq = {IRQ_UART0, NO_IRQ},
+};
+
+struct amba_device ux500_uart1_device = {
+	.dev = { .init_name = "uart1" },
+	__MEM_4K_RESOURCE(UX500_UART1_BASE),
+	.irq = {IRQ_UART1, NO_IRQ},
+};
+
+struct amba_device ux500_uart2_device = {
+	.dev = { .init_name = "uart2" },
+	__MEM_4K_RESOURCE(UX500_UART2_BASE),
+	.irq = {IRQ_UART2, NO_IRQ},
+};
+
 void __init amba_add_devices(struct amba_device *devs[], int num)
 {
 	int i;
diff --git a/arch/arm/mach-ux500/include/mach/devices.h b/arch/arm/mach-ux500/include/mach/devices.h
index 90229b1..7cc4983 100644
--- a/arch/arm/mach-ux500/include/mach/devices.h
+++ b/arch/arm/mach-ux500/include/mach/devices.h
@@ -12,5 +12,8 @@ struct amba_device;
 
 extern struct amba_device ux500_pl031_device;
 extern struct amba_device u8500_ssp0_device;
+extern struct amba_device ux500_uart0_device;
+extern struct amba_device ux500_uart1_device;
+extern struct amba_device ux500_uart2_device;
 
 #endif
-- 
1.7.0
