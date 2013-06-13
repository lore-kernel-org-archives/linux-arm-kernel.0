From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 12 Jun 2013 18:49:08 -0700
Subject: [RFC/PATCH 12/13] ARM: dts: msm: Add MSM8960 MMCC DT nodes
In-Reply-To: <1371088149-22562-1-git-send-email-sboyd@codeaurora.org>
References: <1371088149-22562-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1371088149-22562-13-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary DT data to probe the multimedia clock controller
on MSM8960 devices.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/msm8960-cdp.dts | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/msm8960-cdp.dts b/arch/arm/boot/dts/msm8960-cdp.dts
index 01d03f1..1c0691c 100644
--- a/arch/arm/boot/dts/msm8960-cdp.dts
+++ b/arch/arm/boot/dts/msm8960-cdp.dts
@@ -114,6 +114,43 @@
 		};
 	};
 
+	clock-controller at 4000000 {
+		compatible = "qcom,mmcc-8960", "qcom,mmcc";
+		reg = <0x4000000 0x1000>;
+
+		clocks {
+			pll2: pll2 {
+				#clock-cells = <0>;
+				compatible = "qcom,pll";
+				clocks = <&pxo>;
+			};
+
+			mdp_rcg: mdp_rcg {
+				#clock-cells = <0>;
+				compatible = "qcom,mn8-dyn-clock";
+				clocks = <&pxo>, <&pll2>, <&vpll8>;
+			};
+
+			mdp_cxc: mdp_cxc {
+				#clock-cells = <0>;
+				compatible = "qcom,cxc-clock";
+				clocks = <&mdp_rcg>;
+			};
+
+			rot_rcg: rot_rcg {
+				#clock-cells = <0>;
+				compatible = "qcom,p4-dyn-clock";
+				clocks = <&pxo>, <&pll2>, <&vpll8>;
+			};
+
+			rot_cxc: rot_cxc {
+				#clock-cells = <0>;
+				compatible = "qcom,cxc-clock";
+				clocks = <&rot_rcg>;
+			};
+		};
+	};
+
 	kpss at 2088000 {
 		compatible = "qcom,kpss";
 		reg = <0x02088000 0x1000
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
