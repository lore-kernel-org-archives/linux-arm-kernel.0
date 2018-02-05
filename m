From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  5 Feb 2018 15:34:27 +0100
Subject: [PATCH 1/9] dt-bindings: add binding for Rockchip hdmi phy using an
 Innosilicon IP
In-Reply-To: <20180205143435.4723-1-heiko@sntech.de>
References: <20180205143435.4723-1-heiko@sntech.de>
Message-ID: <20180205143435.4723-2-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zheng Yang <zhengyang@rock-chips.com>

The phy is used so far in two Rockchip socs the rk3228 and the rk3328.

Signed-off-by: Zheng Yang <zhengyang@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/phy/phy-rockchip-inno-hdmi.txt        | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno-hdmi.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-hdmi.txt b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-hdmi.txt
new file mode 100644
index 000000000000..7d36fd8d5d94
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-inno-hdmi.txt
@@ -0,0 +1,42 @@
+ROCKCHIP HDMI PHY WITH INNO IP BLOCK
+
+Required properties:
+ - compatible : should be one of the listed compatibles:
+	* "rockchip,rk3228-hdmi-phy",
+	* "rockchip,rk3328-hdmi-phy";
+ - reg : Address and length of the hdmi phy control register set
+ - clocks : phandle + clock specifier for the phy clocks
+ - clock-names : string, clock name, must contain "sysclk" for system
+	  control and register configuration and "refclk" for reference
+	  crystal oscillator clock input to PLL
+ - #clock-cells: should be 0.
+ - clock-output-names : shall be the name for the output clock.
+ - interrupts : phandle + interrupt specified for the hdmiphy interrupt
+ - #phy-cells : must be 0. See ./phy-bindings.txt for details.
+
+Optional properties for rk3328-hdmi-phy:
+ - nvmem-cells = phandle + nvmem specifier for the cpu-version efuse
+ - nvmem-cell-names : "cpu-version" to read the chip version, required
+	  for adjustment to some frequency settings
+
+Example:
+	hdmi_phy: hdmi-phy at 12030000 {
+		compatible = "rockchip,rk3228-hdmi-phy";
+		reg = <0x12030000 0x10000>;
+		#phy-cells = <0>;
+		clocks = <&cru PCLK_HDMI_PHY>, <&xin24m>;
+		clock-names = "sysclk", "refclk";
+		#clock-cells = <0>;
+		clock-output-names = "hdmi_phy";
+		status = "disabled";
+	};
+
+Then the PHY can be used in other nodes such as:
+
+	hdmi: hdmi at 200a0000 {
+		compatible = "rockchip,rk3228-dw-hdmi";
+		...
+		phys = <&hdmi_phy>;
+		phy-names = "hdmi";
+		...
+	};
-- 
2.15.1
