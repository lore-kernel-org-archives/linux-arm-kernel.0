From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Tue, 18 Mar 2014 16:40:15 +0800
Subject: [PATCH 1/3] Documentation: add Device tree bindings for Hisilicon
 hip04 ethernet
In-Reply-To: <1395132017-15928-1-git-send-email-zhangfei.gao@linaro.org>
References: <1395132017-15928-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1395132017-15928-2-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the Device Tree bindings for the Hisilicon hip04
Ethernet controller, including 100M / 1000M controller.

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../bindings/net/hisilicon-hip04-net.txt           |   74 ++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/hisilicon-hip04-net.txt

diff --git a/Documentation/devicetree/bindings/net/hisilicon-hip04-net.txt b/Documentation/devicetree/bindings/net/hisilicon-hip04-net.txt
new file mode 100644
index 0000000..c918f08
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hisilicon-hip04-net.txt
@@ -0,0 +1,74 @@
+Hisilicon hip04 Ethernet Controller
+
+* Ethernet controller node
+
+Required properties:
+- compatible: should be "hisilicon,hip04-mac".
+- reg: address and length of the register set for the device.
+- interrupts: interrupt for the device.
+- port: ppe port number connected to the controller: range from 0 to 31.
+- speed: 100 (100M) or 1000 (1000M).
+- id: should be different and fe should be 0.
+
+Optional Properties:
+- phy-handle : the phandle to a PHY node
+
+
+* Ethernet ppe node: control rx & tx fifos of all ethernet controllers
+
+Required properties:
+- compatible: should be "hisilicon,hip04-ppebase".
+- reg: address and length of the register set for the node.
+
+
+* MDIO bus node:
+
+Required properties:
+
+- compatible: "hisilicon,hip04-mdio"
+- Inherets from MDIO bus node binding[1]
+[1] Documentation/devicetree/bindings/net/phy.txt
+
+Example:
+	mdio {
+		compatible = "hisilicon,hip04-mdio";
+		reg = <0x28f1000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy0: ethernet-phy at 0 {
+			reg = <0>;
+			marvell,reg-init = <18 0x14 0 0x8001>;
+			device_type = "ethernet-phy";
+		};
+
+		phy1: ethernet-phy at 1 {
+			reg = <1>;
+			marvell,reg-init = <18 0x14 0 0x8001>;
+			device_type = "ethernet-phy";
+		};
+	};
+
+	ppebase: ppebase at 28c0000 {
+		compatible = "hisilicon,hip04-ppebase";
+		reg = <0x28c0000 0x10000>;
+	};
+
+	fe: ethernet at 28b0000 {
+		compatible = "hisilicon,hip04-mac";
+		reg = <0x28b0000 0x10000>;
+		interrupts = <0 413 4>;
+		port = <31>;
+		speed = <100>;
+		id = <0>;
+	};
+
+	ge0: ethernet at 2800000 {
+		compatible = "hisilicon,hip04-mac";
+		reg = <0x2800000 0x10000>;
+		interrupts = <0 402 4>;
+		port = <0>;
+		speed = <1000>;
+		id = <1>;
+		phy-handle = <&phy0>;
+	};
-- 
1.7.9.5
