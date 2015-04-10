From: fathi.boudra@linaro.org (Fathi Boudra)
Date: Fri, 10 Apr 2015 10:16:19 +0300
Subject: [PATCH 1/2] ARM: dts: add HiSilicon hip04 ethernet controller resource
In-Reply-To: <1428650180-9746-1-git-send-email-fathi.boudra@linaro.org>
References: <1428650180-9746-1-git-send-email-fathi.boudra@linaro.org>
Message-ID: <1428650180-9746-2-git-send-email-fathi.boudra@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add the device tree binding for the HiSilicon hip04 ethernet controller
based on Documentation/devicetree/bindings/net/hisilicon-hip04-net.txt

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
---
 arch/arm/boot/dts/hip04.dtsi | 49 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
index 2388145..fc68753 100644
--- a/arch/arm/boot/dts/hip04.dtsi
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -269,6 +269,55 @@
 			interrupts = <0 372 4>;
 		};
 
+		mdio {
+			compatible = "hisilicon,hip04-mdio";
+			reg = <0x28f1000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			phy0: ethernet-phy at 0 {
+				compatible = "ethernet-phy-ieee802.3-c22";
+				reg = <0>;
+				marvell,reg-init = <18 0x14 0 0x8001>;
+			};
+
+			phy1: ethernet-phy at 1 {
+				compatible = "ethernet-phy-ieee802.3-c22";
+				reg = <1>;
+				marvell,reg-init = <18 0x14 0 0x8001>;
+			};
+		};
+
+		ppe: ppe at 28c0000 {
+			compatible = "hisilicon,hip04-ppe", "syscon";
+			reg = <0x28c0000 0x10000>;
+		};
+
+		fe: ethernet at 28b0000 {
+			compatible = "hisilicon,hip04-mac";
+			reg = <0x28b0000 0x10000>;
+			interrupts = <0 413 4>;
+			phy-mode = "mii";
+			port-handle = <&ppe 31 0>;
+		};
+
+		ge0: ethernet at 2800000 {
+			compatible = "hisilicon,hip04-mac";
+			reg = <0x2800000 0x10000>;
+			interrupts = <0 402 4>;
+			phy-mode = "sgmii";
+			port-handle = <&ppe 0 1>;
+			phy-handle = <&phy0>;
+		};
+
+		ge8: ethernet at 2880000 {
+			compatible = "hisilicon,hip04-mac";
+			reg = <0x2880000 0x10000>;
+			interrupts = <0 410 4>;
+			phy-mode = "sgmii";
+			port-handle = <&ppe 8 2>;
+			phy-handle = <&phy1>;
+		};
 	};
 
 	etb at 0,e3c42000 {
-- 
2.1.4
