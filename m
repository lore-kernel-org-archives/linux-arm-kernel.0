From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 9 Jun 2017 14:11:41 +0530
Subject: [PATCH] ARM: dts: omap3-overo: Remove "vqmmc-supply" property from
 MMC dt node
Message-ID: <20170609084141.15582-1-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 94647a30124e2c7 ("ARM: dts: omap3-overo: Enable WiFi/BT combo")
while enabling WiFi/BT combo added regulator to trigger the nReset
signal of the Bluetooth module in vqmmc-supply. However BT should be
handled by UART. Moreover "vqmmc" is not a defined binding for
omap_hsmmc. While "vqmmc" in mmc2 hasn't caused any issues so far,
mmc2 will start to mis-behave once omap_hsmmc defines "vqmmc"
binding.

Remove "vqmmc-supply" property in mmc2 here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap3-overo-base.dtsi | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index 401fae838fe9..cd220342a805 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -74,16 +74,6 @@
 		gpio = <&gpio1 16 GPIO_ACTIVE_HIGH>;		/* gpio_16: WiFi nReset */
 		startup-delay-us = <10000>;
 	};
-
-	/* Regulator to trigger the nReset signal of the Bluetooth module */
-	w3cbw003c_bt_nreset: regulator-w3cbw003c-bt-nreset {
-		compatible = "regulator-fixed";
-		regulator-name = "regulator-w3cbw003c-bt-nreset";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio6 4 GPIO_ACTIVE_HIGH>;		/* gpio_164: BT nReset */
-		startup-delay-us = <10000>;
-	};
 };
 
 &omap3_pmx_core {
@@ -191,7 +181,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&w3cbw003c_npoweron>;
-	vqmmc-supply = <&w3cbw003c_bt_nreset>;
 	vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
 	bus-width = <4>;
 	cap-sdio-irq;
-- 
2.11.0
