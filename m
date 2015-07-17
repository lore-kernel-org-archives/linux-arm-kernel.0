From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Jul 2015 14:41:55 -0700
Subject: [PATCH v4 2/2] regulator: qcom-spmi: Add vendor specific configuration
In-Reply-To: <1437169315-31530-1-git-send-email-sboyd@codeaurora.org>
References: <1437169315-31530-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1437169315-31530-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for over current protection (OCP), pin control
selection, soft start strength, and auto-mode.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Notes:
    Changes from v3:
    * Split this patch out from rest of driver
    * Moved auto mode into regulator-init-mode and made it equal to FAST mode
    * Moved qcom,ocp-enable to regulator-over-current-protection property
    
    Changes from v1:
    * New patch split from orignal SPMI regulator driver

 .../bindings/regulator/qcom,spmi-regulator.txt     |  60 ++++++-
 drivers/regulator/qcom_spmi-regulator.c            | 200 ++++++++++++++++++++-
 2 files changed, 251 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
index 75b4604bad07..d00bfd8624a5 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
@@ -91,13 +91,65 @@ see regulator.txt - with additional custom properties described below:
 - regulator-initial-mode:
 	Usage: optional
 	Value type: <u32>
-	Descrption: 1 = Set initial mode to high power mode (HPM), also referred
-		    to as NPM.  HPM consumes more ground current than LPM, but
+	Description: 2 = Set initial mode to auto mode (automatically select
+		    between HPM and LPM); not available on boost type
+		    regulators.
+
+		    1 = Set initial mode to high power mode (HPM), also referred
+		    to as NPM. HPM consumes more ground current than LPM, but
 		    it can source significantly higher load current. HPM is not
 		    available on boost type regulators. For voltage switch type
 		    regulators, HPM implies that over current protection and
-		    soft start are active all the time. 0 = Set initial mode to
-		    low power mode (LPM).
+		    soft start are active all the time.
+
+		    0 = Set initial mode to low power mode (LPM).
+
+- qcom,ocp-max-retries:
+	Usage: optional
+	Value type: <u32>
+	Description: Maximum number of times to try toggling a voltage switch
+		     off and back on as a result of consecutive over current
+		     events.
+
+- qcom,ocp-retry-delay:
+	Usage: optional
+	Value type: <u32>
+	Description: Time to delay in milliseconds between each voltage switch
+		     toggle after an over current event takes place.
+
+- qcom,pin-ctrl-enable:
+	Usage: optional
+	Value type: <u32>
+	Description: Bit mask specifying which hardware pins should be used to
+		     enable the regulator, if any; supported bits are:
+			0 = ignore all hardware enable signals
+			BIT(0) = follow HW0_EN signal
+			BIT(1) = follow HW1_EN signal
+			BIT(2) = follow HW2_EN signal
+			BIT(3) = follow HW3_EN signal
+
+- qcom,pin-ctrl-hpm:
+	Usage: optional
+	Value type: <u32>
+	Description: Bit mask specifying which hardware pins should be used to
+		     force the regulator into high power mode, if any;
+		     supported bits are:
+			0 = ignore all hardware enable signals
+			BIT(0) = follow HW0_EN signal
+			BIT(1) = follow HW1_EN signal
+			BIT(2) = follow HW2_EN signal
+			BIT(3) = follow HW3_EN signal
+			BIT(4) = follow PMIC awake state
+
+- qcom,vs-soft-start-strength:
+	Usage: optional
+	Value type: <u32>
+	Description: This property sets the soft start strength for voltage
+		     switch type regulators; supported values are:
+			0 = 0.05 uA
+			1 = 0.25 uA
+			2 = 0.55 uA
+			3 = 0.75 uA
 
 Example:
 
diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 850a30a95b5b..638600696b4d 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -26,6 +26,70 @@
 #include <linux/regmap.h>
 #include <linux/list.h>
 
+/* Pin control enable input pins. */
+#define SPMI_REGULATOR_PIN_CTRL_ENABLE_NONE		0x00
+#define SPMI_REGULATOR_PIN_CTRL_ENABLE_EN0		0x01
+#define SPMI_REGULATOR_PIN_CTRL_ENABLE_EN1		0x02
+#define SPMI_REGULATOR_PIN_CTRL_ENABLE_EN2		0x04
+#define SPMI_REGULATOR_PIN_CTRL_ENABLE_EN3		0x08
+#define SPMI_REGULATOR_PIN_CTRL_ENABLE_HW_DEFAULT	0x10
+
+/* Pin control high power mode input pins. */
+#define SPMI_REGULATOR_PIN_CTRL_HPM_NONE		0x00
+#define SPMI_REGULATOR_PIN_CTRL_HPM_EN0			0x01
+#define SPMI_REGULATOR_PIN_CTRL_HPM_EN1			0x02
+#define SPMI_REGULATOR_PIN_CTRL_HPM_EN2			0x04
+#define SPMI_REGULATOR_PIN_CTRL_HPM_EN3			0x08
+#define SPMI_REGULATOR_PIN_CTRL_HPM_SLEEP_B		0x10
+#define SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT		0x20
+
+/*
+ * Used with enable parameters to specify that hardware default register values
+ * should be left unaltered.
+ */
+#define SPMI_REGULATOR_USE_HW_DEFAULT			2
+
+/* Soft start strength of a voltage switch type regulator */
+enum spmi_vs_soft_start_str {
+	SPMI_VS_SOFT_START_STR_0P05_UA = 0,
+	SPMI_VS_SOFT_START_STR_0P25_UA,
+	SPMI_VS_SOFT_START_STR_0P55_UA,
+	SPMI_VS_SOFT_START_STR_0P75_UA,
+	SPMI_VS_SOFT_START_STR_HW_DEFAULT,
+};
+
+/**
+ * struct spmi_regulator_init_data - spmi-regulator initialization data
+ * @pin_ctrl_enable:        Bit mask specifying which hardware pins should be
+ *				used to enable the regulator, if any
+ *			    Value should be an ORing of
+ *				SPMI_REGULATOR_PIN_CTRL_ENABLE_* constants.  If
+ *				the bit specified by
+ *				SPMI_REGULATOR_PIN_CTRL_ENABLE_HW_DEFAULT is
+ *				set, then pin control enable hardware registers
+ *				will not be modified.
+ * @pin_ctrl_hpm:           Bit mask specifying which hardware pins should be
+ *				used to force the regulator into high power
+ *				mode, if any
+ *			    Value should be an ORing of
+ *				SPMI_REGULATOR_PIN_CTRL_HPM_* constants.  If
+ *				the bit specified by
+ *				SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT is
+ *				set, then pin control mode hardware registers
+ *				will not be modified.
+ * @vs_soft_start_strength: This parameter sets the soft start strength for
+ *				voltage switch type regulators.  Its value
+ *				should be one of SPMI_VS_SOFT_START_STR_*.  If
+ *				its value is SPMI_VS_SOFT_START_STR_HW_DEFAULT,
+ *				then the soft start strength will be left at its
+ *				default hardware value.
+ */
+struct spmi_regulator_init_data {
+	unsigned				pin_ctrl_enable;
+	unsigned				pin_ctrl_hpm;
+	enum spmi_vs_soft_start_str		vs_soft_start_strength;
+};
+
 /* These types correspond to unique register layouts. */
 enum spmi_regulator_logical_type {
 	SPMI_REGULATOR_LOGICAL_TYPE_SMPS,
@@ -458,6 +522,14 @@ static int spmi_regulator_vs_enable(struct regulator_dev *rdev)
 	return spmi_regulator_common_enable(rdev);
 }
 
+static int spmi_regulator_vs_ocp(struct regulator_dev *rdev)
+{
+	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
+	u8 reg = SPMI_VS_OCP_OVERRIDE;
+
+	return spmi_vreg_write(vreg, SPMI_VS_REG_OCP, &reg, 1);
+}
+
 static int spmi_regulator_common_disable(struct regulator_dev *rdev)
 {
 	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
@@ -792,6 +864,9 @@ static unsigned int spmi_regulator_common_get_mode(struct regulator_dev *rdev)
 	if (reg & SPMI_COMMON_MODE_HPM_MASK)
 		return REGULATOR_MODE_NORMAL;
 
+	if (reg & SPMI_COMMON_MODE_AUTO_MASK)
+		return REGULATOR_MODE_FAST;
+
 	return REGULATOR_MODE_IDLE;
 }
 
@@ -799,11 +874,13 @@ static int
 spmi_regulator_common_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
-	u8 mask = SPMI_COMMON_MODE_HPM_MASK;
+	u8 mask = SPMI_COMMON_MODE_HPM_MASK | SPMI_COMMON_MODE_AUTO_MASK;
 	u8 val = 0;
 
 	if (mode == REGULATOR_MODE_NORMAL)
-		val = mask;
+		val = SPMI_COMMON_MODE_HPM_MASK;
+	else if (mode == REGULATOR_MODE_FAST)
+		val = SPMI_COMMON_MODE_AUTO_MASK;
 
 	return spmi_vreg_update_bits(vreg, SPMI_COMMON_REG_MODE, val, mask);
 }
@@ -973,6 +1050,7 @@ static struct regulator_ops spmi_vs_ops = {
 	.is_enabled		= spmi_regulator_common_is_enabled,
 	.set_pull_down		= spmi_regulator_common_set_pull_down,
 	.set_soft_start		= spmi_regulator_common_set_soft_start,
+	.set_over_current_protection = spmi_regulator_vs_ocp,
 };
 
 static struct regulator_ops spmi_boost_ops = {
@@ -1203,10 +1281,111 @@ static int spmi_regulator_ftsmps_init_slew_rate(struct spmi_regulator *vreg)
 	return ret;
 }
 
+static int spmi_regulator_init_registers(struct spmi_regulator *vreg,
+				const struct spmi_regulator_init_data *data)
+{
+	int ret;
+	enum spmi_regulator_logical_type type;
+	u8 ctrl_reg[8], reg, mask;
+
+	type = vreg->logical_type;
+
+	ret = spmi_vreg_read(vreg, SPMI_COMMON_REG_VOLTAGE_RANGE, ctrl_reg, 8);
+	if (ret)
+		return ret;
+
+	/* Set up enable pin control. */
+	if ((type == SPMI_REGULATOR_LOGICAL_TYPE_SMPS
+	     || type == SPMI_REGULATOR_LOGICAL_TYPE_LDO
+	     || type == SPMI_REGULATOR_LOGICAL_TYPE_VS)
+	    && !(data->pin_ctrl_enable
+			& SPMI_REGULATOR_PIN_CTRL_ENABLE_HW_DEFAULT)) {
+		ctrl_reg[SPMI_COMMON_IDX_ENABLE] &=
+			~SPMI_COMMON_ENABLE_FOLLOW_ALL_MASK;
+		ctrl_reg[SPMI_COMMON_IDX_ENABLE] |=
+		    data->pin_ctrl_enable & SPMI_COMMON_ENABLE_FOLLOW_ALL_MASK;
+	}
+
+	/* Set up mode pin control. */
+	if ((type == SPMI_REGULATOR_LOGICAL_TYPE_SMPS
+	    || type == SPMI_REGULATOR_LOGICAL_TYPE_LDO)
+		&& !(data->pin_ctrl_hpm
+			& SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT)) {
+		ctrl_reg[SPMI_COMMON_IDX_MODE] &=
+			~SPMI_COMMON_MODE_FOLLOW_ALL_MASK;
+		ctrl_reg[SPMI_COMMON_IDX_MODE] |=
+			data->pin_ctrl_hpm & SPMI_COMMON_MODE_FOLLOW_ALL_MASK;
+	}
+
+	if (type == SPMI_REGULATOR_LOGICAL_TYPE_VS
+	   && !(data->pin_ctrl_hpm & SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT)) {
+		ctrl_reg[SPMI_COMMON_IDX_MODE] &=
+			~SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
+		ctrl_reg[SPMI_COMMON_IDX_MODE] |=
+		       data->pin_ctrl_hpm & SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
+	}
+
+	if ((type == SPMI_REGULATOR_LOGICAL_TYPE_ULT_LO_SMPS
+		|| type == SPMI_REGULATOR_LOGICAL_TYPE_ULT_HO_SMPS
+		|| type == SPMI_REGULATOR_LOGICAL_TYPE_ULT_LDO)
+		&& !(data->pin_ctrl_hpm
+			& SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT)) {
+		ctrl_reg[SPMI_COMMON_IDX_MODE] &=
+			~SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
+		ctrl_reg[SPMI_COMMON_IDX_MODE] |=
+		       data->pin_ctrl_hpm & SPMI_COMMON_MODE_FOLLOW_AWAKE_MASK;
+	}
+
+	/* Write back any control register values that were modified. */
+	ret = spmi_vreg_write(vreg, SPMI_COMMON_REG_VOLTAGE_RANGE, ctrl_reg, 8);
+	if (ret)
+		return ret;
+
+	/* Set soft start strength and over current protection for VS. */
+	if (type == SPMI_REGULATOR_LOGICAL_TYPE_VS) {
+		if (data->vs_soft_start_strength
+				!= SPMI_VS_SOFT_START_STR_HW_DEFAULT) {
+			reg = data->vs_soft_start_strength
+				& SPMI_VS_SOFT_START_SEL_MASK;
+			mask = SPMI_VS_SOFT_START_SEL_MASK;
+			return spmi_vreg_update_bits(vreg,
+						     SPMI_VS_REG_SOFT_START,
+						     reg, mask);
+		}
+	}
+
+	return 0;
+}
+
+static void spmi_regulator_get_dt_config(struct spmi_regulator *vreg,
+		struct device_node *node, struct spmi_regulator_init_data *data)
+{
+	/*
+	 * Initialize configuration parameters to use hardware default in case
+	 * no value is specified via device tree.
+	 */
+	data->pin_ctrl_enable	    = SPMI_REGULATOR_PIN_CTRL_ENABLE_HW_DEFAULT;
+	data->pin_ctrl_hpm	    = SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT;
+	data->vs_soft_start_strength	= SPMI_VS_SOFT_START_STR_HW_DEFAULT;
+
+	/* These bindings are optional, so it is okay if they aren't found. */
+	of_property_read_u32(node, "qcom,ocp-max-retries",
+		&vreg->ocp_max_retries);
+	of_property_read_u32(node, "qcom,ocp-retry-delay",
+		&vreg->ocp_retry_delay_ms);
+	of_property_read_u32(node, "qcom,pin-ctrl-enable",
+		&data->pin_ctrl_enable);
+	of_property_read_u32(node, "qcom,pin-ctrl-hpm", &data->pin_ctrl_hpm);
+	of_property_read_u32(node, "qcom,vs-soft-start-strength",
+		&data->vs_soft_start_strength);
+}
+
 static unsigned int spmi_regulator_of_map_mode(unsigned int mode)
 {
-	if (mode)
+	if (mode == 1)
 		return REGULATOR_MODE_NORMAL;
+	if (mode == 2)
+		return REGULATOR_MODE_FAST;
 
 	return REGULATOR_MODE_IDLE;
 }
@@ -1215,12 +1394,23 @@ static int spmi_regulator_of_parse(struct device_node *node,
 			    const struct regulator_desc *desc,
 			    struct regulator_config *config)
 {
+	struct spmi_regulator_init_data data = { };
 	struct spmi_regulator *vreg = config->driver_data;
 	struct device *dev = config->dev;
 	int ret;
 
-	vreg->ocp_max_retries = SPMI_VS_OCP_DEFAULT_MAX_RETRIES;
-	vreg->ocp_retry_delay_ms = SPMI_VS_OCP_DEFAULT_RETRY_DELAY_MS;
+	spmi_regulator_get_dt_config(vreg, node, &data);
+
+	if (!vreg->ocp_max_retries)
+		vreg->ocp_max_retries = SPMI_VS_OCP_DEFAULT_MAX_RETRIES;
+	if (!vreg->ocp_retry_delay_ms)
+		vreg->ocp_retry_delay_ms = SPMI_VS_OCP_DEFAULT_RETRY_DELAY_MS;
+
+	ret = spmi_regulator_init_registers(vreg, &data);
+	if (ret) {
+		dev_err(dev, "common initialization failed, ret=%d\n", ret);
+		return ret;
+	}
 
 	if (vreg->logical_type == SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS) {
 		ret = spmi_regulator_ftsmps_init_slew_rate(vreg);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
