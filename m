From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Fri, 19 Mar 2010 18:16:37 +0300
Subject: [PATCH 2/3] imx3: Add watchdog platform device support
In-Reply-To: <1269011607-23077-1-git-send-email-vzapolskiy@gmail.com>
References: <1269011607-23077-1-git-send-email-vzapolskiy@gmail.com>
Message-ID: <1269011797-23203-1-git-send-email-vzapolskiy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for build-in watchdog device found on
Freescale imx31 and imx35 SoCs.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/devices.c |   19 ++++++++++++++++++-
 arch/arm/mach-mx3/devices.h |    3 ++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
index 6adb586..f891115 100644
--- a/arch/arm/mach-mx3/devices.c
+++ b/arch/arm/mach-mx3/devices.c
@@ -575,11 +575,26 @@ struct platform_device imx_ssi_device1 = {
 	.resource = imx_ssi_resources1,
 };
 
-static int mx3_devices_init(void)
+static struct resource imx_wdt_resources[] = {
+	{
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+struct platform_device imx_wdt_device0 = {
+	.name           = "imx-wdt",
+	.id             = 0,
+	.num_resources  = ARRAY_SIZE(imx_wdt_resources),
+	.resource       = imx_wdt_resources,
+};
+
+static int __init mx3_devices_init(void)
 {
 	if (cpu_is_mx31()) {
 		mxc_nand_resources[0].start = MX31_NFC_BASE_ADDR;
 		mxc_nand_resources[0].end = MX31_NFC_BASE_ADDR + 0xfff;
+		imx_wdt_resources[0].start = MX31_WDOG_BASE_ADDR;
+		imx_wdt_resources[0].end = MX31_WDOG_BASE_ADDR + 0x3fff;
 		mxc_register_device(&mxc_rnga_device, NULL);
 	}
 	if (cpu_is_mx35()) {
@@ -597,6 +612,8 @@ static int mx3_devices_init(void)
 		imx_ssi_resources0[1].end = MX35_INT_SSI1;
 		imx_ssi_resources1[1].start = MX35_INT_SSI2;
 		imx_ssi_resources1[1].end = MX35_INT_SSI2;
+		imx_wdt_resources[0].start = MX35_WDOG_BASE_ADDR;
+		imx_wdt_resources[0].end = MX35_WDOG_BASE_ADDR + 0x3fff;
 	}
 
 	return 0;
diff --git a/arch/arm/mach-mx3/devices.h b/arch/arm/mach-mx3/devices.h
index 42cf175..4f77eb5 100644
--- a/arch/arm/mach-mx3/devices.h
+++ b/arch/arm/mach-mx3/devices.h
@@ -25,4 +25,5 @@ extern struct platform_device mxc_spi_device1;
 extern struct platform_device mxc_spi_device2;
 extern struct platform_device imx_ssi_device0;
 extern struct platform_device imx_ssi_device1;
-
+extern struct platform_device imx_ssi_device1;
+extern struct platform_device imx_wdt_device0;
-- 
1.6.6.1
