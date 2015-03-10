From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Mar 2015 16:22:33 +0100
Subject: [PATCH 1/2] dt-bindings: ARM: Mediatek: document binding for the PMIC
 wrapper
In-Reply-To: <1426000954-7647-1-git-send-email-s.hauer@pengutronix.de>
References: <1426000954-7647-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1426000954-7647-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation for the PMIC wrapper unit found on Mediatek
SoCs. Currently support are the MT8135 and MT8173 SoCs, but the PMIC
wrapper can also be found on MT6xxx and possibly other SoCs.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../devicetree/bindings/soc/mediatek/pwrap.txt     | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/pwrap.txt

diff --git a/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
new file mode 100644
index 0000000..ddeb5b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
@@ -0,0 +1,58 @@
+MediaTek PMIC Wrapper Driver
+
+This document describes the binding for the MediaTek PMIC wrapper.
+
+On MediaTek SoCs the PMIC is connected via SPI. The SPI master interface
+is not directly visible to the CPU, but only through the PMIC wrapper
+inside the SoC. The communication between the SoC and the PMIC can
+optionally be encrypted. Also a non standard Dual IO SPI mode can be
+used to increase speed.
+
+IP Pairing
+
+on MT8135 the pins of some SoC internal peripherals can be on the PMIC.
+The signals of these pins are routed over the SPI bus using the pwrap
+bridge. In the binding description below the properties needed for bridging
+are marked with "IP Pairing". These are optional on SoCs which do not support
+IP Pairing
+
+Required properties in pwrap device node.
+- compatible:
+	"mediatek,mt8135-pwrap" for MT8135 SoCs
+	"mediatek,mt8173-pwrap" for MT8173 SoCs
+- interrupts: IRQ for pwrap in SOC
+- reg-names: Must include the following entries:
+  "pwrap": Main registers base
+  "pwrap-bridge": bridge base (IP Pairing)
+- reg: Must contain an entry for each entry in reg-names.
+- reset-names: Must include the following entries:
+  "pwrap"
+  "pwrap-bridge" (IP Pairing)
+- resets: Must contain an entry for each entry in reset-names.
+- clock-names: Must include the following entries:
+  "spi": SPI bus clock
+  "wrap": Main module clock
+- clocks: Must contain an entry for each entry in clock-names.
+
+Optional properities:
+- pmic: Mediatek PMIC MFD is the child device of pwrap
+  See the following for child node definitions:
+  Documentation/devicetree/bindings/mfd/mt6397.txt
+
+Example:
+	pwrap: pwrap at 1000f000 {
+		compatible = "mediatek,mt8135-pwrap";
+		reg = <0 0x1000f000 0 0x1000>,
+			<0 0x11017000 0 0x1000>;
+		reg-names = "pwrap", "pwrap-bridge";
+		interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+		resets = <&infracfg MT8135_INFRA_PMIC_WRAP_RST>,
+				<&pericfg MT8135_PERI_PWRAP_BRIDGE_SW_RST>;
+		reset-names = "pwrap", "pwrap-bridge";
+		clocks = <&clk26m>, <&clk26m>;
+		clock-names = "spi", "wrap";
+
+		pmic {
+			compatible = "mediatek,mt6397";
+		};
+	};
-- 
2.1.4
