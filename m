From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 12 Jan 2014 12:13:37 +0100
Subject: [PATCH V3 4/9] spi: rspi: Add DT support
In-Reply-To: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1389525222-3482-5-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
V2:
  - Clarify RSPI/QSPI
  - Add interrupt-parent
  - s/should/must/ for #address-cells and #size-cells
V3:
  - Add renesas,rspi-sh
  - Drop -rcar suffix for QSPI
  - Clarify num-cs
  - Implement DT support in driver
  - Changed one-line summary from "Documentation: dt: Add Renesas RSPI/QSPI
    bindings" to "spi: rspi: Add DT support"
---
 Documentation/devicetree/bindings/spi/spi-rspi.txt |   33 +++++
 drivers/spi/spi-rspi.c                             |  131 +++++++++++++++++---
 2 files changed, 145 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-rspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-rspi.txt b/Documentation/devicetree/bindings/spi/spi-rspi.txt
new file mode 100644
index 000000000000..19854eeee579
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-rspi.txt
@@ -0,0 +1,33 @@
+Device tree configuration for Renesas RSPI/QSPI driver
+
+Required properties:
+- compatible       : For Renesas Serial Peripheral Interface on SH:
+                     "renesas,rspi-<soctype>", "renesas,rspi-sh" as fallback.
+		     For Renesas Serial Peripheral Interface on ARM:
+                     "renesas,rspi-<soctype>", "renesas,rspi-rz" as fallback.
+		     For Quad Serial Peripheral Interface:
+		     "renesas,qspi-<soctype>", "renesas,qspi" as fallback.
+- reg              : Address start and address range size of device
+- interrupts       : Up to 3 interrupts for RSPI (SPEI, SPRI, SPTI),
+		     1 interrupt for QSPI
+- interrupt-parent : The phandle for the interrupt controller that
+		     services interrupts for this device.
+- num-cs	   : Number of chip selects. Some RSPI cores have more than 1.
+- #address-cells   : Must be <1>
+- #size-cells      : Must be <0>
+
+Pinctrl properties might be needed, too. See there.
+
+Example:
+
+	spi0: spi at e800c800 {
+		compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz";
+		reg = <0xe800c800 0x24>;
+		interrupts = <0 238 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 239 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 240 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		num-cs = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 6fd4770d22bd..dd3e9fd936ba 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -33,6 +33,7 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/of_device.h>
 #include <linux/sh_dma.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/rspi.h>
@@ -1071,6 +1072,101 @@ static int rspi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct spi_ops rspi_ops = {
+	.parse_platform_data =		rspi_parse_platform_data,
+	.set_config_register =		rspi_set_config_register,
+	.send_pio =			rspi_send_pio,
+	.receive_pio =			rspi_receive_pio,
+	.mode_bits =			SPI_CPHA | SPI_CPOL | SPI_LOOP,
+};
+
+static const struct spi_ops qspi_ops = {
+	.parse_platform_data =		qspi_parse_platform_data,
+	.set_config_register =		qspi_set_config_register,
+	.send_pio =			qspi_send_pio,
+	.receive_pio =			qspi_receive_pio,
+	.mode_bits =			SPI_CPHA | SPI_CPOL,
+};
+
+#ifdef CONFIG_OF
+struct rspi_of_data {
+	const struct rspi_plat_data *template;
+	const struct spi_ops *spi_ops;
+};
+
+static const struct rspi_plat_data rspi_sh_template = {
+	.data_width	= 0,		/* legacy 16 bit */
+	.txmode		= true,		/* TX only mode */
+	.spcr2		= true,		/* Parity register */
+};
+
+static const struct rspi_plat_data rspi_arm_template = {
+	.data_width	= 8,		/* fixed 8-bit */
+	.txmode		= false,	/* No TX only mode */
+	.spcr2		= false,	/* No parity register */
+};
+
+static const struct rspi_of_data rspi_sh_of_data = {
+	.spi_ops	= &rspi_ops,
+	.template	= &rspi_sh_template,
+};
+
+static const struct rspi_of_data rspi_rz_of_data = {
+	.spi_ops	= &rspi_ops,
+	.template	= &rspi_arm_template,
+};
+
+static const struct rspi_of_data qspi_of_data = {
+	.spi_ops	= &qspi_ops,
+	.template	= &rspi_arm_template,
+};
+
+static const struct of_device_id rspi_of_match[] = {
+	/* RSPI on legacy SH */
+	{ .compatible = "renesas,rspi-sh7757", .data = &rspi_sh_of_data },
+	{ .compatible = "renesas,rspi-sh", .data = &rspi_sh_of_data },
+	/* RSPI on RZ */
+	{ .compatible = "renesas,rspi-r7s72100", .data = &rspi_rz_of_data },
+	{ .compatible = "renesas,rspi-rz", .data = &rspi_rz_of_data },
+	/* QSPI on R-Car Gen2 */
+	{ .compatible = "renesas,qspi-r8a7790", .data = &qspi_of_data },
+	{ .compatible = "renesas,qspi-r8a7791", .data = &qspi_of_data },
+	{ .compatible = "renesas,qspi", .data = &qspi_of_data },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, rspi_of_match);
+
+static int rspi_parse_dt(struct device *dev, const struct rspi_of_data *od,
+			 const struct rspi_plat_data **pd_out,
+			 const struct spi_ops **ops_out)
+{
+	struct rspi_plat_data *pd;
+	u32 num_cs;
+	int error;
+
+	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd) {
+		dev_err(dev, "failed to allocate platform data\n");
+		return -ENOMEM;
+	}
+
+	/* Setup defaults from template */
+	memcpy(pd, od->template, sizeof(*pd));
+
+	/* Parse DT properties */
+	error = of_property_read_u32(dev->of_node, "num-cs", &num_cs);
+	if (error)
+		return error;
+	pd->num_chipselect = num_cs;
+
+	*pd_out = pd;
+	*ops_out = od->spi_ops;
+	return 0;
+}
+
+#endif /* CONFIG_OF */
+
 static int rspi_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -1078,11 +1174,22 @@ static int rspi_probe(struct platform_device *pdev)
 	struct rspi_data *rspi;
 	int ret, irq;
 	unsigned int i;
-	const struct rspi_plat_data *rspi_pd = dev_get_platdata(&pdev->dev);
+	const struct of_device_id *of_id;
+	const struct rspi_plat_data *rspi_pd;
 	const struct spi_ops *ops;
-	const struct platform_device_id *id_entry = pdev->id_entry;
 
-	ops = (struct spi_ops *)id_entry->driver_data;
+	of_id = of_match_device(rspi_of_match, &pdev->dev);
+	if (of_id) {
+		ret = rspi_parse_dt(&pdev->dev, of_id->data, &rspi_pd, &ops);
+		if (ret) {
+			dev_err(&pdev->dev, "rspi_parse_dt failed %d\n", ret);
+			return ret;
+		}
+	} else {
+		ops = (struct spi_ops *)pdev->id_entry->driver_data;
+		rspi_pd = dev_get_platdata(&pdev->dev);
+	};
+
 	/* ops parameter check */
 	if (!ops->set_config_register) {
 		dev_err(&pdev->dev, "there is no set_config_register\n");
@@ -1135,6 +1242,7 @@ static int rspi_probe(struct platform_device *pdev)
 	master->transfer = rspi_transfer;
 	master->cleanup = rspi_cleanup;
 	master->mode_bits = ops->mode_bits;
+	master->dev.of_node = pdev->dev.of_node;
 
 	ret = ops->parse_platform_data(rspi, rspi_pd);
 	if (ret < 0) {
@@ -1187,22 +1295,6 @@ error1:
 	return ret;
 }
 
-static struct spi_ops rspi_ops = {
-	.parse_platform_data =		rspi_parse_platform_data,
-	.set_config_register =		rspi_set_config_register,
-	.send_pio =			rspi_send_pio,
-	.receive_pio =			rspi_receive_pio,
-	.mode_bits =			SPI_CPHA | SPI_CPOL | SPI_LOOP,
-};
-
-static struct spi_ops qspi_ops = {
-	.parse_platform_data =		qspi_parse_platform_data,
-	.set_config_register =		qspi_set_config_register,
-	.send_pio =			qspi_send_pio,
-	.receive_pio =			qspi_receive_pio,
-	.mode_bits =			SPI_CPHA | SPI_CPOL,
-};
-
 static struct platform_device_id spi_driver_ids[] = {
 	{ "rspi",	(kernel_ulong_t)&rspi_ops },
 	{ "qspi",	(kernel_ulong_t)&qspi_ops },
@@ -1218,6 +1310,7 @@ static struct platform_driver rspi_driver = {
 	.driver		= {
 		.name = "renesas_spi",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(rspi_of_match),
 	},
 };
 module_platform_driver(rspi_driver);
-- 
1.7.9.5
