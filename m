From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 29 Nov 2011 15:09:25 +0800
Subject: [PATCH] USB: ehci-mxc: get rid of the uses of cpu_is_mx()
Message-ID: <1322550565-29162-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch removes all the uses of cpu_is_mx().  Instead, it utilizes
platform_device_id to distinguish the ehci differences among SoCs.
It can be useful to imx ehci submission and device tree support later.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/mach-imx/clock-imx25.c                 |    6 +-
 arch/arm/mach-imx/clock-imx27.c                 |   12 +-
 arch/arm/mach-imx/clock-imx31.c                 |   12 +-
 arch/arm/mach-imx/clock-imx35.c                 |    6 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c             |   14 ++--
 arch/arm/plat-mxc/devices/platform-mxc-ehci.c   |   40 +++++---
 arch/arm/plat-mxc/include/mach/devices-common.h |    1 +
 drivers/usb/host/ehci-mxc.c                     |  118 ++++++++++++++++++++++-
 8 files changed, 166 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
index b0fec74..8288b6e 100644
--- a/arch/arm/mach-imx/clock-imx25.c
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -279,9 +279,9 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
 	_REGISTER_CLOCK("imx21-uart.3", NULL, uart4_clk)
 	_REGISTER_CLOCK("imx21-uart.4", NULL, uart5_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
+	_REGISTER_CLOCK("ehci-imx25.0", "usb", usbotg_clk)
+	_REGISTER_CLOCK("ehci-imx25.1", "usb", usbotg_clk)
+	_REGISTER_CLOCK("ehci-imx25.2", "usb", usbotg_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
 	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
 	/* i.mx25 has the i.mx35 type cspi */
diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index 88fe00a..fcbf0ec 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -648,12 +648,12 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mx2-camera.0", NULL, csi_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usb_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb", usb_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb_ahb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb", usb_clk)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb", usb_clk)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb_ahb", usb_clk1)
+	_REGISTER_CLOCK("ehci-imx27.0", "usb", usb_clk)
+	_REGISTER_CLOCK("ehci-imx27.0", "usb_ahb", usb_clk1)
+	_REGISTER_CLOCK("ehci-imx27.1", "usb", usb_clk)
+	_REGISTER_CLOCK("ehci-imx27.1", "usb_ahb", usb_clk1)
+	_REGISTER_CLOCK("ehci-imx27.2", "usb", usb_clk)
+	_REGISTER_CLOCK("ehci-imx27.2", "usb_ahb", usb_clk1)
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
 	_REGISTER_CLOCK("mxc_nand.0", NULL, nfc_clk)
diff --git a/arch/arm/mach-imx/clock-imx31.c b/arch/arm/mach-imx/clock-imx31.c
index 988a281..cae39b1 100644
--- a/arch/arm/mach-imx/clock-imx31.c
+++ b/arch/arm/mach-imx/clock-imx31.c
@@ -538,12 +538,12 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("ipu-core", NULL, ipu_clk)
 	_REGISTER_CLOCK("mx3_sdc_fb", NULL, ipu_clk)
 	_REGISTER_CLOCK(NULL, "kpp", kpp_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb_ahb", usb_clk2)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", usb_clk2)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb", usb_clk1)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb_ahb", usb_clk2)
+	_REGISTER_CLOCK("ehci-imx31.0", "usb", usb_clk1)
+	_REGISTER_CLOCK("ehci-imx31.0", "usb_ahb", usb_clk2)
+	_REGISTER_CLOCK("ehci-imx31.1", "usb", usb_clk1)
+	_REGISTER_CLOCK("ehci-imx31.1", "usb_ahb", usb_clk2)
+	_REGISTER_CLOCK("ehci-imx31.2", "usb", usb_clk1)
+	_REGISTER_CLOCK("ehci-imx31.2", "usb_ahb", usb_clk2)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usb_clk1)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usb_clk2)
 	_REGISTER_CLOCK("mx3-camera.0", NULL, csi_clk)
diff --git a/arch/arm/mach-imx/clock-imx35.c b/arch/arm/mach-imx/clock-imx35.c
index 8116f11..661b884 100644
--- a/arch/arm/mach-imx/clock-imx35.c
+++ b/arch/arm/mach-imx/clock-imx35.c
@@ -491,9 +491,9 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
 	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
 	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
+	_REGISTER_CLOCK("ehci-imx35.0", "usb", usbotg_clk)
+	_REGISTER_CLOCK("ehci-imx35.1", "usb", usbotg_clk)
+	_REGISTER_CLOCK("ehci-imx35.2", "usb", usbotg_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usbahb_clk)
 	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 4cb2769..56dc34b 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1459,13 +1459,13 @@ static struct clk_lookup mx51_lookups[] = {
 	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
 	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
 	_REGISTER_CLOCK("imx-i2c.2", NULL, hsi2c_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb", usboh3_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb_ahb", usb_ahb_clk)
-	_REGISTER_CLOCK("mxc-ehci.0", "usb_phy1", usb_phy1_clk)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb", usboh3_clk)
-	_REGISTER_CLOCK("mxc-ehci.1", "usb_ahb", usb_ahb_clk)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb", usboh3_clk)
-	_REGISTER_CLOCK("mxc-ehci.2", "usb_ahb", usb_ahb_clk)
+	_REGISTER_CLOCK("ehci-imx51.0", "usb", usboh3_clk)
+	_REGISTER_CLOCK("ehci-imx51.0", "usb_ahb", usb_ahb_clk)
+	_REGISTER_CLOCK("ehci-imx51.0", "usb_phy1", usb_phy1_clk)
+	_REGISTER_CLOCK("ehci-imx51.1", "usb", usboh3_clk)
+	_REGISTER_CLOCK("ehci-imx51.1", "usb_ahb", usb_ahb_clk)
+	_REGISTER_CLOCK("ehci-imx51.2", "usb", usboh3_clk)
+	_REGISTER_CLOCK("ehci-imx51.2", "usb_ahb", usb_ahb_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
 	_REGISTER_CLOCK("imx-keypad", NULL, dummy_clk)
diff --git a/arch/arm/plat-mxc/devices/platform-mxc-ehci.c b/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
index 35851d8..d339887 100644
--- a/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
+++ b/arch/arm/plat-mxc/devices/platform-mxc-ehci.c
@@ -10,51 +10,61 @@
 #include <mach/hardware.h>
 #include <mach/devices-common.h>
 
-#define imx_mxc_ehci_data_entry_single(soc, _id, hs)			\
+#define imx_mxc_ehci_data_entry_single(soc, _devid, _id, hs)			\
 	{								\
+		.devid = _devid,					\
 		.id = _id,						\
 		.iobase = soc ## _USB_ ## hs ## _BASE_ADDR,		\
 		.irq = soc ## _INT_USB_ ## hs,				\
 	}
 
+#define imx_mxc_ehci_data_entry(soc, devid, id, hs)	\
+	[id - 1] = imx_mxc_ehci_data_entry_single(soc, devid, id, hs)
+
 #ifdef CONFIG_SOC_IMX25
 const struct imx_mxc_ehci_data imx25_mxc_ehci_otg_data __initconst =
-	imx_mxc_ehci_data_entry_single(MX25, 0, OTG);
+	imx_mxc_ehci_data_entry_single(MX25, "ehci-imx25", 0, OTG);
 const struct imx_mxc_ehci_data imx25_mxc_ehci_hs_data __initconst =
-	imx_mxc_ehci_data_entry_single(MX25, 1, HS);
+	imx_mxc_ehci_data_entry_single(MX25, "ehci-imx25", 1, HS);
 #endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_mxc_ehci_data imx27_mxc_ehci_otg_data __initconst =
-	imx_mxc_ehci_data_entry_single(MX27, 0, OTG);
+	imx_mxc_ehci_data_entry_single(MX27, "ehci-imx27", 0, OTG);
 const struct imx_mxc_ehci_data imx27_mxc_ehci_hs_data[] __initconst = {
-	imx_mxc_ehci_data_entry_single(MX27, 1, HS1),
-	imx_mxc_ehci_data_entry_single(MX27, 2, HS2),
+#define imx27_imx_mxc_ehci_data_entry(soc, _id, hs)			\
+	imx_mxc_ehci_data_entry(soc, "ehci-imx27", _id, hs)
+	imx27_imx_mxc_ehci_data_entry(MX27, 1, HS1),
+	imx27_imx_mxc_ehci_data_entry(MX27, 2, HS2),
 };
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
 #ifdef CONFIG_SOC_IMX31
 const struct imx_mxc_ehci_data imx31_mxc_ehci_otg_data __initconst =
-	imx_mxc_ehci_data_entry_single(MX31, 0, OTG);
+	imx_mxc_ehci_data_entry_single(MX31, "ehci-imx31", 0, OTG);
 const struct imx_mxc_ehci_data imx31_mxc_ehci_hs_data[] __initconst = {
-	imx_mxc_ehci_data_entry_single(MX31, 1, HS1),
-	imx_mxc_ehci_data_entry_single(MX31, 2, HS2),
+#define imx31_imx_mxc_ehci_data_entry(soc, _id, hs)			\
+	imx_mxc_ehci_data_entry(soc, "ehci-imx31", _id, hs)
+	imx31_imx_mxc_ehci_data_entry(MX31, 1, HS1),
+	imx31_imx_mxc_ehci_data_entry(MX31, 2, HS2),
 };
 #endif /* ifdef CONFIG_SOC_IMX31 */
 
 #ifdef CONFIG_SOC_IMX35
 const struct imx_mxc_ehci_data imx35_mxc_ehci_otg_data __initconst =
-	imx_mxc_ehci_data_entry_single(MX35, 0, OTG);
+	imx_mxc_ehci_data_entry_single(MX35, "ehci-imx35", 0, OTG);
 const struct imx_mxc_ehci_data imx35_mxc_ehci_hs_data __initconst =
-	imx_mxc_ehci_data_entry_single(MX35, 1, HS);
+	imx_mxc_ehci_data_entry_single(MX35, "ehci-imx35", 1, HS);
 #endif /* ifdef CONFIG_SOC_IMX35 */
 
 #ifdef CONFIG_SOC_IMX51
 const struct imx_mxc_ehci_data imx51_mxc_ehci_otg_data __initconst =
-	imx_mxc_ehci_data_entry_single(MX51, 0, OTG);
+	imx_mxc_ehci_data_entry_single(MX51, "ehci-imx51", 0, OTG);
 const struct imx_mxc_ehci_data imx51_mxc_ehci_hs_data[] __initconst = {
-	imx_mxc_ehci_data_entry_single(MX51, 1, HS1),
-	imx_mxc_ehci_data_entry_single(MX51, 2, HS2),
+#define imx51_imx_mxc_ehci_data_entry(soc, _id, hs)			\
+	imx_mxc_ehci_data_entry(soc, "ehci-imx51", _id, hs)
+	imx51_imx_mxc_ehci_data_entry(MX51, 1, HS1),
+	imx51_imx_mxc_ehci_data_entry(MX51, 2, HS2),
 };
 #endif /* ifdef CONFIG_SOC_IMX51 */
 
@@ -73,7 +83,7 @@ struct platform_device *__init imx_add_mxc_ehci(
 			.flags = IORESOURCE_IRQ,
 		},
 	};
-	return imx_add_platform_device_dmamask("mxc-ehci", data->id,
+	return imx_add_platform_device_dmamask(data->devid, data->id,
 			res, ARRAY_SIZE(res),
 			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
 }
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index def9ba5..15b68e8 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -226,6 +226,7 @@ struct platform_device *__init imx_add_mx2_camera(
 
 #include <mach/mxc_ehci.h>
 struct imx_mxc_ehci_data {
+	const char *devid;
 	int id;
 	resource_size_t iobase;
 	resource_size_t irq;
diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index 55978fc..6f6b00a 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -23,6 +23,7 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
 
 #include <mach/hardware.h>
 #include <mach/mxc_ehci.h>
@@ -31,10 +32,116 @@
 
 #define ULPI_VIEWPORT_OFFSET	0x170
 
+enum mxc_ehci_type {
+	IMX23_EHCI,
+	IMX25_EHCI,
+	IMX28_EHCI,
+	IMX31_EHCI,
+	IMX35_EHCI,
+	IMX50_EHCI,
+	IMX51_EHCI,
+	IMX53_EHCI,
+	IMX6Q_EHCI,
+};
+
 struct ehci_mxc_priv {
 	struct clk *usbclk, *ahbclk, *phy1clk;
 	struct usb_hcd *hcd;
+	enum mxc_ehci_type devtype;
+};
+
+static struct platform_device_id mxc_ehci_devtype[] = {
+	{
+		.name = "ehci-imx23",
+		.driver_data = IMX25_EHCI,
+	}, {
+		.name = "ehci-imx25",
+		.driver_data = IMX35_EHCI,
+	}, {
+		.name = "ehci-imx28",
+		.driver_data = IMX35_EHCI,
+	}, {
+		.name = "ehci-imx31",
+		.driver_data = IMX35_EHCI,
+	}, {
+		.name = "ehci-imx35",
+		.driver_data = IMX35_EHCI,
+	}, {
+		.name = "ehci-imx50",
+		.driver_data = IMX51_EHCI,
+	}, {
+		.name = "ehci-imx51",
+		.driver_data = IMX51_EHCI,
+	}, {
+		.name = "ehci-imx53",
+		.driver_data = IMX53_EHCI,
+	}, {
+		.name = "ehci-imx6q",
+		.driver_data = IMX6Q_EHCI,
+	}, {
+		/* sentinel */
+	}
 };
+MODULE_DEVICE_TABLE(platform, mxc_ehci_devtype);
+
+static const struct of_device_id imx_ehci_dt_ids[] = {
+	{ .compatible = "fsl,imx23-ehci", .data = &mxc_ehci_devtype[IMX23_EHCI], },
+	{ .compatible = "fsl,imx25-ehci", .data = &mxc_ehci_devtype[IMX25_EHCI], },
+	{ .compatible = "fsl,imx28-ehci", .data = &mxc_ehci_devtype[IMX28_EHCI], },
+	{ .compatible = "fsl,imx31-ehci", .data = &mxc_ehci_devtype[IMX31_EHCI], },
+	{ .compatible = "fsl,imx35-ehci", .data = &mxc_ehci_devtype[IMX35_EHCI], },
+	{ .compatible = "fsl,imx50-ehci", .data = &mxc_ehci_devtype[IMX50_EHCI], },
+	{ .compatible = "fsl,imx51-ehci", .data = &mxc_ehci_devtype[IMX51_EHCI], },
+	{ .compatible = "fsl,imx53-ehci", .data = &mxc_ehci_devtype[IMX53_EHCI], },
+	{ .compatible = "fsl,imx6q-ehci", .data = &mxc_ehci_devtype[IMX6Q_EHCI], },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_ehci_dt_ids);
+
+static inline int is_imx23_ehci(struct ehci_mxc_priv *data)
+{
+	return data->devtype == IMX23_EHCI;
+}
+
+static inline int is_imx25_ehci(struct ehci_mxc_priv *data)
+{
+	return data->devtype == IMX25_EHCI;
+}
+
+static inline int is_imx28_ehci(struct ehci_mxc_priv *data)
+{
+	return data->devtype == IMX28_EHCI;
+}
+
+static inline int is_imx31_ehci(struct ehci_mxc_priv *data)
+{
+	return data->devtype == IMX31_EHCI;
+}
+
+static inline int is_imx35_ehci(struct ehci_mxc_priv *data)
+{
+	return data->devtype == IMX35_EHCI;
+}
+
+static inline int is_imx50_ehci(struct ehci_mxc_priv *data)
+{
+	return data->devtype == IMX50_EHCI;
+}
+
+static inline int is_imx51_ehci(struct ehci_mxc_priv *data)
+{
+	return data->devtype == IMX51_EHCI;
+}
+
+static inline int is_imx53_ehci(struct ehci_mxc_priv *data)
+{
+	return data->devtype == IMX53_EHCI;
+}
+
+static inline int is_imx6q_ehci(struct ehci_mxc_priv *data)
+{
+	return data->devtype == IMX6Q_EHCI;
+}
 
 /* called during probe() after chip reset completes */
 static int ehci_mxc_setup(struct usb_hcd *hcd)
@@ -122,6 +229,8 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	struct ehci_mxc_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct ehci_hcd *ehci;
+	const struct of_device_id *of_id =
+			of_match_device(imx_ehci_dt_ids, &pdev->dev);
 
 	dev_info(&pdev->dev, "initializing i.MX USB Controller\n");
 
@@ -141,6 +250,9 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_alloc;
 	}
+	if (of_id)
+		pdev->id_entry = of_id->data;
+	priv->devtype = pdev->id_entry->driver_data;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -173,7 +285,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	}
 	clk_enable(priv->usbclk);
 
-	if (!cpu_is_mx35() && !cpu_is_mx25()) {
+	if (!is_imx35_ehci(priv) && !is_imx25_ehci(priv)) {
 		priv->ahbclk = clk_get(dev, "usb_ahb");
 		if (IS_ERR(priv->ahbclk)) {
 			ret = PTR_ERR(priv->ahbclk);
@@ -183,7 +295,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	}
 
 	/* "dr" device has its own clock on i.MX51 */
-	if (cpu_is_mx51() && (pdev->id == 0)) {
+	if (is_imx51_ehci(priv) && (pdev->id == 0)) {
 		priv->phy1clk = clk_get(dev, "usb_phy1");
 		if (IS_ERR(priv->phy1clk)) {
 			ret = PTR_ERR(priv->phy1clk);
@@ -192,7 +304,6 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 		clk_enable(priv->phy1clk);
 	}
 
-
 	/* call platform specific init function */
 	if (pdata->init) {
 		ret = pdata->init(pdev);
@@ -336,6 +447,7 @@ static struct platform_driver ehci_mxc_driver = {
 	.probe = ehci_mxc_drv_probe,
 	.remove = __exit_p(ehci_mxc_drv_remove),
 	.shutdown = ehci_mxc_drv_shutdown,
+	.id_table	= mxc_ehci_devtype,
 	.driver = {
 		   .name = "mxc-ehci",
 	},
-- 
1.6.3.3
