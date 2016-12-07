From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Wed,  7 Dec 2016 10:17:45 +0800
Subject: [PATCH] arm: dts: rockchip: add qos node for rk3288
Message-ID: <1481077065-11309-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

when pd power on/off, the qos regs need to save and restore.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 84 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 4fad13368a7b..2628edc871fa 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -699,6 +699,76 @@
 		reg = <0xff720000 0x1000>;
 	};
 
+	qos_gpu_r: qos at ffaa0000 {
+		compatible = "syscon";
+		reg = <0xffaa0000 0x20>;
+	};
+
+	qos_gpu_w: qos at ffaa0080 {
+		compatible = "syscon";
+		reg = <0xffaa0080 0x20>;
+	};
+
+	qos_vio1_vop: qos at ffad0000 {
+		compatible = "syscon";
+		reg = <0xffad0000 0x20>;
+	};
+
+	qos_vio1_isp_w0: qos at ffad0100 {
+		compatible = "syscon";
+		reg = <0xffad0100 0x20>;
+	};
+
+	qos_vio1_isp_w1: qos at ffad0180 {
+		compatible = "syscon";
+		reg = <0xffad0180 0x20>;
+	};
+
+	qos_vio0_vop: qos at ffad0400 {
+		compatible = "syscon";
+		reg = <0xffad0400 0x20>;
+	};
+
+	qos_vio0_vip: qos at ffad0480 {
+		compatible = "syscon";
+		reg = <0xffad0480 0x20>;
+	};
+
+	qos_vio0_iep: qos at ffad0500 {
+		compatible = "syscon";
+		reg = <0xffad0500 0x20>;
+	};
+
+	qos_vio2_rga_r: qos at ffad0800 {
+		compatible = "syscon";
+		reg = <0xffad0800 0x20>;
+	};
+
+	qos_vio2_rga_w: qos at ffad0880 {
+		compatible = "syscon";
+		reg = <0xffad0880 0x20>;
+	};
+
+	qos_vio1_isp_r: qos at ffad0900 {
+		compatible = "syscon";
+		reg = <0xffad0900 0x20>;
+	};
+
+	qos_video: qos at ffae0000 {
+		compatible = "syscon";
+		reg = <0xffae0000 0x20>;
+	};
+
+	qos_hevc_r: qos at ffaf0000 {
+		compatible = "syscon";
+		reg = <0xffaf0000 0x20>;
+	};
+
+	qos_hevc_w: qos at ffaf0080 {
+		compatible = "syscon";
+		reg = <0xffaf0080 0x20>;
+	};
+
 	pmu: power-management at ff730000 {
 		compatible = "rockchip,rk3288-pmu", "syscon", "simple-mfd";
 		reg = <0xff730000 0x100>;
@@ -762,6 +832,15 @@
 					 <&cru SCLK_ISP_JPE>,
 					 <&cru SCLK_ISP>,
 					 <&cru SCLK_RGA>;
+				pm_qos = <&qos_vio0_iep>,
+					 <&qos_vio1_vop>,
+					 <&qos_vio1_isp_w0>,
+					 <&qos_vio1_isp_w1>,
+					 <&qos_vio0_vop>,
+					 <&qos_vio0_vip>,
+					 <&qos_vio2_rga_r>,
+					 <&qos_vio2_rga_w>,
+					 <&qos_vio1_isp_r>;
 			};
 
 			/*
@@ -773,6 +852,8 @@
 				clocks = <&cru ACLK_HEVC>,
 					 <&cru SCLK_HEVC_CABAC>,
 					 <&cru SCLK_HEVC_CORE>;
+				pm_qos = <&qos_hevc_r>,
+					 <&qos_hevc_w>;
 			};
 
 			/*
@@ -784,6 +865,7 @@
 				reg = <RK3288_PD_VIDEO>;
 				clocks = <&cru ACLK_VCODEC>,
 					 <&cru HCLK_VCODEC>;
+				pm_qos = <&qos_video>;
 			};
 
 			/*
@@ -793,6 +875,8 @@
 			pd_gpu at RK3288_PD_GPU {
 				reg = <RK3288_PD_GPU>;
 				clocks = <&cru ACLK_GPU>;
+				pm_qos = <&qos_gpu_r>,
+					 <&qos_gpu_w>;
 			};
 		};
 
-- 
1.9.1
