From: benjamin.zores@alcatel-lucent.com (Benjamin Zores)
Date: Thu, 17 Jun 2010 09:59:14 +0200
Subject: [PATCH 4/4] arch/arm/mach-kirkwood: add support for 2nd TWSI
	controller on 88f6282.
In-Reply-To: <20100617075711.15387.69398.stgit@localhost.localdomain>
References: <20100617075711.15387.69398.stgit@localhost.localdomain>
Message-ID: <20100617075914.15387.91307.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Benjamin Zores <benjamin.zores@alcatel-lucent.com>
---
 arch/arm/mach-kirkwood/common.c                |   52 +++++++++++++++++++-----
 arch/arm/mach-kirkwood/common.h                |    5 ++
 arch/arm/mach-kirkwood/include/mach/irqs.h     |    3 +
 arch/arm/mach-kirkwood/include/mach/kirkwood.h |    3 +
 arch/arm/mach-kirkwood/netspace_v2-setup.c     |    2 -
 arch/arm/mach-kirkwood/netxbig_v2-setup.c      |    2 -
 arch/arm/mach-kirkwood/openrd-setup.c          |    2 -
 arch/arm/mach-kirkwood/ts219-setup.c           |    2 -
 arch/arm/mach-kirkwood/ts41x-setup.c           |    2 -
 9 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 10592ae..8382a56 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -458,31 +458,63 @@ static struct mv64xxx_i2c_pdata kirkwood_i2c_pdata = {
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
+	.name		= MV64XXX_I2C_CTLR_NAME,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(kirkwood_i2c_0_resources),
+	.resource	= kirkwood_i2c_0_resources,
+	.dev		= {
+		.platform_data	= &kirkwood_i2c_pdata,
+	},
+};
+
+static struct platform_device kirkwood_i2c_1 = {
 	.name		= MV64XXX_I2C_CTLR_NAME,
 	.id		= 0,
-	.num_resources	= ARRAY_SIZE(kirkwood_i2c_resources),
-	.resource	= kirkwood_i2c_resources,
+	.num_resources	= ARRAY_SIZE(kirkwood_i2c_1_resources),
+	.resource	= kirkwood_i2c_1_resources,
 	.dev		= {
 		.platform_data	= &kirkwood_i2c_pdata,
 	},
 };
 
-void __init kirkwood_i2c_init(void)
+void __init kirkwood_i2c_init(unsigned int mask)
 {
-	platform_device_register(&kirkwood_i2c);
+	if (mask & KW_TWSI0)
+		platform_device_register(&kirkwood_i2c_0);
+
+	if (mask & KW_TWSI1) {
+		u32 dev, rev;
+
+		kirkwood_pcie_id(&dev, &rev);
+
+		if (dev == MV88F6282_DEV_ID && (rev == MV88F6282_REV_A0))
+			platform_device_register(&kirkwood_i2c_1);
+	}
 }
 
 
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 5b2c1c1..fc05200 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -21,6 +21,9 @@ struct mtd_info;
 #define KW_PCIE0	(1 << 0)
 #define KW_PCIE1	(1 << 1)
 
+#define KW_TWSI0	(1 << 0)
+#define KW_TWSI1	(1 << 1)
+
 /*
  * Basic Kirkwood init functions used early by machine-setup.
  */
@@ -41,7 +44,7 @@ void kirkwood_pcie_init(unsigned int portmask);
 void kirkwood_sata_init(struct mv_sata_platform_data *sata_data);
 void kirkwood_sdio_init(struct mvsdio_platform_data *mvsdio_data);
 void kirkwood_spi_init(void);
-void kirkwood_i2c_init(void);
+void kirkwood_i2c_init(unsigned int mask);
 void kirkwood_uart0_init(void);
 void kirkwood_uart1_init(void);
 void kirkwood_nand_init(struct mtd_partition *parts, int nr_parts, int delay);
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
index 7938347..6138884 100644
--- a/arch/arm/mach-kirkwood/include/mach/kirkwood.h
+++ b/arch/arm/mach-kirkwood/include/mach/kirkwood.h
@@ -71,7 +71,8 @@
 #define  DEVICE_ID		(DEV_BUS_VIRT_BASE | 0x0034)
 #define  RTC_PHYS_BASE		(DEV_BUS_PHYS_BASE | 0x0300)
 #define  SPI_PHYS_BASE		(DEV_BUS_PHYS_BASE | 0x0600)
-#define  I2C_PHYS_BASE		(DEV_BUS_PHYS_BASE | 0x1000)
+#define  I2C_0_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x1000)
+#define  I2C_1_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x1100)
 #define  UART0_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x2000)
 #define  UART0_VIRT_BASE	(DEV_BUS_VIRT_BASE | 0x2000)
 #define  UART1_PHYS_BASE	(DEV_BUS_PHYS_BASE | 0x2100)
diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-kirkwood/netspace_v2-setup.c
index b96e43b..ddf1e89 100644
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netspace_v2-setup.c
@@ -295,7 +295,7 @@ static void __init netspace_v2_init(void)
 	spi_register_board_info(netspace_v2_spi_slave_info,
 				ARRAY_SIZE(netspace_v2_spi_slave_info));
 	kirkwood_spi_init();
-	kirkwood_i2c_init();
+	kirkwood_i2c_init(KW_TWSI0);
 	i2c_register_board_info(0, netspace_v2_i2c_info,
 				ARRAY_SIZE(netspace_v2_i2c_info));
 
diff --git a/arch/arm/mach-kirkwood/netxbig_v2-setup.c b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
index 2bd14c5..1812a0c 100644
--- a/arch/arm/mach-kirkwood/netxbig_v2-setup.c
+++ b/arch/arm/mach-kirkwood/netxbig_v2-setup.c
@@ -377,7 +377,7 @@ static void __init netxbig_v2_init(void)
 	spi_register_board_info(netxbig_v2_spi_slave_info,
 				ARRAY_SIZE(netxbig_v2_spi_slave_info));
 	kirkwood_spi_init();
-	kirkwood_i2c_init();
+	kirkwood_i2c_init(KW_TWSI0);
 	i2c_register_board_info(0, netxbig_v2_i2c_info,
 				ARRAY_SIZE(netxbig_v2_i2c_info));
 
diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
index 2400207..605a8d9 100644
--- a/arch/arm/mach-kirkwood/openrd-setup.c
+++ b/arch/arm/mach-kirkwood/openrd-setup.c
@@ -79,7 +79,7 @@ static void __init openrd_init(void)
 	kirkwood_sata_init(&openrd_sata_data);
 	kirkwood_sdio_init(&openrd_mvsdio_data);
 
-	kirkwood_i2c_init();
+	kirkwood_i2c_init(KW_TWSI0);
 }
 
 static int __init openrd_pci_init(void)
diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
index 5c7dd85..d1115d4 100644
--- a/arch/arm/mach-kirkwood/ts219-setup.c
+++ b/arch/arm/mach-kirkwood/ts219-setup.c
@@ -97,7 +97,7 @@ static void __init qnap_ts219_init(void)
 	kirkwood_uart0_init();
 	kirkwood_uart1_init(); /* A PIC controller is connected here. */
 	qnap_tsx1x_register_flash();
-	kirkwood_i2c_init();
+	kirkwood_i2c_init(KW_TWSI0);
 	i2c_register_board_info(0, &qnap_ts219_i2c_rtc, 1);
 	kirkwood_ge00_init(&qnap_ts219_ge00_data);
 	kirkwood_sata_init(&qnap_ts219_sata_data);
diff --git a/arch/arm/mach-kirkwood/ts41x-setup.c b/arch/arm/mach-kirkwood/ts41x-setup.c
index a2c5f70..7d19691 100644
--- a/arch/arm/mach-kirkwood/ts41x-setup.c
+++ b/arch/arm/mach-kirkwood/ts41x-setup.c
@@ -121,7 +121,7 @@ static void __init qnap_ts41x_init(void)
 	kirkwood_uart0_init();
 	kirkwood_uart1_init(); /* A PIC controller is connected here. */
 	qnap_tsx1x_register_flash();
-	kirkwood_i2c_init();
+	kirkwood_i2c_init(KW_TWSI0);
 	i2c_register_board_info(0, &qnap_ts41x_i2c_rtc, 1);
 	kirkwood_ge00_init(&qnap_ts41x_ge00_data);
 	kirkwood_ge01_init(&qnap_ts41x_ge01_data);
