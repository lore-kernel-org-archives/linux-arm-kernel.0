From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Thu, 14 Apr 2016 20:14:28 +0800
Subject: [alsa-devel] [RFC PATCH v2 3/5] ASoC: mediatek: add clock and irq
 control for 2701 platform driver
In-Reply-To: <1460636070-37426-1-git-send-email-garlic.tseng@mediatek.com>
References: <1460636070-37426-1-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <1460636070-37426-4-git-send-email-garlic.tseng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock and irq controls for 2701 platform driver.
There are some BLOCK_COMMENT_STYLE errors from checkpatch and they will be fixed
after BT functions finished.


Signed-off-by: Garlic Tseng <garlic.tseng@mediatek.com>
---
 sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.c | 259 +++++++++++++++++++++
 sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.h |  28 +++
 sound/soc/mediatek/mt2701/mtk2701-afe-common.h     | 217 +++++++++++++++++
 sound/soc/mediatek/mt2701/mtk2701-irq.c            | 109 +++++++++
 sound/soc/mediatek/mt2701/mtk2701-irq.h            |  30 +++
 sound/soc/mediatek/mt2701/mtk2701-reg.h            | 165 +++++++++++++
 6 files changed, 808 insertions(+)
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.c
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.h
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-afe-common.h
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-irq.c
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-irq.h
 create mode 100644 sound/soc/mediatek/mt2701/mtk2701-reg.h

diff --git a/sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.c b/sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.c
new file mode 100644
index 0000000..eb1334a
--- /dev/null
+++ b/sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.c
@@ -0,0 +1,259 @@
+/*
+ * mtk2701-afe-clock-ctrl.c  --  Mediatek 2701 afe clock ctrl
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
+#include "mtk2701-reg.h"
+#include "mtk2701-afe-common.h"
+#include "mtk2701-afe-clock-ctrl.h"
+
+void mtk2701_afe_enable_clock(struct mtk_afe *afe, int en)
+{
+	if (en) {
+		mtk2701_turn_on_a1sys_clock(afe);
+		mtk2701_turn_on_a2sys_clock(afe);
+		mtk2701_turn_on_afe_clock(afe);
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
+		mtk2701_turn_off_afe_clock(afe);
+		mtk2701_turn_off_a1sys_clock(afe);
+		mtk2701_turn_off_a2sys_clock(afe);
+		regmap_update_bits(afe->regmap, ASYS_TOP_CON,
+				   AUDIO_TOP_CON0_A1SYS_A2SYS_ON, 0);
+		regmap_update_bits(afe->regmap, AFE_DAC_CON0,
+				   AFE_DAC_CON0_AFE_ON, 0);
+	}
+}
+
+void mtk2701_turn_on_a1sys_clock(struct mtk_afe *afe)
+{
+	int ret = 0;
+	struct audio_clock_attr *aud_clks = afe->aud_clks;
+
+	/* Set Mux */
+	ret = clk_prepare_enable(aud_clks[AUDCLK_TOP_AUD_MUX1_SEL].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__,
+			aud_clks[AUDCLK_TOP_AUD_MUX1_SEL].clock_data->name,
+			ret);
+
+	ret = clk_set_parent(aud_clks[AUDCLK_TOP_AUD_MUX1_SEL].clock,
+			     aud_clks[AUDCLK_TOP_AUD1PLL_98M].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n", __func__,
+			aud_clks[AUDCLK_TOP_AUD_MUX1_SEL].clock_data->name,
+			aud_clks[AUDCLK_TOP_AUD1PLL_98M].clock_data->name, ret);
+
+	/* Set Divider */
+	ret = clk_prepare_enable(aud_clks[AUDCLK_TOP_AUD_MUX1_DIV].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__,
+			aud_clks[AUDCLK_TOP_AUD_MUX1_DIV].clock_data->name,
+			ret);
+	ret = clk_set_rate(aud_clks[AUDCLK_TOP_AUD_MUX1_DIV].clock,
+			   98304000 / 2);
+	if (ret)
+		dev_err(afe->dev, "%s clk_set_parent %s-%d fail %d\n", __func__,
+			aud_clks[AUDCLK_TOP_AUD_MUX1_DIV].clock_data->name,
+			98304000 / 2, ret);
+
+	/* Enable clock gate */
+	ret = clk_enable(aud_clks[AUDCLK_TOP_AUD_48K_TIMING].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_enable %s fail %d\n", __func__,
+			aud_clks[AUDCLK_TOP_AUD_48K_TIMING].clock_data->name,
+			ret);
+	/* Enable infra audio */
+	ret = clk_enable(aud_clks[AUDCLK_INFRA_SYS_AUDIO].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_enable %s fail %d\n", __func__,
+			aud_clks[AUDCLK_INFRA_SYS_AUDIO].clock_data->name, ret);
+}
+
+void mtk2701_turn_off_a1sys_clock(struct mtk_afe *afe)
+{
+	struct audio_clock_attr *aud_clks = afe->aud_clks;
+
+	clk_disable(aud_clks[AUDCLK_INFRA_SYS_AUDIO].clock);
+	clk_disable(aud_clks[AUDCLK_TOP_AUD_48K_TIMING].clock);
+	clk_disable_unprepare(aud_clks[AUDCLK_TOP_AUD_MUX1_DIV].clock);
+	clk_disable_unprepare(aud_clks[AUDCLK_TOP_AUD_MUX1_SEL].clock);
+}
+
+void mtk2701_turn_on_a2sys_clock(struct mtk_afe *afe)
+{
+	int ret = 0;
+	struct audio_clock_attr *aud_clks = afe->aud_clks;
+	/* Set Mux */
+	ret = clk_prepare_enable(aud_clks[AUDCLK_TOP_AUD_MUX2_SEL].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__,
+			aud_clks[AUDCLK_TOP_AUD_MUX2_SEL].clock_data->name,
+			ret);
+	ret = clk_set_parent(aud_clks[AUDCLK_TOP_AUD_MUX2_SEL].clock,
+			     aud_clks[AUDCLK_TOP_AUD2PLL_90M].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n", __func__,
+			aud_clks[AUDCLK_TOP_AUD_MUX2_SEL].clock_data->name,
+			aud_clks[AUDCLK_TOP_AUD2PLL_90M].clock_data->name, ret);
+	/* Set Divider */
+	ret = clk_prepare_enable(aud_clks[AUDCLK_TOP_AUD_MUX2_DIV].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__,
+			aud_clks[AUDCLK_TOP_AUD_MUX2_DIV].clock_data->name,
+			ret);
+	ret = clk_set_rate(aud_clks[AUDCLK_TOP_AUD_MUX2_DIV].clock,
+			   90316800 / 2);
+	if (ret)
+		dev_err(afe->dev, "%s clk_set_parent %s-%d fail %d\n", __func__,
+			aud_clks[AUDCLK_TOP_AUD_MUX2_DIV].clock_data->name,
+			90316800 / 2, ret);
+
+	/* Enable clock gate */
+	ret = clk_enable(aud_clks[AUDCLK_TOP_AUD_44K_TIMING].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_enable %s fail %d\n", __func__,
+			aud_clks[AUDCLK_TOP_AUD_44K_TIMING].clock_data->name,
+			ret);
+	/* Enable infra audio */
+	ret = clk_enable(aud_clks[AUDCLK_INFRA_SYS_AUDIO].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_enable %s fail %d\n", __func__,
+			aud_clks[AUDCLK_INFRA_SYS_AUDIO].clock_data->name, ret);
+}
+
+void mtk2701_turn_off_a2sys_clock(struct mtk_afe *afe)
+{
+	struct audio_clock_attr *aud_clks = afe->aud_clks;
+
+	clk_disable(aud_clks[AUDCLK_INFRA_SYS_AUDIO].clock);
+	clk_disable(aud_clks[AUDCLK_TOP_AUD_44K_TIMING].clock);
+	clk_disable_unprepare(aud_clks[AUDCLK_TOP_AUD_MUX2_DIV].clock);
+	clk_disable_unprepare(aud_clks[AUDCLK_TOP_AUD_MUX2_SEL].clock);
+}
+
+void mtk2701_turn_on_afe_clock(struct mtk_afe *afe)
+{
+	int ret;
+	struct audio_clock_attr *aud_clks = afe->aud_clks;
+
+	/*MT_CG_INFRA_AUDIO, INFRA_PDN_STA[5]*/
+	ret = clk_enable(aud_clks[AUDCLK_INFRA_SYS_AUDIO].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_enable %s fail %d\n", __func__,
+			aud_clks[AUDCLK_INFRA_SYS_AUDIO].clock_data->name, ret);
+
+	/* Set AUDCLK_TOP_AUDINTBUS to AUDCLK_TOP_SYSPLL1_D4 */
+	ret = clk_prepare_enable(aud_clks[AUDCLK_TOP_AUDINTBUS].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__,
+			aud_clks[AUDCLK_TOP_AUDINTBUS].clock_data->name, ret);
+
+	ret = clk_set_parent(aud_clks[AUDCLK_TOP_AUDINTBUS].clock,
+			     aud_clks[AUDCLK_TOP_SYSPLL1_D4].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n", __func__,
+			aud_clks[AUDCLK_TOP_AUDINTBUS].clock_data->name,
+			aud_clks[AUDCLK_TOP_SYSPLL1_D4].clock_data->name, ret);
+
+	/* Set AUDCLK_TOP_ASM_H_SEL to AUDCLK_TOP_UNIVPLL2_D2*/
+	ret = clk_prepare_enable(aud_clks[AUDCLK_TOP_ASM_H_SEL].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__,
+			aud_clks[AUDCLK_TOP_ASM_H_SEL].clock_data->name, ret);
+
+	ret = clk_set_parent(aud_clks[AUDCLK_TOP_ASM_H_SEL].clock,
+			     aud_clks[AUDCLK_TOP_UNIVPLL2_D2].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n", __func__,
+			aud_clks[AUDCLK_TOP_ASM_H_SEL].clock_data->name,
+			aud_clks[AUDCLK_TOP_UNIVPLL2_D2].clock_data->name, ret);
+
+	if (ret)
+		dev_err(afe->dev, "%s clk_enable %s fail %d\n", __func__,
+			aud_clks[AUDCLK_TOP_ASM_H_SEL].clock_data->name, ret);
+
+	/* Set AUDCLK_TOP_ASM_M_SEL to AUDCLK_TOP_UNIVPLL2_D4*/
+	ret = clk_prepare_enable(aud_clks[AUDCLK_TOP_ASM_M_SEL].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_prepare_enable %s fail %d\n",
+			__func__,
+			aud_clks[AUDCLK_TOP_ASM_M_SEL].clock_data->name, ret);
+
+	ret = clk_set_parent(aud_clks[AUDCLK_TOP_ASM_M_SEL].clock,
+			     aud_clks[AUDCLK_TOP_UNIVPLL2_D4].clock);
+	if (ret)
+		dev_err(afe->dev, "%s clk_set_parent %s-%s fail %d\n", __func__,
+			aud_clks[AUDCLK_TOP_ASM_M_SEL].clock_data->name,
+			aud_clks[AUDCLK_TOP_UNIVPLL2_D4].clock_data->name, ret);
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
+void mtk2701_turn_off_afe_clock(struct mtk_afe *afe)
+{
+	struct audio_clock_attr *aud_clks = afe->aud_clks;
+
+	/*MT_CG_INFRA_AUDIO,*/
+	clk_disable(aud_clks[AUDCLK_INFRA_SYS_AUDIO].clock);
+
+	clk_disable_unprepare(aud_clks[AUDCLK_TOP_AUDINTBUS].clock);
+	clk_disable_unprepare(aud_clks[AUDCLK_TOP_ASM_H_SEL].clock);
+	clk_disable_unprepare(aud_clks[AUDCLK_TOP_ASM_M_SEL].clock);
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
+MODULE_DESCRIPTION("MTK2701 afe clock control");
+MODULE_AUTHOR("Garlic Tseng <garlic.tseng@mediatek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.h b/sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.h
new file mode 100644
index 0000000..832b1a9
--- /dev/null
+++ b/sound/soc/mediatek/mt2701/mtk2701-afe-clock-ctrl.h
@@ -0,0 +1,28 @@
+/*
+ * mtk2701-afe-clock-ctrl.h  --  Mediatek 2701 afe clock ctrl definition
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
+#ifndef _MTK2701_AFE_CLOCK_CTRL_H_
+#define _MTK2701_AFE_CLOCK_CTRL_H_
+
+void mtk2701_afe_enable_clock(struct mtk_afe *afe, int en);
+void mtk2701_turn_on_a1sys_clock(struct mtk_afe *afe);
+void mtk2701_turn_off_a1sys_clock(struct mtk_afe *afe);
+void mtk2701_turn_on_a2sys_clock(struct mtk_afe *afe);
+void mtk2701_turn_off_a2sys_clock(struct mtk_afe *afe);
+void mtk2701_turn_on_afe_clock(struct mtk_afe *afe);
+void mtk2701_turn_off_afe_clock(struct mtk_afe *afe);
+
+#endif
diff --git a/sound/soc/mediatek/mt2701/mtk2701-afe-common.h b/sound/soc/mediatek/mt2701/mtk2701-afe-common.h
new file mode 100644
index 0000000..daf40dd
--- /dev/null
+++ b/sound/soc/mediatek/mt2701/mtk2701-afe-common.h
@@ -0,0 +1,217 @@
+/*
+ * mtk2701-afe-common.h  --  Mediatek 2701 audio driver definitions
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
+#ifndef _MTK_AFE_COMMON_H_
+#define _MTK_AFE_COMMON_H_
+#include <sound/soc.h>
+#include <linux/clk.h>
+#include <linux/regmap.h>
+
+#define MTK_MEMIF_STREAM_NUM (SNDRV_PCM_STREAM_LAST + 1)
+
+enum {
+	MTK_AFE_I2S_1,
+	MTK_AFE_I2S_2,
+	MTK_AFE_I2S_3,
+	MTK_AFE_I2S_4,
+	MTK_I2S_NUM,
+};
+
+enum {
+	MTK_AFE_MEMIF_1,
+	MTK_AFE_MEMIF_2,
+	MTK_AFE_MEMIF_3,
+	MTK_AFE_MEMIF_4,
+	MTK_AFE_MEMIF_5,
+	MTK_AFE_MEMIF_SINGLE_NUM,
+	MTK_AFE_MEMIF_M = MTK_AFE_MEMIF_SINGLE_NUM,
+	MTK_AFE_MEMIF_NUM,
+	MTK_AFE_IO_I2S = MTK_AFE_MEMIF_NUM,
+	MTK_AFE_IO_2ND_I2S,
+	MTK_AFE_IO_3RD_I2S,
+	MTK_AFE_IO_4TH_I2S,
+	MTK_AFE_IO_5TH_I2S,
+	MTK_AFE_IO_6TH_I2S,
+	MTK_AFE_IO_MRG_O,
+	MTK_AFE_IO_MRG_I,
+};
+
+enum {
+	/*need for DAIBT, will implement before review*/
+/*
+	IRQ_AFE_IRQ1,
+	IRQ_AFE_IRQ2,
+*/
+	IRQ_ASYS_START,
+	IRQ_ASYS_IRQ1 = IRQ_ASYS_START,
+	IRQ_ASYS_IRQ2,
+	IRQ_ASYS_IRQ3,
+	IRQ_ASYS_END,
+	IRQ_NUM = IRQ_ASYS_END,
+};
+
+enum {
+	DIV_ID_MCLK_TO_BCK,
+	DIV_ID_BCK_TO_LRCK,
+};
+
+/*2701 clock def*/
+enum audio_system_clock_type {
+	AUDCLK_INFRA_SYS_AUDIO,
+	AUDCLK_TOP_AUD_MUX1_SEL,
+	AUDCLK_TOP_AUD_MUX2_SEL,
+	AUDCLK_TOP_AUD_MUX1_DIV,
+	AUDCLK_TOP_AUD_MUX2_DIV,
+	AUDCLK_TOP_AUD_48K_TIMING,
+	AUDCLK_TOP_AUD_44K_TIMING,
+	AUDCLK_TOP_AUDPLL_MUX_SEL,
+	AUDCLK_TOP_APLL_SEL,
+	AUDCLK_TOP_AUD1PLL_98M,
+	AUDCLK_TOP_AUD2PLL_90M,
+	AUDCLK_TOP_HADDS2PLL_98M,
+	AUDCLK_TOP_HADDS2PLL_294M,
+	AUDCLK_TOP_AUDPLL,
+	AUDCLK_TOP_AUDPLL_D4,
+	AUDCLK_TOP_AUDPLL_D8,
+	AUDCLK_TOP_AUDPLL_D16,
+	AUDCLK_TOP_AUDPLL_D24,
+	AUDCLK_TOP_AUDINTBUS,
+	AUDCLK_CLK_26M,
+	AUDCLK_TOP_SYSPLL1_D4,
+	AUDCLK_TOP_AUD_K1_SRC_SEL,
+	AUDCLK_TOP_AUD_K2_SRC_SEL,
+	AUDCLK_TOP_AUD_K3_SRC_SEL,
+	AUDCLK_TOP_AUD_K4_SRC_SEL,
+	AUDCLK_TOP_AUD_K5_SRC_SEL,
+	AUDCLK_TOP_AUD_K6_SRC_SEL,
+	AUDCLK_TOP_AUD_K1_SRC_DIV,
+	AUDCLK_TOP_AUD_K2_SRC_DIV,
+	AUDCLK_TOP_AUD_K3_SRC_DIV,
+	AUDCLK_TOP_AUD_K4_SRC_DIV,
+	AUDCLK_TOP_AUD_K5_SRC_DIV,
+	AUDCLK_TOP_AUD_K6_SRC_DIV,
+	AUDCLK_TOP_AUD_I2S1_MCLK,
+	AUDCLK_TOP_AUD_I2S2_MCLK,
+	AUDCLK_TOP_AUD_I2S3_MCLK,
+	AUDCLK_TOP_AUD_I2S4_MCLK,
+	AUDCLK_TOP_AUD_I2S5_MCLK,
+	AUDCLK_TOP_AUD_I2S6_MCLK,
+	AUDCLK_TOP_ASM_M_SEL,
+	AUDCLK_TOP_ASM_H_SEL,
+	AUDCLK_TOP_UNIVPLL2_D4,
+	AUDCLK_TOP_UNIVPLL2_D2,
+	AUDCLK_TOP_SYSPLL_D5,
+	CLOCK_NUM
+};
+
+struct audio_clock_attr_data {
+	const char *name;
+	const bool prepare_once;
+};
+
+struct audio_clock_attr {
+	struct audio_clock_attr_data *clock_data;
+	bool is_prepared;
+	struct clk *clock;
+};
+
+struct mtk_afe;
+struct snd_pcm_substream;
+
+struct mtk_afe_memif_data {
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
+struct mtk_afe_irq_data {
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
+struct mtk_afe_irq {
+	const struct mtk_afe_irq_data *irq_data;
+	int irq_occupyed;
+	struct mtk_afe_memif *memif;
+	void (*isr)(struct mtk_afe *afe, struct mtk_afe_memif *memif);
+};
+
+struct mtk_afe_memif {
+	unsigned int phys_buf_addr;
+	int buffer_size;
+	unsigned int hw_ptr;
+	struct snd_pcm_substream *substream;
+	const struct mtk_afe_memif_data *data;
+	struct mtk_afe_irq *irq;
+};
+
+struct mtk_i2s_data {
+	int i2s_ctrl_reg;
+	int i2s_pwn_shift;
+	int i2s_asrc_fs_shift;
+	int i2s_asrc_fs_mask;
+};
+
+enum mtk_i2s_dir {
+	I2S_OUT,
+	I2S_IN,
+	I2S_DIR_NUM,
+};
+
+struct mtk_i2s_path {
+	int dai_id;
+	int mclk_rate;
+	int div_mclk_to_bck;
+	int div_bck_to_lrck;
+	int format;
+	snd_pcm_format_t stream_fmt;
+	int on[I2S_DIR_NUM];
+	int occupied[I2S_DIR_NUM];
+	const struct mtk_i2s_data *i2s_data[2];
+};
+
+struct mtk_afe {
+	void __iomem *base_addr;
+	struct device *dev;
+	struct regmap *regmap;
+	struct mtk_afe_memif memif[MTK_AFE_MEMIF_NUM][MTK_MEMIF_STREAM_NUM];
+	struct audio_clock_attr aud_clks[CLOCK_NUM];
+	struct mtk_afe_irq irqs[IRQ_NUM];
+	struct mtk_i2s_path i2s_path[MTK_I2S_NUM];
+};
+
+#endif
diff --git a/sound/soc/mediatek/mt2701/mtk2701-irq.c b/sound/soc/mediatek/mt2701/mtk2701-irq.c
new file mode 100644
index 0000000..a319ae5
--- /dev/null
+++ b/sound/soc/mediatek/mt2701/mtk2701-irq.c
@@ -0,0 +1,109 @@
+/*
+ * mtk2701-irq.c  --  Mediatek 2701 audio driver irq function
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
+#include "mtk2701-reg.h"
+#include "mtk2701-afe-common.h"
+#include "mtk2701-irq.h"
+
+u32 mtk2701_asys_irq_status(struct mtk_afe *afe)
+{
+	u32 status = 0;
+
+	regmap_read(afe->regmap, ASYS_IRQ_STATUS, &status);
+	return status;
+}
+
+void mtk2701_asys_irq_clear(struct mtk_afe *afe, u32 status)
+{
+	regmap_write(afe->regmap, ASYS_IRQ_CLR, status);
+}
+
+void mtk2701_memif_isr(struct mtk_afe *afe, struct mtk_afe_memif *memif)
+{
+	if (memif) {
+		u32 base, cur;
+
+		mtk2701_afe_memif_base(afe, memif, &base);
+		mtk2701_afe_memif_pointer(afe, memif, &cur);
+		memif->hw_ptr = cur - base;
+		snd_pcm_period_elapsed(memif->substream);
+	}
+}
+
+int mtk2701_afe_memif_base(struct mtk_afe *afe, struct mtk_afe_memif *memif,
+			   u32 *base)
+{
+	if (!memif || !memif->data) {
+		dev_err(afe->dev, "%s() error: invalid memif %p\n",
+			__func__, memif);
+		return -EINVAL;
+	}
+	if (!base)
+		return -ENOMEM;
+	regmap_read(afe->regmap, memif->data->reg_ofs_base, base);
+	return 0;
+}
+
+int mtk2701_afe_memif_pointer(struct mtk_afe *afe, struct mtk_afe_memif *memif,
+			      u32 *cur_ptr)
+{
+	if (!memif || !memif->data) {
+		dev_err(afe->dev, "%s() error: invalid memif %p\n",
+			__func__, memif);
+		return -EINVAL;
+	}
+	if (!cur_ptr)
+		return -ENOMEM;
+	regmap_read(afe->regmap, memif->data->reg_ofs_cur, cur_ptr);
+	return 0;
+}
+
+static DEFINE_MUTEX(asys_irqs_lock);
+int mtk2701_asys_irq_acquire(struct mtk_afe *afe)
+{
+	int i;
+
+	mutex_lock(&asys_irqs_lock);
+	for (i = IRQ_ASYS_START; i < IRQ_ASYS_END; ++i) {
+		if (afe->irqs[i].irq_occupyed == 0) {
+			afe->irqs[i].irq_occupyed = 1;
+			mutex_unlock(&asys_irqs_lock);
+			return i;
+		}
+	}
+	mutex_unlock(&asys_irqs_lock);
+	return IRQ_NUM;
+}
+
+int mtk2701_asys_irq_release(struct mtk_afe *afe, int irq_id)
+{
+	mutex_lock(&asys_irqs_lock);
+	if (irq_id >= IRQ_ASYS_START && irq_id < IRQ_ASYS_END) {
+		afe->irqs[irq_id].irq_occupyed = 0;
+		mutex_unlock(&asys_irqs_lock);
+		return 0;
+	}
+	mutex_unlock(&asys_irqs_lock);
+	return -EINVAL;
+}
+
+MODULE_DESCRIPTION("MTK2701 irq control");
+MODULE_AUTHOR("Garlic Tseng <garlic.tseng@mediatek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/mediatek/mt2701/mtk2701-irq.h b/sound/soc/mediatek/mt2701/mtk2701-irq.h
new file mode 100644
index 0000000..637d304
--- /dev/null
+++ b/sound/soc/mediatek/mt2701/mtk2701-irq.h
@@ -0,0 +1,30 @@
+/*
+ * mtk2701-irq.h  --  Mediatek 2701 audio driver irq function definition
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
+#ifndef _MTK_2701_IRQ_H_
+#define _MTK_2701_IRQ_H_
+
+u32 mtk2701_asys_irq_status(struct mtk_afe *afe);
+void mtk2701_asys_irq_clear(struct mtk_afe *afe, u32 status);
+void mtk2701_memif_isr(struct mtk_afe *afe, struct mtk_afe_memif *memif);
+int mtk2701_afe_memif_base(struct mtk_afe *afe, struct mtk_afe_memif *memif,
+			   u32 *base);
+int mtk2701_afe_memif_pointer(struct mtk_afe *afe, struct mtk_afe_memif *memif,
+			      u32 *cur_ptr);
+int mtk2701_asys_irq_acquire(struct mtk_afe *afe);
+int mtk2701_asys_irq_release(struct mtk_afe *afe, int irq_id);
+
+#endif
diff --git a/sound/soc/mediatek/mt2701/mtk2701-reg.h b/sound/soc/mediatek/mt2701/mtk2701-reg.h
new file mode 100644
index 0000000..4f83dcc
--- /dev/null
+++ b/sound/soc/mediatek/mt2701/mtk2701-reg.h
@@ -0,0 +1,165 @@
+/*
+ * mtk2701-reg.h  --  Mediatek 2701 audio driver reg definition
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
+#ifndef _MTK2701_REG_H_
+#define _MTK2701_REG_H_
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/pm_runtime.h>
+#include <sound/soc.h>
+#include "mtk2701-afe-common.h"
+
+/*****************************************************************************
+ *                  R E G I S T E R       D E F I N I T I O N
+ *****************************************************************************/
+#define AUDIO_TOP_CON0 0x0000
+#define AUDIO_TOP_CON4 0x0010
+#define AUDIO_TOP_CON5 0x0014
+#define ASMI_TIMING_CON1 0x0100
+#define ASMO_TIMING_CON1 0x0104
+#define PWR1_ASM_CON1 0x0108
+#define ASYS_TOP_CON 0x0600
+#define ASYS_I2SIN1_CON 0x0604
+#define ASYS_I2SIN2_CON 0x0608
+#define ASYS_I2SIN3_CON 0x060C
+#define ASYS_I2SIN4_CON 0x0610
+#define ASYS_I2SIN5_CON 0x0614
+#define ASYS_I2SO1_CON 0x061C
+#define ASYS_I2SO2_CON 0x0620
+#define ASYS_I2SO3_CON 0x0624
+#define ASYS_I2SO4_CON 0x0628
+#define ASYS_I2SO5_CON 0x062C
+#define PWR2_TOP_CON 0x0634
+#define AFE_CONN0 0x06C0
+#define AFE_CONN1 0x06C4
+#define AFE_CONN2 0x06C8
+#define AFE_CONN3 0x06CC
+#define AFE_CONN15 0x06FC
+#define AFE_CONN16 0x0700
+#define AFE_CONN17 0x0704
+#define AFE_CONN18 0x0708
+#define AFE_CONN19 0x070C
+#define AFE_CONN20 0x0710
+#define AFE_CONN21 0x0714
+#define AFE_CONN22 0x0718
+#define AFE_CONN23 0x071C
+#define AFE_CONN24 0x0720
+#define ASYS_IRQ1_CON 0x0780
+#define ASYS_IRQ2_CON 0x0784
+#define ASYS_IRQ3_CON 0x0788
+#define ASYS_IRQ_CLR 0x07C0
+#define ASYS_IRQ_STATUS 0x07C4
+#define PWR2_ASM_CON1 0x1070
+#define AFE_DAC_CON0 0x1200
+#define AFE_DAC_CON1 0x1204
+#define AFE_DAC_CON2 0x1208
+#define AFE_DAC_CON3 0x120C
+#define AFE_DAC_CON4 0x1210
+#define AFE_MEMIF_HD_CON1 0x121C
+#define AFE_MEMIF_PBUF_SIZE 0x1238
+#define AFE_MEMIF_HD_CON0 0x123C
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
+#define AFE_DLMCH_BASE 0x12A0
+#define AFE_DLMCH_CUR 0x12A4
+#define AFE_VUL_BASE 0x1300
+#define AFE_VUL_CUR 0x130C
+#define AFE_UL2_BASE 0x1310
+#define AFE_UL2_END 0x1318
+#define AFE_UL2_CUR 0x131C
+#define AFE_UL3_BASE 0x1320
+#define AFE_UL3_END 0x1328
+#define AFE_UL3_CUR 0x132C
+#define AFE_UL4_BASE 0x1330
+#define AFE_UL4_END 0x1338
+#define AFE_UL4_CUR 0x133C
+#define AFE_UL5_BASE 0x1340
+#define AFE_UL5_END 0x1348
+#define AFE_UL5_CUR 0x134C
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
+
+/*PWR1_ASM_CON1 (0x0108)*/
+#define PWR1_ASM_CON1_INIT_VAL		(0x492)
+
+/* ASYS_I2SO1_CON (0x061C)*/
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
+/*ASYS_IRQ_CLR (0x07C0)*/
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
+#define AFE_MEMIF_PBUF_SIZE_DLM_CH_MASK		(0xF << 24)
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
