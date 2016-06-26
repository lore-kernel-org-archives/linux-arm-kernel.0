From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Sat, 25 Jun 2016 22:21:32 -0700
Subject: [PATCH 2/2] pinctrl: qcom: msm8974: Add hsic_ctl pinmux
In-Reply-To: <20160626052132.7178-1-stephen.boyd@linaro.org>
References: <20160626052132.7178-1-stephen.boyd@linaro.org>
Message-ID: <20160626052132.7178-3-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The msm8974 pinctrl variant has a couple USB HSIC "glue"
registers that let us mux between the pinctrl register settings
or the HSIC core settings for the HSIC pins (gpio 144 and gpio
145). Support this method of operation by adding hsic_data and
hsic_strobe pins that can select between hsic_ctl and gpio
functions. This allows us to toggle the hsic pin configuration
over to the HSIC core at runtime.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 .../bindings/pinctrl/qcom,msm8974-pinctrl.txt      |  5 ++-
 drivers/pinctrl/qcom/pinctrl-msm8x74.c             | 43 +++++++++++++++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
index e4d6a9d20f7d..453bd7c76d6b 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt
@@ -49,6 +49,9 @@ Valid values for pins are:
   sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd, sdc2_data
     Supports bias and drive-strength
 
+  hsic_data, hsic_strobe
+    Supports only mux
+
 Valid values for function are:
   cci_i2c0, cci_i2c1, uim1, uim2, uim_batt_alarm,
   blsp_uim1, blsp_uart1, blsp_i2c1, blsp_spi1,
@@ -70,7 +73,7 @@ Valid values for function are:
   cam_mckl0, cam_mclk1, cam_mclk2, cam_mclk3, mdp_vsync, hdmi_cec, hdmi_ddc,
   hdmi_hpd, edp_hpd, gp_pdm0, gp_pdm1, gp_pdm2, gp_pdm3, gp0_clk, gp1_clk,
   gp_mn, tsif1, tsif2, hsic, grfc, audio_ref_clk, qua_mi2s, pri_mi2s, spkr_mi2s,
-  ter_mi2s, sec_mi2s, bt, fm, wlan, slimbus, gpio
+  ter_mi2s, sec_mi2s, bt, fm, wlan, slimbus, hsic_ctl, gpio
 
   (Note that this is not yet the complete list of functions)
 
diff --git a/drivers/pinctrl/qcom/pinctrl-msm8x74.c b/drivers/pinctrl/qcom/pinctrl-msm8x74.c
index 46fe6ad5f97e..9eb63d3403d4 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8x74.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8x74.c
@@ -172,6 +172,8 @@ static const struct pinctrl_pin_desc msm8x74_pins[] = {
 	PINCTRL_PIN(149, "SDC2_CLK"),
 	PINCTRL_PIN(150, "SDC2_CMD"),
 	PINCTRL_PIN(151, "SDC2_DATA"),
+	PINCTRL_PIN(152, "HSIC_STROBE"),
+	PINCTRL_PIN(153, "HSIC_DATA"),
 };
 
 #define DECLARE_MSM_GPIO_PINS(pin) static const unsigned int gpio##pin##_pins[] = { pin }
@@ -328,6 +330,8 @@ static const unsigned int sdc1_data_pins[] = { 148 };
 static const unsigned int sdc2_clk_pins[] = { 149 };
 static const unsigned int sdc2_cmd_pins[] = { 150 };
 static const unsigned int sdc2_data_pins[] = { 151 };
+static const unsigned int hsic_strobe_pins[] = { 152 };
+static const unsigned int hsic_data_pins[] = { 153 };
 
 #define FUNCTION(fname)					\
 	[MSM_MUX_##fname] = {				\
@@ -399,6 +403,37 @@ static const unsigned int sdc2_data_pins[] = { 151 };
 		.intr_detection_width = -1,		\
 	}
 
+#define HSIC_PINGROUP(pg_name, ctl)			\
+	{						\
+		.name = #pg_name,			\
+		.pins = pg_name##_pins,			\
+		.npins = ARRAY_SIZE(pg_name##_pins),	\
+		.funcs = (int[]){			\
+			MSM_MUX_gpio,			\
+			MSM_MUX_hsic_ctl,		\
+		},					\
+		.nfuncs = 2,				\
+		.ctl_reg = ctl,				\
+		.io_reg = 0,				\
+		.intr_cfg_reg = 0,			\
+		.intr_status_reg = 0,			\
+		.intr_target_reg = 0,			\
+		.mux_bit = 25,				\
+		.pull_bit = -1,				\
+		.drv_bit = -1,				\
+		.oe_bit = -1,				\
+		.in_bit = -1,				\
+		.out_bit = -1,				\
+		.intr_enable_bit = -1,			\
+		.intr_status_bit = -1,			\
+		.intr_target_bit = -1,			\
+		.intr_target_kpss_val = -1,		\
+		.intr_raw_status_bit = -1,		\
+		.intr_polarity_bit = -1,		\
+		.intr_detection_bit = -1,		\
+		.intr_detection_width = -1,		\
+	}
+
 /*
  * TODO: Add the rest of the possible functions and fill out
  * the pingroup table below.
@@ -509,6 +544,7 @@ enum msm8x74_functions {
 	MSM_MUX_fm,
 	MSM_MUX_wlan,
 	MSM_MUX_slimbus,
+	MSM_MUX_hsic_ctl,
 	MSM_MUX_NA,
 };
 
@@ -534,7 +570,8 @@ static const char * const gpio_groups[] = {
 	"gpio123", "gpio124", "gpio125", "gpio126", "gpio127", "gpio128",
 	"gpio129", "gpio130", "gpio131", "gpio132", "gpio133", "gpio134",
 	"gpio135", "gpio136", "gpio137", "gpio138", "gpio139", "gpio140",
-	"gpio141", "gpio142", "gpio143", "gpio144", "gpio145"
+	"gpio141", "gpio142", "gpio143", "gpio144", "gpio145", "hsic_data",
+	"hsic_strobe",
 };
 
 static const char * const blsp_uart1_groups[] = {
@@ -754,6 +791,7 @@ static const char * const wlan_groups[] = {
 };
 
 static const char * const slimbus_groups[] = { "gpio70", "gpio71" };
+static const char * const hsic_ctl_groups[] = { "hsic_strobe", "hsic_data" };
 
 static const struct msm_function msm8x74_functions[] = {
 	FUNCTION(gpio),
@@ -861,6 +899,7 @@ static const struct msm_function msm8x74_functions[] = {
 	FUNCTION(fm),
 	FUNCTION(wlan),
 	FUNCTION(slimbus),
+	FUNCTION(hsic_ctl),
 };
 
 static const struct msm_pingroup msm8x74_groups[] = {
@@ -1016,6 +1055,8 @@ static const struct msm_pingroup msm8x74_groups[] = {
 	SDC_PINGROUP(sdc2_clk, 0x2048, 14, 6),
 	SDC_PINGROUP(sdc2_cmd, 0x2048, 11, 3),
 	SDC_PINGROUP(sdc2_data, 0x2048, 9, 0),
+	HSIC_PINGROUP(hsic_strobe, 0x2050),
+	HSIC_PINGROUP(hsic_data, 0x2054),
 };
 
 #define NUM_GPIO_PINGROUPS 146
-- 
2.9.0.rc2.8.ga28705d
