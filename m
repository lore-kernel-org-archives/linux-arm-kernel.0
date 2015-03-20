From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Fri, 20 Mar 2015 11:51:23 +0530
Subject: [PATCH v3 6/6] clk: qcom: gdsc: Add GDSCs in apq8084 GCC
In-Reply-To: <1426832483-27026-1-git-send-email-rnayak@codeaurora.org>
References: <1426832483-27026-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1426832483-27026-7-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the GDSC instances that exist as part of apq8084 GCC block

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8084.dtsi          |  1 +
 drivers/clk/qcom/Kconfig                     |  1 +
 drivers/clk/qcom/gcc-apq8084.c               | 38 ++++++++++++++++++++++++++++
 include/dt-bindings/clock/qcom,gcc-apq8084.h |  6 +++++
 4 files changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
index 1f130bc..55c281c 100644
--- a/arch/arm/boot/dts/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
@@ -183,6 +183,7 @@
 			compatible = "qcom,gcc-apq8084";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
+			#power-domain-cells = <1>;
 			reg = <0xfc400000 0x4000>;
 		};
 
diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 104ec0c..c246417 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -6,6 +6,7 @@ config COMMON_CLK_QCOM
 
 config APQ_GCC_8084
 	tristate "APQ8084 Global Clock Controller"
+	select QCOM_GDSC
 	depends on COMMON_CLK_QCOM
 	help
 	  Support for the global clock controller on apq8084 devices.
diff --git a/drivers/clk/qcom/gcc-apq8084.c b/drivers/clk/qcom/gcc-apq8084.c
index f75b505..6fafc2a 100644
--- a/drivers/clk/qcom/gcc-apq8084.c
+++ b/drivers/clk/qcom/gcc-apq8084.c
@@ -31,6 +31,7 @@
 #include "clk-rcg.h"
 #include "clk-branch.h"
 #include "reset.h"
+#include "gdsc.h"
 
 enum {
 	P_XO,
@@ -3259,6 +3260,34 @@ static struct clk_branch gcc_usb_hsic_system_clk = {
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
@@ -3452,6 +3481,13 @@ static struct clk_regmap *gcc_apq8084_clocks[] = {
 	[GCC_USB_HSIC_SYSTEM_CLK] = &gcc_usb_hsic_system_clk.clkr,
 };
 
+static struct gdsc *gcc_apq8084_gdscs[] = {
+	[USB_HS_HSIC_GDSC] = &usb_hs_hsic_gdsc,
+	[PCIE0_GDSC] = &pcie0_gdsc,
+	[PCIE1_GDSC] = &pcie1_gdsc,
+	[USB30_GDSC] = &usb30_gdsc,
+};
+
 static const struct qcom_reset_map gcc_apq8084_resets[] = {
 	[GCC_SYSTEM_NOC_BCR] = { 0x0100 },
 	[GCC_CONFIG_NOC_BCR] = { 0x0140 },
@@ -3560,6 +3596,8 @@ static const struct qcom_cc_desc gcc_apq8084_desc = {
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
