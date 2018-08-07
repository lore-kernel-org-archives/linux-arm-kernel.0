From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  7 Aug 2018 15:17:18 +0900
Subject: [v0.1 PATCH 3/7] dt-bindings: mmc: add DT binding for UniPhier
 SD/eMMC controller
In-Reply-To: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
References: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1533622642-13989-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This SD/eMMC controller is used for UniPhier SoC family.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 .../devicetree/bindings/mmc/uniphier-sd.txt        | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt

diff --git a/Documentation/devicetree/bindings/mmc/uniphier-sd.txt b/Documentation/devicetree/bindings/mmc/uniphier-sd.txt
new file mode 100644
index 0000000..49dd0fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/uniphier-sd.txt
@@ -0,0 +1,60 @@
+UniPhier SD/eMMC controller
+
+Required properties:
+- compatible: should be one of the following:
+    "socionext,uniphier-sd-v2.91" - IP version 2.91
+    "socionext,uniphier-sd-v3.1"  - IP version 3.1
+    "socionext,uniphier-sd-v3.1b" - IP version 3.1 (bug-fix ver.) [1]
+- reg: offset and length of the register set for the device.
+- interrupts: a single interrupt specifier.
+- clocks: a single clock specifier of the controller clock.
+- reset-names: should contain the following:
+    "host"   - mandatory for all versions
+    "bridge" - should exist only for "socionext,uniphier-sd-v2.91"
+    "hw"     - should exist if eMMC hw reset line is available
+- resets: a list of reset specifiers, corresponding to the reset-names
+
+[1] There are two different controller cores for version 3.1.  The early
+    release had a bug in the DMA RX channel.  The issue was fixed later,
+    but the version number was not incremented.  Hence, the latter has
+    'b' at the end of its compatible string.
+
+Optional properties:
+- pinctrl-names: if present, should contain the following:
+    "default" - should exist for all instances
+    "uhs"     - should exist for SD instance with UHS support
+- pinctrl-0: pin control state for the default mode
+- pinctrl-1: pin control state for the UHS mode
+- dma-names: should be "rx-tx" if present.
+  This property can exist only for "socionext,uniphier-sd-v2.91".
+- dmas: a single DMA channel specifier
+  This property can exist only for "socionext,uniphier-sd-v2.91".
+- bus-width: see mmc.txt
+- cap-sd-highspeed: see mmc.txt
+- cap-mmc-highspeed: see mmc.txt
+- sd-uhs-sdr12: see mmc.txt
+- sd-uhs-sdr25: see mmc.txt
+- sd-uhs-sdr50: see mmc.txt
+- cap-mmc-hw-reset: should exist if reset-names contains "hw". see mmc.txt
+- non-removable: see mmc.txt
+
+Example:
+
+	sd: sdhc at 5a400000 {
+		compatible = "socionext,uniphier-sd-v2.91";
+		reg = <0x5a400000 0x200>;
+		interrupts = <0 76 4>;
+		pinctrl-names = "default", "uhs";
+		pinctrl-0 = <&pinctrl_sd>;
+		pinctrl-1 = <&pinctrl_sd_uhs>;
+		clocks = <&mio_clk 0>;
+		reset-names = "host", "bridge";
+		resets = <&mio_rst 0>, <&mio_rst 3>;
+		dma-names = "rx-tx";
+		dmas = <&dmac 4>;
+		bus-width = <4>;
+		cap-sd-highspeed;
+		sd-uhs-sdr12;
+		sd-uhs-sdr25;
+		sd-uhs-sdr50;
+	};
-- 
2.7.4
