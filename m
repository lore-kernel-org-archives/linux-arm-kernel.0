From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Apr 2012 11:23:41 +0200
Subject: [PATCH 09/10] mtd: mxc_nand: implement device tree probing
In-Reply-To: <20120423092240.GA18013@pengutronix.de>
References: <20120423092240.GA18013@pengutronix.de>
Message-ID: <1335173022-22371-9-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is tested on i.MX27.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/devicetree/bindings/mtd/mxc-nand.txt |   19 ++++
 drivers/mtd/nand/mxc_nand.c                        |  116 ++++++++++++++++----
 2 files changed, 115 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/mxc-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/mxc-nand.txt b/Documentation/devicetree/bindings/mtd/mxc-nand.txt
new file mode 100644
index 0000000..b5833d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mxc-nand.txt
@@ -0,0 +1,19 @@
+* Freescale's mxc_nand
+
+Required properties:
+- compatible: "fsl,imxXX-nand"
+- reg: address range of the nfc block
+- interrupts: irq to be used
+- nand-bus-width: see nand.txt
+- nand-ecc-mode: see nand.txt
+- nand-on-flash-bbt: see nand.txt
+
+Example:
+
+	nand at d8000000 {
+		compatible = "fsl,imx27-nand";
+		reg = <0xd8000000 0x1000>;
+		interrupts = <29>;
+		nand-bus-width = <8>;
+		nand-ecc-mode = "hw";
+	};
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 81ffb9b..2e4b953 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -32,6 +32,8 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/completion.h>
+#include <linux/of_device.h>
+#include <linux/of_mtd.h>
 
 #include <asm/mach/flash.h>
 #include <mach/mxc_nand.h>
@@ -199,6 +201,7 @@ struct mxc_nand_host {
 	unsigned int		buf_start;
 
 	const struct mxc_nand_devtype_data *devtype_data;
+	struct mxc_nand_platform_data pdata;
 };
 
 /* OOB placement block for use with hardware ecc generation */
@@ -268,7 +271,7 @@ static struct nand_ecclayout nandv2_hw_eccoob_4k = {
 	}
 };
 
-static const char *part_probes[] = { "RedBoot", "cmdlinepart", NULL };
+static const char *part_probes[] = { "RedBoot", "cmdlinepart", "ofpart", NULL };
 
 static int check_int_v3(struct mxc_nand_host *host)
 {
@@ -1237,11 +1240,85 @@ static const struct mxc_nand_devtype_data imx51_nand_devtype_data = {
 	.eccsize = 0,
 };
 
+#ifdef CONFIG_OF_MTD
+static const struct of_device_id mxcnd_dt_ids[] = {
+	{
+		.compatible = "fsl,imx21-nand",
+		.data = &imx21_nand_devtype_data,
+	}, {
+		.compatible = "fsl,imx27-nand",
+		.data = &imx27_nand_devtype_data,
+	}, {
+		.compatible = "fsl,imx25-nand",
+		.data = &imx25_nand_devtype_data,
+	}, {
+		.compatible = "fsl,imx51-nand",
+		.data = &imx51_nand_devtype_data,
+	},
+	{ /* sentinel */ }
+};
+
+static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
+{
+	struct device_node *np = host->dev->of_node;
+	struct mxc_nand_platform_data *pdata = &host->pdata;
+	const struct of_device_id *of_id =
+		of_match_device(mxcnd_dt_ids, host->dev);
+	int buswidth;
+
+	if (!np)
+		return 1;
+
+	if (of_get_nand_ecc_mode(np) >= 0)
+		pdata->hw_ecc = 1;
+
+	pdata->flash_bbt = of_get_nand_on_flash_bbt(np);
+
+	buswidth = of_get_nand_bus_width(np);
+	if (buswidth < 0)
+		return buswidth;
+
+	pdata->width = buswidth / 8;
+
+	host->devtype_data = of_id->data;
+
+	return 0;
+}
+#else
+static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
+{
+	return 1;
+}
+#endif
+
+static int __init mxcnd_probe_pdata(struct mxc_nand_host *host)
+{
+	struct mxc_nand_platform_data *pdata = host->dev->platform_data;
+
+	if (!pdata)
+		return -ENODEV;
+
+	host->pdata = *pdata;
+
+	if (nfc_is_v1()) {
+		if (cpu_is_mx21())
+			host->devtype_data = &imx21_nand_devtype_data;
+		else
+			host->devtype_data = &imx27_nand_devtype_data;
+	} else if (nfc_is_v21()) {
+		host->devtype_data = &imx25_nand_devtype_data;
+	} else if (nfc_is_v3_2()) {
+		host->devtype_data = &imx51_nand_devtype_data;
+	} else
+		BUG();
+
+	return 0;
+}
+
 static int __init mxcnd_probe(struct platform_device *pdev)
 {
 	struct nand_chip *this;
 	struct mtd_info *mtd;
-	struct mxc_nand_platform_data *pdata = pdev->dev.platform_data;
 	struct mxc_nand_host *host;
 	struct resource *res;
 	int err = 0;
@@ -1298,17 +1375,11 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 
 	host->main_area0 = host->base;
 
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
+	err = mxcnd_probe_dt(host);
+	if (err > 0)
+		err = mxcnd_probe_pdata(host);
+	if (err < 0)
+		goto eirq;
 
 	if (host->devtype_data->regs_offset)
 		host->regs = host->base + host->devtype_data->regs_offset;
@@ -1336,7 +1407,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (pdata->hw_ecc) {
+	if (host->pdata.hw_ecc) {
 		this->ecc.calculate = mxc_nand_calculate_ecc;
 		this->ecc.hwctl = mxc_nand_enable_hwecc;
 		this->ecc.correct = host->devtype_data->correct_data;
@@ -1345,11 +1416,11 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		this->ecc.mode = NAND_ECC_SOFT;
 	}
 
-	/* NAND bus width determines access funtions used by upper layer */
-	if (pdata->width == 2)
+	/* NAND bus width determines access functions used by upper layer */
+	if (host->pdata.width == 2)
 		this->options |= NAND_BUSWIDTH_16;
 
-	if (pdata->flash_bbt) {
+	if (host->pdata.flash_bbt) {
 		this->bbt_td = &bbt_main_descr;
 		this->bbt_md = &bbt_mirror_descr;
 		/* update flash based bbt */
@@ -1376,7 +1447,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	 * cleared on i.MX21. Otherwise we can't read the interrupt status bit
 	 * on this machine.
 	 */
-	if (host->irqpending_quirk) {
+	if (host->devtype_data->irqpending_quirk) {
 		disable_irq_nosync(host->irq);
 		host->devtype_data->irq_control(host, 1);
 	}
@@ -1409,8 +1480,12 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	}
 
 	/* Register the partitions */
-	mtd_device_parse_register(mtd, part_probes, NULL, pdata->parts,
-				  pdata->nr_parts);
+	mtd_device_parse_register(mtd, part_probes,
+			&(struct mtd_part_parser_data){
+				.of_node = pdev->dev.of_node,
+			},
+			host->pdata.parts,
+			host->pdata.nr_parts);
 
 	platform_set_drvdata(pdev, host);
 
@@ -1452,6 +1527,7 @@ static struct platform_driver mxcnd_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .owner = THIS_MODULE,
+		   .of_match_table = of_match_ptr(mxcnd_dt_ids),
 	},
 	.remove = __devexit_p(mxcnd_remove),
 };
-- 
1.7.10
