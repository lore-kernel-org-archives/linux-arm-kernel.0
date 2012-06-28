From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 11:45:01 +0800
Subject: [PATCH 05/11] ARM: dts: imx28-evk: add vmmc-supply for mmc device
In-Reply-To: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
References: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340855107-4664-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add vmmc-supply for mmc device, so that the power to mmc slot can be
turned on by mmc driver if bootloader hasn't done it.

Also remove "okay" status for mmc1/ssp1, as the device has pin conflict
with gpmi-nand.  Actually the device is already disabled since the
mxs-mmc driver adopts pinctrl support because there is no pinctrl setup
for the device in dts.  Make this explicit by removing "okay" status.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-evk.dts |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 505ae5e..28b94d3 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -35,6 +35,7 @@
 					&mmc0_cd_cfg &mmc0_sck_cfg>;
 				bus-width = <8>;
 				wp-gpios = <&gpio2 12 0>;
+				vmmc-supply = <&reg_vddio_sd0>;
 				status = "okay";
 			};
 
@@ -42,7 +43,6 @@
 				compatible = "fsl,imx28-mmc";
 				bus-width = <8>;
 				wp-gpios = <&gpio0 28 0>;
-				status = "okay";
 			};
 
 			pinctrl at 80018000 {
@@ -141,6 +141,14 @@
 			regulator-max-microvolt = <3300000>;
 			regulator-always-on;
 		};
+
+		reg_vddio_sd0: vddio-sd0 {
+			compatible = "regulator-fixed";
+			regulator-name = "vddio-sd0";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 28 0>;
+		};
 	};
 
 	sound {
-- 
1.7.5.4
