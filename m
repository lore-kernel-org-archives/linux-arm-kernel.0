From: flora.fu@mediatek.com (Flora Fu)
Date: Mon, 3 Nov 2014 17:02:50 +0800
Subject: [PATCH v2 2/3] dt-bindings: Add Reset Controller for MediaTek SoC
In-Reply-To: <1415005371-4323-1-git-send-email-flora.fu@mediatek.com>
References: <1415005371-4323-1-git-send-email-flora.fu@mediatek.com>
Message-ID: <1415005371-4323-3-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree bindings.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 .../devicetree/bindings/reset/mediatek,reset.txt   | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/mediatek,reset.txt

diff --git a/Documentation/devicetree/bindings/reset/mediatek,reset.txt b/Documentation/devicetree/bindings/reset/mediatek,reset.txt
new file mode 100644
index 0000000..3c5687b
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/mediatek,reset.txt
@@ -0,0 +1,45 @@
+MediaTek SoC Reset Controller
+======================================
+The reset controller driver accesses registers through the syscon regmap. It
+is a child node of syscon.
+
+Required properties:
+- compatible : "mediatek,reset"
+- #reset-cells: 1
+- reg: The register region can be accessed from syscon. The first parameter is
+  reset base address offset. The second parameter is byte width of reset registers.
+
+example:
+infracfg: syscon at 10001000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "mediatek,mt8135-infracfg", "syscon";
+	reg = <0 0x10001000 0 0x1000>;
+
+	infrarst: reset-controller at 30 {
+		#reset-cells = <1>;
+		compatible = "mediatek,mt8135-infracfg-reset", "mediatek,reset";
+		reg = <0x30 0x8>;
+	};
+};
+
+Specifying reset lines connected to IP modules
+==============================================
+
+The reset controller(mtk-reset) manages various reset sources. Those device nodes should
+specify the reset line on the rstc in their resets property, containing a phandle to the
+rstc device node and a RESET_INDEX specifying which module to reset, as described in
+reset.txt.
+
+For MediaTek SoC, RESET_INDEX is reset bit defined in INFRACFG or PERICFG registers.
+
+example:
+pwrap: pwrap at 1000f000 {
+	compatible = "mediatek,mt8135-pwrap";
+	reg = <0 0x1000f000 0 0x1000>,
+		<0 0x11017000 0 0x1000>;
+	reg-names = "pwrap-base",
+		"pwrap-bridge-base";
+	resets = <&infrarst 7>, <&perirst 34>;
+	reset-names = "infrarst", "perirst";
+};
-- 
1.8.1.1.dirty
