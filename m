From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 10 Sep 2015 12:39:17 +0200
Subject: [PATCH 2/3] ARM: at91/dt: shdwc binding: add new shutdown controller
 documentation
In-Reply-To: <bc6fb78ccf190a6e24f69d70036bc3cd3ec42673.1441881064.git.nicolas.ferre@atmel.com>
References: <bc6fb78ccf190a6e24f69d70036bc3cd3ec42673.1441881064.git.nicolas.ferre@atmel.com>
Message-ID: <0a211dfea397ef20c9c6b5f4e23d42699fbd69b1.1441881064.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new shutdown controller compatible with sama5d2 has a new binding
documentation and properties.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../devicetree/bindings/arm/atmel-at91.txt         | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 7fd64ec9ee1d..ec4b183005e4 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -147,6 +147,58 @@ Example:
 		clocks = <&clk32k>;
 	};
 
+SHDWC Shutdown Controller (Alternative)
+
+1) shdwc node
+
+required properties:
+- compatible: should be "atmel,sama5d2-shdwc".
+- reg: should contain registers location and length
+- #address-cells: should be one. The cell is the wake-up input index.
+- #size-cells: should be zero.
+
+optional properties:
+
+- atmel,wakeup-debouncer: minimum wake-up inputs debouncer period in
+  micro-seconds. It's usually a board-related property.
+- atmel,wakeup-rtc-timer: boolean to enable Real-Time Clock wake-up.
+
+The node contains child nodes for each wake-up input that the platform uses.
+
+2) input nodes
+
+Wake-up input nodes are usually described in the "board" part of the Device
+Tree. Note also that input 0 is linked to the wake-up pin and is frequently
+used.
+
+Required properties:
+- reg: should contain the wake-up input index [0 - 15].
+
+Optional properties:
+- atmel,wakeup-type: string, operation mode of the input described by the child
+  node. Supported values are: "high" or "low".
+
+Example:
+
+On the SoC side:
+	shdwc at f8048010 {
+		compatible = "atmel,sama5d2-shdwc";
+		reg = <0xf8048010 0x10>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		atmel,wakeup-rtc-timer;
+	};
+
+On the board side:
+	shdwc at f8048010 {
+		atmel,shdwc-debouncer = <976>;
+
+		input at 0 {
+			reg = <0>;
+			atmel,wakeup-type = "low";
+		};
+	};
+
 Special Function Registers (SFR)
 
 Special Function Registers (SFR) manage specific aspects of the integrated
-- 
2.1.3
