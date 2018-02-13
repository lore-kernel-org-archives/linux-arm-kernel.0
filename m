From: srinivas.kandagatla@linaro.org (srinivas.kandagatla at linaro.org)
Date: Tue, 13 Feb 2018 16:58:32 +0000
Subject: [PATCH v3 20/25] ASoC: qcom: q6afe: add support to MI2S sysclks
In-Reply-To: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180213165837.1620-21-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to LPASS Bit clock, LPASS Digital
core clock and OSR clock. These clocks are required for both
MI2S and PCM setup.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 115 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.h |  10 ++++
 2 files changed, 125 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index c04caea5481c..ea6fa3848007 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -31,6 +31,9 @@
 
 #define AFE_PARAM_ID_CDC_SLIMBUS_SLAVE_CFG 0x00010235
 
+#define AFE_PARAM_ID_LPAIF_CLK_CONFIG	0x00010238
+#define AFE_PARAM_ID_INTERNAL_DIGITAL_CDC_CLK_CONFIG	0x00010239
+
 #define AFE_PARAM_ID_SLIMBUS_CONFIG    0x00010212
 #define AFE_PARAM_ID_I2S_CONFIG	0x0001020D
 
@@ -94,6 +97,11 @@
 #define AFE_PORT_ID_QUATERNARY_MI2S_RX      0x1006
 #define AFE_PORT_ID_QUATERNARY_MI2S_TX      0x1007
 
+#define Q6AFE_LPASS_MODE_CLK1_VALID 1
+#define Q6AFE_LPASS_MODE_CLK2_VALID 2
+#define Q6AFE_LPASS_CLK_SRC_INTERNAL 1
+#define Q6AFE_LPASS_CLK_ROOT_DEFAULT 0
+
 #define TIMEOUT_MS 1000
 #define AFE_CMD_RESP_AVAIL	0
 #define AFE_CMD_RESP_NONE	1
@@ -191,6 +199,23 @@ struct afe_param_id_slimbus_cfg {
  */
 } __packed;
 
+struct afe_clk_cfg {
+	u32                  i2s_cfg_minor_version;
+	u32                  clk_val1;
+	u32                  clk_val2;
+	u16                  clk_src;
+	u16                  clk_root;
+	u16                  clk_set_mode;
+	u16                  reserved;
+} __packed;
+
+struct afe_digital_clk_cfg {
+	u32                  i2s_cfg_minor_version;
+	u32                  clk_val;
+	u16                  clk_root;
+	u16                  reserved;
+} __packed;
+
 struct afe_param_id_i2s_cfg {
 	u32	i2s_cfg_minor_version;
 	u16	bit_width;
@@ -208,6 +233,21 @@ union afe_port_config {
 	struct afe_param_id_i2s_cfg	i2s_cfg;
 } __packed;
 
+struct afe_lpass_clk_config_command {
+	struct apr_hdr			 hdr;
+	struct afe_port_cmd_set_param_v2 param;
+	struct afe_port_param_data_v2    pdata;
+	struct afe_clk_cfg clk_cfg;
+} __packed;
+
+struct afe_lpass_digital_clk_config_command {
+	struct apr_hdr			 hdr;
+	struct afe_port_cmd_set_param_v2 param;
+	struct afe_port_param_data_v2    pdata;
+	struct afe_digital_clk_cfg clk_cfg;
+} __packed;
+
+/* This param id is used to configure internal clk */
 struct q6afe_port {
 	wait_queue_head_t wait;
 	union afe_port_config port_cfg;
@@ -425,6 +465,81 @@ static int q6afe_port_set_param_v2(struct q6afe_port *port, void *data,
 	return ret;
 }
 
+static int q6afe_set_lpass_clock(struct q6afe_port *port,
+				 struct afe_clk_cfg *cfg)
+{
+	struct afe_lpass_clk_config_command clk_cfg = {0};
+	int param_id = AFE_PARAM_ID_LPAIF_CLK_CONFIG;
+	struct q6afe *afe = port->afe;
+
+	if (!cfg) {
+		dev_err(afe->dev, "clock cfg is NULL\n");
+		return -EINVAL;
+	}
+
+	clk_cfg.clk_cfg = *cfg;
+
+	return q6afe_port_set_param_v2(port, &clk_cfg, param_id, sizeof(*cfg));
+}
+
+static int q6afe_set_digital_codec_core_clock(struct q6afe_port *port,
+					      struct afe_digital_clk_cfg *cfg)
+{
+	struct afe_lpass_digital_clk_config_command clk_cfg = {0};
+	int param_id = AFE_PARAM_ID_INTERNAL_DIGITAL_CDC_CLK_CONFIG;
+	struct q6afe *afe = port->afe;
+
+	if (!cfg) {
+		dev_err(afe->dev, "clock cfg is NULL\n");
+		return -EINVAL;
+	}
+
+	clk_cfg.clk_cfg = *cfg;
+
+	return q6afe_port_set_param_v2(port, &clk_cfg, param_id, sizeof(*cfg));
+}
+
+int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
+			  int clk_src, int clk_root,
+			  unsigned int freq, int dir)
+{
+	struct afe_clk_cfg ccfg = {0,};
+	struct afe_digital_clk_cfg dcfg = {0,};
+	int ret;
+
+	switch (clk_id) {
+	case LPAIF_DIG_CLK:
+		dcfg.i2s_cfg_minor_version = AFE_API_VERSION_I2S_CONFIG;
+		dcfg.clk_val = freq;
+		dcfg.clk_root = clk_root;
+		ret = q6afe_set_digital_codec_core_clock(port, &dcfg);
+		break;
+	case LPAIF_BIT_CLK:
+		ccfg.i2s_cfg_minor_version = AFE_API_VERSION_I2S_CONFIG;
+		ccfg.clk_val1 = freq;
+		ccfg.clk_src = clk_src;
+		ccfg.clk_root = clk_root;
+		ccfg.clk_set_mode = Q6AFE_LPASS_MODE_CLK1_VALID;
+		ret = q6afe_set_lpass_clock(port, &ccfg);
+		break;
+
+	case LPAIF_OSR_CLK:
+		ccfg.i2s_cfg_minor_version = AFE_API_VERSION_I2S_CONFIG;
+		ccfg.clk_val2 = freq;
+		ccfg.clk_src = clk_src;
+		ccfg.clk_root = clk_root;
+		ccfg.clk_set_mode = Q6AFE_LPASS_MODE_CLK2_VALID;
+		ret = q6afe_set_lpass_clock(port, &ccfg);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(q6afe_port_set_sysclk);
+
 static int afe_port_start(struct q6afe_port *port,
 			  union afe_port_config *afe_config)
 {
diff --git a/sound/soc/qcom/qdsp6/q6afe.h b/sound/soc/qcom/qdsp6/q6afe.h
index 9114d68a79cb..c469f6de38d2 100644
--- a/sound/soc/qcom/qdsp6/q6afe.h
+++ b/sound/soc/qcom/qdsp6/q6afe.h
@@ -14,6 +14,13 @@
 #define AFE_MAX_CHAN_COUNT	8
 #define AFE_PORT_MAX_AUDIO_CHAN_CNT	0x8
 
+#define Q6AFE_LPASS_CLK_SRC_INTERNAL 1
+#define Q6AFE_LPASS_CLK_ROOT_DEFAULT 0
+
+#define LPAIF_DIG_CLK	1
+#define LPAIF_BIT_CLK	2
+#define LPAIF_OSR_CLK	3
+
 struct q6afe_hdmi_cfg {
 	u16                  datatype;
 	u16                  channel_allocation;
@@ -61,4 +68,7 @@ void q6afe_slim_port_prepare(struct q6afe_port *port,
 			  struct q6afe_slim_cfg *cfg);
 void q6afe_i2s_port_prepare(struct q6afe_port *port, struct q6afe_i2s_cfg *cfg);
 
+int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
+			  int clk_src, int clk_root,
+			  unsigned int freq, int dir);
 #endif /* __Q6AFE_H__ */
-- 
2.15.1
