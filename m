From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 28 May 2011 16:05:08 -0300
Subject: [PATCH] ARM: mx51/sdma: Check the chip revision in run-time
Message-ID: <1306609508-7455-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check the MX51 chip revision in run-time so that the correct SDMA firmware can
be loaded.

While at it also remove the silicon revision from the sdma_script_start_addrs 
structure name for MX51. All the MX51 revisions share the same SDMA start addresses.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/devices/platform-imx-dma.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index 3538b85..b130f60 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -139,7 +139,7 @@ static struct sdma_script_start_addrs addr_imx35_to2 = {
 #endif
 
 #ifdef CONFIG_SOC_IMX51
-static struct sdma_script_start_addrs addr_imx51_to1 = {
+static struct sdma_script_start_addrs addr_imx51 = {
 	.ap_2_ap_addr = 642,
 	.uart_2_mcu_addr = 817,
 	.mcu_2_app_addr = 747,
@@ -196,7 +196,9 @@ static int __init imxXX_add_imx_dma(void)
 
 #if defined(CONFIG_SOC_IMX51)
 	if (cpu_is_mx51()) {
-		imx51_imx_sdma_data.pdata.script_addrs = &addr_imx51_to1;
+		int to_version = mx51_revision() >> 4;
+		imx51_imx_sdma_data.pdata.to_version = to_version;
+		imx51_imx_sdma_data.pdata.script_addrs = &addr_imx51;
 		ret = imx_add_imx_sdma(&imx51_imx_sdma_data);
 	} else
 #endif
-- 
1.6.0.4
