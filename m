From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 17:42:50 -0700
Subject: [PATCH v5 1/2] dt-binding: power: Add otg regulator binding
In-Reply-To: <20161018004251.28733-1-stephen.boyd@linaro.org>
References: <20161018004251.28733-1-stephen.boyd@linaro.org>
Message-ID: <20161018004251.28733-2-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Bird, Tim" <Tim.Bird@sonymobile.com>

Add a binding for the regulator which controls the OTG chargepath switch.
The OTG switch gets its power from pm8941_5vs1, and that should be
expressed as a usb_otg_in-supply property in the DT node for the
charger driver.  The regulator name is "otg-vbus".

Signed-off-by: Tim Bird <tim.bird@sonymobile.com>
Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Reviewed-by: Andy Gross <andy.gross@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 .../devicetree/bindings/power/supply/qcom_smbb.txt    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom_smbb.txt b/Documentation/devicetree/bindings/power/supply/qcom_smbb.txt
index 65b88fac854b..06f8a5ddb68e 100644
--- a/Documentation/devicetree/bindings/power/supply/qcom_smbb.txt
+++ b/Documentation/devicetree/bindings/power/supply/qcom_smbb.txt
@@ -105,6 +105,22 @@ PROPERTIES
                regulation must be done externally to fully comply with
                the JEITA safety guidelines if this flag is set.
 
+- usb_otg_in-supply:
+  Usage: optional
+  Value type: <phandle>
+  Description: Reference to the regulator supplying power to the USB_OTG_IN
+               pin.
+
+child nodes:
+- otg-vbus:
+  Usage: optional
+  Description: This node defines a regulator used to control the direction
+               of VBUS voltage - specifically: whether to supply voltage
+               to VBUS for host mode operation of the OTG port, or allow
+               input voltage from external VBUS for charging.  In the
+               hardware, the supply for this regulator comes from
+               usb_otg_in-supply.
+
 EXAMPLE
 charger at 1000 {
        compatible = "qcom,pm8941-charger";
@@ -128,4 +144,7 @@ charger at 1000 {
 
        qcom,fast-charge-current-limit = <1000000>;
        qcom,dc-charge-current-limit = <1000000>;
+       usb_otg_in-supply = <&pm8941_5vs1>;
+
+       otg-vbus {};
 };
-- 
2.10.0.297.gf6727b0
