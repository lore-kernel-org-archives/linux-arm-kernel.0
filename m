From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Sep 2012 14:45:33 +0800
Subject: [PATCH v2 20/34] mtd: mxc_nand: remove cpu_is_xxx by using
 platform_device_id
In-Reply-To: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1348123547-31082-21-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It changes the driver to use platform_device_id rather than cpu_is_xxx
to determine the controller type, and updates the platform code
accordingly.

As the result, mach/hardware.h inclusion gets removed from the driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: linux-mtd at lists.infradead.org
---
 arch/arm/mach-imx/clk-imx21.c                 |    2 +-
 arch/arm/mach-imx/clk-imx25.c                 |    2 +-
 arch/arm/mach-imx/clk-imx27.c                 |    2 +-
 arch/arm/mach-imx/clk-imx31.c                 |    2 +-
 arch/arm/mach-imx/clk-imx35.c                 |    2 +-
 arch/arm/mach-imx/clk-imx51-imx53.c           |    2 +-
 arch/arm/mach-imx/devices/devices-common.h    |    1 +
 arch/arm/mach-imx/devices/platform-mxc_nand.c |   20 +++---
 arch/arm/mach-imx/imx27-dt.c                  |    2 +-
 drivers/mtd/nand/mxc_nand.c                   |   86 +++++++++++++++----------
 10 files changed, 71 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx21.c b/arch/arm/mach-imx/clk-imx21.c
index 09fc31c..96a4788 100644
--- a/arch/arm/mach-imx/clk-imx21.c
+++ b/arch/arm/mach-imx/clk-imx21.c
@@ -162,7 +162,7 @@ int __init mx21_clocks_init(unsigned long lref, unsigned long href)
 	clk_register_clkdev(clk[lcdc_hclk_gate], "ahb", "imx-fb.0");
 	clk_register_clkdev(clk[usb_gate], "per", "imx21-hcd.0");
 	clk_register_clkdev(clk[usb_hclk_gate], "ahb", "imx21-hcd.0");
-	clk_register_clkdev(clk[nfc_gate], NULL, "mxc_nand.0");
+	clk_register_clkdev(clk[nfc_gate], NULL, "imx21-nand.0");
 	clk_register_clkdev(clk[dma_hclk_gate], "ahb", "imx-dma");
 	clk_register_clkdev(clk[dma_gate], "ipg", "imx-dma");
 	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index 54edac0..1aea073 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -198,7 +198,7 @@ int __init mx25_clocks_init(void)
 	clk_register_clkdev(clk[ipg], "ipg", "fsl-usb2-udc");
 	clk_register_clkdev(clk[usbotg_ahb], "ahb", "fsl-usb2-udc");
 	clk_register_clkdev(clk[usb_div], "per", "fsl-usb2-udc");
-	clk_register_clkdev(clk[nfc_ipg_per], NULL, "mxc_nand.0");
+	clk_register_clkdev(clk[nfc_ipg_per], NULL, "imx25-nand.0");
 	/* i.mx25 has the i.mx35 type cspi */
 	clk_register_clkdev(clk[cspi1_ipg], NULL, "imx35-cspi.0");
 	clk_register_clkdev(clk[cspi2_ipg], NULL, "imx35-cspi.1");
diff --git a/arch/arm/mach-imx/clk-imx27.c b/arch/arm/mach-imx/clk-imx27.c
index d9aac0f..6ae2868 100644
--- a/arch/arm/mach-imx/clk-imx27.c
+++ b/arch/arm/mach-imx/clk-imx27.c
@@ -239,7 +239,7 @@ int __init mx27_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[usb_ahb_gate], "ahb", "mxc-ehci.2");
 	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
 	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
-	clk_register_clkdev(clk[nfc_baud_gate], NULL, "mxc_nand.0");
+	clk_register_clkdev(clk[nfc_baud_gate], NULL, "imx27-nand.0");
 	clk_register_clkdev(clk[vpu_baud_gate], "per", "imx-vpu");
 	clk_register_clkdev(clk[vpu_ahb_gate], "ahb", "imx-vpu");
 	clk_register_clkdev(clk[dma_ahb_gate], "ahb", "imx-dma");
diff --git a/arch/arm/mach-imx/clk-imx31.c b/arch/arm/mach-imx/clk-imx31.c
index 76e6462..729d1a9 100644
--- a/arch/arm/mach-imx/clk-imx31.c
+++ b/arch/arm/mach-imx/clk-imx31.c
@@ -127,7 +127,7 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[rtc_gate], NULL, "mxc_rtc");
 	clk_register_clkdev(clk[epit1_gate], "epit", NULL);
 	clk_register_clkdev(clk[epit2_gate], "epit", NULL);
-	clk_register_clkdev(clk[nfc], NULL, "mxc_nand.0");
+	clk_register_clkdev(clk[nfc], NULL, "imx27-nand.0");
 	clk_register_clkdev(clk[ipu_gate], NULL, "ipu-core");
 	clk_register_clkdev(clk[ipu_gate], NULL, "mx3_sdc_fb");
 	clk_register_clkdev(clk[kpp_gate], NULL, "imx-keypad");
diff --git a/arch/arm/mach-imx/clk-imx35.c b/arch/arm/mach-imx/clk-imx35.c
index e411153..2f15c6d 100644
--- a/arch/arm/mach-imx/clk-imx35.c
+++ b/arch/arm/mach-imx/clk-imx35.c
@@ -252,7 +252,7 @@ int __init mx35_clocks_init()
 	clk_register_clkdev(clk[ipg], "ipg", "fsl-usb2-udc");
 	clk_register_clkdev(clk[usbotg_gate], "ahb", "fsl-usb2-udc");
 	clk_register_clkdev(clk[wdog_gate], NULL, "imx2-wdt.0");
-	clk_register_clkdev(clk[nfc_div], NULL, "mxc_nand.0");
+	clk_register_clkdev(clk[nfc_div], NULL, "imx25-nand.0");
 
 	clk_prepare_enable(clk[spba_gate]);
 	clk_prepare_enable(clk[gpio1_gate]);
diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index 54303a8..5399682 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -270,7 +270,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
 	clk_register_clkdev(clk[usboh3_per_gate], "per", "fsl-usb2-udc");
 	clk_register_clkdev(clk[usboh3_gate], "ipg", "fsl-usb2-udc");
 	clk_register_clkdev(clk[usboh3_gate], "ahb", "fsl-usb2-udc");
-	clk_register_clkdev(clk[nfc_gate], NULL, "mxc_nand");
+	clk_register_clkdev(clk[nfc_gate], NULL, "imx51-nand");
 	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
 	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");
 	clk_register_clkdev(clk[ssi3_ipg_gate], NULL, "imx-ssi.2");
diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
index b0f4747..d9717b3 100644
--- a/arch/arm/mach-imx/devices/devices-common.h
+++ b/arch/arm/mach-imx/devices/devices-common.h
@@ -239,6 +239,7 @@ struct platform_device *__init imx_add_mxc_mmc(
 
 #include <linux/platform_data/mtd-mxc_nand.h>
 struct imx_mxc_nand_data {
+	const char *devid;
 	/*
 	 * id is traditionally 0, but -1 is more appropriate.  We use -1 for new
 	 * machines but don't change existing devices as the nand device usually
diff --git a/arch/arm/mach-imx/devices/platform-mxc_nand.c b/arch/arm/mach-imx/devices/platform-mxc_nand.c
index eb73b82..cec6961 100644
--- a/arch/arm/mach-imx/devices/platform-mxc_nand.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_nand.c
@@ -10,15 +10,17 @@
 #include <mach/hardware.h>
 #include "devices-common.h"
 
-#define imx_mxc_nand_data_entry_single(soc, _size)			\
+#define imx_mxc_nand_data_entry_single(soc, _devid, _size)		\
 	{								\
+		.devid = _devid,					\
 		.iobase = soc ## _NFC_BASE_ADDR,			\
 		.iosize = _size,					\
 		.irq = soc ## _INT_NFC					\
 	}
 
-#define imx_mxc_nandv3_data_entry_single(soc, _size)			\
+#define imx_mxc_nandv3_data_entry_single(soc, _devid, _size)		\
 	{								\
+		.devid = _devid,					\
 		.id = -1,						\
 		.iobase = soc ## _NFC_BASE_ADDR,			\
 		.iosize = _size,					\
@@ -28,32 +30,32 @@
 
 #ifdef CONFIG_SOC_IMX21
 const struct imx_mxc_nand_data imx21_mxc_nand_data __initconst =
-	imx_mxc_nand_data_entry_single(MX21, SZ_4K);
+	imx_mxc_nand_data_entry_single(MX21, "imx21-nand", SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX21 */
 
 #ifdef CONFIG_SOC_IMX25
 const struct imx_mxc_nand_data imx25_mxc_nand_data __initconst =
-	imx_mxc_nand_data_entry_single(MX25, SZ_8K);
+	imx_mxc_nand_data_entry_single(MX25, "imx25-nand", SZ_8K);
 #endif /* ifdef CONFIG_SOC_IMX25 */
 
 #ifdef CONFIG_SOC_IMX27
 const struct imx_mxc_nand_data imx27_mxc_nand_data __initconst =
-	imx_mxc_nand_data_entry_single(MX27, SZ_4K);
+	imx_mxc_nand_data_entry_single(MX27, "imx27-nand", SZ_4K);
 #endif /* ifdef CONFIG_SOC_IMX27 */
 
 #ifdef CONFIG_SOC_IMX31
 const struct imx_mxc_nand_data imx31_mxc_nand_data __initconst =
-	imx_mxc_nand_data_entry_single(MX31, SZ_4K);
+	imx_mxc_nand_data_entry_single(MX31, "imx27-nand", SZ_4K);
 #endif
 
 #ifdef CONFIG_SOC_IMX35
 const struct imx_mxc_nand_data imx35_mxc_nand_data __initconst =
-	imx_mxc_nand_data_entry_single(MX35, SZ_8K);
+	imx_mxc_nand_data_entry_single(MX35, "imx25-nand", SZ_8K);
 #endif
 
 #ifdef CONFIG_SOC_IMX51
 const struct imx_mxc_nand_data imx51_mxc_nand_data __initconst =
-	imx_mxc_nandv3_data_entry_single(MX51, SZ_16K);
+	imx_mxc_nandv3_data_entry_single(MX51, "imx51-nand", SZ_16K);
 #endif
 
 struct platform_device *__init imx_add_mxc_nand(
@@ -76,7 +78,7 @@ struct platform_device *__init imx_add_mxc_nand(
 			.flags = IORESOURCE_IRQ,
 		},
 	};
-	return imx_add_platform_device("mxc_nand", data->id,
+	return imx_add_platform_device(data->devid, data->id,
 			res + !data->axibase,
 			ARRAY_SIZE(res) - !data->axibase,
 			pdata, sizeof(*pdata));
diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
index 43fbf86..a6c288e 100644
--- a/arch/arm/mach-imx/imx27-dt.c
+++ b/arch/arm/mach-imx/imx27-dt.c
@@ -29,7 +29,7 @@ static const struct of_dev_auxdata imx27_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("fsl,imx27-cspi", MX27_CSPI2_BASE_ADDR, "imx27-cspi.1", NULL),
 	OF_DEV_AUXDATA("fsl,imx27-cspi", MX27_CSPI3_BASE_ADDR, "imx27-cspi.2", NULL),
 	OF_DEV_AUXDATA("fsl,imx27-wdt", MX27_WDOG_BASE_ADDR, "imx2-wdt.0", NULL),
-	OF_DEV_AUXDATA("fsl,imx27-nand", MX27_NFC_BASE_ADDR, "mxc_nand.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx27-nand", MX27_NFC_BASE_ADDR, "imx27-nand.0", NULL),
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 5683604..d5f8f01 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -37,15 +37,9 @@
 
 #include <asm/mach/flash.h>
 #include <linux/platform_data/mtd-mxc_nand.h>
-#include <mach/hardware.h>
 
 #define DRIVER_NAME "mxc_nand"
 
-#define nfc_is_v21()		(cpu_is_mx25() || cpu_is_mx35())
-#define nfc_is_v1()		(cpu_is_mx31() || cpu_is_mx27() || cpu_is_mx21())
-#define nfc_is_v3_2()		(cpu_is_mx51() || cpu_is_mx53())
-#define nfc_is_v3()		nfc_is_v3_2()
-
 /* Addresses for NFC registers */
 #define NFC_V1_V2_BUF_SIZE		(host->regs + 0x00)
 #define NFC_V1_V2_BUF_ADDR		(host->regs + 0x04)
@@ -1260,6 +1254,45 @@ static const struct mxc_nand_devtype_data imx51_nand_devtype_data = {
 	.eccsize = 0,
 };
 
+static inline int is_imx21_nfc(struct mxc_nand_host *host)
+{
+	return host->devtype_data == &imx21_nand_devtype_data;
+}
+
+static inline int is_imx27_nfc(struct mxc_nand_host *host)
+{
+	return host->devtype_data == &imx27_nand_devtype_data;
+}
+
+static inline int is_imx25_nfc(struct mxc_nand_host *host)
+{
+	return host->devtype_data == &imx25_nand_devtype_data;
+}
+
+static inline int is_imx51_nfc(struct mxc_nand_host *host)
+{
+	return host->devtype_data == &imx51_nand_devtype_data;
+}
+
+static struct platform_device_id mxcnd_devtype[] = {
+	{
+		.name = "imx21-nand",
+		.driver_data = (kernel_ulong_t) &imx21_nand_devtype_data,
+	}, {
+		.name = "imx27-nand",
+		.driver_data = (kernel_ulong_t) &imx27_nand_devtype_data,
+	}, {
+		.name = "imx25-nand",
+		.driver_data = (kernel_ulong_t) &imx25_nand_devtype_data,
+	}, {
+		.name = "imx51-nand",
+		.driver_data = (kernel_ulong_t) &imx51_nand_devtype_data,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(platform, mxcnd_devtype);
+
 #ifdef CONFIG_OF_MTD
 static const struct of_device_id mxcnd_dt_ids[] = {
 	{
@@ -1311,30 +1344,6 @@ static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
 }
 #endif
 
-static int __init mxcnd_probe_pdata(struct mxc_nand_host *host)
-{
-	struct mxc_nand_platform_data *pdata = host->dev->platform_data;
-
-	if (!pdata)
-		return -ENODEV;
-
-	host->pdata = *pdata;
-
-	if (nfc_is_v1()) {
-		if (cpu_is_mx21())
-			host->devtype_data = &imx21_nand_devtype_data;
-		else
-			host->devtype_data = &imx27_nand_devtype_data;
-	} else if (nfc_is_v21()) {
-		host->devtype_data = &imx25_nand_devtype_data;
-	} else if (nfc_is_v3_2()) {
-		host->devtype_data = &imx51_nand_devtype_data;
-	} else
-		BUG();
-
-	return 0;
-}
-
 static int __init mxcnd_probe(struct platform_device *pdev)
 {
 	struct nand_chip *this;
@@ -1396,8 +1405,16 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	host->main_area0 = host->base;
 
 	err = mxcnd_probe_dt(host);
-	if (err > 0)
-		err = mxcnd_probe_pdata(host);
+	if (err > 0) {
+		struct mxc_nand_platform_data *pdata = pdev->dev.platform_data;
+		if (pdata) {
+			host->pdata = *pdata;
+			host->devtype_data = (struct mxc_nand_devtype_data *)
+						pdev->id_entry->driver_data;
+		} else {
+			err = -ENODEV;
+		}
+	}
 	if (err < 0)
 		goto eirq;
 
@@ -1473,7 +1490,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	}
 
 	/* first scan to find the device and get the page size */
-	if (nand_scan_ident(mtd, nfc_is_v21() ? 4 : 1, NULL)) {
+	if (nand_scan_ident(mtd, is_imx25_nfc(host) ? 4 : 1, NULL)) {
 		err = -ENXIO;
 		goto escan;
 	}
@@ -1487,7 +1504,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		this->ecc.layout = host->devtype_data->ecclayout_4k;
 
 	if (this->ecc.mode == NAND_ECC_HW) {
-		if (nfc_is_v1())
+		if (is_imx21_nfc(host) || is_imx27_nfc(host))
 			this->ecc.strength = 1;
 		else
 			this->ecc.strength = (host->eccsize == 4) ? 4 : 8;
@@ -1549,6 +1566,7 @@ static struct platform_driver mxcnd_driver = {
 		   .owner = THIS_MODULE,
 		   .of_match_table = of_match_ptr(mxcnd_dt_ids),
 	},
+	.id_table = mxcnd_devtype,
 	.remove = __devexit_p(mxcnd_remove),
 };
 
-- 
1.7.9.5
