From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Fri, 29 Apr 2016 21:00:44 +0800
Subject: [alsa-devel] [PATCH 3/7] ASoC: mediatek: add clock and irq control
 for 2701 platform driver
In-Reply-To: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
References: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <1461934848-60011-4-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock and irq controls for 2701 platform driver.
To save irq resource, dynamic-allocated irq mechanism is implemented.

Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c | 344 ++++++++++++++++++++++
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h |  33 +++
 sound/soc/mediatek/mt2701/mt2701-afe-common.h     | 228 ++++++++++++++
 sound/soc/mediatek/mt2701/mt2701-irq.c            |  74 +++++
 sound/soc/mediatek/mt2701/mt2701-irq.h            |  26 ++
 sound/soc/mediatek/mt2701/mt2701-reg.h            | 195 ++++++++++++
 6 files changed, 900 insertions(+)
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-common.h
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-irq.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-irq.h
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-reg.h

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
new file mode 100644
index 0000000..0fe29cd
--- /dev/null
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
@@ -0,0 +1,344 @@
+/*
+ * mt2701-afe-clock-ctrl.c  --  Mediatek 2701 afe clock ctrl
+ *
+ * Copyright (c) 2016 MediaTek Inc.
+ * Author: Garlic Tseng <garlic.tseng@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <sound/soc.h>
+#include <linux/regmap.h>
+#include <linux/pm_runtime.h>
+
+#include "mt2701-afe-common.h"
+#include "mt2701-afe-clock-ctrl.h"
+
+static const char *aud_clks[MT2701_CLOCK_NUM] = {
+	[MT2701_AUD_INFRA_SYS_AUDIO] = "infra_sys_audio_clk",
+	[MT2701_AUD_TOP_AUD_MUX1_SEL] = "top_audio_mux1_sel",
+	[MT2701_AUD_TOP_AUD_MUX2_SEL] = "top_audio_mux2_sel",
+	[MT2701_AUD_TOP_AUD_MUX1_DIV] = "top_audio_mux1_div",
+	[MT2701_AUD_TOP_AUD_MUX2_DIV] = "top_audio_mux2_div",
+	[MT2701_AUD_TOP_AUD_48K_TIMING] = "top_audio_48k_timing",
+	[MT2701_AUD_TOP_AUD_44K_TIMING] = "top_audio_44k_timing",
+	[MT2701_AUD_TOP_AUDPLL_MUX_SEL] = "top_audpll_mux_sel",
+	[MT2701_AUD_TOP_APLL_SEL] = "top_apll_sel",
+	[MT2701_AUD_TOP_AUD1PLL_98M] = "top_aud1_pll_98M",
+	[MT2701_AUD_TOP_AUD2PLL_90M] = "top_aud2_pll_90M",
+	[MT2701_AUD_TOP_HADDS2PLL_98M] = "top_hadds2_pll_98M",
+	[MT2701_AUD_TOP_HADDS2PLL_294M] = "top_hadds2_pll_294M",
+	[MT2701_AUD_TOP_AUDPLL] = "top_audpll",
+	[MT2701_AUD_TOP_AUDPLL_D4] = "top_audpll_d4",
+	[MT2701_AUD_TOP_AUDPLL_D8] = "top_audpll_d8",
+	[MT2701_AUD_TOP_AUDPLL_D16] = "top_audpll_d16",
+	[MT2701_AUD_TOP_AUDPLL_D24] = "top_audpll_d24",
+	[MT2701_AUD_TOP_AUDINTBUS] = "top_audintbus_sel",
+	[MT2701_AUD_CLK_26M] = "clk_26m",
+	[MT2701_AUD_TOP_SYSPLL1_D4] = "top_syspll1_d4",
+	[MT2701_AUD_TOP_AUD_K1_SRC_SEL] = "top_aud_k1_src_sel",
+	[MT2701_AUD_TOP_AUD_K2_SRC_SEL] = "top_aud_k2_src_sel",
+	[MT2701_AUD_TOP_AUD_K3_SRC_SEL] = "top_aud_k3_src_sel",
+	[MT2701_AUD_TOP_AUD_K4_SRC_SEL] = "top_aud_k4_src_sel",
+	[MT2701_AUD_TOP_AUD_K5_SRC_SEL] = "top_aud_k5_src_sel",
+	[MT2701_AUD_TOP_AUD_K6_SRC_SEL] = "top_aud_k6_src_sel",
+	[MT2701_AUD_TOP_AUD_K1_SRC_DIV] = "top_aud_k1_src_div",
+	[MT2701_AUD_TOP_AUD_K2_SRC_DIV] = "top_aud_k2_src_div",
+	[MT2701_AUD_TOP_AUD_K3_SRC_DIV] = "top_aud_k3_src_div",
+	[MT2701_AUD_TOP_AUD_K4_SRC_DIV] = "top_aud_k4_src_div",
+	[MT2701_AUD_TOP_AUD_K5_SRC_DIV] = "top_aud_k5_src_div",
+	[MT2701_AUD_TOP_AUD_K6_SRC_DIV] = "top_aud_k6_src_div",
+	[MT2701_AUD_TOP_AUD_I2S1_MCLK] = "top_aud_i2s1_mclk",
+	[MT2701_AUD_TOP_AUD_I2S2_MCLK] = "top_aud_i2s2_mclk",
+	[MT2701_AUD_TOP_AUD_I2S3_MCLK] = "top_aud_i2s3_mclk",
+	[MT2701_AUD_TOP_AUD_I2S4_MCLK] = "top_aud_i2s4_mclk",
+	[MT2701_AUD_TOP_AUD_I2S5_MCLK] = "top_aud_i2s5_mclk",
+	[MT2701_AUD_TOP_AUD_I2S6_MCLK] = "top_aud_i2s6_mclk",
+	[MT2701_AUD_TOP_ASM_M_SEL] = "top_asm_m_sel",
+	[MT2701_AUD_TOP_ASM_H_SEL] = "top_asm_h_sel",
+	[MT2701_AUD_TOP_UNIVPLL2_D4] = "top_univpll2_d4",
+	[MT2701_AUD_TOP_UNIVPLL2_D2] = "top_univpll2_d2",
+	[MT2701_AUD_TOP_SYSPLL_D5] = "top_syspll_d5",
+};
+
+void mt2701_init_clock(struct mt2701_afe *afe)
+{
+	int i = 0;
+
+	for (i = 0; i < MT2701_CLOCK_NUM; i++) {
+		afe->clocks[i] = devm_clk_get(afe->dev, aud_clks[i]);
+		if (IS_ERR(aud_clks[i]))
+			dev_warn(afe->dev, "%s devm_clk_get %s fail\n",
+				 __func__, aud_clks[i]);
+	}
+}
+
+void mt2701_afe_enable_clock(struct mt2701_afe *afe, int en)
+{
+	if (en) {
+		mt2701_turn_on_a1sys_clock(afe);
+		mt2701_turn_on_a2sys_clock(afe);
+		mt2701_turn_on_afe_clock(afe);
+		regmap_update_bits(afe->regmap, ASYS_TOP_CON,
+				   AUDIO_TOP_CON0_A1SYS_A2SYS_ON,
+				   AUDIO_TOP_CON0_A1SYS_A2SYS_ON);
+		regmap_update_bits(afe->regmap, AFE_DAC_CON0,
+				   AFE_DAC_CON0_AFE_ON, AFE_DAC_CON0_AFE_ON);
+		regmap_write(afe->regmap, PWR2_TOP_CON, PWR2_TOP_CON_INIT_VAL);
+		regmap_write(afe->regmap, PWR1_ASM_CON1,
+			     PWR1_ASM_CON1_INIT_VAL);
+		regmap_write(afe->regmap, PWR2_ASM_CON1,
+			     PWR2_ASM_CON1_INIT_VAL);
+	} else {
+		mt2701_turn_off_afe_clock(afe);
+		mt2701_turn_off_a1sys_clock(afe);
+		mt2701_turn_off_a2sys_clock(afe);
+		regmap_update_bits(afe->regmap, ASYS_TOP_CON,
+				   AUDIO_TOP_CON0_A1SYS_A2SYS_ON, 0);
+		regmap_update_bits(afe->regmap, AFE_DAC_CON0,
+				   AFE_DAC_CON0_AFE_ON, 0);
+	}
+}
+
+void mt2701_turn_on_a1sys_clock(struct mt2701_afe *afe)
+{
+	int ret = 0;
+
+	/* Set Mux */
+	ret = clk_prepare_enable(afe->clocks[MT2701_AUD_TOP_AUD_MUX1_SEL]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[MT2701_AUD_TOP_AUD_MUX1_SEL], ret);
+
+	ret = clk_set_parent(afe->clocks[MT2701_AUD_TOP_AUD_MUX1_SEL],
+			     afe->clocks[MT2701_AUD_TOP_AUD1PLL_98M]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n", __func__,
+			aud_clks[MT2701_AUD_TOP_AUD_MUX1_SEL],
+			aud_clks[MT2701_AUD_TOP_AUD1PLL_98M], ret);
+
+	/* Set Divider */
+	ret = clk_prepare_enable(afe->clocks[MT2701_AUD_TOP_AUD_MUX1_DIV]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__,
+			aud_clks[MT2701_AUD_TOP_AUD_MUX1_DIV],
+			ret);
+	ret = clk_set_rate(afe->clocks[MT2701_AUD_TOP_AUD_MUX1_DIV],
+			   MT2701_AUD_TOP_AUD_MUX1_DIV_RATE);
+	if (ret)
+		dev_err(afe->dev, "%s clk_set_parent %s-%d fail %d\n", __func__,
+			aud_clks[MT2701_AUD_TOP_AUD_MUX1_DIV],
+			MT2701_AUD_TOP_AUD_MUX1_DIV_RATE, ret);
+
+	/* Enable clock gate */
+	ret = clk_prepare_enable(afe->clocks[MT2701_AUD_TOP_AUD_48K_TIMING]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[MT2701_AUD_TOP_AUD_48K_TIMING], ret);
+	/* Enable infra audio */
+	ret = clk_prepare_enable(afe->clocks[MT2701_AUD_INFRA_SYS_AUDIO]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[MT2701_AUD_INFRA_SYS_AUDIO], ret);
+}
+
+void mt2701_turn_off_a1sys_clock(struct mt2701_afe *afe)
+{
+	clk_disable_unprepare(afe->clocks[MT2701_AUD_INFRA_SYS_AUDIO]);
+	clk_disable_unprepare(afe->clocks[MT2701_AUD_TOP_AUD_48K_TIMING]);
+	clk_disable_unprepare(afe->clocks[MT2701_AUD_TOP_AUD_MUX1_DIV]);
+	clk_disable_unprepare(afe->clocks[MT2701_AUD_TOP_AUD_MUX1_SEL]);
+}
+
+void mt2701_turn_on_a2sys_clock(struct mt2701_afe *afe)
+{
+	int ret = 0;
+
+	/* Set Mux */
+	ret = clk_prepare_enable(afe->clocks[MT2701_AUD_TOP_AUD_MUX2_SEL]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__,
+			aud_clks[MT2701_AUD_TOP_AUD_MUX2_SEL],
+			ret);
+	ret = clk_set_parent(afe->clocks[MT2701_AUD_TOP_AUD_MUX2_SEL],
+			     afe->clocks[MT2701_AUD_TOP_AUD2PLL_90M]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n", __func__,
+			aud_clks[MT2701_AUD_TOP_AUD_MUX2_SEL],
+			aud_clks[MT2701_AUD_TOP_AUD2PLL_90M], ret);
+	/* Set Divider */
+	ret = clk_prepare_enable(afe->clocks[MT2701_AUD_TOP_AUD_MUX2_DIV]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__,
+			aud_clks[MT2701_AUD_TOP_AUD_MUX2_DIV],
+			ret);
+	ret = clk_set_rate(afe->clocks[MT2701_AUD_TOP_AUD_MUX2_DIV],
+			   MT2701_AUD_TOP_AUD_MUX2_DIV_RATE);
+	if (ret)
+		dev_err(afe->dev, "%s clk_set_parent %s-%d fail %d\n", __func__,
+			aud_clks[MT2701_AUD_TOP_AUD_MUX2_DIV],
+			MT2701_AUD_TOP_AUD_MUX2_DIV_RATE, ret);
+
+	/* Enable clock gate */
+	ret = clk_prepare_enable(afe->clocks[MT2701_AUD_TOP_AUD_44K_TIMING]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[MT2701_AUD_TOP_AUD_44K_TIMING], ret);
+	/* Enable infra audio */
+	ret = clk_prepare_enable(afe->clocks[MT2701_AUD_INFRA_SYS_AUDIO]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[MT2701_AUD_INFRA_SYS_AUDIO], ret);
+}
+
+void mt2701_turn_off_a2sys_clock(struct mt2701_afe *afe)
+{
+	clk_disable_unprepare(afe->clocks[MT2701_AUD_INFRA_SYS_AUDIO]);
+	clk_disable_unprepare(afe->clocks[MT2701_AUD_TOP_AUD_44K_TIMING]);
+	clk_disable_unprepare(afe->clocks[MT2701_AUD_TOP_AUD_MUX2_DIV]);
+	clk_disable_unprepare(afe->clocks[MT2701_AUD_TOP_AUD_MUX2_SEL]);
+}
+
+void mt2701_turn_on_afe_clock(struct mt2701_afe *afe)
+{
+	int ret;
+
+	/*MT_CG_INFRA_AUDIO, INFRA_PDN_STA[5]*/
+	ret = clk_prepare_enable(afe->clocks[MT2701_AUD_INFRA_SYS_AUDIO]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[MT2701_AUD_INFRA_SYS_AUDIO], ret);
+
+	/* Set MT2701_AUD_TOP_AUDINTBUS to MT2701_AUD_TOP_SYSPLL1_D4 */
+	ret = clk_prepare_enable(afe->clocks[MT2701_AUD_TOP_AUDINTBUS]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__,
+			aud_clks[MT2701_AUD_TOP_AUDINTBUS], ret);
+
+	ret = clk_set_parent(afe->clocks[MT2701_AUD_TOP_AUDINTBUS],
+			     afe->clocks[MT2701_AUD_TOP_SYSPLL1_D4]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n", __func__,
+			aud_clks[MT2701_AUD_TOP_AUDINTBUS],
+			aud_clks[MT2701_AUD_TOP_SYSPLL1_D4], ret);
+
+	/* Set MT2701_AUD_TOP_ASM_H_SEL to MT2701_AUD_TOP_UNIVPLL2_D2*/
+	ret = clk_prepare_enable(afe->clocks[MT2701_AUD_TOP_ASM_H_SEL]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__,
+			aud_clks[MT2701_AUD_TOP_ASM_H_SEL], ret);
+
+	ret = clk_set_parent(afe->clocks[MT2701_AUD_TOP_ASM_H_SEL],
+			     afe->clocks[MT2701_AUD_TOP_UNIVPLL2_D2]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n", __func__,
+			aud_clks[MT2701_AUD_TOP_ASM_H_SEL],
+			aud_clks[MT2701_AUD_TOP_UNIVPLL2_D2], ret);
+
+	/* Set MT2701_AUD_TOP_ASM_M_SEL to MT2701_AUD_TOP_UNIVPLL2_D4*/
+	ret = clk_prepare_enable(afe->clocks[MT2701_AUD_TOP_ASM_M_SEL]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__,
+			aud_clks[MT2701_AUD_TOP_ASM_M_SEL], ret);
+
+	ret = clk_set_parent(afe->clocks[MT2701_AUD_TOP_ASM_M_SEL],
+			     afe->clocks[MT2701_AUD_TOP_UNIVPLL2_D4]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n", __func__,
+			aud_clks[MT2701_AUD_TOP_ASM_M_SEL],
+			aud_clks[MT2701_AUD_TOP_UNIVPLL2_D4], ret);
+
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
+			   AUDIO_TOP_CON0_PDN_AFE, 0);
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
+			   AUDIO_TOP_CON0_PDN_APLL_CK, 0);
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON4,
+			   AUDIO_TOP_CON4_PDN_A1SYS, 0);
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON4,
+			   AUDIO_TOP_CON4_PDN_A2SYS, 0);
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON4,
+			   AUDIO_TOP_CON4_PDN_AFE_CONN, 0);
+}
+
+void mt2701_turn_off_afe_clock(struct mt2701_afe *afe)
+{
+	/*MT_CG_INFRA_AUDIO,*/
+	clk_disable_unprepare(afe->clocks[MT2701_AUD_INFRA_SYS_AUDIO]);
+
+	clk_disable_unprepare(afe->clocks[MT2701_AUD_TOP_AUDINTBUS]);
+	clk_disable_unprepare(afe->clocks[MT2701_AUD_TOP_ASM_H_SEL]);
+	clk_disable_unprepare(afe->clocks[MT2701_AUD_TOP_ASM_M_SEL]);
+
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
+			   AUDIO_TOP_CON0_PDN_AFE, AUDIO_TOP_CON0_PDN_AFE);
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0,
+			   AUDIO_TOP_CON0_PDN_APLL_CK,
+			   AUDIO_TOP_CON0_PDN_APLL_CK);
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON4,
+			   AUDIO_TOP_CON4_PDN_A1SYS, AUDIO_TOP_CON4_PDN_A1SYS);
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON4,
+			   AUDIO_TOP_CON4_PDN_A2SYS, AUDIO_TOP_CON4_PDN_A2SYS);
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON4,
+			   AUDIO_TOP_CON4_PDN_AFE_CONN,
+			   AUDIO_TOP_CON4_PDN_AFE_CONN);
+}
+
+void mt2701_mclk_configuration(struct mt2701_afe *afe, int id, int domain,
+			       int mclk)
+{
+	int ret;
+	int aud_src_div_id = MT2701_AUD_TOP_AUD_K1_SRC_DIV + id;
+	int aud_src_clk_id = MT2701_AUD_TOP_AUD_K1_SRC_SEL + id;
+
+	/* Set MCLK Kx_SRC_SEL(domain) */
+	ret = clk_prepare_enable(afe->clocks[aud_src_clk_id]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[aud_src_clk_id], ret);
+
+	if (domain == 0) {
+		ret = clk_set_parent(afe->clocks[aud_src_clk_id],
+				     afe->clocks[MT2701_AUD_TOP_AUD_MUX1_SEL]);
+		if (ret)
+			dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n",
+				__func__, aud_clks[aud_src_clk_id],
+				aud_clks[MT2701_AUD_TOP_AUD_MUX1_SEL], ret);
+	} else {
+		ret = clk_set_parent(afe->clocks[aud_src_clk_id],
+				     afe->clocks[MT2701_AUD_TOP_AUD_MUX2_SEL]);
+		if (ret)
+			dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n",
+				__func__, aud_clks[aud_src_clk_id],
+				aud_clks[MT2701_AUD_TOP_AUD_MUX2_SEL], ret);
+	}
+	clk_disable_unprepare(afe->clocks[aud_src_clk_id]);
+
+	/* Set MCLK Kx_SRC_DIV(divider) */
+	ret = clk_prepare_enable(afe->clocks[aud_src_div_id]);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__, aud_clks[aud_src_div_id], ret);
+
+	ret = clk_set_rate(afe->clocks[aud_src_div_id], mclk);
+	if (ret)
+		dev_err(afe->dev, "%s clk_set_rate %s-%d fail %d\n", __func__,
+			aud_clks[aud_src_div_id], mclk, ret);
+	clk_disable_unprepare(afe->clocks[aud_src_div_id]);
+}
+
+MODULE_DESCRIPTION("MT2701 afe clock control");
+MODULE_AUTHOR("Garlic Tseng <garlic.tseng@mediatek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
new file mode 100644
index 0000000..4b02da2
--- /dev/null
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
@@ -0,0 +1,33 @@
+/*
+ * mt2701-afe-clock-ctrl.h  --  Mediatek 2701 afe clock ctrl definition
+ *
+ * Copyright (c) 2016 MediaTek Inc.
+ * Author: Garlic Tseng <garlic.tseng@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _MT2701_AFE_CLOCK_CTRL_H_
+#define _MT2701_AFE_CLOCK_CTRL_H_
+
+struct mt2701_afe;
+
+void mt2701_init_clock(struct mt2701_afe *afe);
+void mt2701_afe_enable_clock(struct mt2701_afe *afe, int en);
+void mt2701_turn_on_a1sys_clock(struct mt2701_afe *afe);
+void mt2701_turn_off_a1sys_clock(struct mt2701_afe *afe);
+void mt2701_turn_on_a2sys_clock(struct mt2701_afe *afe);
+void mt2701_turn_off_a2sys_clock(struct mt2701_afe *afe);
+void mt2701_turn_on_afe_clock(struct mt2701_afe *afe);
+void mt2701_turn_off_afe_clock(struct mt2701_afe *afe);
+void mt2701_mclk_configuration(struct mt2701_afe *afe, int id, int domain,
+			       int mclk);
+
+#endif
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-common.h b/sound/soc/mediatek/mt2701/mt2701-afe-common.h
new file mode 100644
index 0000000..d801bce
--- /dev/null
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-common.h
@@ -0,0 +1,228 @@
+/*
+ * mt2701-afe-common.h  --  Mediatek 2701 audio driver definitions
+ *
+ * Copyright (c) 2016 MediaTek Inc.
+ * Author: Garlic Tseng <garlic.tseng@mediatek.com>
+ *             Koro Chen <koro.chen@mediatek.com>
+ *             Sascha Hauer <s.hauer@pengutronix.de>
+ *             Hidalgo Huang <hidalgo.huang@mediatek.com>
+ *             Ir Lian <ir.lian@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _MT_2701_AFE_COMMON_H_
+#define _MT_2701_AFE_COMMON_H_
+#include <sound/soc.h>
+#include <linux/clk.h>
+#include <linux/regmap.h>
+#include "mt2701-reg.h"
+
+#define MT2701_STREAM_DIR_NUM (SNDRV_PCM_STREAM_LAST + 1)
+#define MT2701_PLL_DOMAIN_0_RATE	98304000
+#define MT2701_PLL_DOMAIN_1_RATE	90316800
+#define MT2701_AUD_TOP_AUD_MUX1_DIV_RATE (MT2701_PLL_DOMAIN_0_RATE / 2)
+#define MT2701_AUD_TOP_AUD_MUX2_DIV_RATE (MT2701_PLL_DOMAIN_1_RATE / 2)
+
+enum {
+	MT2701_I2S_1,
+	MT2701_I2S_2,
+	MT2701_I2S_3,
+	MT2701_I2S_4,
+	MT2701_I2S_NUM,
+};
+
+enum {
+	MT2701_MEMIF_1,
+	MT2701_MEMIF_2,
+	MT2701_MEMIF_3,
+	MT2701_MEMIF_4,
+	MT2701_MEMIF_5,
+	MT2701_MEMIF_SINGLE_NUM,
+	MT2701_MEMIF_M = MT2701_MEMIF_SINGLE_NUM,
+	MT2701_MEMIF_BT,
+	MT2701_MEMIF_NUM,
+	MT2701_IO_I2S = MT2701_MEMIF_NUM,
+	MT2701_IO_2ND_I2S,
+	MT2701_IO_3RD_I2S,
+	MT2701_IO_4TH_I2S,
+	MT2701_IO_5TH_I2S,
+	MT2701_IO_6TH_I2S,
+	MT2701_IO_MRG,
+};
+
+enum {
+	MT2701_IRQ_ASYS_START,
+	MT2701_IRQ_ASYS_IRQ1 = MT2701_IRQ_ASYS_START,
+	MT2701_IRQ_ASYS_IRQ2,
+	MT2701_IRQ_ASYS_IRQ3,
+	MT2701_IRQ_ASYS_END,
+};
+
+enum {
+	DIV_ID_MCLK_TO_BCK,
+	DIV_ID_BCK_TO_LRCK,
+};
+
+/*2701 clock def*/
+enum audio_system_clock_type {
+	MT2701_AUD_INFRA_SYS_AUDIO,
+	MT2701_AUD_TOP_AUD_MUX1_SEL,
+	MT2701_AUD_TOP_AUD_MUX2_SEL,
+	MT2701_AUD_TOP_AUD_MUX1_DIV,
+	MT2701_AUD_TOP_AUD_MUX2_DIV,
+	MT2701_AUD_TOP_AUD_48K_TIMING,
+	MT2701_AUD_TOP_AUD_44K_TIMING,
+	MT2701_AUD_TOP_AUDPLL_MUX_SEL,
+	MT2701_AUD_TOP_APLL_SEL,
+	MT2701_AUD_TOP_AUD1PLL_98M,
+	MT2701_AUD_TOP_AUD2PLL_90M,
+	MT2701_AUD_TOP_HADDS2PLL_98M,
+	MT2701_AUD_TOP_HADDS2PLL_294M,
+	MT2701_AUD_TOP_AUDPLL,
+	MT2701_AUD_TOP_AUDPLL_D4,
+	MT2701_AUD_TOP_AUDPLL_D8,
+	MT2701_AUD_TOP_AUDPLL_D16,
+	MT2701_AUD_TOP_AUDPLL_D24,
+	MT2701_AUD_TOP_AUDINTBUS,
+	MT2701_AUD_CLK_26M,
+	MT2701_AUD_TOP_SYSPLL1_D4,
+	MT2701_AUD_TOP_AUD_K1_SRC_SEL,
+	MT2701_AUD_TOP_AUD_K2_SRC_SEL,
+	MT2701_AUD_TOP_AUD_K3_SRC_SEL,
+	MT2701_AUD_TOP_AUD_K4_SRC_SEL,
+	MT2701_AUD_TOP_AUD_K5_SRC_SEL,
+	MT2701_AUD_TOP_AUD_K6_SRC_SEL,
+	MT2701_AUD_TOP_AUD_K1_SRC_DIV,
+	MT2701_AUD_TOP_AUD_K2_SRC_DIV,
+	MT2701_AUD_TOP_AUD_K3_SRC_DIV,
+	MT2701_AUD_TOP_AUD_K4_SRC_DIV,
+	MT2701_AUD_TOP_AUD_K5_SRC_DIV,
+	MT2701_AUD_TOP_AUD_K6_SRC_DIV,
+	MT2701_AUD_TOP_AUD_I2S1_MCLK,
+	MT2701_AUD_TOP_AUD_I2S2_MCLK,
+	MT2701_AUD_TOP_AUD_I2S3_MCLK,
+	MT2701_AUD_TOP_AUD_I2S4_MCLK,
+	MT2701_AUD_TOP_AUD_I2S5_MCLK,
+	MT2701_AUD_TOP_AUD_I2S6_MCLK,
+	MT2701_AUD_TOP_ASM_M_SEL,
+	MT2701_AUD_TOP_ASM_H_SEL,
+	MT2701_AUD_TOP_UNIVPLL2_D4,
+	MT2701_AUD_TOP_UNIVPLL2_D2,
+	MT2701_AUD_TOP_SYSPLL_D5,
+	MT2701_CLOCK_NUM
+};
+
+static const unsigned int mt2701_afe_backup_list[] = {
+	AUDIO_TOP_CON0,
+	AUDIO_TOP_CON4,
+	AUDIO_TOP_CON5,
+	ASYS_TOP_CON,
+	AFE_CONN0,
+	AFE_CONN1,
+	AFE_CONN2,
+	AFE_CONN3,
+	AFE_CONN15,
+	AFE_CONN16,
+	AFE_CONN17,
+	AFE_CONN18,
+	AFE_CONN19,
+	AFE_CONN20,
+	AFE_CONN21,
+	AFE_CONN22,
+	AFE_DAC_CON0,
+	AFE_MEMIF_PBUF_SIZE,
+};
+
+struct mt2701_afe;
+struct snd_pcm_substream;
+
+struct mt2701_afe_memif_data {
+	int id;
+	const char *name;
+	int reg_ofs_base;
+	int reg_ofs_cur;
+	int fs_reg;
+	int fs_shift;
+	int mono_reg;
+	int mono_shift;
+	int enable_shift;
+	int hd_reg;
+	int hd_shift;
+	int agent_disable_shift;
+};
+
+struct mt2701_afe_irq_data {
+	int irq_id;
+	int irq_cnt_reg;
+	int irq_cnt_shift;
+	int irq_cnt_maskbit;
+	int irq_fs_reg;
+	int irq_fs_shift;
+	int irq_fs_maskbit;
+	int irq_en_reg;
+	int irq_en_shift;
+	int irq_occupy;
+};
+
+struct mt2701_afe_irq {
+	const struct mt2701_afe_irq_data *irq_data;
+	int irq_occupyed;
+	struct mt2701_afe_memif *memif;
+	void (*isr)(struct mt2701_afe *afe, struct mt2701_afe_memif *memif);
+};
+
+struct mt2701_afe_memif {
+	unsigned int phys_buf_addr;
+	int buffer_size;
+	struct snd_pcm_substream *substream;
+	const struct mt2701_afe_memif_data *data;
+	struct mt2701_afe_irq *irq;
+};
+
+struct mt2701_i2s_data {
+	int i2s_ctrl_reg;
+	int i2s_pwn_shift;
+	int i2s_asrc_fs_shift;
+	int i2s_asrc_fs_mask;
+};
+
+enum mt2701_i2s_dir {
+	I2S_OUT,
+	I2S_IN,
+	I2S_DIR_NUM,
+};
+
+struct mt2701_i2s_path {
+	int dai_id;
+	int mclk_rate;
+	int div_mclk_to_bck;
+	int div_bck_to_lrck;
+	int format;
+	snd_pcm_format_t stream_fmt;
+	int on[I2S_DIR_NUM];
+	int occupied[I2S_DIR_NUM];
+	const struct mt2701_i2s_data *i2s_data[2];
+};
+
+struct mt2701_afe {
+	void __iomem *base_addr;
+	struct device *dev;
+	struct regmap *regmap;
+	struct mt2701_afe_memif memif[MT2701_MEMIF_NUM][MT2701_STREAM_DIR_NUM];
+	struct clk *clocks[MT2701_CLOCK_NUM];
+	struct mt2701_afe_irq irqs[MT2701_IRQ_ASYS_END];
+	struct mt2701_i2s_path i2s_path[MT2701_I2S_NUM];
+	bool mrg_enable[MT2701_STREAM_DIR_NUM];
+	unsigned int backup_regs[ARRAY_SIZE(mt2701_afe_backup_list)];
+	bool suspended;
+};
+
+#endif
diff --git a/sound/soc/mediatek/mt2701/mt2701-irq.c b/sound/soc/mediatek/mt2701/mt2701-irq.c
new file mode 100644
index 0000000..302766a
--- /dev/null
+++ b/sound/soc/mediatek/mt2701/mt2701-irq.c
@@ -0,0 +1,74 @@
+/*
+ * mt2701-irq.c  --  Mediatek 2701 audio driver irq function
+ *
+ * Copyright (c) 2016 MediaTek Inc.
+ * Author: Garlic Tseng <garlic.tseng@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include "mt2701-afe-common.h"
+#include "mt2701-irq.h"
+
+u32 mt2701_asys_irq_status(struct mt2701_afe *afe)
+{
+	u32 status = 0;
+
+	regmap_read(afe->regmap, ASYS_IRQ_STATUS, &status);
+	return status;
+}
+
+void mt2701_asys_irq_clear(struct mt2701_afe *afe, u32 status)
+{
+	regmap_write(afe->regmap, ASYS_IRQ_CLR, status);
+}
+
+void mt2701_memif_isr(struct mt2701_afe *afe, struct mt2701_afe_memif *memif)
+{
+	if (memif)
+		snd_pcm_period_elapsed(memif->substream);
+}
+
+static DEFINE_MUTEX(asys_irqs_lock);
+int mt2701_asys_irq_acquire(struct mt2701_afe *afe)
+{
+	int i;
+
+	mutex_lock(&asys_irqs_lock);
+	for (i = MT2701_IRQ_ASYS_START; i < MT2701_IRQ_ASYS_END; ++i) {
+		if (afe->irqs[i].irq_occupyed == 0) {
+			afe->irqs[i].irq_occupyed = 1;
+			mutex_unlock(&asys_irqs_lock);
+			return i;
+		}
+	}
+	mutex_unlock(&asys_irqs_lock);
+	return MT2701_IRQ_ASYS_END;
+}
+
+int mt2701_asys_irq_release(struct mt2701_afe *afe, int irq_id)
+{
+	mutex_lock(&asys_irqs_lock);
+	if (irq_id >= MT2701_IRQ_ASYS_START && irq_id < MT2701_IRQ_ASYS_END) {
+		afe->irqs[irq_id].irq_occupyed = 0;
+		mutex_unlock(&asys_irqs_lock);
+		return 0;
+	}
+	mutex_unlock(&asys_irqs_lock);
+	return -EINVAL;
+}
+
+MODULE_DESCRIPTION("MT2701 irq control");
+MODULE_AUTHOR("Garlic Tseng <garlic.tseng@mediatek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/mediatek/mt2701/mt2701-irq.h b/sound/soc/mediatek/mt2701/mt2701-irq.h
new file mode 100644
index 0000000..3c31037
--- /dev/null
+++ b/sound/soc/mediatek/mt2701/mt2701-irq.h
@@ -0,0 +1,26 @@
+/*
+ * mt2701-irq.h  --  Mediatek 2701 audio driver irq function definition
+ *
+ * Copyright (c) 2016 MediaTek Inc.
+ * Author: Garlic Tseng <garlic.tseng@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _MT_2701_IRQ_H_
+#define _MT_2701_IRQ_H_
+
+u32 mt2701_asys_irq_status(struct mt2701_afe *afe);
+void mt2701_asys_irq_clear(struct mt2701_afe *afe, u32 status);
+void mt2701_memif_isr(struct mt2701_afe *afe, struct mt2701_afe_memif *memif);
+int mt2701_asys_irq_acquire(struct mt2701_afe *afe);
+int mt2701_asys_irq_release(struct mt2701_afe *afe, int irq_id);
+
+#endif
diff --git a/sound/soc/mediatek/mt2701/mt2701-reg.h b/sound/soc/mediatek/mt2701/mt2701-reg.h
new file mode 100644
index 0000000..c9c52a8
--- /dev/null
+++ b/sound/soc/mediatek/mt2701/mt2701-reg.h
@@ -0,0 +1,195 @@
+/*
+ * mt2701-reg.h  --  Mediatek 2701 audio driver reg definition
+ *
+ * Copyright (c) 2016 MediaTek Inc.
+ * Author: Garlic Tseng <garlic.tseng@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _MT2701_REG_H_
+#define _MT2701_REG_H_
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/pm_runtime.h>
+#include <sound/soc.h>
+#include "mt2701-afe-common.h"
+
+/*****************************************************************************
+ *                  R E G I S T E R       D E F I N I T I O N
+ *****************************************************************************/
+#define AUDIO_TOP_CON0 0x0000
+#define AUDIO_TOP_CON4 0x0010
+#define AUDIO_TOP_CON5 0x0014
+#define AFE_DAIBT_CON0 0x001c
+#define AFE_MRGIF_CON 0x003c
+#define ASMI_TIMING_CON1 0x0100
+#define ASMO_TIMING_CON1 0x0104
+#define PWR1_ASM_CON1 0x0108
+#define AFE_BT_SECURITY0 0x0320
+#define AFE_BT_SECURITY1 0x0324
+#define ASYS_TOP_CON 0x0600
+#define ASYS_I2SIN1_CON 0x0604
+#define ASYS_I2SIN2_CON 0x0608
+#define ASYS_I2SIN3_CON 0x060c
+#define ASYS_I2SIN4_CON 0x0610
+#define ASYS_I2SIN5_CON 0x0614
+#define ASYS_I2SO1_CON 0x061C
+#define ASYS_I2SO2_CON 0x0620
+#define ASYS_I2SO3_CON 0x0624
+#define ASYS_I2SO4_CON 0x0628
+#define ASYS_I2SO5_CON 0x062c
+#define PWR2_TOP_CON 0x0634
+#define AFE_CONN0 0x06c0
+#define AFE_CONN1 0x06c4
+#define AFE_CONN2 0x06c8
+#define AFE_CONN3 0x06cc
+#define AFE_CONN14 0x06f8
+#define AFE_CONN15 0x06fc
+#define AFE_CONN16 0x0700
+#define AFE_CONN17 0x0704
+#define AFE_CONN18 0x0708
+#define AFE_CONN19 0x070c
+#define AFE_CONN20 0x0710
+#define AFE_CONN21 0x0714
+#define AFE_CONN22 0x0718
+#define AFE_CONN23 0x071c
+#define AFE_CONN24 0x0720
+#define AFE_CONN41 0x0764
+#define ASYS_IRQ1_CON 0x0780
+#define ASYS_IRQ2_CON 0x0784
+#define ASYS_IRQ3_CON 0x0788
+#define ASYS_IRQ_CLR 0x07c0
+#define ASYS_IRQ_STATUS 0x07c4
+#define PWR2_ASM_CON1 0x1070
+#define AFE_DAC_CON0 0x1200
+#define AFE_DAC_CON1 0x1204
+#define AFE_DAC_CON2 0x1208
+#define AFE_DAC_CON3 0x120c
+#define AFE_DAC_CON4 0x1210
+#define AFE_MEMIF_HD_CON1 0x121c
+#define AFE_MEMIF_PBUF_SIZE 0x1238
+#define AFE_MEMIF_HD_CON0 0x123c
+#define AFE_DL1_BASE 0x1240
+#define AFE_DL1_CUR 0x1244
+#define AFE_DL2_BASE 0x1250
+#define AFE_DL2_CUR 0x1254
+#define AFE_DL3_BASE 0x1260
+#define AFE_DL3_CUR 0x1264
+#define AFE_DL4_BASE 0x1270
+#define AFE_DL4_CUR 0x1274
+#define AFE_DL5_BASE 0x1280
+#define AFE_DL5_CUR 0x1284
+#define AFE_DLMCH_BASE 0x12a0
+#define AFE_DLMCH_CUR 0x12a4
+#define AFE_ARB1_BASE 0x12b0
+#define AFE_ARB1_CUR 0x12b4
+#define AFE_VUL_BASE 0x1300
+#define AFE_VUL_CUR 0x130c
+#define AFE_UL2_BASE 0x1310
+#define AFE_UL2_END 0x1318
+#define AFE_UL2_CUR 0x131c
+#define AFE_UL3_BASE 0x1320
+#define AFE_UL3_END 0x1328
+#define AFE_UL3_CUR 0x132c
+#define AFE_UL4_BASE 0x1330
+#define AFE_UL4_END 0x1338
+#define AFE_UL4_CUR 0x133c
+#define AFE_UL5_BASE 0x1340
+#define AFE_UL5_END 0x1348
+#define AFE_UL5_CUR 0x134c
+#define AFE_DAI_BASE 0x1370
+#define AFE_DAI_CUR 0x137c
+
+/*AUDIO_TOP_CON0 (0x0000)*/
+#define AUDIO_TOP_CON0_A1SYS_A2SYS_ON	(0x3 << 0)
+#define AUDIO_TOP_CON0_PDN_AFE		(0x1 << 2)
+#define AUDIO_TOP_CON0_PDN_APLL_CK	(0x1 << 23)
+
+/*AUDIO_TOP_CON4 (0x0010)*/
+#define AUDIO_TOP_CON4_I2SO1_PWN	(0x1 << 6)
+#define AUDIO_TOP_CON4_PDN_A1SYS	(0x1 << 21)
+#define AUDIO_TOP_CON4_PDN_A2SYS	(0x1 << 22)
+#define AUDIO_TOP_CON4_PDN_AFE_CONN	(0x1 << 23)
+#define AUDIO_TOP_CON4_PDN_MRGIF	(0x1 << 25)
+
+/*AFE_DAIBT_CON0 (0x001c)*/
+#define AFE_DAIBT_CON0_DAIBT_EN		(0x1 << 0)
+#define AFE_DAIBT_CON0_BT_FUNC_EN	(0x1 << 1)
+#define AFE_DAIBT_CON0_BT_FUNC_RDY	(0x1 << 3)
+#define AFE_DAIBT_CON0_BT_WIDE_MODE_EN	(0x1 << 9)
+#define AFE_DAIBT_CON0_MRG_USE		(0x1 << 12)
+
+/*PWR1_ASM_CON1 (0x0108)*/
+#define PWR1_ASM_CON1_INIT_VAL		(0x492)
+
+/*AFE_MRGIF_CON (0x003c)*/
+#define AFE_MRGIF_CON_MRG_EN		(0x1 << 0)
+#define AFE_MRGIF_CON_MRG_I2S_EN	(0x1 << 16)
+#define AFE_MRGIF_CON_I2S_MODE_MASK	(0xf << 20)
+#define AFE_MRGIF_CON_I2S_MODE_32K	(0x4 << 20)
+
+/*AFE_BT_SECURITY0 (0x0320)*/
+#define AFE_BT_SECURITY0_INIT_VAL	(0x235000)
+
+/*AFE_BT_SECURITY1 (0x0324)*/
+#define AFE_BT_SECURITY1_INIT_VAL	(0x5)
+
+/* ASYS_I2SO1_CON (0x061c)*/
+#define ASYS_I2SO1_CON_FS		(0x1f << 8)
+#define ASYS_I2SO1_CON_FS_SET(x)	((x) << 8)
+#define ASYS_I2SO1_CON_MULTI_CH		(0x1 << 16)
+#define ASYS_I2SO1_CON_SIDEGEN		(0x1 << 30)
+#define ASYS_I2SO1_CON_I2S_EN		(0x1 << 0)
+/*0:EIAJ 1:I2S*/
+#define ASYS_I2SO1_CON_I2S_MODE		(0x1 << 3)
+#define ASYS_I2SO1_CON_WIDE_MODE	(0x1 << 1)
+#define ASYS_I2SO1_CON_WIDE_MODE_SET(x)	((x) << 1)
+
+/*PWR2_TOP_CON (0x0634)*/
+#define PWR2_TOP_CON_INIT_VAL		(0xffe1ffff)
+
+/*ASYS_IRQ_CLR (0x07c0)*/
+#define ASYS_IRQ_CLR_ALL		(0xffffffff)
+
+/*PWR2_ASM_CON1 (0x1070)*/
+#define PWR2_ASM_CON1_INIT_VAL		(0x492492)
+
+/*AFE_DAC_CON0 (0x1200)*/
+#define AFE_DAC_CON0_AFE_ON		(0x1 << 0)
+
+/* AFE_MEMIF_PBUF_SIZE (0x1238)*/
+#define AFE_MEMIF_PBUF_SIZE_DLM_MASK		(0x1 << 29)
+#define AFE_MEMIF_PBUF_SIZE_PAIR_INTERLEAVE	(0x0 << 29)
+#define AFE_MEMIF_PBUF_SIZE_FULL_INTERLEAVE	(0x1 << 29)
+#define DLMCH_BIT_WIDTH_MASK			(0x1 << 28)
+#define AFE_MEMIF_PBUF_SIZE_DLM_CH_MASK		(0xf << 24)
+#define AFE_MEMIF_PBUF_SIZE_DLM_CH(x)		((x) << 24)
+#define AFE_MEMIF_PBUF_SIZE_DLM_BYTE_MASK	(0x3 << 12)
+#define AFE_MEMIF_PBUF_SIZE_DLM_32BYTES		(0x1 << 12)
+
+/*I2S in/out register bit control*/
+#define ASYS_I2S_CON_FS			(0x1f << 8)
+#define ASYS_I2S_CON_FS_SET(x)		((x) << 8)
+#define ASYS_I2S_CON_MULTI_CH		(0x1 << 16)
+#define ASYS_I2S_CON_RESET		(0x1 << 30)
+#define ASYS_I2S_CON_I2S_EN		(0x1 << 0)
+#define ASYS_I2S_CON_I2S_COUPLE_MODE	(0x1 << 17)
+/*0:EIAJ 1:I2S*/
+#define ASYS_I2S_CON_I2S_MODE		(0x1 << 3)
+#define ASYS_I2S_CON_WIDE_MODE		(0x1 << 1)
+#define ASYS_I2S_CON_WIDE_MODE_SET(x)	((x) << 1)
+#define ASYS_I2S_IN_PHASE_FIX		(0x1 << 31)
+
+#define AFE_END_ADDR 0x15e0
+#endif
-- 
1.9.1
