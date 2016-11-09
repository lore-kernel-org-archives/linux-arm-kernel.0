From: wxt@rock-chips.com (Caesar Wang)
Date: Wed,  9 Nov 2016 21:21:53 +0800
Subject: [PATCH v2 1/9] arm64: dts: rockchip: add eMMC's power domain support
 for rk3399
In-Reply-To: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
References: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1478697721-2323-2-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ziyuan Xu <xzy.xu@rock-chips.com>

Control power domain for eMMC via genpd to reduce power consumption.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2:
- Reviewed-on: https://chromium-review.googlesource.com/376558
- Verified on ChromeOS kernel4.4

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index cbb7f8b..b401176 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -269,6 +269,7 @@
 		#clock-cells = <0>;
 		phys = <&emmc_phy>;
 		phy-names = "phy_arasan";
+		power-domains = <&power RK3399_PD_EMMC>;
 		status = "disabled";
 	};
 
@@ -690,6 +691,11 @@
 		status = "disabled";
 	};
 
+	qos_emmc: qos at ffa58000 {
+		compatible = "syscon";
+		reg = <0x0 0xffa58000 0x0 0x20>;
+	};
+
 	qos_gmac: qos at ffa5c000 {
 		compatible = "syscon";
 		reg = <0x0 0xffa5c000 0x0 0x20>;
@@ -823,6 +829,11 @@
 			};
 
 			/* These power domains are grouped by VD_LOGIC */
+			pd_emmc at RK3399_PD_EMMC {
+				reg = <RK3399_PD_EMMC>;
+				clocks = <&cru ACLK_EMMC>;
+				pm_qos = <&qos_emmc>;
+			};
 			pd_gmac at RK3399_PD_GMAC {
 				reg = <RK3399_PD_GMAC>;
 				clocks = <&cru ACLK_GMAC>;
-- 
2.7.4
