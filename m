From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri,  8 Jan 2016 12:25:53 -0800
Subject: [PATCH] pinctrl: qcom: spmi-mpp: Skip pullup on ULT type MPPs
Message-ID: <1452284753-5450-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ULT type of MPPs don't have a pullup. Skip configuring the
pullup on these types of pins.

Cc: Andy Gross <andy.gross@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index 2f18323571a6..2a3e5490a483 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -117,6 +117,7 @@
  * @output_enabled: Set to true if MPP output logic is enabled.
  * @input_enabled: Set to true if MPP input buffer logic is enabled.
  * @paired: Pin operates in paired mode
+ * @has_pullup: Pin has support to configure pullup
  * @num_sources: Number of power-sources supported by this MPP.
  * @power_source: Current power-source used.
  * @amux_input: Set the source for analog input.
@@ -134,6 +135,7 @@ struct pmic_mpp_pad {
 	bool		output_enabled;
 	bool		input_enabled;
 	bool		paired;
+	bool		has_pullup;
 	unsigned int	num_sources;
 	unsigned int	power_source;
 	unsigned int	amux_input;
@@ -477,11 +479,14 @@ static int pmic_mpp_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
 	if (ret < 0)
 		return ret;
 
-	val = pad->pullup << PMIC_MPP_REG_PULL_SHIFT;
+	if (pad->has_pullup) {
+		val = pad->pullup << PMIC_MPP_REG_PULL_SHIFT;
 
-	ret = pmic_mpp_write(state, pad, PMIC_MPP_REG_DIG_PULL_CTL, val);
-	if (ret < 0)
-		return ret;
+		ret = pmic_mpp_write(state, pad, PMIC_MPP_REG_DIG_PULL_CTL,
+				     val);
+		if (ret < 0)
+			return ret;
+	}
 
 	val = pad->amux_input & PMIC_MPP_REG_AIN_ROUTE_MASK;
 
@@ -534,7 +539,8 @@ static void pmic_mpp_config_dbg_show(struct pinctrl_dev *pctldev,
 		seq_printf(s, " %-7s", pmic_mpp_functions[pad->function]);
 		seq_printf(s, " vin-%d", pad->power_source);
 		seq_printf(s, " %d", pad->aout_level);
-		seq_printf(s, " %-8s", biases[pad->pullup]);
+		if (pad->has_pullup)
+			seq_printf(s, " %-8s", biases[pad->pullup]);
 		seq_printf(s, " %-4s", pad->out_value ? "high" : "low");
 		if (pad->dtest)
 			seq_printf(s, " dtest%d", pad->dtest);
@@ -748,12 +754,16 @@ static int pmic_mpp_populate(struct pmic_mpp_state *state,
 	pad->power_source = val >> PMIC_MPP_REG_VIN_SHIFT;
 	pad->power_source &= PMIC_MPP_REG_VIN_MASK;
 
-	val = pmic_mpp_read(state, pad, PMIC_MPP_REG_DIG_PULL_CTL);
-	if (val < 0)
-		return val;
+	if (subtype != PMIC_MPP_SUBTYPE_ULT_4CH_NO_ANA_OUT &&
+	    subtype != PMIC_MPP_SUBTYPE_ULT_4CH_NO_SINK) {
+		val = pmic_mpp_read(state, pad, PMIC_MPP_REG_DIG_PULL_CTL);
+		if (val < 0)
+			return val;
 
-	pad->pullup = val >> PMIC_MPP_REG_PULL_SHIFT;
-	pad->pullup &= PMIC_MPP_REG_PULL_MASK;
+		pad->pullup = val >> PMIC_MPP_REG_PULL_SHIFT;
+		pad->pullup &= PMIC_MPP_REG_PULL_MASK;
+		pad->has_pullup = true;
+	}
 
 	val = pmic_mpp_read(state, pad, PMIC_MPP_REG_AIN_CTL);
 	if (val < 0)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
