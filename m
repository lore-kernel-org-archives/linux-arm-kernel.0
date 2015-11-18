From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 17 Nov 2015 17:00:26 -0800
Subject: [RFC/PATCH] pinctrl: qcom: Add generic ssbi and spmi GPIO/MPP bindings
Message-ID: <1447808426-21834-1-git-send-email-sboyd@codeaurora.org>
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
Cc: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

We can also figure out the number of the pins from the number
of interrupts, so we really don't need to even look at the size of the
reg property or model number for the spmi and ssbi modules. I'll propose
that change as well tomorrow.

 Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 5 ++++-
 Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt  | 5 ++++-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                     | 1 +
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c                      | 1 +
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt
index a90c812ad642..f1e4643f4132 100644
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
index df4413023e21..9f9979903fcb 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -806,6 +806,7 @@ static const struct of_device_id pmic_gpio_of_match[] = {
 	{ .compatible = "qcom,pm8941-gpio" },	/* 36 GPIO's */
 	{ .compatible = "qcom,pm8994-gpio" },	/* 22 GPIO's */
 	{ .compatible = "qcom,pma8084-gpio" },	/* 22 GPIO's */
+	{ .compatible = "qcom,spmi-gpio" }, /* Generic */
 	{ },
 };
 
diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
index 7b4136a22c5b..5a4373dd9c61 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-mpp.c
@@ -909,6 +909,7 @@ static const struct of_device_id pmic_mpp_of_match[] = {
 	{ .compatible = "qcom,pm8941-mpp" },	/* 8 MPP's */
 	{ .compatible = "qcom,pm8994-mpp" },	/* 8 MPP's */
 	{ .compatible = "qcom,pma8084-mpp" },	/* 8 MPP's */
+	{ .compatible = "qcom,spmi-mpp" },	/* Generic */
 	{ },
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
