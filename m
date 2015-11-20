From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:28:37 +0200
Subject: [PATCH 02/10] dt-bindings: nxp: add description of wakeup controller
 on LPC32xx
In-Reply-To: <1447982925-30138-1-git-send-email-vz@mleia.com>
References: <1447982925-30138-1-git-send-email-vz@mleia.com>
Message-ID: <1447982925-30138-3-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP LPC32xx has three wakeup controllers of two types, this
descriptions defines DT bindings of wakeup controllers connected to
MIC, SIC1 and SIC2 interrupt controllers.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 .../bindings/arm/nxp/nxp,lpc3220-wakeup.txt        | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/nxp/nxp,lpc3220-wakeup.txt

diff --git a/Documentation/devicetree/bindings/arm/nxp/nxp,lpc3220-wakeup.txt b/Documentation/devicetree/bindings/arm/nxp/nxp,lpc3220-wakeup.txt
new file mode 100644
index 0000000..803728f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/nxp/nxp,lpc3220-wakeup.txt
@@ -0,0 +1,41 @@
+NXP LPC32xx Wakeup Controller
+
+Required properties:
+- compatible: should be "nxp,lpc3220-wakeup"
+- reg:  should contain wakeup controller registers location and length
+- #wakeup-cells: must be 2, the first cell describes wakeup source on
+  the controller, the second cell is a hardware interrupt number on IC.
+
+Examples:
+
+	/* System Control Block */
+	scb {
+		compatible = "simple-bus";
+		ranges = <0x0 0x040004000 0x00001000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		wakeup_int: wakeup-controller at 20 {
+			compatible = "nxp,lpc3220-wakeup";
+			reg = <0x20 0x10>;
+			#wakeup-cells = <2>;
+		};
+
+		wakeup_pin: wakeup-controller at 30 {
+			compatible = "nxp,lpc3220-wakeup";
+			reg = <0x30 0x10>;
+			#wakeup-cells = <2>;
+		};
+	};
+
+	/* Main Interrupt Controller */
+	mic: interrupt-controller at 40008000 {
+		compatible = "nxp,lpc3220-mic";
+		reg = <0x40008000 0x4000>;
+		interrupt-controller;
+		interrupt-controller-name = "mic";
+		#interrupt-cells = <2>;
+
+		wakeup-sources = <&wakeup_int 7 29>,
+				 <&wakeup_int 25 27>;
+	};
-- 
2.1.4
