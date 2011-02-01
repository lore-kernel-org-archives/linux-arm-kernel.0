From: michael.williamson@criticallink.com (Michael Williamson)
Date: Tue,  1 Feb 2011 16:49:36 -0500
Subject: [PATCH v1 1/4] davinci: da8xx/omap-l1: add support for SPI
In-Reply-To: <1296596979-18524-1-git-send-email-michael.williamson@criticallink.com>
References: <1296596979-18524-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1296596979-18524-2-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPI registration routines, clocks, and driver resources for
DA850/OMAP-L138/AM18x and DA830/OMAP-L137/AM17x platforms.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/da850.c              |   16 +++++
 arch/arm/mach-davinci/devices-da8xx.c      |   96 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    3 +
 3 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 3443d97..68fe4c2 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -359,6 +359,20 @@ static struct clk usb20_clk = {
 	.gpsc		= 1,
 };
 
+static struct clk spi0_clk = {
+	.name		= "spi0",
+	.parent		= &pll0_sysclk2,
+	.lpsc		= DA8XX_LPSC0_SPI0,
+};
+
+static struct clk spi1_clk = {
+	.name		= "spi1",
+	.parent		= &pll0_sysclk2,
+	.lpsc		= DA8XX_LPSC1_SPI1,
+	.gpsc		= 1,
+	.flags		= DA850_CLK_ASYNC3,
+};
+
 static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"ref",		&ref_clk),
 	CLK(NULL,		"pll0",		&pll0_clk),
@@ -403,6 +417,8 @@ static struct clk_lookup da850_clks[] = {
 	CLK(NULL,		"aemif",	&aemif_clk),
 	CLK(NULL,		"usb11",	&usb11_clk),
 	CLK(NULL,		"usb20",	&usb20_clk),
+	CLK("spi_davinci.0",	NULL,		&spi0_clk),
+	CLK("spi_davinci.1",	NULL,		&spi1_clk),
 	CLK(NULL,		NULL,		NULL),
 };
 
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index beda8a4..f421f97 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -725,3 +725,99 @@ int __init da8xx_register_cpuidle(void)
 
 	return platform_device_register(&da8xx_cpuidle_device);
 }
+
+static struct resource da8xx_spi0_resources[] = {
+	[0] = {
+		.start	= 0x01c41000,
+		.end	= 0x01c41fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_DA8XX_SPINT0,
+		.end	= IRQ_DA8XX_SPINT0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= EDMA_CTLR_CHAN(0, 14),
+		.end	= EDMA_CTLR_CHAN(0, 14),
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= EDMA_CTLR_CHAN(0, 15),
+		.end	= EDMA_CTLR_CHAN(0, 15),
+		.flags	= IORESOURCE_DMA,
+	},
+	[4] = {
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct resource da8xx_spi1_resources[] = {
+	[0] = {
+		.start	= 0x01f0e000,
+		.end	= 0x01f0efff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_DA8XX_SPINT1,
+		.end	= IRQ_DA8XX_SPINT1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= EDMA_CTLR_CHAN(0, 18),
+		.end	= EDMA_CTLR_CHAN(0, 18),
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= EDMA_CTLR_CHAN(0, 19),
+		.end	= EDMA_CTLR_CHAN(0, 19),
+		.flags	= IORESOURCE_DMA,
+	},
+	[4] = {
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+struct davinci_spi_platform_data da8xx_spi_pdata[] = {
+	[0] = {
+		.version	= SPI_VERSION_2,
+		.intr_line	= 1,
+	},
+	[1] = {
+		.version	= SPI_VERSION_2,
+		.intr_line	= 1,
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
+int __init da8xx_register_spi(int instance)
+{
+	struct platform_device *pdev;
+
+	if (instance == 0 || instance == 1)
+		pdev = &da8xx_spi_device[instance];
+	else
+		return -EINVAL;
+
+	return platform_device_register(pdev);
+}
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index cfcb223..0c5fa01 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -23,6 +23,7 @@
 #include <mach/mmc.h>
 #include <mach/usb.h>
 #include <mach/pm.h>
+#include <mach/spi.h>
 
 extern void __iomem *da8xx_syscfg0_base;
 extern void __iomem *da8xx_syscfg1_base;
@@ -77,6 +78,7 @@ void __init da850_init(void);
 int da830_register_edma(struct edma_rsv_info *rsv);
 int da850_register_edma(struct edma_rsv_info *rsv[2]);
 int da8xx_register_i2c(int instance, struct davinci_i2c_platform_data *pdata);
+int da8xx_register_spi(int instance);
 int da8xx_register_watchdog(void);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
 int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
@@ -95,6 +97,7 @@ extern struct platform_device da8xx_serial_device;
 extern struct emac_platform_data da8xx_emac_pdata;
 extern struct da8xx_lcdc_platform_data sharp_lcd035q3dg01_pdata;
 extern struct da8xx_lcdc_platform_data sharp_lk043t1dg01_pdata;
+extern struct davinci_spi_platform_data da8xx_spi_pdata[];
 
 extern struct platform_device da8xx_wdt_device;
 
-- 
1.7.0.4
