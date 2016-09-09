From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri,  9 Sep 2016 15:40:33 +0800
Subject: [PATCH 3/6] arm64: dts: rockchip: add pd_perihp power node for rk3399
In-Reply-To: <1473406836-6720-1-git-send-email-zhangqing@rock-chips.com>
References: <1473406836-6720-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1473406836-6720-4-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1.add pd node for RK3399 Soc
2.create power domain tree
3.add qos node for domain,include usb2,pcie
4.add the pd_perihp consumers node

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 869b52d60b73..52eeb007fddf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -303,6 +303,7 @@
 		resets = <&cru SRST_PCIE_CORE>, <&cru SRST_PCIE_MGMT>,
 			 <&cru SRST_PCIE_MGMT_STICKY>, <&cru SRST_PCIE_PIPE>;
 		reset-names = "core", "mgmt", "mgmt-sticky", "pipe";
+		power-domains = <&power RK3399_PD_PERIHP>;
 		status = "disabled";
 
 		pcie0_intc: interrupt-controller {
@@ -320,6 +321,7 @@
 		clock-names = "hclk_host0", "hclk_host0_arb";
 		phys = <&u2phy0_host>;
 		phy-names = "usb";
+		power-domains = <&power RK3399_PD_PERIHP>;
 		status = "disabled";
 	};
 
@@ -329,6 +331,7 @@
 		interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru HCLK_HOST0>, <&cru HCLK_HOST0_ARB>;
 		clock-names = "hclk_host0", "hclk_host0_arb";
+		power-domains = <&power RK3399_PD_PERIHP>;
 		status = "disabled";
 	};
 
@@ -340,6 +343,7 @@
 		clock-names = "hclk_host1", "hclk_host1_arb";
 		phys = <&u2phy1_host>;
 		phy-names = "usb";
+		power-domains = <&power RK3399_PD_PERIHP>;
 		status = "disabled";
 	};
 
@@ -349,6 +353,7 @@
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru HCLK_HOST1>, <&cru HCLK_HOST1_ARB>;
 		clock-names = "hclk_host1", "hclk_host1_arb";
+		power-domains = <&power RK3399_PD_PERIHP>;
 		status = "disabled";
 	};
 
@@ -699,6 +704,20 @@
 		compatible = "syscon";
 		reg = <0x0 0xffa5c000 0x0 0x20>;
 	};
+	qos_pcie: qos at ffa60080 {
+		compatible = "syscon";
+		reg = <0x0 0xffa60080 0x0 0x20>;
+	};
+
+	qos_usb_host0: qos at ffa60100 {
+		compatible = "syscon";
+		reg = <0x0 0xffa60100 0x0 0x20>;
+	};
+
+	qos_usb_host1: qos at ffa60180 {
+		compatible = "syscon";
+		reg = <0x0 0xffa60180 0x0 0x20>;
+	};
 
 	qos_hdcp: qos at ffa90000 {
 		compatible = "syscon";
@@ -770,6 +789,11 @@
 		reg = <0x0 0xffad0000 0x0 0x20>;
 	};
 
+	qos_perihp: qos at ffad8080 {
+		compatible = "syscon";
+		reg = <0x0 0xffad8080 0x0 0x20>;
+	};
+
 	qos_gpu: qos at ffae0000 {
 		compatible = "syscon";
 		reg = <0x0 0xffae0000 0x0 0x20>;
@@ -842,6 +866,16 @@
 				clocks = <&cru ACLK_GMAC>;
 				pm_qos = <&qos_gmac>;
 			};
+			pd_perihp at RK3399_PD_PERIHP {
+				reg = <RK3399_PD_PERIHP>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&cru ACLK_PERIHP>;
+				pm_qos = <&qos_perihp>,
+					 <&qos_pcie>,
+					 <&qos_usb_host0>,
+					 <&qos_usb_host1>;
+			};
 			pd_vio at RK3399_PD_VIO {
 				reg = <RK3399_PD_VIO>;
 				#address-cells = <1>;
-- 
1.9.1
