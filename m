From: agross@codeaurora.org (Andy Gross)
Date: Thu, 18 Dec 2014 14:59:53 -0600
Subject: [PATCH 2/4] pinctrl: qcom: ipq8064: Add multi copy support
In-Reply-To: <1418936395-14623-1-git-send-email-agross@codeaurora.org>
References: <1418936395-14623-1-git-send-email-agross@codeaurora.org>
Message-ID: <1418936395-14623-3-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds multiple copy support for functions that can be mapped to more
than one pin and that also require an additional mux configuration setting to
work properly.

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 .../bindings/pinctrl/qcom,ipq8064-pinctrl.txt      |   16 +-
 drivers/pinctrl/qcom/pinctrl-ipq8064.c             |  244 ++++++++++++++------
 2 files changed, 185 insertions(+), 75 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt
index 6e88e91..593b86b 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt
@@ -51,13 +51,15 @@ Valid values for qcom,pins are:
 
 
 Valid values for function are:
-  mdio, mi2s, pdm, ssbi, spmi, audio_pcm, gpio, gsbi1, gsbi2, gsbi4, gsbi5,
-  gsbi5_spi_cs1, gsbi5_spi_cs2, gsbi5_spi_cs3, gsbi6, gsbi7, nss_spi, sdc1,
-  spdif, nand, tsif1, tsif2, usb_fs_n, usb_fs, usb2_hsic, rgmii2, sata,
-  pcie1_rst, pcie1_prsnt, pcie1_pwren_n, pcie1_pwren, pcie1_pwrflt,
-  pcie1_clk_req, pcie2_rst, pcie2_prsnt, pcie2_pwren_n, pcie2_pwren,
-  pcie2_pwrflt, pcie2_clk_req, pcie3_rst, pcie3_prsnt, pcie3_pwren_n,
-  pcie3_pwren, pcie3_pwrflt, pcie3_clk_req, ps_hold
+  mdio, mi2s_a, mi2s_b, mi2s, pdm0_a, pdm0_b, pdm1_a, pdm1_b, pdm2_a, pdm2_b,
+  ssbi, spmi, audio_pcm, gpio, gsbi1, gsbi2, gsbi4, gsbi5, gsbi5_spi_cs1,
+  gsbi5_spi_cs2, gsbi5_spi_cs3, gsbi6_a, gsbi6_b, gsbi7, nss_spi, sdc1, spdif,
+  nand, tsif1, tsif2, usb_fs_n, usb_fs, usb2_hsic, rgmii2, sata, pcie1_rst,
+  pcie1_prsnt_a, pcie1_prsnt_b, pcie1_pwren_n_a, pcie1_pwren_n_b, pcie1_pwren_a,
+  pcie1_pwren_b, pcie1_pwrflt_a, pcie1_pwrflt_b, pcie1_clk_req, pcie2_rst,
+  pcie2_prsnt_a, pcie2_prsnt_b, pcie2_pwren_n_a, pcie2_pwren_n_b, pcie2_pwren_a,
+  pcie2_pwren_b, pcie2_pwrflt_a, pcie2_pwrflt_b, pcie2_clk_req, pcie3_rst,
+  pcie3_prsnt, pcie3_pwren_n, pcie3_pwren, pcie3_pwrflt, pcie3_clk_req, ps_hold
 
 Example:
 
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq8064.c b/drivers/pinctrl/qcom/pinctrl-ipq8064.c
index bcb29c0..312968d 100644
--- a/drivers/pinctrl/qcom/pinctrl-ipq8064.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq8064.c
@@ -177,6 +177,16 @@ static const unsigned int sdc3_data_pins[] = { 71 };
 		.ngroups = ARRAY_SIZE(fname##_groups),	\
 	}
 
+#define FUNCTION_MULTI_COPY(fname, reg, value)		\
+	[IPQ_MUX_##fname] = {				\
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
@@ -247,7 +257,15 @@ static const unsigned int sdc3_data_pins[] = { 71 };
 enum ipq8064_functions {
 	IPQ_MUX_gpio,
 	IPQ_MUX_mdio,
+	IPQ_MUX_mi2s_a,
+	IPQ_MUX_mi2s_b,
 	IPQ_MUX_mi2s,
+	IPQ_MUX_pdm0_a,
+	IPQ_MUX_pdm0_b,
+	IPQ_MUX_pdm1_a,
+	IPQ_MUX_pdm1_b,
+	IPQ_MUX_pdm2_a,
+	IPQ_MUX_pdm2_b,
 	IPQ_MUX_pdm,
 	IPQ_MUX_ssbi,
 	IPQ_MUX_spmi,
@@ -259,7 +277,8 @@ enum ipq8064_functions {
 	IPQ_MUX_gsbi5_spi_cs1,
 	IPQ_MUX_gsbi5_spi_cs2,
 	IPQ_MUX_gsbi5_spi_cs3,
-	IPQ_MUX_gsbi6,
+	IPQ_MUX_gsbi6_a,
+	IPQ_MUX_gsbi6_b,
 	IPQ_MUX_gsbi7,
 	IPQ_MUX_nss_spi,
 	IPQ_MUX_sdc1,
@@ -273,16 +292,24 @@ enum ipq8064_functions {
 	IPQ_MUX_rgmii2,
 	IPQ_MUX_sata,
 	IPQ_MUX_pcie1_rst,
-	IPQ_MUX_pcie1_prsnt,
-	IPQ_MUX_pcie1_pwrflt,
-	IPQ_MUX_pcie1_pwren_n,
-	IPQ_MUX_pcie1_pwren,
+	IPQ_MUX_pcie1_prsnt_a,
+	IPQ_MUX_pcie1_prsnt_b,
+	IPQ_MUX_pcie1_pwrflt_a,
+	IPQ_MUX_pcie1_pwrflt_b,
+	IPQ_MUX_pcie1_pwren_n_a,
+	IPQ_MUX_pcie1_pwren_n_b,
+	IPQ_MUX_pcie1_pwren_a,
+	IPQ_MUX_pcie1_pwren_b,
 	IPQ_MUX_pcie1_clk_req,
 	IPQ_MUX_pcie2_rst,
-	IPQ_MUX_pcie2_prsnt,
-	IPQ_MUX_pcie2_pwrflt,
-	IPQ_MUX_pcie2_pwren_n,
-	IPQ_MUX_pcie2_pwren,
+	IPQ_MUX_pcie2_prsnt_a,
+	IPQ_MUX_pcie2_prsnt_b,
+	IPQ_MUX_pcie2_pwrflt_a,
+	IPQ_MUX_pcie2_pwrflt_b,
+	IPQ_MUX_pcie2_pwren_n_a,
+	IPQ_MUX_pcie2_pwren_n_b,
+	IPQ_MUX_pcie2_pwren_a,
+	IPQ_MUX_pcie2_pwren_b,
 	IPQ_MUX_pcie2_clk_req,
 	IPQ_MUX_pcie3_rst,
 	IPQ_MUX_pcie3_prsnt,
@@ -311,15 +338,44 @@ static const char * const mdio_groups[] = {
 	"gpio0", "gpio1", "gpio10", "gpio11",
 };
 
+static const char * const mi2s_a_groups[] = {
+	"gpio27", "gpio28", "gpio29", "gpio32",
+};
+
+static const char * const mi2s_b_groups[] = {
+	"gpio55", "gpio56", "gpio57", "gpio58",
+};
+
 static const char * const mi2s_groups[] = {
-	"gpio27", "gpio28", "gpio29", "gpio30", "gpio31", "gpio32",
-	"gpio33", "gpio55", "gpio56", "gpio57", "gpio58",
+	"gpio30", "gpio31", "gpio33",
+};
+
+static const char * const pdm0_a_groups[] = {
+	"gpio51", "gpio52",
+};
+
+static const char * const pdm0_b_groups[] = {
+	"gpio2", "gpio59",
+};
+
+static const char * const pdm1_a_groups[] = {
+	"gpio30", "gpio31",
+};
+
+static const char * const pdm1_b_groups[] = {
+	"gpio16", "gpio17",
+};
+
+static const char * const pdm2_a_groups[] = {
+	"gpio55", "gpio56",
+};
+
+static const char * const pdm2_b_groups[] = {
+	"gpio34", "gpio35",
 };
 
 static const char * const pdm_groups[] = {
-	"gpio3", "gpio16", "gpio17", "gpio22", "gpio30", "gpio31",
-	"gpio34", "gpio35", "gpio52", "gpio55", "gpio56", "gpio58",
-	"gpio59",
+	"gpio22",
 };
 
 static const char * const ssbi_groups[] = {
@@ -362,9 +418,12 @@ static const char * const gsbi5_spi_cs3_groups[] = {
 	"gpio2",
 };
 
-static const char * const gsbi6_groups[] = {
-	"gpio27", "gpio28", "gpio29", "gpio30", "gpio55", "gpio56",
-	"gpio57", "gpio58",
+static const char * const gsbi6_a_groups[] = {
+	"gpio27", "gpio28", "gpio29", "gpio30",
+};
+
+static const char *const gsbi6_b_groups[] = {
+	"gpio55", "gpio56", "gpio57", "gpio58",
 };
 
 static const char * const gsbi7_groups[] = {
@@ -424,20 +483,36 @@ static const char * const pcie1_rst_groups[] = {
 	"gpio3",
 };
 
-static const char * const pcie1_prsnt_groups[] = {
-	"gpio3", "gpio11",
+static const char * const pcie1_prsnt_a_groups[] = {
+	"gpio11",
+};
+
+static const char * const pcie1_prsnt_b_groups[] = {
+	"gpio3",
+};
+
+static const char * const pcie1_pwren_n_a_groups[] = {
+	"gpio12",
 };
 
-static const char * const pcie1_pwren_n_groups[] = {
-	"gpio4", "gpio12",
+static const char * const pcie1_pwren_n_b_groups[] = {
+	"gpio4",
 };
 
-static const char * const pcie1_pwren_groups[] = {
-	"gpio4", "gpio12",
+static const char * const pcie1_pwren_a_groups[] = {
+	"gpio12",
 };
 
-static const char * const pcie1_pwrflt_groups[] = {
-	"gpio5", "gpio13",
+static const char * const pcie1_pwren_b_groups[] = {
+	"gpio4",
+};
+
+static const char * const pcie1_pwrflt_a_groups[] = {
+	"gpio13",
+};
+
+static const char * const pcie1_pwrflt_b_groups[] = {
+	"gpio5",
 };
 
 static const char * const pcie1_clk_req_groups[] = {
@@ -448,20 +523,36 @@ static const char * const pcie2_rst_groups[] = {
 	"gpio48",
 };
 
-static const char * const pcie2_prsnt_groups[] = {
-	"gpio11", "gpio48",
+static const char * const pcie2_prsnt_a_groups[] = {
+	"gpio11",
+};
+
+static const char * const pcie2_prsnt_b_groups[] = {
+	"gpio48",
+};
+
+static const char * const pcie2_pwren_n_a_groups[] = {
+	"gpio12",
+};
+
+static const char * const pcie2_pwren_n_b_groups[] = {
+	"gpio49",
 };
 
-static const char * const pcie2_pwren_n_groups[] = {
-	"gpio12", "gpio49",
+static const char * const pcie2_pwren_a_groups[] = {
+	"gpio12",
 };
 
-static const char * const pcie2_pwren_groups[] = {
-	"gpio12", "gpio49",
+static const char * const pcie2_pwren_b_groups[] = {
+	"gpio49",
 };
 
-static const char * const pcie2_pwrflt_groups[] = {
-	"gpio13", "gpio50",
+static const char * const pcie2_pwrflt_a_groups[] = {
+	"gpio13",
+};
+
+static const char * const pcie2_pwrflt_b_groups[] = {
+	"gpio50",
 };
 
 static const char * const pcie2_clk_req_groups[] = {
@@ -499,10 +590,18 @@ static const char * const ps_hold_groups[] = {
 static const struct msm_function ipq8064_functions[] = {
 	FUNCTION(gpio),
 	FUNCTION(mdio),
-	FUNCTION(ssbi),
-	FUNCTION(spmi),
+	FUNCTION_MULTI_COPY(mi2s_a, 0x2074, 0x0),
+	FUNCTION_MULTI_COPY(mi2s_b, 0x2074, 0x1),
 	FUNCTION(mi2s),
+	FUNCTION_MULTI_COPY(pdm0_a, 0x2068, 0x0),
+	FUNCTION_MULTI_COPY(pdm0_b, 0x2068, 0x1),
+	FUNCTION_MULTI_COPY(pdm1_a, 0x206c, 0x0),
+	FUNCTION_MULTI_COPY(pdm1_b, 0x206c, 0x1),
+	FUNCTION_MULTI_COPY(pdm2_a, 0x2070, 0x0),
+	FUNCTION_MULTI_COPY(pdm2_b, 0x2070, 0x1),
 	FUNCTION(pdm),
+	FUNCTION(ssbi),
+	FUNCTION(spmi),
 	FUNCTION(audio_pcm),
 	FUNCTION(gsbi1),
 	FUNCTION(gsbi2),
@@ -511,7 +610,8 @@ static const struct msm_function ipq8064_functions[] = {
 	FUNCTION(gsbi5_spi_cs1),
 	FUNCTION(gsbi5_spi_cs2),
 	FUNCTION(gsbi5_spi_cs3),
-	FUNCTION(gsbi6),
+	FUNCTION_MULTI_COPY(gsbi6_a, 0x2088, 0x0),
+	FUNCTION_MULTI_COPY(gsbi6_b, 0x2088, 0x1),
 	FUNCTION(gsbi7),
 	FUNCTION(nss_spi),
 	FUNCTION(sdc1),
@@ -525,16 +625,24 @@ static const struct msm_function ipq8064_functions[] = {
 	FUNCTION(rgmii2),
 	FUNCTION(sata),
 	FUNCTION(pcie1_rst),
-	FUNCTION(pcie1_prsnt),
-	FUNCTION(pcie1_pwren_n),
-	FUNCTION(pcie1_pwren),
-	FUNCTION(pcie1_pwrflt),
+	FUNCTION_MULTI_COPY(pcie1_prsnt_a, 0x207c, 0),
+	FUNCTION_MULTI_COPY(pcie1_prsnt_b, 0x207c, 1),
+	FUNCTION_MULTI_COPY(pcie1_pwren_n_a, 0x207c, 0),
+	FUNCTION_MULTI_COPY(pcie1_pwren_n_b, 0x207c, 1),
+	FUNCTION_MULTI_COPY(pcie1_pwren_a, 0x207c, 0),
+	FUNCTION_MULTI_COPY(pcie1_pwren_b, 0x207c, 1),
+	FUNCTION_MULTI_COPY(pcie1_pwrflt_a, 0x207c, 0),
+	FUNCTION_MULTI_COPY(pcie1_pwrflt_b, 0x207c, 1),
 	FUNCTION(pcie1_clk_req),
 	FUNCTION(pcie2_rst),
-	FUNCTION(pcie2_prsnt),
-	FUNCTION(pcie2_pwren_n),
-	FUNCTION(pcie2_pwren),
-	FUNCTION(pcie2_pwrflt),
+	FUNCTION_MULTI_COPY(pcie2_prsnt_a, 0x2080, 0),
+	FUNCTION_MULTI_COPY(pcie2_prsnt_b, 0x2080, 1),
+	FUNCTION_MULTI_COPY(pcie2_pwren_n_a, 0x2080, 0),
+	FUNCTION_MULTI_COPY(pcie2_pwren_n_b, 0x2080, 1),
+	FUNCTION_MULTI_COPY(pcie2_pwren_a, 0x2080, 0),
+	FUNCTION_MULTI_COPY(pcie2_pwren_b, 0x2080, 1),
+	FUNCTION_MULTI_COPY(pcie2_pwrflt_a, 0x2080, 0),
+	FUNCTION_MULTI_COPY(pcie2_pwrflt_b, 0x2080, 1),
 	FUNCTION(pcie2_clk_req),
 	FUNCTION(pcie3_rst),
 	FUNCTION(pcie3_prsnt),
@@ -549,21 +657,21 @@ static const struct msm_pingroup ipq8064_groups[] = {
 	PINGROUP(0, mdio, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(1, mdio, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(2, gsbi5_spi_cs3, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(3, pcie1_rst, pcie1_prsnt, pdm, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(4, pcie1_pwren_n, pcie1_pwren, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(5, pcie1_clk_req, pcie1_pwrflt, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(3, pcie1_rst, pcie1_prsnt_b, pdm0_b, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(4, pcie1_pwren_n_b, pcie1_pwren_b, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(5, pcie1_clk_req, pcie1_pwrflt_b, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(6, gsbi7, usb_fs, gsbi5_spi_cs1, usb_fs_n, NA, NA, NA, NA, NA, NA),
 	PINGROUP(7, gsbi7, usb_fs, gsbi5_spi_cs2, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(8, gsbi7, usb_fs, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(9, gsbi7, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(10, gsbi4, spdif, sata, ssbi, mdio, spmi, NA, NA, NA, NA),
-	PINGROUP(11, gsbi4, pcie2_prsnt, pcie1_prsnt, pcie3_prsnt, ssbi, mdio, spmi, NA, NA, NA),
-	PINGROUP(12, gsbi4, pcie2_pwren_n, pcie1_pwren_n, pcie3_pwren_n, pcie2_pwren, pcie1_pwren, pcie3_pwren, NA, NA, NA),
-	PINGROUP(13, gsbi4, pcie2_pwrflt, pcie1_pwrflt, pcie3_pwrflt, NA, NA, NA, NA, NA, NA),
+	PINGROUP(11, gsbi4, pcie2_prsnt_a, pcie1_prsnt_a, pcie3_prsnt, ssbi, mdio, spmi, NA, NA, NA),
+	PINGROUP(12, gsbi4, pcie2_pwren_n_a, pcie1_pwren_n_a, pcie3_pwren_n, pcie2_pwren_a, pcie1_pwren_a, pcie3_pwren, NA, NA, NA),
+	PINGROUP(13, gsbi4, pcie2_pwrflt_a, pcie1_pwrflt_a, pcie3_pwrflt, NA, NA, NA, NA, NA, NA),
 	PINGROUP(14, audio_pcm, nss_spi, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(15, audio_pcm, nss_spi, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(16, audio_pcm, nss_spi, pdm, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(17, audio_pcm, nss_spi, pdm, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(16, audio_pcm, nss_spi, pdm1_b, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(17, audio_pcm, nss_spi, pdm1_b, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(18, gsbi5, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(19, gsbi5, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(20, gsbi5, NA, NA, NA, NA, NA, NA, NA, NA, NA),
@@ -573,15 +681,15 @@ static const struct msm_pingroup ipq8064_groups[] = {
 	PINGROUP(24, gsbi2, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(25, gsbi2, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(26, ps_hold, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(27, mi2s, rgmii2, gsbi6, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(28, mi2s, rgmii2, gsbi6, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(29, mi2s, rgmii2, gsbi6, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(30, mi2s, rgmii2, gsbi6, pdm, NA, NA, NA, NA, NA, NA),
-	PINGROUP(31, mi2s, rgmii2, pdm, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(32, mi2s, rgmii2, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(27, mi2s_a, rgmii2, gsbi6_a, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(28, mi2s_a, rgmii2, gsbi6_a, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(29, mi2s_a, rgmii2, gsbi6_a, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(30, mi2s, rgmii2, gsbi6_a, pdm1_a, NA, NA, NA, NA, NA, NA),
+	PINGROUP(31, mi2s, rgmii2, pdm1_a, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(32, mi2s_a, rgmii2, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(33, mi2s, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(34, nand, pdm, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(35, nand, pdm, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(34, nand, pdm2_b, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(35, nand, pdm2_b, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(36, nand, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(37, nand, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(38, nand, sdc1, NA, NA, NA, NA, NA, NA, NA, NA),
@@ -595,17 +703,17 @@ static const struct msm_pingroup ipq8064_groups[] = {
 	PINGROUP(46, nand, sdc1, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(47, nand, sdc1, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(48, pcie2_rst, spdif, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(49, pcie2_pwren_n, pcie2_pwren, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(50, pcie2_clk_req, pcie2_pwrflt, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(49, pcie2_pwren_n_b, pcie2_pwren_b, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(50, pcie2_clk_req, pcie2_pwrflt_b, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(51, gsbi1, rgmii2, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(52, gsbi1, rgmii2, pdm, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(52, gsbi1, rgmii2, pdm0_a, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(53, gsbi1, NA, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(54, gsbi1, NA, NA, NA, NA, NA, NA, NA, NA, NA),
-	PINGROUP(55, tsif1, mi2s, gsbi6, pdm, nss_spi, NA, NA, NA, NA, NA),
-	PINGROUP(56, tsif1, mi2s, gsbi6, pdm, nss_spi, NA, NA, NA, NA, NA),
-	PINGROUP(57, tsif1, mi2s, gsbi6, nss_spi, NA, NA, NA, NA, NA, NA),
-	PINGROUP(58, tsif1, mi2s, gsbi6, pdm, nss_spi, NA, NA, NA, NA, NA),
-	PINGROUP(59, tsif2, rgmii2, pdm, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(55, tsif1, mi2s_b, gsbi6_b, pdm2_a, nss_spi, NA, NA, NA, NA, NA),
+	PINGROUP(56, tsif1, mi2s_b, gsbi6_b, pdm2_a, nss_spi, NA, NA, NA, NA, NA),
+	PINGROUP(57, tsif1, mi2s_b, gsbi6_b, nss_spi, NA, NA, NA, NA, NA, NA),
+	PINGROUP(58, tsif1, mi2s_b, gsbi6_b, pdm0_a, nss_spi, NA, NA, NA, NA, NA),
+	PINGROUP(59, tsif2, rgmii2, pdm0_b, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(60, tsif2, rgmii2, NA, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(61, tsif2, rgmii2, gsbi5_spi_cs1, NA, NA, NA, NA, NA, NA, NA),
 	PINGROUP(62, tsif2, rgmii2, gsbi5_spi_cs2, NA, NA, NA, NA, NA, NA, NA),
-- 
Qualcomm Innovation Center, Inc
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
