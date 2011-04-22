From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 22 Apr 2011 17:38:21 +0530
Subject: [PATCH v4 03/11] da850: pruss platform specific additions.
In-Reply-To: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <1303474109-6212-4-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the platform device and assignes the platform resources
for the PRUSS mfd driver.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 arch/arm/mach-davinci/devices-da8xx.c      |   63 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    4 ++
 2 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 625d4b6..f51c9ad 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -20,6 +20,7 @@
 #include <mach/time.h>
 #include <mach/da8xx.h>
 #include <mach/cpuidle.h>
+#include <linux/mfd/pruss.h>
 
 #include "clock.h"
 
@@ -510,6 +511,68 @@ void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata)
 	}
 }
 
+static struct resource da8xx_pruss_resources[] = {
+	{
+		.name	= "da8xx_pruss",
+		.start	= DA8XX_PRUSS_MEM_BASE,
+		.end	= DA8XX_PRUSS_MEM_BASE + 0xFFFF,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_DA8XX_EVTOUT0,
+		.end	= IRQ_DA8XX_EVTOUT0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_EVTOUT1,
+		.end	= IRQ_DA8XX_EVTOUT1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_EVTOUT2,
+		.end	= IRQ_DA8XX_EVTOUT2,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_EVTOUT3,
+		.end	= IRQ_DA8XX_EVTOUT3,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_EVTOUT4,
+		.end	= IRQ_DA8XX_EVTOUT4,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_EVTOUT5,
+		.end	= IRQ_DA8XX_EVTOUT5,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_EVTOUT6,
+		.end	= IRQ_DA8XX_EVTOUT6,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.start	= IRQ_DA8XX_EVTOUT7,
+		.end	= IRQ_DA8XX_EVTOUT7,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device da8xx_pruss_mfddev = {
+	.name		= "pruss_mfd",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(da8xx_pruss_resources),
+	.resource	= da8xx_pruss_resources,
+};
+
+int __init da8xx_register_pruss_mfd(struct mfd_cell *cell)
+{
+	da8xx_pruss_mfddev.dev.platform_data = cell;
+	return platform_device_register(&da8xx_pruss_mfddev);
+}
+
 static const struct display_panel disp_panel = {
 	QVGA,
 	16,
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 09b8ddb..0c23035 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -16,6 +16,8 @@
 #include <linux/platform_device.h>
 #include <linux/davinci_emac.h>
 #include <linux/spi/spi.h>
+#include <linux/mfd/pruss.h>
+#include <linux/mfd/core.h>
 
 #include <mach/serial.h>
 #include <mach/edma.h>
@@ -73,6 +75,7 @@ extern unsigned int da850_max_speed;
 #define DA8XX_DDR2_CTL_BASE	0xb0000000
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 #define DA8XX_SHARED_RAM_BASE	0x80000000
+#define DA8XX_PRUSS_MEM_BASE	0x01C30000
 
 void __init da830_init(void);
 void __init da850_init(void);
@@ -85,6 +88,7 @@ int da8xx_register_watchdog(void);
 int da8xx_register_usb20(unsigned mA, unsigned potpgt);
 int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
 int da8xx_register_emac(void);
+int da8xx_register_pruss_mfd(struct mfd_cell *);
 int da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata);
 int da8xx_register_mmcsd0(struct davinci_mmc_config *config);
 int da850_register_mmcsd1(struct davinci_mmc_config *config);
-- 
1.7.2.3
