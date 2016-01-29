From: ykk@rock-chips.com (Yakir Yang)
Date: Fri, 29 Jan 2016 14:49:44 +0800
Subject: [PATCH v8 2/2] dt-bindings: add document for Innosilicon HDMI on
 Rockchip platform
In-Reply-To: <1454049768-30872-1-git-send-email-ykk@rock-chips.com>
References: <1454049768-30872-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1454050184-31245-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yakir Yang <ykk@rock-chips.com>

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
- Add the Acked-by tags from Rob
- Correct the misspell "rk3036-dw-hdmi" (Heiko)

 .../display/rockchip/inno_hdmi-rockchip.txt        | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt

diff --git a/Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
new file mode 100644
index 0000000..8096a29
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
@@ -0,0 +1,50 @@
+Rockchip specific extensions to the Innosilicon HDMI
+================================
+
+Required properties:
+- compatible:
+	"rockchip,rk3036-inno-hdmi";
+- reg:
+	Physical base address and length of the controller's registers.
+- clocks, clock-names:
+	Phandle to hdmi controller clock, name should be "pclk"
+- interrupts:
+	HDMI interrupt number
+- ports:
+	Contain one port node with endpoint definitions as defined in
+	Documentation/devicetree/bindings/graph.txt.
+- pinctrl-0, pinctrl-name:
+	Switch the iomux of HPD/CEC pins to HDMI function.
+
+Example:
+hdmi: hdmi at 20034000 {
+	compatible = "rockchip,rk3036-inno-hdmi";
+	reg = <0x20034000 0x4000>;
+	interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&cru  PCLK_HDMI>;
+	clock-names = "pclk";
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_ctl>;
+	status = "disabled";
+
+	hdmi_in: port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		hdmi_in_lcdc: endpoint at 0 {
+			reg = <0>;
+			remote-endpoint = <&lcdc_out_hdmi>;
+		};
+	};
+};
+
+&pinctrl {
+	hdmi {
+		hdmi_ctl: hdmi-ctl {
+			rockchip,pins = <1 8  RK_FUNC_1 &pcfg_pull_none>,
+					<1 9  RK_FUNC_1 &pcfg_pull_none>,
+					<1 10 RK_FUNC_1 &pcfg_pull_none>,
+					<1 11 RK_FUNC_1 &pcfg_pull_none>;
+		};
+	};
+
+};
-- 
1.9.1
