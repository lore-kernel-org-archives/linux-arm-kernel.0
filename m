From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Jul 2018 10:33:05 +0100
Subject: Applied "dt-bindings: regulator: add DT bindings for UniPhier
 regulator" to the regulator tree
In-Reply-To: <1531186037-16630-2-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <E1fdBUf-00033y-UF@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   dt-bindings: regulator: add DT bindings for UniPhier regulator

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 64a7b80ba6ee80f64d36e59331d14b1d25cf7006 Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Wed, 11 Jul 2018 13:30:51 +0900
Subject: [PATCH] dt-bindings: regulator: add DT bindings for UniPhier
 regulator

Add DT bindings for regulators implemented in UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/regulator/uniphier-regulator.txt | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/uniphier-regulator.txt

diff --git a/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt b/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
new file mode 100644
index 000000000000..c9919f4b92d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/uniphier-regulator.txt
@@ -0,0 +1,57 @@
+Socionext UniPhier Regulator Controller
+
+This describes the devicetree bindings for regulator controller implemented
+on Socionext UniPhier SoCs.
+
+USB3 Controller
+---------------
+
+This regulator controls VBUS and belongs to USB3 glue layer. Before using
+the regulator, it is necessary to control the clocks and resets to enable
+this layer. These clocks and resets should be described in each property.
+
+Required properties:
+- compatible: Should be
+    "socionext,uniphier-pro4-usb3-regulator" - for Pro4 SoC
+    "socionext,uniphier-pxs2-usb3-regulator" - for PXs2 SoC
+    "socionext,uniphier-ld20-usb3-regulator" - for LD20 SoC
+    "socionext,uniphier-pxs3-usb3-regulator" - for PXs3 SoC
+- reg: Specifies offset and length of the register set for the device.
+- clocks: A list of phandles to the clock gate for USB3 glue layer.
+	According to the clock-names, appropriate clocks are required.
+- clock-names: Should contain
+    "gio", "link" - for Pro4 SoC
+    "link"        - for others
+- resets: A list of phandles to the reset control for USB3 glue layer.
+	According to the reset-names, appropriate resets are required.
+- reset-names: Should contain
+    "gio", "link" - for Pro4 SoC
+    "link"        - for others
+
+See Documentation/devicetree/bindings/regulator/regulator.txt
+for more details about the regulator properties.
+
+Example:
+
+	usb-glue at 65b00000 {
+		compatible = "socionext,uniphier-ld20-dwc3-glue",
+			     "simple-mfd";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x65b00000 0x400>;
+
+		usb_vbus0: regulators at 100 {
+			compatible = "socionext,uniphier-ld20-usb3-regulator";
+			reg = <0x100 0x10>;
+			clock-names = "link";
+			clocks = <&sys_clk 14>;
+			reset-names = "link";
+			resets = <&sys_rst 14>;
+		};
+
+		phy {
+			...
+			phy-supply = <&usb_vbus0>;
+		};
+		...
+	};
-- 
2.18.0.rc2
