From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 1 Jun 2010 20:55:40 +0400
Subject: [PATCH 3/4] ARM: cns3xxx: Add support for AHCI controllers
In-Reply-To: <20100601165409.GA29614@oksana.dev.rtsoft.ru>
References: <20100601165409.GA29614@oksana.dev.rtsoft.ru>
Message-ID: <20100601165540.GC7123@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CNS3xxx chips have AHCI-compatible SATA controller. This patch adds
the support using generic ahci_platform driver.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/arm/mach-cns3xxx/cns3420vb.c |    1 +
 arch/arm/mach-cns3xxx/devices.c   |   61 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-cns3xxx/devices.h   |    1 +
 3 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
index df9ca5b..1e79ed5 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -112,6 +112,7 @@ static void __init cns3420_early_serial_setup(void)
  */
 static struct platform_device *cns3420_pdevs[] __initdata = {
 	&cns3420_nor_pdev,
+	&cns3xxx_ahci_pdev,
 	&cns3xxx_sdhci_pdev,
 };
 
diff --git a/arch/arm/mach-cns3xxx/devices.c b/arch/arm/mach-cns3xxx/devices.c
index 549ad0c..bf6044b 100644
--- a/arch/arm/mach-cns3xxx/devices.c
+++ b/arch/arm/mach-cns3xxx/devices.c
@@ -14,14 +14,75 @@
 #include <linux/init.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
+#include <linux/ahci_platform.h>
 #include <linux/mmc/host.h>
 #include <linux/sdhci-pltfm.h>
 #include "../../../drivers/mmc/host/sdhci.h"
+#include "core.h"
 #include "devices.h"
 
 /*
+ * AHCI
+ */
+static int cns3xxx_ahci_init(struct device *dev)
+{
+	u32 tmp;
+
+	tmp = MISC_SATA_POWER_MODE;
+	tmp |= 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mode */
+	tmp |= 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mode */
+	MISC_SATA_POWER_MODE = tmp;
+
+	/* Enable SATA PHY */
+	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY0);
+	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY1);
+
+	/* Enable SATA Clock */
+	cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_SATA);
+
+	/* De-Asscer SATA Reset */
+	tmp = PM_SOFT_RST_REG;
+	tmp |= 0x1 << PM_SOFT_RST_REG_OFFST_SATA;
+	PM_SOFT_RST_REG = tmp;
+
+	return 0;
+}
+
+static struct ahci_platform_data cns3xxx_ahci_pdata = {
+	.init = cns3xxx_ahci_init,
+};
+
+static struct resource cns3xxx_ahci_resource[] = {
+	[0] = {
+		.start	= CNS3XXX_SATA2_BASE,
+		.end	= CNS3XXX_SATA2_BASE + CNS3XXX_SATA2_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_CNS3XXX_SATA,
+		.end	= IRQ_CNS3XXX_SATA,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static u64 cns3xxx_ahci_dmamask = DMA_BIT_MASK(32);
+
+struct platform_device cns3xxx_ahci_pdev = {
+	.name		= "ahci",
+	.id		= 0,
+	.resource	= cns3xxx_ahci_resource,
+	.num_resources	= ARRAY_SIZE(cns3xxx_ahci_resource),
+	.dev		= {
+		.dma_mask		= &cns3xxx_ahci_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &cns3xxx_ahci_pdata,
+	},
+};
+
+/*
  * SDHCI
  */
 static struct resource cns3xxx_sdhci_resources[] = {
diff --git a/arch/arm/mach-cns3xxx/devices.h b/arch/arm/mach-cns3xxx/devices.h
index c5bf5cf..3e6616d 100644
--- a/arch/arm/mach-cns3xxx/devices.h
+++ b/arch/arm/mach-cns3xxx/devices.h
@@ -14,6 +14,7 @@
 #ifndef __CNS3XXX_DEVICES_H_
 #define __CNS3XXX_DEVICES_H_
 
+extern struct platform_device cns3xxx_ahci_pdev;
 extern struct platform_device cns3xxx_sdhci_pdev;
 
 #endif /* __CNS3XXX_DEVICES_H_ */
-- 
1.7.0.5
