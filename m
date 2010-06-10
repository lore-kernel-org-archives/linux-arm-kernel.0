From: benjamin.zores@alcatel-lucent.com (Benjamin Zores)
Date: Thu, 10 Jun 2010 15:59:51 +0200
Subject: [PATCH 4/4] arch/arm/mach-kirkwood: add support for 2nd TWSI
	controller on 88f6282.
In-Reply-To: <20100610135936.14097.22635.stgit@localhost.localdomain>
References: <20100610135936.14097.22635.stgit@localhost.localdomain>
Message-ID: <20100610135951.14097.48348.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Benjamin Zores <benjamin.zores@alcatel-lucent.com>
---
 arch/arm/mach-kirkwood/common.c                |   46 +++++++++++++++++++-----
 arch/arm/mach-kirkwood/include/mach/irqs.h     |    3 +-
 arch/arm/mach-kirkwood/include/mach/kirkwood.h |    3 +-
 3 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 473a1d0..93b7762 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -458,23 +458,45 @@ static struct mv64xxx_i2c_pdata kirkwood_i2c_pdata = {
 	.timeout	= 1000, /* Default timeout of 1 second */
 };
 
-static struct resource kirkwood_i2c_resources[] = {
+static struct resource kirkwood_i2c_0_resources[] = {
 	{
-		.start	= I2C_PHYS_BASE,
-		.end	= I2C_PHYS_BASE + 0x1f,
+		.start	= I2C_0_PHYS_BASE,
+		.end	= I2C_0_PHYS_BASE + 0x1f,
 		.flags	= IORESOURCE_MEM,
 	}, {
-		.start	= IRQ_KIRKWOOD_TWSI,
-		.end	= IRQ_KIRKWOOD_TWSI,
+		.start	= IRQ_KIRKWOOD_TWSI0,
+		.end	= IRQ_KIRKWOOD_TWSI0,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
 
-static struct platform_device kirkwood_i2c = {
+static struct resource kirkwood_i2c_1_resources[] = {
+	{
+		.start	= I2C_1_PHYS_BASE,
+		.end	= I2C_1_PHYS_BASE + 0x1f,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_KIRKWOOD_TWSI1,
+		.end	= IRQ_KIRKWOOD_TWSI1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device kirkwood_i2c_0 = {
 	.name		= MV64XXX_I2C_CTLR_NAME,
 	.id		= 0,
-	.num_resources	= ARRAY_SIZE(kirkwood_i2c_resources),
-	.resource	= kirkwood_i2c_resources,
+	.num_resources	= ARRAY_SIZE(kirkwood_i2c_0_resources),
+	.resource	= kirkwood_i2c_0_resources,
+	.dev		= {
+		.platform_data	= &kirkwood_i2c_pdata,
+	},
+};
+
+static struct platform_device kirkwood_i2c_1 = {
+	.name		= MV64XXX_I2C_CTLR_NAME,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(kirkwood_i2c_1_resources),
+	.resource	= kirkwood_i2c_1_resources,
 	.dev		= {
 		.platform_data	= &kirkwood_i2c_pdata,
 	},
@@ -482,7 +504,13 @@ static struct platform_device kirkwood_i2c = {
 
 void __init kirkwood_i2c_init(void)
 {
-	platform_device_register(&kirkwood_i2c);
+	u32 dev, rev;
+
+	kirkwood_pcie_id(&dev, &rev);
+
+	platform_device_register(&kirkwood_i2c_0);
+	if (dev == MV88F6282_DEV_ID && (rev == MV88F6282_REV_A0))
+	  platform_device_register(&kirkwood_i2c_1);
 }
 
 
diff --git a/arch/arm/mach-kirkwood/include/mach/irqs.h b/arch/arm/mach-kirkwood/include/mach/irqs.h
index 9da2eb5..d82ecf0 100644
--- a/arch/arm/mach-kirkwood/include/mach/irqs.h
+++ b/arch/arm/mach-kirkwood/include/mach/irqs.h
@@ -33,13 +33,14 @@
 #define IRQ_KIRKWOOD_I2S	24
 #define IRQ_KIRKWOOD_TS_0	26
 #define IRQ_KIRKWOOD_SDIO	28
-#define IRQ_KIRKWOOD_TWSI	29
+#define IRQ_KIRKWOOD_TWSI0	29
 #define IRQ_KIRKWOOD_AVB	30
 #define IRQ_KIRKWOOD_TDMI	31
 
 /*
  * High Interrupt Controller
  */
+#define IRQ_KIRKWOOD_TWSI1	32
 #define IRQ_KIRKWOOD_UART_0	33
 #define IRQ_KIRKWOOD_UART_1	34
 #define IRQ_KIRKWOOD_GPIO_LOW_0_7	35
diff --git a/arch/arm/mach-kirkwood/include/mach/kirkwood.h b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
index 7f0b50a..b2f2f5d 100644
--- a/arch/arm/mach-kirkwood/include/mach/kirkwood.h
+++ b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
@@ -68,7 +68,8 @@
 #define  DEVICE_ID		(DEV_BUS_VIRT_BASE | 0x0034)
 #define  RTC_PHYS_BASE		(DEV_BUS_PHYS_BASE | 0x0300)
 #define  SPI_PHYS_BASE		(DEV_BUS_PHYS_BASE | 0x0600)
-#define  I2C_PHYS_BASE		(DEV_BUS_PHYS_BASE | 0x1000)
+#define  I2C_0_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x1000)
+#define  I2C_1_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x1100)
 #define  UART0_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x2000)
 #define  UART0_VIRT_BASE	(DEV_BUS_VIRT_BASE | 0x2000)
 #define  UART1_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x2100)
