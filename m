From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu,  6 Jun 2013 01:57:31 +0200
Subject: [PATCH 7/7] ARM: s3c64xx: Remove old clock management code
In-Reply-To: <1370476651-6743-1-git-send-email-tomasz.figa@gmail.com>
References: <1370476651-6743-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1370476651-6743-8-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes old clock management code of S3C64xx, since the
platform has been already moved to the new clock driver using Common
Clock Framework.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/clock.c                   | 1007 -----------------------
 arch/arm/mach-s3c64xx/common.h                  |    2 -
 arch/arm/mach-s3c64xx/include/mach/regs-clock.h |  132 +--
 arch/arm/mach-s3c64xx/pm.c                      |   21 -
 4 files changed, 4 insertions(+), 1158 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/clock.c

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
deleted file mode 100644
index c1bcc4a..0000000
diff --git a/arch/arm/mach-s3c64xx/common.h b/arch/arm/mach-s3c64xx/common.h
index 76ce4fe..0184abf 100644
--- a/arch/arm/mach-s3c64xx/common.h
+++ b/arch/arm/mach-s3c64xx/common.h
@@ -35,7 +35,6 @@ extern void s3c6400_init_irq(void);
 extern void s3c6400_map_io(void);
 
 #else
-#define s3c6400_init_clocks NULL
 #define s3c6400_map_io NULL
 #define s3c6400_init NULL
 #endif
@@ -47,7 +46,6 @@ extern void s3c6410_init_irq(void);
 extern void s3c6410_map_io(void);
 
 #else
-#define s3c6410_init_clocks NULL
 #define s3c6410_map_io NULL
 #define s3c6410_init NULL
 #endif
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
index 05332b9..4f44aac 100644
--- a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
+++ b/arch/arm/mach-s3c64xx/include/mach/regs-clock.h
@@ -15,145 +15,21 @@
 #ifndef __PLAT_REGS_CLOCK_H
 #define __PLAT_REGS_CLOCK_H __FILE__
 
+/*
+ * FIXME: Remove remaining definitions
+ */
+
 #define S3C_CLKREG(x)		(S3C_VA_SYS + (x))
 
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
 #define S3C_PCLK_GATE		S3C_CLKREG(0x34)
-#define S3C_SCLK_GATE		S3C_CLKREG(0x38)
-#define S3C_MEM0_GATE		S3C_CLKREG(0x3C)
 #define S3C6410_CLK_SRC2	S3C_CLKREG(0x10C)
 #define S3C_MEM_SYS_CFG		S3C_CLKREG(0x120)
 
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
 /* PCLK GATE Registers */
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
 #define S3C_CLKCON_PCLK_UART3		(1<<4)
 #define S3C_CLKCON_PCLK_UART2		(1<<3)
 #define S3C_CLKCON_PCLK_UART1		(1<<2)
 #define S3C_CLKCON_PCLK_UART0		(1<<1)
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
 
 /* MEM_SYS_CFG */
 #define MEM_SYS_CFG_INDEP_CF		0x4000
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 6a1f91f..8cdb824 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -194,29 +194,8 @@ void s3c_pm_debug_smdkled(u32 set, u32 clear)
 #endif
 
 static struct sleep_save core_save[] = {
-	SAVE_ITEM(S3C_APLL_LOCK),
-	SAVE_ITEM(S3C_MPLL_LOCK),
-	SAVE_ITEM(S3C_EPLL_LOCK),
-	SAVE_ITEM(S3C_CLK_SRC),
-	SAVE_ITEM(S3C_CLK_DIV0),
-	SAVE_ITEM(S3C_CLK_DIV1),
-	SAVE_ITEM(S3C_CLK_DIV2),
-	SAVE_ITEM(S3C_CLK_OUT),
-	SAVE_ITEM(S3C_HCLK_GATE),
-	SAVE_ITEM(S3C_PCLK_GATE),
-	SAVE_ITEM(S3C_SCLK_GATE),
-	SAVE_ITEM(S3C_MEM0_GATE),
-
-	SAVE_ITEM(S3C_EPLL_CON1),
-	SAVE_ITEM(S3C_EPLL_CON0),
-
 	SAVE_ITEM(S3C64XX_MEM0DRVCON),
 	SAVE_ITEM(S3C64XX_MEM1DRVCON),
-
-#ifndef CONFIG_CPU_FREQ
-	SAVE_ITEM(S3C_APLL_CON),
-	SAVE_ITEM(S3C_MPLL_CON),
-#endif
 };
 
 static struct sleep_save misc_save[] = {
-- 
1.8.2.1
