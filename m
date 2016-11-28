From: david@lechnology.com (David Lechner)
Date: Mon, 28 Nov 2016 10:40:24 -0600
Subject: [PATCH v2 1/3] devicetree: bindings: pinctrl: Add binding for ti,
 da850-pupd
In-Reply-To: <1480351226-3332-1-git-send-email-david@lechnology.com>
References: <1480351226-3332-1-git-send-email-david@lechnology.com>
Message-ID: <1480351226-3332-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device-tree bindings for TI DA850/OMAP-L138/AM18XX pullup/pulldown
pinconf controller.

Signed-off-by: David Lechner <david@lechnology.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
---

v2 changes:
* s/DA8XX/DA850/ in the commit message

 .../devicetree/bindings/pinctrl/ti,da850-pupd.txt  | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ti,da850-pupd.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/ti,da850-pupd.txt b/Documentation/devicetree/bindings/pinctrl/ti,da850-pupd.txt
new file mode 100644
index 0000000..7f29805
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/ti,da850-pupd.txt
@@ -0,0 +1,55 @@
+* Pin configuration for TI DA850/OMAP-L138/AM18x
+
+These SoCs have a separate controller for setting bias (internal pullup/down).
+Bias can only be selected for groups rather than individual pins.
+
+Required Properties:
+
+  - compatible: Must be "ti,da850-pupd"
+  - reg: Base address and length of the memory resource used by the pullup/down
+    controller hardware module.
+
+The controller node also acts as a container for pin group configuration nodes.
+The names of these groups are ignored.
+
+Pin Group Node Properties:
+
+- groups: An array of strings, each string containing the name of a pin group.
+          Valid names are "cp0".."cp31".
+
+The pin configuration parameters use the generic pinconf bindings defined in
+pinctrl-bindings.txt in this directory. The supported parameters are
+bias-disable, bias-pull-up, bias-pull-down.
+
+
+Example
+-------
+
+In common dtsi file:
+
+	pinconf: pin-controller at 22c00c {
+		compatible = "ti,da850-pupd";
+		reg = <0x22c00c 0x8>;
+	};
+
+In board-specific file:
+
+	&pinconf {
+		pinctrl-0 = <&pinconf_bias_groups>;
+		pinctrl-names = "default";
+
+		pinconf_bias_groups: bias-groups {
+			pull-up {
+				groups = "cp30", "cp31";
+				bias-pull-up;
+			};
+			pull-down {
+				groups = "cp29", "cp28";
+				bias-pull-down;
+			};
+			disable {
+				groups = "cp27", "cp26";
+				bias-disable;
+			};
+		};
+	};
-- 
2.7.4
