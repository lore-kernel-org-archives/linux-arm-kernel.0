From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 28 Apr 2011 15:32:49 +0900
Subject: [PATCH v2] ARM: S3C64XX: Remove gpio-bank-X header files
Message-ID: <1303972369-17563-1-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gpio-bank-X header files of S3C64XX have defines which can be
substituted by more common API, so they can be removed. This is compile
tested only.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s3c64xx/dev-spi.c                  |   20 ++----
 arch/arm/mach-s3c64xx/include/mach/gpio-bank-a.h |   48 --------------
 arch/arm/mach-s3c64xx/include/mach/gpio-bank-b.h |   60 -----------------
 arch/arm/mach-s3c64xx/include/mach/gpio-bank-c.h |   53 ---------------
 arch/arm/mach-s3c64xx/include/mach/gpio-bank-d.h |   49 --------------
 arch/arm/mach-s3c64xx/include/mach/gpio-bank-e.h |   44 -------------
 arch/arm/mach-s3c64xx/include/mach/gpio-bank-f.h |   71 ---------------------
 arch/arm/mach-s3c64xx/include/mach/gpio-bank-g.h |   42 ------------
 arch/arm/mach-s3c64xx/include/mach/gpio-bank-h.h |   74 ----------------------
 arch/arm/mach-s3c64xx/include/mach/gpio-bank-i.h |   40 ------------
 arch/arm/mach-s3c64xx/include/mach/gpio-bank-j.h |   36 -----------
 arch/arm/mach-s3c64xx/include/mach/gpio-bank-n.h |   54 ----------------
 arch/arm/mach-s3c64xx/include/mach/gpio-bank-o.h |   70 --------------------
 arch/arm/mach-s3c64xx/include/mach/gpio-bank-p.h |   69 --------------------
 arch/arm/mach-s3c64xx/include/mach/gpio-bank-q.h |   46 -------------
 arch/arm/mach-s3c64xx/mach-smdk6410.c            |    1 -
 arch/arm/mach-s3c64xx/pm.c                       |   34 ++++++-----
 arch/arm/mach-s3c64xx/setup-i2c0.c               |    7 +--
 arch/arm/mach-s3c64xx/setup-i2c1.c               |    7 +--
 arch/arm/mach-s3c64xx/sleep.S                    |    8 ++-
 20 files changed, 37 insertions(+), 796 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-a.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-b.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-c.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-d.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-e.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-f.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-g.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-h.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-i.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-j.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-n.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-o.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-p.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/gpio-bank-q.h

diff --git a/arch/arm/mach-s3c64xx/dev-spi.c b/arch/arm/mach-s3c64xx/dev-spi.c
index 405e621..82db072 100644
--- a/arch/arm/mach-s3c64xx/dev-spi.c
+++ b/arch/arm/mach-s3c64xx/dev-spi.c
@@ -16,7 +16,6 @@
 
 #include <mach/dma.h>
 #include <mach/map.h>
-#include <mach/gpio-bank-c.h>
 #include <mach/spi-clocks.h>
 #include <mach/irqs.h>
 
@@ -40,23 +39,15 @@ static char *spi_src_clks[] = {
  */
 static int s3c64xx_spi_cfg_gpio(struct platform_device *pdev)
 {
+	unsigned int base;
+
 	switch (pdev->id) {
 	case 0:
-		s3c_gpio_cfgpin(S3C64XX_GPC(0), S3C64XX_GPC0_SPI_MISO0);
-		s3c_gpio_cfgpin(S3C64XX_GPC(1), S3C64XX_GPC1_SPI_CLKO);
-		s3c_gpio_cfgpin(S3C64XX_GPC(2), S3C64XX_GPC2_SPI_MOSIO);
-		s3c_gpio_setpull(S3C64XX_GPC(0), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S3C64XX_GPC(1), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S3C64XX_GPC(2), S3C_GPIO_PULL_UP);
+		base = S3C64XX_GPC(0);
 		break;
 
 	case 1:
-		s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_SPI_MISO1);
-		s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_SPI_CLK1);
-		s3c_gpio_cfgpin(S3C64XX_GPC(6), S3C64XX_GPC6_SPI_MOSI1);
-		s3c_gpio_setpull(S3C64XX_GPC(4), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S3C64XX_GPC(5), S3C_GPIO_PULL_UP);
-		s3c_gpio_setpull(S3C64XX_GPC(6), S3C_GPIO_PULL_UP);
+		base = S3C64XX_GPC(4);
 		break;
 
 	default:
@@ -64,6 +55,9 @@ static int s3c64xx_spi_cfg_gpio(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	s3c_gpio_cfgall_range(base, 3,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-a.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-a.h
deleted file mode 100644
index 34212e1..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-a.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-a.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- * 	Ben Dooks <ben@simtec.co.uk>
- * 	http://armlinux.simtec.co.uk/
- *
- * GPIO Bank A register and configuration definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C64XX_GPACON			(S3C64XX_GPA_BASE + 0x00)
-#define S3C64XX_GPADAT			(S3C64XX_GPA_BASE + 0x04)
-#define S3C64XX_GPAPUD			(S3C64XX_GPA_BASE + 0x08)
-#define S3C64XX_GPACONSLP		(S3C64XX_GPA_BASE + 0x0c)
-#define S3C64XX_GPAPUDSLP		(S3C64XX_GPA_BASE + 0x10)
-
-#define S3C64XX_GPA_CONMASK(__gpio)	(0xf << ((__gpio) * 4))
-#define S3C64XX_GPA_INPUT(__gpio)	(0x0 << ((__gpio) * 4))
-#define S3C64XX_GPA_OUTPUT(__gpio)	(0x1 << ((__gpio) * 4))
-
-#define S3C64XX_GPA0_UART_RXD0		(0x02 << 0)
-#define S3C64XX_GPA0_EINT_G1_0		(0x07 << 0)
-
-#define S3C64XX_GPA1_UART_TXD0		(0x02 << 4)
-#define S3C64XX_GPA1_EINT_G1_1		(0x07 << 4)
-
-#define S3C64XX_GPA2_UART_nCTS0		(0x02 << 8)
-#define S3C64XX_GPA2_EINT_G1_2		(0x07 << 8)
-
-#define S3C64XX_GPA3_UART_nRTS0		(0x02 << 12)
-#define S3C64XX_GPA3_EINT_G1_3		(0x07 << 12)
-
-#define S3C64XX_GPA4_UART_RXD1		(0x02 << 16)
-#define S3C64XX_GPA4_EINT_G1_4		(0x07 << 16)
-
-#define S3C64XX_GPA5_UART_TXD1		(0x02 << 20)
-#define S3C64XX_GPA5_EINT_G1_5		(0x07 << 20)
-
-#define S3C64XX_GPA6_UART_nCTS1		(0x02 << 24)
-#define S3C64XX_GPA6_EINT_G1_6		(0x07 << 24)
-
-#define S3C64XX_GPA7_UART_nRTS1		(0x02 << 28)
-#define S3C64XX_GPA7_EINT_G1_7		(0x07 << 28)
-
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-b.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-b.h
deleted file mode 100644
index 7232c03..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-b.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-b.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- * 	Ben Dooks <ben@simtec.co.uk>
- * 	http://armlinux.simtec.co.uk/
- *
- * GPIO Bank B register and configuration definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C64XX_GPBCON			(S3C64XX_GPB_BASE + 0x00)
-#define S3C64XX_GPBDAT			(S3C64XX_GPB_BASE + 0x04)
-#define S3C64XX_GPBPUD			(S3C64XX_GPB_BASE + 0x08)
-#define S3C64XX_GPBCONSLP		(S3C64XX_GPB_BASE + 0x0c)
-#define S3C64XX_GPBPUDSLP		(S3C64XX_GPB_BASE + 0x10)
-
-#define S3C64XX_GPB_CONMASK(__gpio)	(0xf << ((__gpio) * 4))
-#define S3C64XX_GPB_INPUT(__gpio)	(0x0 << ((__gpio) * 4))
-#define S3C64XX_GPB_OUTPUT(__gpio)	(0x1 << ((__gpio) * 4))
-
-#define S3C64XX_GPB0_UART_RXD2		(0x02 << 0)
-#define S3C64XX_GPB0_EXTDMA_REQ		(0x03 << 0)
-#define S3C64XX_GPB0_IrDA_RXD		(0x04 << 0)
-#define S3C64XX_GPB0_ADDR_CF0		(0x05 << 0)
-#define S3C64XX_GPB0_EINT_G1_8		(0x07 << 0)
-
-#define S3C64XX_GPB1_UART_TXD2		(0x02 << 4)
-#define S3C64XX_GPB1_EXTDMA_ACK		(0x03 << 4)
-#define S3C64XX_GPB1_IrDA_TXD		(0x04 << 4)
-#define S3C64XX_GPB1_ADDR_CF1		(0x05 << 4)
-#define S3C64XX_GPB1_EINT_G1_9		(0x07 << 4)
-
-#define S3C64XX_GPB2_UART_RXD3		(0x02 << 8)
-#define S3C64XX_GPB2_IrDA_RXD		(0x03 << 8)
-#define S3C64XX_GPB2_EXTDMA_REQ		(0x04 << 8)
-#define S3C64XX_GPB2_ADDR_CF2		(0x05 << 8)
-#define S3C64XX_GPB2_I2C_SCL1		(0x06 << 8)
-#define S3C64XX_GPB2_EINT_G1_10		(0x07 << 8)
-
-#define S3C64XX_GPB3_UART_TXD3		(0x02 << 12)
-#define S3C64XX_GPB3_IrDA_TXD		(0x03 << 12)
-#define S3C64XX_GPB3_EXTDMA_ACK		(0x04 << 12)
-#define S3C64XX_GPB3_I2C_SDA1		(0x06 << 12)
-#define S3C64XX_GPB3_EINT_G1_11		(0x07 << 12)
-
-#define S3C64XX_GPB4_IrDA_SDBW		(0x02 << 16)
-#define S3C64XX_GPB4_CAM_FIELD		(0x03 << 16)
-#define S3C64XX_GPB4_CF_DATA_DIR	(0x04 << 16)
-#define S3C64XX_GPB4_EINT_G1_12		(0x07 << 16)
-
-#define S3C64XX_GPB5_I2C_SCL0		(0x02 << 20)
-#define S3C64XX_GPB5_EINT_G1_13		(0x07 << 20)
-
-#define S3C64XX_GPB6_I2C_SDA0		(0x02 << 24)
-#define S3C64XX_GPB6_EINT_G1_14		(0x07 << 24)
-
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-c.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-c.h
deleted file mode 100644
index db189ab..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-c.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-c.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- * 	Ben Dooks <ben@simtec.co.uk>
- * 	http://armlinux.simtec.co.uk/
- *
- * GPIO Bank C register and configuration definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C64XX_GPCCON			(S3C64XX_GPC_BASE + 0x00)
-#define S3C64XX_GPCDAT			(S3C64XX_GPC_BASE + 0x04)
-#define S3C64XX_GPCPUD			(S3C64XX_GPC_BASE + 0x08)
-#define S3C64XX_GPCCONSLP		(S3C64XX_GPC_BASE + 0x0c)
-#define S3C64XX_GPCPUDSLP		(S3C64XX_GPC_BASE + 0x10)
-
-#define S3C64XX_GPC_CONMASK(__gpio)	(0xf << ((__gpio) * 4))
-#define S3C64XX_GPC_INPUT(__gpio)	(0x0 << ((__gpio) * 4))
-#define S3C64XX_GPC_OUTPUT(__gpio)	(0x1 << ((__gpio) * 4))
-
-#define S3C64XX_GPC0_SPI_MISO0		(0x02 << 0)
-#define S3C64XX_GPC0_EINT_G2_0		(0x07 << 0)
-
-#define S3C64XX_GPC1_SPI_CLKO		(0x02 << 4)
-#define S3C64XX_GPC1_EINT_G2_1		(0x07 << 4)
-
-#define S3C64XX_GPC2_SPI_MOSIO		(0x02 << 8)
-#define S3C64XX_GPC2_EINT_G2_2		(0x07 << 8)
-
-#define S3C64XX_GPC3_SPI_nCSO		(0x02 << 12)
-#define S3C64XX_GPC3_EINT_G2_3		(0x07 << 12)
-
-#define S3C64XX_GPC4_SPI_MISO1		(0x02 << 16)
-#define S3C64XX_GPC4_MMC2_CMD		(0x03 << 16)
-#define S3C64XX_GPC4_I2S_V40_DO0	(0x05 << 16)
-#define S3C64XX_GPC4_EINT_G2_4		(0x07 << 16)
-
-#define S3C64XX_GPC5_SPI_CLK1		(0x02 << 20)
-#define S3C64XX_GPC5_MMC2_CLK		(0x03 << 20)
-#define S3C64XX_GPC5_I2S_V40_DO1	(0x05 << 20)
-#define S3C64XX_GPC5_EINT_G2_5		(0x07 << 20)
-
-#define S3C64XX_GPC6_SPI_MOSI1		(0x02 << 24)
-#define S3C64XX_GPC6_EINT_G2_6		(0x07 << 24)
-
-#define S3C64XX_GPC7_SPI_nCS1		(0x02 << 28)
-#define S3C64XX_GPC7_I2S_V40_DO2	(0x05 << 28)
-#define S3C64XX_GPC7_EINT_G2_7		(0x07 << 28)
-
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-d.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-d.h
deleted file mode 100644
index 1a01cee..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-d.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-d.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- * 	Ben Dooks <ben@simtec.co.uk>
- * 	http://armlinux.simtec.co.uk/
- *
- * GPIO Bank D register and configuration definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C64XX_GPDCON			(S3C64XX_GPD_BASE + 0x00)
-#define S3C64XX_GPDDAT			(S3C64XX_GPD_BASE + 0x04)
-#define S3C64XX_GPDPUD			(S3C64XX_GPD_BASE + 0x08)
-#define S3C64XX_GPDCONSLP		(S3C64XX_GPD_BASE + 0x0c)
-#define S3C64XX_GPDPUDSLP		(S3C64XX_GPD_BASE + 0x10)
-
-#define S3C64XX_GPD_CONMASK(__gpio)	(0xf << ((__gpio) * 4))
-#define S3C64XX_GPD_INPUT(__gpio)	(0x0 << ((__gpio) * 4))
-#define S3C64XX_GPD_OUTPUT(__gpio)	(0x1 << ((__gpio) * 4))
-
-#define S3C64XX_GPD0_PCM0_SCLK		(0x02 << 0)
-#define S3C64XX_GPD0_I2S0_CLK		(0x03 << 0)
-#define S3C64XX_GPD0_AC97_BITCLK	(0x04 << 0)
-#define S3C64XX_GPD0_EINT_G3_0		(0x07 << 0)
-
-#define S3C64XX_GPD1_PCM0_EXTCLK	(0x02 << 4)
-#define S3C64XX_GPD1_I2S0_CDCLK		(0x03 << 4)
-#define S3C64XX_GPD1_AC97_nRESET	(0x04 << 4)
-#define S3C64XX_GPD1_EINT_G3_1		(0x07 << 4)
-
-#define S3C64XX_GPD2_PCM0_FSYNC		(0x02 << 8)
-#define S3C64XX_GPD2_I2S0_LRCLK		(0x03 << 8)
-#define S3C64XX_GPD2_AC97_SYNC		(0x04 << 8)
-#define S3C64XX_GPD2_EINT_G3_2		(0x07 << 8)
-
-#define S3C64XX_GPD3_PCM0_SIN		(0x02 << 12)
-#define S3C64XX_GPD3_I2S0_DI		(0x03 << 12)
-#define S3C64XX_GPD3_AC97_SDI		(0x04 << 12)
-#define S3C64XX_GPD3_EINT_G3_3		(0x07 << 12)
-
-#define S3C64XX_GPD4_PCM0_SOUT		(0x02 << 16)
-#define S3C64XX_GPD4_I2S0_D0		(0x03 << 16)
-#define S3C64XX_GPD4_AC97_SDO		(0x04 << 16)
-#define S3C64XX_GPD4_EINT_G3_4		(0x07 << 16)
-
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-e.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-e.h
deleted file mode 100644
index f057adb..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-e.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-e.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- * 	Ben Dooks <ben@simtec.co.uk>
- * 	http://armlinux.simtec.co.uk/
- *
- * GPIO Bank E register and configuration definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C64XX_GPECON			(S3C64XX_GPE_BASE + 0x00)
-#define S3C64XX_GPEDAT			(S3C64XX_GPE_BASE + 0x04)
-#define S3C64XX_GPEPUD			(S3C64XX_GPE_BASE + 0x08)
-#define S3C64XX_GPECONSLP		(S3C64XX_GPE_BASE + 0x0c)
-#define S3C64XX_GPEPUDSLP		(S3C64XX_GPE_BASE + 0x10)
-
-#define S3C64XX_GPE_CONMASK(__gpio)	(0xf << ((__gpio) * 4))
-#define S3C64XX_GPE_INPUT(__gpio)	(0x0 << ((__gpio) * 4))
-#define S3C64XX_GPE_OUTPUT(__gpio)	(0x1 << ((__gpio) * 4))
-
-#define S3C64XX_GPE0_PCM1_SCLK		(0x02 << 0)
-#define S3C64XX_GPE0_I2S1_CLK		(0x03 << 0)
-#define S3C64XX_GPE0_AC97_BITCLK	(0x04 << 0)
-
-#define S3C64XX_GPE1_PCM1_EXTCLK	(0x02 << 4)
-#define S3C64XX_GPE1_I2S1_CDCLK		(0x03 << 4)
-#define S3C64XX_GPE1_AC97_nRESET	(0x04 << 4)
-
-#define S3C64XX_GPE2_PCM1_FSYNC		(0x02 << 8)
-#define S3C64XX_GPE2_I2S1_LRCLK		(0x03 << 8)
-#define S3C64XX_GPE2_AC97_SYNC		(0x04 << 8)
-
-#define S3C64XX_GPE3_PCM1_SIN		(0x02 << 12)
-#define S3C64XX_GPE3_I2S1_DI		(0x03 << 12)
-#define S3C64XX_GPE3_AC97_SDI		(0x04 << 12)
-
-#define S3C64XX_GPE4_PCM1_SOUT		(0x02 << 16)
-#define S3C64XX_GPE4_I2S1_D0		(0x03 << 16)
-#define S3C64XX_GPE4_AC97_SDO		(0x04 << 16)
-
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-f.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-f.h
deleted file mode 100644
index 62ab8f5..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-f.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-f.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- * 	Ben Dooks <ben@simtec.co.uk>
- * 	http://armlinux.simtec.co.uk/
- *
- * GPIO Bank F register and configuration definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C64XX_GPFCON			(S3C64XX_GPF_BASE + 0x00)
-#define S3C64XX_GPFDAT			(S3C64XX_GPF_BASE + 0x04)
-#define S3C64XX_GPFPUD			(S3C64XX_GPF_BASE + 0x08)
-#define S3C64XX_GPFCONSLP		(S3C64XX_GPF_BASE + 0x0c)
-#define S3C64XX_GPFPUDSLP		(S3C64XX_GPF_BASE + 0x10)
-
-#define S3C64XX_GPF_CONMASK(__gpio)	(0x3 << ((__gpio) * 2))
-#define S3C64XX_GPF_INPUT(__gpio)	(0x0 << ((__gpio) * 2))
-#define S3C64XX_GPF_OUTPUT(__gpio)	(0x1 << ((__gpio) * 2))
-
-#define S3C64XX_GPF0_CAMIF_CLK		(0x02 << 0)
-#define S3C64XX_GPF0_EINT_G4_0		(0x03 << 0)
-
-#define S3C64XX_GPF1_CAMIF_HREF		(0x02 << 2)
-#define S3C64XX_GPF1_EINT_G4_1		(0x03 << 2)
-
-#define S3C64XX_GPF2_CAMIF_PCLK		(0x02 << 4)
-#define S3C64XX_GPF2_EINT_G4_2		(0x03 << 4)
-
-#define S3C64XX_GPF3_CAMIF_nRST		(0x02 << 6)
-#define S3C64XX_GPF3_EINT_G4_3		(0x03 << 6)
-
-#define S3C64XX_GPF4_CAMIF_VSYNC	(0x02 << 8)
-#define S3C64XX_GPF4_EINT_G4_4		(0x03 << 8)
-
-#define S3C64XX_GPF5_CAMIF_YDATA0	(0x02 << 10)
-#define S3C64XX_GPF5_EINT_G4_5		(0x03 << 10)
-
-#define S3C64XX_GPF6_CAMIF_YDATA1	(0x02 << 12)
-#define S3C64XX_GPF6_EINT_G4_6		(0x03 << 12)
-
-#define S3C64XX_GPF7_CAMIF_YDATA2	(0x02 << 14)
-#define S3C64XX_GPF7_EINT_G4_7		(0x03 << 14)
-
-#define S3C64XX_GPF8_CAMIF_YDATA3	(0x02 << 16)
-#define S3C64XX_GPF8_EINT_G4_8		(0x03 << 16)
-
-#define S3C64XX_GPF9_CAMIF_YDATA4	(0x02 << 18)
-#define S3C64XX_GPF9_EINT_G4_9		(0x03 << 18)
-
-#define S3C64XX_GPF10_CAMIF_YDATA5	(0x02 << 20)
-#define S3C64XX_GPF10_EINT_G4_10	(0x03 << 20)
-
-#define S3C64XX_GPF11_CAMIF_YDATA6	(0x02 << 22)
-#define S3C64XX_GPF11_EINT_G4_11	(0x03 << 22)
-
-#define S3C64XX_GPF12_CAMIF_YDATA7	(0x02 << 24)
-#define S3C64XX_GPF12_EINT_G4_12	(0x03 << 24)
-
-#define S3C64XX_GPF13_PWM_ECLK		(0x02 << 26)
-#define S3C64XX_GPF13_EINT_G4_13	(0x03 << 26)
-
-#define S3C64XX_GPF14_PWM_TOUT0		(0x02 << 28)
-#define S3C64XX_GPF14_CLKOUT0		(0x03 << 28)
-
-#define S3C64XX_GPF15_PWM_TOUT1		(0x02 << 30)
-
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-g.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-g.h
deleted file mode 100644
index b94954a..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-g.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-g.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- * 	Ben Dooks <ben@simtec.co.uk>
- * 	http://armlinux.simtec.co.uk/
- *
- * GPIO Bank G register and configuration definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C64XX_GPGCON			(S3C64XX_GPG_BASE + 0x00)
-#define S3C64XX_GPGDAT			(S3C64XX_GPG_BASE + 0x04)
-#define S3C64XX_GPGPUD			(S3C64XX_GPG_BASE + 0x08)
-#define S3C64XX_GPGCONSLP		(S3C64XX_GPG_BASE + 0x0c)
-#define S3C64XX_GPGPUDSLP		(S3C64XX_GPG_BASE + 0x10)
-
-#define S3C64XX_GPG_CONMASK(__gpio)	(0xf << ((__gpio) * 4))
-#define S3C64XX_GPG_INPUT(__gpio)	(0x0 << ((__gpio) * 4))
-#define S3C64XX_GPG_OUTPUT(__gpio)	(0x1 << ((__gpio) * 4))
-
-#define S3C64XX_GPG0_MMC0_CLK		(0x02 << 0)
-#define S3C64XX_GPG0_EINT_G5_0		(0x07 << 0)
-
-#define S3C64XX_GPG1_MMC0_CMD		(0x02 << 4)
-#define S3C64XX_GPG1_EINT_G5_1		(0x07 << 4)
-
-#define S3C64XX_GPG2_MMC0_DATA0		(0x02 << 8)
-#define S3C64XX_GPG2_EINT_G5_2		(0x07 << 8)
-
-#define S3C64XX_GPG3_MMC0_DATA1		(0x02 << 12)
-#define S3C64XX_GPG3_EINT_G5_3		(0x07 << 12)
-
-#define S3C64XX_GPG4_MMC0_DATA2		(0x02 << 16)
-#define S3C64XX_GPG4_EINT_G5_4		(0x07 << 16)
-
-#define S3C64XX_GPG5_MMC0_DATA3		(0x02 << 20)
-#define S3C64XX_GPG5_EINT_G5_5		(0x07 << 20)
-
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-h.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-h.h
deleted file mode 100644
index 5d75aaa..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-h.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-h.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- * 	Ben Dooks <ben@simtec.co.uk>
- * 	http://armlinux.simtec.co.uk/
- *
- * GPIO Bank H register and configuration definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C64XX_GPHCON0			(S3C64XX_GPH_BASE + 0x00)
-#define S3C64XX_GPHCON1			(S3C64XX_GPH_BASE + 0x04)
-#define S3C64XX_GPHDAT			(S3C64XX_GPH_BASE + 0x08)
-#define S3C64XX_GPHPUD			(S3C64XX_GPH_BASE + 0x0c)
-#define S3C64XX_GPHCONSLP		(S3C64XX_GPH_BASE + 0x10)
-#define S3C64XX_GPHPUDSLP		(S3C64XX_GPH_BASE + 0x14)
-
-#define S3C64XX_GPH_CONMASK(__gpio)	(0xf << ((__gpio) * 4))
-#define S3C64XX_GPH_INPUT(__gpio)	(0x0 << ((__gpio) * 4))
-#define S3C64XX_GPH_OUTPUT(__gpio)	(0x1 << ((__gpio) * 4))
-
-#define S3C64XX_GPH0_MMC1_CLK		(0x02 << 0)
-#define S3C64XX_GPH0_KP_COL0		(0x04 << 0)
-#define S3C64XX_GPH0_EINT_G6_0		(0x07 << 0)
-
-#define S3C64XX_GPH1_MMC1_CMD		(0x02 << 4)
-#define S3C64XX_GPH1_KP_COL1		(0x04 << 4)
-#define S3C64XX_GPH1_EINT_G6_1		(0x07 << 4)
-
-#define S3C64XX_GPH2_MMC1_DATA0		(0x02 << 8)
-#define S3C64XX_GPH2_KP_COL2		(0x04 << 8)
-#define S3C64XX_GPH2_EINT_G6_2		(0x07 << 8)
-
-#define S3C64XX_GPH3_MMC1_DATA1		(0x02 << 12)
-#define S3C64XX_GPH3_KP_COL3		(0x04 << 12)
-#define S3C64XX_GPH3_EINT_G6_3		(0x07 << 12)
-
-#define S3C64XX_GPH4_MMC1_DATA2		(0x02 << 16)
-#define S3C64XX_GPH4_KP_COL4		(0x04 << 16)
-#define S3C64XX_GPH4_EINT_G6_4		(0x07 << 16)
-
-#define S3C64XX_GPH5_MMC1_DATA3		(0x02 << 20)
-#define S3C64XX_GPH5_KP_COL5		(0x04 << 20)
-#define S3C64XX_GPH5_EINT_G6_5		(0x07 << 20)
-
-#define S3C64XX_GPH6_MMC1_DATA4		(0x02 << 24)
-#define S3C64XX_GPH6_MMC2_DATA0		(0x03 << 24)
-#define S3C64XX_GPH6_KP_COL6		(0x04 << 24)
-#define S3C64XX_GPH6_I2S_V40_BCLK	(0x05 << 24)
-#define S3C64XX_GPH6_ADDR_CF0		(0x06 << 24)
-#define S3C64XX_GPH6_EINT_G6_6		(0x07 << 24)
-
-#define S3C64XX_GPH7_MMC1_DATA5		(0x02 << 28)
-#define S3C64XX_GPH7_MMC2_DATA1		(0x03 << 28)
-#define S3C64XX_GPH7_KP_COL7		(0x04 << 28)
-#define S3C64XX_GPH7_I2S_V40_CDCLK	(0x05 << 28)
-#define S3C64XX_GPH7_ADDR_CF1		(0x06 << 28)
-#define S3C64XX_GPH7_EINT_G6_7		(0x07 << 28)
-
-#define S3C64XX_GPH8_MMC1_DATA6		(0x02 <<  0)
-#define S3C64XX_GPH8_MMC2_DATA2		(0x03 <<  0)
-#define S3C64XX_GPH8_I2S_V40_LRCLK	(0x05 <<  0)
-#define S3C64XX_GPH8_ADDR_CF2		(0x06 <<  0)
-#define S3C64XX_GPH8_EINT_G6_8		(0x07 <<  0)
-
-#define S3C64XX_GPH9_OUTPUT		(0x01 <<  4)
-#define S3C64XX_GPH9_MMC1_DATA7		(0x02 <<  4)
-#define S3C64XX_GPH9_MMC2_DATA3		(0x03 <<  4)
-#define S3C64XX_GPH9_I2S_V40_DI		(0x05 <<  4)
-#define S3C64XX_GPH9_EINT_G6_9		(0x07 <<  4)
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-i.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-i.h
deleted file mode 100644
index 4ceaa60..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-i.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-i.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- * 	Ben Dooks <ben@simtec.co.uk>
- * 	http://armlinux.simtec.co.uk/
- *
- * GPIO Bank I register and configuration definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C64XX_GPICON			(S3C64XX_GPI_BASE + 0x00)
-#define S3C64XX_GPIDAT			(S3C64XX_GPI_BASE + 0x04)
-#define S3C64XX_GPIPUD			(S3C64XX_GPI_BASE + 0x08)
-#define S3C64XX_GPICONSLP		(S3C64XX_GPI_BASE + 0x0c)
-#define S3C64XX_GPIPUDSLP		(S3C64XX_GPI_BASE + 0x10)
-
-#define S3C64XX_GPI_CONMASK(__gpio)	(0x3 << ((__gpio) * 2))
-#define S3C64XX_GPI_INPUT(__gpio)	(0x0 << ((__gpio) * 2))
-#define S3C64XX_GPI_OUTPUT(__gpio)	(0x1 << ((__gpio) * 2))
-
-#define S3C64XX_GPI0_VD0		(0x02 << 0)
-#define S3C64XX_GPI1_VD1		(0x02 << 2)
-#define S3C64XX_GPI2_VD2		(0x02 << 4)
-#define S3C64XX_GPI3_VD3		(0x02 << 6)
-#define S3C64XX_GPI4_VD4		(0x02 << 8)
-#define S3C64XX_GPI5_VD5		(0x02 << 10)
-#define S3C64XX_GPI6_VD6		(0x02 << 12)
-#define S3C64XX_GPI7_VD7		(0x02 << 14)
-#define S3C64XX_GPI8_VD8		(0x02 << 16)
-#define S3C64XX_GPI9_VD9		(0x02 << 18)
-#define S3C64XX_GPI10_VD10		(0x02 << 20)
-#define S3C64XX_GPI11_VD11		(0x02 << 22)
-#define S3C64XX_GPI12_VD12		(0x02 << 24)
-#define S3C64XX_GPI13_VD13		(0x02 << 26)
-#define S3C64XX_GPI14_VD14		(0x02 << 28)
-#define S3C64XX_GPI15_VD15		(0x02 << 30)
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-j.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-j.h
deleted file mode 100644
index 6f25cd0..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-j.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-j.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- * 	Ben Dooks <ben@simtec.co.uk>
- * 	http://armlinux.simtec.co.uk/
- *
- * GPIO Bank J register and configuration definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C64XX_GPJCON			(S3C64XX_GPJ_BASE + 0x00)
-#define S3C64XX_GPJDAT			(S3C64XX_GPJ_BASE + 0x04)
-#define S3C64XX_GPJPUD			(S3C64XX_GPJ_BASE + 0x08)
-#define S3C64XX_GPJCONSLP		(S3C64XX_GPJ_BASE + 0x0c)
-#define S3C64XX_GPJPUDSLP		(S3C64XX_GPJ_BASE + 0x10)
-
-#define S3C64XX_GPJ_CONMASK(__gpio)	(0x3 << ((__gpio) * 2))
-#define S3C64XX_GPJ_INPUT(__gpio)	(0x0 << ((__gpio) * 2))
-#define S3C64XX_GPJ_OUTPUT(__gpio)	(0x1 << ((__gpio) * 2))
-
-#define S3C64XX_GPJ0_VD16		(0x02 << 0)
-#define S3C64XX_GPJ1_VD17		(0x02 << 2)
-#define S3C64XX_GPJ2_VD18		(0x02 << 4)
-#define S3C64XX_GPJ3_VD19		(0x02 << 6)
-#define S3C64XX_GPJ4_VD20		(0x02 << 8)
-#define S3C64XX_GPJ5_VD21		(0x02 << 10)
-#define S3C64XX_GPJ6_VD22		(0x02 << 12)
-#define S3C64XX_GPJ7_VD23		(0x02 << 14)
-#define S3C64XX_GPJ8_LCD_HSYNC		(0x02 << 16)
-#define S3C64XX_GPJ9_LCD_VSYNC		(0x02 << 18)
-#define S3C64XX_GPJ10_LCD_VDEN		(0x02 << 20)
-#define S3C64XX_GPJ11_LCD_VCLK		(0x02 << 22)
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-n.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-n.h
deleted file mode 100644
index d0aeda1..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-n.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-n.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- * 	Ben Dooks <ben@simtec.co.uk>
- * 	http://armlinux.simtec.co.uk/
- *
- * GPIO Bank N register and configuration definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C64XX_GPNCON			(S3C64XX_GPN_BASE + 0x00)
-#define S3C64XX_GPNDAT			(S3C64XX_GPN_BASE + 0x04)
-#define S3C64XX_GPNPUD			(S3C64XX_GPN_BASE + 0x08)
-
-#define S3C64XX_GPN_CONMASK(__gpio)	(0x3 << ((__gpio) * 2))
-#define S3C64XX_GPN_INPUT(__gpio)	(0x0 << ((__gpio) * 2))
-#define S3C64XX_GPN_OUTPUT(__gpio)	(0x1 << ((__gpio) * 2))
-
-#define S3C64XX_GPN0_EINT0		(0x02 << 0)
-#define S3C64XX_GPN0_KP_ROW0		(0x03 << 0)
-
-#define S3C64XX_GPN1_EINT1		(0x02 << 2)
-#define S3C64XX_GPN1_KP_ROW1		(0x03 << 2)
-
-#define S3C64XX_GPN2_EINT2		(0x02 << 4)
-#define S3C64XX_GPN2_KP_ROW2		(0x03 << 4)
-
-#define S3C64XX_GPN3_EINT3		(0x02 << 6)
-#define S3C64XX_GPN3_KP_ROW3		(0x03 << 6)
-
-#define S3C64XX_GPN4_EINT4		(0x02 << 8)
-#define S3C64XX_GPN4_KP_ROW4		(0x03 << 8)
-
-#define S3C64XX_GPN5_EINT5		(0x02 << 10)
-#define S3C64XX_GPN5_KP_ROW5		(0x03 << 10)
-
-#define S3C64XX_GPN6_EINT6		(0x02 << 12)
-#define S3C64XX_GPN6_KP_ROW6		(0x03 << 12)
-
-#define S3C64XX_GPN7_EINT7		(0x02 << 14)
-#define S3C64XX_GPN7_KP_ROW7		(0x03 << 14)
-
-#define S3C64XX_GPN8_EINT8		(0x02 << 16)
-#define S3C64XX_GPN9_EINT9		(0x02 << 18)
-#define S3C64XX_GPN10_EINT10		(0x02 << 20)
-#define S3C64XX_GPN11_EINT11		(0x02 << 22)
-#define S3C64XX_GPN12_EINT12		(0x02 << 24)
-#define S3C64XX_GPN13_EINT13		(0x02 << 26)
-#define S3C64XX_GPN14_EINT14		(0x02 << 28)
-#define S3C64XX_GPN15_EINT15		(0x02 << 30)
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-o.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-o.h
deleted file mode 100644
index 21868fa..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-o.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-o.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- * 	Ben Dooks <ben@simtec.co.uk>
- * 	http://armlinux.simtec.co.uk/
- *
- * GPIO Bank O register and configuration definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C64XX_GPOCON			(S3C64XX_GPO_BASE + 0x00)
-#define S3C64XX_GPODAT			(S3C64XX_GPO_BASE + 0x04)
-#define S3C64XX_GPOPUD			(S3C64XX_GPO_BASE + 0x08)
-#define S3C64XX_GPOCONSLP		(S3C64XX_GPO_BASE + 0x0c)
-#define S3C64XX_GPOPUDSLP		(S3C64XX_GPO_BASE + 0x10)
-
-#define S3C64XX_GPO_CONMASK(__gpio)	(0x3 << ((__gpio) * 2))
-#define S3C64XX_GPO_INPUT(__gpio)	(0x0 << ((__gpio) * 2))
-#define S3C64XX_GPO_OUTPUT(__gpio)	(0x1 << ((__gpio) * 2))
-
-#define S3C64XX_GPO0_MEM0_nCS2		(0x02 << 0)
-#define S3C64XX_GPO0_EINT_G7_0		(0x03 << 0)
-
-#define S3C64XX_GPO1_MEM0_nCS3		(0x02 << 2)
-#define S3C64XX_GPO1_EINT_G7_1		(0x03 << 2)
-
-#define S3C64XX_GPO2_MEM0_nCS4		(0x02 << 4)
-#define S3C64XX_GPO2_EINT_G7_2		(0x03 << 4)
-
-#define S3C64XX_GPO3_MEM0_nCS5		(0x02 << 6)
-#define S3C64XX_GPO3_EINT_G7_3		(0x03 << 6)
-
-#define S3C64XX_GPO4_EINT_G7_4		(0x03 << 8)
-
-#define S3C64XX_GPO5_EINT_G7_5		(0x03 << 10)
-
-#define S3C64XX_GPO6_MEM0_ADDR6		(0x02 << 12)
-#define S3C64XX_GPO6_EINT_G7_6		(0x03 << 12)
-
-#define S3C64XX_GPO7_MEM0_ADDR7		(0x02 << 14)
-#define S3C64XX_GPO7_EINT_G7_7		(0x03 << 14)
-
-#define S3C64XX_GPO8_MEM0_ADDR8		(0x02 << 16)
-#define S3C64XX_GPO8_EINT_G7_8		(0x03 << 16)
-
-#define S3C64XX_GPO9_MEM0_ADDR9		(0x02 << 18)
-#define S3C64XX_GPO9_EINT_G7_9		(0x03 << 18)
-
-#define S3C64XX_GPO10_MEM0_ADDR10	(0x02 << 20)
-#define S3C64XX_GPO10_EINT_G7_10	(0x03 << 20)
-
-#define S3C64XX_GPO11_MEM0_ADDR11	(0x02 << 22)
-#define S3C64XX_GPO11_EINT_G7_11	(0x03 << 22)
-
-#define S3C64XX_GPO12_MEM0_ADDR12	(0x02 << 24)
-#define S3C64XX_GPO12_EINT_G7_12	(0x03 << 24)
-
-#define S3C64XX_GPO13_MEM0_ADDR13	(0x02 << 26)
-#define S3C64XX_GPO13_EINT_G7_13	(0x03 << 26)
-
-#define S3C64XX_GPO14_MEM0_ADDR14	(0x02 << 28)
-#define S3C64XX_GPO14_EINT_G7_14	(0x03 << 28)
-
-#define S3C64XX_GPO15_MEM0_ADDR15	(0x02 << 30)
-#define S3C64XX_GPO15_EINT_G7_15	(0x03 << 30)
-
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-p.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-p.h
deleted file mode 100644
index 46bcfb6..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-p.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-p.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- * 	Ben Dooks <ben@simtec.co.uk>
- * 	http://armlinux.simtec.co.uk/
- *
- * GPIO Bank P register and configuration definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C64XX_GPPCON			(S3C64XX_GPP_BASE + 0x00)
-#define S3C64XX_GPPDAT			(S3C64XX_GPP_BASE + 0x04)
-#define S3C64XX_GPPPUD			(S3C64XX_GPP_BASE + 0x08)
-#define S3C64XX_GPPCONSLP		(S3C64XX_GPP_BASE + 0x0c)
-#define S3C64XX_GPPPUDSLP		(S3C64XX_GPP_BASE + 0x10)
-
-#define S3C64XX_GPP_CONMASK(__gpio)	(0x3 << ((__gpio) * 2))
-#define S3C64XX_GPP_INPUT(__gpio)	(0x0 << ((__gpio) * 2))
-#define S3C64XX_GPP_OUTPUT(__gpio)	(0x1 << ((__gpio) * 2))
-
-#define S3C64XX_GPP0_MEM0_ADDRV		(0x02 << 0)
-#define S3C64XX_GPP0_EINT_G8_0		(0x03 << 0)
-
-#define S3C64XX_GPP1_MEM0_SMCLK		(0x02 << 2)
-#define S3C64XX_GPP1_EINT_G8_1		(0x03 << 2)
-
-#define S3C64XX_GPP2_MEM0_nWAIT		(0x02 << 4)
-#define S3C64XX_GPP2_EINT_G8_2		(0x03 << 4)
-
-#define S3C64XX_GPP3_MEM0_RDY0_ALE	(0x02 << 6)
-#define S3C64XX_GPP3_EINT_G8_3		(0x03 << 6)
-
-#define S3C64XX_GPP4_MEM0_RDY1_CLE	(0x02 << 8)
-#define S3C64XX_GPP4_EINT_G8_4		(0x03 << 8)
-
-#define S3C64XX_GPP5_MEM0_INTsm0_FWE	(0x02 << 10)
-#define S3C64XX_GPP5_EINT_G8_5		(0x03 << 10)
-
-#define S3C64XX_GPP6_MEM0_(null)	(0x02 << 12)
-#define S3C64XX_GPP6_EINT_G8_6		(0x03 << 12)
-
-#define S3C64XX_GPP7_MEM0_INTsm1_FRE	(0x02 << 14)
-#define S3C64XX_GPP7_EINT_G8_7		(0x03 << 14)
-
-#define S3C64XX_GPP8_MEM0_RPn_RnB	(0x02 << 16)
-#define S3C64XX_GPP8_EINT_G8_8		(0x03 << 16)
-
-#define S3C64XX_GPP9_MEM0_ATA_RESET	(0x02 << 18)
-#define S3C64XX_GPP9_EINT_G8_9		(0x03 << 18)
-
-#define S3C64XX_GPP10_MEM0_ATA_INPACK	(0x02 << 20)
-#define S3C64XX_GPP10_EINT_G8_10	(0x03 << 20)
-
-#define S3C64XX_GPP11_MEM0_ATA_REG	(0x02 << 22)
-#define S3C64XX_GPP11_EINT_G8_11	(0x03 << 22)
-
-#define S3C64XX_GPP12_MEM0_ATA_WE	(0x02 << 24)
-#define S3C64XX_GPP12_EINT_G8_12	(0x03 << 24)
-
-#define S3C64XX_GPP13_MEM0_ATA_OE	(0x02 << 26)
-#define S3C64XX_GPP13_EINT_G8_13	(0x03 << 26)
-
-#define S3C64XX_GPP14_MEM0_ATA_CD	(0x02 << 28)
-#define S3C64XX_GPP14_EINT_G8_14	(0x03 << 28)
-
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-q.h b/arch/arm/mach-s3c64xx/include/mach/gpio-bank-q.h
deleted file mode 100644
index 1712223..0000000
--- a/arch/arm/mach-s3c64xx/include/mach/gpio-bank-q.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/* linux/arch/arm/mach-s3c64xx/include/mach/gpio-bank-q.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- * 	Ben Dooks <ben@simtec.co.uk>
- * 	http://armlinux.simtec.co.uk/
- *
- * GPIO Bank Q register and configuration definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#define S3C64XX_GPQCON			(S3C64XX_GPQ_BASE + 0x00)
-#define S3C64XX_GPQDAT			(S3C64XX_GPQ_BASE + 0x04)
-#define S3C64XX_GPQPUD			(S3C64XX_GPQ_BASE + 0x08)
-#define S3C64XX_GPQCONSLP		(S3C64XX_GPQ_BASE + 0x0c)
-#define S3C64XX_GPQPUDSLP		(S3C64XX_GPQ_BASE + 0x10)
-
-#define S3C64XX_GPQ_CONMASK(__gpio)	(0x3 << ((__gpio) * 2))
-#define S3C64XX_GPQ_INPUT(__gpio)	(0x0 << ((__gpio) * 2))
-#define S3C64XX_GPQ_OUTPUT(__gpio)	(0x1 << ((__gpio) * 2))
-
-#define S3C64XX_GPQ0_MEM0_ADDR18_RAS	(0x02 << 0)
-#define S3C64XX_GPQ0_EINT_G9_0		(0x03 << 0)
-
-#define S3C64XX_GPQ1_MEM0_ADDR19_CAS	(0x02 << 2)
-#define S3C64XX_GPQ1_EINT_G9_1		(0x03 << 2)
-
-#define S3C64XX_GPQ2_EINT_G9_2		(0x03 << 4)
-
-#define S3C64XX_GPQ3_EINT_G9_3		(0x03 << 6)
-
-#define S3C64XX_GPQ4_EINT_G9_4		(0x03 << 8)
-
-#define S3C64XX_GPQ5_EINT_G9_5		(0x03 << 10)
-
-#define S3C64XX_GPQ6_EINT_G9_6		(0x03 << 12)
-
-#define S3C64XX_GPQ7_MEM0_ADDR17_WENDMC	(0x02 << 14)
-#define S3C64XX_GPQ7_EINT_G9_7		(0x03 << 14)
-
-#define S3C64XX_GPQ8_MEM0_ADDR16_APDMC	(0x02 << 16)
-#define S3C64XX_GPQ8_EINT_G9_8		(0x03 << 16)
-
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 686a4f2..2c0353a 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -50,7 +50,6 @@
 #include <mach/hardware.h>
 #include <mach/regs-fb.h>
 #include <mach/map.h>
-#include <mach/gpio-bank-f.h>
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 79412f7..bc1c470 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -30,26 +30,18 @@
 #include <mach/regs-gpio-memport.h>
 
 #ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
-#include <mach/gpio-bank-n.h>
-
 void s3c_pm_debug_smdkled(u32 set, u32 clear)
 {
 	unsigned long flags;
-	u32 reg;
+	int i;
 
 	local_irq_save(flags);
-	reg = __raw_readl(S3C64XX_GPNCON);
-	reg &= ~(S3C64XX_GPN_CONMASK(12) | S3C64XX_GPN_CONMASK(13) |
-		 S3C64XX_GPN_CONMASK(14) | S3C64XX_GPN_CONMASK(15));
-	reg |= S3C64XX_GPN_OUTPUT(12) | S3C64XX_GPN_OUTPUT(13) |
-	       S3C64XX_GPN_OUTPUT(14) | S3C64XX_GPN_OUTPUT(15);
-	__raw_writel(reg, S3C64XX_GPNCON);
-
-	reg = __raw_readl(S3C64XX_GPNDAT);
-	reg &= ~(clear << 12);
-	reg |= set << 12;
-	__raw_writel(reg, S3C64XX_GPNDAT);
-
+	for (i = 0; i < 4; i++) {
+		if (clear & (1 << i))
+			gpio_set_value(S3C64XX_GPN(12 + i), 0);
+		if (set & (1 << i))
+			gpio_set_value(S3C64XX_GPN(12 + i), 1);
+	}
 	local_irq_restore(flags);
 }
 #endif
@@ -187,6 +179,18 @@ static int s3c64xx_pm_init(void)
 	pm_cpu_prep = s3c64xx_pm_prepare;
 	pm_cpu_sleep = s3c64xx_cpu_suspend;
 	pm_uart_udivslot = 1;
+
+#ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
+	gpio_request(S3C64XX_GPN(12), "DEBUG_LED0");
+	gpio_request(S3C64XX_GPN(13), "DEBUG_LED1");
+	gpio_request(S3C64XX_GPN(14), "DEBUG_LED2");
+	gpio_request(S3C64XX_GPN(15), "DEBUG_LED3");
+	gpio_direction_output(S3C64XX_GPN(12), 0);
+	gpio_direction_output(S3C64XX_GPN(13), 0);
+	gpio_direction_output(S3C64XX_GPN(14), 0);
+	gpio_direction_output(S3C64XX_GPN(15), 0);
+#endif
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-s3c64xx/setup-i2c0.c b/arch/arm/mach-s3c64xx/setup-i2c0.c
index 406192a..241af94 100644
--- a/arch/arm/mach-s3c64xx/setup-i2c0.c
+++ b/arch/arm/mach-s3c64xx/setup-i2c0.c
@@ -18,14 +18,11 @@
 
 struct platform_device; /* don't need the contents */
 
-#include <mach/gpio-bank-b.h>
 #include <plat/iic.h>
 #include <plat/gpio-cfg.h>
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgpin(S3C64XX_GPB(5), S3C64XX_GPB5_I2C_SCL0);
-	s3c_gpio_cfgpin(S3C64XX_GPB(6), S3C64XX_GPB6_I2C_SDA0);
-	s3c_gpio_setpull(S3C64XX_GPB(5), S3C_GPIO_PULL_UP);
-	s3c_gpio_setpull(S3C64XX_GPB(6), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S3C64XX_GPB(5), 2,
+			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s3c64xx/setup-i2c1.c b/arch/arm/mach-s3c64xx/setup-i2c1.c
index 1ee62c9..3d13a96 100644
--- a/arch/arm/mach-s3c64xx/setup-i2c1.c
+++ b/arch/arm/mach-s3c64xx/setup-i2c1.c
@@ -18,14 +18,11 @@
 
 struct platform_device; /* don't need the contents */
 
-#include <mach/gpio-bank-b.h>
 #include <plat/iic.h>
 #include <plat/gpio-cfg.h>
 
 void s3c_i2c1_cfg_gpio(struct platform_device *dev)
 {
-	s3c_gpio_cfgpin(S3C64XX_GPB(2), S3C64XX_GPB2_I2C_SCL1);
-	s3c_gpio_cfgpin(S3C64XX_GPB(3), S3C64XX_GPB3_I2C_SDA1);
-	s3c_gpio_setpull(S3C64XX_GPB(2), S3C_GPIO_PULL_UP);
-	s3c_gpio_setpull(S3C64XX_GPB(3), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgall_range(S3C64XX_GPB(2), 2,
+			      S3C_GPIO_SFN(6), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s3c64xx/sleep.S b/arch/arm/mach-s3c64xx/sleep.S
index afe5a76..1f87732 100644
--- a/arch/arm/mach-s3c64xx/sleep.S
+++ b/arch/arm/mach-s3c64xx/sleep.S
@@ -20,7 +20,6 @@
 #define S3C64XX_VA_GPIO (0x0)
 
 #include <mach/regs-gpio.h>
-#include <mach/gpio-bank-n.h>
 
 #define LL_UART (S3C_PA_UART + (0x400 * CONFIG_S3C_LOWLEVEL_UART_PORT))
 
@@ -68,6 +67,13 @@ ENTRY(s3c_cpu_resume)
 	ldr	r2, =LL_UART		/* for debug */
 
 #ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
+
+#define S3C64XX_GPNCON			(S3C64XX_GPN_BASE + 0x00)
+#define S3C64XX_GPNDAT			(S3C64XX_GPN_BASE + 0x04)
+
+#define S3C64XX_GPN_CONMASK(__gpio)	(0x3 << ((__gpio) * 2))
+#define S3C64XX_GPN_OUTPUT(__gpio)	(0x1 << ((__gpio) * 2))
+
 	/* Initialise the GPIO state if we are debugging via the SMDK LEDs,
 	 * as the uboot version supplied resets these to inputs during the
 	 * resume checks.
-- 
1.7.1
