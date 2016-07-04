From: wxt@rock-chips.com (Caesar Wang)
Date: Mon,  4 Jul 2016 20:34:04 +0800
Subject: [PATCH v3] arm64: dts: rockchip: add the power domain node for rk3399
Message-ID: <1467635644-16798-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Elaine Zhang <zhangqing@rock-chips.com>

In order to meet low power requirements, a power management unit (PMU) is
designed for controlling power resources in RK3399. The RK3399 PMU is
dedicated for managing the power of the whole chip.

1. add pd node for RK3399 Soc
2. create power domain tree
3. add qos node for domain

>From the DT/binds and driver can get more detail information:
The driver:
        drivers/soc/rockchip/pm_domains.c
The document:
        Documentation/devicetree/bindings/soc/rockchip/power_domain.txt

Note:
As the TRM lists many voltage domains and power domains, then this patch
adds some domains for driver. Due to some domains
(e.g. emmc, usb, core)...We can't turned off it on
bootup, or says some device driver can't handle the power domain enough.
Maybe We will add more other domains in the future or later.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>

---

Changes in v3:
- As some commnets on https://patchwork.kernel.org/patch/9209205/
- according to the alphabetically sort
- %s/RK3399_PD_VOP/RK3399_PD_VOPL, %s/RK3399_PD_IE/RK3399_PD_IEP

Changes in v2:
- As Doug/Heiko commnets on https://patchwork.kernel.org/patch/9206415/.
  drop the debugfs-dump and Add the comments for alphabetical order.

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 179 +++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index a6dd623..4559c04 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -45,6 +45,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/power/rk3399-power.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -594,6 +595,184 @@
 		status = "disabled";
 	};
 
+	qos_hdcp: qos_hdcp at ffa90000 {
+		compatible = "syscon";
+		reg = <0x0 0xffa90000 0x0 0x20>;
+	};
+
+	qos_iep: qos_iep at ffa98000 {
+		compatible = "syscon";
+		reg = <0x0 0xffa98000 0x0 0x20>;
+	};
+
+	qos_isp0_m0: qos_isp0_m0 at ffaa0000 {
+		compatible = "syscon";
+		reg = <0x0 0xffaa0000 0x0 0x20>;
+	};
+
+	qos_isp0_m1: qos_isp0_m1 at ffaa0080 {
+		compatible = "syscon";
+		reg = <0x0 0xffaa0080 0x0 0x20>;
+	};
+
+	qos_isp1_m0: qos_isp1_m0 at ffaa8000 {
+		compatible = "syscon";
+		reg = <0x0 0xffaa8000 0x0 0x20>;
+	};
+
+	qos_isp1_m1: qos_isp1_m1 at ffaa8080 {
+		compatible = "syscon";
+		reg = <0x0 0xffaa8080 0x0 0x20>;
+	};
+
+	qos_rga_r: qos_rga_r at ffab0000 {
+		compatible = "syscon";
+		reg = <0x0 0xffab0000 0x0 0x20>;
+	};
+
+	qos_rga_w: qos_rga_w at ffab0080 {
+		compatible = "syscon";
+		reg = <0x0 0xffab0080 0x0 0x20>;
+	};
+
+	qos_video_m0: qos_video_m0 at ffab8000 {
+		compatible = "syscon";
+		reg = <0x0 0xffab8000 0x0 0x20>;
+	};
+
+	qos_video_m1_r: qos_video_m1_r at ffac0000 {
+		compatible = "syscon";
+		reg = <0x0 0xffac0000 0x0 0x20>;
+	};
+
+	qos_video_m1_w: qos_video_m1_w at ffac0080 {
+		compatible = "syscon";
+		reg = <0x0 0xffac0080 0x0 0x20>;
+	};
+
+	qos_vop_big_r: qos_vop_big_r at ffac8000 {
+		compatible = "syscon";
+		reg = <0x0 0xffac8000 0x0 0x20>;
+	};
+
+	qos_vop_big_w: qos_vop_big_w at ffac8080 {
+		compatible = "syscon";
+		reg = <0x0 0xffac8080 0x0 0x20>;
+	};
+
+	qos_vop_little: qos_vop_little at ffad0000 {
+		compatible = "syscon";
+		reg = <0x0 0xffad0000 0x0 0x20>;
+	};
+
+	qos_gpu: qos_gpu at ffae0000 {
+		compatible = "syscon";
+		reg = <0x0 0xffae0000 0x0 0x20>;
+	};
+
+	pmu: power-management at ff310000 {
+		compatible = "rockchip,rk3399-pmu", "syscon", "simple-mfd";
+		reg = <0x0 0xff310000 0x0 0x1000>;
+
+		/*
+		 * Note: RK3399 supports 6 voltage domains including VD_CORE_L,
+		 * VD_CORE_B, VD_CENTER, VD_GPU, VD_LOGIC and VD_PMU.
+		 * Some of the power domains are grouped together for every
+		 * voltage domain.
+		 * The detail contents as below.
+		 */
+		power: power-controller {
+			status = "okay";
+			compatible = "rockchip,rk3399-power-controller";
+			#power-domain-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* These power domains are grouped by VD_CENTER */
+			pd_iep at RK3399_PD_IEP {
+				reg = <RK3399_PD_IEP>;
+				clocks = <&cru ACLK_IEP>,
+					 <&cru HCLK_IEP>;
+				pm_qos = <&qos_iep>;
+			};
+			pd_vcodec at RK3399_PD_VCODEC {
+				reg = <RK3399_PD_VCODEC>;
+				clocks = <&cru ACLK_VCODEC>,
+					 <&cru HCLK_VCODEC>;
+				pm_qos = <&qos_video_m0>;
+			};
+			pd_vdu at RK3399_PD_VDU {
+				reg = <RK3399_PD_VDU>;
+				clocks = <&cru ACLK_VDU>,
+					 <&cru HCLK_VDU>;
+				pm_qos = <&qos_video_m1_r>,
+					 <&qos_video_m1_w>;
+			};
+			pd_rga at RK3399_PD_RGA {
+				reg = <RK3399_PD_RGA>;
+				clocks = <&cru ACLK_RGA>,
+					 <&cru HCLK_RGA>;
+				pm_qos = <&qos_rga_r>,
+					 <&qos_rga_w>;
+			};
+
+			/* These power domains are grouped by VD_GPU */
+			pd_gpu at RK3399_PD_GPU {
+				reg = <RK3399_PD_GPU>;
+				clocks = <&cru ACLK_GPU>;
+				pm_qos = <&qos_gpu>;
+			};
+
+			/* These power domains are grouped by VD_LOGIC */
+			pd_vio at RK3399_PD_VIO {
+				reg = <RK3399_PD_VIO>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pd_hdcp at RK3399_PD_HDCP {
+					reg = <RK3399_PD_HDCP>;
+					clocks = <&cru ACLK_HDCP>,
+						 <&cru HCLK_HDCP>,
+						 <&cru PCLK_HDCP>;
+					pm_qos = <&qos_hdcp>;
+				};
+				pd_isp0 at RK3399_PD_ISP0 {
+					reg = <RK3399_PD_ISP0>;
+					clocks = <&cru ACLK_ISP0>,
+						 <&cru HCLK_ISP0>;
+					pm_qos = <&qos_isp0_m0>,
+						 <&qos_isp0_m1>;
+				};
+				pd_isp1 at RK3399_PD_ISP1 {
+					reg = <RK3399_PD_ISP1>;
+					clocks = <&cru ACLK_ISP1>,
+						 <&cru HCLK_ISP1>;
+					pm_qos = <&qos_isp1_m0>,
+						 <&qos_isp1_m1>;
+				};
+				pd_vo at RK3399_PD_VO {
+					reg = <RK3399_PD_VO>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					pd_vopb at RK3399_PD_VOPB {
+						reg = <RK3399_PD_VOPB>;
+						clocks = <&cru ACLK_VOP0>,
+							 <&cru HCLK_VOP0>;
+						pm_qos = <&qos_vop_big_r>,
+							 <&qos_vop_big_w>;
+					};
+					pd_vopl at RK3399_PD_VOPL {
+						reg = <RK3399_PD_VOPL>;
+						clocks = <&cru ACLK_VOP1>,
+							 <&cru HCLK_VOP1>;
+						pm_qos = <&qos_vop_little>;
+					};
+				};
+			};
+		};
+	};
+
 	pmugrf: syscon at ff320000 {
 		compatible = "rockchip,rk3399-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xff320000 0x0 0x1000>;
-- 
1.9.1
