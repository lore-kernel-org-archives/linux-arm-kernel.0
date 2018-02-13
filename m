From: d.schultz@phytec.de (Daniel Schultz)
Date: Tue, 13 Feb 2018 10:44:34 +0100
Subject: [PATCH 3/3] ARM: dts: rockchip: phycore: Support UHS mode for SD card
 on phyCORE-RK3288 RDK
In-Reply-To: <1518515074-22526-1-git-send-email-d.schultz@phytec.de>
References: <1518515074-22526-1-git-send-email-d.schultz@phytec.de>
Message-ID: <1518515074-22526-3-git-send-email-d.schultz@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wadim Egorov <w.egorov@phytec.de>

The phyCORE-RK3288 RDK could enable SD3.0 card but need vdd_io_sd to
support the voltage range from 1.8V to 3.3V.
And we have also to add relevant UHS modes to the sdmmc node.
Let's also turn off the vdd_io_sd regulator in suspend state.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 arch/arm/boot/dts/rk3288-phycore-rdk.dts  | 4 ++++
 arch/arm/boot/dts/rk3288-phycore-som.dtsi | 5 ++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-phycore-rdk.dts b/arch/arm/boot/dts/rk3288-phycore-rdk.dts
index ecb26f0..985743f 100644
--- a/arch/arm/boot/dts/rk3288-phycore-rdk.dts
+++ b/arch/arm/boot/dts/rk3288-phycore-rdk.dts
@@ -265,6 +265,10 @@
 	disable-wp;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	vmmc-supply = <&vdd_sd>;
 	vqmmc-supply = <&vdd_io_sd>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/rk3288-phycore-som.dtsi b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
index 5eae477..f13bcb1 100644
--- a/arch/arm/boot/dts/rk3288-phycore-som.dtsi
+++ b/arch/arm/boot/dts/rk3288-phycore-som.dtsi
@@ -336,11 +336,10 @@
 				regulator-name = "vdd_io_sd";
 				regulator-always-on;
 				regulator-boot-on;
-				regulator-min-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-state-mem {
-					regulator-on-in-suspend;
-					regulator-suspend-microvolt = <3300000>;
+					regulator-off-in-suspend;
 				};
 			};
 		};
-- 
2.7.4
