From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Mon, 14 Aug 2017 15:06:51 -0700
Subject: [PATCH 3/9] ASoC: cygnus: Allow each port to select its clock source
In-Reply-To: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <1502748417-26417-4-git-send-email-lori.hikichi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ability to assign which of the 3 audio PLL outputs are to be
used by each port. Remove the suspend and resume handlers because the only
thing they were doing was unnecessarily maintaining the clock state.

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
---
 sound/soc/bcm/cygnus-ssp.c | 332 ++++++++++++++-------------------------------
 sound/soc/bcm/cygnus-ssp.h |  15 +-
 2 files changed, 103 insertions(+), 244 deletions(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index 1a57a4e..00fd4dc 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -25,8 +25,6 @@
 
 #include "cygnus-ssp.h"
 
-#define DEFAULT_VCO    1354750204
-
 #define CAPTURE_FCI_ID_BASE 0x180
 #define CYGNUS_SSP_TRISTATE_MASK 0x001fff
 #define CYGNUS_PLLCLKSEL_MASK 0xf
@@ -95,22 +93,10 @@
 #define SPDIF_FORMAT_CFG_OFFSET  0xad8
 #define SPDIF_MCLK_CFG_OFFSET    0xadc
 
-/* AUD_FMM_IOP_PLL_0_xxx regs */
-#define IOP_PLL_0_MACRO_OFFSET    0xb00
-#define IOP_PLL_0_MDIV_Ch0_OFFSET 0xb14
-#define IOP_PLL_0_MDIV_Ch1_OFFSET 0xb18
-#define IOP_PLL_0_MDIV_Ch2_OFFSET 0xb1c
-
-#define IOP_PLL_0_ACTIVE_MDIV_Ch0_OFFSET 0xb30
-#define IOP_PLL_0_ACTIVE_MDIV_Ch1_OFFSET 0xb34
-#define IOP_PLL_0_ACTIVE_MDIV_Ch2_OFFSET 0xb38
-
-/* AUD_FMM_IOP_xxx regs */
-#define IOP_PLL_0_CONTROL_OFFSET     0xb04
-#define IOP_PLL_0_USER_NDIV_OFFSET   0xb08
-#define IOP_PLL_0_ACTIVE_NDIV_OFFSET 0xb20
-#define IOP_PLL_0_RESET_OFFSET       0xb5c
 
+/*--------------------------------------------
+ * Register offsets for i2s_in io space
+ */
 /* AUD_FMM_IOP_IN_I2S_xxx regs */
 #define IN_I2S_0_STREAM_CFG_OFFSET 0x00
 #define IN_I2S_0_CFG_OFFSET        0x04
@@ -173,12 +159,6 @@
 #define SPDIF_0_OUT_DITHER_ENA     3
 #define SPDIF_0_OUT_STREAM_ENA    31
 
-/* AUD_FMM_IOP_PLL_0_USER */
-#define IOP_PLL_0_USER_NDIV_FRAC   10
-
-/* AUD_FMM_IOP_PLL_0_ACTIVE */
-#define IOP_PLL_0_ACTIVE_NDIV_FRAC 10
-
 
 #define INIT_SSP_REGS(num) (struct cygnus_ssp_regs){ \
 		.i2s_stream_cfg = OUT_I2S_ ##num## _STREAM_CFG_OFFSET, \
@@ -193,41 +173,6 @@
 		.bf_sourcech_grp = BF_SRC_GRP ##num## _OFFSET \
 }
 
-struct pll_macro_entry {
-	u32 mclk;
-	u32 pll_ch_num;
-};
-
-/*
- * PLL has 3 output channels (1x, 2x, and 4x). Below are
- * the common MCLK frequencies used by audio driver
- */
-static const struct pll_macro_entry pll_predef_mclk[] = {
-	{ 4096000, 0},
-	{ 8192000, 1},
-	{16384000, 2},
-
-	{ 5644800, 0},
-	{11289600, 1},
-	{22579200, 2},
-
-	{ 6144000, 0},
-	{12288000, 1},
-	{24576000, 2},
-
-	{12288000, 0},
-	{24576000, 1},
-	{49152000, 2},
-
-	{22579200, 0},
-	{45158400, 1},
-	{90316800, 2},
-
-	{24576000, 0},
-	{49152000, 1},
-	{98304000, 2},
-};
-
 #define CYGNUS_RATE_MIN     8000
 #define CYGNUS_RATE_MAX   384000
 
@@ -488,59 +433,6 @@ static int audio_ssp_out_disable(struct cygnus_aio_port *aio)
 	return status;
 }
 
-static int pll_configure_mclk(struct cygnus_audio *cygaud, u32 mclk,
-	struct cygnus_aio_port *aio)
-{
-	int i = 0, error;
-	bool found = false;
-	const struct pll_macro_entry *p_entry;
-	struct clk *ch_clk;
-
-	for (i = 0; i < ARRAY_SIZE(pll_predef_mclk); i++) {
-		p_entry = &pll_predef_mclk[i];
-		if (p_entry->mclk == mclk) {
-			found = true;
-			break;
-		}
-	}
-	if (!found) {
-		dev_err(cygaud->dev,
-			"%s No valid mclk freq (%u) found!\n", __func__, mclk);
-		return -EINVAL;
-	}
-
-	ch_clk = cygaud->audio_clk[p_entry->pll_ch_num];
-
-	if ((aio->clk_trace.cap_en) && (!aio->clk_trace.cap_clk_en)) {
-		error = clk_prepare_enable(ch_clk);
-		if (error) {
-			dev_err(cygaud->dev, "%s clk_prepare_enable failed %d\n",
-				__func__, error);
-			return error;
-		}
-		aio->clk_trace.cap_clk_en = true;
-	}
-
-	if ((aio->clk_trace.play_en) && (!aio->clk_trace.play_clk_en)) {
-		error = clk_prepare_enable(ch_clk);
-		if (error) {
-			dev_err(cygaud->dev, "%s clk_prepare_enable failed %d\n",
-				__func__, error);
-			return error;
-		}
-		aio->clk_trace.play_clk_en = true;
-	}
-
-	error = clk_set_rate(ch_clk, mclk);
-	if (error) {
-		dev_err(cygaud->dev, "%s Set MCLK rate failed: %d\n",
-			__func__, error);
-		return error;
-	}
-
-	return p_entry->pll_ch_num;
-}
-
 static int cygnus_ssp_set_clocks(struct cygnus_aio_port *aio)
 {
 	u32 value;
@@ -723,26 +615,68 @@ static int cygnus_ssp_hw_params(struct snd_pcm_substream *substream,
 }
 
 /*
+ * Check that the actual mclk is within about 1% of the requested rate.
+ * The check is rather loose and is intended to catch any big mistakes.
+ * It is expected that the actual mclk rate may be a little different
+ * than the requested rate because the clock from which the mclk is
+ * derived (PLL) may not be an exact multiple of the mclk.
+ */
+static bool mclk_in_range(unsigned int target, unsigned int actual)
+{
+	unsigned int delta;
+
+	/* Mclk is at least several MHz, so simple div by 100 will suffice */
+	delta = target / 100;
+	return (actual > (target - delta)) && (actual < (target + delta));
+}
+
+/*
  * This function sets the mclk frequency for pll clock
  */
 static int cygnus_ssp_set_sysclk(struct snd_soc_dai *dai,
 			int clk_id, unsigned int freq, int dir)
 {
 	int sel;
+	int ret;
 	u32 value;
+	long rate;
 	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(dai);
-	struct cygnus_audio *cygaud = snd_soc_dai_get_drvdata(dai);
 
 	dev_dbg(aio->cygaud->dev,
 		"%s Enter port = %d\n", __func__, aio->portnum);
-	sel = pll_configure_mclk(cygaud, freq, aio);
-	if (sel < 0) {
+
+	/*
+	 * This should not happen, but the machine file may inadvertently
+	 * call set_sysclk without configuring a clock via the devicetree.
+	 */
+	if (!aio->clk_info.audio_clk) {
 		dev_err(aio->cygaud->dev,
-			"%s Setting mclk failed.\n", __func__);
+			"%s Error. No clock assigned.\n", __func__);
+		return -ENODEV;
+	}
+
+	rate = clk_round_rate(aio->clk_info.audio_clk, freq);
+	if (rate < 0) {
+		dev_err(aio->cygaud->dev, "%s Error with with clock %ld.\n",
+			__func__, rate);
+		return rate;
+	}
+
+	if (!mclk_in_range(freq, rate)) {
+		dev_err(aio->cygaud->dev, "%s Can not set rate to %u  actual %ld.\n",
+			__func__, freq, rate);
 		return -EINVAL;
 	}
 
+	ret = clk_set_rate(aio->clk_info.audio_clk, freq);
+	if (ret) {
+		dev_err(aio->cygaud->dev,
+			"%s Set MCLK rate fail %d\n", __func__, ret);
+		return ret;
+	}
+
 	aio->mclk = freq;
+	sel = aio->clk_info.clk_mux;
 
 	dev_dbg(aio->cygaud->dev, "%s Setting MCLKSEL to %d\n", __func__, sel);
 	value = readl(aio->cygaud->audio + aio->regs.i2s_mclk_cfg);
@@ -759,17 +693,14 @@ static int cygnus_ssp_startup(struct snd_pcm_substream *substream,
 	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(dai);
 
 	snd_soc_dai_set_dma_data(dai, substream, aio);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		aio->clk_trace.play_en = true;
-	else
-		aio->clk_trace.cap_en = true;
 
 	substream->runtime->hw.rate_min = CYGNUS_RATE_MIN;
 	substream->runtime->hw.rate_max = CYGNUS_RATE_MAX;
 
 	snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE, &cygnus_rate_constraint);
-	return 0;
+
+	return clk_prepare_enable(aio->clk_info.audio_clk);
 }
 
 static void cygnus_ssp_shutdown(struct snd_pcm_substream *substream,
@@ -777,36 +708,7 @@ static void cygnus_ssp_shutdown(struct snd_pcm_substream *substream,
 {
 	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(dai);
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		aio->clk_trace.play_en = false;
-	else
-		aio->clk_trace.cap_en = false;
-
-	if (!aio->is_slave) {
-		u32 val;
-
-		val = readl(aio->cygaud->audio + aio->regs.i2s_mclk_cfg);
-		val &= CYGNUS_PLLCLKSEL_MASK;
-		if (val >= ARRAY_SIZE(aio->cygaud->audio_clk)) {
-			dev_err(aio->cygaud->dev, "Clk index %u is out of bounds\n",
-				val);
-			return;
-		}
-
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			if (aio->clk_trace.play_clk_en) {
-				clk_disable_unprepare(aio->cygaud->
-						audio_clk[val]);
-				aio->clk_trace.play_clk_en = false;
-			}
-		} else {
-			if (aio->clk_trace.cap_clk_en) {
-				clk_disable_unprepare(aio->cygaud->
-						audio_clk[val]);
-				aio->clk_trace.cap_clk_en = false;
-			}
-		}
-	}
+	clk_disable_unprepare(aio->clk_info.audio_clk);
 }
 
 /*
@@ -945,7 +847,6 @@ static int cygnus_ssp_trigger(struct snd_pcm_substream *substream, int cmd,
 			       struct snd_soc_dai *dai)
 {
 	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(dai);
-	struct cygnus_audio *cygaud = snd_soc_dai_get_drvdata(dai);
 
 	dev_dbg(aio->cygaud->dev,
 		"%s cmd %d at port = %d\n", __func__, cmd, aio->portnum);
@@ -958,7 +859,6 @@ static int cygnus_ssp_trigger(struct snd_pcm_substream *substream, int cmd,
 			audio_ssp_out_enable(aio);
 		else
 			audio_ssp_in_enable(aio);
-		cygaud->active_ports++;
 
 		break;
 
@@ -969,7 +869,6 @@ static int cygnus_ssp_trigger(struct snd_pcm_substream *substream, int cmd,
 			audio_ssp_out_disable(aio);
 		else
 			audio_ssp_in_disable(aio);
-		cygaud->active_ports--;
 		break;
 
 	default:
@@ -1063,68 +962,34 @@ static int cygnus_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int cygnus_ssp_suspend(struct snd_soc_dai *cpu_dai)
+static int cygnus_ssp_set_pll(struct snd_soc_dai *cpu_dai, int pll_id,
+				 int source, unsigned int freq_in,
+				 unsigned int freq_out)
 {
 	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(cpu_dai);
+	struct clk *clk_pll;
+	int ret = 0;
 
-	if (!aio->is_slave) {
-		u32 val;
-
-		val = readl(aio->cygaud->audio + aio->regs.i2s_mclk_cfg);
-		val &= CYGNUS_PLLCLKSEL_MASK;
-		if (val >= ARRAY_SIZE(aio->cygaud->audio_clk)) {
-			dev_err(aio->cygaud->dev, "Clk index %u is out of bounds\n",
-				val);
-			return -EINVAL;
-		}
-
-		if (aio->clk_trace.cap_clk_en)
-			clk_disable_unprepare(aio->cygaud->audio_clk[val]);
-		if (aio->clk_trace.play_clk_en)
-			clk_disable_unprepare(aio->cygaud->audio_clk[val]);
+	if (!aio->clk_info.audio_clk) {
+		dev_err(aio->cygaud->dev,
+			"%s: port %d does not have an assigned clock.\n",
+			__func__, aio->portnum);
+		return -ENODEV;
+	}
 
-		aio->pll_clk_num = val;
+	clk_pll = clk_get_parent(aio->clk_info.audio_clk);
+	if (IS_ERR(clk_pll)) {
+		dev_err(aio->cygaud->dev,
+			"%s: could not get audiopll clock.\n", __func__);
+		return -ENODEV;
 	}
 
-	return 0;
+	ret = clk_set_rate(clk_pll, freq_out);
+
+	return ret;
 }
 
-static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)
-{
-	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(cpu_dai);
-	int error;
-
-	if (!aio->is_slave) {
-		if (aio->clk_trace.cap_clk_en) {
-			error = clk_prepare_enable(aio->cygaud->
-					audio_clk[aio->pll_clk_num]);
-			if (error) {
-				dev_err(aio->cygaud->dev, "%s clk_prepare_enable failed\n",
-					__func__);
-				return -EINVAL;
-			}
-		}
-		if (aio->clk_trace.play_clk_en) {
-			error = clk_prepare_enable(aio->cygaud->
-					audio_clk[aio->pll_clk_num]);
-			if (error) {
-				if (aio->clk_trace.cap_clk_en)
-					clk_disable_unprepare(aio->cygaud->
-						audio_clk[aio->pll_clk_num]);
-				dev_err(aio->cygaud->dev, "%s clk_prepare_enable failed\n",
-					__func__);
-				return -EINVAL;
-			}
-		}
-	}
 
-	return 0;
-}
-#else
-#define cygnus_ssp_suspend NULL
-#define cygnus_ssp_resume  NULL
-#endif
 
 static const struct snd_soc_dai_ops cygnus_ssp_dai_ops = {
 	.startup	= cygnus_ssp_startup,
@@ -1134,6 +999,7 @@ static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)
 	.set_fmt	= cygnus_ssp_set_fmt,
 	.set_sysclk	= cygnus_ssp_set_sysclk,
 	.set_tdm_slot	= cygnus_set_dai_tdm_slot,
+	.set_pll	= cygnus_ssp_set_pll,
 };
 
 
@@ -1155,8 +1021,6 @@ static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)
 					SNDRV_PCM_FMTBIT_S32_LE, \
 	}, \
 	.ops = &cygnus_ssp_dai_ops, \
-	.suspend = cygnus_ssp_suspend, \
-	.resume = cygnus_ssp_resume, \
 }
 
 static const struct snd_soc_dai_driver cygnus_ssp_dai_info[] = {
@@ -1175,8 +1039,6 @@ static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)
 			SNDRV_PCM_FMTBIT_S32_LE,
 	},
 	.ops = &cygnus_ssp_dai_ops,
-	.suspend = cygnus_ssp_suspend,
-	.resume = cygnus_ssp_resume,
 };
 
 static struct snd_soc_dai_driver cygnus_ssp_dai[CYGNUS_MAX_PORTS];
@@ -1200,6 +1062,8 @@ static int parse_ssp_child_node(struct platform_device *pdev,
 	u32 rawval;
 	int portnum = -1;
 	enum cygnus_audio_port_type port_type;
+	u32 muxval;
+	struct clk *clk;
 
 	if (of_property_read_u32(dn, "reg", &rawval)) {
 		dev_err(&pdev->dev, "Missing reg property\n");
@@ -1259,28 +1123,37 @@ static int parse_ssp_child_node(struct platform_device *pdev,
 	dev_dbg(&pdev->dev, "%s portnum = %d\n", __func__, aio->portnum);
 	aio->streams_on = 0;
 	aio->cygaud->dev = &pdev->dev;
-	aio->clk_trace.play_en = false;
-	aio->clk_trace.cap_en = false;
 
-	audio_ssp_init_portregs(aio);
-	return 0;
-}
 
-static int audio_clk_init(struct platform_device *pdev,
-						struct cygnus_audio *cygaud)
-{
-	int i;
-	char clk_name[PROP_LEN_MAX];
+	aio->clk_info.audio_clk = NULL;
 
-	for (i = 0; i < ARRAY_SIZE(cygaud->audio_clk); i++) {
-		snprintf(clk_name, PROP_LEN_MAX, "ch%d_audio", i);
+	/*
+	 * The default in the DT is to assign a clock. It is possible
+	 * the user may not want a clock if the port is only used in slave
+	 * mode.  In this case, they could override the default using this
+	 * mechanism:    /delete-property/ clocks;
+	 */
+	if (of_property_read_bool(dn, "clocks")) {
+		clk = devm_get_clk_from_child(&pdev->dev, dn, "ssp_clk");
+		if (IS_ERR(clk)) {
+			dev_err(&pdev->dev,
+				"Port %d: devm_clk_get ssp-clk err %ld\n",
+				portnum, PTR_ERR(clk));
+			return PTR_ERR(clk);
+		}
 
-		cygaud->audio_clk[i] = devm_clk_get(&pdev->dev, clk_name);
-		if (IS_ERR(cygaud->audio_clk[i]))
-			return PTR_ERR(cygaud->audio_clk[i]);
+		aio->clk_info.audio_clk = clk;
+
+		if (of_property_read_u32(dn, "brcm,ssp-clk-mux", &muxval)) {
+			dev_err(&pdev->dev, "Missing property clock-mux\n");
+			return -EINVAL;
+		}
+		aio->clk_info.clk_mux = muxval;
+	} else {
+		dev_dbg(&pdev->dev, "No clock provided for port %d\n", portnum);
 	}
 
-	return 0;
+	return audio_ssp_init_portregs(aio);
 }
 
 static int cygnus_ssp_probe(struct platform_device *pdev)
@@ -1337,7 +1210,6 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 	}
 
 	cygaud->dev = dev;
-	cygaud->active_ports = 0;
 
 	dev_dbg(dev, "Registering %d DAIs\n", active_port_count);
 	err = snd_soc_register_component(dev, &cygnus_ssp_component,
@@ -1354,12 +1226,6 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 		goto err_irq;
 	}
 
-	err = audio_clk_init(pdev, cygaud);
-	if (err) {
-		dev_err(dev, "audio clock initialization failed\n");
-		goto err_irq;
-	}
-
 	err = cygnus_soc_platform_register(dev, cygaud);
 	if (err) {
 		dev_err(dev, "platform reg error %d\n", err);
diff --git a/sound/soc/bcm/cygnus-ssp.h b/sound/soc/bcm/cygnus-ssp.h
index 33dd343..ad15a00 100644
--- a/sound/soc/bcm/cygnus-ssp.h
+++ b/sound/soc/bcm/cygnus-ssp.h
@@ -19,7 +19,6 @@
 #define CYGNUS_MAX_CAPTURE_PORTS 3
 #define CYGNUS_MAX_I2S_PORTS 3
 #define CYGNUS_MAX_PORTS  CYGNUS_MAX_PLAYBACK_PORTS
-#define CYGNUS_AUIDO_MAX_NUM_CLKS 3
 
 #define CYGNUS_SSP_FRAMEBITS_DIV 1
 
@@ -81,11 +80,9 @@ struct cygnus_ssp_regs {
 	u32 bf_sourcech_grp;
 };
 
-struct cygnus_track_clk {
-	bool cap_en;
-	bool play_en;
-	bool cap_clk_en;
-	bool play_clk_en;
+struct cygnus_audio_clkinfo {
+	struct clk *audio_clk;
+	int clk_mux;
 };
 
 struct cygnus_aio_port {
@@ -110,7 +107,7 @@ struct cygnus_aio_port {
 	struct snd_pcm_substream *play_stream;
 	struct snd_pcm_substream *capture_stream;
 
-	struct cygnus_track_clk clk_trace;
+	struct cygnus_audio_clkinfo clk_info;
 };
 
 
@@ -121,10 +118,6 @@ struct cygnus_audio {
 	void __iomem *audio;
 	struct device *dev;
 	void __iomem *i2s_in;
-
-	struct clk *audio_clk[CYGNUS_AUIDO_MAX_NUM_CLKS];
-	int active_ports;
-	unsigned long vco_rate;
 };
 
 extern int cygnus_ssp_get_mode(struct snd_soc_dai *cpu_dai);
-- 
1.9.1
