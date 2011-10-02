From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 02 Oct 2011 18:24:40 +0900
Subject: [PATCH 2/2] ARM: SAMSUNG: Cleanup resources by using macro
Message-ID: <001e01cc80e5$1c9eb150$55dc13f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds macro SAMSUNG_RES_MEM and SAMSUNG_RES_IRQ to cleanup
regarding 'struct resource'

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2410/include/mach/map.h  |    1 +
 arch/arm/plat-samsung/devs.c              |  670 +++++------------------------
 arch/arm/plat-samsung/include/plat/devs.h |   10 +
 3 files changed, 122 insertions(+), 559 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/map.h b/arch/arm/mach-s3c2410/include/mach/map.h
index 4cf495f..78ae807 100644
--- a/arch/arm/mach-s3c2410/include/mach/map.h
+++ b/arch/arm/mach-s3c2410/include/mach/map.h
@@ -149,6 +149,7 @@
 #define S3C24XX_PA_RTC      S3C2410_PA_RTC
 #define S3C24XX_PA_ADC      S3C2410_PA_ADC
 #define S3C24XX_PA_SPI      S3C2410_PA_SPI
+#define S3C24XX_PA_SPI1		(S3C2410_PA_SPI + S3C2410_SPI1)
 #define S3C24XX_PA_SDI      S3C2410_PA_SDI
 #define S3C24XX_PA_NAND	    S3C2410_PA_NAND
 
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 83c3cf9..fc72476 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -66,16 +66,8 @@ static u64 samsung_device_dma_mask = DMA_BIT_MASK(32);
 /* AC97 */
 #ifdef CONFIG_CPU_S3C2440
 static struct resource s3c_ac97_resource[] = {
-	[0] = {
-		.start	= S3C2440_PA_AC97,
-		.end	= S3C2440_PA_AC97 + S3C2440_SZ_AC97 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_S3C244x_AC97,
-		.end	= IRQ_S3C244x_AC97,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S3C2440, AC97, S3C2440_SZ_AC97) },
+	[1] = { SAMSUNG_RES_IRQ(S3C244x_AC97) },
 	[2] = {
 		.name	= "PCM out",
 		.start	= DMACH_PCM_OUT,
@@ -112,21 +104,9 @@ struct platform_device s3c_device_ac97 = {
 
 #ifdef CONFIG_PLAT_S3C24XX
 static struct resource s3c_adc_resource[] = {
-	[0] = {
-		.start	= S3C24XX_PA_ADC,
-		.end	= S3C24XX_PA_ADC + S3C24XX_SZ_ADC - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_TC,
-		.end	= IRQ_TC,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_ADC,
-		.end	= IRQ_ADC,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C24XX, ADC, S3C24XX_SZ_ADC) },
+	[1] = { SAMSUNG_RES_IRQ(TC) },
+	[2] = { SAMSUNG_RES_IRQ(ADC) },
 };
 
 struct platform_device s3c_device_adc = {
@@ -139,21 +119,9 @@ struct platform_device s3c_device_adc = {
 
 #if defined(CONFIG_SAMSUNG_DEV_ADC)
 static struct resource s3c_adc_resource[] = {
-	[0] = {
-		.start	= SAMSUNG_PA_ADC,
-		.end	= SAMSUNG_PA_ADC + SZ_256 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_TC,
-		.end	= IRQ_TC,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_ADC,
-		.end	= IRQ_ADC,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(SAMSUNG, ADC, SZ_256) },
+	[1] = { SAMSUNG_RES_IRQ(TC) },
+	[2] = { SAMSUNG_RES_IRQ(ADC) },
 };
 
 struct platform_device s3c_device_adc = {
@@ -168,16 +136,8 @@ struct platform_device s3c_device_adc = {
 
 #ifdef CONFIG_CPU_S3C2440
 static struct resource s3c_camif_resource[] = {
-	[0] = {
-		.start	= S3C2440_PA_CAMIF,
-		.end	= S3C2440_PA_CAMIF + S3C2440_SZ_CAMIF - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_CAM,
-		.end	= IRQ_CAM,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C2440, CAMIF, S3C2440_SZ_CAMIF) },
+	[1] = { SAMSUNG_RES_IRQ(CAM) },
 };
 
 struct platform_device s3c_device_camif = {
@@ -216,26 +176,10 @@ struct platform_device samsung_asoc_idma = {
 
 #ifdef CONFIG_S3C_DEV_FB
 static struct resource s3c_fb_resource[] = {
-	[0] = {
-		.start	= S3C_PA_FB,
-		.end	= S3C_PA_FB + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_LCD_VSYNC,
-		.end	= IRQ_LCD_VSYNC,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_LCD_FIFO,
-		.end	= IRQ_LCD_FIFO,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= IRQ_LCD_SYSTEM,
-		.end	= IRQ_LCD_SYSTEM,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S3C, FB, SZ_16K) },
+	[1] = { SAMSUNG_RES_IRQ(LCD_VSYNC) },
+	[2] = { SAMSUNG_RES_IRQ(LCD_FIFO) },
+	[3] = { SAMSUNG_RES_IRQ(LCD_SYSTEM) },
 };
 
 struct platform_device s3c_device_fb = {
@@ -260,16 +204,8 @@ void __init s3c_fb_set_platdata(struct s3c_fb_platdata *pd)
 
 #ifdef CONFIG_S5P_DEV_FIMC0
 static struct resource s5p_fimc0_resource[] = {
-	[0] = {
-		.start	= S5P_PA_FIMC0,
-		.end	= S5P_PA_FIMC0 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_FIMC0,
-		.end	= IRQ_FIMC0,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S5P, FIMC0, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(FIMC0) },
 };
 
 struct platform_device s5p_device_fimc0 = {
@@ -286,16 +222,8 @@ struct platform_device s5p_device_fimc0 = {
 
 #ifdef CONFIG_S5P_DEV_FIMC1
 static struct resource s5p_fimc1_resource[] = {
-	[0] = {
-		.start	= S5P_PA_FIMC1,
-		.end	= S5P_PA_FIMC1 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_FIMC1,
-		.end	= IRQ_FIMC1,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S5P, FIMC1, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(FIMC1) },
 };
 
 struct platform_device s5p_device_fimc1 = {
@@ -312,16 +240,8 @@ struct platform_device s5p_device_fimc1 = {
 
 #ifdef CONFIG_S5P_DEV_FIMC2
 static struct resource s5p_fimc2_resource[] = {
-	[0] = {
-		.start	= S5P_PA_FIMC2,
-		.end	= S5P_PA_FIMC2 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_FIMC2,
-		.end	= IRQ_FIMC2,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S5P, FIMC2, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(FIMC2) },
 };
 
 struct platform_device s5p_device_fimc2 = {
@@ -338,16 +258,8 @@ struct platform_device s5p_device_fimc2 = {
 
 #ifdef CONFIG_S5P_DEV_FIMC3
 static struct resource s5p_fimc3_resource[] = {
-	[0] = {
-		.start	= S5P_PA_FIMC3,
-		.end	= S5P_PA_FIMC3 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_FIMC3,
-		.end	= IRQ_FIMC3,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S5P, FIMC3, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(FIMC3) },
 };
 
 struct platform_device s5p_device_fimc3 = {
@@ -366,26 +278,10 @@ struct platform_device s5p_device_fimc3 = {
 
 #ifdef CONFIG_S5P_DEV_FIMD0
 static struct resource s5p_fimd0_resource[] = {
-	[0] = {
-		.start	= S5P_PA_FIMD0,
-		.end	= S5P_PA_FIMD0 + SZ_32K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_FIMD0_VSYNC,
-		.end	= IRQ_FIMD0_VSYNC,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_FIMD0_FIFO,
-		.end	= IRQ_FIMD0_FIFO,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= IRQ_FIMD0_SYSTEM,
-		.end	= IRQ_FIMD0_SYSTEM,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S5P, FIMD0, SZ_32K) },
+	[1] = { SAMSUNG_RES_IRQ(FIMD0_VSYNC) },
+	[2] = { SAMSUNG_RES_IRQ(FIMD0_FIFO) },
+	[3] = { SAMSUNG_RES_IRQ(FIMD0_SYSTEM) },
 };
 
 struct platform_device s5p_device_fimd0 = {
@@ -424,20 +320,10 @@ void __init s3c_hwmon_set_platdata(struct s3c_hwmon_pdata *pd)
 
 /* HSMMC */
 
-#define S3C_SZ_HSMMC	0x1000
-
 #ifdef CONFIG_S3C_DEV_HSMMC
 static struct resource s3c_hsmmc_resource[] = {
-	[0] = {
-		.start	= S3C_PA_HSMMC0,
-		.end	= S3C_PA_HSMMC0 + S3C_SZ_HSMMC - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_HSMMC0,
-		.end	= IRQ_HSMMC0,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C, HSMMC0, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(HSMMC0) },
 };
 
 struct s3c_sdhci_platdata s3c_hsmmc0_def_platdata = {
@@ -467,16 +353,8 @@ void s3c_sdhci0_set_platdata(struct s3c_sdhci_platdata *pd)
 
 #ifdef CONFIG_S3C_DEV_HSMMC1
 static struct resource s3c_hsmmc1_resource[] = {
-	[0] = {
-		.start	= S3C_PA_HSMMC1,
-		.end	= S3C_PA_HSMMC1 + S3C_SZ_HSMMC - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_HSMMC1,
-		.end	= IRQ_HSMMC1,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C, HSMMC1, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(HSMMC1) },
 };
 
 struct s3c_sdhci_platdata s3c_hsmmc1_def_platdata = {
@@ -508,16 +386,8 @@ void s3c_sdhci1_set_platdata(struct s3c_sdhci_platdata *pd)
 
 #ifdef CONFIG_S3C_DEV_HSMMC2
 static struct resource s3c_hsmmc2_resource[] = {
-	[0] = {
-		.start	= S3C_PA_HSMMC2,
-		.end	= S3C_PA_HSMMC2 + S3C_SZ_HSMMC - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_HSMMC2,
-		.end	= IRQ_HSMMC2,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C, HSMMC2, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(HSMMC2) },
 };
 
 struct s3c_sdhci_platdata s3c_hsmmc2_def_platdata = {
@@ -547,16 +417,8 @@ void s3c_sdhci2_set_platdata(struct s3c_sdhci_platdata *pd)
 
 #ifdef CONFIG_S3C_DEV_HSMMC3
 static struct resource s3c_hsmmc3_resource[] = {
-	[0] = {
-		.start	= S3C_PA_HSMMC3,
-		.end	= S3C_PA_HSMMC3 + S3C_SZ_HSMMC - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_HSMMC3,
-		.end	= IRQ_HSMMC3,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C, HSMMC3, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(HSMMC3) },
 };
 
 struct s3c_sdhci_platdata s3c_hsmmc3_def_platdata = {
@@ -587,16 +449,8 @@ void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata *pd)
 /* I2C */
 
 static struct resource s3c_i2c0_resource[] = {
-	[0] = {
-		.start	= S3C_PA_IIC,
-		.end	= S3C_PA_IIC + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_IIC,
-		.end	= IRQ_IIC,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S3C, IIC, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(IIC) },
 };
 
 struct platform_device s3c_device_i2c0 = {
@@ -633,16 +487,8 @@ void __init s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *pd)
 
 #ifdef CONFIG_S3C_DEV_I2C1
 static struct resource s3c_i2c1_resource[] = {
-	[0] = {
-		.start	= S3C_PA_IIC1,
-		.end	= S3C_PA_IIC1 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_IIC1,
-		.end	= IRQ_IIC1,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S3C, IIC1, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(IIC1) },
 };
 
 struct platform_device s3c_device_i2c1 = {
@@ -671,16 +517,8 @@ void __init s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *pd)
 
 #ifdef CONFIG_S3C_DEV_I2C2
 static struct resource s3c_i2c2_resource[] = {
-	[0] = {
-		.start	= S3C_PA_IIC2,
-		.end	= S3C_PA_IIC2 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_IIC2,
-		.end	= IRQ_IIC2,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S3C, IIC2, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(IIC2) },
 };
 
 struct platform_device s3c_device_i2c2 = {
@@ -709,16 +547,8 @@ void __init s3c_i2c2_set_platdata(struct s3c2410_platform_i2c *pd)
 
 #ifdef CONFIG_S3C_DEV_I2C3
 static struct resource s3c_i2c3_resource[] = {
-	[0] = {
-		.start	= S3C_PA_IIC3,
-		.end	= S3C_PA_IIC3 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_IIC3,
-		.end	= IRQ_IIC3,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S3C, IIC3, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(IIC3) },
 };
 
 struct platform_device s3c_device_i2c3 = {
@@ -747,16 +577,8 @@ void __init s3c_i2c3_set_platdata(struct s3c2410_platform_i2c *pd)
 
 #ifdef CONFIG_S3C_DEV_I2C4
 static struct resource s3c_i2c4_resource[] = {
-	[0] = {
-		.start	= S3C_PA_IIC4,
-		.end	= S3C_PA_IIC4 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_IIC4,
-		.end	= IRQ_IIC4,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S3C, IIC4, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(IIC4) },
 };
 
 struct platform_device s3c_device_i2c4 = {
@@ -785,16 +607,8 @@ void __init s3c_i2c4_set_platdata(struct s3c2410_platform_i2c *pd)
 
 #ifdef CONFIG_S3C_DEV_I2C5
 static struct resource s3c_i2c5_resource[] = {
-	[0] = {
-		.start	= S3C_PA_IIC5,
-		.end	= S3C_PA_IIC5 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_IIC5,
-		.end	= IRQ_IIC5,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S3C, IIC5, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(IIC5) },
 };
 
 struct platform_device s3c_device_i2c5 = {
@@ -823,16 +637,8 @@ void __init s3c_i2c5_set_platdata(struct s3c2410_platform_i2c *pd)
 
 #ifdef CONFIG_S3C_DEV_I2C6
 static struct resource s3c_i2c6_resource[] = {
-	[0] = {
-		.start	= S3C_PA_IIC6,
-		.end	= S3C_PA_IIC6 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_IIC6,
-		.end	= IRQ_IIC6,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S3C, IIC6, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(IIC6) },
 };
 
 struct platform_device s3c_device_i2c6 = {
@@ -861,16 +667,8 @@ void __init s3c_i2c6_set_platdata(struct s3c2410_platform_i2c *pd)
 
 #ifdef CONFIG_S3C_DEV_I2C7
 static struct resource s3c_i2c7_resource[] = {
-	[0] = {
-		.start	= S3C_PA_IIC7,
-		.end	= S3C_PA_IIC7 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_IIC7,
-		.end	= IRQ_IIC7,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S3C, IIC7, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(IIC7) },
 };
 
 struct platform_device s3c_device_i2c7 = {
@@ -899,16 +697,8 @@ void __init s3c_i2c7_set_platdata(struct s3c2410_platform_i2c *pd)
 
 #ifdef CONFIG_S5P_DEV_I2C_HDMIPHY
 static struct resource s5p_i2c_resource[] = {
-	[0] = {
-		.start	= S5P_PA_IIC_HDMIPHY,
-		.end	= S5P_PA_IIC_HDMIPHY + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_IIC_HDMIPHY,
-		.end	= IRQ_IIC_HDMIPHY,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S5P, IIC_HDMIPHY, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(IIC_HDMIPHY) },
 };
 
 struct platform_device s5p_device_i2c_hdmiphy = {
@@ -942,11 +732,7 @@ void __init s5p_i2c_hdmiphy_set_platdata(struct s3c2410_platform_i2c *pd)
 
 #ifdef CONFIG_PLAT_S3C24XX
 static struct resource s3c_iis_resource[] = {
-	[0] = {
-		.start	= S3C24XX_PA_IIS,
-		.end	= S3C24XX_PA_IIS + S3C24XX_SZ_IIS - 1,
-		.flags	= IORESOURCE_MEM,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C24XX, IIS, S3C24XX_SZ_IIS) },
 };
 
 struct platform_device s3c_device_iis = {
@@ -976,16 +762,8 @@ struct platform_device s3c2412_device_iis = {
 
 #ifdef CONFIG_SAMSUNG_DEV_IDE
 static struct resource s3c_cfcon_resource[] = {
-	[0] = {
-		.start	= SAMSUNG_PA_CFCON,
-		.end	= SAMSUNG_PA_CFCON + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_CFCON,
-		.end	= IRQ_CFCON,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(SAMSUNG, CFCON, SZ_16K) },
+	[1] = { SAMSUNG_RES_IRQ(CFCON) },
 };
 
 struct platform_device s3c_device_cfcon = {
@@ -1005,16 +783,8 @@ void s3c_ide_set_platdata(struct s3c_ide_platdata *pdata)
 
 #ifdef CONFIG_SAMSUNG_DEV_KEYPAD
 static struct resource samsung_keypad_resources[] = {
-	[0] = {
-		.start	= SAMSUNG_PA_KEYPAD,
-		.end	= SAMSUNG_PA_KEYPAD + 0x20 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_KEYPAD,
-		.end	= IRQ_KEYPAD,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(SAMSUNG, KEYPAD, SZ_32) },
+	[1] = { SAMSUNG_RES_IRQ(KEYPAD) },
 };
 
 struct platform_device samsung_device_keypad = {
@@ -1040,16 +810,8 @@ void __init samsung_keypad_set_platdata(struct samsung_keypad_platdata *pd)
 
 #ifdef CONFIG_PLAT_S3C24XX
 static struct resource s3c_lcd_resource[] = {
-	[0] = {
-		.start	= S3C24XX_PA_LCD,
-		.end	= S3C24XX_PA_LCD + S3C24XX_SZ_LCD - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_LCD,
-		.end	= IRQ_LCD,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C24XX, LCD, S3C24XX_SZ_LCD) },
+	[1] = { SAMSUNG_RES_IRQ(LCD) },
 };
 
 struct platform_device s3c_device_lcd = {
@@ -1084,16 +846,8 @@ void __init s3c24xx_fb_set_platdata(struct s3c2410fb_mach_info *pd)
 
 #ifdef CONFIG_S5P_DEV_MFC
 static struct resource s5p_mfc_resource[] = {
-	[0] = {
-		.start	= S5P_PA_MFC,
-		.end	= S5P_PA_MFC + SZ_64K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_MFC,
-		.end	= IRQ_MFC,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S5P, MFC, SZ_64K) },
+	[1] = { SAMSUNG_RES_IRQ(MFC) },
 };
 
 struct platform_device s5p_device_mfc = {
@@ -1136,16 +890,8 @@ struct platform_device s5p_device_mfc_r = {
 
 #ifdef CONFIG_S5P_DEV_CSIS0
 static struct resource s5p_mipi_csis0_resource[] = {
-	[0] = {
-		.start	= S5P_PA_MIPI_CSIS0,
-		.end	= S5P_PA_MIPI_CSIS0 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_MIPI_CSIS0,
-		.end	= IRQ_MIPI_CSIS0,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S5P, MIPI_CSIS0, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(MIPI_CSIS0) },
 };
 
 struct platform_device s5p_device_mipi_csis0 = {
@@ -1158,16 +904,8 @@ struct platform_device s5p_device_mipi_csis0 = {
 
 #ifdef CONFIG_S5P_DEV_CSIS1
 static struct resource s5p_mipi_csis1_resource[] = {
-	[0] = {
-		.start	= S5P_PA_MIPI_CSIS1,
-		.end	= S5P_PA_MIPI_CSIS1 + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_MIPI_CSIS1,
-		.end	= IRQ_MIPI_CSIS1,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S5P, MIPI_CSIS1, SZ_4K) },
+	[1] = { SAMSUNG_RES_IRQ(MIPI_CSIS1) },
 };
 
 struct platform_device s5p_device_mipi_csis1 = {
@@ -1182,11 +920,7 @@ struct platform_device s5p_device_mipi_csis1 = {
 
 #ifdef CONFIG_S3C_DEV_NAND
 static struct resource s3c_nand_resource[] = {
-	[0] = {
-		.start	= S3C_PA_NAND,
-		.end	= S3C_PA_NAND + SZ_1M,
-		.flags	= IORESOURCE_MEM,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C, NAND, SZ_1M) },
 };
 
 struct platform_device s3c_device_nand = {
@@ -1291,21 +1025,9 @@ void __init s3c_nand_set_platdata(struct s3c2410_platform_nand *nand)
 
 #ifdef CONFIG_S3C_DEV_ONENAND
 static struct resource s3c_onenand_resources[] = {
-	[0] = {
-		.start	= S3C_PA_ONENAND,
-		.end	= S3C_PA_ONENAND + 0x400 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= S3C_PA_ONENAND_BUF,
-		.end	= S3C_PA_ONENAND_BUF + S3C_SZ_ONENAND_BUF - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start	= IRQ_ONENAND,
-		.end	= IRQ_ONENAND,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S3C, ONENAND, SZ_1K) },
+	[1] = { SAMSUNG_RES_MEM(S3C, ONENAND_BUF, S3C_SZ_ONENAND_BUF) },
+	[2] = { SAMSUNG_RES_IRQ(ONENAND) },
 };
 
 struct platform_device s3c_device_onenand = {
@@ -1318,21 +1040,9 @@ struct platform_device s3c_device_onenand = {
 
 #ifdef CONFIG_S3C64XX_DEV_ONENAND1
 static struct resource s3c64xx_onenand1_resources[] = {
-	[0] = {
-		.start	= S3C64XX_PA_ONENAND1,
-		.end	= S3C64XX_PA_ONENAND1 + 0x400 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= S3C64XX_PA_ONENAND1_BUF,
-		.end	= S3C64XX_PA_ONENAND1_BUF + S3C64XX_SZ_ONENAND1_BUF - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start	= IRQ_ONENAND1,
-		.end	= IRQ_ONENAND1,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S3C64XX, ONENAND1, SZ_1K) },
+	[1] = { SAMSUNG_RES_MEM(S3C64XX, ONENAND1_BUF, S3C64XX_SZ_ONENAND1_BUF) },
+	[2] = { SAMSUNG_RES_IRQ(ONENAND1) },
 };
 
 struct platform_device s3c64xx_device_onenand1 = {
@@ -1351,21 +1061,9 @@ void s3c64xx_onenand1_set_platdata(struct onenand_platform_data *pdata)
 
 #ifdef CONFIG_S5P_DEV_ONENAND
 static struct resource s5p_onenand_resources[] = {
-	[0] = {
-		.start	= S5P_PA_ONENAND,
-		.end	= S5P_PA_ONENAND + SZ_128K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= S5P_PA_ONENAND_DMA,
-		.end	= S5P_PA_ONENAND_DMA + SZ_8K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start	= IRQ_ONENAND_AUDI,
-		.end	= IRQ_ONENAND_AUDI,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S5P, ONENAND, SZ_128K) },
+	[1] = { SAMSUNG_RES_MEM(S5P, ONENAND_DMA, SZ_8K) },
+	[2] = { SAMSUNG_RES_IRQ(ONENAND_AUDI) },
 };
 
 struct platform_device s5p_device_onenand = {
@@ -1380,9 +1078,7 @@ struct platform_device s5p_device_onenand = {
 
 #ifdef CONFIG_PLAT_S5P
 static struct resource s5p_pmu_resource = {
-	.start	= IRQ_PMU,
-	.end	= IRQ_PMU,
-	.flags	= IORESOURCE_IRQ,
+	SAMSUNG_RES_IRQ(PMU)
 };
 
 struct platform_device s5p_device_pmu = {
@@ -1439,21 +1135,9 @@ struct platform_device s3c_device_timer[] = {
 
 #ifdef CONFIG_PLAT_S3C24XX
 static struct resource s3c_rtc_resource[] = {
-	[0] = {
-		.start	= S3C24XX_PA_RTC,
-		.end	= S3C24XX_PA_RTC + 0xff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_RTC,
-		.end	= IRQ_RTC,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_TICK,
-		.end	= IRQ_TICK,
-		.flags	= IORESOURCE_IRQ
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C24XX, RTC, SZ_256) },
+	[1] = { SAMSUNG_RES_IRQ(RTC) },
+	[2] = { SAMSUNG_RES_IRQ(TICK) },
 };
 
 struct platform_device s3c_device_rtc = {
@@ -1466,21 +1150,9 @@ struct platform_device s3c_device_rtc = {
 
 #ifdef CONFIG_S3C_DEV_RTC
 static struct resource s3c_rtc_resource[] = {
-	[0] = {
-		.start	= S3C_PA_RTC,
-		.end	= S3C_PA_RTC + 0xff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_RTC_ALARM,
-		.end	= IRQ_RTC_ALARM,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_RTC_TIC,
-		.end	= IRQ_RTC_TIC,
-		.flags	= IORESOURCE_IRQ
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C, RTC, SZ_256) },
+	[1] = { SAMSUNG_RES_IRQ(RTC_ALARM) },
+	[2] = { SAMSUNG_RES_IRQ(RTC_TIC) },
 };
 
 struct platform_device s3c_device_rtc = {
@@ -1495,16 +1167,8 @@ struct platform_device s3c_device_rtc = {
 
 #ifdef CONFIG_PLAT_S3C24XX
 static struct resource s3c_sdi_resource[] = {
-	[0] = {
-		.start	= S3C24XX_PA_SDI,
-		.end	= S3C24XX_PA_SDI + S3C24XX_SZ_SDI - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_SDI,
-		.end	= IRQ_SDI,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C24XX, SDI, S3C24XX_SZ_SDI) },
+	[1] = { SAMSUNG_RES_IRQ(SDI) },
 };
 
 struct platform_device s3c_device_sdi = {
@@ -1525,16 +1189,8 @@ void __init s3c24xx_mci_set_platdata(struct s3c24xx_mci_pdata *pdata)
 
 #ifdef CONFIG_PLAT_S3C24XX
 static struct resource s3c_spi0_resource[] = {
-	[0] = {
-		.start	= S3C24XX_PA_SPI,
-		.end	= S3C24XX_PA_SPI + 0x1f,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_SPI0,
-		.end	= IRQ_SPI0,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C24XX, SPI, SZ_32) },
+	[1] = { SAMSUNG_RES_IRQ(SPI0) },
 };
 
 struct platform_device s3c_device_spi0 = {
@@ -1549,16 +1205,8 @@ struct platform_device s3c_device_spi0 = {
 };
 
 static struct resource s3c_spi1_resource[] = {
-	[0] = {
-		.start	= S3C24XX_PA_SPI + S3C2410_SPI1,
-		.end	= S3C24XX_PA_SPI + S3C2410_SPI1 + 0x1f,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_SPI1,
-		.end	= IRQ_SPI1,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C24XX, SPI1, SZ_32) },
+	[1] = { SAMSUNG_RES_IRQ(SPI1) },
 };
 
 struct platform_device s3c_device_spi1 = {
@@ -1577,17 +1225,8 @@ struct platform_device s3c_device_spi1 = {
 
 #ifdef CONFIG_PLAT_S3C24XX
 static struct resource s3c_ts_resource[] = {
-	[0] = {
-		.start	= S3C24XX_PA_ADC,
-		.end	= S3C24XX_PA_ADC + S3C24XX_SZ_ADC - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_TC,
-		.end	= IRQ_TC,
-		.flags	= IORESOURCE_IRQ,
-	},
-
+	[0] = { SAMSUNG_RES_MEM(S3C24XX, ADC, S3C24XX_SZ_ADC) },
+	[1] = { SAMSUNG_RES_IRQ(TC) },
 };
 
 struct platform_device s3c_device_ts = {
@@ -1607,16 +1246,8 @@ void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *hard_s3c2410ts_
 
 #ifdef CONFIG_SAMSUNG_DEV_TS
 static struct resource s3c_ts_resource[] = {
-	[0] = {
-		.start	= SAMSUNG_PA_ADC,
-		.end	= SAMSUNG_PA_ADC + SZ_256 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_TC,
-		.end	= IRQ_TC,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(SAMSUNG, ADC, SZ_256) },
+	[1] = { SAMSUNG_RES_IRQ(TC) },
 };
 
 static struct s3c2410_ts_mach_info default_ts_data __initdata = {
@@ -1647,16 +1278,8 @@ void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *pd)
 #ifdef CONFIG_S5P_DEV_TV
 
 static struct resource s5p_hdmi_resources[] = {
-	[0] = {
-		.start	= S5P_PA_HDMI,
-		.end	= S5P_PA_HDMI + SZ_1M - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_HDMI,
-		.end	= IRQ_HDMI,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S5P, HDMI, SZ_1M) },
+	[1] = { SAMSUNG_RES_IRQ(HDMI) },
 };
 
 struct platform_device s5p_device_hdmi = {
@@ -1667,16 +1290,8 @@ struct platform_device s5p_device_hdmi = {
 };
 
 static struct resource s5p_sdo_resources[] = {
-	[0] = {
-		.start	= S5P_PA_SDO,
-		.end	= S5P_PA_SDO + SZ_64K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_SDO,
-		.end	= IRQ_SDO,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S5P, SDO, SZ_64K) },
+	[1] = { SAMSUNG_RES_IRQ(SDO) },
 };
 
 struct platform_device s5p_device_sdo = {
@@ -1687,24 +1302,9 @@ struct platform_device s5p_device_sdo = {
 };
 
 static struct resource s5p_mixer_resources[] = {
-	[0] = {
-		.start	= S5P_PA_MIXER,
-		.end	= S5P_PA_MIXER + SZ_64K - 1,
-		.flags	= IORESOURCE_MEM,
-		.name	= "mxr"
-	},
-	[1] = {
-		.start	= S5P_PA_VP,
-		.end	= S5P_PA_VP + SZ_64K - 1,
-		.flags	= IORESOURCE_MEM,
-		.name	= "vp"
-	},
-	[2] = {
-		.start	= IRQ_MIXER,
-		.end	= IRQ_MIXER,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "irq"
-	}
+	[0] = { SAMSUNG_RES_MEM(S5P, MIXER, SZ_64K) .name = "mxr" },
+	[1] = { SAMSUNG_RES_MEM(S5P, VP, SZ_64K) .name = "vp" },
+	[2] = { SAMSUNG_RES_IRQ(MIXER) .name = "irq" },
 };
 
 struct platform_device s5p_device_mixer = {
@@ -1723,16 +1323,8 @@ struct platform_device s5p_device_mixer = {
 
 #ifdef CONFIG_S3C_DEV_USB_HOST
 static struct resource s3c_usb_resource[] = {
-	[0] = {
-		.start	= S3C_PA_USBHOST,
-		.end	= S3C_PA_USBHOST + 0x100 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_USBH,
-		.end	= IRQ_USBH,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C, USBHOST, SZ_256) },
+	[1] = { SAMSUNG_RES_IRQ(USBH) },
 };
 
 struct platform_device s3c_device_ohci = {
@@ -1766,16 +1358,8 @@ void __init s3c_ohci_set_platdata(struct s3c2410_hcd_info *info)
 
 #ifdef CONFIG_PLAT_S3C24XX
 static struct resource s3c_usbgadget_resource[] = {
-	[0] = {
-		.start	= S3C24XX_PA_USBDEV,
-		.end	= S3C24XX_PA_USBDEV + S3C24XX_SZ_USBDEV - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_USBD,
-		.end	= IRQ_USBD,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C24XX, USBDEV, S3C24XX_SZ_USBDEV) },
+	[1] = { SAMSUNG_RES_IRQ(USBD) },
 };
 
 struct platform_device s3c_device_usbgadget = {
@@ -1795,16 +1379,8 @@ void __init s3c24xx_udc_set_platdata(struct s3c2410_udc_mach_info *pd)
 
 #ifdef CONFIG_S5P_DEV_USB_EHCI
 static struct resource s5p_ehci_resource[] = {
-	[0] = {
-		.start	= S5P_PA_EHCI,
-		.end	= S5P_PA_EHCI + SZ_256 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_USB_HOST,
-		.end	= IRQ_USB_HOST,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S5P, EHCI, SZ_256) },
+	[1] = { SAMSUNG_RES_IRQ(USB_HOST) },
 };
 
 struct platform_device s5p_device_ehci = {
@@ -1836,16 +1412,8 @@ void __init s5p_ehci_set_platdata(struct s5p_ehci_platdata *pd)
 
 #ifdef CONFIG_S3C_DEV_USB_HSOTG
 static struct resource s3c_usb_hsotg_resources[] = {
-	[0] = {
-		.start	= S3C_PA_USB_HSOTG,
-		.end	= S3C_PA_USB_HSOTG + 0x10000 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_OTG,
-		.end	= IRQ_OTG,
-		.flags	= IORESOURCE_IRQ,
-	},
+	[0] = { SAMSUNG_RES_MEM(S3C, USB_HSOTG, SZ_16K) },
+	[1] = { SAMSUNG_RES_IRQ(OTG) },
 };
 
 struct platform_device s3c_device_usb_hsotg = {
@@ -1864,16 +1432,8 @@ struct platform_device s3c_device_usb_hsotg = {
 
 #ifdef CONFIG_PLAT_S3C24XX
 static struct resource s3c_hsudc_resource[] = {
-	[0] = {
-		.start	= S3C2416_PA_HSUDC,
-		.end	= S3C2416_PA_HSUDC + S3C2416_SZ_HSUDC - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_USBD,
-		.end	= IRQ_USBD,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C2416, HSUDC, S3C2416_SZ_HSUDC) },
+	[1] = { SAMSUNG_RES_IRQ(USBD) },
 };
 
 struct platform_device s3c_device_usb_hsudc = {
@@ -1897,16 +1457,8 @@ void __init s3c24xx_hsudc_set_platdata(struct s3c24xx_hsudc_platdata *pd)
 
 #ifdef CONFIG_S3C_DEV_WDT
 static struct resource s3c_wdt_resource[] = {
-	[0] = {
-		.start	= S3C_PA_WDT,
-		.end	= S3C_PA_WDT + SZ_1K,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_WDT,
-		.end	= IRQ_WDT,
-		.flags	= IORESOURCE_IRQ,
-	}
+	[0] = { SAMSUNG_RES_MEM(S3C, WDT, SZ_1K) },
+	[1] = { SAMSUNG_RES_IRQ(WDT) },
 };
 
 struct platform_device s3c_device_wdt = {
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 8f19241..8b8bd1c 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -18,6 +18,16 @@
 
 #include <linux/platform_device.h>
 
+#define SAMSUNG_RES_MEM(soc, ip, sz)			\
+		.start	= soc##_PA_##ip,		\
+		.end	= soc##_PA_##ip + sz - 1,	\
+		.flags	= IORESOURCE_MEM,
+
+#define SAMSUNG_RES_IRQ(ip)				\
+		.start	= IRQ_##ip,			\
+		.end	= IRQ_##ip,			\
+		.flags	= IORESOURCE_IRQ,
+
 struct s3c24xx_uart_resources {
 	struct resource		*resources;
 	unsigned long		 nr_resources;
-- 
1.7.1
