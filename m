From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 11 Jul 2016 12:01:09 -0700
Subject: [PATCH] pinctrl: qcom: Add generic ssbi and spmi GPIO/MPP bindings
Message-ID: <20160711190109.16758-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The drivers don't really need to know which PMIC they're for, so
make a generic binding for them. This alleviates us from updating
the drivers every time a new PMIC comes out. It's still
recommended that we update the binding with new PMIC models and
always specify the specific model for the MPPs and gpios before
the generic compatible string in devicetree, but this at least
cuts down on adding more and more compatible strings to the
drivers until we actually need them.

Cc: <devicetree@vger.kernel.org>
Acked-by: "Ivan T. Ivanov" <iivanov.xz@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

This seems to been missed 6 months ago when sent as an RFC. The dts
side changes have already been made and Rob H said it "Seems okay to
me".

 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 5 ++++-
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt  | 5 ++++-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                     | 1 +
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c                      | 1 +
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
index a54c39ebbf8b..8d893a874634 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
@@ -17,6 +17,9 @@ PMIC's from Qualcomm.
 		    "qcom,pm8994-gpio"
 		    "qcom,pma8084-gpio"
 
+		    And must contain either "qcom,spmi-gpio" or "qcom,ssbi-gpio"
+		    if the device is on an spmi bus or an ssbi bus respectively
+
 - reg:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -183,7 +186,7 @@ to specify in a pin configuration subnode:
 Example:
 
 	pm8921_gpio: gpio at 150 {
-		compatible = "qcom,pm8921-gpio";
+		compatible = "qcom,pm8921-gpio", "qcom,ssbi-gpio";
 		reg = <0x150 0x160>;
 		interrupts = <192 1>, <193 1>, <194 1>,
 			     <195 1>, <196 1>, <197 1>,
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt
index d74e631e10da..e28320b18ecb 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt
@@ -18,6 +18,9 @@ of PMIC's from Qualcomm.
 		    "qcom,pm8994-mpp",
 		    "qcom,pma8084-mpp",
 
+		    And must contain either "qcom,spmi-mpp" or "qcom,ssbi-mpp"
+		    if the device is on an spmi bus or an ssbi bus respectively.
+
 - reg:
 	Usage: required
 	Value type: <prop-encoded-array>
@@ -157,7 +160,7 @@ to specify in a pin configuration subnode:
 Example:
 
 	mpps at a000 {
-		compatible = "qcom,pm8841-mpp";
+		compatible = "qcom,pm8841-mpp", "qcom,spmi-mpp";
 		reg = <0xa000>;
 		gpio-controller;
 		#gpio-cells = <2>;
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index 686accb89f52..664b641fd776 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -800,6 +800,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm8941-gpio" },	/* 36 GPIO's */
 	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
 	{ .compatible = "qcom,pma8084-gpio" },	/* 22 GPIO's */
+	{ .compatible = "qcom,spmi-gpio" }, /* Generic */
 	{ },
 };
 
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index 1735ffef9d5c..6556dbeae65e 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -914,6 +914,7 @@ static const struct of_device_id pmic_mpp_of_match[] = {
 	{ .compatible = "qcom,pm8941-mpp" },	/* 8 MPP's */
 	{ .compatible = "qcom,pm8994-mpp" },	/* 8 MPP's */
 	{ .compatible = "qcom,pma8084-mpp" },	/* 8 MPP's */
+	{ .compatible = "qcom,spmi-mpp" },	/* Generic */
 	{ },
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
