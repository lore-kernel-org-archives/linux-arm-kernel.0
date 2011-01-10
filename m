From: yong.shen@freescale.com (yong.shen at freescale.com)
Date: Mon, 10 Jan 2011 20:08:53 +0800
Subject: [PATCH 2/3] ARM i.MX53 enable spi on EVK board
In-Reply-To: <1294661334-7826-1-git-send-email-yong.shen@freescale.com>
References: <1294661334-7826-1-git-send-email-yong.shen@freescale.com>
Message-ID: <1294661334-7826-2-git-send-email-yong.shen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

1. some macro definitions fix
2. add platform data for spi device
3. register spi clocks

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 arch/arm/mach-mx5/Kconfig                    |    1 +
 arch/arm/mach-mx5/board-mx53_evk.c           |   14 ++++++++++++++
 arch/arm/mach-mx5/clock-mx51-mx53.c          |    3 +++
 arch/arm/mach-mx5/devices-imx53.h            |    4 ++++
 arch/arm/plat-mxc/devices/platform-spi_imx.c |   12 ++++++++++++
 arch/arm/plat-mxc/include/mach/mx53.h        |   10 +++++-----
 6 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 23b0e3f..777740b 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -126,6 +126,7 @@ config MACH_MX53_EVK
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  Include support for MX53 EVK platform. This includes specific
 	  configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 4043451..8017d68 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -33,6 +33,8 @@
 #include <mach/iomux-mx53.h>
 
 #define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
+#define EVK_ECSPI1_CS0		IMX_GPIO_NR(3, 19)
+#define EVK_ECSPI1_CS1		IMX_GPIO_NR(2, 30)
 
 #include "crm_regs.h"
 #include "devices-imx53.h"
@@ -89,6 +91,16 @@ static struct fec_platform_data mx53_evk_fec_pdata = {
 	.phy = PHY_INTERFACE_MODE_RMII,
 };
 
+static int mx53_evk_spi_cs[] = {
+	EVK_ECSPI1_CS0,
+	EVK_ECSPI1_CS1,
+};
+
+static const struct spi_imx_master mx53_evk_spi_data __initconst = {
+	.chipselect     = mx53_evk_spi_cs,
+	.num_chipselect = ARRAY_SIZE(mx53_evk_spi_cs),
+};
+
 static void __init mx53_evk_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_evk_pads,
@@ -102,6 +114,8 @@ static void __init mx53_evk_board_init(void)
 
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(1, NULL);
+
+	imx53_add_ecspi(0, &mx53_evk_spi_data);
 }
 
 static void __init mx53_evk_timer_init(void)
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index d0f58a3..a20d0c0 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1330,6 +1330,9 @@ static struct clk_lookup mx53_lookups[] = {
 	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
+	_REGISTER_CLOCK("imx53-ecspi.0", NULL, ecspi1_clk)
+	_REGISTER_CLOCK("imx53-ecspi.1", NULL, ecspi2_clk)
+	_REGISTER_CLOCK("imx53-cspi.0", NULL, cspi_clk)
 };
 
 static void clk_tree_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index f7c89ef..8639735 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -25,3 +25,7 @@ extern const struct imx_sdhci_esdhc_imx_data
 imx53_sdhci_esdhc_imx_data[] __initconst;
 #define imx53_add_sdhci_esdhc_imx(id, pdata)	\
 	imx_add_sdhci_esdhc_imx(&imx53_sdhci_esdhc_imx_data[id], pdata)
+
+extern const struct imx_spi_imx_data imx53_ecspi_data[] __initconst;
+#define imx53_add_ecspi(id, pdata)	\
+	imx_add_spi_imx(&imx53_ecspi_data[id], pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
index 8ea49ad..013c85f 100644
--- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
+++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
@@ -81,6 +81,18 @@ const struct imx_spi_imx_data imx51_ecspi_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
+#ifdef CONFIG_SOC_IMX53
+const struct imx_spi_imx_data imx53_cspi_data __initconst =
+	imx_spi_imx_data_entry_single(MX53, CSPI, "imx53-cspi", 0, , SZ_4K);
+
+const struct imx_spi_imx_data imx53_ecspi_data[] __initconst = {
+#define imx53_ecspi_data_entry(_id, _hwid)				\
+	imx_spi_imx_data_entry(MX53, ECSPI, "imx53-ecspi", _id, _hwid, SZ_4K)
+	imx53_ecspi_data_entry(0, 1),
+	imx53_ecspi_data_entry(1, 2),
+};
+#endif /* ifdef CONFIG_SOC_IMX53 */
+
 struct platform_device *__init imx_add_spi_imx(
 		const struct imx_spi_imx_data *data,
 		const struct spi_imx_master *pdata)
diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index 340937f..d7a8e52 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -56,7 +56,7 @@
 #define MX53_ESDHC1_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00004000)
 #define MX53_ESDHC2_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00008000)
 #define MX53_UART3_BASE_ADDR		(MX53_SPBA0_BASE_ADDR + 0x0000C000)
-#define MX53_CSPI1_BASE_ADDR		(MX53_SPBA0_BASE_ADDR + 0x00010000)
+#define MX53_ECSPI1_BASE_ADDR		(MX53_SPBA0_BASE_ADDR + 0x00010000)
 #define MX53_SSI2_BASE_ADDR		(MX53_SPBA0_BASE_ADDR + 0x00014000)
 #define MX53_ESDHC3_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00020000)
 #define MX53_ESDHC4_BASE_ADDR	(MX53_SPBA0_BASE_ADDR + 0x00024000)
@@ -117,12 +117,12 @@
 #define MX53_ARM_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000A0000)
 #define MX53_OWIRE_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000A4000)
 #define MX53_FIRI_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000A8000)
-#define MX53_CSPI2_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000AC000)
+#define MX53_ECSPI2_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000AC000)
 #define MX53_SDMA_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000B0000)
 #define MX53_SCC_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000B4000)
 #define MX53_ROMCP_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000B8000)
 #define MX53_RTIC_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000BC000)
-#define MX53_CSPI3_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000C0000)
+#define MX53_CSPI_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000C0000)
 #define MX53_I2C2_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000C4000)
 #define MX53_I2C1_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000C8000)
 #define MX53_SSI1_BASE_ADDR	(MX53_AIPS2_BASE_ADDR + 0x000CC000)
@@ -264,8 +264,8 @@
 #define MX53_INT_UART3	33
 #define MX53_INT_RESV34	34
 #define MX53_INT_RESV35	35
-#define MX53_INT_CSPI1	36
-#define MX53_INT_CSPI2	37
+#define MX53_INT_ECSPI1	36
+#define MX53_INT_ECSPI2	37
 #define MX53_INT_CSPI	38
 #define MX53_INT_GPT	39
 #define MX53_INT_EPIT1	40
-- 
1.7.1
