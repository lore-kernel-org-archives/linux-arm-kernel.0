From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Nov 2010 17:14:11 +0100
Subject: [PATCH 2/2] ARM i.MX SDMA: Add ROM script addresses to platform_data
In-Reply-To: <1288887251-31851-1-git-send-email-s.hauer@pengutronix.de>
References: <1288887251-31851-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1288887251-31851-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/devices/platform-imx-dma.c |   99 ++++++++++++++++++++++++--
 1 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index 02d9890..1877cbd 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -84,6 +84,83 @@ static struct platform_device __init __maybe_unused *imx_add_imx_dma(void)
 	return imx_add_platform_device("imx-dma", -1, NULL, 0, NULL, 0);
 }
 
+#ifdef CONFIG_ARCH_MX25
+static struct sdma_script_start_addrs addr_imx25_to1 = {
+	.ap_2_ap_addr = 729,
+	.uart_2_mcu_addr = 904,
+	.per_2_app_addr = 1255,
+	.mcu_2_app_addr = 834,
+	.uartsh_2_mcu_addr = 1120,
+	.per_2_shp_addr = 1329,
+	.mcu_2_shp_addr = 1048,
+	.ata_2_mcu_addr = 1560,
+	.mcu_2_ata_addr = 1479,
+	.app_2_per_addr = 1189,
+	.app_2_mcu_addr = 770,
+	.shp_2_per_addr = 1407,
+	.shp_2_mcu_addr = 979,
+};
+#endif
+
+#ifdef CONFIG_ARCH_MX31
+static struct sdma_script_start_addrs addr_imx31_to1 = {
+	.per_2_per_addr = 1677,
+};
+
+static struct sdma_script_start_addrs addr_imx31_to2 = {
+	.ap_2_ap_addr = 423,
+	.ap_2_bp_addr = 829,
+	.bp_2_ap_addr = 1029,
+};
+#endif
+
+#ifdef CONFIG_ARCH_MX35
+static struct sdma_script_start_addrs addr_imx35_to1 = {
+	.ap_2_ap_addr = 642,
+	.uart_2_mcu_addr = 817,
+	.mcu_2_app_addr = 747,
+	.uartsh_2_mcu_addr = 1183,
+	.per_2_shp_addr = 1033,
+	.mcu_2_shp_addr = 961,
+	.ata_2_mcu_addr = 1333,
+	.mcu_2_ata_addr = 1252,
+	.app_2_mcu_addr = 683,
+	.shp_2_per_addr = 1111,
+	.shp_2_mcu_addr = 892,
+};
+
+static struct sdma_script_start_addrs addr_imx35_to2 = {
+	.ap_2_ap_addr = 729,
+	.uart_2_mcu_addr = 904,
+	.per_2_app_addr = 1597,
+	.mcu_2_app_addr = 834,
+	.uartsh_2_mcu_addr = 1270,
+	.per_2_shp_addr = 1120,
+	.mcu_2_shp_addr = 1048,
+	.ata_2_mcu_addr = 1429,
+	.mcu_2_ata_addr = 1339,
+	.app_2_per_addr = 1531,
+	.app_2_mcu_addr = 770,
+	.shp_2_per_addr = 1198,
+	.shp_2_mcu_addr = 979,
+};
+#endif
+
+#ifdef CONFIG_ARCH_MX51
+static struct sdma_script_start_addrs addr_imx51_to1 = {
+	.ap_2_ap_addr = 642,
+	.uart_2_mcu_addr = 817,
+	.mcu_2_app_addr = 747,
+	.mcu_2_shp_addr = 961,
+	.ata_2_mcu_addr = 1473,
+	.mcu_2_ata_addr = 1392,
+	.app_2_per_addr = 1033,
+	.app_2_mcu_addr = 683,
+	.shp_2_per_addr = 1251,
+	.shp_2_mcu_addr = 892,
+};
+#endif
+
 static int __init imxXX_add_imx_dma(void)
 {
 	struct platform_device *ret;
@@ -95,29 +172,41 @@ static int __init imxXX_add_imx_dma(void)
 #endif
 
 #if defined(CONFIG_ARCH_MX25)
-	if (cpu_is_mx25())
+	if (cpu_is_mx25()) {
+		imx25_imx_sdma_data.pdata.script_addrs = &addr_imx25_to1;
 		ret = imx_add_imx_sdma(&imx25_imx_sdma_data);
 	else
 #endif
 
 #if defined(CONFIG_ARCH_MX31)
 	if (cpu_is_mx31()) {
-		imx31_imx_sdma_data.pdata.to_version = mx31_revision() >> 4;
+		int to_version = mx31_revision() >> 4;
+		imx31_imx_sdma_data.pdata.to_version = to_version;
+		if (to_version == 1)
+			imx31_imx_sdma_data.pdata.script_addrs = &addr_imx31_to1;
+		else
+			imx31_imx_sdma_data.pdata.script_addrs = &addr_imx31_to2;
 		ret = imx_add_imx_sdma(&imx31_imx_sdma_data);
 	} else
 #endif
 
 #if defined(CONFIG_ARCH_MX35)
 	if (cpu_is_mx35()) {
-		imx35_imx_sdma_data.pdata.to_version = mx35_revision() >> 4;
+		int to_version = mx35_revision() >> 4;
+		imx35_imx_sdma_data.pdata.to_version = to_version;
+		if (to_version == 1)
+			imx35_imx_sdma_data.pdata.script_addrs = &addr_imx35_to1;
+		else
+			imx35_imx_sdma_data.pdata.script_addrs = &addr_imx35_to2;
 		ret = imx_add_imx_sdma(&imx35_imx_sdma_data);
 	} else
 #endif
 
 #if defined(CONFIG_ARCH_MX51)
-	if (cpu_is_mx51())
+	if (cpu_is_mx51()) {
+		imx51_imx_sdma_data.pdata.script_addrs = &addr_imx51_to1;
 		ret = imx_add_imx_sdma(&imx51_imx_sdma_data);
-	else
+	} else
 #endif
 		ret = ERR_PTR(-ENODEV);
 
-- 
1.7.2.3
