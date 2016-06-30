From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 30 Jun 2016 23:58:45 +0800
Subject: [PATCH v4 1/7] mfd: ac100: Add device tree bindings for X-Powers
 AC100 codec/RTC combo IC
In-Reply-To: <1467302331-9663-1-git-send-email-wens@csie.org>
References: <1467302331-9663-1-git-send-email-wens@csie.org>
Message-ID: <1467302331-9663-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v3:

  - Fixed device node names and added labels.
  - Added clock output from codec and input to rtc.

Changes since v2:

  - Fix interrupt line for ac100_codec in provided example.

---
 Documentation/devicetree/bindings/mfd/ac100.txt | 49 +++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt

diff --git a/Documentation/devicetree/bindings/mfd/ac100.txt b/Documentation/devicetree/bindings/mfd/ac100.txt
new file mode 100644
index 000000000000..31e6f9cc41bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ac100.txt
@@ -0,0 +1,49 @@
+X-Powers AC100 Codec/RTC IC device tree bindings
+
+AC100 is a audio codec and RTC subsystem combo IC. The 2 parts are
+separated, including power supplies and interrupt lines, but share
+a common register address space and host interface.
+
+Required properties:
+- compatible: "x-powers,ac100"
+- reg: The I2C slave address or RSB hardware address for the chip
+- sub-nodes:
+  - codec
+    - compatible: "x-powers,ac100-codec"
+    - interrupt-parent: The parent interrupt controller
+    - interrupts: SoC NMI / GPIO interrupt connected to the IRQ_AUDIO pin
+    - #clock-cells: shall be 0
+    - clock-output-names: "4M_adda"
+    - see clock/clock-bindings.txt for common clock bindings
+  - rtc
+    - compatible: "x-powers,ac100-rtc"
+    - interrupt-parent: The parent interrupt controller
+    - interrupts: SoC NMI / GPIO interrupt connected to the IRQ_RTC pin
+    - clocks: A phandle to the codec's "4M_adda" clock
+    - #clock-cells: shall be 1
+    - clock-output-names: "cko1_rtc", "cko2_rtc", "cko3_rtc"
+    - see clock/clock-bindings.txt for common clock bindings
+
+Example:
+
+ac100: codec at e89 {
+	compatible = "x-powers,ac100";
+	reg = <0xe89>;
+
+	ac100_codec: codec {
+		compatible = "x-powers,ac100-codec";
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 9 IRQ_TYPE_LEVEL_LOW>; /* PL9 */
+		#clock-cells = <0>;
+		clock-output-names = "4M_adda";
+	};
+
+	ac100_rtc: rtc {
+		compatible = "x-powers,ac100-rtc";
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&ac100_codec>;
+		#clock-cells = <1>;
+		clock-output-names = "cko1_rtc", "cko2_rtc", "cko3_rtc";
+	};
+};
-- 
2.8.1
