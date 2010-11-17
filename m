From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 17 Nov 2010 22:30:12 +0100
Subject: [PATCH 44/51] ARM: mx3: introduce SOC_IMX31 and SOC_IMX35
In-Reply-To: <20101117212821.GF8942@pengutronix.de>
References: <20101117212821.GF8942@pengutronix.de>
Message-ID: <1290029419-21435-44-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Additionally convert some known to be good usages to the new
names.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig                     |   40 ++++++++++++++++---------
 arch/arm/mach-mx3/Makefile                    |    4 +-
 arch/arm/mach-mx3/mm.c                        |    8 ++--
 arch/arm/plat-mxc/devices/Kconfig             |    2 +-
 arch/arm/plat-mxc/devices/platform-esdhc.c    |    4 +-
 arch/arm/plat-mxc/devices/platform-fec.c      |    2 +-
 arch/arm/plat-mxc/devices/platform-flexcan.c  |    4 +-
 arch/arm/plat-mxc/devices/platform-imx-dma.c  |   12 ++++----
 arch/arm/plat-mxc/devices/platform-imx-i2c.c  |    8 ++--
 arch/arm/plat-mxc/devices/platform-imx-ssi.c  |    8 ++--
 arch/arm/plat-mxc/devices/platform-imx-uart.c |    8 ++--
 arch/arm/plat-mxc/devices/platform-mxc_nand.c |    4 +-
 arch/arm/plat-mxc/devices/platform-mxc_w1.c   |    8 ++--
 arch/arm/plat-mxc/devices/platform-spi_imx.c  |    8 ++--
 arch/arm/plat-mxc/gpio.c                      |    8 ++--
 15 files changed, 70 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 3f83fd5..29ec5ad 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -1,21 +1,33 @@
 if ARCH_MX3
 
+# ARCH_MX31 and ARCH_MX35 are left for compatibility
+# Some usages assume that having one of them implies not having (e.g.) ARCH_MX2.
+# To easily distinguish good and reviewed from unreviewed usages new (and IMHO
+# more sensible) names are used: SOC_IMX31 and SOC_IMX35
 config ARCH_MX31
-	select ARCH_HAS_RNGA
-	select ARCH_MXC_AUDMUX_V2
 	bool
 
 config ARCH_MX35
 	bool
+
+config SOC_IMX31
+	bool
+	select ARCH_HAS_RNGA
+	select ARCH_MXC_AUDMUX_V2
+	select ARCH_MX31
+
+config SOC_IMX35
+	bool
 	select ARCH_MXC_IOMUX_V3
 	select ARCH_MXC_AUDMUX_V2
 	select HAVE_EPIT
+	select ARCH_MX35
 
 comment "MX3 platforms:"
 
 config MACH_MX31ADS
 	bool "Support MX31ADS platforms"
-	select ARCH_MX31
+	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -37,7 +49,7 @@ config MACH_MX31ADS_WM1133_EV1
 
 config MACH_PCM037
 	bool "Support Phytec pcm037 (i.MX31) platforms"
-	select ARCH_MX31
+	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
@@ -58,7 +70,7 @@ config MACH_PCM037_EET
 
 config MACH_MX31LITE
 	bool "Support MX31 LITEKIT (LogicPD)"
-	select ARCH_MX31
+	select SOC_IMX31
 	select MXC_ULPI if USB_ULPI
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
@@ -69,7 +81,7 @@ config MACH_MX31LITE
 
 config MACH_MX31_3DS
 	bool "Support MX31PDK (3DS)"
-	select ARCH_MX31
+	select SOC_IMX31
 	select MXC_DEBUG_BOARD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
@@ -89,7 +101,7 @@ config MACH_MX31_3DS_MXC_NAND_USE_BBT
 
 config MACH_MX31MOBOARD
 	bool "Support mx31moboard platforms (EPFL Mobots group)"
-	select ARCH_MX31
+	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SPI_IMX
@@ -100,7 +112,7 @@ config MACH_MX31MOBOARD
 
 config MACH_MX31LILLY
 	bool "Support MX31 LILLY-1131 platforms (INCO startec)"
-	select ARCH_MX31
+	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_ULPI if USB_ULPI
@@ -110,7 +122,7 @@ config MACH_MX31LILLY
 
 config MACH_QONG
 	bool "Support Dave/DENX QongEVB-LITE platform"
-	select ARCH_MX31
+	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_UART
 	help
 	  Include support for Dave/DENX QongEVB-LITE platform. This includes
@@ -118,7 +130,7 @@ config MACH_QONG
 
 config MACH_PCM043
 	bool "Support Phytec pcm043 (i.MX35) platforms"
-	select ARCH_MX35
+	select SOC_IMX35
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
@@ -132,7 +144,7 @@ config MACH_PCM043
 
 config MACH_ARMADILLO5X0
 	bool "Support Atmark Armadillo-500 Development Base Board"
-	select ARCH_MX31
+	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
@@ -143,7 +155,7 @@ config MACH_ARMADILLO5X0
 
 config MACH_MX35_3DS
 	bool "Support MX35PDK platform"
-	select ARCH_MX35
+	select SOC_IMX35
 	select MXC_DEBUG_BOARD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_NAND
@@ -155,7 +167,7 @@ config MACH_MX35_3DS
 
 config MACH_KZM_ARM11_01
 	bool "Support KZM-ARM11-01(Kyoto Microcomputer)"
-	select ARCH_MX31
+	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_IMX_UART
 	help
 	  Include support for KZM-ARM11-01. This includes specific
@@ -163,7 +175,7 @@ config MACH_KZM_ARM11_01
 
 config MACH_EUKREA_CPUIMX35
 	bool "Support Eukrea CPUIMX35 Platform"
-	select ARCH_MX35
+	select SOC_IMX35
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_MXC_NAND
diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
index 7feb6c4..8db1329 100644
--- a/arch/arm/mach-mx3/Makefile
+++ b/arch/arm/mach-mx3/Makefile
@@ -5,8 +5,8 @@
 # Object file lists.
 
 obj-y				:= mm.o devices.o cpu.o
-obj-$(CONFIG_ARCH_MX31)		+= clock-imx31.o iomux-imx31.o
-obj-$(CONFIG_ARCH_MX35)		+= clock-imx35.o
+obj-$(CONFIG_SOC_IMX31)		+= clock-imx31.o iomux-imx31.o
+obj-$(CONFIG_SOC_IMX35)		+= clock-imx35.o
 obj-$(CONFIG_MACH_MX31ADS)	+= mach-mx31ads.o
 obj-$(CONFIG_MACH_MX31LILLY)	+= mach-mx31lilly.o mx31lilly-db.o
 obj-$(CONFIG_MACH_MX31LITE)	+= mach-mx31lite.o mx31lite-db.o
diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
index 2e81271..47118f7 100644
--- a/arch/arm/mach-mx3/mm.c
+++ b/arch/arm/mach-mx3/mm.c
@@ -36,7 +36,7 @@
  * @ingroup Memory
  */
 
-#ifdef CONFIG_ARCH_MX31
+#ifdef CONFIG_SOC_IMX31
 static struct map_desc mx31_io_desc[] __initdata = {
 	imx_map_entry(MX31, X_MEMC, MT_DEVICE),
 	imx_map_entry(MX31, AVIC, MT_DEVICE_NONSHARED),
@@ -64,9 +64,9 @@ void __init mx31_init_irq(void)
 	mxc_init_irq(MX31_IO_ADDRESS(MX31_AVIC_BASE_ADDR));
 	imx31_register_gpios();
 }
-#endif /* ifdef CONFIG_ARCH_MX31 */
+#endif /* ifdef CONFIG_SOC_IMX31 */
 
-#ifdef CONFIG_ARCH_MX35
+#ifdef CONFIG_SOC_IMX35
 static struct map_desc mx35_io_desc[] __initdata = {
 	imx_map_entry(MX35, X_MEMC, MT_DEVICE),
 	imx_map_entry(MX35, AVIC, MT_DEVICE_NONSHARED),
@@ -90,7 +90,7 @@ void __init mx35_init_irq(void)
 	mxc_init_irq(MX35_IO_ADDRESS(MX35_AVIC_BASE_ADDR));
 	imx35_register_gpios();
 }
-#endif /* ifdef CONFIG_ARCH_MX35 */
+#endif /* ifdef CONFIG_SOC_IMX35 */
 
 #ifdef CONFIG_CACHE_L2X0
 static int mxc_init_l2x0(void)
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index dbb2078..1be4476 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -3,7 +3,7 @@ config IMX_HAVE_PLATFORM_ESDHC
 
 config IMX_HAVE_PLATFORM_FEC
 	bool
-	default y if ARCH_MX25 || SOC_IMX27 || ARCH_MX35 || ARCH_MX51
+	default y if ARCH_MX25 || SOC_IMX27 || SOC_IMX35 || ARCH_MX51
 
 config IMX_HAVE_PLATFORM_FLEXCAN
 	select HAVE_CAN_FLEXCAN if CAN
diff --git a/arch/arm/plat-mxc/devices/platform-esdhc.c b/arch/arm/plat-mxc/devices/platform-esdhc.c
index 87df70b..013e92f 100644
--- a/arch/arm/plat-mxc/devices/platform-esdhc.c
+++ b/arch/arm/plat-mxc/devices/platform-esdhc.c
@@ -29,7 +29,7 @@ const struct imx_esdhc_imx_data imx25_esdhc_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX25 */
 
-#ifdef CONFIG_ARCH_MX35
+#ifdef CONFIG_SOC_IMX35
 const struct imx_esdhc_imx_data imx35_esdhc_data[] __initconst = {
 #define imx35_esdhc_data_entry(_id, _hwid)                           \
 	imx_esdhc_imx_data_entry(MX35, _id, _hwid)
@@ -37,7 +37,7 @@ const struct imx_esdhc_imx_data imx35_esdhc_data[] __initconst = {
 	imx35_esdhc_data_entry(1, 2),
 	imx35_esdhc_data_entry(2, 3),
 };
-#endif /* ifdef CONFIG_ARCH_MX35 */
+#endif /* ifdef CONFIG_SOC_IMX35 */
 
 #ifdef CONFIG_ARCH_MX51
 const struct imx_esdhc_imx_data imx51_esdhc_data[] __initconst = {
diff --git a/arch/arm/plat-mxc/devices/platform-fec.c b/arch/arm/plat-mxc/devices/platform-fec.c
index e6a365e..8d78aed 100644
--- a/arch/arm/plat-mxc/devices/platform-fec.c
+++ b/arch/arm/plat-mxc/devices/platform-fec.c
@@ -26,7 +26,7 @@ const struct imx_fec_data imx27_fec_data __initconst =
 	imx_fec_data_entry_single(MX27);
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
-#ifdef CONFIG_ARCH_MX35
+#ifdef CONFIG_SOC_IMX35
 const struct imx_fec_data imx35_fec_data __initconst =
 	imx_fec_data_entry_single(MX35);
 #endif
diff --git a/arch/arm/plat-mxc/devices/platform-flexcan.c b/arch/arm/plat-mxc/devices/platform-flexcan.c
index f10db6f..4e8497a 100644
--- a/arch/arm/plat-mxc/devices/platform-flexcan.c
+++ b/arch/arm/plat-mxc/devices/platform-flexcan.c
@@ -28,14 +28,14 @@ const struct imx_flexcan_data imx25_flexcan_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX25 */
 
-#ifdef CONFIG_ARCH_MX35
+#ifdef CONFIG_SOC_IMX35
 const struct imx_flexcan_data imx35_flexcan_data[] __initconst = {
 #define imx35_flexcan_data_entry(_id, _hwid)				\
 	imx_flexcan_data_entry(MX35, _id, _hwid, SZ_16K)
 	imx35_flexcan_data_entry(0, 1),
 	imx35_flexcan_data_entry(1, 2),
 };
-#endif /* ifdef CONFIG_ARCH_MX35 */
+#endif /* ifdef CONFIG_SOC_IMX35 */
 
 struct platform_device *__init imx_add_flexcan(
 		const struct imx_flexcan_data *data,
diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index cbafd93..10f41cc 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -44,15 +44,15 @@ const struct imx_imx_sdma_data imx25_imx_sdma_data __initconst =
 	imx_imx_sdma_data_entry_single(MX25, 1, "imx25", 0);
 #endif /* ifdef CONFIG_SOC_IMX25 */
 
-#ifdef CONFIG_ARCH_MX31
+#ifdef CONFIG_SOC_IMX31
 struct imx_imx_sdma_data imx31_imx_sdma_data __initdata =
 	imx_imx_sdma_data_entry_single(MX31, 1, "imx31", 0);
-#endif /* ifdef CONFIG_ARCH_MX31 */
+#endif /* ifdef CONFIG_SOC_IMX31 */
 
-#ifdef CONFIG_ARCH_MX35
+#ifdef CONFIG_SOC_IMX35
 struct imx_imx_sdma_data imx35_imx_sdma_data __initdata =
 	imx_imx_sdma_data_entry_single(MX35, 2, "imx35", 0);
-#endif /* ifdef CONFIG_ARCH_MX35 */
+#endif /* ifdef CONFIG_SOC_IMX35 */
 
 #ifdef CONFIG_ARCH_MX51
 const struct imx_imx_sdma_data imx51_imx_sdma_data __initconst =
@@ -100,14 +100,14 @@ static int __init imxXX_add_imx_dma(void)
 	else
 #endif
 
-#if defined(CONFIG_ARCH_MX31)
+#if defined(CONFIG_SOC_IMX31)
 	if (cpu_is_mx31()) {
 		imx31_imx_sdma_data.pdata.to_version = mx31_revision() >> 4;
 		ret = imx_add_imx_sdma(&imx31_imx_sdma_data);
 	} else
 #endif
 
-#if defined(CONFIG_ARCH_MX35)
+#if defined(CONFIG_SOC_IMX35)
 	if (cpu_is_mx35()) {
 		imx35_imx_sdma_data.pdata.to_version = mx35_revision() >> 4;
 		ret = imx_add_imx_sdma(&imx35_imx_sdma_data);
diff --git a/arch/arm/plat-mxc/devices/platform-imx-i2c.c b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
index 2cb0232..075bd8e 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-i2c.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-i2c.c
@@ -49,7 +49,7 @@ const struct imx_imx_i2c_data imx27_imx_i2c_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
-#ifdef CONFIG_ARCH_MX31
+#ifdef CONFIG_SOC_IMX31
 const struct imx_imx_i2c_data imx31_imx_i2c_data[] __initconst = {
 #define imx31_imx_i2c_data_entry(_id, _hwid)				\
 	imx_imx_i2c_data_entry(MX31, _id, _hwid, SZ_4K)
@@ -57,9 +57,9 @@ const struct imx_imx_i2c_data imx31_imx_i2c_data[] __initconst = {
 	imx31_imx_i2c_data_entry(1, 2),
 	imx31_imx_i2c_data_entry(2, 3),
 };
-#endif /* ifdef CONFIG_ARCH_MX31 */
+#endif /* ifdef CONFIG_SOC_IMX31 */
 
-#ifdef CONFIG_ARCH_MX35
+#ifdef CONFIG_SOC_IMX35
 const struct imx_imx_i2c_data imx35_imx_i2c_data[] __initconst = {
 #define imx35_imx_i2c_data_entry(_id, _hwid)				\
 	imx_imx_i2c_data_entry(MX35, _id, _hwid, SZ_4K)
@@ -67,7 +67,7 @@ const struct imx_imx_i2c_data imx35_imx_i2c_data[] __initconst = {
 	imx35_imx_i2c_data_entry(1, 2),
 	imx35_imx_i2c_data_entry(2, 3),
 };
-#endif /* ifdef CONFIG_ARCH_MX35 */
+#endif /* ifdef CONFIG_SOC_IMX35 */
 
 #ifdef CONFIG_ARCH_MX51
 const struct imx_imx_i2c_data imx51_imx_i2c_data[] __initconst = {
diff --git a/arch/arm/plat-mxc/devices/platform-imx-ssi.c b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
index d6410e1..02002fc 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-ssi.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-ssi.c
@@ -48,23 +48,23 @@ const struct imx_imx_ssi_data imx27_imx_ssi_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
-#ifdef CONFIG_ARCH_MX31
+#ifdef CONFIG_SOC_IMX31
 const struct imx_imx_ssi_data imx31_imx_ssi_data[] __initconst = {
 #define imx31_imx_ssi_data_entry(_id, _hwid)				\
 	imx_imx_ssi_data_entry(MX31, _id, _hwid, SZ_4K)
 	imx31_imx_ssi_data_entry(0, 1),
 	imx31_imx_ssi_data_entry(1, 2),
 };
-#endif /* ifdef CONFIG_ARCH_MX31 */
+#endif /* ifdef CONFIG_SOC_IMX31 */
 
-#ifdef CONFIG_ARCH_MX35
+#ifdef CONFIG_SOC_IMX35
 const struct imx_imx_ssi_data imx35_imx_ssi_data[] __initconst = {
 #define imx35_imx_ssi_data_entry(_id, _hwid)				\
 	imx_imx_ssi_data_entry(MX35, _id, _hwid, SZ_4K)
 	imx35_imx_ssi_data_entry(0, 1),
 	imx35_imx_ssi_data_entry(1, 2),
 };
-#endif /* ifdef CONFIG_ARCH_MX35 */
+#endif /* ifdef CONFIG_SOC_IMX35 */
 
 #ifdef CONFIG_ARCH_MX51
 const struct imx_imx_ssi_data imx51_imx_ssi_data[] __initconst = {
diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/arm/plat-mxc/devices/platform-imx-uart.c
index b10c736..08bbd65 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
@@ -72,7 +72,7 @@ const struct imx_imx_uart_1irq_data imx27_imx_uart_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
-#ifdef CONFIG_ARCH_MX31
+#ifdef CONFIG_SOC_IMX31
 const struct imx_imx_uart_1irq_data imx31_imx_uart_data[] __initconst = {
 #define imx31_imx_uart_data_entry(_id, _hwid)				\
 	imx_imx_uart_1irq_data_entry(MX31, _id, _hwid, SZ_4K)
@@ -82,9 +82,9 @@ const struct imx_imx_uart_1irq_data imx31_imx_uart_data[] __initconst = {
 	imx31_imx_uart_data_entry(3, 4),
 	imx31_imx_uart_data_entry(4, 5),
 };
-#endif /* ifdef CONFIG_ARCH_MX31 */
+#endif /* ifdef CONFIG_SOC_IMX31 */
 
-#ifdef CONFIG_ARCH_MX35
+#ifdef CONFIG_SOC_IMX35
 const struct imx_imx_uart_1irq_data imx35_imx_uart_data[] __initconst = {
 #define imx35_imx_uart_data_entry(_id, _hwid)				\
 	imx_imx_uart_1irq_data_entry(MX31, _id, _hwid, SZ_16K)
@@ -92,7 +92,7 @@ const struct imx_imx_uart_1irq_data imx35_imx_uart_data[] __initconst = {
 	imx35_imx_uart_data_entry(1, 2),
 	imx35_imx_uart_data_entry(2, 3),
 };
-#endif /* ifdef CONFIG_ARCH_MX35 */
+#endif /* ifdef CONFIG_SOC_IMX35 */
 
 #ifdef CONFIG_ARCH_MX51
 const struct imx_imx_uart_1irq_data imx51_imx_uart_data[] __initconst = {
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_nand.c b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
index 967d847..f5beac0 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_nand.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_nand.c
@@ -41,12 +41,12 @@ const struct imx_mxc_nand_data imx27_mxc_nand_data __initconst =
 	imx_mxc_nand_data_entry_single(MX27, SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
-#ifdef CONFIG_ARCH_MX31
+#ifdef CONFIG_SOC_IMX31
 const struct imx_mxc_nand_data imx31_mxc_nand_data __initconst =
 	imx_mxc_nand_data_entry_single(MX31, SZ_4K);
 #endif
 
-#ifdef CONFIG_ARCH_MX35
+#ifdef CONFIG_SOC_IMX35
 const struct imx_mxc_nand_data imx35_mxc_nand_data __initconst =
 	imx_mxc_nand_data_entry_single(MX35, SZ_8K);
 #endif
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_w1.c b/arch/arm/plat-mxc/devices/platform-mxc_w1.c
index 1355237..96fa5ea 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc_w1.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc_w1.c
@@ -24,15 +24,15 @@ const struct imx_mxc_w1_data imx27_mxc_w1_data __initconst =
 	imx_mxc_w1_data_entry_single(MX27);
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
-#ifdef CONFIG_ARCH_MX31
+#ifdef CONFIG_SOC_IMX31
 const struct imx_mxc_w1_data imx31_mxc_w1_data __initconst =
 	imx_mxc_w1_data_entry_single(MX31);
-#endif /* ifdef CONFIG_ARCH_MX31 */
+#endif /* ifdef CONFIG_SOC_IMX31 */
 
-#ifdef CONFIG_ARCH_MX35
+#ifdef CONFIG_SOC_IMX35
 const struct imx_mxc_w1_data imx35_mxc_w1_data __initconst =
 	imx_mxc_w1_data_entry_single(MX35);
-#endif /* ifdef CONFIG_ARCH_MX35 */
+#endif /* ifdef CONFIG_SOC_IMX35 */
 
 struct platform_device *__init imx_add_mxc_w1(
 		const struct imx_mxc_w1_data *data)
diff --git a/arch/arm/plat-mxc/devices/platform-spi_imx.c b/arch/arm/plat-mxc/devices/platform-spi_imx.c
index bf2cb47..8f2b60a 100644
--- a/arch/arm/plat-mxc/devices/platform-spi_imx.c
+++ b/arch/arm/plat-mxc/devices/platform-spi_imx.c
@@ -49,7 +49,7 @@ const struct imx_spi_imx_data imx27_cspi_data[] __initconst = {
 };
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
-#ifdef CONFIG_ARCH_MX31
+#ifdef CONFIG_SOC_IMX31
 const struct imx_spi_imx_data imx31_cspi_data[] __initconst = {
 #define imx31_cspi_data_entry(_id, _hwid)				\
 	imx_spi_imx_data_entry(MX31, CSPI, "imx31-cspi", _id, _hwid, SZ_4K)
@@ -57,16 +57,16 @@ const struct imx_spi_imx_data imx31_cspi_data[] __initconst = {
 	imx31_cspi_data_entry(1, 2),
 	imx31_cspi_data_entry(2, 3),
 };
-#endif /* ifdef CONFIG_ARCH_MX31 */
+#endif /* ifdef CONFIG_SOC_IMX31 */
 
-#ifdef CONFIG_ARCH_MX35
+#ifdef CONFIG_SOC_IMX35
 const struct imx_spi_imx_data imx35_cspi_data[] __initconst = {
 #define imx35_cspi_data_entry(_id, _hwid)                           \
 	imx_spi_imx_data_entry(MX35, CSPI, "imx35-cspi", _id, _hwid, SZ_4K)
 	imx35_cspi_data_entry(0, 1),
 	imx35_cspi_data_entry(1, 2),
 };
-#endif /* ifdef CONFIG_ARCH_MX35 */
+#endif /* ifdef CONFIG_SOC_IMX35 */
 
 #ifdef CONFIG_ARCH_MX51
 const struct imx_spi_imx_data imx51_cspi_data __initconst =
diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 2fb1efa..93a8d93 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -421,7 +421,7 @@ DEFINE_REGISTER_FUNCTION(imx27)
 
 #endif /* if defined(CONFIG_SOC_IMX27) */
 
-#if defined(CONFIG_ARCH_MX31)
+#if defined(CONFIG_SOC_IMX31)
 static struct mxc_gpio_port imx31_gpio_ports[] = {
 	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 0, 1, MX31_INT_GPIO1),
 	DEFINE_IMX_GPIO_PORT_IRQ(MX31, 1, 2, MX31_INT_GPIO2),
@@ -430,9 +430,9 @@ static struct mxc_gpio_port imx31_gpio_ports[] = {
 
 DEFINE_REGISTER_FUNCTION(imx31)
 
-#endif /* if defined(CONFIG_ARCH_MX31) */
+#endif /* if defined(CONFIG_SOC_IMX31) */
 
-#if defined(CONFIG_ARCH_MX35)
+#if defined(CONFIG_SOC_IMX35)
 static struct mxc_gpio_port imx35_gpio_ports[] = {
 	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 0, 1, MX35_INT_GPIO1),
 	DEFINE_IMX_GPIO_PORT_IRQ(MX35, 1, 2, MX35_INT_GPIO2),
@@ -441,4 +441,4 @@ static struct mxc_gpio_port imx35_gpio_ports[] = {
 
 DEFINE_REGISTER_FUNCTION(imx35)
 
-#endif /* if defined(CONFIG_ARCH_MX35) */
+#endif /* if defined(CONFIG_SOC_IMX35) */
-- 
1.7.2.3
