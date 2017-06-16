From: olivier.moysan@st.com (olivier moysan)
Date: Fri, 16 Jun 2017 14:16:24 +0200
Subject: [PATCH 2/2] ASoC: stm32: sai: add h7 support
In-Reply-To: <1497615384-7407-1-git-send-email-olivier.moysan@st.com>
References: <1497615384-7407-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1497615384-7407-3-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support of SAI on STM32H7 family.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai.c     | 13 +++++-
 sound/soc/stm/stm32_sai.h     | 72 ++++++++++++++++++++++++++++++---
 sound/soc/stm/stm32_sai_sub.c | 92 ++++++++++++++++++++++++++++++++++++-------
 3 files changed, 155 insertions(+), 22 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 6159d66..f771331 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -27,8 +27,17 @@
 
 #include "stm32_sai.h"
 
+static const struct stm32_sai_conf stm32_sai_conf_f4 = {
+	.version = SAI_STM32F4,
+};
+
+static const struct stm32_sai_conf stm32_sai_conf_h7 = {
+	.version = SAI_STM32H7,
+};
+
 static const struct of_device_id stm32_sai_ids[] = {
-	{ .compatible = "st,stm32f4-sai", .data = (void *)SAI_STM32F4 },
+	{ .compatible = "st,stm32f4-sai", .data = (void *)&stm32_sai_conf_f4 },
+	{ .compatible = "st,stm32h7-sai", .data = (void *)&stm32_sai_conf_h7 },
 	{}
 };
 
@@ -52,7 +61,7 @@ static int stm32_sai_probe(struct platform_device *pdev)
 
 	of_id = of_match_device(stm32_sai_ids, &pdev->dev);
 	if (of_id)
-		sai->version = (enum stm32_sai_version)of_id->data;
+		sai->conf = (struct stm32_sai_conf *)of_id->data;
 	else
 		return -EINVAL;
 
diff --git a/sound/soc/stm/stm32_sai.h b/sound/soc/stm/stm32_sai.h
index 270be93..889974dc 100644
--- a/sound/soc/stm/stm32_sai.h
+++ b/sound/soc/stm/stm32_sai.h
@@ -31,6 +31,10 @@
 #define STM_SAI_CLRFR_REGX	0x18
 #define STM_SAI_DR_REGX		0x1C
 
+/* Sub-block A registers, relative to sub-block A address */
+#define STM_SAI_PDMCR_REGX	0x40
+#define STM_SAI_PDMLY_REGX	0x44
+
 /******************** Bit definition for SAI_GCR register *******************/
 #define SAI_GCR_SYNCIN_SHIFT	0
 #define SAI_GCR_SYNCIN_MASK	GENMASK(1, SAI_GCR_SYNCIN_SHIFT)
@@ -75,10 +79,11 @@
 #define SAI_XCR1_NODIV		BIT(SAI_XCR1_NODIV_SHIFT)
 
 #define SAI_XCR1_MCKDIV_SHIFT	20
-#define SAI_XCR1_MCKDIV_WIDTH	4
-#define SAI_XCR1_MCKDIV_MASK	GENMASK(24, SAI_XCR1_MCKDIV_SHIFT)
+#define SAI_XCR1_MCKDIV_WIDTH(x)	(((x) == SAI_STM32F4) ? 4 : 6)
+#define SAI_XCR1_MCKDIV_MASK(x) GENMASK((SAI_XCR1_MCKDIV_SHIFT + (x) - 1),\
+				SAI_XCR1_MCKDIV_SHIFT)
 #define SAI_XCR1_MCKDIV_SET(x)	((x) << SAI_XCR1_MCKDIV_SHIFT)
-#define SAI_XCR1_MCKDIV_MAX	((1 << SAI_XCR1_MCKDIV_WIDTH) - 1)
+#define SAI_XCR1_MCKDIV_MAX(x)	((1 << SAI_XCR1_MCKDIV_WIDTH(x)) - 1)
 
 #define SAI_XCR1_OSR_SHIFT	26
 #define SAI_XCR1_OSR		BIT(SAI_XCR1_OSR_SHIFT)
@@ -178,8 +183,65 @@
 #define SAI_XCLRFR_SHIFT	0
 #define SAI_XCLRFR_MASK		GENMASK(6, SAI_XCLRFR_SHIFT)
 
+/****************** Bit definition for SAI_PDMCR register ******************/
+#define SAI_PDMCR_PDMEN		BIT(0)
+
+#define SAI_PDMCR_MICNBR_SHIFT	4
+#define SAI_PDMCR_MICNBR_MASK	GENMASK(5, SAI_PDMCR_MICNBR_SHIFT)
+#define SAI_PDMCR_MICNBR_SET(x)	((x) << SAI_PDMCR_MICNBR_SHIFT)
+
+#define SAI_PDMCR_CKEN1		BIT(8)
+#define SAI_PDMCR_CKEN2		BIT(9)
+#define SAI_PDMCR_CKEN3		BIT(10)
+#define SAI_PDMCR_CKEN4		BIT(11)
+
+/****************** Bit definition for (SAI_PDMDLY register ****************/
+#define SAI_PDMDLY_1L_SHIFT	0
+#define SAI_PDMDLY_1L_MASK	GENMASK(2, SAI_PDMDLY_1L_SHIFT)
+#define SAI_PDMDLY_1L_WIDTH	3
+
+#define SAI_PDMDLY_1R_SHIFT	4
+#define SAI_PDMDLY_1R_MASK	GENMASK(6, SAI_PDMDLY_1R_SHIFT)
+#define SAI_PDMDLY_1R_WIDTH	3
+
+#define SAI_PDMDLY_2L_SHIFT	8
+#define SAI_PDMDLY_2L_MASK	GENMASK(10, SAI_PDMDLY_2L_SHIFT)
+#define SAI_PDMDLY_2L_WIDTH	3
+
+#define SAI_PDMDLY_2R_SHIFT	12
+#define SAI_PDMDLY_2R_MASK	GENMASK(14, SAI_PDMDLY_2R_SHIFT)
+#define SAI_PDMDLY_2R_WIDTH	3
+
+#define SAI_PDMDLY_3L_SHIFT	16
+#define SAI_PDMDLY_3L_MASK	GENMASK(18, SAI_PDMDLY_3L_SHIFT)
+#define SAI_PDMDLY_3L_WIDTH	3
+
+#define SAI_PDMDLY_3R_SHIFT	20
+#define SAI_PDMDLY_3R_MASK	GENMASK(22, SAI_PDMDLY_3R_SHIFT)
+#define SAI_PDMDLY_3R_WIDTH	3
+
+#define SAI_PDMDLY_4L_SHIFT	24
+#define SAI_PDMDLY_4L_MASK	GENMASK(26, SAI_PDMDLY_4L_SHIFT)
+#define SAI_PDMDLY_4L_WIDTH	3
+
+#define SAI_PDMDLY_4R_SHIFT	28
+#define SAI_PDMDLY_4R_MASK	GENMASK(30, SAI_PDMDLY_4R_SHIFT)
+#define SAI_PDMDLY_4R_WIDTH	3
+
+#define STM_SAI_IS_F4(ip)	((ip)->conf->version == SAI_STM32F4)
+#define STM_SAI_IS_H7(ip)	((ip)->conf->version == SAI_STM32H7)
+
 enum stm32_sai_version {
-	SAI_STM32F4
+	SAI_STM32F4,
+	SAI_STM32H7
+};
+
+/**
+ * struct stm32_sai_conf - SAI configuration
+ * @version: SAI version
+ */
+struct stm32_sai_conf {
+	int version;
 };
 
 /**
@@ -194,6 +256,6 @@ struct stm32_sai_data {
 	struct platform_device *pdev;
 	struct clk *clk_x8k;
 	struct clk *clk_x11k;
-	int version;
+	struct stm32_sai_conf *conf;
 	int irq;
 };
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index ce48c02..ba3fdc7 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -51,12 +51,15 @@
 #define STM_SAI_A_ID		0x0
 #define STM_SAI_B_ID		0x1
 
+#define STM_SAI_IS_SUB_A(x)	((x)->id == STM_SAI_A_ID)
+#define STM_SAI_IS_SUB_B(x)	((x)->id == STM_SAI_B_ID)
 #define STM_SAI_BLOCK_NAME(x)	(((x)->id == STM_SAI_A_ID) ? "A" : "B")
 
 /**
  * struct stm32_sai_sub_data - private data of SAI sub block (block A or B)
  * @pdev: device data pointer
  * @regmap: SAI register map pointer
+ * @regmap_config: SAI sub block register map configuration pointer
  * @dma_params: dma configuration data for rx or tx channel
  * @cpu_dai_drv: DAI driver data pointer
  * @cpu_dai: DAI runtime data pointer
@@ -79,6 +82,7 @@
 struct stm32_sai_sub_data {
 	struct platform_device *pdev;
 	struct regmap *regmap;
+	const struct regmap_config *regmap_config;
 	struct snd_dmaengine_dai_dma_data dma_params;
 	struct snd_soc_dai_driver *cpu_dai_drv;
 	struct snd_soc_dai *cpu_dai;
@@ -118,6 +122,8 @@ static bool stm32_sai_sub_readable_reg(struct device *dev, unsigned int reg)
 	case STM_SAI_SR_REGX:
 	case STM_SAI_CLRFR_REGX:
 	case STM_SAI_DR_REGX:
+	case STM_SAI_PDMCR_REGX:
+	case STM_SAI_PDMLY_REGX:
 		return true;
 	default:
 		return false;
@@ -145,13 +151,15 @@ static bool stm32_sai_sub_writeable_reg(struct device *dev, unsigned int reg)
 	case STM_SAI_SR_REGX:
 	case STM_SAI_CLRFR_REGX:
 	case STM_SAI_DR_REGX:
+	case STM_SAI_PDMCR_REGX:
+	case STM_SAI_PDMLY_REGX:
 		return true;
 	default:
 		return false;
 	}
 }
 
-static const struct regmap_config stm32_sai_sub_regmap_config = {
+static const struct regmap_config stm32_sai_sub_regmap_config_f4 = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
@@ -162,6 +170,17 @@ static bool stm32_sai_sub_writeable_reg(struct device *dev, unsigned int reg)
 	.fast_io = true,
 };
 
+static const struct regmap_config stm32_sai_sub_regmap_config_h7 = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = STM_SAI_PDMLY_REGX,
+	.readable_reg = stm32_sai_sub_readable_reg,
+	.volatile_reg = stm32_sai_sub_volatile_reg,
+	.writeable_reg = stm32_sai_sub_writeable_reg,
+	.fast_io = true,
+};
+
 static irqreturn_t stm32_sai_isr(int irq, void *devid)
 {
 	struct stm32_sai_sub_data *sai = (struct stm32_sai_sub_data *)devid;
@@ -551,7 +570,8 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	int cr1, mask, div = 0;
-	int sai_clk_rate, ret;
+	int sai_clk_rate, mclk_ratio, den, ret;
+	int version = sai->pdata->conf->version;
 
 	if (!sai->mclk_rate) {
 		dev_err(cpu_dai->dev, "Mclk rate is null\n");
@@ -564,22 +584,54 @@ static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 		clk_set_parent(sai->sai_ck, sai->pdata->clk_x8k);
 	sai_clk_rate = clk_get_rate(sai->sai_ck);
 
-	/*
-	 * mclk_rate = 256 * fs
-	 * MCKDIV = 0 if sai_ck < 3/2 * mclk_rate
-	 * MCKDIV = sai_ck / (2 * mclk_rate) otherwise
-	 */
-	if (2 * sai_clk_rate >= 3 * sai->mclk_rate)
-		div = DIV_ROUND_CLOSEST(sai_clk_rate, 2 * sai->mclk_rate);
-
-	if (div > SAI_XCR1_MCKDIV_MAX) {
+	if (STM_SAI_IS_F4(sai->pdata)) {
+		/*
+		 * mclk_rate = 256 * fs
+		 * MCKDIV = 0 if sai_ck < 3/2 * mclk_rate
+		 * MCKDIV = sai_ck / (2 * mclk_rate) otherwise
+		 */
+		if (2 * sai_clk_rate >= 3 * sai->mclk_rate)
+			div = DIV_ROUND_CLOSEST(sai_clk_rate,
+						2 * sai->mclk_rate);
+	} else {
+		/*
+		 * TDM mode :
+		 *   mclk on
+		 *      MCKDIV = sai_ck / (ws x 256)	(NOMCK=0. OSR=0)
+		 *      MCKDIV = sai_ck / (ws x 512)	(NOMCK=0. OSR=1)
+		 *   mclk off
+		 *      MCKDIV = sai_ck / (frl x ws)	(NOMCK=1)
+		 * Note: NOMCK/NODIV correspond to same bit.
+		 */
+		if (sai->mclk_rate) {
+			mclk_ratio = sai->mclk_rate / params_rate(params);
+			if (mclk_ratio != 256) {
+				if (mclk_ratio == 512) {
+					mask = SAI_XCR1_OSR;
+					cr1 = SAI_XCR1_OSR;
+				} else {
+					dev_err(cpu_dai->dev,
+						"Wrong mclk ratio %d\n",
+						mclk_ratio);
+					return -EINVAL;
+				}
+			}
+			div = DIV_ROUND_CLOSEST(sai_clk_rate, sai->mclk_rate);
+		} else {
+			/* mclk-fs not set, master clock not active. NOMCK=1 */
+			den = sai->fs_length * params_rate(params);
+			div = DIV_ROUND_CLOSEST(sai_clk_rate, den);
+		}
+	}
+
+	if (div > SAI_XCR1_MCKDIV_MAX(version)) {
 		dev_err(cpu_dai->dev, "Divider %d out of range\n", div);
 		return -EINVAL;
 	}
 	dev_dbg(cpu_dai->dev, "SAI clock %d, divider %d\n", sai_clk_rate, div);
 
-	mask = SAI_XCR1_MCKDIV_MASK;
-	cr1 = SAI_XCR1_MCKDIV_SET(div);
+	mask = SAI_XCR1_MCKDIV_MASK(SAI_XCR1_MCKDIV_WIDTH(version));
+				    cr1 = SAI_XCR1_MCKDIV_SET(div);
 	ret = regmap_update_bits(sai->regmap, STM_SAI_CR1_REGX, mask, cr1);
 	if (ret < 0) {
 		dev_err(cpu_dai->dev, "Failed to update CR1 register\n");
@@ -780,8 +832,18 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 		return PTR_ERR(base);
 
 	sai->phys_addr = res->start;
-	sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "sai_ck", base,
-						&stm32_sai_sub_regmap_config);
+
+	sai->regmap_config = &stm32_sai_sub_regmap_config_f4;
+	/* Note: PDM registers not available for H7 sub-block B */
+	if (STM_SAI_IS_H7(sai->pdata) && STM_SAI_IS_SUB_A(sai))
+		sai->regmap_config = &stm32_sai_sub_regmap_config_h7;
+
+	sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "sai_ck",
+						base, sai->regmap_config);
+	if (IS_ERR(sai->regmap)) {
+		dev_err(&pdev->dev, "Failed to initialize MMIO\n");
+		return PTR_ERR(sai->regmap);
+	}
 
 	/* Get direction property */
 	if (of_property_match_string(np, "dma-names", "tx") >= 0) {
-- 
1.9.1
