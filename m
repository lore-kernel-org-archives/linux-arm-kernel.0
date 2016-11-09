From: wxt@rock-chips.com (Caesar Wang)
Date: Wed,  9 Nov 2016 21:22:01 +0800
Subject: [PATCH v2 9/9] arm64: dts: rockchip: add the usb3 pd for rk3399
In-Reply-To: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
References: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1478697721-2323-10-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. add pd node for RK3399 Soc
2. create power domain tree
3. add qos node for domain
4. add the pd support for usb3

Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v2:
- Reviewed-on: https://chromium-review.googlesource.com/384280

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 3659c56..7480fa7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -376,6 +376,7 @@
 			snps,dis_u2_susphy_quirk;
 			snps,dis-del-phy-power-chg-quirk;
 			snps,xhci-slow-suspend-quirk;
+			power-domains = <&power RK3399_PD_USB3>;
 			status = "disabled";
 		};
 	};
@@ -403,6 +404,7 @@
 			snps,dis_u2_susphy_quirk;
 			snps,dis-del-phy-power-chg-quirk;
 			snps,xhci-slow-suspend-quirk;
+			power-domains = <&power RK3399_PD_USB3>;
 			status = "disabled";
 		};
 	};
@@ -746,6 +748,16 @@
 		status = "disabled";
 	};
 
+	qos_usb_otg0: qos at ffa70000 {
+		compatible = "syscon";
+		reg = <0x0 0xffa70000 0x0 0x20>;
+	};
+
+	qos_usb_otg1: qos at ffa70080 {
+		compatible = "syscon";
+		reg = <0x0 0xffa70080 0x0 0x20>;
+	};
+
 	qos_sd: qos at ffa74000 {
 		compatible = "syscon";
 		reg = <0x0 0xffa74000 0x0 0x20>;
@@ -909,6 +921,12 @@
 					 <&cru SCLK_SDMMC>;
 				pm_qos = <&qos_sd>;
 			};
+			pd_usb3 at RK3399_PD_USB3 {
+				reg = <RK3399_PD_USB3>;
+				clocks = <&cru ACLK_USB3>;
+				pm_qos = <&qos_usb_otg0>,
+					 <&qos_usb_otg1>;
+			};
 			pd_vio at RK3399_PD_VIO {
 				reg = <RK3399_PD_VIO>;
 				#address-cells = <1>;
-- 
2.7.4
