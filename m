From: carlo@caione.org (Carlo Caione)
Date: Sat,  8 Feb 2014 17:03:48 +0100
Subject: [PATCH 3/3] mfd: axp20x: Add bindings documentation
In-Reply-To: <1391875428-6281-1-git-send-email-carlo@caione.org>
References: <1391875428-6281-1-git-send-email-carlo@caione.org>
Message-ID: <1391875428-6281-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bindings documentation for the axp20x driver. In this file also two
sub-nodes (PEK and regulators) are documented.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 87 ++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
new file mode 100644
index 0000000..ccea6b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -0,0 +1,87 @@
+* axp20x device tree bindings
+
+The axp20x family current members :-
+axp202 (x-powers)
+axp209 (x-powers)
+
+Required properties:
+- compatible : Should be "x-powers,axp20x" (for axp202 and axp209)
+- interrupt-controller : axp20x has its own internal IRQs
+- #interrupt-cells : should be set to 1
+- interrupt-parent : The parent interrupt controller
+- interrupts : Specifies the list of interrupt lines which are handled by
+	       the device in the parent controller's notation
+- reg : Specifies base physical address and size of the registers
+
+Sub-nodes
+* regulators : Contain the regulator nodes. The regulators are bound using
+	       their name as listed here: dcdc2, dcdc3, ldo1, ldo2, ldo3,
+	       ldo4, ldo5.
+	       The bindings details of individual regulator device can be found in:
+	       Documentation/devicetree/bindings/regulator/regulator.txt with the
+	       exception of:
+
+	- dcdc-freq : defines the work frequency of DC-DC where
+		      F=(1+dcdc-freq*5%)*1.5MHz
+
+* axp20x-pek : Power Enable Key
+	- compatible : should be "x-powers,axp20x-pek"
+	- interrupts : two interrupt numbers with order defined by interrupt-names
+		       (one irq number for rising transition of the power key, the
+		       other one for falling transition)
+	- interrupt-names : should be "PEK_DBR" and "PEK_DBF"
+
+Example:
+
+axp {
+	compatible = "x-powers,axp20x";
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	axp20x-pek {
+		compatible = "x-powers,axp20x-pek";
+		interrupts = <33>,  <34>;
+		interrupt-names = "PEK_DBR", "PEK_DBF";
+	};
+
+	regulators {
+		dcdc-freq = "8";
+
+		axp_dcdc2: dcdc2 {
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <2275000>;
+			dcdc-workmode = <0>;
+		};
+
+		axp_dcdc3: dcdc3 {
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <3500000>;
+			dcdc-workmode = <0>;
+		};
+
+		axp_ldo1: ldo1 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		axp_ldo2: ldo2 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		axp_ldo3: ldo3 {
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <3500000>;
+		};
+
+		axp_ldo4: ldo4 {
+			regulator-min-microvolt = <1250000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		axp_ldo5: ldo5 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
+};
-- 
1.8.5.3
