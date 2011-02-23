From: michael.williamson@criticallink.com (Michael Williamson)
Date: Wed, 23 Feb 2011 13:44:08 -0500
Subject: [PATCH v4 1/4] davinci: da8xx: add spi resources and registration
	routine
In-Reply-To: <1298486651-18882-1-git-send-email-michael.williamson@criticallink.com>
References: <1298486651-18882-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1298486651-18882-2-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add IO resource structures, platform data, and a registration
routine in order to support spi device on DA850/OMAP-L138/AM18x
and DA830/OMAP-L137/AM17x platforms.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/devices-da8xx.c      |  104 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    4 +
 2 files changed, 108 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 119d46e..625d4b6 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -38,14 +38,20 @@
 #define DA8XX_EMAC_MDIO_BASE		0x01e24000
 #define DA8XX_GPIO_BASE			0x01e26000
 #define DA8XX_I2C1_BASE			0x01e28000
+#define DA8XX_SPI0_BASE			0x01c41000
+#define DA8XX_SPI1_BASE			0x01f0e000
 
 #define DA8XX_EMAC_CTRL_REG_OFFSET	0x3000
 #define DA8XX_EMAC_MOD_REG_OFFSET	0x2000
 #define DA8XX_EMAC_RAM_OFFSET		0x0000
 #define DA8XX_EMAC_CTRL_RAM_SIZE	SZ_8K
 
+#define DA8XX_DMA_SPI0_RX	EDMA_CTLR_CHAN(0, 14)
+#define DA8XX_DMA_SPI0_TX	EDMA_CTLR_CHAN(0, 15)
 #define DA8XX_DMA_MMCSD0_RX	EDMA_CTLR_CHAN(0, 16)
 #define DA8XX_DMA_MMCSD0_TX	EDMA_CTLR_CHAN(0, 17)
+#define DA8XX_DMA_SPI1_RX	EDMA_CTLR_CHAN(0, 18)
+#define DA8XX_DMA_SPI1_TX	EDMA_CTLR_CHAN(0, 19)
 #define DA850_DMA_MMCSD1_RX	EDMA_CTLR_CHAN(1, 28)
 #define DA850_DMA_MMCSD1_TX	EDMA_CTLR_CHAN(1, 29)
 
@@ -730,3 +736,101 @@ int __init da8xx_register_cpuidle(void)
 
 	return platform_device_register(&da8xx_cpuidle_device);
 }
+
+static struct resource da8xx_spi0_resources[] = {
+	[0] = {
+		.start	= DA8XX_SPI0_BASE,
+		.end	= DA8XX_SPI0_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_DA8XX_SPINT0,
+		.end	= IRQ_DA8XX_SPINT0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= DA8XX_DMA_SPI0_RX,
+		.end	= DA8XX_DMA_SPI0_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= DA8XX_DMA_SPI0_TX,
+		.end	= DA8XX_DMA_SPI0_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct resource da8xx_spi1_resources[] = {
+	[0] = {
+		.start	= DA8XX_SPI1_BASE,
+		.end	= DA8XX_SPI1_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_DA8XX_SPINT1,
+		.end	= IRQ_DA8XX_SPINT1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= DA8XX_DMA_SPI1_RX,
+		.end	= DA8XX_DMA_SPI1_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= DA8XX_DMA_SPI1_TX,
+		.end	= DA8XX_DMA_SPI1_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+struct davinci_spi_platform_data da8xx_spi_pdata[] = {
+	[0] = {
+		.version	= SPI_VERSION_2,
+		.intr_line	= 1,
+		.dma_event_q	= EVENTQ_0,
+	},
+	[1] = {
+		.version	= SPI_VERSION_2,
+		.intr_line	= 1,
+		.dma_event_q	= EVENTQ_0,
+	},
+};
+
+static struct platform_device da8xx_spi_device[] = {
+	[0] = {
+		.name		= "spi_davinci",
+		.id		= 0,
+		.num_resources	= ARRAY_SIZE(da8xx_spi0_resources),
+		.resource	= da8xx_spi0_resources,
+		.dev		= {
+			.platform_data = &da8xx_spi_pdata[0],
+		},
+	},
+	[1] = {
+		.name		= "spi_davinci",
+		.id		= 1,
+		.num_resources	= ARRAY_SIZE(da8xx_spi1_resources),
+		.resource	= da8xx_spi1_resources,
+		.dev		= {
+			.platform_data = &da8xx_spi_pdata[1],
+		},
+	},
+};
+
+int __init da8xx_register_spi(int instance, struct spi_board_info *info,
+			      unsigned len)
+{
+	int ret;
+
+	if (instance < 0 || instance > 1)
+		return -EINVAL;
+
+	ret = spi_register_board_info(info, len);
+	if (ret)
+		pr_warning("%s: failed to register board info for spi %d :"
+			   " %d\n", __func__, instance, ret);
+
+	da8xx_spi_pdata[instance].num_chipselect = len;
+
+	return platform_device_register(&da8xx_spi_device[instance]);
+}
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index cfcb223..e4fc1af 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -15,6 +15,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/davinci_emac.h>
+#include <linux/spi/spi.h>
 
 #include <mach/serial.h>
 #include <mach/edma.h>
@@ -23,6 +24,7 @@
 #include <mach/mmc.h>
 #include <mach/usb.h>
 #include <mach/pm.h>
+#include <mach/spi.h>
 
 extern void __iomem *da8xx_syscfg0_base;
 extern void __iomem *da8xx_syscfg1_base;
@@ -77,6 +79,7 @@ void __init da850_init(void);
 int da830_register_edma(struct edma_rsv_info *rsv);
 int da850_register_edma(struct edma_rsv_info *rsv[2]);
 int da8xx_register_i2c(int instance, struct davinci_i2c_platform_data *pdata);
+int da8xx_register_spi(int instance, struct spi_board_info *info, unsigned len);
 int da8xx_register_watchdog(void);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
 int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
@@ -95,6 +98,7 @@ extern struct platform_device da8xx_serial_device;
 extern struct emac_platform_data da8xx_emac_pdata;
 extern struct da8xx_lcdc_platform_data sharp_lcd035q3dg01_pdata;
 extern struct da8xx_lcdc_platform_data sharp_lk043t1dg01_pdata;
+extern struct davinci_spi_platform_data da8xx_spi_pdata[];
 
 extern struct platform_device da8xx_wdt_device;
 
-- 
1.7.0.4
