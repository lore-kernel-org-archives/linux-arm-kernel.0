From: tony@atomide.com (Tony Lindgren)
Date: Thu, 25 Apr 2013 20:52:16 -0700
Subject: [PATCH 3/3] ARM: dts: Add muxing for wl12xx on the SDIO bus for blaze
In-Reply-To: <20130426034858.26065.65118.stgit@muffinssi.local>
References: <20130426034858.26065.65118.stgit@muffinssi.local>
Message-ID: <20130426035216.26065.32776.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should work assuming the board-4430sdp.c works, but it seems
that I don't have the "1283 PG 2.21 connectivity device" on
my blaze. Anybody got a spare connectivity device for blaze?

Also, if somebody has the schematics, please provide a patch
for the missing GPIO muxes for blaze, see the the panda for
what's currently missing.

Cc: Luciano Coelho <coelho@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Ruslan Bilovol <ruslan.bilovol@ti.com>
Cc: devicetree-discuss at lists.ozlabs.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-sdp.dts |   39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index a35d9cd..c13c483 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -140,6 +140,19 @@
 			"DMic", "Digital Mic",
 			"Digital Mic", "Digital Mic1 Bias";
 	};
+
+	/* regulator for wl12xx on sdio5 */
+	wl12xx_vmmc: wl12xx_vmmc {
+		pinctrl-names = "default";
+		pinctrl-0 = <&wl12xx_gpio>;
+		compatible = "regulator-fixed";
+		regulator-name = "vwl1271";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio2 22 0>;
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
 };
 
 &omap4_pmx_core {
@@ -275,6 +288,26 @@
 			0xf0 0x118     /* i2c4_sda PULLUP | INPUTENABLE | MODE0 */
 		>;
 	};
+
+	/* wl12xx GPIO output for WLAN_EN */
+	wl12xx_gpio: pinmux_wl12xx_gpio {
+		pinctrl-single,pins = <
+			0x3c 0x3	/* gpmc_nwp.gpio_54 OUTPUT | MODE3 */
+		>;
+	};
+
+	/* wl12xx GPIO inputs and SDIO pins */
+	wl12xx_pins: pinmux_wl12xx_pins {
+		pinctrl-single,pins = <
+			0x3a 0x103	/* gpmc_ncs3.gpio_53 INPUT | MODE3 */
+			0x108 0x118	/* sdmmc5_clk.sdmmc5_clk INPUT_PULLUP | MODE0 */
+			0x10a 0x118	/* sdmmc5_cmd.sdmmc5_cmd INPUT_PULLUP | MODE0 */
+			0x10c 0x118	/* sdmmc5_dat0.sdmmc5_dat0 INPUT_PULLUP | MODE0 */
+			0x10e 0x118	/* sdmmc5_dat1.sdmmc5_dat1 INPUT_PULLUP | MODE0 */
+			0x110 0x118	/* sdmmc5_dat2.sdmmc5_dat2 INPUT_PULLUP | MODE0 */
+			0x112 0x118	/* sdmmc5_dat3.sdmmc5_dat3 INPUT_PULLUP | MODE0 */
+      		>;
+	};
 };
 
 &i2c1 {
@@ -400,8 +433,12 @@
 };
 
 &mmc5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wl12xx_pins>;
+	vmmc-supply = <&wl12xx_vmmc>;
+	non-removable;
 	bus-width = <4>;
-	ti,non-removable;
+	cap-power-off-card;
 };
 
 &emif1 {
