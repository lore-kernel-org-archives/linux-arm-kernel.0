From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 3 Mar 2011 16:40:03 +0800
Subject: [PATCH 2/2] ARM: imx3x: clean up ARCH_MX3X
In-Reply-To: <1299141603-22148-1-git-send-email-richard.zhao@freescale.com>
References: <1299141603-22148-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1299141603-22148-2-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move to SOC_SOC_IMX3X.
Leave ARCH_MX31/35 definitions there, in case some place prevent multi-soc
single image.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index e4509ba..2bd4ccf 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -811,7 +811,7 @@ config CACHE_FEROCEON_L2_WRITETHROUGH
 config CACHE_L2X0
 	bool "Enable the L2x0 outer cache controller"
 	depends on REALVIEW_EB_ARM11MP || MACH_REALVIEW_PB11MP || MACH_REALVIEW_PB1176 || \
-		   REALVIEW_EB_A9MP || ARCH_MX35 || ARCH_MX31 || MACH_REALVIEW_PBX || \
+		   REALVIEW_EB_A9MP || SOC_IMX35 || SOC_IMX31 || MACH_REALVIEW_PBX || \
 		   ARCH_NOMADIK || ARCH_OMAP4 || ARCH_S5PV310 || ARCH_TEGRA || \
 		   ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_SHMOBILE
 	default y
diff --git a/arch/arm/plat-mxc/devices/platform-imx-dma.c b/arch/arm/plat-mxc/devices/platform-imx-dma.c
index be7df13..3538b85 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-dma.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-dma.c
@@ -94,7 +94,7 @@ static struct sdma_script_start_addrs addr_imx25_to1 = {
 };
 #endif
 
-#ifdef CONFIG_ARCH_MX31
+#ifdef CONFIG_SOC_IMX31
 static struct sdma_script_start_addrs addr_imx31_to1 = {
 	.per_2_per_addr = 1677,
 };
@@ -106,7 +106,7 @@ static struct sdma_script_start_addrs addr_imx31_to2 = {
 };
 #endif
 
-#ifdef CONFIG_ARCH_MX35
+#ifdef CONFIG_SOC_IMX35
 static struct sdma_script_start_addrs addr_imx35_to1 = {
 	.ap_2_ap_addr = 642,
 	.uart_2_mcu_addr = 817,
diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index 3781f2f..7e07263 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -103,7 +103,7 @@ extern unsigned int __mxc_cpu_type;
 # define cpu_is_mx27()		(0)
 #endif
 
-#ifdef CONFIG_ARCH_MX31
+#ifdef CONFIG_SOC_IMX31
 # ifdef mxc_cpu_type
 #  undef mxc_cpu_type
 #  define mxc_cpu_type __mxc_cpu_type
@@ -115,7 +115,7 @@ extern unsigned int __mxc_cpu_type;
 # define cpu_is_mx31()		(0)
 #endif
 
-#ifdef CONFIG_ARCH_MX35
+#ifdef CONFIG_SOC_IMX35
 # ifdef mxc_cpu_type
 #  undef mxc_cpu_type
 #  define mxc_cpu_type __mxc_cpu_type
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 0382332..9928115 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1944,7 +1944,7 @@ config 68360_ENET
 config FEC
 	bool "FEC ethernet controller (of ColdFire and some i.MX CPUs)"
 	depends on M523x || M527x || M5272 || M528x || M520x || M532x || \
-		MACH_MX27 || ARCH_MX35 || ARCH_MX25 || ARCH_MX5 || SOC_IMX28
+		IMX_HAVE_PLATFORM_FEC || SOC_IMX28
 	select PHYLIB
 	help
 	  Say Y here if you want to use the built-in 10/100 Fast ethernet
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9f9d3f7..bd9dad5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -161,10 +161,10 @@ config SPI_IMX_VER_0_0
 	def_bool y if SOC_IMX21 || SOC_IMX27
 
 config SPI_IMX_VER_0_4
-	def_bool y if ARCH_MX31
+	def_bool y if SOC_MX31
 
 config SPI_IMX_VER_0_7
-	def_bool y if ARCH_MX25 || ARCH_MX35 || SOC_IMX51 || SOC_IMX53
+	def_bool y if ARCH_MX25 || SOC_IMX35 || SOC_IMX51 || SOC_IMX53
 
 config SPI_IMX_VER_2_3
 	def_bool y if SOC_IMX51 || SOC_IMX53
diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
index 77b1eb5..834fe94 100644
--- a/drivers/usb/gadget/fsl_mxc_udc.c
+++ b/drivers/usb/gadget/fsl_mxc_udc.c
@@ -88,7 +88,7 @@ eenahb:
 void fsl_udc_clk_finalize(struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
-#if defined(CONFIG_ARCH_MX35)
+#if defined(CONFIG_SOC_IMX35)
 	unsigned int v;
 
 	/* workaround ENGcm09152 for i.MX35 */
-- 
1.7.1
