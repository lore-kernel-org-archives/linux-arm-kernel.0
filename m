From: zonque@gmail.com (Daniel Mack)
Date: Wed,  7 Aug 2013 17:33:53 +0200
Subject: [PATCH 04/20] ARM: pxa: ssp: add DT bindings
In-Reply-To: <1375889649-14638-1-git-send-email-zonque@gmail.com>
References: <1375889649-14638-1-git-send-email-zonque@gmail.com>
Message-ID: <1375889649-14638-5-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT bindings for the pxa ssp driver.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 .../devicetree/bindings/serial/mrvl,pxa-ssp.txt    | 43 ++++++++++
 arch/arm/plat-pxa/ssp.c                            | 93 +++++++++++++++++-----
 2 files changed, 115 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt

diff --git a/Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt b/Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
new file mode 100644
index 0000000..9f642f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
@@ -0,0 +1,43 @@
+Device tree bindings for Marvell PXA SSP ports
+
+Required properties:
+
+	- compatible:	Must be one of
+				mrvl,pxa25x-ssp
+				mvrl,pxa25x-nssp
+				mrvl,pxa27x-ssp
+				mrvl,pxa3xx-ssp
+				mvrl,pxa168-ssp
+				mrvl,pxa910-ssp
+				mrvl,ce4100-ssp
+				mrvl,lpss-ssp
+
+	- reg:		The memory base
+
+
+Example for PXA3xx:
+
+	ssp at 41000000 {
+		compatible = "mrvl,pxa27x-ssp";
+		reg = <0x41000000 0x40>;
+		interrupts = <24>;
+	};
+
+	ssp at 41700000 {
+		compatible = "mrvl,pxa27x-ssp";
+		reg = <0x41700000 0x40>;
+		interrupts = <16>;
+	};
+
+	ssp at 41900000 {
+		compatible = "mrvl,pxa27x-ssp";
+		reg = <0x41900000 0x40>;
+		interrupts = <0>;
+	};
+
+	ssp at 41a00000 {
+		compatible = "mrvl,pxa27x-ssp";
+		reg = <0x41a00000 0x40>;
+		interrupts = <13>;
+	};
+
diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index a503ea0..7628e85 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -30,12 +30,15 @@
 #include <linux/platform_device.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <asm/irq.h>
 #include <mach/hardware.h>
 
 static DEFINE_MUTEX(ssp_lock);
 static LIST_HEAD(ssp_list);
+static unsigned int ssp_count;
 
 struct ssp_device *pxa_ssp_request(int port, const char *label)
 {
@@ -72,9 +75,23 @@ void pxa_ssp_free(struct ssp_device *ssp)
 }
 EXPORT_SYMBOL(pxa_ssp_free);
 
+#ifdef CONFIG_OF
+static const struct of_device_id pxa_ssp_of_ids[] = {
+	{ .compatible = "mrvl,pxa25x-ssp",	.data = (void *) PXA25x_SSP },
+	{ .compatible = "mvrl,pxa25x-nssp",	.data = (void *) PXA25x_NSSP },
+	{ .compatible = "mrvl,pxa27x-ssp",	.data = (void *) PXA27x_SSP },
+	{ .compatible = "mrvl,pxa3xx-ssp",	.data = (void *) PXA3xx_SSP },
+	{ .compatible = "mvrl,pxa168-ssp",	.data = (void *) PXA168_SSP },
+	{ .compatible = "mrvl,pxa910-ssp",	.data = (void *) PXA910_SSP },
+	{ .compatible = "mrvl,ce4100-ssp",	.data = (void *) CE4100_SSP },
+	{ .compatible = "mrvl,lpss-ssp",	.data = (void *) LPSS_SSP },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pxa_ssp_of_ids);
+#endif
+
 static int pxa_ssp_probe(struct platform_device *pdev)
 {
-	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct resource *res;
 	struct ssp_device *ssp;
 	struct device *dev = &pdev->dev;
@@ -93,21 +110,42 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (res == NULL) {
-		dev_err(dev, "no SSP RX DRCMR defined\n");
-		ret = -ENODEV;
-		goto err_free_clk;
-	}
-	ssp->drcmr_rx = res->start;
+	if (dev->of_node) {
+		struct of_phandle_args dma_spec;
+		struct device_node *np = dev->of_node;
+
+		/*
+		 * FIXME: we should allocate the DMA channel from this
+		 * context and pass the channel down to the ssp users.
+		 * For now, we lookup the rx and tx indices manually
+		 */
+
+		/* rx */
+		of_parse_phandle_with_args(np, "dmas", "#dma-cells",
+					   0, &dma_spec);
+		ssp->drcmr_rx = dma_spec.args[0];
+		of_node_put(dma_spec.np);
+
+		/* tx */
+		of_parse_phandle_with_args(np, "dmas", "#dma-cells",
+					   1, &dma_spec);
+		ssp->drcmr_tx = dma_spec.args[0];
+		of_node_put(dma_spec.np);
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+		if (res == NULL) {
+			dev_err(dev, "no SSP RX DRCMR defined\n");
+			return -ENODEV;
+		}
+		ssp->drcmr_rx = res->start;
 
-	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-	if (res == NULL) {
-		dev_err(dev, "no SSP TX DRCMR defined\n");
-		ret = -ENODEV;
-		goto err_free_clk;
+		res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+		if (res == NULL) {
+			dev_err(dev, "no SSP TX DRCMR defined\n");
+			return -ENODEV;
+		}
+		ssp->drcmr_tx = res->start;
 	}
-	ssp->drcmr_tx = res->start;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
@@ -140,12 +178,24 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 		goto err_free_io;
 	}
 
-	/* PXA2xx/3xx SSP ports starts from 1 and the internal pdev->id
-	 * starts from 0, do a translation here
-	 */
-	ssp->port_id = pdev->id + 1;
+	if (dev->of_node) {
+		const struct of_device_id *id =
+			of_match_device(of_match_ptr(pxa_ssp_of_ids), dev);
+		ssp->type = (int) id->data;
+		/* REVISIT: we want to pass real of_nodes eventually */
+		ssp->port_id = ++ssp_count;
+	} else {
+		const struct platform_device_id *id =
+			platform_get_device_id(pdev);
+		ssp->type = (int) id->driver_data;
+
+		/* PXA2xx/3xx SSP ports starts from 1 and the internal pdev->id
+		 * starts from 0, do a translation here
+		 */
+		ssp->port_id = pdev->id + 1;
+	}
+
 	ssp->use_count = 0;
-	ssp->type = (int)id->driver_data;
 
 	mutex_lock(&ssp_lock);
 	list_add(&ssp->node, &ssp_list);
@@ -202,8 +252,9 @@ static struct platform_driver pxa_ssp_driver = {
 	.probe		= pxa_ssp_probe,
 	.remove		= pxa_ssp_remove,
 	.driver		= {
-		.owner	= THIS_MODULE,
-		.name	= "pxa2xx-ssp",
+		.owner		= THIS_MODULE,
+		.name		= "pxa2xx-ssp",
+		.of_match_table	= of_match_ptr(pxa_ssp_of_ids),
 	},
 	.id_table	= ssp_id_table,
 };
-- 
1.8.3.1
