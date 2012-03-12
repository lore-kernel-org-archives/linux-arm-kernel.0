From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 12 Mar 2012 20:03:03 +0100
Subject: [PATCH v2 5/6] ARM: S3C24XX: Add HSSPI setup callback for s3c64xx-spi
 driver
In-Reply-To: <201203121959.32966.heiko@sntech.de>
References: <201203121959.32966.heiko@sntech.de>
Message-ID: <201203122003.03303.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This lets the s3c64xx-spi driver know the specifics of the controller-
variant and also setups the gpios and the misccr bit.

This setup is valid for all S3C24XX SoCs containing a HSSPI controller
(i.e. S3C2416/2450 and S3C2443)

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes since v1: adapt to changes in Makefile

 arch/arm/mach-s3c24xx/Kconfig     |    5 ++++
 arch/arm/mach-s3c24xx/Makefile    |    1 +
 arch/arm/mach-s3c24xx/setup-spi.c |   39 +++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s3c24xx/setup-spi.c

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 0f3a327..38e6b30 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -518,6 +518,11 @@ config S3C2443_DMA
 	help
 	  Internal config node for S3C2443 DMA support
 
+config S3C2443_SETUP_SPI
+	bool
+	help
+	  Common setup code for SPI GPIO configurations
+
 endif	# CPU_S3C2443 || CPU_S3C2416
 
 if CPU_S3C2443
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 3518fe8..d0f3a92 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -91,5 +91,6 @@ obj-$(CONFIG_MACH_OSIRIS_DVS)		+= mach-osiris-dvs.o
 # device setup
 
 obj-$(CONFIG_S3C2416_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
+obj-$(CONFIG_S3C2443_SETUP_SPI)		+= setup-spi.o
 obj-$(CONFIG_ARCH_S3C24XX)		+= setup-i2c.o
 obj-$(CONFIG_S3C24XX_SETUP_TS)		+= setup-ts.o
diff --git a/arch/arm/mach-s3c24xx/setup-spi.c b/arch/arm/mach-s3c24xx/setup-spi.c
new file mode 100644
index 0000000..5712c85
--- /dev/null
+++ b/arch/arm/mach-s3c24xx/setup-spi.c
@@ -0,0 +1,39 @@
+/*
+ * HS-SPI device setup for S3C2443/S3C2416
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
+#include <plat/s3c64xx-spi.h>
+
+#include <mach/hardware.h>
+#include <mach/regs-gpio.h>
+
+#ifdef CONFIG_S3C64XX_DEV_SPI0
+struct s3c64xx_spi_info s3c64xx_spi0_pdata __initdata = {
+	.fifo_lvl_mask	= 0x7f,
+	.rx_lvl_offset	= 13,
+	.tx_st_done	= 21,
+	.high_speed	= 1,
+};
+
+int s3c64xx_spi0_cfg_gpio(struct platform_device *pdev)
+{
+	/* enable hsspi bit in misccr */
+	s3c2410_modify_misccr(S3C2416_MISCCR_HSSPI_EN2, 1);
+
+	s3c_gpio_cfgall_range(S3C2410_GPE(11), 3,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+
+	return 0;
+}
+#endif
-- 
1.7.2.3
