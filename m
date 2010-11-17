From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:29:32 +0100
Subject: [PATCH 04/51] ARM: imx: remove last explicit users of virtual base
	address defines
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows changing the mapping without the need to adapt all users.

While at it remove some unneeded casts to void __iomem *, this is already
taken care for in the IO_ADDRESS macros

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/devices.c           |    8 ++++----
 arch/arm/mach-mx25/devices.c          |    8 ++++----
 arch/arm/mach-mx25/mm.c               |    2 +-
 arch/arm/plat-mxc/include/mach/mx25.h |    9 ++++-----
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-imx/devices.c b/arch/arm/mach-imx/devices.c
index fba5047..e69e46e 100644
--- a/arch/arm/mach-imx/devices.c
+++ b/arch/arm/mach-imx/devices.c
@@ -159,22 +159,22 @@ struct platform_device imx_usb_device = {
 static struct mxc_gpio_port imx_gpio_ports[] = {
 	{
 		.chip.label = "gpio-0",
-		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR),
+		.base = MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR),
 		.irq = MX1_GPIO_INT_PORTA,
 		.virtual_irq_start = MXC_GPIO_IRQ_START,
 	}, {
 		.chip.label = "gpio-1",
-		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x100),
+		.base = MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x100),
 		.irq = MX1_GPIO_INT_PORTB,
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 32,
 	}, {
 		.chip.label = "gpio-2",
-		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x200),
+		.base = MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x200),
 		.irq = MX1_GPIO_INT_PORTC,
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 64,
 	}, {
 		.chip.label = "gpio-3",
-		.base = (void __iomem *)MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x300),
+		.base = MX1_IO_ADDRESS(MX1_GPIO_BASE_ADDR + 0x300),
 		.irq = MX1_GPIO_INT_PORTD,
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 96,
 	}
diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 1d0eb3e..92eb1a9 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -182,22 +182,22 @@ struct platform_device mxc_pwm_device3 = {
 static struct mxc_gpio_port imx_gpio_ports[] = {
 	{
 		.chip.label = "gpio-0",
-		.base = (void __iomem *)MX25_GPIO1_BASE_ADDR_VIRT,
+		.base = MX25_IO_ADDRESS(MX25_GPIO1_BASE_ADDR),
 		.irq = 52,
 		.virtual_irq_start = MXC_GPIO_IRQ_START,
 	}, {
 		.chip.label = "gpio-1",
-		.base = (void __iomem *)MX25_GPIO2_BASE_ADDR_VIRT,
+		.base = MX25_IO_ADDRESS(MX25_GPIO2_BASE_ADDR),
 		.irq = 51,
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 32,
 	}, {
 		.chip.label = "gpio-2",
-		.base = (void __iomem *)MX25_GPIO3_BASE_ADDR_VIRT,
+		.base = MX25_IO_ADDRESS(MX25_GPIO3_BASE_ADDR),
 		.irq = 16,
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 64,
 	}, {
 		.chip.label = "gpio-3",
-		.base = (void __iomem *)MX25_GPIO4_BASE_ADDR_VIRT,
+		.base = MX25_IO_ADDRESS(MX25_GPIO4_BASE_ADDR),
 		.irq = 23,
 		.virtual_irq_start = MXC_GPIO_IRQ_START + 96,
 	}
diff --git a/arch/arm/mach-mx25/mm.c b/arch/arm/mach-mx25/mm.c
index 11cd335..2edec6c 100644
--- a/arch/arm/mach-mx25/mm.c
+++ b/arch/arm/mach-mx25/mm.c
@@ -56,7 +56,7 @@ int imx25_register_gpios(void);
 
 void __init mx25_init_irq(void)
 {
-	mxc_init_irq((void __iomem *)MX25_AVIC_BASE_ADDR_VIRT);
+	mxc_init_irq(MX25_IO_ADDRESS(MX25_AVIC_BASE_ADDR));
 	imx25_register_gpios();
 }
 
diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 6f9e1d4..08b5a3a 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -21,13 +21,12 @@
 
 #define MX25_CRM_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0x80000)
 #define MX25_GPT1_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0x90000)
+#define MX25_GPIO4_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0x9c000)
+#define MX25_GPIO3_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xa4000)
+#define MX25_GPIO1_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xcc000)
+#define MX25_GPIO2_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xd0000)
 #define MX25_WDOG_BASE_ADDR		(MX25_AIPS2_BASE_ADDR + 0xdc000)
 
-#define MX25_GPIO1_BASE_ADDR_VIRT	(MX25_AIPS2_BASE_ADDR_VIRT + 0xcc000)
-#define MX25_GPIO2_BASE_ADDR_VIRT	(MX25_AIPS2_BASE_ADDR_VIRT + 0xd0000)
-#define MX25_GPIO3_BASE_ADDR_VIRT	(MX25_AIPS2_BASE_ADDR_VIRT + 0xa4000)
-#define MX25_GPIO4_BASE_ADDR_VIRT	(MX25_AIPS2_BASE_ADDR_VIRT + 0x9c000)
-
 #define MX25_IO_P2V(x)	(					\
 	IMX_IO_P2V_MODULE(x, MX25_AIPS1) ?:			\
 	IMX_IO_P2V_MODULE(x, MX25_AIPS2) ?:			\
-- 
1.7.2.3
