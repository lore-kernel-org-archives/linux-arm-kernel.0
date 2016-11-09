From: wxt@rock-chips.com (Caesar Wang)
Date: Wed,  9 Nov 2016 21:21:54 +0800
Subject: [PATCH v2 2/9] arm64: dts: rockchip: add pd_sd power node for rk3399
In-Reply-To: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
References: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1478697721-2323-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zhangqing <zhangqing@rock-chips.com>

1.add pd node for RK3399 Soc
2.create power domain tree
3.add qos node for domain
4.add the pd_sd consumers node

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v2:
- v1 on https://patchwork.kernel.org/patch/9322553/
- Reviewed-on: https://chromium-review.googlesource.com/386483
- Verified on ChromeOS kernel4.4

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index b401176..e5b5b3d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -253,6 +253,7 @@
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
 		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
+		power-domains = <&power RK3399_PD_SD>;
 		status = "disabled";
 	};
 
@@ -691,6 +692,11 @@
 		status = "disabled";
 	};
 
+	qos_sd: qos at ffa74000 {
+		compatible = "syscon";
+		reg = <0x0 0xffa74000 0x0 0x20>;
+	};
+
 	qos_emmc: qos at ffa58000 {
 		compatible = "syscon";
 		reg = <0x0 0xffa58000 0x0 0x20>;
@@ -839,6 +845,12 @@
 				clocks = <&cru ACLK_GMAC>;
 				pm_qos = <&qos_gmac>;
 			};
+			pd_sd at RK3399_PD_SD {
+				reg = <RK3399_PD_SD>;
+				clocks = <&cru HCLK_SDMMC>,
+					 <&cru SCLK_SDMMC>;
+				pm_qos = <&qos_sd>;
+			};
 			pd_vio at RK3399_PD_VIO {
 				reg = <RK3399_PD_VIO>;
 				#address-cells = <1>;
-- 
2.7.4
