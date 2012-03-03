From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat,  3 Mar 2012 23:19:45 +0800
Subject: [PATCH 04/20] ARM: imx: convert audmux to a platform driver
In-Reply-To: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330788001-10158-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <richard.zhao@linaro.org>

It coverts audmux to a platform driver, so that it can be moved into
sound/soc/imx and adopt device tree support later.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c   |    7 ++
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |    7 ++
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c |    7 ++
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c    |    7 ++
 arch/arm/mach-imx/mach-mx31ads.c               |    6 +
 arch/arm/mach-imx/mach-pca100.c                |    7 ++
 arch/arm/mach-imx/mach-pcm043.c                |    7 ++
 arch/arm/plat-mxc/audmux.c                     |  127 +++++++++++++++++-------
 8 files changed, 140 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 5f2f91d..11cd0a0 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -294,6 +294,10 @@ struct imx_ssi_platform_data eukrea_mbimx27_ssi_pdata __initconst = {
 	.flags = IMX_SSI_DMA | IMX_SSI_USE_I2S_SLAVE,
 };
 
+static const struct resource audmux_res[] __initconst = {
+	DEFINE_RES_MEM(MX27_AUDMUX_BASE_ADDR, SZ_4K),
+};
+
 /*
  * system init for baseboard usage. Will be called by cpuimx27 init.
  *
@@ -317,6 +321,9 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	i2c_register_board_info(0, eukrea_mbimx27_i2c_devices,
 				ARRAY_SIZE(eukrea_mbimx27_i2c_devices));
 
+	/* imx27 has the imx21 version audmux */
+	imx_add_platform_device("imx21-audmux", 0, audmux_res,
+				ARRAY_SIZE(audmux_res), NULL, 0);
 	imx27_add_imx_ssi(0, &eukrea_mbimx27_ssi_pdata);
 
 #if defined(CONFIG_TOUCHSCREEN_ADS7846) \
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index 2cf603e..2797da8 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -222,6 +222,10 @@ struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata __initconst = {
 	.flags = IMX_SSI_SYN | IMX_SSI_NET | IMX_SSI_USE_I2S_SLAVE,
 };
 
+static const struct resource audmux_res[] __initconst = {
+	DEFINE_RES_MEM(MX25_AUDMUX_BASE_ADDR, SZ_16K),
+};
+
 static struct esdhc_platform_data sd1_pdata = {
 	.cd_gpio = GPIO_SD1CD,
 	.cd_type = ESDHC_CD_GPIO,
@@ -242,6 +246,9 @@ void __init eukrea_mbimxsd25_baseboard_init(void)
 
 	imx25_add_imx_uart1(&uart_pdata);
 	imx25_add_imx_fb(&eukrea_mximxsd_fb_pdata);
+	/* imx25 has the imx31 version audmux */
+	imx_add_platform_device("imx31-audmux", 0, audmux_res,
+				ARRAY_SIZE(audmux_res), NULL, 0);
 	imx25_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
 
 	imx25_add_flexcan1(NULL);
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
index fd8bf8a..1878114 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
@@ -233,6 +233,10 @@ struct imx_ssi_platform_data eukrea_mbimxsd_ssi_pdata __initconst = {
 	.flags = IMX_SSI_SYN | IMX_SSI_NET | IMX_SSI_USE_I2S_SLAVE,
 };
 
+static const struct resource audmux_res[] __initconst = {
+	DEFINE_RES_MEM(MX35_AUDMUX_BASE_ADDR, SZ_16K),
+};
+
 static struct esdhc_platform_data sd1_pdata = {
 	.cd_gpio = GPIO_SD1CD,
 	.cd_type = ESDHC_CD_GPIO,
@@ -255,6 +259,9 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 	imx35_add_ipu_core(&mx3_ipu_data);
 	imx35_add_mx3_sdc_fb(&mx3fb_pdata);
 
+	/* imx35 has the imx31 version audmux */
+	imx_add_platform_device("imx31-audmux", 0, audmux_res,
+				ARRAY_SIZE(audmux_res), NULL, 0);
 	imx35_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
 
 	imx35_add_flexcan1(NULL);
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index c2766ae..8f03235 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -240,6 +240,10 @@ static const struct imx_ssi_platform_data visstrim_m10_ssi_pdata __initconst = {
 	.flags			= IMX_SSI_DMA | IMX_SSI_SYN,
 };
 
+static const struct resource audmux_res[] __initconst = {
+	DEFINE_RES_MEM(MX27_AUDMUX_BASE_ADDR, SZ_4K),
+};
+
 static void __init visstrim_m10_board_init(void)
 {
 	int ret;
@@ -251,6 +255,9 @@ static void __init visstrim_m10_board_init(void)
 	if (ret)
 		pr_err("Failed to setup pins (%d)\n", ret);
 
+	/* imx27 has the imx21 version audmux */
+	imx_add_platform_device("imx21-audmux", 0, audmux_res,
+				ARRAY_SIZE(audmux_res), NULL, 0);
 	imx27_add_imx_ssi(0, &visstrim_m10_ssi_pdata);
 	imx27_add_imx_uart0(&uart_pdata);
 
diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index 4917aab..f84bd46 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -486,8 +486,14 @@ static unsigned int ssi_pins[] = {
 	MX31_PIN_STXD5__STXD5,
 };
 
+static const struct resource audmux_res[] __initconst = {
+	DEFINE_RES_MEM(MX31_AUDMUX_BASE_ADDR, SZ_16K),
+};
+
 static void __init mxc_init_audio(void)
 {
+	imx_add_platform_device("imx31-audmux", 0, audmux_res,
+				ARRAY_SIZE(audmux_res), NULL, 0);
 	imx31_add_imx_ssi(0, NULL);
 	mxc_iomux_setup_multiple_pins(ssi_pins, ARRAY_SIZE(ssi_pins), "ssi");
 }
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 541152e..8a491b3 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -240,6 +240,10 @@ static const struct imx_ssi_platform_data pca100_ssi_pdata __initconst = {
 	.flags			= IMX_SSI_USE_AC97,
 };
 
+static const struct resource audmux_res[] __initconst = {
+	DEFINE_RES_MEM(MX27_AUDMUX_BASE_ADDR, SZ_4K),
+};
+
 static int pca100_sdhc2_init(struct device *dev, irq_handler_t detect_irq,
 		void *data)
 {
@@ -363,6 +367,9 @@ static void __init pca100_init(void)
 	if (ret)
 		printk(KERN_ERR "pca100: Failed to setup pins (%d)\n", ret);
 
+	/* imx27 has the imx21 version audmux */
+	imx_add_platform_device("imx21-audmux", 0, audmux_res,
+				ARRAY_SIZE(audmux_res), NULL, 0);
 	imx27_add_imx_ssi(0, &pca100_ssi_pdata);
 
 	imx27_add_imx_uart0(&uart_pdata);
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index 237474f..7d6a1e0 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -298,6 +298,10 @@ static const struct imx_ssi_platform_data pcm043_ssi_pdata __initconst = {
 	.flags = IMX_SSI_USE_AC97,
 };
 
+static const struct resource audmux_res[] __initconst = {
+	DEFINE_RES_MEM(MX35_AUDMUX_BASE_ADDR, SZ_16K),
+};
+
 static const struct mxc_nand_platform_data
 pcm037_nand_board_info __initconst = {
 	.width = 1,
@@ -367,6 +371,9 @@ static void __init pcm043_init(void)
 
 	imx35_add_imx_uart0(&uart_pdata);
 	imx35_add_mxc_nand(&pcm037_nand_board_info);
+	/* imx35 has the imx31 version audmux */
+	imx_add_platform_device("imx31-audmux", 0, audmux_res,
+				ARRAY_SIZE(audmux_res), NULL, 0);
 	imx35_add_imx_ssi(0, &pcm043_ssi_pdata);
 
 	imx35_add_imx_uart1(&uart_pdata);
diff --git a/arch/arm/plat-mxc/audmux.c b/arch/arm/plat-mxc/audmux.c
index f6dc536..98f5656 100644
--- a/arch/arm/plat-mxc/audmux.c
+++ b/arch/arm/plat-mxc/audmux.c
@@ -1,4 +1,6 @@
 /*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012 Linaro Ltd.
  * Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
  *
  * Initial development of this code was funded by
@@ -15,14 +17,16 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/module.h>
-#include <linux/err.h>
-#include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <mach/audmux.h>
-#include <mach/hardware.h>
+
+#define DRIVER_NAME "imx-audmux"
 
 static struct clk *audmux_clk;
 static void __iomem *audmux_base;
@@ -140,7 +144,7 @@ static const struct file_operations audmux_debugfs_fops = {
 	.llseek = default_llseek,
 };
 
-static void audmux_debugfs_init(void)
+static void __init audmux_debugfs_init(void)
 {
 	int i;
 	char buf[20];
@@ -159,18 +163,48 @@ static void audmux_debugfs_init(void)
 				   i);
 	}
 }
+
+static void __exit audmux_debugfs_remove(void)
+{
+	debugfs_remove_recursive(audmux_debugfs_root);
+}
 #else
 static inline void audmux_debugfs_init(void)
 {
 }
+
+static inline void audmux_debugfs_remove(void)
+{
+}
 #endif
 
+enum imx_audmux_type {
+	IMX21_AUDMUX,
+	IMX31_AUDMUX,
+} audmux_type;
+
+static struct platform_device_id imx_audmux_ids[] = {
+	{
+		.name = "imx21-audmux",
+		.driver_data = IMX21_AUDMUX,
+	}, {
+		.name = "imx31-audmux",
+		.driver_data = IMX31_AUDMUX,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(platform, imx_audmux_ids);
+
 static unsigned char port_mapping[] = {
 	0x0, 0x4, 0x8, 0x10, 0x14, 0x1c,
 };
 
 int mxc_audmux_v1_configure_port(unsigned int port, unsigned int pcr)
 {
+	if (audmux_type != IMX21_AUDMUX)
+		return -EINVAL;
+
 	if (!audmux_base)
 		return -ENOSYS;
 
@@ -186,6 +220,9 @@ EXPORT_SYMBOL_GPL(mxc_audmux_v1_configure_port);
 int mxc_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 		unsigned int pdcr)
 {
+	if (audmux_type != IMX31_AUDMUX)
+		return -EINVAL;
+
 	if (!audmux_base)
 		return -ENOSYS;
 
@@ -202,41 +239,61 @@ int mxc_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 }
 EXPORT_SYMBOL_GPL(mxc_audmux_v2_configure_port);
 
-static int mxc_audmux_init(void)
+static int __init imx_audmux_probe(struct platform_device *pdev)
 {
-	int ret;
-	if (cpu_is_mx51()) {
-		audmux_base = MX51_IO_ADDRESS(MX51_AUDMUX_BASE_ADDR);
-	} else if (cpu_is_mx31()) {
-		audmux_base = MX31_IO_ADDRESS(MX31_AUDMUX_BASE_ADDR);
-	} else if (cpu_is_mx35()) {
-		audmux_clk = clk_get(NULL, "audmux");
-		if (IS_ERR(audmux_clk)) {
-			ret = PTR_ERR(audmux_clk);
-			printk(KERN_ERR "%s: cannot get clock: %d\n", __func__,
-					ret);
-			return ret;
-		}
-		audmux_base = MX35_IO_ADDRESS(MX35_AUDMUX_BASE_ADDR);
-	} else if (cpu_is_mx25()) {
-		audmux_clk = clk_get(NULL, "audmux");
-		if (IS_ERR(audmux_clk)) {
-			ret = PTR_ERR(audmux_clk);
-			printk(KERN_ERR "%s: cannot get clock: %d\n", __func__,
-					ret);
-			return ret;
-		}
-		audmux_base = MX25_IO_ADDRESS(MX25_AUDMUX_BASE_ADDR);
-	} else if (cpu_is_mx27()) {
-		audmux_base = MX27_IO_ADDRESS(MX27_AUDMUX_BASE_ADDR);
-	} else if (cpu_is_mx21()) {
-		audmux_base = MX21_IO_ADDRESS(MX21_AUDMUX_BASE_ADDR);
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	audmux_base = devm_request_and_ioremap(&pdev->dev, res);
+	if (!audmux_base)
+		return -EADDRNOTAVAIL;
+
+	audmux_clk = clk_get(&pdev->dev, "audmux");
+	if (IS_ERR(audmux_clk)) {
+		dev_dbg(&pdev->dev, "cannot get clock: %ld\n",
+				PTR_ERR(audmux_clk));
+		audmux_clk = NULL;
 	}
 
-	if (!cpu_is_mx2())
+	audmux_type = pdev->id_entry->driver_data;
+	if (audmux_type == IMX31_AUDMUX)
 		audmux_debugfs_init();
 
 	return 0;
 }
 
-postcore_initcall(mxc_audmux_init);
+static int __exit imx_audmux_remove(struct platform_device *pdev)
+{
+	if (audmux_type == IMX31_AUDMUX)
+		audmux_debugfs_remove();
+	clk_put(audmux_clk);
+
+	return 0;
+}
+
+static struct platform_driver imx_audmux_driver = {
+	.probe		= imx_audmux_probe,
+	.remove		= __exit_p(imx_audmux_remove),
+	.id_table	= imx_audmux_ids,
+	.driver	= {
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
+	}
+};
+
+static int __init imx_audmux_init(void)
+{
+	return platform_driver_register(&imx_audmux_driver);
+}
+subsys_initcall(imx_audmux_init);
+
+static void __exit imx_audmux_exit(void)
+{
+	platform_driver_unregister(&imx_audmux_driver);
+}
+module_exit(imx_audmux_exit);
+
+MODULE_DESCRIPTION("Freescale i.MX AUDMUX driver");
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.7.5.4
