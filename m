From: isubramanian@apm.com (Iyappan Subramanian)
Date: Wed,  8 Oct 2014 20:54:18 -0700
Subject: [PATCH v3 3/6] dtb: Add 10GbE node to APM X-Gene SoC device tree
In-Reply-To: <1412826861-32208-1-git-send-email-isubramanian@apm.com>
References: <1412826861-32208-1-git-send-email-isubramanian@apm.com>
Message-ID: <1412826861-32208-4-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added 10GbE interface and clock nodes.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
---
 arch/arm64/boot/dts/apm-mustang.dts |  4 ++++
 arch/arm64/boot/dts/apm-storm.dtsi  | 28 +++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/apm-mustang.dts b/arch/arm64/boot/dts/apm-mustang.dts
index b2f5622..2ae782b 100644
--- a/arch/arm64/boot/dts/apm-mustang.dts
+++ b/arch/arm64/boot/dts/apm-mustang.dts
@@ -32,3 +32,7 @@
 &menet {
 	status = "ok";
 };
+
+&xgenet {
+	status = "ok";
+};
diff --git a/arch/arm64/boot/dts/apm-storm.dtsi b/arch/arm64/boot/dts/apm-storm.dtsi
index c0aceef..0a4dbf8 100644
--- a/arch/arm64/boot/dts/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm-storm.dtsi
@@ -176,6 +176,16 @@
 				clock-output-names = "menetclk";
 			};
 
+			xge0clk: xge0clk at 1f61c000 {
+				compatible = "apm,xgene-device-clock";
+				#clock-cells = <1>;
+				clocks = <&socplldiv2 0>;
+				reg = <0x0 0x1f61c000 0x0 0x1000>;
+				reg-names = "csr-reg";
+				csr-mask = <0x3>;
+				clock-output-names = "xge0clk";
+			};
+
 			sataphy1clk: sataphy1clk at 1f21c000 {
 				compatible = "apm,xgene-device-clock";
 				#clock-cells = <1>;
@@ -407,7 +417,8 @@
 			interrupts = <0x0 0x3c 0x4>;
 			dma-coherent;
 			clocks = <&menetclk 0>;
-			local-mac-address = [00 01 73 00 00 01];
+			/* mac address will be overwritten by the bootloader */
+			local-mac-address = [00 00 00 00 00 00];
 			phy-connection-type = "rgmii";
 			phy-handle = <&menetphy>;
 			mdio {
@@ -421,5 +432,20 @@
 
 			};
 		};
+
+		xgenet: ethernet at 1f610000 {
+			compatible = "apm,xgene-enet";
+			status = "disabled";
+			reg = <0x0 0x1f610000 0x0 0xd100>,
+			      <0x0 0x1f600000 0x0 0X400>,
+			      <0x0 0x18000000 0x0 0X200>;
+			reg-names = "enet_csr", "ring_csr", "ring_cmd";
+			interrupts = <0x0 0x60 0x4>;
+			dma-coherent;
+			clocks = <&xge0clk 0>;
+			/* mac address will be overwritten by the bootloader */
+			local-mac-address = [00 00 00 00 00 00];
+			phy-connection-type = "xgmii";
+		};
 	};
 };
-- 
1.9.1
