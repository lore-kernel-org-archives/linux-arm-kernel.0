From: hechtb@googlemail.com (Bastian Hecht)
Date: Tue,  2 Oct 2012 15:12:02 +0200
Subject: [PATCH 2/2] mtd: sh_flctl: Add device tree support
In-Reply-To: <1349183522-15321-1-git-send-email-hechtb@gmail.com>
References: <1349183522-15321-1-git-send-email-hechtb@gmail.com>
Message-ID: <1349183522-15321-3-git-send-email-hechtb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flctl can now be probed via device tree setup in addition to the
existing platform data way.

SoC specific setup data is set in the .data member of the OF match, so
kept within the driver itself, while board/user specific setup - like
partitioning - is taken from the device tree.

Actual configuration is added for the SoC sh7372.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 .../devicetree/bindings/mtd/flctl-nand.txt         |   37 ++++++++
 drivers/mtd/nand/sh_flctl.c                        |   92 ++++++++++++++++++--
 2 files changed, 122 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/flctl-nand.txt

diff --git a/Documentation/devicetree/bindings/mtd/flctl-nand.txt b/Documentation/devicetree/bindings/mtd/flctl-nand.txt
new file mode 100644
index 0000000..f615031
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/flctl-nand.txt
@@ -0,0 +1,37 @@
+FLCTL NAND controller
+
+Required properties:
+- compatible : "renesas,shmobile-flctl-sh7372"
+- reg : Address range of the FLCTL
+- interrupts : flste IRQ number
+- nand-bus-width : bus width to NAND chip
+
+The device tree may optionally contain sub-nodes describing partitions of the
+address space. See partition.txt for more detail.
+
+Example:
+
+	flctl at e6a30000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "renesas,shmobile-flctl-sh7372";
+		reg = <0xe6a30000 0x100>;
+		interrupts = <0x0d80>;
+
+		nand-bus-width = <16>;
+
+		system at 0 {
+			label = "system";
+			reg = <0x0 0x8000000>;
+		};
+
+		userdata at 8000000 {
+			label = "userdata";
+			reg = <0x8000000 0x10000000>;
+		};
+
+		cache at 18000000 {
+			label = "cache";
+			reg = <0x18000000 0x8000000>;
+		};
+	};
diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 0fead2a..4c7e542 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -28,6 +28,9 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_mtd.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sh_dma.h>
@@ -1020,6 +1023,73 @@ static irqreturn_t flctl_handle_flste(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_OF
+struct flctl_soc_config {
+	unsigned long flcmncr_val;
+	unsigned has_hwecc:1;
+	unsigned use_holden:1;
+};
+
+static struct flctl_soc_config flctl_sh7372_config = {
+	.flcmncr_val = CLK_16B_12L_4H | TYPESEL_SET | SHBUSSEL,
+	.has_hwecc = 1,
+	.use_holden = 1,
+};
+
+static const struct of_device_id of_flctl_match[] = {
+	{ .compatible = "renesas,shmobile-flctl-sh7372",
+				.data = &flctl_sh7372_config },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_flctl_match);
+
+static struct sh_flctl_platform_data *flctl_parse_dt(struct device *dev)
+{
+	const struct of_device_id *match;
+	struct flctl_soc_config *config;
+	struct sh_flctl_platform_data *pdata;
+	struct device_node *dn = dev->of_node;
+	int ret;
+
+	match = of_match_device(of_flctl_match, dev);
+	if (match)
+		config = (struct flctl_soc_config *)match->data;
+	else {
+		dev_err(dev, "%s: no OF configuration attached\n", __func__);
+		return NULL;
+	}
+
+	pdata = devm_kzalloc(dev, sizeof(struct sh_flctl_platform_data),
+								GFP_KERNEL);
+	if (!pdata) {
+		dev_err(dev, "%s: failed to allocate config data\n", __func__);
+		return NULL;
+	}
+
+	/* set SoC specific options */
+	pdata->flcmncr_val = config->flcmncr_val;
+	pdata->has_hwecc = config->has_hwecc;
+	pdata->use_holden = config->use_holden;
+
+	/* parse user defined options */
+	ret = of_get_nand_bus_width(dn);
+	if (ret == 16)
+		pdata->flcmncr_val |= SEL_16BIT;
+	else if (ret != 8) {
+		dev_err(dev, "%s: invalid bus width\n", __func__);
+		return NULL;
+	}
+
+	return pdata;
+}
+#else /* CONFIG_OF */
+#define of_flctl_match NULL
+static struct sh_flctl_platform_data *flctl_parse_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
 static int __devinit flctl_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -1029,12 +1099,7 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 	struct sh_flctl_platform_data *pdata;
 	int ret = -ENXIO;
 	int irq;
-
-	pdata = pdev->dev.platform_data;
-	if (pdata == NULL) {
-		dev_err(&pdev->dev, "no platform data defined\n");
-		return -EINVAL;
-	}
+	struct mtd_part_parser_data ppdata = {};
 
 	flctl = kzalloc(sizeof(struct sh_flctl), GFP_KERNEL);
 	if (!flctl) {
@@ -1066,6 +1131,16 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 		goto err_flste;
 	}
 
+	if (pdev->dev.of_node)
+		pdata = flctl_parse_dt(&pdev->dev);
+	else
+		pdata = pdev->dev.platform_data;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "no setup data defined\n");
+		return -EINVAL;
+	}
+
 	platform_set_drvdata(pdev, flctl);
 	flctl_mtd = &flctl->mtd;
 	nand = &flctl->chip;
@@ -1108,7 +1183,9 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_chip;
 
-	mtd_device_register(flctl_mtd, pdata->parts, pdata->nr_parts);
+	ppdata.of_node = pdev->dev.of_node;
+	ret = mtd_device_parse_register(flctl_mtd, NULL, &ppdata, pdata->parts,
+			pdata->nr_parts);
 
 	return 0;
 
@@ -1142,6 +1219,7 @@ static struct platform_driver flctl_driver = {
 	.driver = {
 		.name	= "sh_flctl",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_flctl_match,
 	},
 };
 
-- 
1.7.5.4
