From: w.egorov@phytec.de (Wadim Egorov)
Date: Thu, 21 Jan 2016 13:57:13 +0100
Subject: [PATCH] ARM: dts: rockchip: Bump sd card pin drive strength up on
 firefly boards
Message-ID: <1453381033-3479-1-git-send-email-w.egorov@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems some firefly boards need 12mA drive strength for sdmmc.
Using 4mA/8mA drive strength will cause the kernel to fail to recognize
the sd card correctly.
Increased the sdmmc lines drive strength from 4mA to 12mA.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index 4e3fd9a..49ec20d 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -408,6 +408,11 @@
 		output-low;
 	};
 
+	pcfg_pull_up_drv_12ma: pcfg-pull-up-drv-12ma {
+		bias-pull-up;
+		drive-strength = <12>;
+	};
+
 	act8846 {
 		pwr_hold: pwr-hold {
 			rockchip,pins = <0 1 RK_FUNC_GPIO &pcfg_output_high>;
@@ -457,6 +462,25 @@
 	};
 
 	sdmmc {
+		/*
+		 * Default drive strength isn't enough to achieve even
+		 * high-speed mode on firefly board so bump up to 12ma.
+		 */
+		sdmmc_bus4: sdmmc-bus4 {
+			rockchip,pins = <6 16 RK_FUNC_1 &pcfg_pull_up_drv_12ma>,
+					<6 17 RK_FUNC_1 &pcfg_pull_up_drv_12ma>,
+					<6 18 RK_FUNC_1 &pcfg_pull_up_drv_12ma>,
+					<6 19 RK_FUNC_1 &pcfg_pull_up_drv_12ma>;
+		};
+
+		sdmmc_clk: sdmmc-clk {
+			rockchip,pins = <6 20 RK_FUNC_1 &pcfg_pull_none_12ma>;
+		};
+
+		sdmmc_cmd: sdmmc-cmd {
+			rockchip,pins = <6 21 RK_FUNC_1 &pcfg_pull_up_drv_12ma>;
+		};
+
 		sdmmc_pwr: sdmmc-pwr {
 			rockchip,pins = <7 11 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
-- 
1.9.1
