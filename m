From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 04 Dec 2013 11:40:15 +0100
Subject: [PATCH v6 3/3] mfd: max14577: Add device tree bindings document
In-Reply-To: <1386153615-25456-1-git-send-email-k.kozlowski@samsung.com>
References: <1386153615-25456-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1386153615-25456-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add document describing device tree bindings for MAX14577 MFD driver.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 Documentation/devicetree/bindings/mfd/max14577.txt |   48 ++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt

diff --git a/Documentation/devicetree/bindings/mfd/max14577.txt b/Documentation/devicetree/bindings/mfd/max14577.txt
new file mode 100644
index 000000000000..f4fd16360b6b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max14577.txt
@@ -0,0 +1,48 @@
+MAXIM MAX14577 multi-function device
+
+MAX14577 is a Multi-function device with Micro-USB Interface Circuit, Li+
+Battery Charger and SFOUT LDO output for powering USB devices. It is
+interfaced to host controller using I2C.
+
+Required properties:
+- compatible : Must be "maxim,max14577".
+- reg : I2C slave address for the max14577 chip.
+- interrupts : IRQ line for the max14577 chip.
+- interrupt-parent :  The parent interrupt controller.
+
+Optional nodes:
+- regulators :
+  Required child node properties:
+  - compatible : "maxim,max14577-regulator"
+
+  Optional child nodes:
+    Each child node representing a regulator, following standard regulator
+    bindings. Valid names for a regulator are: "CHARGER" and "SAFEOUT".
+    The SAFEOUT is a constant voltage regulator so there is no need to specify
+    voltages for it.
+
+	[*] refer Documentation/devicetree/bindings/regulator/regulator.txt
+
+Example:
+	max14577 at 25 {
+		compatible = "maxim,max14577";
+		reg = <0x25>;
+		interrupt-parent = <&gpx1>;
+		interrupts = <5 0>;
+
+		regulators {
+			compatible = "maxim,max14577-regulator";
+
+			safeout_reg: safeout at 1 {
+				regulator-compatible = "SAFEOUT";
+				regulator-name = "SAFEOUT";
+			};
+			charger_reg: charger at 0 {
+				regulator-compatible = "CHARGER";
+				regulator-name = "CHARGER";
+				regulator-min-microamp = <90000>;
+				regulator-max-microamp = <950000>;
+				regulator-boot-on;
+			};
+		};
+	};
-- 
1.7.9.5
