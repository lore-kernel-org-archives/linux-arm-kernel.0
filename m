From: padma.v@samsung.com (Padmavathi Venna)
Date: Thu, 30 Jun 2011 08:40:40 -0400
Subject: [PATCH] ARM: EXYNOS4: Add SPI support
Message-ID: <1309437640-9608-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPI Support
Add SPI setup files for GPIO configurations
Define SPI source clocks
Add SPI platform specific code
Enable the existing SPI driver

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 arch/arm/mach-exynos4/Kconfig                   |   21 +++++++++++++++++++
 arch/arm/mach-exynos4/Makefile                  |    4 +++
 arch/arm/mach-exynos4/include/mach/irqs.h       |    4 +++
 arch/arm/mach-exynos4/include/mach/map.h        |    7 ++++++
 arch/arm/mach-exynos4/include/mach/spi-clocks.h |   21 +++++++++++++++++++
 arch/arm/mach-exynos4/mach-smdkv310.c           |   25 +++++++++++++++++++++++
 arch/arm/mach-exynos4/setup-spi0.c              |   23 +++++++++++++++++++++
 arch/arm/mach-exynos4/setup-spi1.c              |   23 +++++++++++++++++++++
 arch/arm/mach-exynos4/setup-spi2.c              |   23 +++++++++++++++++++++
 drivers/spi/Kconfig                             |    2 +-
 10 files changed, 152 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-exynos4/include/mach/spi-clocks.h
 create mode 100644 arch/arm/mach-exynos4/setup-spi0.c
 create mode 100644 arch/arm/mach-exynos4/setup-spi1.c
 create mode 100644 arch/arm/mach-exynos4/setup-spi2.c

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 1413778..953eec2 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -96,6 +96,21 @@ config EXYNOS4_SETUP_USB_PHY
 	help
 	  Common setup code for USB PHY controller
 
+config EXYNOS4_SETUP_SPI0
+	bool
+	help
+	  Common setup code for SPI channel 0
+
+config EXYNOS4_SETUP_SPI1
+	bool
+	help
+	  Common setup code for SPI channel 1
+
+config EXYNOS4_SETUP_SPI2
+	bool
+	help
+	  Common setup code for SPI channel 2
+
 # machine support
 
 menu "EXYNOS4 Machines"
@@ -128,11 +143,17 @@ config MACH_SMDKV310
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
 	select SAMSUNG_DEV_KEYPAD
+	select SAMSUNG_DEV_SPI0
+	select SAMSUNG_DEV_SPI1
+	select SAMSUNG_DEV_SPI2
 	select EXYNOS4_DEV_PD
 	select EXYNOS4_DEV_SYSMMU
 	select EXYNOS4_SETUP_I2C1
 	select EXYNOS4_SETUP_KEYPAD
 	select EXYNOS4_SETUP_SDHCI
+	select EXYNOS4_SETUP_SPI0
+	select EXYNOS4_SETUP_SPI1
+	select EXYNOS4_SETUP_SPI2
 	help
 	  Machine support for Samsung SMDKV310
 
diff --git a/arch/arm/mach-exynos4/Makefile b/arch/arm/mach-exynos4/Makefile
index 60fe5ec..ccbd8fa 100644
--- a/arch/arm/mach-exynos4/Makefile
+++ b/arch/arm/mach-exynos4/Makefile
@@ -57,3 +57,7 @@ obj-$(CONFIG_EXYNOS4_SETUP_SDHCI)	+= setup-sdhci.o
 obj-$(CONFIG_EXYNOS4_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 
 obj-$(CONFIG_EXYNOS4_SETUP_USB_PHY)	+= setup-usb-phy.o
+obj-$(CONFIG_EXYNOS4_SETUP_SPI0)        += setup-spi0.o
+obj-$(CONFIG_EXYNOS4_SETUP_SPI1)        += setup-spi1.o
+obj-$(CONFIG_EXYNOS4_SETUP_SPI2)        += setup-spi2.o
+obj-$(CONFIG_EXYNOS4_SETUP_SPI0)        += setup-spi0.o
diff --git a/arch/arm/mach-exynos4/include/mach/irqs.h b/arch/arm/mach-exynos4/include/mach/irqs.h
index 5d03730..edffb30 100644
--- a/arch/arm/mach-exynos4/include/mach/irqs.h
+++ b/arch/arm/mach-exynos4/include/mach/irqs.h
@@ -103,6 +103,10 @@
 #define IRQ_IIC6		COMBINER_IRQ(27, 6)
 #define IRQ_IIC7		COMBINER_IRQ(27, 7)
 
+#define IRQ_SPI0		COMBINER_IRQ(28, 0)
+#define IRQ_SPI1		COMBINER_IRQ(28, 1)
+#define IRQ_SPI2		COMBINER_IRQ(28, 2)
+
 #define IRQ_HSMMC0		COMBINER_IRQ(29, 0)
 #define IRQ_HSMMC1		COMBINER_IRQ(29, 1)
 #define IRQ_HSMMC2		COMBINER_IRQ(29, 2)
diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
index 57d8074..8de8952 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -110,6 +110,10 @@
 
 #define EXYNOS4_PA_IIC(x)		(0x13860000 + ((x) * 0x10000))
 
+#define EXYNOS4_PA_SPI0			0x13920000
+#define EXYNOS4_PA_SPI1			0x13930000
+#define EXYNOS4_PA_SPI2			0x13940000
+
 #define EXYNOS4_PA_AC97			0x139A0000
 
 #define EXYNOS4_PA_SPDIF		0x139B0000
@@ -134,6 +138,9 @@
 #define S3C_PA_IIC7			EXYNOS4_PA_IIC(7)
 #define S3C_PA_RTC			EXYNOS4_PA_RTC
 #define S3C_PA_WDT			EXYNOS4_PA_WATCHDOG
+#define S3C_PA_SPI0			EXYNOS4_PA_SPI0
+#define S3C_PA_SPI1			EXYNOS4_PA_SPI1
+#define S3C_PA_SPI2			EXYNOS4_PA_SPI2
 
 #define S5P_PA_CHIPID			EXYNOS4_PA_CHIPID
 #define S5P_PA_FIMC0			EXYNOS4_PA_FIMC0
diff --git a/arch/arm/mach-exynos4/include/mach/spi-clocks.h b/arch/arm/mach-exynos4/include/mach/spi-clocks.h
new file mode 100644
index 0000000..7af25a6
--- /dev/null
+++ b/arch/arm/mach-exynos4/include/mach/spi-clocks.h
@@ -0,0 +1,21 @@
+/* linux/arch/arm/mach-exynos4/include/mach/spi-clocks.h
+ *
+ * Copyright (C) 2011 Samsung Electronics Co. Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_SPI_CLKS_H
+#define __ASM_ARCH_SPI_CLKS_H __FILE__
+
+/* Must source from SCLK_SPI */
+#define EXYNOS4_SPI_SRCCLK_SCLK		0
+
+static char *spi_src_clks[] = {
+	[EXYNOS4_SPI_SRCCLK_SCLK] = "sclk_spi",
+};
+
+#endif /* __ASM_ARCH_SPI_CLKS_H */
diff --git a/arch/arm/mach-exynos4/mach-smdkv310.c b/arch/arm/mach-exynos4/mach-smdkv310.c
index af80a16..6c91f56 100644
--- a/arch/arm/mach-exynos4/mach-smdkv310.c
+++ b/arch/arm/mach-exynos4/mach-smdkv310.c
@@ -29,6 +29,7 @@
 #include <plat/sdhci.h>
 #include <plat/iic.h>
 #include <plat/pd.h>
+#include <plat/s3c64xx-spi.h>
 
 #include <mach/map.h>
 
@@ -140,6 +141,30 @@ static struct platform_device smdkv310_smsc911x = {
 	},
 };
 
+static struct s3c64xx_spi_info s3c_spi0_pdata __initdata = {
+	.fifo_lvl_mask	= 0x1ff,
+	.rx_lvl_offset	= 15,
+	.high_speed	= 1,
+	.clk_from_cmu	= true,
+	.tx_st_done	= 25,
+};
+
+static struct s3c64xx_spi_info s3c_spi1_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 15,
+	.high_speed	= 1,
+	.clk_from_cmu	= true,
+	.tx_st_done	= 25,
+};
+
+static struct s3c64xx_spi_info s3c_spi2_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 15,
+	.high_speed	= 1,
+	.clk_from_cmu	= true,
+	.tx_st_done	= 25,
+};
+
 static uint32_t smdkv310_keymap[] __initdata = {
 	/* KEY(row, col, keycode) */
 	KEY(0, 3, KEY_1), KEY(0, 4, KEY_2), KEY(0, 5, KEY_3),
diff --git a/arch/arm/mach-exynos4/setup-spi0.c b/arch/arm/mach-exynos4/setup-spi0.c
new file mode 100644
index 0000000..b797360
--- /dev/null
+++ b/arch/arm/mach-exynos4/setup-spi0.c
@@ -0,0 +1,23 @@
+/* linux/arch/arm/mach-exynos4/setup-spi0.c
+ *
+ * Copyright (C) 2011 Samsung Electronics Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+
+#include <plat/gpio-cfg.h>
+
+int s3c_spi0_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(EXYNOS4_GPB(0), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(EXYNOS4_GPB(0), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(EXYNOS4_GPB(2), 2,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
diff --git a/arch/arm/mach-exynos4/setup-spi1.c b/arch/arm/mach-exynos4/setup-spi1.c
new file mode 100644
index 0000000..ab4e9c9
--- /dev/null
+++ b/arch/arm/mach-exynos4/setup-spi1.c
@@ -0,0 +1,23 @@
+/* linux/arch/arm/mach-exynos4/setup-spi1.c
+ *
+ * Copyright (C) 2011 Samsung Electronics Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+
+#include <plat/gpio-cfg.h>
+
+int s3c_spi1_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(EXYNOS4_GPB(4), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(EXYNOS4_GPB(4), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(EXYNOS4_GPB(6), 2,
+				S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+	return 0;
+}
diff --git a/arch/arm/mach-exynos4/setup-spi2.c b/arch/arm/mach-exynos4/setup-spi2.c
new file mode 100644
index 0000000..d4436db
--- /dev/null
+++ b/arch/arm/mach-exynos4/setup-spi2.c
@@ -0,0 +1,23 @@
+/* linux/arch/arm/mach-exynos4/setup-spi2.c
+ *
+ * Copyright (C) 2011 Samsung Electronics Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+
+#include <plat/gpio-cfg.h>
+
+int s3c_spi2_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(EXYNOS4_GPC1(1), S3C_GPIO_SFN(5));
+	s3c_gpio_setpull(EXYNOS4_GPC1(1), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(EXYNOS4_GPC1(3), 2,
+				S3C_GPIO_SFN(5), S3C_GPIO_PULL_UP);
+	return 0;
+}
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ed1ebea..ceb2a22 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -341,7 +341,7 @@ config SPI_S3C24XX_GPIO
 config SPI_S3C64XX
 	tristate "Samsung S3C64XX series type SPI"
 	depends on (ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_S5PC100 \
-			|| ARCH_S5PV210)
+			|| ARCH_S5PV210 || ARCH_EXYNOS4)
 	select S3C64XX_DMA if ARCH_S3C64XX
 	help
 	  SPI driver for Samsung S3C64XX and newer SoCs.
-- 
1.7.0.4
