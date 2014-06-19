From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 19 Jun 2014 20:20:38 +0200
Subject: [PATCH v3 12/14] clk: max77802: Add DT binding documentation
In-Reply-To: <1403202040-12641-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1403202040-12641-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1403202040-12641-13-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Device Tree binding documentation for the clocks
outputs in the Maxim 77802 Power Management IC.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v2:
 - Split the DT binding documentation in a separate patch.

 .../devicetree/bindings/clock/maxim,max77802.txt   | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/maxim,max77802.txt

diff --git a/Documentation/devicetree/bindings/clock/maxim,max77802.txt b/Documentation/devicetree/bindings/clock/maxim,max77802.txt
new file mode 100644
index 0000000..b2c2129
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/maxim,max77802.txt
@@ -0,0 +1,42 @@
+Binding for Maxim MAX77802 32k clock generator block
+
+This is a part of device tree bindings of MAX77802 multi-function device.
+More information can be found in bindings/mfd/max77802.txt file.
+
+The MAX77802 contains two 32.768khz clock outputs that can be controlled
+(gated/ungated) over I2C.
+
+Following properties should be presend in main device node of the MFD chip.
+
+Required properties:
+
+- #clock-cells: from common clock binding; shall be set to 1.
+
+Each clock is assigned an identifier and client nodes can use this identifier
+to specify the clock which they consume. Following indices are allowed:
+     - 0: 32khz_ap clock,
+     - 1: 32khz_cp clock.
+
+Clocks are defined as preprocessor macros in dt-bindings/clock/maxim,max77802.h
+header and can be used in device tree sources.
+
+Example: Node of the MFD chip
+
+	max77802: max77802 at 09 {
+		compatible = "maxim,max77802";
+		interrupt-parent = <&wakeup_eint>;
+		interrupts = <26 0>;
+		reg = <0x09>;
+		#clock-cells = <1>;
+
+		/* ... */
+	};
+
+Example: Clock consumer node
+
+	foo at 0 {
+		compatible = "bar,foo";
+		/* ... */
+		clock-names = "32khz_ap";
+		clocks = <&max77802 MAX77802_CLK_32K_AP>;
+	};
-- 
2.0.0.rc2
