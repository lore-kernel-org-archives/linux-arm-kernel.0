From: agross@codeaurora.org (Andy Gross)
Date: Thu, 18 Dec 2014 14:59:54 -0600
Subject: [PATCH 3/4] pinctrl: qcom: apq8064: Add multi copy support
In-Reply-To: <1418936395-14623-1-git-send-email-agross@codeaurora.org>
References: <1418936395-14623-1-git-send-email-agross@codeaurora.org>
Message-ID: <1418936395-14623-4-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds multiple copy support for functions that can be mapped to more
than one pin and that also require an additional mux configuration setting to
work properly.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 .../bindings/pinctrl/qcom,apq8064-pinctrl.txt      |    3 +-
 drivers/pinctrl/qcom/pinctrl-apq8064.c             |   29 +++++++++++++++-----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt
index a7bde64..37ffe9b 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt
@@ -50,7 +50,8 @@ Valid values for function are:
   gsbi4_cam_i2c, gsbi5, gsbi5_spi_cs1, gsbi5_spi_cs2, gsbi5_spi_cs3, gsbi6,
   gsbi6_spi_cs1, gsbi6_spi_cs2, gsbi6_spi_cs3, gsbi7, gsbi7_spi_cs1,
   gsbi7_spi_cs2, gsbi7_spi_cs3, gsbi_cam_i2c, hdmi, mi2s, riva_bt, riva_fm,
-  riva_wlan, sdc2, sdc4, slimbus, spkr_i2s, tsif1, tsif2, usb2_hsic, ps_hold
+  riva_wlan, sdc2, sdc4, slimbus_a, slimbus_b, spkr_i2s, tsif1, tsif2,
+  usb2_hsic, ps_hold
 
 Example:
 
diff --git a/drivers/pinctrl/qcom/pinctrl-apq8064.c b/drivers/pinctrl/qcom/pinctrl-apq8064.c
index cd96699..e2d1dc1 100644
--- a/drivers/pinctrl/qcom/pinctrl-apq8064.c
+++ b/drivers/pinctrl/qcom/pinctrl-apq8064.c
@@ -224,6 +224,16 @@ static const unsigned int sdc3_data_pins[] = { 95 };
 		.ngroups = ARRAY_SIZE(fname##_groups),	\
 	}
 
+#define FUNCTION_MULTI_COPY(fname, reg, value)		\
+	[APQ_MUX_##fname] = {				\
+		.name = #fname,				\
+		.groups = fname##_groups,		\
+		.ngroups = ARRAY_SIZE(fname##_groups),	\
+		.requires_copy_select = 1,		\
+		.copy_select_reg = reg,			\
+		.copy_select_value = value,		\
+	}
+
 #define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10) \
 	{						\
 		.name = "gpio" #id,			\
@@ -321,7 +331,8 @@ enum apq8064_functions {
 	APQ_MUX_riva_wlan,
 	APQ_MUX_sdc2,
 	APQ_MUX_sdc4,
-	APQ_MUX_slimbus,
+	APQ_MUX_slimbus_a,
+	APQ_MUX_slimbus_b,
 	APQ_MUX_spkr_i2s,
 	APQ_MUX_tsif1,
 	APQ_MUX_tsif2,
@@ -432,9 +443,12 @@ static const char * const sdc2_groups[] = {
 static const char * const sdc4_groups[] = {
 	"gpio63", "gpio64", "gpio65", "gpio66", "gpio67", "gpio68"
 };
-static const char * const slimbus_groups[] = {
+static const char * const slimbus_a_groups[] = {
 	"gpio40", "gpio41"
 };
+static const char * const slimbus_b_groups[] = {
+	"gpio30", "gpio31"
+};
 static const char * const spkr_i2s_groups[] = {
 	"gpio47", "gpio48", "gpio49", "gpio50"
 };
@@ -478,7 +492,8 @@ static const struct msm_function apq8064_functions[] = {
 	FUNCTION(riva_wlan),
 	FUNCTION(sdc2),
 	FUNCTION(sdc4),
-	FUNCTION(slimbus),
+	FUNCTION_MULTI_COPY(slimbus_a, 0x2074, 0),
+	FUNCTION_MULTI_COPY(slimbus_b, 0x2074, 1),
 	FUNCTION(spkr_i2s),
 	FUNCTION(tsif1),
 	FUNCTION(tsif2),
@@ -517,8 +532,8 @@ static const struct msm_pingroup apq8064_groups[] = {
 	PINGROUP(27, mi2s, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(28, mi2s, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(29, mi2s, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(30, mi2s, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(31, mi2s, NA, gsbi5_spi_cs2, gsbi6_spi_cs2, gsbi7_spi_cs2, NA, NA, NA, NA, NA),
+	PINGROUP(30, mi2s, slimbus_b, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(31, mi2s, slimbus_b, gsbi5_spi_cs2, gsbi6_spi_cs2, gsbi7_spi_cs2, NA, NA, NA, NA, NA),
 	PINGROUP(32, mi2s, NA, NA, NA, NA, gsbi5_spi_cs3, gsbi6_spi_cs3, gsbi7_spi_cs3, NA, NA),
 	PINGROUP(33, mi2s, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(34, codec_mic_i2s, NA, NA, NA, NA, NA, NA, NA, NA, NA),
@@ -527,8 +542,8 @@ static const struct msm_pingroup apq8064_groups[] = {
 	PINGROUP(37, codec_mic_i2s, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(38, codec_mic_i2s, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(39, codec_spkr_i2s, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(40, slimbus, codec_spkr_i2s, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(41, slimbus, codec_spkr_i2s, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(40, slimbus_a, codec_spkr_i2s, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(41, slimbus_a, codec_spkr_i2s, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(42, codec_spkr_i2s, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(43, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(44, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-- 
Qualcomm Innovation Center, Inc
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
