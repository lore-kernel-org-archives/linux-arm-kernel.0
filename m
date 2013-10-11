From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 11 Oct 2013 11:01:33 +0200
Subject: [PATCH RESEND 3/3] ARM: S3C24XX: add dma pdata for s3c2410,
 s3c2440 and s3c2442
In-Reply-To: <201310111059.19791.heiko@sntech.de>
References: <201310111059.19791.heiko@sntech.de>
Message-ID: <201310111101.33782.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c2410 and s3c2442 share the same dma channels while s3c2440 has
slight differences. But on all three the reachable sources per dma
channel has constraints attached and thus encodes the usable
combinations using the S3C24XX_DMA_CHANREQ macro.

This also fixes the warning about s3c2410_dma_resource being unused
as reported by Olof Johansson.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/common.c            |  100 +++++++++++++++++++++++++++++
 arch/arm/mach-s3c24xx/common.h            |    2 +
 include/linux/platform_data/dma-s3c24xx.h |    3 +
 3 files changed, 105 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 16ac669..4cfe7a4 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -343,6 +343,50 @@ static struct resource s3c2410_dma_resource[] = {
 };
 #endif
 
+#if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2442)
+static struct s3c24xx_dma_channel s3c2410_dma_channels[DMACH_MAX] = {
+	[DMACH_XD0] = { S3C24XX_DMA_AHB, true, S3C24XX_DMA_CHANREQ(0, 0), },
+	[DMACH_XD1] = { S3C24XX_DMA_AHB, true, S3C24XX_DMA_CHANREQ(0, 1), },
+	[DMACH_SDI] = { S3C24XX_DMA_APB, false, S3C24XX_DMA_CHANREQ(2, 0) |
+						S3C24XX_DMA_CHANREQ(2, 2) |
+						S3C24XX_DMA_CHANREQ(1, 3),
+	},
+	[DMACH_SPI0] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(3, 1), },
+	[DMACH_SPI1] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(2, 3), },
+	[DMACH_UART0] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(1, 0), },
+	[DMACH_UART1] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(1, 1), },
+	[DMACH_UART2] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(0, 3), },
+	[DMACH_TIMER] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(3, 0) |
+						 S3C24XX_DMA_CHANREQ(3, 2) |
+						 S3C24XX_DMA_CHANREQ(3, 3),
+	},
+	[DMACH_I2S_IN] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(2, 1) |
+						  S3C24XX_DMA_CHANREQ(1, 2),
+	},
+	[DMACH_I2S_OUT] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(0, 2), },
+	[DMACH_USB_EP1] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(4, 0), },
+	[DMACH_USB_EP2] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(4, 1), },
+	[DMACH_USB_EP3] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(4, 2), },
+	[DMACH_USB_EP4] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(4, 3), },
+};
+
+static struct s3c24xx_dma_platdata s3c2410_dma_platdata = {
+	.num_phy_channels = 4,
+	.channels = s3c2410_dma_channels,
+	.num_channels = DMACH_MAX,
+};
+
+struct platform_device s3c2410_device_dma = {
+	.name		= "s3c2410-dma",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s3c2410_dma_resource),
+	.resource	= s3c2410_dma_resource,
+	.dev	= {
+		.platform_data	= &s3c2410_dma_platdata,
+	},
+};
+#endif
+
 #ifdef CONFIG_CPU_S3C2412
 static struct s3c24xx_dma_channel s3c2412_dma_channels[DMACH_MAX] = {
 	[DMACH_XD0] = { S3C24XX_DMA_AHB, true, 17 },
@@ -384,6 +428,62 @@ struct platform_device s3c2412_device_dma = {
 };
 #endif
 
+#if defined(CONFIG_CPU_S3C2440)
+static struct s3c24xx_dma_channel s3c2440_dma_channels[DMACH_MAX] = {
+	[DMACH_XD0] = { S3C24XX_DMA_AHB, true, S3C24XX_DMA_CHANREQ(0, 0), },
+	[DMACH_XD1] = { S3C24XX_DMA_AHB, true, S3C24XX_DMA_CHANREQ(0, 1), },
+	[DMACH_SDI] = { S3C24XX_DMA_APB, false, S3C24XX_DMA_CHANREQ(2, 0) |
+						S3C24XX_DMA_CHANREQ(6, 1) |
+						S3C24XX_DMA_CHANREQ(2, 2) |
+						S3C24XX_DMA_CHANREQ(1, 3),
+	},
+	[DMACH_SPI0] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(3, 1), },
+	[DMACH_SPI1] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(2, 3), },
+	[DMACH_UART0] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(1, 0), },
+	[DMACH_UART1] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(1, 1), },
+	[DMACH_UART2] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(0, 3), },
+	[DMACH_TIMER] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(3, 0) |
+						 S3C24XX_DMA_CHANREQ(3, 2) |
+						 S3C24XX_DMA_CHANREQ(3, 3),
+	},
+	[DMACH_I2S_IN] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(2, 1) |
+						  S3C24XX_DMA_CHANREQ(1, 2),
+	},
+	[DMACH_I2S_OUT] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(5, 0) |
+						   S3C24XX_DMA_CHANREQ(0, 2),
+	},
+	[DMACH_PCM_IN] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(6, 0) |
+						  S3C24XX_DMA_CHANREQ(5, 2),
+	},
+	[DMACH_PCM_OUT] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(5, 1) |
+						  S3C24XX_DMA_CHANREQ(6, 3),
+	},
+	[DMACH_MIC_IN] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(6, 2) |
+						  S3C24XX_DMA_CHANREQ(5, 3),
+	},
+	[DMACH_USB_EP1] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(4, 0), },
+	[DMACH_USB_EP2] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(4, 1), },
+	[DMACH_USB_EP3] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(4, 2), },
+	[DMACH_USB_EP4] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(4, 3), },
+};
+
+static struct s3c24xx_dma_platdata s3c2440_dma_platdata = {
+	.num_phy_channels = 4,
+	.channels = s3c2440_dma_channels,
+	.num_channels = DMACH_MAX,
+};
+
+struct platform_device s3c2440_device_dma = {
+	.name		= "s3c2410-dma",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s3c2410_dma_resource),
+	.resource	= s3c2410_dma_resource,
+	.dev	= {
+		.platform_data	= &s3c2440_dma_platdata,
+	},
+};
+#endif
+
 #if defined(CONFIG_CPUS_3C2443) || defined(CONFIG_CPU_S3C2416)
 static struct resource s3c2443_dma_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C24XX_PA_DMA, S3C24XX_SZ_DMA),
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index fe07189..e46c104 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -109,7 +109,9 @@ extern void s3c2443_init_irq(void);
 
 extern struct syscore_ops s3c24xx_irq_syscore_ops;
 
+extern struct platform_device s3c2410_device_dma;
 extern struct platform_device s3c2412_device_dma;
+extern struct platform_device s3c2440_device_dma;
 extern struct platform_device s3c2443_device_dma;
 
 #endif /* __ARCH_ARM_MACH_S3C24XX_COMMON_H */
diff --git a/include/linux/platform_data/dma-s3c24xx.h b/include/linux/platform_data/dma-s3c24xx.h
index 5a0cfff..89ba1b0 100644
--- a/include/linux/platform_data/dma-s3c24xx.h
+++ b/include/linux/platform_data/dma-s3c24xx.h
@@ -9,6 +9,9 @@
  * any later version.
  */
 
+/* Helper to encode the source selection constraints for early s3c socs. */
+#define S3C24XX_DMA_CHANREQ(src, chan)	((BIT(3) | src) << chan * 4)
+
 enum s3c24xx_dma_bus {
 	S3C24XX_DMA_APB,
 	S3C24XX_DMA_AHB,
-- 
1.7.10.4
