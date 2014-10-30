From: flora.fu@mediatek.com (flora.fu at mediatek.com)
Date: Thu, 30 Oct 2014 11:12:12 +0800
Subject: [PATCH 2/3] dt-bindings: Add Reset Controller for MediaTek SoC
In-Reply-To: <1414638733-10080-1-git-send-email-flora.fu@mediatek.com>
References: <1414638733-10080-1-git-send-email-flora.fu@mediatek.com>
Message-ID: <1414638733-10080-3-git-send-email-flora.fu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Flora Fu <flora.fu@mediatek.com>

Add device tree bindings.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
---
 .../devicetree/bindings/reset/mediatek,reset.txt   | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/mediatek,reset.txt

diff --git a/Documentation/devicetree/bindings/reset/mediatek,reset.txt b/Documentation/devicetree/bindings/reset/mediatek,reset.txt
new file mode 100644
index 0000000..0dd23e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/mediatek,reset.txt
@@ -0,0 +1,37 @@
+MediaTek SoC Reset Controller
+======================================
+
+Required properties:
+- compatible : "mediatek,reset"
+- #reset-cells: 1
+- mediatek,syscon-reset: The first parameter is refer to the syscon registers base. 
+  Follows are reset base address offset and byte width.
+
+example:
+	infrarst: reset-controller at 10001030 {
+		#reset-cells = <1>;
+		compatible = "mediatek,mt8135-infracfg-reset", "mediatek,reset";
+		mediatek,syscon-reset = <&infracfg 0x30 0x8>;
+	};
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
+	};
+};
\ No newline at end of file
-- 
1.8.1.1.dirty
