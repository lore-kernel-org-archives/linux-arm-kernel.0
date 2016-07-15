From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 15 Jul 2016 14:34:02 +0530
Subject: [PATCH 7/8] uio: bind uio_dmem_genirq via OF
In-Reply-To: <1468573443-4670-1-git-send-email-anup.patel@broadcom.com>
References: <1468573443-4670-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1468573443-4670-8-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Viktorin <viktorin@rehivetech.com>

The uio_dmem_genirq works in a similar ways as uio_pdrv_genirq now.

It accepts the of_id module parameter to specify UIO compatible
string as module parameter. There are few other module parameters
to specify DT property name for number bits in DMA mask and details
about dynamic regions.

Following are the newly added module parameters:
1) of_id: The UIO compatible string to be used for DT probing
2) of_dma_bits_prot: This is name of OF property which will be
used to specify number of DMA mask bits in UIO DT node.
3) of_dmem_count_prop: This is name of OF property which will be
used to specify number of dynamic regions in UIO DT node.
4) of_dmem_sizes_prop: This is name of OF property which will be
used to specify sizes of each dynamic regions in UIO DT node.

Signed-off-by: Jan Viktorin <viktorin@rehivetech.com>
Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/uio/uio_dmem_genirq.c | 113 +++++++++++++++++++++++++++++++++---------
 1 file changed, 89 insertions(+), 24 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index a4d6d81..0a0cc19 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -144,46 +144,107 @@ static int uio_dmem_genirq_irqcontrol(struct uio_info *dev_info, s32 irq_on)
 	return 0;
 }
 
+static char uio_of_dma_bits_prop[128] = "uio,dma-bits";
+static char uio_of_dmem_count_prop[128] = "uio,number-of-dynamic-regions";
+static char uio_of_dmem_sizes_prop[128] = "uio,dynamic-regions-sizes";
+
+static int uio_dmem_genirq_alloc_platdata(struct platform_device *pdev)
+{
+	struct uio_dmem_genirq_pdata pdata;
+	u32 dma_bits, regions;
+	u32 sizes[MAX_UIO_MAPS];
+	int ret;
+
+	memset(&pdata, 0, sizeof(pdata));
+
+	ret = of_property_read_u32(pdev->dev.of_node,
+				   uio_of_dma_bits_prop, &dma_bits);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Missing property %s\n", uio_of_dma_bits_prop);
+		return ret;
+	}
+	if (dma_bits > 64)
+		dma_bits = 64;
+
+	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(dma_bits));
+
+	ret = of_property_read_u32(pdev->dev.of_node,
+				   uio_of_dmem_count_prop, &regions);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Missing property %s\n", uio_of_dmem_count_prop);
+		return ret;
+	}
+
+	regions = min_t(u32, regions, MAX_UIO_MAPS);
+
+	ret = of_property_read_u32_array(pdev->dev.of_node,
+					 uio_of_dmem_sizes_prop, sizes,
+					 regions);
+	if (ret) {
+		dev_err(&pdev->dev, "Missing or invalid property %s\n",
+			uio_of_dmem_sizes_prop);
+		return ret;
+	}
+
+	pdata.dynamic_region_sizes = devm_kzalloc(&pdev->dev,
+			sizeof(*pdata.dynamic_region_sizes) *
+			pdata.num_dynamic_regions, GFP_KERNEL);
+	if (!pdata.dynamic_region_sizes) {
+		dev_err(&pdev->dev, "Unable to alloc dynamic_region_sizes\n");
+		ret = -ENOMEM;
+		return ret;
+	}
+
+	pdata.num_dynamic_regions = regions;
+	while (regions--)
+		pdata.dynamic_region_sizes[regions] = sizes[regions];
+
+	pdata.uioinfo.name = pdev->dev.of_node->name;
+	pdata.uioinfo.version = "devicetree";
+
+	return platform_device_add_data(pdev, &pdata, sizeof(pdata));
+}
+
 static int uio_dmem_genirq_probe(struct platform_device *pdev)
 {
-	struct uio_dmem_genirq_pdata *pdata = dev_get_platdata(&pdev->dev);
-	struct uio_info *uioinfo = &pdata->uioinfo;
+	struct uio_dmem_genirq_pdata *pdata;
+	struct uio_info *uioinfo;
 	struct uio_dmem_genirq_platdata *priv;
 	struct uio_mem *uiomem;
 	int ret = -EINVAL;
 	int i;
 
 	if (pdev->dev.of_node) {
-		/* alloc uioinfo for one device */
-		uioinfo = kzalloc(sizeof(*uioinfo), GFP_KERNEL);
-		if (!uioinfo) {
-			ret = -ENOMEM;
-			dev_err(&pdev->dev, "unable to kmalloc\n");
+		ret = uio_dmem_genirq_alloc_platdata(pdev);
+		if (ret)
 			goto bad2;
-		}
-		uioinfo->name = pdev->dev.of_node->name;
-		uioinfo->version = "devicetree";
 	}
 
+	pdata = dev_get_platdata(&pdev->dev);
+	uioinfo = &pdata->uioinfo;
+
 	if (!uioinfo || !uioinfo->name || !uioinfo->version) {
 		dev_err(&pdev->dev, "missing platform_data\n");
-		goto bad0;
+		goto bad2;
 	}
 
 	if (uioinfo->handler || uioinfo->irqcontrol ||
 	    uioinfo->irq_flags & IRQF_SHARED) {
 		dev_err(&pdev->dev, "interrupt configuration error\n");
-		goto bad0;
+		goto bad2;
 	}
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		ret = -ENOMEM;
 		dev_err(&pdev->dev, "unable to kmalloc\n");
-		goto bad0;
+		goto bad2;
 	}
 
-	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	if (!pdev->dev.of_node)
+		dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 
 	priv->uioinfo = uioinfo;
 	spin_lock_init(&priv->lock);
@@ -278,10 +339,6 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 	return 0;
  bad1:
 	kfree(priv);
- bad0:
-	/* kfree uioinfo for OF */
-	if (pdev->dev.of_node)
-		kfree(uioinfo);
  bad2:
 	return ret;
 }
@@ -296,10 +353,6 @@ static int uio_dmem_genirq_remove(struct platform_device *pdev)
 	priv->uioinfo->handler = NULL;
 	priv->uioinfo->irqcontrol = NULL;
 
-	/* kfree uioinfo for OF */
-	if (pdev->dev.of_node)
-		kfree(priv->uioinfo);
-
 	kfree(priv);
 	return 0;
 }
@@ -327,10 +380,22 @@ static const struct dev_pm_ops uio_dmem_genirq_dev_pm_ops = {
 };
 
 #ifdef CONFIG_OF
-static const struct of_device_id uio_of_genirq_match[] = {
-	{ /* empty for now */ },
+static struct of_device_id uio_of_genirq_match[] = {
+	{ /* This is filled with module_parm */ },
+	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(of, uio_of_genirq_match);
+module_param_string(of_id, uio_of_genirq_match[0].compatible, 128, 0);
+MODULE_PARM_DESC(of_id, "Openfirmware id of the device to be handled by uio");
+module_param_string(of_dma_bits_prop, uio_of_dma_bits_prop, 128, 0);
+MODULE_PARM_DESC(of_dma_bits_prop,
+		 "Openfirmware property for number of bits in DMA mask");
+module_param_string(of_dmem_count_prop, uio_of_dmem_count_prop, 128, 0);
+MODULE_PARM_DESC(of_dmem_count_prop,
+		 "Openfirmware property for dynamic region count");
+module_param_string(of_dmem_sizes_prop, uio_of_dmem_sizes_prop, 128, 0);
+MODULE_PARM_DESC(of_dmem_sizes_prop,
+		 "Openfirmware property for dynamic region sizes");
 #endif
 
 static struct platform_driver uio_dmem_genirq = {
-- 
1.9.1
