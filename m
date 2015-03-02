From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Mon,  2 Mar 2015 12:32:29 +0530
Subject: [PATCH 6/6] clk: qcom: gdsc: Add GDSCs in apq8084 GCC
In-Reply-To: <1425279749-16625-1-git-send-email-rnayak@codeaurora.org>
References: <1425279749-16625-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1425279749-16625-7-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the GDSC instances that exist as part of apq8084 GCC block

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gcc-apq8084.c               | 38 ++++++++++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-apq8084.h |  6 +++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/clk/qcom/gcc-apq8084.c b/drivers/clk/qcom/gcc-apq8084.c
index e3ef902..ccab028 100644
--- a/drivers/clk/qcom/gcc-apq8084.c
+++ b/drivers/clk/qcom/gcc-apq8084.c
@@ -31,6 +31,7 @@
 #include "clk-rcg.h"
 #include "clk-branch.h"
 #include "reset.h"
+#include "gdsc.h"
 
 #define P_XO	0
 #define P_GPLL0	1
@@ -3251,6 +3252,34 @@ static struct clk_branch gcc_usb_hsic_system_clk = {
 	},
 };
 
+static struct gdsc usb_hs_hsic_gdsc = {
+	.gdscr = 0x404,
+	.pd = {
+		.name = "usb_hs_hsic",
+	},
+};
+
+static struct gdsc pcie0_gdsc = {
+	.gdscr = 0x1ac4,
+	.pd = {
+		.name = "pcie0",
+	},
+};
+
+static struct gdsc pcie1_gdsc = {
+	.gdscr = 0x1b44,
+	.pd = {
+		.name = "pcie1",
+	},
+};
+
+static struct gdsc usb30_gdsc = {
+	.gdscr = 0x1e84,
+	.pd = {
+		.name = "usb30",
+	},
+};
+
 static struct clk_regmap *gcc_apq8084_clocks[] = {
 	[GPLL0] = &gpll0.clkr,
 	[GPLL0_VOTE] = &gpll0_vote,
@@ -3444,6 +3473,13 @@ static struct clk_regmap *gcc_apq8084_clocks[] = {
 	[GCC_USB_HSIC_SYSTEM_CLK] = &gcc_usb_hsic_system_clk.clkr,
 };
 
+static struct generic_pm_domain *gcc_apq8084_gdscs[] = {
+	[USB_HS_HSIC_GDSC] = &usb_hs_hsic_gdsc.pd,
+	[PCIE0_GDSC] = &pcie0_gdsc.pd,
+	[PCIE1_GDSC] = &pcie1_gdsc.pd,
+	[USB30_GDSC] = &usb30_gdsc.pd,
+};
+
 static const struct qcom_reset_map gcc_apq8084_resets[] = {
 	[GCC_SYSTEM_NOC_BCR] = { 0x0100 },
 	[GCC_CONFIG_NOC_BCR] = { 0x0140 },
@@ -3552,6 +3588,8 @@ static const struct qcom_cc_desc gcc_apq8084_desc = {
 	.num_clks = ARRAY_SIZE(gcc_apq8084_clocks),
 	.resets = gcc_apq8084_resets,
 	.num_resets = ARRAY_SIZE(gcc_apq8084_resets),
+	.gdscs = gcc_apq8084_gdscs,
+	.num_gdscs = ARRAY_SIZE(gcc_apq8084_gdscs),
 };
 
 static const struct of_device_id gcc_apq8084_match_table[] = {
diff --git a/include/dt-bindings/clock/qcom,gcc-apq8084.h b/include/dt-bindings/clock/qcom,gcc-apq8084.h
index 2c0da56..5aa7ebe 100644
--- a/include/dt-bindings/clock/qcom,gcc-apq8084.h
+++ b/include/dt-bindings/clock/qcom,gcc-apq8084.h
@@ -348,4 +348,10 @@
 #define GCC_PCIE_1_PIPE_CLK				331
 #define GCC_PCIE_1_SLV_AXI_CLK				332
 
+/* gdscs */
+#define USB_HS_HSIC_GDSC				0
+#define PCIE0_GDSC					1
+#define PCIE1_GDSC					2
+#define USB30_GDSC					3
+
 #endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
