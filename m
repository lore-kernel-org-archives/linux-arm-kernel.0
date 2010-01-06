From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:32:14 -0800
Subject: [PATCH 32/35] davinci: da8xx/omap-l1xx: Add EDMA platform data for
	da850/omap-l138
In-Reply-To: <1262802737-6601-32-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-15-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-16-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-17-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-18-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-19-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-20-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-21-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-22-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-23-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-24-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-25-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-26-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-27-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-28-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-29-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-30-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-31-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-32-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-33-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

Currently da850/omap-l138 supports only one channel controller
instance of EDMA though EDMA driver as such supports multiple
channel controller instances. This patch adds platform data
for the 2nd EDMA channel controller. As, the platform data
differ between da830/omap-l137 and da850/omap-l138, existing
code has been re-shuffled to accommodate this.

Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/devices-da8xx.c |  121 +++++++++++++++++++++++++++++++--
 1 files changed, 114 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 40647c4..63c330c 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -24,8 +24,10 @@
 #include "clock.h"
 
 #define DA8XX_TPCC_BASE			0x01c00000
+#define DA850_TPCC1_BASE		0x01e30000
 #define DA8XX_TPTC0_BASE		0x01c08000
 #define DA8XX_TPTC1_BASE		0x01c08400
+#define DA850_TPTC2_BASE		0x01e38000
 #define DA8XX_WDOG_BASE			0x01c21000 /* DA8XX_TIMER64P1_BASE */
 #define DA8XX_I2C0_BASE			0x01c22000
 #define DA8XX_RTC_BASE			0x01C23000
@@ -97,7 +99,31 @@ static const s8 da8xx_queue_priority_mapping[][2] = {
 	{-1, -1}
 };
 
-static struct edma_soc_info da8xx_edma_info[] = {
+static const s8 da850_queue_tc_mapping[][2] = {
+	/* {event queue no, TC no} */
+	{0, 0},
+	{-1, -1}
+};
+
+static const s8 da850_queue_priority_mapping[][2] = {
+	/* {event queue no, Priority} */
+	{0, 3},
+	{-1, -1}
+};
+
+static struct edma_soc_info da830_edma_info[] = {
+	{
+		.n_channel		= 32,
+		.n_region		= 4,
+		.n_slot			= 128,
+		.n_tc			= 2,
+		.n_cc			= 1,
+		.queue_tc_mapping	= da8xx_queue_tc_mapping,
+		.queue_priority_mapping	= da8xx_queue_priority_mapping,
+	},
+};
+
+static struct edma_soc_info da850_edma_info[] = {
 	{
 		.n_channel		= 32,
 		.n_region		= 4,
@@ -107,9 +133,49 @@ static struct edma_soc_info da8xx_edma_info[] = {
 		.queue_tc_mapping	= da8xx_queue_tc_mapping,
 		.queue_priority_mapping	= da8xx_queue_priority_mapping,
 	},
+	{
+		.n_channel		= 32,
+		.n_region		= 4,
+		.n_slot			= 128,
+		.n_tc			= 1,
+		.n_cc			= 1,
+		.queue_tc_mapping	= da850_queue_tc_mapping,
+		.queue_priority_mapping	= da850_queue_priority_mapping,
+	},
+};
+
+static struct resource da830_edma_resources[] = {
+	{
+		.name	= "edma_cc0",
+		.start	= DA8XX_TPCC_BASE,
+		.end	= DA8XX_TPCC_BASE + SZ_32K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "edma_tc0",
+		.start	= DA8XX_TPTC0_BASE,
+		.end	= DA8XX_TPTC0_BASE + SZ_1K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "edma_tc1",
+		.start	= DA8XX_TPTC1_BASE,
+		.end	= DA8XX_TPTC1_BASE + SZ_1K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "edma0",
+		.start	= IRQ_DA8XX_CCINT0,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.name	= "edma0_err",
+		.start	= IRQ_DA8XX_CCERRINT,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
-static struct resource da8xx_edma_resources[] = {
+static struct resource da850_edma_resources[] = {
 	{
 		.name	= "edma_cc0",
 		.start	= DA8XX_TPCC_BASE,
@@ -129,6 +195,18 @@ static struct resource da8xx_edma_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	{
+		.name	= "edma_cc1",
+		.start	= DA850_TPCC1_BASE,
+		.end	= DA850_TPCC1_BASE + SZ_32K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "edma_tc2",
+		.start	= DA850_TPTC2_BASE,
+		.end	= DA850_TPTC2_BASE + SZ_1K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
 		.name	= "edma0",
 		.start	= IRQ_DA8XX_CCINT0,
 		.flags	= IORESOURCE_IRQ,
@@ -138,21 +216,50 @@ static struct resource da8xx_edma_resources[] = {
 		.start	= IRQ_DA8XX_CCERRINT,
 		.flags	= IORESOURCE_IRQ,
 	},
+	{
+		.name	= "edma1",
+		.start	= IRQ_DA850_CCINT1,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.name	= "edma1_err",
+		.start	= IRQ_DA850_CCERRINT1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device da830_edma_device = {
+	.name		= "edma",
+	.id		= -1,
+	.dev = {
+		.platform_data = da830_edma_info,
+	},
+	.num_resources	= ARRAY_SIZE(da830_edma_resources),
+	.resource	= da830_edma_resources,
 };
 
-static struct platform_device da8xx_edma_device = {
+static struct platform_device da850_edma_device = {
 	.name		= "edma",
 	.id		= -1,
 	.dev = {
-		.platform_data	= da8xx_edma_info,
+		.platform_data = da850_edma_info,
 	},
-	.num_resources	= ARRAY_SIZE(da8xx_edma_resources),
-	.resource	= da8xx_edma_resources,
+	.num_resources	= ARRAY_SIZE(da850_edma_resources),
+	.resource	= da850_edma_resources,
 };
 
 int __init da8xx_register_edma(void)
 {
-	return platform_device_register(&da8xx_edma_device);
+	struct platform_device *pdev;
+
+	if (cpu_is_davinci_da830())
+		pdev = &da830_edma_device;
+	else if (cpu_is_davinci_da850())
+		pdev = &da850_edma_device;
+	else
+		return -ENODEV;
+
+	return platform_device_register(pdev);
 }
 
 static struct resource da8xx_i2c_resources0[] = {
-- 
1.6.6.rc2.1.g42108
