From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Jun 2012 13:59:38 +0800
Subject: [PATCH 07/16] dma: ipu: remove the use of ipu_platform_data
In-Reply-To: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1339653587-4832-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The struct ipu_platform_data is used by platform code to pass
MXC_IPU_IRQ_START to ipu-core driver.  We can save it by having
ipu-core driver call irq_alloc_descs to get the irq_base.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Vinod Koul <vinod.koul@intel.com>
---
 arch/arm/mach-imx/devices-imx31.h               |    4 ++--
 arch/arm/mach-imx/devices-imx35.h               |    4 ++--
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c  |    6 +-----
 arch/arm/mach-imx/mach-armadillo5x0.c           |    6 +-----
 arch/arm/mach-imx/mach-mx31_3ds.c               |    6 +-----
 arch/arm/mach-imx/mach-mx31moboard.c            |    6 +-----
 arch/arm/mach-imx/mach-mx35_3ds.c               |   10 +---------
 arch/arm/mach-imx/mach-pcm037.c                 |    6 +-----
 arch/arm/mach-imx/mach-pcm043.c                 |    6 +-----
 arch/arm/mach-imx/mach-vpr200.c                 |    6 +-----
 arch/arm/mach-imx/mx31lilly-db.c                |    6 +-----
 arch/arm/plat-mxc/devices/platform-ipu-core.c   |    5 ++---
 arch/arm/plat-mxc/include/mach/devices-common.h |    4 +---
 arch/arm/plat-mxc/include/mach/ipu.h            |    4 ----
 drivers/dma/ipu/ipu_idmac.c                     |    8 +++-----
 drivers/dma/ipu/ipu_irq.c                       |   14 +++++++++-----
 16 files changed, 28 insertions(+), 73 deletions(-)

diff --git a/arch/arm/mach-imx/devices-imx31.h b/arch/arm/mach-imx/devices-imx31.h
index 488e241..911c2da 100644
--- a/arch/arm/mach-imx/devices-imx31.h
+++ b/arch/arm/mach-imx/devices-imx31.h
@@ -42,8 +42,8 @@ extern const struct imx_imx_uart_1irq_data imx31_imx_uart_data[];
 #define imx31_add_imx_uart4(pdata)	imx31_add_imx_uart(4, pdata)
 
 extern const struct imx_ipu_core_data imx31_ipu_core_data;
-#define imx31_add_ipu_core(pdata)	\
-	imx_add_ipu_core(&imx31_ipu_core_data, pdata)
+#define imx31_add_ipu_core()		\
+	imx_add_ipu_core(&imx31_ipu_core_data)
 #define imx31_alloc_mx3_camera(pdata)	\
 	imx_alloc_mx3_camera(&imx31_ipu_core_data, pdata)
 #define imx31_add_mx3_sdc_fb(pdata)	\
diff --git a/arch/arm/mach-imx/devices-imx35.h b/arch/arm/mach-imx/devices-imx35.h
index 7b99ef0..6fb9072 100644
--- a/arch/arm/mach-imx/devices-imx35.h
+++ b/arch/arm/mach-imx/devices-imx35.h
@@ -50,8 +50,8 @@ extern const struct imx_imx_uart_1irq_data imx35_imx_uart_data[];
 #define imx35_add_imx_uart2(pdata)	imx35_add_imx_uart(2, pdata)
 
 extern const struct imx_ipu_core_data imx35_ipu_core_data;
-#define imx35_add_ipu_core(pdata)	\
-	imx_add_ipu_core(&imx35_ipu_core_data, pdata)
+#define imx35_add_ipu_core()		\
+	imx_add_ipu_core(&imx35_ipu_core_data)
 #define imx35_alloc_mx3_camera(pdata)	\
 	imx_alloc_mx3_camera(&imx35_ipu_core_data, pdata)
 #define imx35_add_mx3_sdc_fb(pdata)	\
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
index 557f6c4..6e9dd12 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
@@ -95,10 +95,6 @@ static const struct fb_videomode fb_modedb[] = {
 	},
 };
 
-static const struct ipu_platform_data mx3_ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.name		= "CMO-QVGA",
 	.mode		= fb_modedb,
@@ -287,7 +283,7 @@ void __init eukrea_mbimxsd35_baseboard_init(void)
 		printk(KERN_ERR "error setting mbimxsd pads !\n");
 
 	imx35_add_imx_uart1(&uart_pdata);
-	imx35_add_ipu_core(&mx3_ipu_data);
+	imx35_add_ipu_core();
 	imx35_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	imx35_add_imx_ssi(0, &eukrea_mbimxsd_ssi_pdata);
diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index f83c5c6..2c6ab32 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -367,10 +367,6 @@ static const struct fb_videomode fb_modedb[] = {
 	},
 };
 
-static const struct ipu_platform_data mx3_ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.name		= "CRT-VGA",
 	.mode		= fb_modedb,
@@ -517,7 +513,7 @@ static void __init armadillo5x0_init(void)
 	imx31_add_mxc_mmc(0, &sdhc_pdata);
 
 	/* Register FB */
-	imx31_add_ipu_core(&mx3_ipu_data);
+	imx31_add_ipu_core();
 	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	/* Register NOR Flash */
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index ecdba04..618935e 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -274,10 +274,6 @@ static const struct fb_videomode fb_modedb[] = {
 	},
 };
 
-static struct ipu_platform_data mx3_ipu_data = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.name		= "Epson-VGA",
 	.mode		= fb_modedb,
@@ -743,7 +739,7 @@ static void __init mx31_3ds_init(void)
 	imx31_add_mxc_mmc(0, &sdhc1_pdata);
 
 	imx31_add_spi_imx0(&spi0_pdata);
-	imx31_add_ipu_core(&mx3_ipu_data);
+	imx31_add_ipu_core();
 	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	/* CSI */
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index f0d26db..54d9e5d 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -473,10 +473,6 @@ static const struct gpio_led_platform_data mx31moboard_led_pdata __initconst = {
 	.leds		= mx31moboard_leds,
 };
 
-static const struct ipu_platform_data mx3_ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static struct platform_device *devices[] __initdata = {
 	&mx31moboard_flash,
 };
@@ -494,7 +490,7 @@ static int __init mx31moboard_init_cam(void)
 	int dma, ret = -ENOMEM;
 	struct platform_device *pdev;
 
-	imx31_add_ipu_core(&mx3_ipu_data);
+	imx31_add_ipu_core();
 
 	pdev = imx31_alloc_mx3_camera(&camera_pdata);
 	if (IS_ERR(pdev))
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index fa1ea74..ad63e6e 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -80,10 +80,6 @@ static const struct fb_videomode fb_modedb[] = {
 	 },
 };
 
-static const struct ipu_platform_data mx3_ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.name = "Ceramate-CLAA070VC01",
 	.mode = fb_modedb,
@@ -297,10 +293,6 @@ err:
 	return ret;
 }
 
-static const struct ipu_platform_data mx35_3ds_ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static struct i2c_board_info mx35_3ds_i2c_camera = {
 	I2C_BOARD_INFO("ov2640", 0x30),
 };
@@ -596,7 +588,7 @@ static void __init mx35_3ds_init(void)
 	i2c_register_board_info(
 		0, i2c_devices_3ds, ARRAY_SIZE(i2c_devices_3ds));
 
-	imx35_add_ipu_core(&mx35_3ds_ipu_data);
+	imx35_add_ipu_core();
 	platform_device_register(&mx35_3ds_ov2640);
 	imx35_3ds_init_camera();
 
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index 551a035..ded4ed9 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -441,10 +441,6 @@ static struct platform_device *devices[] __initdata = {
 	&pcm037_mt9v022,
 };
 
-static const struct ipu_platform_data mx3_ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static const struct fb_videomode fb_modedb[] = {
 	{
 		/* 240x320 @ 60 Hz Sharp */
@@ -648,7 +644,7 @@ static void __init pcm037_init(void)
 
 	imx31_add_mxc_nand(&pcm037_nand_board_info);
 	imx31_add_mxc_mmc(0, &sdhc_pdata);
-	imx31_add_ipu_core(&mx3_ipu_data);
+	imx31_add_ipu_core();
 	imx31_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	/* CSI */
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index 73585f5..133908f 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -76,10 +76,6 @@ static const struct fb_videomode fb_modedb[] = {
 	},
 };
 
-static const struct ipu_platform_data mx3_ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.name		= "Sharp-LQ035Q7",
 	.mode		= fb_modedb,
@@ -376,7 +372,7 @@ static void __init pcm043_init(void)
 
 	imx35_add_imx_i2c0(&pcm043_i2c0_data);
 
-	imx35_add_ipu_core(&mx3_ipu_data);
+	imx35_add_ipu_core();
 	imx35_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	if (otg_mode_host) {
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index e36eb2c..1aa5622 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -87,10 +87,6 @@ static const struct fb_videomode fb_modedb[] = {
 	}
 };
 
-static const struct ipu_platform_data mx3_ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.name		= "PT0708048",
 	.mode		= fb_modedb,
@@ -290,7 +286,7 @@ static void __init vpr200_board_init(void)
 	imx35_add_imx_uart0(NULL);
 	imx35_add_imx_uart2(NULL);
 
-	imx35_add_ipu_core(&mx3_ipu_data);
+	imx35_add_ipu_core();
 	imx35_add_mx3_sdc_fb(&mx3fb_pdata);
 
 	imx35_add_fsl_usb2_udc(&otg_device_pdata);
diff --git a/arch/arm/mach-imx/mx31lilly-db.c b/arch/arm/mach-imx/mx31lilly-db.c
index 2df625b..29e890f 100644
--- a/arch/arm/mach-imx/mx31lilly-db.c
+++ b/arch/arm/mach-imx/mx31lilly-db.c
@@ -162,10 +162,6 @@ static const struct imxmmc_platform_data mmc_pdata __initconst = {
 };
 
 /* Framebuffer support */
-static const struct ipu_platform_data ipu_data __initconst = {
-	.irq_base = MXC_IPU_IRQ_START,
-};
-
 static const struct fb_videomode fb_modedb = {
 	/* 640x480 TFT panel (IPS-056T) */
 	.name		= "CRT-VGA",
@@ -199,7 +195,7 @@ static void __init mx31lilly_init_fb(void)
 		return;
 	}
 
-	imx31_add_ipu_core(&ipu_data);
+	imx31_add_ipu_core();
 	imx31_add_mx3_sdc_fb(&fb_pdata);
 	gpio_direction_output(LCD_VCC_EN_GPIO, 1);
 }
diff --git a/arch/arm/plat-mxc/devices/platform-ipu-core.c b/arch/arm/plat-mxc/devices/platform-ipu-core.c
index 79d340a..d1e33cc 100644
--- a/arch/arm/plat-mxc/devices/platform-ipu-core.c
+++ b/arch/arm/plat-mxc/devices/platform-ipu-core.c
@@ -30,8 +30,7 @@ const struct imx_ipu_core_data imx35_ipu_core_data __initconst =
 static struct platform_device *imx_ipu_coredev __initdata;
 
 struct platform_device *__init imx_add_ipu_core(
-		const struct imx_ipu_core_data *data,
-		const struct ipu_platform_data *pdata)
+		const struct imx_ipu_core_data *data)
 {
 	/* The resource order is important! */
 	struct resource res[] = {
@@ -55,7 +54,7 @@ struct platform_device *__init imx_add_ipu_core(
 	};
 
 	return imx_ipu_coredev = imx_add_platform_device("ipu-core", -1,
-			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+			res, ARRAY_SIZE(res), NULL, 0);
 }
 
 struct platform_device *__init imx_alloc_mx3_camera(
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 1b2258d..a7f5bb1 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -183,7 +183,6 @@ struct platform_device *__init imx_add_imx_udc(
 		const struct imx_imx_udc_data *data,
 		const struct imxusb_platform_data *pdata);
 
-#include <mach/ipu.h>
 #include <mach/mx3fb.h>
 #include <mach/mx3_camera.h>
 struct imx_ipu_core_data {
@@ -192,8 +191,7 @@ struct imx_ipu_core_data {
 	resource_size_t errirq;
 };
 struct platform_device *__init imx_add_ipu_core(
-		const struct imx_ipu_core_data *data,
-		const struct ipu_platform_data *pdata);
+		const struct imx_ipu_core_data *data);
 struct platform_device *__init imx_alloc_mx3_camera(
 		const struct imx_ipu_core_data *data,
 		const struct mx3_camera_pdata *pdata);
diff --git a/arch/arm/plat-mxc/include/mach/ipu.h b/arch/arm/plat-mxc/include/mach/ipu.h
index a9221f1..539e559 100644
--- a/arch/arm/plat-mxc/include/mach/ipu.h
+++ b/arch/arm/plat-mxc/include/mach/ipu.h
@@ -110,10 +110,6 @@ enum ipu_rotate_mode {
 	IPU_ROTATE_90_LEFT = 7,
 };
 
-struct ipu_platform_data {
-	unsigned int	irq_base;
-};
-
 /*
  * Enumeration of DI ports for ADC.
  */
diff --git a/drivers/dma/ipu/ipu_idmac.c b/drivers/dma/ipu/ipu_idmac.c
index 5ec7204..c7573e5 100644
--- a/drivers/dma/ipu/ipu_idmac.c
+++ b/drivers/dma/ipu/ipu_idmac.c
@@ -1663,7 +1663,6 @@ static void __exit ipu_idmac_exit(struct ipu *ipu)
 
 static int __init ipu_probe(struct platform_device *pdev)
 {
-	struct ipu_platform_data *pdata = pdev->dev.platform_data;
 	struct resource *mem_ipu, *mem_ic;
 	int ret;
 
@@ -1671,7 +1670,7 @@ static int __init ipu_probe(struct platform_device *pdev)
 
 	mem_ipu	= platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mem_ic	= platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!pdata || !mem_ipu || !mem_ic)
+	if (!mem_ipu || !mem_ic)
 		return -EINVAL;
 
 	ipu_data.dev = &pdev->dev;
@@ -1688,10 +1687,9 @@ static int __init ipu_probe(struct platform_device *pdev)
 		goto err_noirq;
 
 	ipu_data.irq_err = ret;
-	ipu_data.irq_base = pdata->irq_base;
 
-	dev_dbg(&pdev->dev, "fn irq %u, err irq %u, irq-base %u\n",
-		ipu_data.irq_fn, ipu_data.irq_err, ipu_data.irq_base);
+	dev_dbg(&pdev->dev, "fn irq %u, err irq %u\n",
+		ipu_data.irq_fn, ipu_data.irq_err);
 
 	/* Remap IPU common registers */
 	ipu_data.reg_ipu = ioremap(mem_ipu->start, resource_size(mem_ipu));
diff --git a/drivers/dma/ipu/ipu_irq.c b/drivers/dma/ipu/ipu_irq.c
index a71f55e..fa95bcc 100644
--- a/drivers/dma/ipu/ipu_irq.c
+++ b/drivers/dma/ipu/ipu_irq.c
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/module.h>
 
 #include <mach/ipu.h>
 
@@ -354,10 +355,12 @@ static struct irq_chip ipu_irq_chip = {
 /* Install the IRQ handler */
 int __init ipu_irq_attach_irq(struct ipu *ipu, struct platform_device *dev)
 {
-	struct ipu_platform_data *pdata = dev->dev.platform_data;
-	unsigned int irq, irq_base, i;
+	unsigned int irq, i;
+	int irq_base = irq_alloc_descs(-1, 0, CONFIG_MX3_IPU_IRQS,
+				       numa_node_id());
 
-	irq_base = pdata->irq_base;
+	if (irq_base < 0)
+		return irq_base;
 
 	for (i = 0; i < IPU_IRQ_NR_BANKS; i++)
 		irq_bank[i].ipu = ipu;
@@ -387,15 +390,16 @@ int __init ipu_irq_attach_irq(struct ipu *ipu, struct platform_device *dev)
 	irq_set_handler_data(ipu->irq_err, ipu);
 	irq_set_chained_handler(ipu->irq_err, ipu_irq_err);
 
+	ipu->irq_base = irq_base;
+
 	return 0;
 }
 
 void ipu_irq_detach_irq(struct ipu *ipu, struct platform_device *dev)
 {
-	struct ipu_platform_data *pdata = dev->dev.platform_data;
 	unsigned int irq, irq_base;
 
-	irq_base = pdata->irq_base;
+	irq_base = ipu->irq_base;
 
 	irq_set_chained_handler(ipu->irq_fn, NULL);
 	irq_set_handler_data(ipu->irq_fn, NULL);
-- 
1.7.5.4
