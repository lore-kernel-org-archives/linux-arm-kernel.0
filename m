From: andrew@aj.id.au (Andrew Jeffery)
Date: Wed, 20 Jul 2016 15:28:22 +0930
Subject: [PATCH 01/12] pinctrl: dt-bindings: Add documentation for Aspeed pin
 controllers
In-Reply-To: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
References: <1468994313-13538-1-git-send-email-andrew@aj.id.au>
Message-ID: <1468994313-13538-2-git-send-email-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Outline expectations on the pin controller's relationship with the
System Control Unit (SCU) IP through syscon, and document the compatible
strings for 4th and 5th generation Aspeed SoC pin controllers.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 .../devicetree/bindings/pinctrl/pinctrl-aspeed.txt | 45 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
new file mode 100644
index 000000000000..5aac6a0a2e89
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt
@@ -0,0 +1,45 @@
+Aspeed Pin Controllers
+----------------------
+
+The Aspeed SoCs vary in functionality inside a generation but have a common mux
+device register layout.
+
+Required properties:
+- compatible: should be one of the following:
+	"aspeed,g4-pinctrl";
+	"aspeed,g5-pinctrl"
+
+The pin controller node should be a child of a syscon node with the required
+property:
+- compatible: "syscon", "simple-mfd"
+
+Refer to the the bindings described in
+Documentation/devicetree/bindings/mfd/syscon.txt
+
+Subnode format:
+
+Please refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices.
+
+The required properties of child nodes are (as defined in pinctrl-bindings):
+- function
+- groups
+
+Each function has only one associated pin group. Each group is named by its
+function.
+
+Examples:
+
+syscon: scu at 1e6e2000 {
+	compatible = "syscon", "simple-mfd";
+	reg = <0x1e6e2000 0x1a8>;
+
+	pinctrl: pinctrl at 1e6e2000 {
+		compatible = "aspeed,g4-pinctrl";
+
+		pinctrl_i2c3_default: i2c3_default {
+			function = "I2C3";
+			groups = "I2C3";
+		};
+	};
+};
diff --git a/MAINTAINERS b/MAINTAINERS
index 1209323b7e43..b5f2d3576d3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1003,6 +1003,7 @@ S:	Maintained
 F:	arch/arm/mach-aspeed/
 F:	arch/arm/boot/dts/aspeed-*
 F:	drivers/*/*aspeed*
+F:	Documentation/devicetree/bindings/*/*aspeed*
 
 ARM/ATMEL AT91RM9200, AT91SAM9 AND SAMA5 SOC SUPPORT
 M:	Nicolas Ferre <nicolas.ferre@atmel.com>
-- 
2.7.4
