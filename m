From: yong.shen@freescale.com (yong.shen at freescale.com)
Date: Fri, 7 Jan 2011 12:25:34 +0800
Subject: [PATCH v2 3/3] ARM i.MX53 enable sdhc support on EVK board
In-Reply-To: <1294374334-18920-1-git-send-email-yong.shen@freescale.com>
References: <1294374334-18920-1-git-send-email-yong.shen@freescale.com>
Message-ID: <1294374334-18920-4-git-send-email-yong.shen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

1. changes some register address to fit macro definition
2. add platform data and clock for sdhc

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 arch/arm/mach-mx5/Kconfig                          |    1 +
 arch/arm/mach-mx5/board-mx53_evk.c                 |    3 +++
 arch/arm/mach-mx5/clock-mx51-mx53.c                |    2 ++
 arch/arm/mach-mx5/devices-imx53.h                  |    5 +++++
 .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   12 ++++++++++++
 arch/arm/plat-mxc/include/mach/mx53.h              |   16 ++++++++--------
 6 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 632d711..23b0e3f 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -125,6 +125,7 @@ config MACH_MX53_EVK
 	select SOC_IMX53
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	help
 	  Include support for MX53 EVK platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index d0b4570..4043451 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -99,6 +99,9 @@ static void __init mx53_evk_board_init(void)
 
 	imx53_add_imx_i2c(0, &mx53_evk_i2c_data);
 	imx53_add_imx_i2c(1, &mx53_evk_i2c_data);
+
+	imx53_add_sdhci_esdhc_imx(0, NULL);
+	imx53_add_sdhci_esdhc_imx(1, NULL);
 }
 
 static void __init mx53_evk_timer_init(void)
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 0ade3c4..15fa89e 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1328,6 +1328,8 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
 	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
 	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
 };
 
 static void clk_tree_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index ca1232b..f7c89ef 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -20,3 +20,8 @@ extern const struct imx_imx_uart_1irq_data imx53_imx_uart_data[] __initconst;
 extern const struct imx_imx_i2c_data imx53_imx_i2c_data[] __initconst;
 #define imx53_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx53_imx_i2c_data[id], pdata)
+
+extern const struct imx_sdhci_esdhc_imx_data
+imx53_sdhci_esdhc_imx_data[] __initconst;
+#define imx53_add_sdhci_esdhc_imx(id, pdata)	\
+	imx_add_sdhci_esdhc_imx(&imx53_sdhci_esdhc_imx_data[id], pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
index b352564..6b2940b 100644
--- a/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
+++ b/arch/arm/plat-mxc/devices/platform-sdhci-esdhc-imx.c
@@ -53,6 +53,18 @@ imx51_sdhci_esdhc_imx_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
+#ifdef CONFIG_SOC_IMX53
+const struct imx_sdhci_esdhc_imx_data
+imx53_sdhci_esdhc_imx_data[] __initconst = {
+#define imx53_sdhci_esdhc_imx_data_entry(_id, _hwid)			\
+	imx_sdhci_esdhc_imx_data_entry(MX53, _id, _hwid)
+	imx53_sdhci_esdhc_imx_data_entry(0, 1),
+	imx53_sdhci_esdhc_imx_data_entry(1, 2),
+	imx53_sdhci_esdhc_imx_data_entry(2, 3),
+	imx53_sdhci_esdhc_imx_data_entry(3, 4),
+};
+#endif /* ifdef CONFIG_SOC_IMX53 */
+
 struct platform_device *__init imx_add_sdhci_esdhc_imx(
 		const struct imx_sdhci_esdhc_imx_data *data,
 		const struct esdhc_platform_data *pdata)
diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index a35e0c7..340937f 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -53,13 +53,13 @@
 #define MX53_SPBA0_BASE_ADDR		0x50000000
 #define MX53_SPBA0_SIZE		SZ_1M
 
-#define MX53_MMC_SDHC1_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00004000)
-#define MX53_MMC_SDHC2_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00008000)
+#define MX53_ESDHC1_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00004000)
+#define MX53_ESDHC2_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00008000)
 #define MX53_UART3_BASE_ADDR		(MX53_SPBA0_BASE_ADDR + 0x0000C000)
 #define MX53_CSPI1_BASE_ADDR		(MX53_SPBA0_BASE_ADDR + 0x00010000)
 #define MX53_SSI2_BASE_ADDR		(MX53_SPBA0_BASE_ADDR + 0x00014000)
-#define MX53_MMC_SDHC3_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00020000)
-#define MX53_MMC_SDHC4_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00024000)
+#define MX53_ESDHC3_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00020000)
+#define MX53_ESDHC4_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00024000)
 #define MX53_SPDIF_BASE_ADDR		(MX53_SPBA0_BASE_ADDR + 0x00028000)
 #define MX53_ASRC_BASE_ADDR		(MX53_SPBA0_BASE_ADDR + 0x0002C000)
 #define MX53_ATA_DMA_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00030000)
@@ -229,10 +229,10 @@
  * Interrupt numbers
  */
 #define MX53_INT_RESV0		0
-#define MX53_INT_MMC_SDHC1	1
-#define MX53_INT_MMC_SDHC2	2
-#define MX53_INT_MMC_SDHC3	3
-#define MX53_INT_MMC_SDHC4	4
+#define MX53_INT_ESDHC1	1
+#define MX53_INT_ESDHC2	2
+#define MX53_INT_ESDHC3	3
+#define MX53_INT_ESDHC4	4
 #define MX53_INT_RESV5	5
 #define MX53_INT_SDMA	6
 #define MX53_INT_IOMUX	7
-- 
1.7.1
