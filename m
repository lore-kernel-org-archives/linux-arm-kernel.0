From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Sat, 23 Apr 2016 17:05:17 +0800
Subject: [PATCH v2 net-next 13/13] dts: hisi: update hns dst for separating
 dsaf dev support
In-Reply-To: <1461402317-136499-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1461402317-136499-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1461402317-136499-14-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because debug dsaf port was separated from service dsaf port, this patch
updates the related configurations of hns dts, changes it to match with
the new binding files. This also removes enet nodes which don't exist in
d02 board.

Signed-off-by: Yisen Zhuang <yisen.zhuang@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi | 72 ++++++++++++----------------
 1 file changed, 30 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi b/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
index 933cba3..058cb78 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi
@@ -28,13 +28,13 @@ soc0: soc at 000000000 {
 		mode = "6port-16rss";
 		interrupt-parent = <&mbigen_dsa>;
 
-		reg = <0x0 0xC0000000 0x0 0x420000
-		       0x0 0xC2000000 0x0 0x300000
-		       0x0 0xc5000000 0x0 0x890000
+		reg = <0x0 0xc5000000 0x0 0x890000
 		       0x0 0xc7000000 0x0 0x60000
 		       >;
 
-		phy-handle = <0 0 0 0 &soc0_phy0 &soc0_phy1 0 0>;
+		reg-names = "ppe-base","dsaf-base";
+		subctrl-syscon = <&dsaf_subctrl>;
+		reset-field-offset = <0>;
 		interrupts = <
 			/* [14] ge fifo err 8 / xge 6**/
 			149 0x4 150 0x4 151 0x4 152 0x4
@@ -122,12 +122,31 @@ soc0: soc@000000000 {
 		buf-size = <4096>;
 		desc-num = <1024>;
 		dma-coherent;
+
+		port at 0 {
+			port-id = <0>;
+			serdes-syscon = <&serdes_ctrl0>;
+		};
+		port at 1 {
+			port-id = <1>;
+			serdes-syscon = <&serdes_ctrl0>;
+		};
+		port at 4 {
+			port-id = <4>;
+			phy-handle = <&soc0_phy0>;
+			serdes-syscon = <&serdes_ctrl1>;
+		};
+		port at 5 {
+			port-id = <5>;
+			phy-handle = <&soc0_phy1>;
+			serdes-syscon = <&serdes_ctrl1>;
+		};
 	};
 
 	eth0: ethernet at 0{
 		compatible = "hisilicon,hns-nic-v1";
 		ae-handle = <&dsaf0>;
-		port-id = <0>;
+		port-idx-in-ae = <0>;
 		local-mac-address = [00 00 00 01 00 58];
 		status = "disabled";
 		dma-coherent;
@@ -135,56 +154,25 @@ soc0: soc at 000000000 {
 	eth1: ethernet at 1{
 		compatible = "hisilicon,hns-nic-v1";
 		ae-handle = <&dsaf0>;
-		port-id = <1>;
+		port-idx-in-ae = <1>;
+		local-mac-address = [00 00 00 01 00 59];
 		status = "disabled";
 		dma-coherent;
 	};
-	eth2: ethernet at 2{
+	eth2: ethernet at 4{
 		compatible = "hisilicon,hns-nic-v1";
 		ae-handle = <&dsaf0>;
-		port-id = <2>;
+		port-idx-in-ae = <4>;
 		local-mac-address = [00 00 00 01 00 5a];
 		status = "disabled";
 		dma-coherent;
 	};
-	eth3: ethernet at 3{
+	eth3: ethernet at 5{
 		compatible = "hisilicon,hns-nic-v1";
 		ae-handle = <&dsaf0>;
-		port-id = <3>;
+		port-idx-in-ae = <5>;
 		local-mac-address = [00 00 00 01 00 5b];
 		status = "disabled";
 		dma-coherent;
 	};
-	eth4: ethernet at 4{
-		compatible = "hisilicon,hns-nic-v1";
-		ae-handle = <&dsaf0>;
-		port-id = <4>;
-		local-mac-address = [00 00 00 01 00 5c];
-		status = "disabled";
-		dma-coherent;
-	};
-	eth5: ethernet at 5{
-		compatible = "hisilicon,hns-nic-v1";
-		ae-handle = <&dsaf0>;
-		port-id = <5>;
-		local-mac-address = [00 00 00 01 00 5d];
-		status = "disabled";
-		dma-coherent;
-	};
-	eth6: ethernet at 6{
-		compatible = "hisilicon,hns-nic-v1";
-		ae-handle = <&dsaf0>;
-		port-id = <6>;
-		local-mac-address = [00 00 00 01 00 5e];
-		status = "disabled";
-		dma-coherent;
-	};
-	eth7: ethernet at 7{
-		compatible = "hisilicon,hns-nic-v1";
-		ae-handle = <&dsaf0>;
-		port-id = <7>;
-		local-mac-address = [00 00 00 01 00 5f];
-		status = "disabled";
-		dma-coherent;
-	};
 };
-- 
1.9.1
