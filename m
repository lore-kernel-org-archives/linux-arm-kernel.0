From: jason.chen@freescale.com (jason.chen at freescale.com)
Date: Tue, 15 Feb 2011 16:56:13 +0800
Subject: [PATCH 1/3] IPUv3: Add i.MX53 IPU support
Message-ID: <1297760175-19211-1-git-send-email-jason.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jason Chen <b02280@freescale.com>

Signed-off-by: Jason Chen <b02280@freescale.com>
---
 arch/arm/mach-mx5/board-mx51_babbage.c          |    2 +-
 arch/arm/mach-mx5/devices-imx51.h               |    3 -
 arch/arm/plat-mxc/devices/platform-imx_ipuv3.c  |   97 +++++++++++++++++++++--
 arch/arm/plat-mxc/include/mach/devices-common.h |    4 +-
 arch/arm/plat-mxc/include/mach/ipu-v3.h         |    1 +
 drivers/mfd/Kconfig                             |    6 +-
 drivers/mfd/imx-ipu-v3/ipu-common.c             |   66 +++------------
 drivers/mfd/imx-ipu-v3/ipu-prv.h                |   32 ++++----
 8 files changed, 126 insertions(+), 85 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index ff951f8..176b9bc 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -457,7 +457,7 @@ static void __init mxc_board_init(void)
 	gpio_request(GPIO_DVI_I2C, "dvi i2c");
 	gpio_direction_output(GPIO_DVI_I2C, 0);
 
-	imx51_add_ipuv3(&ipu_data);
+	imx_add_ipuv3(&ipu_data);
 }
 
 static void __init mx51_babbage_timer_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 1bd73b3..065ac87 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -56,6 +56,3 @@ extern const struct imx_imx_keypad_data imx51_imx_keypad_data __initconst;
 #define imx51_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx51_imx_keypad_data, pdata)
 
-extern const struct imx_ipuv3_data imx51_ipuv3_data __initconst;
-#define imx51_add_ipuv3(pdata)	\
-	imx_add_ipuv3(&imx51_ipuv3_data, pdata)
diff --git a/arch/arm/plat-mxc/devices/platform-imx_ipuv3.c b/arch/arm/plat-mxc/devices/platform-imx_ipuv3.c
index 2c6b913..c867f97 100644
--- a/arch/arm/plat-mxc/devices/platform-imx_ipuv3.c
+++ b/arch/arm/plat-mxc/devices/platform-imx_ipuv3.c
@@ -8,27 +8,93 @@
  */
 #include <mach/hardware.h>
 #include <mach/devices-common.h>
+#include <linux/clk.h>
 
-#define imx51_ipuv3_data_entry_single(soc)				\
+#define imx5_ipuv3_data_entry_single(soc)				\
 	{								\
 		.iobase = soc ## _IPU_CTRL_BASE_ADDR,			\
 		.irq_err = soc ## _INT_IPU_ERR,				\
 		.irq = soc ## _INT_IPU_SYN,				\
 	}
 
-#ifdef CONFIG_SOC_IMX51
-const struct imx_ipuv3_data imx51_ipuv3_data __initconst =
-	imx51_ipuv3_data_entry_single(MX51);
-#endif /* ifdef CONFIG_SOC_IMX35 */
+struct imx_ipuv3_data __initdata imx51_ipuv3_data =
+		imx5_ipuv3_data_entry_single(MX51);
+struct imx_ipuv3_data __initdata imx53_ipuv3_data =
+		imx5_ipuv3_data_entry_single(MX53);
 
-struct platform_device *__init imx_add_ipuv3(
+/*
+ * The MIPI HSC unit has been removed from the i.MX51 Reference Manual by
+ * the Freescale marketing division. However this did not remove the
+ * hardware from the chip which still needs to be configured...
+ */
+static int __init ipu_mipi_setup(void)
+{
+	struct clk *hsc_clk;
+	void __iomem *hsc_addr;
+	int ret = 0;
+
+	hsc_addr = ioremap(MX51_MIPI_HSC_BASE_ADDR, PAGE_SIZE);
+	if (!hsc_addr)
+		return -ENOMEM;
+
+	hsc_clk = clk_get_sys(NULL, "mipi_hsp");
+	if (IS_ERR(hsc_clk)) {
+		ret = PTR_ERR(hsc_clk);
+		goto unmap;
+	}
+	clk_enable(hsc_clk);
+
+	/* setup MIPI module to legacy mode */
+	__raw_writel(0xF00, hsc_addr);
+
+	/* CSI mode: reserved; DI control mode: legacy (from Freescale BSP) */
+	__raw_writel(__raw_readl(hsc_addr + 0x800) | 0x30ff,
+		hsc_addr + 0x800);
+
+	clk_disable(hsc_clk);
+	clk_put(hsc_clk);
+unmap:
+	iounmap(hsc_addr);
+
+	return ret;
+}
+
+int __init mx51_ipuv3_init(void)
+{
+	int ret = 0;
+	u32 val;
+
+	ret = ipu_mipi_setup();
+
+	/* hard reset the IPU */
+	val = readl(MX51_IO_ADDRESS(MX51_SRC_BASE_ADDR));
+	val |= 1 << 3;
+	writel(val, MX51_IO_ADDRESS(MX51_SRC_BASE_ADDR));
+
+	return ret;
+}
+
+int __init mx53_ipuv3_init(void)
+{
+	int ret = 0;
+	u32 val;
+
+	/* hard reset the IPU */
+	val = readl(MX53_IO_ADDRESS(MX53_SRC_BASE_ADDR));
+	val |= 1 << 3;
+	writel(val, MX53_IO_ADDRESS(MX53_SRC_BASE_ADDR));
+
+	return ret;
+}
+
+struct platform_device *__init _imx_add_ipuv3(
 		const struct imx_ipuv3_data *data,
 		const struct imx_ipuv3_platform_data *pdata)
 {
 	struct resource res[] = {
 		{
 			.start = data->iobase,
-			.end = data->iobase + SZ_512M - 1,
+			.end = data->iobase + data->iosize - 1,
 			.flags = IORESOURCE_MEM,
 		}, {
 			.start = data->irq_err,
@@ -45,3 +111,20 @@ struct platform_device *__init imx_add_ipuv3(
 			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
 }
 
+struct platform_device *__init imx_add_ipuv3(
+		struct imx_ipuv3_platform_data *pdata)
+{
+	if (cpu_is_mx51()) {
+		imx51_ipuv3_data.iosize = SZ_512M;
+		pdata->init = mx51_ipuv3_init;
+		return _imx_add_ipuv3(&imx51_ipuv3_data, pdata);
+	} else if (cpu_is_mx53()) {
+		/* fix offset */
+		imx53_ipuv3_data.iobase -= 0x18000000;
+		imx51_ipuv3_data.iosize = SZ_128M;
+		pdata->init = mx53_ipuv3_init;
+		return _imx_add_ipuv3(&imx53_ipuv3_data, pdata);
+	} else
+		return ERR_PTR(-EINVAL);
+}
+
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 8f5197f..d9824a2 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -268,9 +268,9 @@ struct platform_device *__init imx_add_spi_imx(
 #include <mach/ipu-v3.h>
 struct imx_ipuv3_data {
 	resource_size_t iobase;
+	resource_size_t iosize;
 	resource_size_t irq_err;
 	resource_size_t irq;
 };
 struct platform_device *__init imx_add_ipuv3(
-		const struct imx_ipuv3_data *data,
-		const struct imx_ipuv3_platform_data *pdata);
+		struct imx_ipuv3_platform_data *pdata);
diff --git a/arch/arm/plat-mxc/include/mach/ipu-v3.h b/arch/arm/plat-mxc/include/mach/ipu-v3.h
index f8900b9..1a4a271 100644
--- a/arch/arm/plat-mxc/include/mach/ipu-v3.h
+++ b/arch/arm/plat-mxc/include/mach/ipu-v3.h
@@ -42,6 +42,7 @@ struct ipuv3_fb_platform_data {
 
 struct imx_ipuv3_platform_data {
 	int rev;
+	int (*init) (void);
 	struct ipuv3_fb_platform_data	*fb_head0_platform_data;
 	struct ipuv3_fb_platform_data	*fb_head1_platform_data;
 };
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index d1aa701..0d218cd 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -625,11 +625,11 @@ config MFD_WL1273_CORE
 	  audio codec.
 
 config MFD_IMX_IPU_V3
-	tristate "Support the Image Processing Unit (IPU) found on the i.MX51"
-	depends on ARCH_MX51
+	tristate "Support the Image Processing Unit (IPUv3) found on the i.MX5X"
+	depends on ARCH_MX51 || ARCH_MX53
 	select MFD_CORE
 	help
-	  Say yes here to support the IPU on i.MX51.
+	  Say yes here to support the IPUv3 on i.MX5X.
 
 endif # MFD_SUPPORT
 
diff --git a/drivers/mfd/imx-ipu-v3/ipu-common.c b/drivers/mfd/imx-ipu-v3/ipu-common.c
index d96245f..3a026c0 100644
--- a/drivers/mfd/imx-ipu-v3/ipu-common.c
+++ b/drivers/mfd/imx-ipu-v3/ipu-common.c
@@ -345,15 +345,9 @@ ipu_color_space_t format_to_colorspace(u32 fmt)
 	}
 }
 
-static int ipu_reset(void)
+static int ipu_mem_reset(void)
 {
 	int timeout = 10000;
-	u32 val;
-
-	/* hard reset the IPU */
-	val = readl(MX51_IO_ADDRESS(MX51_SRC_BASE_ADDR));
-	val |= 1 << 3;
-	writel(val, MX51_IO_ADDRESS(MX51_SRC_BASE_ADDR));
 
 	ipu_cm_write(0x807FFFFF, IPU_MEM_RST);
 
@@ -366,43 +360,6 @@ static int ipu_reset(void)
 	return 0;
 }
 
-/*
- * The MIPI HSC unit has been removed from the i.MX51 Reference Manual by
- * the Freescale marketing division. However this did not remove the
- * hardware from the chip which still needs to be configured...
- */
-static int __devinit ipu_mipi_setup(void)
-{
-	struct clk *hsc_clk;
-	void __iomem *hsc_addr;
-	int ret = 0;
-
-	hsc_addr = ioremap(MX51_MIPI_HSC_BASE_ADDR, PAGE_SIZE);
-	if (!hsc_addr)
-		return -ENOMEM;
-
-	hsc_clk = clk_get_sys(NULL, "mipi_hsp");
-	if (IS_ERR(hsc_clk)) {
-		ret = PTR_ERR(hsc_clk);
-		goto unmap;
-	}
-	clk_enable(hsc_clk);
-
-	/* setup MIPI module to legacy mode */
-	__raw_writel(0xF00, hsc_addr);
-
-	/* CSI mode: reserved; DI control mode: legacy (from Freescale BSP) */
-	__raw_writel(__raw_readl(hsc_addr + 0x800) | 0x30ff,
-		hsc_addr + 0x800);
-
-	clk_disable(hsc_clk);
-	clk_put(hsc_clk);
-unmap:
-	iounmap(hsc_addr);
-
-	return ret;
-}
-
 static int ipu_submodules_init(struct platform_device *pdev,
 		unsigned long ipu_base, struct clk *ipu_clk)
 {
@@ -526,9 +483,9 @@ static int ipu_add_client_devices(struct platform_device *pdev)
 	fbdata = plat_data->fb_head0_platform_data;
 	if (fbdata) {
 		fbdata->ipu_channel_bg =
-			MX51_IPU_CHANNEL_MEM_BG_SYNC;
+			MX5_IPU_CHANNEL_MEM_BG_SYNC;
 		fbdata->ipu_channel_fg =
-			MX51_IPU_CHANNEL_MEM_FG_SYNC;
+			MX5_IPU_CHANNEL_MEM_FG_SYNC;
 		fbdata->dc_channel = 5;
 		fbdata->dp_channel = IPU_DP_FLOW_SYNC;
 
@@ -539,7 +496,7 @@ static int ipu_add_client_devices(struct platform_device *pdev)
 	fbdata = plat_data->fb_head1_platform_data;
 	if (fbdata) {
 		fbdata->ipu_channel_bg =
-			MX51_IPU_CHANNEL_MEM_DC_SYNC;
+			MX5_IPU_CHANNEL_MEM_DC_SYNC;
 		fbdata->ipu_channel_fg = -1;
 		fbdata->dc_channel = 1;
 		fbdata->dp_channel = -1;
@@ -554,6 +511,7 @@ static int ipu_add_client_devices(struct platform_device *pdev)
 static int __devinit ipu_probe(struct platform_device *pdev)
 {
 	struct resource *res;
+	struct imx_ipuv3_platform_data *plat_data = pdev->dev.platform_data;
 	unsigned long ipu_base;
 	int ret, irq1, irq2;
 
@@ -586,10 +544,6 @@ static int __devinit ipu_probe(struct platform_device *pdev)
 		goto failed_ioremap2;
 	}
 
-	ret = ipu_mipi_setup();
-	if (ret)
-		goto failed_mipi_setup;
-
 	ipu_clk = clk_get(&pdev->dev, "ipu");
 	if (IS_ERR(ipu_clk)) {
 		ret = PTR_ERR(ipu_clk);
@@ -613,7 +567,13 @@ static int __devinit ipu_probe(struct platform_device *pdev)
 		goto failed_request_irq2;
 	}
 
-	ipu_reset();
+	if (plat_data->init) {
+		ret = plat_data->init();
+		if (ret)
+			goto failed_plat_init;
+	}
+
+	ipu_mem_reset();
 
 	ret = ipu_submodules_init(pdev, ipu_base, ipu_clk);
 	if (ret)
@@ -634,6 +594,7 @@ static int __devinit ipu_probe(struct platform_device *pdev)
 
 failed_add_clients:
 	ipu_submodules_exit(pdev, ipu_base);
+failed_plat_init:
 failed_submodules_init:
 	free_irq(irq2, &pdev->dev);
 failed_request_irq2:
@@ -642,7 +603,6 @@ failed_request_irq2:
 failed_request_irq1:
 	clk_put(ipu_clk);
 failed_clk_get:
-failed_mipi_setup:
 	iounmap(ipu_idmac_reg);
 failed_ioremap2:
 	iounmap(ipu_cm_reg);
diff --git a/drivers/mfd/imx-ipu-v3/ipu-prv.h b/drivers/mfd/imx-ipu-v3/ipu-prv.h
index 339b554..8469337 100644
--- a/drivers/mfd/imx-ipu-v3/ipu-prv.h
+++ b/drivers/mfd/imx-ipu-v3/ipu-prv.h
@@ -21,22 +21,22 @@
 #include <linux/platform_device.h>
 #include <mach/hardware.h>
 
-#define MX51_IPU_CHANNEL_CSI0			 0
-#define MX51_IPU_CHANNEL_CSI1			 1
-#define MX51_IPU_CHANNEL_CSI2			 2
-#define MX51_IPU_CHANNEL_CSI3			 3
-#define MX51_IPU_CHANNEL_MEM_BG_SYNC		23
-#define MX51_IPU_CHANNEL_MEM_FG_SYNC		27
-#define MX51_IPU_CHANNEL_MEM_DC_SYNC		28
-#define MX51_IPU_CHANNEL_MEM_FG_SYNC_ALPHA	31
-#define MX51_IPU_CHANNEL_MEM_DC_ASYNC		41
-#define MX51_IPU_CHANNEL_ROT_ENC_MEM		45
-#define MX51_IPU_CHANNEL_ROT_VF_MEM		46
-#define MX51_IPU_CHANNEL_ROT_PP_MEM		47
-#define MX51_IPU_CHANNEL_ROT_ENC_MEM_OUT	48
-#define MX51_IPU_CHANNEL_ROT_VF_MEM_OUT		49
-#define MX51_IPU_CHANNEL_ROT_PP_MEM_OUT		50
-#define MX51_IPU_CHANNEL_MEM_BG_SYNC_ALPHA	51
+#define MX5_IPU_CHANNEL_CSI0			 0
+#define MX5_IPU_CHANNEL_CSI1			 1
+#define MX5_IPU_CHANNEL_CSI2			 2
+#define MX5_IPU_CHANNEL_CSI3			 3
+#define MX5_IPU_CHANNEL_MEM_BG_SYNC		23
+#define MX5_IPU_CHANNEL_MEM_FG_SYNC		27
+#define MX5_IPU_CHANNEL_MEM_DC_SYNC		28
+#define MX5_IPU_CHANNEL_MEM_FG_SYNC_ALPHA	31
+#define MX5_IPU_CHANNEL_MEM_DC_ASYNC		41
+#define MX5_IPU_CHANNEL_ROT_ENC_MEM		45
+#define MX5_IPU_CHANNEL_ROT_VF_MEM		46
+#define MX5_IPU_CHANNEL_ROT_PP_MEM		47
+#define MX5_IPU_CHANNEL_ROT_ENC_MEM_OUT	48
+#define MX5_IPU_CHANNEL_ROT_VF_MEM_OUT		49
+#define MX5_IPU_CHANNEL_ROT_PP_MEM_OUT		50
+#define MX5_IPU_CHANNEL_MEM_BG_SYNC_ALPHA	51
 
 #define IPU_DISP0_BASE		0x00000000
 #define IPU_MCU_T_DEFAULT	8
-- 
1.7.1
