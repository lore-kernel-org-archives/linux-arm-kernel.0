From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Jun 2015 08:17:03 +0200
Subject: [PATCH 2/4] dt-bindings: soc: Add documentation for the MediaTek
 SCPSYS unit
In-Reply-To: <1435126625-9634-1-git-send-email-s.hauer@pengutronix.de>
References: <1435126625-9634-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1435126625-9634-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation for the MediaTek SCPSYS unit found in MT8173 SoCs.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../devicetree/bindings/soc/mediatek/scpsys.txt    | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt

diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
new file mode 100644
index 0000000..c051114
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -0,0 +1,41 @@
+MediaTek SCPSYS
+===============
+
+The System Control Processor System (SCPSYS) has several power management
+related tasks in the system. The tasks include thermal measurement, dynamic
+voltage frequency scaling (DVFS), interrupt filter and lowlevel sleep control.
+The System Power Manager (SPM) inside the SCPSYS is for the MTCMOS power
+domain control.
+
+The driver implements the Generic PM domain bindings described in
+power/power_domain.txt. It provides the power domains defined in
+include/dt-bindings/power/mt8173-power.h.
+
+Required properties:
+- compatible: Must be "mediatek,mt8173-scpsys"
+- #power-domain-cells: Must be 1
+- reg: Address range of the SCPSYS unit
+- infracfg: must contain a phandle to the infracfg controller
+- clock, clock-names: clocks according to the common clock binding.
+                      The clocks needed "mm" and "mfg". These are the
+		      clocks which hardware needs to be enabled before
+		      enabling certain power domains.
+
+Example:
+
+	scpsys: scpsys at 10006000 {
+		#power-domain-cells = <1>;
+		compatible = "mediatek,mt8173-scpsys";
+		reg = <0 0x10006000 0 0x1000>;
+		infracfg = <&infracfg>;
+		clocks = <&clk26m>,
+			 <&topckgen CLK_TOP_MM_SEL>;
+		clock-names = "mfg", "mm";
+	};
+
+Example consumer:
+
+	afe: mt8173-afe-pcm at 11220000 {
+		compatible = "mediatek,mt8173-afe-pcm";
+		power-domains = <&scpsys MT8173_POWER_DOMAIN_AUDIO>;
+	};
-- 
2.1.4
