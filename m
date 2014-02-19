From: kaloz@openwrt.org (Imre Kaloz)
Date: Wed, 19 Feb 2014 11:41:35 +0100
Subject: [PATCH] ARM: OMAP2+: Use pdata quirks for wl12xx on the AM335x EV-MSK
Message-ID: <1392806495-4874-1-git-send-email-kaloz@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the WiLink6 connected to mmc2.

Signed-off-by: Imre Kaloz <kaloz at openwrt.org
---
 arch/arm/boot/dts/am335x-evmsk.dts |   40 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pdata-quirks.c |   10 +++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 4718ec4..a544fc4 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -45,6 +45,18 @@
 		regulator-boot-on;
 	};
 
+	wl12xx_vmmc: fixedregulator@2 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&wl12xx_gpio>;
+		compatible = "regulator-fixed";
+		regulator-name = "vwl1271";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio1 29 0>;
+		startup-delay-us = <70000>;
+		enable-active-high;
+	};
+
 	leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&user_leds_s0>;
@@ -264,6 +276,24 @@
 			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE4) /* rmii1_ref_clk.mcasp1_axr3 */
 		>;
 	};
+
+	mmc2_pins: pinmux_mmc2_pins {
+		pinctrl-single,pins = <
+			0x74 (PIN_INPUT_PULLUP | MUX_MODE7) /* gpmc_wpn.gpio0_31 */
+			0x80 (PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk */
+			0x84 (PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn2.mmc1_cmd */
+			0x00 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0 */
+			0x04 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1 */
+			0x08 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2 */
+			0x0c (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3 */
+		>;
+	};
+
+	wl12xx_gpio: pinmux_wl12xx_gpio {
+		pinctrl-single,pins = <
+			0x7c (PIN_OUTPUT_PULLUP | MUX_MODE7) /* gpmc_csn0.gpio1_29 */
+		>;
+	};
 };
 
 &uart0 {
@@ -470,6 +500,16 @@
 	ti,no-reset-on-init;
 };
 
+&mmc2 {
+	status = "okay";
+	vmmc-supply = <&wl12xx_vmmc>;
+	ti,non-removable;
+	bus-width = <4>;
+	cap-power-off-card;
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_pins>;
+};
+
 &mcasp1 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&mcasp1_pins>;
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 3d5b24d..a92acdb 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -187,6 +187,13 @@ static void __init omap4_panda_legacy_init(void)
 }
 #endif
 
+#ifdef CONFIG_SOC_AM33XX
+static void __init am335x_evmsk_legacy_init(void)
+{
+	legacy_init_wl12xx(WL12XX_REFCLOCK_24, 0, 31);
+}
+#endif
+
 #ifdef CONFIG_SOC_OMAP5
 static void __init omap5_uevm_legacy_init(void)
 {
@@ -271,6 +278,9 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "ti,omap4-sdp", omap4_sdp_legacy_init, },
 	{ "ti,omap4-panda", omap4_panda_legacy_init, },
 #endif
+#ifdef CONFIG_SOC_AM33XX
+	{ "ti,am335x-evmsk", am335x_evmsk_legacy_init, },
+#endif
 #ifdef CONFIG_SOC_OMAP5
 	{ "ti,omap5-uevm", omap5_uevm_legacy_init, },
 #endif
-- 
1.7.10.4
