From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 27 Jun 2011 17:12:09 -0300
Subject: [PATCH 2/4] ARM: mx53: Add SSI suport
In-Reply-To: <1309205531-18103-1-git-send-email-fabio.estevam@freescale.com>
References: <1309205531-18103-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1309205531-18103-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/clock-mx51-mx53.c          |    3 +++
 arch/arm/mach-mx5/devices-imx53.h            |    4 ++++
 arch/arm/plat-mxc/devices/platform-imx-ssi.c |   10 ++++++++++
 arch/arm/plat-mxc/include/mach/mx53.h        |   24 ++++++++++++------------
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 789c6cf..6826863 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1490,6 +1490,9 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, dummy_clk)
 	_REGISTER_CLOCK("imx2-wdt.1", NULL, dummy_clk)
 	_REGISTER_CLOCK("imx-sdma", NULL, sdma_clk)
+	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
+	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
+	_REGISTER_CLOCK("imx-ssi.2", NULL, ssi3_clk)
 };
 
 static void clk_tree_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index 48f4c8c..b8a492f 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -32,3 +32,7 @@ extern const struct imx_spi_imx_data imx53_ecspi_data[];
 extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[];
 #define imx53_add_imx2_wdt(id, pdata)	\
 	imx_add_imx2_wdt(&imx53_imx2_wdt_data[id])
+
+extern const struct imx_imx_ssi_data imx53_imx_ssi_data[];
+#define imx53_add_imx_ssi(id, pdata)	\
+	imx_add_imx_ssi(&imx53_imx_ssi_data[id], pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-imx-ssi.c b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
index 2569c8d..a0915d6 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-ssi.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
@@ -76,6 +76,16 @@ const struct imx_imx_ssi_data imx51_imx_ssi_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
+#ifdef CONFIG_SOC_IMX53
+const struct imx_imx_ssi_data imx53_imx_ssi_data[] __initconst = {
+#define imx53_imx_ssi_data_entry(_id, _hwid)				\
+	imx_imx_ssi_data_entry(MX53, _id, _hwid, SZ_16K)
+	imx53_imx_ssi_data_entry(0, 1),
+	imx53_imx_ssi_data_entry(1, 2),
+	imx53_imx_ssi_data_entry(2, 3),
+};
+#endif /* ifdef CONFIG_SOC_IMX53 */
+
 struct platform_device *__init imx_add_imx_ssi(
 		const struct imx_imx_ssi_data *data,
 		const struct imx_ssi_platform_data *pdata)
diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index 7b54eb6..3128af7 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -176,10 +176,10 @@
 /*
  * DMA request assignments
  */
-#define MX53_DMA_REQ_SSI3_TX1		47
-#define MX53_DMA_REQ_SSI3_RX1		46
-#define MX53_DMA_REQ_SSI3_TX2		45
-#define MX53_DMA_REQ_SSI3_RX2		44
+#define MX53_DMA_REQ_SSI3_TX0		47
+#define MX53_DMA_REQ_SSI3_RX0		46
+#define MX53_DMA_REQ_SSI3_TX1		45
+#define MX53_DMA_REQ_SSI3_RX1		44
 #define MX53_DMA_REQ_UART3_TX	43
 #define MX53_DMA_REQ_UART3_RX	42
 #define MX53_DMA_REQ_ESAI_TX		41
@@ -194,14 +194,14 @@
 #define MX53_DMA_REQ_ASRC_DMA1	32
 #define MX53_DMA_REQ_EMI_WR		31
 #define MX53_DMA_REQ_EMI_RD		30
-#define MX53_DMA_REQ_SSI1_TX1		29
-#define MX53_DMA_REQ_SSI1_RX1		28
-#define MX53_DMA_REQ_SSI1_TX2		27
-#define MX53_DMA_REQ_SSI1_RX2		26
-#define MX53_DMA_REQ_SSI2_TX1		25
-#define MX53_DMA_REQ_SSI2_RX1		24
-#define MX53_DMA_REQ_SSI2_TX2		23
-#define MX53_DMA_REQ_SSI2_RX2		22
+#define MX53_DMA_REQ_SSI1_TX0		29
+#define MX53_DMA_REQ_SSI1_RX0		28
+#define MX53_DMA_REQ_SSI1_TX1		27
+#define MX53_DMA_REQ_SSI1_RX1		26
+#define MX53_DMA_REQ_SSI2_TX0		25
+#define MX53_DMA_REQ_SSI2_RX0		24
+#define MX53_DMA_REQ_SSI2_TX1		23
+#define MX53_DMA_REQ_SSI2_RX1		22
 #define MX53_DMA_REQ_I2C2_SDHC2	21
 #define MX53_DMA_REQ_I2C1_SDHC1	20
 #define MX53_DMA_REQ_UART1_TX	19
-- 
1.6.0.4
