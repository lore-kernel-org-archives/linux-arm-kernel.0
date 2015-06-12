From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 11 Jun 2015 17:31:07 -0700
Subject: [PATCH v2 6/6] regulator: qcom-spmi: Add vendor specific configuration
In-Reply-To: <1434069067-1371-1-git-send-email-sboyd@codeaurora.org>
References: <1434069067-1371-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1434069067-1371-7-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for over current protection (OCP), pin control
selection, soft start and soft start strength, auto-mode, input
current limiting, and pull down.

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes from v1:
* New patch split from orignal SPMI regulator driver

 .../bindings/regulator/qcom,spmi-regulator.txt     |  62 +++++
 drivers/regulator/qcom_spmi-regulator.c            | 298 ++++++++++++++++++++-
 2 files changed, 358 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
index 75b4604bad07..ab01a152e930 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
@@ -99,6 +99,68 @@ see regulator.txt - with additional custom properties described below:
 		    soft start are active all the time. 0 = Set initial mode to
 		    low power mode (LPM).
 
+- qcom,auto-mode-enable:
+	Usage: optional
+	Value type: <u32>
+	Description: 1 = Enable automatic hardware selection of regulator
+			 mode (HPM vs LPM); not available on boost type
+			 regulators. 0 = Disable auto mode selection.
+
+- qcom,ocp-enable:
+	Usage: optional
+	Value type: <u32>
+	Description: 1 = Allow over current protection (OCP) to be enabled for
+		     voltage switch type regulators so that they latch off
+		     automatically when over current is detected. OCP is
+		     enabled when in HPM or auto mode.  0 = Disable OCP.
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
+
 Example:
 
 	regulators {
diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 3df635d101c4..f26b3b29cb04 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -26,6 +26,86 @@
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
+ * @auto_mode_enable:       1 = Enable automatic hardware selection of regulator
+ *				mode (HPM vs LPM).  Auto mode is not available
+ *				on boost type regulators
+ *			    0 = Disable auto mode selection
+ *			    SPMI_REGULATOR_USE_HW_DEFAULT = do not modify
+ *			        auto mode state
+ * @ocp_enable:             1 = Allow over current protection (OCP) to be
+ *				enabled for voltage switch type regulators so
+ *				that they latch off automatically when over
+ *				current is detected.  OCP is enabled when in HPM
+ *				or auto mode.
+ *			    0 = Disable OCP
+ *				QPNP_REGULATOR_USE_HW_DEFAULT = do not modify
+ *				OCP state
+ */
+struct spmi_regulator_init_data {
+	unsigned				pin_ctrl_enable;
+	unsigned				pin_ctrl_hpm;
+	enum spmi_vs_soft_start_str		vs_soft_start_strength;
+	int					auto_mode_enable;
+	int					ocp_enable;
+};
+
 /* These types correspond to unique register layouts. */
 enum spmi_regulator_logical_type {
 	SPMI_REGULATOR_LOGICAL_TYPE_SMPS,
@@ -824,6 +904,72 @@ spmi_regulator_common_set_load(struct regulator_dev *rdev, int load_uA)
 	return spmi_regulator_common_set_mode(rdev, mode);
 }
 
+static int spmi_regulator_common_set_pull_down(struct regulator_dev *rdev)
+{
+	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
+	unsigned int mask = SPMI_COMMON_PULL_DOWN_ENABLE_MASK;
+
+	return spmi_vreg_update_bits(vreg, SPMI_COMMON_REG_PULL_DOWN,
+				     mask, mask);
+}
+
+static int spmi_regulator_common_set_soft_start(struct regulator_dev *rdev)
+{
+	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
+	unsigned int mask = SPMI_LDO_SOFT_START_ENABLE_MASK;
+
+	return spmi_vreg_update_bits(vreg, SPMI_COMMON_REG_SOFT_START,
+				     mask, mask);
+}
+
+static int spmi_regulator_set_ilim(struct regulator_dev *rdev, int ilim_uA)
+{
+	struct spmi_regulator *vreg = rdev_get_drvdata(rdev);
+	enum spmi_regulator_logical_type type = vreg->logical_type;
+	unsigned int current_reg;
+	u8 reg;
+	u8 mask = SPMI_BOOST_CURRENT_LIMIT_MASK |
+		  SPMI_BOOST_CURRENT_LIMIT_ENABLE_MASK;
+
+	if (type == SPMI_REGULATOR_LOGICAL_TYPE_BOOST)
+		current_reg = SPMI_BOOST_REG_CURRENT_LIMIT;
+	else
+		current_reg = SPMI_BOOST_BYP_REG_CURRENT_LIMIT;
+
+	switch (ilim_uA) {
+	case 0 ... 300:
+		reg = 0;
+		break;
+	case 301 ... 600:
+		reg = 1;
+		break;
+	case 601 ... 900:
+		reg = 2;
+		break;
+	case 901 ... 1200:
+		reg = 3;
+		break;
+	case 1201 ... 1500:
+		reg = 4;
+		break;
+	case 1501 ... 1800:
+		reg = 5;
+		break;
+	case 1801 ... 2100:
+		reg = 6;
+		break;
+	case 2101 ... 2400:
+		reg = 7;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg |= SPMI_BOOST_CURRENT_LIMIT_ENABLE_MASK;
+
+	return spmi_vreg_update_bits(vreg, current_reg, reg, mask);
+}
+
 static int spmi_regulator_vs_clear_ocp(struct spmi_regulator *vreg)
 {
 	int ret;
@@ -897,6 +1043,7 @@ static struct regulator_ops spmi_smps_ops = {
 	.set_mode		= spmi_regulator_common_set_mode,
 	.get_mode		= spmi_regulator_common_get_mode,
 	.set_load		= spmi_regulator_common_set_load,
+	.set_pull_down		= spmi_regulator_common_set_pull_down,
 };
 
 static struct regulator_ops spmi_ldo_ops = {
@@ -911,6 +1058,8 @@ static struct regulator_ops spmi_ldo_ops = {
 	.set_load		= spmi_regulator_common_set_load,
 	.set_bypass		= spmi_regulator_common_set_bypass,
 	.get_bypass		= spmi_regulator_common_get_bypass,
+	.set_pull_down		= spmi_regulator_common_set_pull_down,
+	.set_soft_start		= spmi_regulator_common_set_soft_start,
 };
 
 static struct regulator_ops spmi_ln_ldo_ops = {
@@ -928,6 +1077,8 @@ static struct regulator_ops spmi_vs_ops = {
 	.enable			= spmi_regulator_vs_enable,
 	.disable		= spmi_regulator_common_disable,
 	.is_enabled		= spmi_regulator_common_is_enabled,
+	.set_pull_down		= spmi_regulator_common_set_pull_down,
+	.set_soft_start		= spmi_regulator_common_set_soft_start,
 };
 
 static struct regulator_ops spmi_boost_ops = {
@@ -937,6 +1088,7 @@ static struct regulator_ops spmi_boost_ops = {
 	.set_voltage		= spmi_regulator_single_range_set_voltage,
 	.get_voltage		= spmi_regulator_single_range_get_voltage,
 	.list_voltage		= spmi_regulator_common_list_voltage,
+	.set_input_current_limit = spmi_regulator_set_ilim,
 };
 
 static struct regulator_ops spmi_ftsmps_ops = {
@@ -950,6 +1102,7 @@ static struct regulator_ops spmi_ftsmps_ops = {
 	.set_mode		= spmi_regulator_common_set_mode,
 	.get_mode		= spmi_regulator_common_get_mode,
 	.set_load		= spmi_regulator_common_set_load,
+	.set_pull_down		= spmi_regulator_common_set_pull_down,
 };
 
 static struct regulator_ops spmi_ult_lo_smps_ops = {
@@ -962,6 +1115,7 @@ static struct regulator_ops spmi_ult_lo_smps_ops = {
 	.set_mode		= spmi_regulator_common_set_mode,
 	.get_mode		= spmi_regulator_common_get_mode,
 	.set_load		= spmi_regulator_common_set_load,
+	.set_pull_down		= spmi_regulator_common_set_pull_down,
 };
 
 static struct regulator_ops spmi_ult_ho_smps_ops = {
@@ -974,6 +1128,7 @@ static struct regulator_ops spmi_ult_ho_smps_ops = {
 	.set_mode		= spmi_regulator_common_set_mode,
 	.get_mode		= spmi_regulator_common_get_mode,
 	.set_load		= spmi_regulator_common_set_load,
+	.set_pull_down		= spmi_regulator_common_set_pull_down,
 };
 
 static struct regulator_ops spmi_ult_ldo_ops = {
@@ -988,6 +1143,8 @@ static struct regulator_ops spmi_ult_ldo_ops = {
 	.set_load		= spmi_regulator_common_set_load,
 	.set_bypass		= spmi_regulator_common_set_bypass,
 	.get_bypass		= spmi_regulator_common_get_bypass,
+	.set_pull_down		= spmi_regulator_common_set_pull_down,
+	.set_soft_start		= spmi_regulator_common_set_soft_start,
 };
 
 /* Maximum possible digital major revision value */
@@ -1152,6 +1309,132 @@ static int spmi_regulator_ftsmps_init_slew_rate(struct spmi_regulator *vreg)
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
+	/* Set up auto mode control. */
+	if ((type == SPMI_REGULATOR_LOGICAL_TYPE_SMPS
+	     || type == SPMI_REGULATOR_LOGICAL_TYPE_LDO
+	     || type == SPMI_REGULATOR_LOGICAL_TYPE_VS
+	     || type == SPMI_REGULATOR_LOGICAL_TYPE_FTSMPS)
+	    && (data->auto_mode_enable != SPMI_REGULATOR_USE_HW_DEFAULT)) {
+		ctrl_reg[SPMI_COMMON_IDX_MODE] &=
+			~SPMI_COMMON_MODE_AUTO_MASK;
+		ctrl_reg[SPMI_COMMON_IDX_MODE] |=
+		     (data->auto_mode_enable ? SPMI_COMMON_MODE_AUTO_MASK : 0);
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
+			ret = spmi_vreg_update_bits(vreg,
+						    SPMI_VS_REG_SOFT_START,
+						    reg, mask);
+			if (ret)
+				return ret;
+		}
+
+		if (data->ocp_enable != SPMI_REGULATOR_USE_HW_DEFAULT) {
+			reg = data->ocp_enable ? SPMI_VS_OCP_NO_OVERRIDE
+						: SPMI_VS_OCP_OVERRIDE;
+			ret = spmi_vreg_write(vreg, SPMI_VS_REG_OCP, &reg, 1);
+			if (ret)
+				return ret;
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
+	data->auto_mode_enable		= SPMI_REGULATOR_USE_HW_DEFAULT;
+	data->ocp_enable		= SPMI_REGULATOR_USE_HW_DEFAULT;
+	data->pin_ctrl_enable	    = SPMI_REGULATOR_PIN_CTRL_ENABLE_HW_DEFAULT;
+	data->pin_ctrl_hpm	    = SPMI_REGULATOR_PIN_CTRL_HPM_HW_DEFAULT;
+	data->vs_soft_start_strength	= SPMI_VS_SOFT_START_STR_HW_DEFAULT;
+
+	/* These bindings are optional, so it is okay if they aren't found. */
+	of_property_read_u32(node, "qcom,auto-mode-enable",
+		&data->auto_mode_enable);
+	of_property_read_u32(node, "qcom,ocp-enable", &data->ocp_enable);
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
 	if (mode)
@@ -1164,12 +1447,23 @@ static int spmi_regulator_of_parse(struct device_node *node,
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
