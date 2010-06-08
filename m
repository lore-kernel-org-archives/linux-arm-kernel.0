From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 8 Jun 2010 21:02:17 +0400
Subject: [PATCH 4/4] ARM: cns3xxx: Add support for AHCI controllers
In-Reply-To: <20100608170030.GA26992@oksana.dev.rtsoft.ru>
References: <20100608170030.GA26992@oksana.dev.rtsoft.ru>
Message-ID: <20100608170217.GD22516@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CNS3xxx chips have AHCI-compatible SATA controller. This patch adds
the support using generic ahci_platform driver.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/arm/mach-cns3xxx/cns3420vb.c |    1 +
 arch/arm/mach-cns3xxx/devices.c   |   52 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-cns3xxx/devices.h   |    1 +
 3 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
index 04ae1ce..9df8391 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -118,6 +118,7 @@ static void __init cns3420_init(void)
 {
 	platform_add_devices(cns3420_pdevs, ARRAY_SIZE(cns3420_pdevs));
 
+	cns3xxx_ahci_init();
 	cns3xxx_sdhci_init();
 
 	pm_power_off = cns3xxx_power_off;
diff --git a/arch/arm/mach-cns3xxx/devices.c b/arch/arm/mach-cns3xxx/devices.c
index b01a301..50b4d31 100644
--- a/arch/arm/mach-cns3xxx/devices.c
+++ b/arch/arm/mach-cns3xxx/devices.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/init.h>
 #include <linux/compiler.h>
+#include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <mach/cns3xxx.h>
 #include <mach/irqs.h>
@@ -21,6 +22,57 @@
 #include "devices.h"
 
 /*
+ * AHCI
+ */
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
+static struct platform_device cns3xxx_ahci_pdev = {
+	.name		= "ahci",
+	.id		= 0,
+	.resource	= cns3xxx_ahci_resource,
+	.num_resources	= ARRAY_SIZE(cns3xxx_ahci_resource),
+	.dev		= {
+		.dma_mask		= &cns3xxx_ahci_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+void __init cns3xxx_ahci_init(void)
+{
+	u32 tmp;
+
+	tmp = __raw_readl(MISC_SATA_POWER_MODE);
+	tmp |= 0x1 << 16; /* Disable SATA PHY 0 from SLUMBER Mode */
+	tmp |= 0x1 << 17; /* Disable SATA PHY 1 from SLUMBER Mode */
+	__raw_writel(tmp, MISC_SATA_POWER_MODE);
+
+	/* Enable SATA PHY */
+	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY0);
+	cns3xxx_pwr_power_up(0x1 << PM_PLL_HM_PD_CTRL_REG_OFFSET_SATA_PHY1);
+
+	/* Enable SATA Clock */
+	cns3xxx_pwr_clk_en(0x1 << PM_CLK_GATE_REG_OFFSET_SATA);
+
+	/* De-Asscer SATA Reset */
+	cns3xxx_pwr_soft_rst(CNS3XXX_PWR_SOFTWARE_RST(SATA));
+
+	platform_device_register(&cns3xxx_ahci_pdev);
+}
+
+/*
  * SDHCI
  */
 static struct resource cns3xxx_sdhci_resources[] = {
diff --git a/arch/arm/mach-cns3xxx/devices.h b/arch/arm/mach-cns3xxx/devices.h
index 0735a45..27e15a1 100644
--- a/arch/arm/mach-cns3xxx/devices.h
+++ b/arch/arm/mach-cns3xxx/devices.h
@@ -14,6 +14,7 @@
 #ifndef __CNS3XXX_DEVICES_H_
 #define __CNS3XXX_DEVICES_H_
 
+void __init cns3xxx_ahci_init(void);
 void __init cns3xxx_sdhci_init(void);
 
 #endif /* __CNS3XXX_DEVICES_H_ */
-- 
1.7.0.5
