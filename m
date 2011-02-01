From: michael.williamson@criticallink.com (Michael Williamson)
Date: Mon, 31 Jan 2011 19:05:13 -0500
Subject: [PATCH 1/4] davinci: da8xx/omap-l1: add support for SPI
In-Reply-To: <1296518716-5004-1-git-send-email-michael.williamson@criticallink.com>
References: <1296518716-5004-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <1296518716-5004-2-git-send-email-michael.williamson@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SPI registration routines, clocks, and driver resources for
DA850/OMAP-L138/AM18x and DA830/OMAP-L137/AM17x platforms.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
 arch/arm/mach-davinci/da850.c              |   16 +++++
 arch/arm/mach-davinci/devices-da8xx.c      |   88 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    2 +
 3 files changed, 106 insertions(+), 0 deletions(-)

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
index beda8a4..5f8ff96 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -725,3 +725,91 @@ int __init da8xx_register_cpuidle(void)
 
 	return platform_device_register(&da8xx_cpuidle_device);
 }
+
+static struct resource da8xx_spi0_resources[] = {
+	[0] = {
+		.start = 0x01c41000,
+		.end   = 0x01c41fff,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_DA8XX_SPINT0,
+		.start = IRQ_DA8XX_SPINT0,
+		.flags = IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start = EDMA_CTLR_CHAN(0, 14),
+		.end = EDMA_CTLR_CHAN(0, 14),
+		.flags = IORESOURCE_DMA,
+	},
+	[3] = {
+		.start = EDMA_CTLR_CHAN(0, 15),
+		.end = EDMA_CTLR_CHAN(0, 15),
+		.flags = IORESOURCE_DMA,
+	},
+	[4] = {
+		.start = 0,
+		.end = 0,
+		.flags = IORESOURCE_DMA,
+	},
+};
+
+static struct resource da8xx_spi1_resources[] = {
+	[0] = {
+		.start = 0x01f0e000,
+		.end   = 0x01f0efff,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_DA8XX_SPINT1,
+		.start = IRQ_DA8XX_SPINT1,
+		.flags = IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start = EDMA_CTLR_CHAN(0, 18),
+		.end = EDMA_CTLR_CHAN(0, 18),
+		.flags = IORESOURCE_DMA,
+	},
+	[3] = {
+		.start = EDMA_CTLR_CHAN(0, 19),
+		.end = EDMA_CTLR_CHAN(0, 19),
+		.flags = IORESOURCE_DMA,
+	},
+	[4] = {
+		.start = 0,
+		.end = 0,
+		.flags = IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device da8xx_spi_device[] = {
+	[0] = {
+		.name = "spi_davinci",
+		.id = 0,
+		.num_resources = ARRAY_SIZE(da8xx_spi0_resources),
+		.resource = da8xx_spi0_resources,
+	},
+	[1] = {
+		.name = "spi_davinci",
+		.id = 1,
+		.num_resources = ARRAY_SIZE(da8xx_spi1_resources),
+		.resource = da8xx_spi1_resources,
+	},
+};
+
+int __init da8xx_register_spi(int instance,
+			      struct davinci_spi_platform_data *pdata)
+{
+	struct platform_device *pdev;
+
+	if (instance == 0)
+		pdev = &da8xx_spi_device[0];
+	else if (instance == 1)
+		pdev = &da8xx_spi_device[1];
+	else
+		return -EINVAL;
+
+	pdev->dev.platform_data = pdata;
+
+	return platform_device_register(pdev);
+}
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index cfcb223..1f4cf5f 100644
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
+int da8xx_register_spi(int instance, struct davinci_spi_platform_data *pdata);
 int da8xx_register_watchdog(void);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
 int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
-- 
1.7.0.4
