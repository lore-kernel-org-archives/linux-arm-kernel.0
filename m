From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 26 Jan 2010 07:02:56 +0000
Subject: [PATCH] ARM: S3C64XX: Move register definition headers to machine
	include directory
In-Reply-To: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
References: <1264489385-13345-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1264489385-13345-6-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the register definition files from plat-s3c64xx into the machine
include direcotry as they are unlikely to be reused outside mach-s3c64xx.

This move includes removing the empty <mach/regs-clock.h> and replacing
it with the <plat/regs-clock.h> implementation.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/include/mach/regs-clock.h    |  148 ++++++++++++++++++-
 .../include/mach}/regs-gpio-memport.h              |    0
 .../plat => mach-s3c64xx/include/mach}/regs-gpio.h |    0
 .../include/mach}/regs-modem.h                     |    0
 .../plat => mach-s3c64xx/include/mach}/regs-srom.h |    0
 .../plat => mach-s3c64xx/include/mach}/regs-sys.h  |    0
 .../include/mach}/regs-syscon-power.h              |    0
 arch/arm/mach-s3c64xx/mach-anw6410.c               |    4 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |    8 +-
 arch/arm/mach-s3c64xx/s3c6400.c                    |    2 +-
 arch/arm/mach-s3c64xx/s3c6410.c                    |    2 +-
 arch/arm/plat-s3c64xx/clock.c                      |    4 +-
 arch/arm/plat-s3c64xx/dma.c                        |    2 +-
 arch/arm/plat-s3c64xx/gpiolib.c                    |    2 +-
 arch/arm/plat-s3c64xx/include/plat/regs-clock.h    |  156 --------------------
 arch/arm/plat-s3c64xx/irq-eint.c                   |    2 +-
 arch/arm/plat-s3c64xx/irq-pm.c                     |    2 +-
 arch/arm/plat-s3c64xx/pm.c                         |   10 +-
 arch/arm/plat-s3c64xx/s3c6400-clock.c              |    2 +-
 19 files changed, 164 insertions(+), 180 deletions(-)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/regs-gpio-memport.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/regs-gpio.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/regs-modem.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/regs-srom.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/regs-sys.h (100%)
 rename arch/arm/{plat-s3c64xx/include/plat => mach-s3c64xx/include/mach}/regs-syscon-power.h (100%)
 delete mode 100644 arch/arm/plat-s3c64xx/include/plat/regs-clock.h

diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
index a6c7f4e..3ef6274 100644
--- a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
+++ b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
@@ -1,16 +1,156 @@
-/* linux/arch/arm/mach-s3c6400/include/mach/regs-clock.h
+/* arch/arm/plat-s3c64xx/include/plat/regs-clock.h
  *
  * Copyright 2008 Openmoko, Inc.
  * Copyright 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
  *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
  *
- * S3C64XX - clock register compatibility with s3c24xx
+ * S3C64XX clock register definitions
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
 */
 
-#include <plat/regs-clock.h>
+#ifndef __PLAT_REGS_CLOCK_H
+#define __PLAT_REGS_CLOCK_H __FILE__
+
+#define S3C_CLKREG(x)		(S3C_VA_SYS + (x))
+
+#define S3C_APLL_LOCK		S3C_CLKREG(0x00)
+#define S3C_MPLL_LOCK		S3C_CLKREG(0x04)
+#define S3C_EPLL_LOCK		S3C_CLKREG(0x08)
+#define S3C_APLL_CON		S3C_CLKREG(0x0C)
+#define S3C_MPLL_CON		S3C_CLKREG(0x10)
+#define S3C_EPLL_CON0		S3C_CLKREG(0x14)
+#define S3C_EPLL_CON1		S3C_CLKREG(0x18)
+#define S3C_CLK_SRC		S3C_CLKREG(0x1C)
+#define S3C_CLK_DIV0		S3C_CLKREG(0x20)
+#define S3C_CLK_DIV1		S3C_CLKREG(0x24)
+#define S3C_CLK_DIV2		S3C_CLKREG(0x28)
+#define S3C_CLK_OUT		S3C_CLKREG(0x2C)
+#define S3C_HCLK_GATE		S3C_CLKREG(0x30)
+#define S3C_PCLK_GATE		S3C_CLKREG(0x34)
+#define S3C_SCLK_GATE		S3C_CLKREG(0x38)
+#define S3C_MEM0_GATE		S3C_CLKREG(0x3C)
+
+/* CLKDIV0 */
+#define S3C6400_CLKDIV0_PCLK_MASK	(0xf << 12)
+#define S3C6400_CLKDIV0_PCLK_SHIFT	(12)
+#define S3C6400_CLKDIV0_HCLK2_MASK	(0x7 << 9)
+#define S3C6400_CLKDIV0_HCLK2_SHIFT	(9)
+#define S3C6400_CLKDIV0_HCLK_MASK	(0x1 << 8)
+#define S3C6400_CLKDIV0_HCLK_SHIFT	(8)
+#define S3C6400_CLKDIV0_MPLL_MASK	(0x1 << 4)
+#define S3C6400_CLKDIV0_MPLL_SHIFT	(4)
+
+#define S3C6400_CLKDIV0_ARM_MASK	(0x7 << 0)
+#define S3C6410_CLKDIV0_ARM_MASK	(0xf << 0)
+#define S3C6400_CLKDIV0_ARM_SHIFT	(0)
+
+/* HCLK GATE Registers */
+#define S3C_CLKCON_HCLK_3DSE	(1<<31)
+#define S3C_CLKCON_HCLK_UHOST	(1<<29)
+#define S3C_CLKCON_HCLK_SECUR	(1<<28)
+#define S3C_CLKCON_HCLK_SDMA1	(1<<27)
+#define S3C_CLKCON_HCLK_SDMA0	(1<<26)
+#define S3C_CLKCON_HCLK_IROM	(1<<25)
+#define S3C_CLKCON_HCLK_DDR1	(1<<24)
+#define S3C_CLKCON_HCLK_DDR0	(1<<23)
+#define S3C_CLKCON_HCLK_MEM1	(1<<22)
+#define S3C_CLKCON_HCLK_MEM0	(1<<21)
+#define S3C_CLKCON_HCLK_USB	(1<<20)
+#define S3C_CLKCON_HCLK_HSMMC2	(1<<19)
+#define S3C_CLKCON_HCLK_HSMMC1	(1<<18)
+#define S3C_CLKCON_HCLK_HSMMC0	(1<<17)
+#define S3C_CLKCON_HCLK_MDP	(1<<16)
+#define S3C_CLKCON_HCLK_DHOST	(1<<15)
+#define S3C_CLKCON_HCLK_IHOST	(1<<14)
+#define S3C_CLKCON_HCLK_DMA1	(1<<13)
+#define S3C_CLKCON_HCLK_DMA0	(1<<12)
+#define S3C_CLKCON_HCLK_JPEG	(1<<11)
+#define S3C_CLKCON_HCLK_CAMIF	(1<<10)
+#define S3C_CLKCON_HCLK_SCALER	(1<<9)
+#define S3C_CLKCON_HCLK_2D	(1<<8)
+#define S3C_CLKCON_HCLK_TV	(1<<7)
+#define S3C_CLKCON_HCLK_POST0	(1<<5)
+#define S3C_CLKCON_HCLK_ROT	(1<<4)
+#define S3C_CLKCON_HCLK_LCD	(1<<3)
+#define S3C_CLKCON_HCLK_TZIC	(1<<2)
+#define S3C_CLKCON_HCLK_INTC	(1<<1)
+#define S3C_CLKCON_HCLK_MFC	(1<<0)
+
+/* PCLK GATE Registers */
+#define S3C6410_CLKCON_PCLK_I2C1	(1<<27)
+#define S3C6410_CLKCON_PCLK_IIS2	(1<<26)
+#define S3C_CLKCON_PCLK_SKEY		(1<<24)
+#define S3C_CLKCON_PCLK_CHIPID		(1<<23)
+#define S3C_CLKCON_PCLK_SPI1		(1<<22)
+#define S3C_CLKCON_PCLK_SPI0		(1<<21)
+#define S3C_CLKCON_PCLK_HSIRX		(1<<20)
+#define S3C_CLKCON_PCLK_HSITX		(1<<19)
+#define S3C_CLKCON_PCLK_GPIO		(1<<18)
+#define S3C_CLKCON_PCLK_IIC		(1<<17)
+#define S3C_CLKCON_PCLK_IIS1		(1<<16)
+#define S3C_CLKCON_PCLK_IIS0		(1<<15)
+#define S3C_CLKCON_PCLK_AC97		(1<<14)
+#define S3C_CLKCON_PCLK_TZPC		(1<<13)
+#define S3C_CLKCON_PCLK_TSADC		(1<<12)
+#define S3C_CLKCON_PCLK_KEYPAD		(1<<11)
+#define S3C_CLKCON_PCLK_IRDA		(1<<10)
+#define S3C_CLKCON_PCLK_PCM1		(1<<9)
+#define S3C_CLKCON_PCLK_PCM0		(1<<8)
+#define S3C_CLKCON_PCLK_PWM		(1<<7)
+#define S3C_CLKCON_PCLK_RTC		(1<<6)
+#define S3C_CLKCON_PCLK_WDT		(1<<5)
+#define S3C_CLKCON_PCLK_UART3		(1<<4)
+#define S3C_CLKCON_PCLK_UART2		(1<<3)
+#define S3C_CLKCON_PCLK_UART1		(1<<2)
+#define S3C_CLKCON_PCLK_UART0		(1<<1)
+#define S3C_CLKCON_PCLK_MFC		(1<<0)
+
+/* SCLK GATE Registers */
+#define S3C_CLKCON_SCLK_UHOST		(1<<30)
+#define S3C_CLKCON_SCLK_MMC2_48		(1<<29)
+#define S3C_CLKCON_SCLK_MMC1_48		(1<<28)
+#define S3C_CLKCON_SCLK_MMC0_48		(1<<27)
+#define S3C_CLKCON_SCLK_MMC2		(1<<26)
+#define S3C_CLKCON_SCLK_MMC1		(1<<25)
+#define S3C_CLKCON_SCLK_MMC0		(1<<24)
+#define S3C_CLKCON_SCLK_SPI1_48 	(1<<23)
+#define S3C_CLKCON_SCLK_SPI0_48 	(1<<22)
+#define S3C_CLKCON_SCLK_SPI1		(1<<21)
+#define S3C_CLKCON_SCLK_SPI0		(1<<20)
+#define S3C_CLKCON_SCLK_DAC27		(1<<19)
+#define S3C_CLKCON_SCLK_TV27		(1<<18)
+#define S3C_CLKCON_SCLK_SCALER27	(1<<17)
+#define S3C_CLKCON_SCLK_SCALER		(1<<16)
+#define S3C_CLKCON_SCLK_LCD27		(1<<15)
+#define S3C_CLKCON_SCLK_LCD		(1<<14)
+#define S3C6400_CLKCON_SCLK_POST1_27	(1<<13)
+#define S3C6410_CLKCON_FIMC		(1<<13)
+#define S3C_CLKCON_SCLK_POST0_27	(1<<12)
+#define S3C6400_CLKCON_SCLK_POST1	(1<<11)
+#define S3C6410_CLKCON_SCLK_AUDIO2	(1<<11)
+#define S3C_CLKCON_SCLK_POST0		(1<<10)
+#define S3C_CLKCON_SCLK_AUDIO1		(1<<9)
+#define S3C_CLKCON_SCLK_AUDIO0		(1<<8)
+#define S3C_CLKCON_SCLK_SECUR		(1<<7)
+#define S3C_CLKCON_SCLK_IRDA		(1<<6)
+#define S3C_CLKCON_SCLK_UART		(1<<5)
+#define S3C_CLKCON_SCLK_ONENAND 	(1<<4)
+#define S3C_CLKCON_SCLK_MFC		(1<<3)
+#define S3C_CLKCON_SCLK_CAM		(1<<2)
+#define S3C_CLKCON_SCLK_JPEG		(1<<1)
+
+/* CLKSRC */
+
+#define S3C6400_CLKSRC_APLL_MOUT	(1 << 0)
+#define S3C6400_CLKSRC_MPLL_MOUT	(1 << 1)
+#define S3C6400_CLKSRC_EPLL_MOUT	(1 << 2)
+#define S3C6400_CLKSRC_APLL_MOUT_SHIFT	(0)
+#define S3C6400_CLKSRC_MPLL_MOUT_SHIFT	(1)
+#define S3C6400_CLKSRC_EPLL_MOUT_SHIFT	(2)
+#define S3C6400_CLKSRC_MFC		(1 << 4)
 
+#endif /* _PLAT_REGS_CLOCK_H */
diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-gpio-memport.h b/arch/arm/mach-s3c64xx/include/mach/regs-gpio-memport.h
similarity index 100%
rename from arch/arm/plat-s3c64xx/include/plat/regs-gpio-memport.h
rename to arch/arm/mach-s3c64xx/include/mach/regs-gpio-memport.h
diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-gpio.h b/arch/arm/mach-s3c64xx/include/mach/regs-gpio.h
similarity index 100%
rename from arch/arm/plat-s3c64xx/include/plat/regs-gpio.h
rename to arch/arm/mach-s3c64xx/include/mach/regs-gpio.h
diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-modem.h b/arch/arm/mach-s3c64xx/include/mach/regs-modem.h
similarity index 100%
rename from arch/arm/plat-s3c64xx/include/plat/regs-modem.h
rename to arch/arm/mach-s3c64xx/include/mach/regs-modem.h
diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-srom.h b/arch/arm/mach-s3c64xx/include/mach/regs-srom.h
similarity index 100%
rename from arch/arm/plat-s3c64xx/include/plat/regs-srom.h
rename to arch/arm/mach-s3c64xx/include/mach/regs-srom.h
diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-sys.h b/arch/arm/mach-s3c64xx/include/mach/regs-sys.h
similarity index 100%
rename from arch/arm/plat-s3c64xx/include/plat/regs-sys.h
rename to arch/arm/mach-s3c64xx/include/mach/regs-sys.h
diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-syscon-power.h b/arch/arm/mach-s3c64xx/include/mach/regs-syscon-power.h
similarity index 100%
rename from arch/arm/plat-s3c64xx/include/plat/regs-syscon-power.h
rename to arch/arm/mach-s3c64xx/include/mach/regs-syscon-power.h
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index 49032a8..06d8fe5 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -49,8 +49,8 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
-#include <plat/regs-gpio.h>
-#include <plat/regs-modem.h>
+#include <mach/regs-gpio.h>
+#include <mach/regs-modem.h>
 
 /* DM9000 */
 #define ANW6410_PA_DM9000	(0x18000000)
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 6e6ff35..021670e 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -46,10 +46,10 @@
 #include <asm/mach-types.h>
 
 #include <plat/regs-serial.h>
-#include <plat/regs-modem.h>
-#include <plat/regs-gpio.h>
-#include <plat/regs-sys.h>
-#include <plat/regs-srom.h>
+#include <mach/regs-modem.h>
+#include <mach/regs-gpio.h>
+#include <mach/regs-sys.h>
+#include <mach/regs-srom.h>
 #include <plat/iic.h>
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
index 884858a..2fba1b2 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -30,7 +30,7 @@
 
 #include <plat/cpu-freq.h>
 #include <plat/regs-serial.h>
-#include <plat/regs-clock.h>
+#include <mach/regs-clock.h>
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 185f15c..b881d6a 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -31,7 +31,7 @@
 
 #include <plat/cpu-freq.h>
 #include <plat/regs-serial.h>
-#include <plat/regs-clock.h>
+#include <mach/regs-clock.h>
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
diff --git a/arch/arm/plat-s3c64xx/clock.c b/arch/arm/plat-s3c64xx/clock.c
index 2989c3a..64439de 100644
--- a/arch/arm/plat-s3c64xx/clock.c
+++ b/arch/arm/plat-s3c64xx/clock.c
@@ -21,8 +21,8 @@
 #include <mach/hardware.h>
 #include <mach/map.h>
 
-#include <plat/regs-sys.h>
-#include <plat/regs-clock.h>
+#include <mach/regs-sys.h>
+#include <mach/regs-clock.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/clock.h>
diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
index d554b93..0e0edf7 100644
--- a/arch/arm/plat-s3c64xx/dma.c
+++ b/arch/arm/plat-s3c64xx/dma.c
@@ -28,7 +28,7 @@
 #include <mach/irqs.h>
 
 #include <plat/dma-plat.h>
-#include <plat/regs-sys.h>
+#include <mach/regs-sys.h>
 
 #include <asm/hardware/pl080.h>
 
diff --git a/arch/arm/plat-s3c64xx/gpiolib.c b/arch/arm/plat-s3c64xx/gpiolib.c
index b6e3f55..66e6794 100644
--- a/arch/arm/plat-s3c64xx/gpiolib.c
+++ b/arch/arm/plat-s3c64xx/gpiolib.c
@@ -22,7 +22,7 @@
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
-#include <plat/regs-gpio.h>
+#include <mach/regs-gpio.h>
 
 /* GPIO bank summary:
  *
diff --git a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h b/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
deleted file mode 100644
index 3ef6274..0000000
--- a/arch/arm/plat-s3c64xx/include/plat/regs-clock.h
+++ /dev/null
@@ -1,156 +0,0 @@
-/* arch/arm/plat-s3c64xx/include/plat/regs-clock.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C64XX clock register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __PLAT_REGS_CLOCK_H
-#define __PLAT_REGS_CLOCK_H __FILE__
-
-#define S3C_CLKREG(x)		(S3C_VA_SYS + (x))
-
-#define S3C_APLL_LOCK		S3C_CLKREG(0x00)
-#define S3C_MPLL_LOCK		S3C_CLKREG(0x04)
-#define S3C_EPLL_LOCK		S3C_CLKREG(0x08)
-#define S3C_APLL_CON		S3C_CLKREG(0x0C)
-#define S3C_MPLL_CON		S3C_CLKREG(0x10)
-#define S3C_EPLL_CON0		S3C_CLKREG(0x14)
-#define S3C_EPLL_CON1		S3C_CLKREG(0x18)
-#define S3C_CLK_SRC		S3C_CLKREG(0x1C)
-#define S3C_CLK_DIV0		S3C_CLKREG(0x20)
-#define S3C_CLK_DIV1		S3C_CLKREG(0x24)
-#define S3C_CLK_DIV2		S3C_CLKREG(0x28)
-#define S3C_CLK_OUT		S3C_CLKREG(0x2C)
-#define S3C_HCLK_GATE		S3C_CLKREG(0x30)
-#define S3C_PCLK_GATE		S3C_CLKREG(0x34)
-#define S3C_SCLK_GATE		S3C_CLKREG(0x38)
-#define S3C_MEM0_GATE		S3C_CLKREG(0x3C)
-
-/* CLKDIV0 */
-#define S3C6400_CLKDIV0_PCLK_MASK	(0xf << 12)
-#define S3C6400_CLKDIV0_PCLK_SHIFT	(12)
-#define S3C6400_CLKDIV0_HCLK2_MASK	(0x7 << 9)
-#define S3C6400_CLKDIV0_HCLK2_SHIFT	(9)
-#define S3C6400_CLKDIV0_HCLK_MASK	(0x1 << 8)
-#define S3C6400_CLKDIV0_HCLK_SHIFT	(8)
-#define S3C6400_CLKDIV0_MPLL_MASK	(0x1 << 4)
-#define S3C6400_CLKDIV0_MPLL_SHIFT	(4)
-
-#define S3C6400_CLKDIV0_ARM_MASK	(0x7 << 0)
-#define S3C6410_CLKDIV0_ARM_MASK	(0xf << 0)
-#define S3C6400_CLKDIV0_ARM_SHIFT	(0)
-
-/* HCLK GATE Registers */
-#define S3C_CLKCON_HCLK_3DSE	(1<<31)
-#define S3C_CLKCON_HCLK_UHOST	(1<<29)
-#define S3C_CLKCON_HCLK_SECUR	(1<<28)
-#define S3C_CLKCON_HCLK_SDMA1	(1<<27)
-#define S3C_CLKCON_HCLK_SDMA0	(1<<26)
-#define S3C_CLKCON_HCLK_IROM	(1<<25)
-#define S3C_CLKCON_HCLK_DDR1	(1<<24)
-#define S3C_CLKCON_HCLK_DDR0	(1<<23)
-#define S3C_CLKCON_HCLK_MEM1	(1<<22)
-#define S3C_CLKCON_HCLK_MEM0	(1<<21)
-#define S3C_CLKCON_HCLK_USB	(1<<20)
-#define S3C_CLKCON_HCLK_HSMMC2	(1<<19)
-#define S3C_CLKCON_HCLK_HSMMC1	(1<<18)
-#define S3C_CLKCON_HCLK_HSMMC0	(1<<17)
-#define S3C_CLKCON_HCLK_MDP	(1<<16)
-#define S3C_CLKCON_HCLK_DHOST	(1<<15)
-#define S3C_CLKCON_HCLK_IHOST	(1<<14)
-#define S3C_CLKCON_HCLK_DMA1	(1<<13)
-#define S3C_CLKCON_HCLK_DMA0	(1<<12)
-#define S3C_CLKCON_HCLK_JPEG	(1<<11)
-#define S3C_CLKCON_HCLK_CAMIF	(1<<10)
-#define S3C_CLKCON_HCLK_SCALER	(1<<9)
-#define S3C_CLKCON_HCLK_2D	(1<<8)
-#define S3C_CLKCON_HCLK_TV	(1<<7)
-#define S3C_CLKCON_HCLK_POST0	(1<<5)
-#define S3C_CLKCON_HCLK_ROT	(1<<4)
-#define S3C_CLKCON_HCLK_LCD	(1<<3)
-#define S3C_CLKCON_HCLK_TZIC	(1<<2)
-#define S3C_CLKCON_HCLK_INTC	(1<<1)
-#define S3C_CLKCON_HCLK_MFC	(1<<0)
-
-/* PCLK GATE Registers */
-#define S3C6410_CLKCON_PCLK_I2C1	(1<<27)
-#define S3C6410_CLKCON_PCLK_IIS2	(1<<26)
-#define S3C_CLKCON_PCLK_SKEY		(1<<24)
-#define S3C_CLKCON_PCLK_CHIPID		(1<<23)
-#define S3C_CLKCON_PCLK_SPI1		(1<<22)
-#define S3C_CLKCON_PCLK_SPI0		(1<<21)
-#define S3C_CLKCON_PCLK_HSIRX		(1<<20)
-#define S3C_CLKCON_PCLK_HSITX		(1<<19)
-#define S3C_CLKCON_PCLK_GPIO		(1<<18)
-#define S3C_CLKCON_PCLK_IIC		(1<<17)
-#define S3C_CLKCON_PCLK_IIS1		(1<<16)
-#define S3C_CLKCON_PCLK_IIS0		(1<<15)
-#define S3C_CLKCON_PCLK_AC97		(1<<14)
-#define S3C_CLKCON_PCLK_TZPC		(1<<13)
-#define S3C_CLKCON_PCLK_TSADC		(1<<12)
-#define S3C_CLKCON_PCLK_KEYPAD		(1<<11)
-#define S3C_CLKCON_PCLK_IRDA		(1<<10)
-#define S3C_CLKCON_PCLK_PCM1		(1<<9)
-#define S3C_CLKCON_PCLK_PCM0		(1<<8)
-#define S3C_CLKCON_PCLK_PWM		(1<<7)
-#define S3C_CLKCON_PCLK_RTC		(1<<6)
-#define S3C_CLKCON_PCLK_WDT		(1<<5)
-#define S3C_CLKCON_PCLK_UART3		(1<<4)
-#define S3C_CLKCON_PCLK_UART2		(1<<3)
-#define S3C_CLKCON_PCLK_UART1		(1<<2)
-#define S3C_CLKCON_PCLK_UART0		(1<<1)
-#define S3C_CLKCON_PCLK_MFC		(1<<0)
-
-/* SCLK GATE Registers */
-#define S3C_CLKCON_SCLK_UHOST		(1<<30)
-#define S3C_CLKCON_SCLK_MMC2_48		(1<<29)
-#define S3C_CLKCON_SCLK_MMC1_48		(1<<28)
-#define S3C_CLKCON_SCLK_MMC0_48		(1<<27)
-#define S3C_CLKCON_SCLK_MMC2		(1<<26)
-#define S3C_CLKCON_SCLK_MMC1		(1<<25)
-#define S3C_CLKCON_SCLK_MMC0		(1<<24)
-#define S3C_CLKCON_SCLK_SPI1_48 	(1<<23)
-#define S3C_CLKCON_SCLK_SPI0_48 	(1<<22)
-#define S3C_CLKCON_SCLK_SPI1		(1<<21)
-#define S3C_CLKCON_SCLK_SPI0		(1<<20)
-#define S3C_CLKCON_SCLK_DAC27		(1<<19)
-#define S3C_CLKCON_SCLK_TV27		(1<<18)
-#define S3C_CLKCON_SCLK_SCALER27	(1<<17)
-#define S3C_CLKCON_SCLK_SCALER		(1<<16)
-#define S3C_CLKCON_SCLK_LCD27		(1<<15)
-#define S3C_CLKCON_SCLK_LCD		(1<<14)
-#define S3C6400_CLKCON_SCLK_POST1_27	(1<<13)
-#define S3C6410_CLKCON_FIMC		(1<<13)
-#define S3C_CLKCON_SCLK_POST0_27	(1<<12)
-#define S3C6400_CLKCON_SCLK_POST1	(1<<11)
-#define S3C6410_CLKCON_SCLK_AUDIO2	(1<<11)
-#define S3C_CLKCON_SCLK_POST0		(1<<10)
-#define S3C_CLKCON_SCLK_AUDIO1		(1<<9)
-#define S3C_CLKCON_SCLK_AUDIO0		(1<<8)
-#define S3C_CLKCON_SCLK_SECUR		(1<<7)
-#define S3C_CLKCON_SCLK_IRDA		(1<<6)
-#define S3C_CLKCON_SCLK_UART		(1<<5)
-#define S3C_CLKCON_SCLK_ONENAND 	(1<<4)
-#define S3C_CLKCON_SCLK_MFC		(1<<3)
-#define S3C_CLKCON_SCLK_CAM		(1<<2)
-#define S3C_CLKCON_SCLK_JPEG		(1<<1)
-
-/* CLKSRC */
-
-#define S3C6400_CLKSRC_APLL_MOUT	(1 << 0)
-#define S3C6400_CLKSRC_MPLL_MOUT	(1 << 1)
-#define S3C6400_CLKSRC_EPLL_MOUT	(1 << 2)
-#define S3C6400_CLKSRC_APLL_MOUT_SHIFT	(0)
-#define S3C6400_CLKSRC_MPLL_MOUT_SHIFT	(1)
-#define S3C6400_CLKSRC_EPLL_MOUT_SHIFT	(2)
-#define S3C6400_CLKSRC_MFC		(1 << 4)
-
-#endif /* _PLAT_REGS_CLOCK_H */
diff --git a/arch/arm/plat-s3c64xx/irq-eint.c b/arch/arm/plat-s3c64xx/irq-eint.c
index ebdf183..5682d6a 100644
--- a/arch/arm/plat-s3c64xx/irq-eint.c
+++ b/arch/arm/plat-s3c64xx/irq-eint.c
@@ -22,7 +22,7 @@
 #include <asm/hardware/vic.h>
 
 #include <plat/regs-irqtype.h>
-#include <plat/regs-gpio.h>
+#include <mach/regs-gpio.h>
 #include <plat/gpio-cfg.h>
 
 #include <mach/map.h>
diff --git a/arch/arm/plat-s3c64xx/irq-pm.c b/arch/arm/plat-s3c64xx/irq-pm.c
index ca523b5..da1bec6 100644
--- a/arch/arm/plat-s3c64xx/irq-pm.c
+++ b/arch/arm/plat-s3c64xx/irq-pm.c
@@ -23,7 +23,7 @@
 
 #include <plat/regs-serial.h>
 #include <plat/regs-timer.h>
-#include <plat/regs-gpio.h>
+#include <mach/regs-gpio.h>
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
diff --git a/arch/arm/plat-s3c64xx/pm.c b/arch/arm/plat-s3c64xx/pm.c
index 8ad9ab1..b8ac459 100644
--- a/arch/arm/plat-s3c64xx/pm.c
+++ b/arch/arm/plat-s3c64xx/pm.c
@@ -20,11 +20,11 @@
 #include <mach/map.h>
 
 #include <plat/pm.h>
-#include <plat/regs-sys.h>
-#include <plat/regs-gpio.h>
-#include <plat/regs-clock.h>
-#include <plat/regs-syscon-power.h>
-#include <plat/regs-gpio-memport.h>
+#include <mach/regs-sys.h>
+#include <mach/regs-gpio.h>
+#include <mach/regs-clock.h>
+#include <mach/regs-syscon-power.h>
+#include <mach/regs-gpio-memport.h>
 
 #ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
 #include <mach/gpio-bank-n.h>
diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
index cb2bf4b..85f7bb0 100644
--- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
+++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
@@ -27,7 +27,7 @@
 
 #include <plat/cpu-freq.h>
 
-#include <plat/regs-clock.h>
+#include <mach/regs-clock.h>
 #include <plat/clock.h>
 #include <plat/clock-clksrc.h>
 #include <plat/cpu.h>
-- 
1.6.0.4
