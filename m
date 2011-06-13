From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 12 Jun 2011 21:33:00 -0300
Subject: [PATCH] ARM: mx53: Add SDMA support for MX53
Message-ID: <1307925180-16991-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/devices/platform-imx-dma.c |   28 ++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index b130f60..4e7fbc2 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -51,6 +51,11 @@ struct imx_imx_sdma_data imx51_imx_sdma_data __initconst =
 	imx_imx_sdma_data_entry_single(MX51, 2, "imx51", 0);
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
+#ifdef CONFIG_SOC_IMX53
+struct imx_imx_sdma_data imx53_imx_sdma_data __initconst =
+	imx_imx_sdma_data_entry_single(MX53, 2, "imx53", 0);
+#endif /* ifdef CONFIG_SOC_IMX53 */
+
 static struct platform_device __init __maybe_unused *imx_add_imx_sdma(
 		const struct imx_imx_sdma_data *data)
 {
@@ -153,6 +158,22 @@ static struct sdma_script_start_addrs addr_imx51 = {
 };
 #endif
 
+#ifdef CONFIG_SOC_IMX53
+static struct sdma_script_start_addrs addr_imx53 = {
+	.ap_2_ap_addr = 642,
+	.app_2_mcu_addr = 683,
+	.mcu_2_app_addr = 747,
+	.uart_2_mcu_addr = 817,
+	.shp_2_mcu_addr = 891,
+	.mcu_2_shp_addr = 960,
+	.uartsh_2_mcu_addr = 1032,
+	.spdif_2_mcu_addr = 1100,
+	.mcu_2_spdif_addr = 1134,
+	.firi_2_mcu_addr = 1193,
+	.mcu_2_firi_addr = 1290,
+};
+#endif
+
 static int __init imxXX_add_imx_dma(void)
 {
 	struct platform_device *ret;
@@ -202,6 +223,13 @@ static int __init imxXX_add_imx_dma(void)
 		ret = imx_add_imx_sdma(&imx51_imx_sdma_data);
 	} else
 #endif
+
+#if defined(CONFIG_SOC_IMX53)
+	if (cpu_is_mx53()) {
+		imx53_imx_sdma_data.pdata.script_addrs = &addr_imx53;
+		ret = imx_add_imx_sdma(&imx53_imx_sdma_data);
+	} else
+#endif
 		ret = ERR_PTR(-ENODEV);
 
 	if (IS_ERR(ret))
-- 
1.7.1
