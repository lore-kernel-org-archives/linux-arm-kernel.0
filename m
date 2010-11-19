From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 19 Nov 2010 17:06:28 -0200
Subject: [PATCH 1/2] ARM: mx5: introduce SOC_IMX51
Message-ID: <1290193589-17633-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
applies on top of Uwe's imx-for-2.6.38 tree

 arch/arm/mach-mx5/Kconfig                     |    4 ++++
 arch/arm/plat-mxc/devices/platform-esdhc.c    |    4 ++--
 arch/arm/plat-mxc/devices/platform-fec.c      |    2 +-
 arch/arm/plat-mxc/devices/platform-imx-dma.c  |    6 +++---
 arch/arm/plat-mxc/devices/platform-imx-i2c.c  |    4 ++--
 arch/arm/plat-mxc/devices/platform-imx-ssi.c  |    4 ++--
 arch/arm/plat-mxc/devices/platform-imx-uart.c |    4 ++--
 arch/arm/plat-mxc/devices/platform-mxc_nand.c |    2 +-
 arch/arm/plat-mxc/devices/platform-spi_imx.c  |    4 ++--
 arch/arm/plat-mxc/ehci.c                      |    2 +-
 10 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 3ec910a..1025a89 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -2,11 +2,15 @@ if ARCH_MX5
 
 config ARCH_MX51
 	bool
+
+config SOC_IMX51
+	bool
 	default y
 	select MXC_TZIC
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
 	select ARCH_HAS_CPUFREQ
+	select ARCH_MX51
 
 comment "MX5 platforms:"
 
diff --git a/arch/arm/plat-mxc/devices/platform-esdhc.c b/arch/arm/plat-mxc/devices/platform-esdhc.c
index 013e92f..48b2547 100644
--- a/arch/arm/plat-mxc/devices/platform-esdhc.c
+++ b/arch/arm/plat-mxc/devices/platform-esdhc.c
@@ -39,7 +39,7 @@ const struct imx_esdhc_imx_data imx35_esdhc_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
-#ifdef CONFIG_ARCH_MX51
+#ifdef CONFIG_SOC_IMX51
 const struct imx_esdhc_imx_data imx51_esdhc_data[] __initconst = {
 #define imx51_esdhc_data_entry(_id, _hwid)				\
 	imx_esdhc_imx_data_entry(MX51, _id, _hwid)
@@ -48,7 +48,7 @@ const struct imx_esdhc_imx_data imx51_esdhc_data[] __initconst = {
 	imx51_esdhc_data_entry(2, 3),
 	imx51_esdhc_data_entry(3, 4),
 };
-#endif /* ifdef CONFIG_ARCH_MX51 */
+#endif /* ifdef CONFIG_SOC_IMX51 */
 
 struct platform_device *__init imx_add_esdhc(
 		const struct imx_esdhc_imx_data *data,
diff --git a/arch/arm/plat-mxc/devices/platform-fec.c b/arch/arm/plat-mxc/devices/platform-fec.c
index 8d78aed..269ec78 100644
--- a/arch/arm/plat-mxc/devices/platform-fec.c
+++ b/arch/arm/plat-mxc/devices/platform-fec.c
@@ -31,7 +31,7 @@ const struct imx_fec_data imx35_fec_data __initconst =
 	imx_fec_data_entry_single(MX35);
 #endif
 
-#ifdef CONFIG_ARCH_MX51
+#ifdef CONFIG_SOC_IMX51
 const struct imx_fec_data imx51_fec_data __initconst =
 	imx_fec_data_entry_single(MX51);
 #endif
diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index 10f41cc..82f28f7 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -54,10 +54,10 @@ struct imx_imx_sdma_data imx35_imx_sdma_data __initdata =
 	imx_imx_sdma_data_entry_single(MX35, 2, "imx35", 0);
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
-#ifdef CONFIG_ARCH_MX51
+#ifdef CONFIG_SOC_IMX51
 const struct imx_imx_sdma_data imx51_imx_sdma_data __initconst =
 	imx_imx_sdma_data_entry_single(MX51, 2, "imx51", 0);
-#endif /* ifdef CONFIG_ARCH_MX51 */
+#endif /* ifdef CONFIG_SOC_IMX51 */
 
 static struct platform_device __init __maybe_unused *imx_add_imx_sdma(
 		const struct imx_imx_sdma_data *data)
@@ -114,7 +114,7 @@ static int __init imxXX_add_imx_dma(void)
 	} else
 #endif
 
-#if defined(CONFIG_ARCH_MX51)
+#if defined(CONFIG_SOC_IMX51)
 	if (cpu_is_mx51())
 		ret = imx_add_imx_sdma(&imx51_imx_sdma_data);
 	else
diff --git a/arch/arm/plat-mxc/devices/platform-imx-i2c.c b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
index 075bd8e..72ba880 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-i2c.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
@@ -69,14 +69,14 @@ const struct imx_imx_i2c_data imx35_imx_i2c_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
-#ifdef CONFIG_ARCH_MX51
+#ifdef CONFIG_SOC_IMX51
 const struct imx_imx_i2c_data imx51_imx_i2c_data[] __initconst = {
 #define imx51_imx_i2c_data_entry(_id, _hwid)				\
 	imx_imx_i2c_data_entry(MX51, _id, _hwid, SZ_4K)
 	imx51_imx_i2c_data_entry(0, 1),
 	imx51_imx_i2c_data_entry(1, 2),
 };
-#endif /* ifdef CONFIG_ARCH_MX51 */
+#endif /* ifdef CONFIG_SOC_IMX51 */
 
 struct platform_device *__init imx_add_imx_i2c(
 		const struct imx_imx_i2c_data *data,
diff --git a/arch/arm/plat-mxc/devices/platform-imx-ssi.c b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
index 02002fc..ac3d572 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-ssi.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
@@ -66,14 +66,14 @@ const struct imx_imx_ssi_data imx35_imx_ssi_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
-#ifdef CONFIG_ARCH_MX51
+#ifdef CONFIG_SOC_IMX51
 const struct imx_imx_ssi_data imx51_imx_ssi_data[] __initconst = {
 #define imx51_imx_ssi_data_entry(_id, _hwid)				\
 	imx_imx_ssi_data_entry(MX51, _id, _hwid, SZ_4K)
 	imx51_imx_ssi_data_entry(0, 1),
 	imx51_imx_ssi_data_entry(1, 2),
 };
-#endif /* ifdef CONFIG_ARCH_MX51 */
+#endif /* ifdef CONFIG_SOC_IMX51 */
 
 struct platform_device *__init imx_add_imx_ssi(
 		const struct imx_imx_ssi_data *data,
diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/arm/plat-mxc/devices/platform-imx-uart.c
index 08bbd65..7b45b78 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
@@ -94,7 +94,7 @@ const struct imx_imx_uart_1irq_data imx35_imx_uart_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
-#ifdef CONFIG_ARCH_MX51
+#ifdef CONFIG_SOC_IMX51
 const struct imx_imx_uart_1irq_data imx51_imx_uart_data[] __initconst = {
 #define imx51_imx_uart_data_entry(_id, _hwid)				\
 	imx_imx_uart_1irq_data_entry(MX51, _id, _hwid, SZ_4K)
@@ -102,7 +102,7 @@ const struct imx_imx_uart_1irq_data imx51_imx_uart_data[] __initconst = {
 	imx51_imx_uart_data_entry(1, 2),
 	imx51_imx_uart_data_entry(2, 3),
 };
-#endif /* ifdef CONFIG_ARCH_MX51 */
+#endif /* ifdef CONFIG_SOC_IMX51 */
 
 struct platform_device *__init imx_add_imx_uart_3irq(
 		const struct imx_imx_uart_3irq_data *data,
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_nand.c b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
index f5beac0..1568f39 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_nand.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
@@ -51,7 +51,7 @@ const struct imx_mxc_nand_data imx35_mxc_nand_data __initconst =
 	imx_mxc_nand_data_entry_single(MX35, SZ_8K);
 #endif
 
-#ifdef CONFIG_ARCH_MX51
+#ifdef CONFIG_SOC_IMX51
 const struct imx_mxc_nand_data imx51_mxc_nand_data __initconst =
 	imx_mxc_nandv3_data_entry_single(MX51, SZ_16K);
 #endif
diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
index 8f2b60a..e1ffa1f 100644
--- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
+++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
@@ -68,7 +68,7 @@ const struct imx_spi_imx_data imx35_cspi_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
-#ifdef CONFIG_ARCH_MX51
+#ifdef CONFIG_SOC_IMX51
 const struct imx_spi_imx_data imx51_cspi_data __initconst =
 	imx_spi_imx_data_entry_single(MX51, CSPI, "imx51-cspi", 0, , SZ_4K);
 
@@ -78,7 +78,7 @@ const struct imx_spi_imx_data imx51_ecspi_data[] __initconst = {
 	imx51_ecspi_data_entry(0, 1),
 	imx51_ecspi_data_entry(1, 2),
 };
-#endif /* ifdef CONFIG_ARCH_MX51 */
+#endif /* ifdef CONFIG_SOC_IMX51 */
 
 struct platform_device *__init imx_add_spi_imx(
 		const struct imx_spi_imx_data *data,
diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
index 4bac3d5..1c7ecd9 100644
--- a/arch/arm/plat-mxc/ehci.c
+++ b/arch/arm/plat-mxc/ehci.c
@@ -246,7 +246,7 @@ int mxc_initialize_usb_hw(int port, unsigned int flags)
 		return 0;
 	}
 #endif /* CONFIG_MACH_MX27 */
-#ifdef CONFIG_ARCH_MX51
+#ifdef CONFIG_SOC_IMX51
 	if (cpu_is_mx51()) {
 		void __iomem *usb_base;
 		void __iomem *usbotg_base;
-- 
1.6.0.4
