From: olivier.moysan@st.com (Olivier Moysan)
Date: Thu, 19 Oct 2017 15:03:23 +0200
Subject: [INTERNAL][PATCH 7/7] ASoC: stm32: sai: Add synchronization support
In-Reply-To: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
References: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1508418203-16840-8-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Synchronization support for STM32 SAI.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai.c     | 160 ++++++++++++++++++++++++++++++++++++++++--
 sound/soc/stm/stm32_sai.h     |  22 +++++-
 sound/soc/stm/stm32_sai_sub.c |  95 +++++++++++++++++++++++++
 3 files changed, 269 insertions(+), 8 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 5fe878ac..d6f71a3 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -16,6 +16,7 @@
  * details.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/module.h>
@@ -27,6 +28,16 @@
 
 #include "stm32_sai.h"
 
+static LIST_HEAD(sync_providers);
+static DEFINE_MUTEX(sync_mutex);
+
+struct sync_provider {
+	struct list_head link;
+	struct device_node *node;
+	int  (*sync_conf)(void *data, int synco);
+	void *data;
+};
+
 static const struct stm32_sai_conf stm32_sai_conf_f4 = {
 	.version = SAI_STM32F4,
 };
@@ -41,23 +52,143 @@
 	{}
 };
 
+static int stm32_sai_sync_conf_client(struct stm32_sai_data *sai, int synci)
+{
+	int ret;
+
+	/* Enable peripheral clock to allow GCR register access */
+	ret = clk_prepare_enable(sai->pclk);
+	if (ret) {
+		dev_err(&sai->pdev->dev, "failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
+	writel_relaxed(FIELD_PREP(SAI_GCR_SYNCIN_MASK, (synci - 1)), sai->base);
+
+	clk_disable_unprepare(sai->pclk);
+
+	return 0;
+}
+
+static int stm32_sai_sync_conf_provider(void *data, int synco)
+{
+	struct stm32_sai_data *sai = (struct stm32_sai_data *)data;
+	u32 prev_synco;
+	int ret;
+
+	/* Enable peripheral clock to allow GCR register access */
+	ret = clk_prepare_enable(sai->pclk);
+	if (ret) {
+		dev_err(&sai->pdev->dev, "failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(&sai->pdev->dev, "Set %s%s as synchro provider\n",
+		sai->pdev->dev.of_node->name,
+		synco == STM_SAI_SYNC_OUT_A ? "A" : "B");
+
+	prev_synco = FIELD_GET(SAI_GCR_SYNCOUT_MASK, readl_relaxed(sai->base));
+	if (prev_synco != STM_SAI_SYNC_OUT_NONE && synco != prev_synco) {
+		dev_err(&sai->pdev->dev, "%s%s already set as sync provider\n",
+			sai->pdev->dev.of_node->name,
+			prev_synco == STM_SAI_SYNC_OUT_A ? "A" : "B");
+		clk_disable_unprepare(sai->pclk);
+		return -EINVAL;
+	}
+
+	writel_relaxed(FIELD_PREP(SAI_GCR_SYNCOUT_MASK, synco), sai->base);
+
+	clk_disable_unprepare(sai->pclk);
+
+	return 0;
+}
+
+static int stm32_sai_set_sync_provider(struct device_node *np, int synco)
+{
+	struct sync_provider *provider;
+	int ret;
+
+	mutex_lock(&sync_mutex);
+	list_for_each_entry(provider, &sync_providers, link) {
+		if (provider->node == np) {
+			ret = provider->sync_conf(provider->data, synco);
+			mutex_unlock(&sync_mutex);
+			return ret;
+		}
+	}
+	mutex_unlock(&sync_mutex);
+
+	/* SAI sync provider not found */
+	return -ENODEV;
+}
+
+static int stm32_sai_set_sync(struct stm32_sai_data *sai,
+			      struct device_node *np_provider,
+			      int synco, int synci)
+{
+	int ret;
+
+	/* Configure sync client */
+	stm32_sai_sync_conf_client(sai, synci);
+
+	/* Configure sync provider */
+	ret = stm32_sai_set_sync_provider(np_provider, synco);
+
+	return ret;
+}
+
+static int stm32_sai_sync_add_provider(struct platform_device *pdev,
+				       void *data)
+{
+	struct sync_provider *sp;
+
+	sp = devm_kzalloc(&pdev->dev, sizeof(*sp), GFP_KERNEL);
+	if (!sp)
+		return -ENOMEM;
+
+	sp->node = of_node_get(pdev->dev.of_node);
+	sp->data = data;
+	sp->sync_conf = &stm32_sai_sync_conf_provider;
+
+	mutex_lock(&sync_mutex);
+	list_add(&sp->link, &sync_providers);
+	mutex_unlock(&sync_mutex);
+
+	return 0;
+}
+
+static void stm32_sai_sync_del_provider(struct device_node *np)
+{
+	struct sync_provider *sp;
+
+	mutex_lock(&sync_mutex);
+	list_for_each_entry(sp, &sync_providers, link) {
+		if (sp->node == np) {
+			list_del(&sp->link);
+			of_node_put(sp->node);
+			break;
+		}
+	}
+	mutex_unlock(&sync_mutex);
+}
+
 static int stm32_sai_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct stm32_sai_data *sai;
 	struct reset_control *rst;
 	struct resource *res;
-	void __iomem *base;
 	const struct of_device_id *of_id;
+	int ret;
 
 	sai = devm_kzalloc(&pdev->dev, sizeof(*sai), GFP_KERNEL);
 	if (!sai)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+	sai->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(sai->base))
+		return PTR_ERR(sai->base);
 
 	of_id = of_match_device(stm32_sai_ids, &pdev->dev);
 	if (of_id)
@@ -65,6 +196,14 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	else
 		return -EINVAL;
 
+	if (!STM_SAI_IS_F4(sai)) {
+		sai->pclk = devm_clk_get(&pdev->dev, "pclk");
+		if (IS_ERR(sai->pclk)) {
+			dev_err(&pdev->dev, "missing bus clock pclk\n");
+			return PTR_ERR(sai->pclk);
+		}
+	}
+
 	sai->clk_x8k = devm_clk_get(&pdev->dev, "x8k");
 	if (IS_ERR(sai->clk_x8k)) {
 		dev_err(&pdev->dev, "missing x8k parent clock\n");
@@ -92,16 +231,27 @@ static int stm32_sai_probe(struct platform_device *pdev)
 		reset_control_deassert(rst);
 	}
 
+	ret = stm32_sai_sync_add_provider(pdev, sai);
+	if (ret < 0)
+		return ret;
+	sai->set_sync = &stm32_sai_set_sync;
+
 	sai->pdev = pdev;
 	platform_set_drvdata(pdev, sai);
 
-	return of_platform_populate(np, NULL, NULL, &pdev->dev);
+	ret = of_platform_populate(np, NULL, NULL, &pdev->dev);
+	if (ret < 0)
+		stm32_sai_sync_del_provider(np);
+
+	return ret;
 }
 
 static int stm32_sai_remove(struct platform_device *pdev)
 {
 	of_platform_depopulate(&pdev->dev);
 
+	stm32_sai_sync_del_provider(pdev->dev.of_node);
+
 	return 0;
 }
 
diff --git a/sound/soc/stm/stm32_sai.h b/sound/soc/stm/stm32_sai.h
index 889974dc..bb062e7 100644
--- a/sound/soc/stm/stm32_sai.h
+++ b/sound/soc/stm/stm32_sai.h
@@ -16,9 +16,11 @@
  * details.
  */
 
+#include <linux/bitfield.h>
+
 /******************** SAI Register Map **************************************/
 
-/* common register */
+/* Global configuration register */
 #define STM_SAI_GCR		0x00
 
 /* Sub-block A&B registers offsets, relative to A&B sub-block addresses */
@@ -37,12 +39,13 @@
 
 /******************** Bit definition for SAI_GCR register *******************/
 #define SAI_GCR_SYNCIN_SHIFT	0
+#define SAI_GCR_SYNCIN_WDTH	2
 #define SAI_GCR_SYNCIN_MASK	GENMASK(1, SAI_GCR_SYNCIN_SHIFT)
-#define SAI_GCR_SYNCIN_SET(x)	((x) << SAI_GCR_SYNCIN_SHIFT)
+#define SAI_GCR_SYNCIN_MAX	FIELD_GET(SAI_GCR_SYNCIN_MASK,\
+				SAI_GCR_SYNCIN_MASK)
 
 #define SAI_GCR_SYNCOUT_SHIFT	4
 #define SAI_GCR_SYNCOUT_MASK	GENMASK(5, SAI_GCR_SYNCOUT_SHIFT)
-#define SAI_GCR_SYNCOUT_SET(x)	((x) << SAI_GCR_SYNCOUT_SHIFT)
 
 /******************* Bit definition for SAI_XCR1 register *******************/
 #define SAI_XCR1_RX_TX_SHIFT	0
@@ -231,6 +234,12 @@
 #define STM_SAI_IS_F4(ip)	((ip)->conf->version == SAI_STM32F4)
 #define STM_SAI_IS_H7(ip)	((ip)->conf->version == SAI_STM32H7)
 
+enum stm32_sai_syncout {
+	STM_SAI_SYNC_OUT_NONE,
+	STM_SAI_SYNC_OUT_A,
+	STM_SAI_SYNC_OUT_B,
+};
+
 enum stm32_sai_version {
 	SAI_STM32F4,
 	SAI_STM32H7
@@ -247,15 +256,22 @@ struct stm32_sai_conf {
 /**
  * struct stm32_sai_data - private data of SAI instance driver
  * @pdev: device data pointer
+ * @base: common register bank virtual base address
+ * @pclk: SAI bus clock
  * @clk_x8k: SAI parent clock for sampling frequencies multiple of 8kHz
  * @clk_x11k: SAI parent clock for sampling frequencies multiple of 11kHz
  * @version: SOC version
  * @irq: SAI interrupt line
+ * @set_sync: pointer to synchro mode configuration callback
  */
 struct stm32_sai_data {
 	struct platform_device *pdev;
+	void __iomem *base;
+	struct clk *pclk;
 	struct clk *clk_x8k;
 	struct clk *clk_x11k;
 	struct stm32_sai_conf *conf;
 	int irq;
+	int (*set_sync)(struct stm32_sai_data *sai,
+			struct device_node *np_provider, int synco, int synci);
 };
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index fd7dc77..150ad54 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -55,6 +55,12 @@
 #define STM_SAI_IS_SUB_B(x)	((x)->id == STM_SAI_B_ID)
 #define STM_SAI_BLOCK_NAME(x)	(((x)->id == STM_SAI_A_ID) ? "A" : "B")
 
+#define SAI_SYNC_NONE		0x0
+#define SAI_SYNC_INTERNAL	0x1
+#define SAI_SYNC_EXTERNAL	0x2
+
+#define STM_SAI_HAS_EXT_SYNC(x) (!STM_SAI_IS_F4(sai->pdata))
+
 /**
  * struct stm32_sai_sub_data - private data of SAI sub block (block A or B)
  * @pdev: device data pointer
@@ -65,6 +71,7 @@
  * @cpu_dai: DAI runtime data pointer
  * @substream: PCM substream data pointer
  * @pdata: SAI block parent data pointer
+ * @np_sync_provider: synchronization provider node
  * @sai_ck: kernel clock feeding the SAI clock generator
  * @phys_addr: SAI registers physical base address
  * @mclk_rate: SAI block master clock frequency (Hz). set at init
@@ -73,6 +80,8 @@
  * @master: SAI block mode flag. (true=master, false=slave) set at init
  * @fmt: SAI block format. relevant only for custom protocols. set at init
  * @sync: SAI block synchronization mode. (none, internal or external)
+ * @synco: SAI block ext sync source (provider setting). (none, sub-block A/B)
+ * @synci: SAI block ext sync source (client setting). (SAI sync provider index)
  * @fs_length: frame synchronization length. depends on protocol settings
  * @slots: rx or tx slot number
  * @slot_width: rx or tx slot width in bits
@@ -88,6 +97,7 @@ struct stm32_sai_sub_data {
 	struct snd_soc_dai *cpu_dai;
 	struct snd_pcm_substream *substream;
 	struct stm32_sai_data *pdata;
+	struct device_node *np_sync_provider;
 	struct clk *sai_ck;
 	dma_addr_t phys_addr;
 	unsigned int mclk_rate;
@@ -96,6 +106,8 @@ struct stm32_sai_sub_data {
 	bool master;
 	int fmt;
 	int sync;
+	int synco;
+	int synci;
 	int fs_length;
 	int slots;
 	int slot_width;
@@ -387,6 +399,14 @@ static int stm32_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
 			fmt & SND_SOC_DAIFMT_MASTER_MASK);
 		return -EINVAL;
 	}
+
+	/* Set slave mode if sub-block is synchronized with another SAI */
+	if (sai->sync) {
+		dev_dbg(cpu_dai->dev, "Synchronized SAI configured as slave\n");
+		cr1 |= SAI_XCR1_SLAVE;
+		sai->master = false;
+	}
+
 	cr1_mask |= SAI_XCR1_SLAVE;
 
 	/* do not generate master by default */
@@ -749,6 +769,16 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	if (STM_SAI_IS_CAPTURE(sai))
 		cr1 |= SAI_XCR1_RX_TX;
 
+	/* Configure synchronization */
+	if (sai->sync == SAI_SYNC_EXTERNAL) {
+		/* Configure synchro client and provider */
+		sai->pdata->set_sync(sai->pdata, sai->np_sync_provider,
+				     sai->synco, sai->synci);
+	}
+
+	cr1_mask |= SAI_XCR1_SYNCEN_MASK;
+	cr1 |= SAI_XCR1_SYNCEN_SET(sai->sync);
+
 	return regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, cr1_mask, cr1);
 }
 
@@ -835,6 +865,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *res;
 	void __iomem *base;
+	struct of_phandle_args args;
+	int ret;
 
 	if (!np)
 		return -ENODEV;
@@ -868,6 +900,69 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	/* Get synchronization property */
+	args.np = NULL;
+	ret = of_parse_phandle_with_fixed_args(np, "st,sync", 1, 0, &args);
+	if (ret < 0  && ret != -ENOENT) {
+		dev_err(&pdev->dev, "Failed to get st,sync property\n");
+		return ret;
+	}
+
+	sai->sync = SAI_SYNC_NONE;
+	if (args.np) {
+		if (args.np == np) {
+			dev_err(&pdev->dev, "%s sync own reference\n",
+				np->name);
+			of_node_put(args.np);
+			return -EINVAL;
+		}
+
+		sai->np_sync_provider  = of_get_parent(args.np);
+		if (!sai->np_sync_provider) {
+			dev_err(&pdev->dev, "%s parent node not found\n",
+				np->name);
+			of_node_put(args.np);
+			return -ENODEV;
+		}
+
+		sai->sync = SAI_SYNC_INTERNAL;
+		if (sai->np_sync_provider != sai->pdata->pdev->dev.of_node) {
+			if (!STM_SAI_HAS_EXT_SYNC(sai)) {
+				dev_err(&pdev->dev,
+					"External synchro not supported\n");
+				of_node_put(args.np);
+				return -EINVAL;
+			}
+			sai->sync = SAI_SYNC_EXTERNAL;
+
+			sai->synci = args.args[0];
+			if (sai->synci < 1 ||
+			    (sai->synci > (SAI_GCR_SYNCIN_MAX + 1))) {
+				dev_err(&pdev->dev, "Wrong SAI index\n");
+				of_node_put(args.np);
+				return -EINVAL;
+			}
+
+			if (of_property_match_string(args.np, "compatible",
+						     "st,stm32-sai-sub-a") >= 0)
+				sai->synco = STM_SAI_SYNC_OUT_A;
+
+			if (of_property_match_string(args.np, "compatible",
+						     "st,stm32-sai-sub-b") >= 0)
+				sai->synco = STM_SAI_SYNC_OUT_B;
+
+			if (!sai->synco) {
+				dev_err(&pdev->dev, "Unknown SAI sub-block\n");
+				of_node_put(args.np);
+				return -EINVAL;
+			}
+		}
+
+		dev_dbg(&pdev->dev, "%s synchronized with %s\n",
+			pdev->name, args.np->full_name);
+	}
+
+	of_node_put(args.np);
 	sai->sai_ck = devm_clk_get(&pdev->dev, "sai_ck");
 	if (IS_ERR(sai->sai_ck)) {
 		dev_err(&pdev->dev, "Missing kernel clock sai_ck\n");
-- 
1.9.1
