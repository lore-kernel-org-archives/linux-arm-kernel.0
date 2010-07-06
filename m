From: lamiaposta71@gmail.com (Raffaele Recalcati)
Date: Tue,  6 Jul 2010 10:39:03 +0200
Subject: [PATCH 2/3] ASoC: DaVinci: Added selection of clk input pin for McBSP
In-Reply-To: <1278405544-3852-1-git-send-email-lamiaposta71@gmail.com>
References: <1278405544-3852-1-git-send-email-lamiaposta71@gmail.com>
Message-ID: <1278405544-3852-3-git-send-email-lamiaposta71@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Raffaele Recalcati <raffaele.recalcati@bticino.it>

    When McBSP peripheral gets the clock from an external pin,
    there are three possible chooses, MCBSP_CLKX, MCBSP_CLKR
    and MCBSP_CLKS.
    evm-dm365 uses MCBSP_CLKR, instead in bmx board I have a different
    hardware connection and I use MCBSP_CLKS, so I have added
    this possibility.

    This patch has been developed against the:
        http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git
    git tree and has been tested on bmx board (similar to dm365 evm)

Signed-off-by: Raffaele Recalcati <raffaele.recalcati@bticino.it>
Signed-off-by: Davide Bonfanti <davide.bonfanti@bticino.it>
---
 arch/arm/mach-davinci/include/mach/asp.h |   15 +++++++++++++++
 sound/soc/davinci/davinci-i2s.c          |   29 ++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/asp.h b/arch/arm/mach-davinci/include/mach/asp.h
index 834725f..0847d21 100644
--- a/arch/arm/mach-davinci/include/mach/asp.h
+++ b/arch/arm/mach-davinci/include/mach/asp.h
@@ -63,6 +63,16 @@ struct snd_platform_data {
 	unsigned sram_size_playback;
 	unsigned sram_size_capture;
 
+	/*
+	 * If McBSP peripheral gets the clock from an external pin,
+	 * there are three chooses, that are MCBSP_CLKX, MCBSP_CLKR
+	 * and MCBSP_CLKS.
+	 * Depending on different hardware connections it is possible
+	 * to use this setting to change the behaviour of McBSP
+	 * driver. The dm365_clk_input_pin enum is available for dm365
+	 */
+	int clk_input_pin;
+
 	/* McASP specific fields */
 	int tdm_slots;
 	u8 op_mode;
@@ -78,6 +88,11 @@ enum {
 	MCASP_VERSION_2,	/* DA8xx/OMAPL1x */
 };
 
+enum dm365_clk_input_pin {
+	MCBSP_CLKR = 0,		/* DM365 */
+	MCBSP_CLKS,
+};
+
 #define INACTIVE_MODE	0
 #define TX_MODE		1
 #define RX_MODE		2
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index c8f038c..ba5644b 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -122,6 +122,7 @@ static const unsigned char double_fmt[SNDRV_PCM_FORMAT_S32_LE + 1] = {
 };
 
 struct davinci_mcbsp_dev {
+	struct device *dev;
 	struct davinci_pcm_dma_params	dma_params[2];
 	void __iomem			*base;
 #define MOD_DSP_A	0
@@ -153,6 +154,7 @@ struct davinci_mcbsp_dev {
 
 	unsigned int fmt;
 	int clk_div;
+	int clk_input_pin;
 };
 
 static inline void davinci_mcbsp_write_reg(struct davinci_mcbsp_dev *dev,
@@ -279,11 +281,26 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 			DAVINCI_MCBSP_PCR_CLKRM;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
-		/* McBSP CLKR pin is the input for the Sample Rate Generator.
-		 * McBSP FSR and FSX are driven by the Sample Rate Generator. */
-		pcr = DAVINCI_MCBSP_PCR_SCLKME |
-			DAVINCI_MCBSP_PCR_FSXM |
-			DAVINCI_MCBSP_PCR_FSRM;
+		pcr = DAVINCI_MCBSP_PCR_FSRM | DAVINCI_MCBSP_PCR_FSXM;
+		/*
+		 * Selection of the clock input pin that is the
+		 * input for the Sample Rate Generator.
+		 * McBSP FSR and FSX are driven by the Sample Rate
+		 * Generator.
+		 */
+		switch (dev->clk_input_pin) {
+		case MCBSP_CLKS:
+			pcr |= DAVINCI_MCBSP_PCR_CLKXM |
+				DAVINCI_MCBSP_PCR_CLKRM;
+			break;
+		case MCBSP_CLKR:
+			pcr |= DAVINCI_MCBSP_PCR_SCLKME;
+			break;
+		default:
+			dev_err(dev->dev, "bad clk_input_pin\n");
+			return -EINVAL;
+		}
+
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		/* codec is master */
@@ -644,6 +661,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 			pdata->sram_size_playback;
 		dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].sram_size =
 			pdata->sram_size_capture;
+		dev->clk_input_pin = pdata->clk_input_pin;
 	}
 	dev->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
@@ -676,6 +694,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 		goto err_free_mem;
 	}
 	dev->dma_params[SNDRV_PCM_STREAM_CAPTURE].channel = res->start;
+	dev->dev = &pdev->dev;
 
 	davinci_i2s_dai.private_data = dev;
 	davinci_i2s_dai.capture.dma_data = dev->dma_params;
-- 
1.7.0.4
