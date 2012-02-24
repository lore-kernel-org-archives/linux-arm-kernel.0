From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Feb 2012 22:09:39 +0800
Subject: [PATCH 4/6] ASoC: fsl: create fsl_utils to accommodate the common
 functions
In-Reply-To: <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330092582-21180-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some amount of code duplication between mpc8610_hpcd and
p1022_ds machine drivers, and the same code will be duplicated again
when another new machine driver is added.  The patch creates fsl_utils
to accommodate the common functions to stop the code duplication.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/Kconfig        |    5 ++
 sound/soc/fsl/Makefile       |    2 +
 sound/soc/fsl/fsl_utils.c    |  153 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/fsl/fsl_utils.h    |   29 ++++++++
 sound/soc/fsl/mpc8610_hpcd.c |  157 +++---------------------------------------
 sound/soc/fsl/p1022_ds.c     |  149 +++-------------------------------------
 6 files changed, 209 insertions(+), 286 deletions(-)
 create mode 100644 sound/soc/fsl/fsl_utils.c
 create mode 100644 sound/soc/fsl/fsl_utils.h

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index a62dc28..337c3d1 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,6 +1,9 @@
 config SND_SOC_FSL_SSI
 	tristate
 
+config SND_SOC_FSL_UTILS
+	tristate
+
 menuconfig SND_POWERPC_SOC
 	tristate "SoC Audio for Freescale PowerPC CPUs"
 	depends on FSL_SOC
@@ -26,6 +29,7 @@ config SND_SOC_MPC8610_HPCD
 	# I2C is necessary for the CS4270 driver
 	depends on MPC8610_HPCD && I2C
 	select SND_SOC_FSL_SSI
+	select SND_SOC_FSL_UTILS
 	select SND_SOC_POWERPC_DMA
 	select SND_SOC_CS4270
 	select SND_SOC_CS4270_VD33_ERRATA
@@ -38,6 +42,7 @@ config SND_SOC_P1022_DS
 	# I2C is necessary for the WM8776 driver
 	depends on P1022_DS && I2C
 	select SND_SOC_FSL_SSI
+	select SND_SOC_FSL_UTILS
 	select SND_SOC_POWERPC_DMA
 	select SND_SOC_WM8776
 	default y if P1022_DS
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 65087b1..46752af 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -8,8 +8,10 @@ obj-$(CONFIG_SND_SOC_P1022_DS) += snd-soc-p1022-ds.o
 
 # Freescale PowerPC SSI/DMA Platform Support
 snd-soc-fsl-ssi-objs := fsl_ssi.o
+snd-soc-fsl-utils-objs := fsl_utils.o
 snd-soc-fsl-dma-objs := fsl_dma.o
 obj-$(CONFIG_SND_SOC_FSL_SSI) += snd-soc-fsl-ssi.o
+obj-$(CONFIG_SND_SOC_FSL_UTILS) += snd-soc-fsl-utils.o
 obj-$(CONFIG_SND_SOC_POWERPC_DMA) += snd-soc-fsl-dma.o
 
 # MPC5200 Platform Support
diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
new file mode 100644
index 0000000..90722aa
--- /dev/null
+++ b/sound/soc/fsl/fsl_utils.c
@@ -0,0 +1,153 @@
+/**
+ * Freescale ALSA SoC Machine driver utility
+ *
+ * Author: Timur Tabi <timur@freescale.com>
+ *
+ * Copyright 2010 Freescale Semiconductor, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/of_i2c.h>
+#include <sound/soc.h>
+
+#include "fsl_utils.h"
+
+/**
+ * get_node_by_phandle_name - get a node by its phandle name
+ *
+ * This function takes a node, the name of a property in that node, and a
+ * compatible string.  Assuming the property is a phandle to another node,
+ * it returns that node, (optionally) if that node is compatible.
+ *
+ * If the property is not a phandle, or the node it points to is not compatible
+ * with the specific string, then NULL is returned.
+ */
+static struct device_node *get_node_by_phandle_name(struct device_node *np,
+	const char *name, const char *compatible)
+{
+	np = of_parse_phandle(np, name, 0);
+	if (!np)
+		return NULL;
+
+	if (!of_device_is_compatible(np, compatible)) {
+		of_node_put(np);
+		return NULL;
+	}
+
+	return np;
+}
+
+/**
+ * get_parent_cell_index -- return the cell-index of the parent of a node
+ *
+ * Return the value of the cell-index property of the parent of the given
+ * node.  This is used for DMA channel nodes that need to know the DMA ID
+ * of the controller they are on.
+ */
+static int get_parent_cell_index(struct device_node *np)
+{
+	struct device_node *parent = of_get_parent(np);
+	const u32 *iprop;
+	int ret = -1;
+
+	if (!parent)
+		return -1;
+
+	iprop = of_get_property(parent, "cell-index", NULL);
+	if (iprop)
+		ret = be32_to_cpup(iprop);
+
+	of_node_put(parent);
+
+	return ret;
+}
+
+/**
+ * fsl_asoc_get_codec_dev_name - determine the dev_name for a codec node
+ *
+ * This function determines the dev_name for an I2C node.  This is the name
+ * that would be returned by dev_name() if this device_node were part of a
+ * 'struct device'  It's ugly and hackish, but it works.
+ *
+ * The dev_name for such devices include the bus number and I2C address. For
+ * example, "cs4270.0-004f".
+ */
+int fsl_asoc_get_codec_dev_name(struct device_node *np, char *buf, size_t len)
+{
+	const u32 *iprop;
+	int addr;
+	char temp[DAI_NAME_SIZE];
+	struct i2c_client *i2c;
+
+	of_modalias_node(np, temp, DAI_NAME_SIZE);
+
+	iprop = of_get_property(np, "reg", NULL);
+	if (!iprop)
+		return -EINVAL;
+
+	addr = be32_to_cpup(iprop);
+
+	/* We need the adapter number */
+	i2c = of_find_i2c_device_by_node(np);
+	if (!i2c)
+		return -ENODEV;
+
+	snprintf(buf, len, "%s.%u-%04x", temp, i2c->adapter->nr, addr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fsl_asoc_get_codec_dev_name);
+
+int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
+			     const char *name,
+			     struct snd_soc_dai_link *dai,
+			     unsigned int *dma_channel_id,
+			     unsigned int *dma_id)
+{
+	struct resource res;
+	struct device_node *dma_channel_np;
+	const u32 *iprop;
+	int ret;
+
+	dma_channel_np = get_node_by_phandle_name(ssi_np, name,
+						  "fsl,ssi-dma-channel");
+	if (!dma_channel_np)
+		return -EINVAL;
+
+	/* Determine the dev_name for the device_node.  This code mimics the
+	 * behavior of of_device_make_bus_id(). We need this because ASoC uses
+	 * the dev_name() of the device to match the platform (DMA) device with
+	 * the CPU (SSI) device.  It's all ugly and hackish, but it works (for
+	 * now).
+	 *
+	 * dai->platform name should already point to an allocated buffer.
+	 */
+	ret = of_address_to_resource(dma_channel_np, 0, &res);
+	if (ret) {
+		of_node_put(dma_channel_np);
+		return ret;
+	}
+	snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%s",
+		 (unsigned long long) res.start, dma_channel_np->name);
+
+	iprop = of_get_property(dma_channel_np, "cell-index", NULL);
+	if (!iprop) {
+		of_node_put(dma_channel_np);
+		return -EINVAL;
+	}
+
+	*dma_channel_id = be32_to_cpup(iprop);
+	*dma_id = get_parent_cell_index(dma_channel_np);
+	of_node_put(dma_channel_np);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fsl_asoc_get_dma_channel);
+
+MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
+MODULE_DESCRIPTION("Freescale ASoC utility code");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/fsl/fsl_utils.h b/sound/soc/fsl/fsl_utils.h
new file mode 100644
index 0000000..c928a15
--- /dev/null
+++ b/sound/soc/fsl/fsl_utils.h
@@ -0,0 +1,29 @@
+/**
+ * Freescale ALSA SoC Machine driver utility
+ *
+ * Author: Timur Tabi <timur@freescale.com>
+ *
+ * Copyright 2010 Freescale Semiconductor, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef _FSL_UTILS_H
+#define _FSL_UTILS_H
+
+#define DAI_NAME_SIZE	32
+
+struct snd_soc_dai_link;
+struct device_node;
+
+extern int fsl_asoc_get_codec_dev_name(struct device_node *np,
+				       char *buf, size_t len);
+extern int fsl_asoc_get_dma_channel(struct device_node *ssi_np,
+				    const char *name,
+				    struct snd_soc_dai_link *dai,
+				    unsigned int *dma_channel_id,
+				    unsigned int *dma_id);
+
+#endif /* _FSL_UTILS_H */
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index fcf9302..7ead1e5 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -14,18 +14,16 @@
 #include <linux/interrupt.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
-#include <linux/of_i2c.h>
 #include <sound/soc.h>
 #include <asm/fsl_guts.h>
 
 #include "fsl_dma.h"
 #include "fsl_ssi.h"
+#include "fsl_utils.h"
 
 /* There's only one global utilities register */
 static phys_addr_t guts_phys;
 
-#define DAI_NAME_SIZE	32
-
 /**
  * mpc8610_hpcd_data: machine-specific ASoC device data
  *
@@ -181,141 +179,6 @@ static struct snd_soc_ops mpc8610_hpcd_ops = {
 };
 
 /**
- * get_node_by_phandle_name - get a node by its phandle name
- *
- * This function takes a node, the name of a property in that node, and a
- * compatible string.  Assuming the property is a phandle to another node,
- * it returns that node, (optionally) if that node is compatible.
- *
- * If the property is not a phandle, or the node it points to is not compatible
- * with the specific string, then NULL is returned.
- */
-static struct device_node *get_node_by_phandle_name(struct device_node *np,
-					       const char *name,
-					       const char *compatible)
-{
-	const phandle *ph;
-	int len;
-
-	ph = of_get_property(np, name, &len);
-	if (!ph || (len != sizeof(phandle)))
-		return NULL;
-
-	np = of_find_node_by_phandle(*ph);
-	if (!np)
-		return NULL;
-
-	if (compatible && !of_device_is_compatible(np, compatible)) {
-		of_node_put(np);
-		return NULL;
-	}
-
-	return np;
-}
-
-/**
- * get_parent_cell_index -- return the cell-index of the parent of a node
- *
- * Return the value of the cell-index property of the parent of the given
- * node.  This is used for DMA channel nodes that need to know the DMA ID
- * of the controller they are on.
- */
-static int get_parent_cell_index(struct device_node *np)
-{
-	struct device_node *parent = of_get_parent(np);
-	const u32 *iprop;
-
-	if (!parent)
-		return -1;
-
-	iprop = of_get_property(parent, "cell-index", NULL);
-	of_node_put(parent);
-
-	if (!iprop)
-		return -1;
-
-	return be32_to_cpup(iprop);
-}
-
-/**
- * codec_node_dev_name - determine the dev_name for a codec node
- *
- * This function determines the dev_name for an I2C node.  This is the name
- * that would be returned by dev_name() if this device_node were part of a
- * 'struct device'  It's ugly and hackish, but it works.
- *
- * The dev_name for such devices include the bus number and I2C address. For
- * example, "cs4270.0-004f".
- */
-static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
-{
-	const u32 *iprop;
-	int addr;
-	char temp[DAI_NAME_SIZE];
-	struct i2c_client *i2c;
-
-	of_modalias_node(np, temp, DAI_NAME_SIZE);
-
-	iprop = of_get_property(np, "reg", NULL);
-	if (!iprop)
-		return -EINVAL;
-
-	addr = be32_to_cpup(iprop);
-
-	/* We need the adapter number */
-	i2c = of_find_i2c_device_by_node(np);
-	if (!i2c)
-		return -ENODEV;
-
-	snprintf(buf, len, "%s.%u-%04x", temp, i2c->adapter->nr, addr);
-
-	return 0;
-}
-
-static int get_dma_channel(struct device_node *ssi_np,
-			   const char *name,
-			   struct snd_soc_dai_link *dai,
-			   unsigned int *dma_channel_id,
-			   unsigned int *dma_id)
-{
-	struct resource res;
-	struct device_node *dma_channel_np;
-	const u32 *iprop;
-	int ret;
-
-	dma_channel_np = get_node_by_phandle_name(ssi_np, name,
-						  "fsl,ssi-dma-channel");
-	if (!dma_channel_np)
-		return -EINVAL;
-
-	/* Determine the dev_name for the device_node.  This code mimics the
-	 * behavior of of_device_make_bus_id(). We need this because ASoC uses
-	 * the dev_name() of the device to match the platform (DMA) device with
-	 * the CPU (SSI) device.  It's all ugly and hackish, but it works (for
-	 * now).
-	 *
-	 * dai->platform name should already point to an allocated buffer.
-	 */
-	ret = of_address_to_resource(dma_channel_np, 0, &res);
-	if (ret)
-		return ret;
-	snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%s",
-		 (unsigned long long) res.start, dma_channel_np->name);
-
-	iprop = of_get_property(dma_channel_np, "cell-index", NULL);
-	if (!iprop) {
-		of_node_put(dma_channel_np);
-		return -EINVAL;
-	}
-
-	*dma_channel_id = be32_to_cpup(iprop);
-	*dma_id = get_parent_cell_index(dma_channel_np);
-	of_node_put(dma_channel_np);
-
-	return 0;
-}
-
-/**
  * mpc8610_hpcd_probe: platform probe function for the machine driver
  *
  * Although this is a machine driver, the SSI node is the "master" node with
@@ -353,8 +216,8 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 	machine_data->dai[0].ops = &mpc8610_hpcd_ops;
 
 	/* Determine the codec name, it will be used as the codec DAI name */
-	ret = codec_node_dev_name(codec_np, machine_data->codec_name,
-				  DAI_NAME_SIZE);
+	ret = fsl_asoc_get_codec_dev_name(codec_np, machine_data->codec_name,
+					  DAI_NAME_SIZE);
 	if (ret) {
 		dev_err(&pdev->dev, "invalid codec node %s\n",
 			codec_np->full_name);
@@ -458,9 +321,10 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 
 	/* Find the playback DMA channel to use. */
 	machine_data->dai[0].platform_name = machine_data->platform_name[0];
-	ret = get_dma_channel(np, "fsl,playback-dma", &machine_data->dai[0],
-			      &machine_data->dma_channel_id[0],
-			      &machine_data->dma_id[0]);
+	ret = fsl_asoc_get_dma_channel(np, "fsl,playback-dma",
+				       &machine_data->dai[0],
+				       &machine_data->dma_channel_id[0],
+				       &machine_data->dma_id[0]);
 	if (ret) {
 		dev_err(&pdev->dev, "missing/invalid playback DMA phandle\n");
 		goto error;
@@ -468,9 +332,10 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 
 	/* Find the capture DMA channel to use. */
 	machine_data->dai[1].platform_name = machine_data->platform_name[1];
-	ret = get_dma_channel(np, "fsl,capture-dma", &machine_data->dai[1],
-			      &machine_data->dma_channel_id[1],
-			      &machine_data->dma_id[1]);
+	ret = fsl_asoc_get_dma_channel(np, "fsl,capture-dma",
+				       &machine_data->dai[1],
+				       &machine_data->dma_channel_id[1],
+				       &machine_data->dma_id[1]);
 	if (ret) {
 		dev_err(&pdev->dev, "missing/invalid capture DMA phandle\n");
 		goto error;
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index d32ec46..60f7bb8 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -14,12 +14,12 @@
 #include <linux/interrupt.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
-#include <linux/of_i2c.h>
 #include <sound/soc.h>
 #include <asm/fsl_guts.h>
 
 #include "fsl_dma.h"
 #include "fsl_ssi.h"
+#include "fsl_utils.h"
 
 /* P1022-specific PMUXCR and DMUXCR bit definitions */
 
@@ -57,8 +57,6 @@ static inline void guts_set_dmuxcr(struct ccsr_guts_85xx __iomem *guts,
 /* There's only one global utilities register */
 static phys_addr_t guts_phys;
 
-#define DAI_NAME_SIZE	32
-
 /**
  * machine_data: machine-specific ASoC device data
  *
@@ -191,136 +189,6 @@ static struct snd_soc_ops p1022_ds_ops = {
 };
 
 /**
- * get_node_by_phandle_name - get a node by its phandle name
- *
- * This function takes a node, the name of a property in that node, and a
- * compatible string.  Assuming the property is a phandle to another node,
- * it returns that node, (optionally) if that node is compatible.
- *
- * If the property is not a phandle, or the node it points to is not compatible
- * with the specific string, then NULL is returned.
- */
-static struct device_node *get_node_by_phandle_name(struct device_node *np,
-	const char *name, const char *compatible)
-{
-	np = of_parse_phandle(np, name, 0);
-	if (!np)
-		return NULL;
-
-	if (!of_device_is_compatible(np, compatible)) {
-		of_node_put(np);
-		return NULL;
-	}
-
-	return np;
-}
-
-/**
- * get_parent_cell_index -- return the cell-index of the parent of a node
- *
- * Return the value of the cell-index property of the parent of the given
- * node.  This is used for DMA channel nodes that need to know the DMA ID
- * of the controller they are on.
- */
-static int get_parent_cell_index(struct device_node *np)
-{
-	struct device_node *parent = of_get_parent(np);
-	const u32 *iprop;
-	int ret = -1;
-
-	if (!parent)
-		return -1;
-
-	iprop = of_get_property(parent, "cell-index", NULL);
-	if (iprop)
-		ret = be32_to_cpup(iprop);
-
-	of_node_put(parent);
-
-	return ret;
-}
-
-/**
- * codec_node_dev_name - determine the dev_name for a codec node
- *
- * This function determines the dev_name for an I2C node.  This is the name
- * that would be returned by dev_name() if this device_node were part of a
- * 'struct device'  It's ugly and hackish, but it works.
- *
- * The dev_name for such devices include the bus number and I2C address. For
- * example, "cs4270-codec.0-004f".
- */
-static int codec_node_dev_name(struct device_node *np, char *buf, size_t len)
-{
-	const u32 *iprop;
-	int addr;
-	char temp[DAI_NAME_SIZE];
-	struct i2c_client *i2c;
-
-	of_modalias_node(np, temp, DAI_NAME_SIZE);
-
-	iprop = of_get_property(np, "reg", NULL);
-	if (!iprop)
-		return -EINVAL;
-
-	addr = be32_to_cpup(iprop);
-
-	/* We need the adapter number */
-	i2c = of_find_i2c_device_by_node(np);
-	if (!i2c)
-		return -ENODEV;
-
-	snprintf(buf, len, "%s.%u-%04x", temp, i2c->adapter->nr, addr);
-
-	return 0;
-}
-
-static int get_dma_channel(struct device_node *ssi_np,
-			   const char *name,
-			   struct snd_soc_dai_link *dai,
-			   unsigned int *dma_channel_id,
-			   unsigned int *dma_id)
-{
-	struct resource res;
-	struct device_node *dma_channel_np;
-	const u32 *iprop;
-	int ret;
-
-	dma_channel_np = get_node_by_phandle_name(ssi_np, name,
-						  "fsl,ssi-dma-channel");
-	if (!dma_channel_np)
-		return -EINVAL;
-
-	/* Determine the dev_name for the device_node.  This code mimics the
-	 * behavior of of_device_make_bus_id(). We need this because ASoC uses
-	 * the dev_name() of the device to match the platform (DMA) device with
-	 * the CPU (SSI) device.  It's all ugly and hackish, but it works (for
-	 * now).
-	 *
-	 * dai->platform name should already point to an allocated buffer.
-	 */
-	ret = of_address_to_resource(dma_channel_np, 0, &res);
-	if (ret) {
-		of_node_put(dma_channel_np);
-		return ret;
-	}
-	snprintf((char *)dai->platform_name, DAI_NAME_SIZE, "%llx.%s",
-		 (unsigned long long) res.start, dma_channel_np->name);
-
-	iprop = of_get_property(dma_channel_np, "cell-index", NULL);
-	if (!iprop) {
-		of_node_put(dma_channel_np);
-		return -EINVAL;
-	}
-
-	*dma_channel_id = be32_to_cpup(iprop);
-	*dma_id = get_parent_cell_index(dma_channel_np);
-	of_node_put(dma_channel_np);
-
-	return 0;
-}
-
-/**
  * p1022_ds_probe: platform probe function for the machine driver
  *
  * Although this is a machine driver, the SSI node is the "master" node with
@@ -358,7 +226,8 @@ static int p1022_ds_probe(struct platform_device *pdev)
 	mdata->dai[0].ops = &p1022_ds_ops;
 
 	/* Determine the codec name, it will be used as the codec DAI name */
-	ret = codec_node_dev_name(codec_np, mdata->codec_name, DAI_NAME_SIZE);
+	ret = fsl_asoc_get_codec_dev_name(codec_np, mdata->codec_name,
+					  DAI_NAME_SIZE);
 	if (ret) {
 		dev_err(&pdev->dev, "invalid codec node %s\n",
 			codec_np->full_name);
@@ -454,9 +323,9 @@ static int p1022_ds_probe(struct platform_device *pdev)
 
 	/* Find the playback DMA channel to use. */
 	mdata->dai[0].platform_name = mdata->platform_name[0];
-	ret = get_dma_channel(np, "fsl,playback-dma", &mdata->dai[0],
-			      &mdata->dma_channel_id[0],
-			      &mdata->dma_id[0]);
+	ret = fsl_asoc_get_dma_channel(np, "fsl,playback-dma", &mdata->dai[0],
+				       &mdata->dma_channel_id[0],
+				       &mdata->dma_id[0]);
 	if (ret) {
 		dev_err(&pdev->dev, "missing/invalid playback DMA phandle\n");
 		goto error;
@@ -464,9 +333,9 @@ static int p1022_ds_probe(struct platform_device *pdev)
 
 	/* Find the capture DMA channel to use. */
 	mdata->dai[1].platform_name = mdata->platform_name[1];
-	ret = get_dma_channel(np, "fsl,capture-dma", &mdata->dai[1],
-			      &mdata->dma_channel_id[1],
-			      &mdata->dma_id[1]);
+	ret = fsl_asoc_get_dma_channel(np, "fsl,capture-dma", &mdata->dai[1],
+				       &mdata->dma_channel_id[1],
+				       &mdata->dma_id[1]);
 	if (ret) {
 		dev_err(&pdev->dev, "missing/invalid capture DMA phandle\n");
 		goto error;
-- 
1.7.5.4
