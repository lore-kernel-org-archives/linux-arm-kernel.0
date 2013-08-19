From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Aug 2013 14:16:03 +0200
Subject: [PATCH 3/3] ARM: i.MX: remove sdma script address arrays from
 platform data
In-Reply-To: <1376914563-10912-1-git-send-email-s.hauer@pengutronix.de>
References: <1376914563-10912-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1376914563-10912-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the sdma driver holds the address tables they are no longer
needed in platform_data. Remove them.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mm-imx25.c | 17 -----------
 arch/arm/mach-imx/mm-imx3.c  | 67 +++++++++-----------------------------------
 arch/arm/mach-imx/mm-imx5.c  | 14 ---------
 3 files changed, 13 insertions(+), 85 deletions(-)

diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
index e065c11..5211f62 100644
--- a/arch/arm/mach-imx/mm-imx25.c
+++ b/arch/arm/mach-imx/mm-imx25.c
@@ -61,25 +61,8 @@ void __init mx25_init_irq(void)
 	mxc_init_irq(MX25_IO_ADDRESS(MX25_AVIC_BASE_ADDR));
 }
 
-static struct sdma_script_start_addrs imx25_sdma_script __initdata = {
-	.ap_2_ap_addr = 729,
-	.uart_2_mcu_addr = 904,
-	.per_2_app_addr = 1255,
-	.mcu_2_app_addr = 834,
-	.uartsh_2_mcu_addr = 1120,
-	.per_2_shp_addr = 1329,
-	.mcu_2_shp_addr = 1048,
-	.ata_2_mcu_addr = 1560,
-	.mcu_2_ata_addr = 1479,
-	.app_2_per_addr = 1189,
-	.app_2_mcu_addr = 770,
-	.shp_2_per_addr = 1407,
-	.shp_2_mcu_addr = 979,
-};
-
 static struct sdma_platform_data imx25_sdma_pdata __initdata = {
 	.fw_name = "sdma-imx25.bin",
-	.script_addrs = &imx25_sdma_script,
 };
 
 static const struct resource imx25_audmux_res[] __initconst = {
diff --git a/arch/arm/mach-imx/mm-imx3.c b/arch/arm/mach-imx/mm-imx3.c
index 0884ca9..53005db 100644
--- a/arch/arm/mach-imx/mm-imx3.c
+++ b/arch/arm/mach-imx/mm-imx3.c
@@ -148,19 +148,8 @@ void __init mx31_init_irq(void)
 	mxc_init_irq(MX31_IO_ADDRESS(MX31_AVIC_BASE_ADDR));
 }
 
-static struct sdma_script_start_addrs imx31_to1_sdma_script __initdata = {
-	.per_2_per_addr = 1677,
-};
-
-static struct sdma_script_start_addrs imx31_to2_sdma_script __initdata = {
-	.ap_2_ap_addr = 423,
-	.ap_2_bp_addr = 829,
-	.bp_2_ap_addr = 1029,
-};
-
 static struct sdma_platform_data imx31_sdma_pdata __initdata = {
 	.fw_name = "sdma-imx31-to2.bin",
-	.script_addrs = &imx31_to2_sdma_script,
 };
 
 static const struct resource imx31_audmux_res[] __initconst = {
@@ -170,6 +159,7 @@ static const struct resource imx31_audmux_res[] __initconst = {
 void __init imx31_soc_init(void)
 {
 	int to_version = mx31_revision() >> 4;
+	char *sdmastr;
 
 	imx3_init_l2x0();
 
@@ -182,13 +172,12 @@ void __init imx31_soc_init(void)
 
 	pinctrl_provide_dummies();
 
-	if (to_version == 1) {
-		strncpy(imx31_sdma_pdata.fw_name, "sdma-imx31-to1.bin",
-			strlen(imx31_sdma_pdata.fw_name));
-		imx31_sdma_pdata.script_addrs = &imx31_to1_sdma_script;
-	}
+	if (to_version == 1)
+		sdmastr = "imx31-to1-sdma";
+	else
+		sdmastr = "imx31-to2-sdma";
 
-	imx_add_imx_sdma("imx31-sdma", MX31_SDMA_BASE_ADDR, MX31_INT_SDMA, &imx31_sdma_pdata);
+	imx_add_imx_sdma(sdmastr, MX31_SDMA_BASE_ADDR, MX31_INT_SDMA, &imx31_sdma_pdata);
 
 	imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS1_BASE_ADDR));
 	imx_set_aips(MX31_IO_ADDRESS(MX31_AIPS2_BASE_ADDR));
@@ -226,39 +215,8 @@ void __init mx35_init_irq(void)
 	mxc_init_irq(MX35_IO_ADDRESS(MX35_AVIC_BASE_ADDR));
 }
 
-static struct sdma_script_start_addrs imx35_to1_sdma_script __initdata = {
-	.ap_2_ap_addr = 642,
-	.uart_2_mcu_addr = 817,
-	.mcu_2_app_addr = 747,
-	.uartsh_2_mcu_addr = 1183,
-	.per_2_shp_addr = 1033,
-	.mcu_2_shp_addr = 961,
-	.ata_2_mcu_addr = 1333,
-	.mcu_2_ata_addr = 1252,
-	.app_2_mcu_addr = 683,
-	.shp_2_per_addr = 1111,
-	.shp_2_mcu_addr = 892,
-};
-
-static struct sdma_script_start_addrs imx35_to2_sdma_script __initdata = {
-	.ap_2_ap_addr = 729,
-	.uart_2_mcu_addr = 904,
-	.per_2_app_addr = 1597,
-	.mcu_2_app_addr = 834,
-	.uartsh_2_mcu_addr = 1270,
-	.per_2_shp_addr = 1120,
-	.mcu_2_shp_addr = 1048,
-	.ata_2_mcu_addr = 1429,
-	.mcu_2_ata_addr = 1339,
-	.app_2_per_addr = 1531,
-	.app_2_mcu_addr = 770,
-	.shp_2_per_addr = 1198,
-	.shp_2_mcu_addr = 979,
-};
-
 static struct sdma_platform_data imx35_sdma_pdata __initdata = {
 	.fw_name = "sdma-imx35-to2.bin",
-	.script_addrs = &imx35_to2_sdma_script,
 };
 
 static const struct resource imx35_audmux_res[] __initconst = {
@@ -268,6 +226,7 @@ static const struct resource imx35_audmux_res[] __initconst = {
 void __init imx35_soc_init(void)
 {
 	int to_version = mx35_revision() >> 4;
+	char *sdmastr;
 
 	imx3_init_l2x0();
 
@@ -279,13 +238,13 @@ void __init imx35_soc_init(void)
 	mxc_register_gpio("imx35-gpio", 2, MX35_GPIO3_BASE_ADDR, SZ_16K, MX35_INT_GPIO3, 0);
 
 	pinctrl_provide_dummies();
-	if (to_version == 1) {
-		strncpy(imx35_sdma_pdata.fw_name, "sdma-imx35-to1.bin",
-			strlen(imx35_sdma_pdata.fw_name));
-		imx35_sdma_pdata.script_addrs = &imx35_to1_sdma_script;
-	}
 
-	imx_add_imx_sdma("imx35-sdma", MX35_SDMA_BASE_ADDR, MX35_INT_SDMA, &imx35_sdma_pdata);
+	if (to_version == 1)
+		sdmastr = "imx35-to1-sdma";
+	else
+		sdmastr = "imx35-to2-sdma";
+
+	imx_add_imx_sdma(sdmastr, MX35_SDMA_BASE_ADDR, MX35_INT_SDMA, &imx35_sdma_pdata);
 
 	/* Setup AIPS registers */
 	imx_set_aips(MX35_IO_ADDRESS(MX35_AIPS1_BASE_ADDR));
diff --git a/arch/arm/mach-imx/mm-imx5.c b/arch/arm/mach-imx/mm-imx5.c
index cf193d8..051add9 100644
--- a/arch/arm/mach-imx/mm-imx5.c
+++ b/arch/arm/mach-imx/mm-imx5.c
@@ -103,22 +103,8 @@ void __init mx53_init_irq(void)
 	tzic_init_irq(MX53_IO_ADDRESS(MX53_TZIC_BASE_ADDR));
 }
 
-static struct sdma_script_start_addrs imx51_sdma_script __initdata = {
-	.ap_2_ap_addr = 642,
-	.uart_2_mcu_addr = 817,
-	.mcu_2_app_addr = 747,
-	.mcu_2_shp_addr = 961,
-	.ata_2_mcu_addr = 1473,
-	.mcu_2_ata_addr = 1392,
-	.app_2_per_addr = 1033,
-	.app_2_mcu_addr = 683,
-	.shp_2_per_addr = 1251,
-	.shp_2_mcu_addr = 892,
-};
-
 static struct sdma_platform_data imx51_sdma_pdata __initdata = {
 	.fw_name = "sdma-imx51.bin",
-	.script_addrs = &imx51_sdma_script,
 };
 
 static const struct resource imx51_audmux_res[] __initconst = {
-- 
1.8.4.rc3
