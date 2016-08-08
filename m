From: anup.patel@broadcom.com (Anup Patel)
Date: Mon,  8 Aug 2016 11:22:36 +0530
Subject: [PATCH RESEND v2 7/8] uio: bind uio_dmem_genirq via OF
In-Reply-To: <1470635557-13416-1-git-send-email-anup.patel@broadcom.com>
References: <1470635557-13416-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1470635557-13416-8-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Viktorin <viktorin@rehivetech.com>

The uio_dmem_genirq works in a similar ways as uio_pdrv_genirq now.

It accepts the of_id module parameter to specify UIO compatible
string as module parameter. There are few other module parameters
to specify number bits in DMA mask and sizes dynamic regions.

Following are the newly added module parameters:
1) of_id: The UIO compatible string to be used for DT probing
2) dmem_dma_bits: This is the number of DMA mask bits for UIO device.
3) dmem_sizes: This is a formatted string specifying sizes of dynamic
required by some of the UIO devices.

Below are few examples of formatted string for dmem_sizes:
a) UIO dmem device with 3 dynamic regions:
uio_dmem_genirq.dmem_sizes=abc:4K,16K,4M
b) Two UIO dmem devices with different number of dynamic regions:
uio_dmem_genirq.dmem_sizes=abc:4K,16K,4M;xyz:8K

Signed-off-by: Jan Viktorin <viktorin@rehivetech.com>
Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/uio/uio_dmem_genirq.c | 162 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 135 insertions(+), 27 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index a4d6d81..1db2559 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -12,6 +12,27 @@
  * the Free Software Foundation.
  */
 
+/*
+ * For DeviceTree based platform devices, the compatible string, the DMA mask
+ * bits and sizes of dynamic regions are derived from kernel command-line.
+ *
+ * The format for specifying dynamic region sizes in kernel command line
+ * is as follows:
+ *
+ * uio_dmem_genirq.dmem_sizes := <uio_dmem_sizes_def>[;<uio_dmem_sizes_def>]
+ * <uio_dmem_sizes_def>       := <uio_name>:<size>[,<size>]
+ * <uio_name>                 := name as shown in /sys/class/uio/uioX/name
+ * <size>                     := standard linux memsize
+ *
+ * Examples:
+ *
+ * 1) UIO dmem device with 3 dynamic regions:
+ * uio_dmem_genirq.dmem_sizes=abc:4K,16K,4M
+ *
+ * 2) Two UIO dmem devices with different number of dynamic regions:
+ * uio_dmem_genirq.dmem_sizes=abc:4K,16K,4M;xyz:8K
+ */
+
 #include <linux/platform_device.h>
 #include <linux/uio_driver.h>
 #include <linux/spinlock.h>
@@ -144,46 +165,134 @@ static int uio_dmem_genirq_irqcontrol(struct uio_info *dev_info, s32 irq_on)
 	return 0;
 }
 
+static unsigned int uio_dmem_dma_bits = 32;
+static char uio_dmem_sizes[256];
+
+static int uio_dmem_genirq_alloc_platdata(struct platform_device *pdev)
+{
+	int ret, name_len;
+	u32 regions = 0;
+	char *s, *name, *sz;
+	char *sizes_str = NULL, *sizes_endstr = NULL;
+	struct uio_dmem_genirq_pdata pdata;
+	unsigned long long sizes[MAX_UIO_MAPS];
+
+	memset(&pdata, 0, sizeof(pdata));
+
+	/* Set DMA coherent mask */
+	if (uio_dmem_dma_bits > 64)
+		uio_dmem_dma_bits = 64;
+	ret = dma_set_coherent_mask(&pdev->dev,
+				    DMA_BIT_MASK(uio_dmem_dma_bits));
+	if (ret) {
+		dev_err(&pdev->dev, "Unable to dma_set_coherent_mask\n");
+		return ret;
+	}
+
+	/* Find-out start and end of sizes list */
+	s = uio_dmem_sizes;
+	while (*s != '\0') {
+		name = s;
+		s = strchr(s, ':');
+		if (!s)
+			break;
+		name_len = s - name;
+		s++;
+		if (*s == '\0')
+			break;
+		sz = s;
+		s = strchr(s, ';');
+		if (!s)
+			s = &uio_dmem_sizes[strlen(uio_dmem_sizes)];
+		if (strncmp(name, pdev->dev.of_node->name, name_len) == 0) {
+			sizes_str = sz;
+			sizes_endstr = s;
+			break;
+		}
+		s++;
+	}
+
+	/* Parse dynamic regions from sizes list */
+	regions = 0;
+	sizes[0] = 0;
+	while (sizes_str && sizes_endstr &&
+	       (sizes_str < sizes_endstr) &&
+	       (*sizes_str != '\0') &&
+	       (*sizes_str != ';') &&
+	       (regions < MAX_UIO_MAPS)) {
+		if (*sizes_str == ',') {
+			sizes_str++;
+			continue;
+		}
+		sizes[regions] = memparse(sizes_str, &sizes_str);
+		if (sizes[regions])
+			regions++;
+	}
+
+	/* Populate platform data */
+	pdata.num_dynamic_regions = regions;
+	pdata.dynamic_region_sizes = devm_kzalloc(&pdev->dev,
+			sizeof(*pdata.dynamic_region_sizes) *
+			pdata.num_dynamic_regions, GFP_KERNEL);
+	if (!pdata.dynamic_region_sizes) {
+		dev_err(&pdev->dev, "Unable to alloc dynamic_region_sizes\n");
+		ret = -ENOMEM;
+		return ret;
+	}
+
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
-	struct uio_dmem_genirq_platdata *priv;
-	struct uio_mem *uiomem;
-	int ret = -EINVAL;
 	int i;
+	int ret = -EINVAL;
+	struct uio_mem *uiomem;
+	struct uio_info *uioinfo;
+	struct uio_dmem_genirq_pdata *pdata;
+	struct uio_dmem_genirq_platdata *priv;
 
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
+	if (!pdev->dev.of_node) {
+		ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+		if (ret) {
+			dev_err(&pdev->dev,
+				"unable to dma_set_coherent_mask\n");
+			goto bad1;
+		}
+	}
 
 	priv->uioinfo = uioinfo;
 	spin_lock_init(&priv->lock);
@@ -278,10 +387,6 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
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
@@ -296,10 +401,6 @@ static int uio_dmem_genirq_remove(struct platform_device *pdev)
 	priv->uioinfo->handler = NULL;
 	priv->uioinfo->irqcontrol = NULL;
 
-	/* kfree uioinfo for OF */
-	if (pdev->dev.of_node)
-		kfree(priv->uioinfo);
-
 	kfree(priv);
 	return 0;
 }
@@ -327,10 +428,17 @@ static const struct dev_pm_ops uio_dmem_genirq_dev_pm_ops = {
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
+module_param_named(dmem_dma_bits, uio_dmem_dma_bits, uint, 0);
+MODULE_PARM_DESC(dmem_dma_bits, "Number of bits in DMA mask");
+module_param_string(dmem_sizes, uio_dmem_sizes, 256, 0);
+MODULE_PARM_DESC(dmem_sizes, "Comma separated dynamic region sizes");
 #endif
 
 static struct platform_driver uio_dmem_genirq = {
-- 
1.9.1
