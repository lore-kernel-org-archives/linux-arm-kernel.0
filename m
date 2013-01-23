From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 23 Jan 2013 17:37:50 +0100
Subject: [PATCH v3 7/8] ARM: shmobile: completely switch MMC interfaces on
 mackerel-reference to DT
In-Reply-To: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
References: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1358959071-2873-8-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch MMCIF, SDHI0 and SDHI2 to complete DT initialisation: use DT
bindings to configure interface pins, card-detect GPIOs, various
interface configuration parameters. Notice, since MMCIF and SDHI1 share
the same card slot, both devices cannot be successfully probed
simultaneously: they both would try to get the card-detection GPIO and only
one would succeed. Ideally it should be possible to let the user decide
which device to enable by, possibly, patching the DT at run-time. As long as
this is unsupported, we choose to enable MMCIF and remove SDHI1 from DT
completely.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/boot/dts/sh7372-mackerel-reference.dts   |   42 +++++++++++++++----
 arch/arm/mach-shmobile/board-mackerel-reference.c |   46 ---------------------
 2 files changed, 33 insertions(+), 55 deletions(-)

diff --git a/arch/arm/boot/dts/sh7372-mackerel-reference.dts b/arch/arm/boot/dts/sh7372-mackerel-reference.dts
index 2fd1eff..aa72309 100644
--- a/arch/arm/boot/dts/sh7372-mackerel-reference.dts
+++ b/arch/arm/boot/dts/sh7372-mackerel-reference.dts
@@ -75,6 +75,11 @@
 		interrupt-parent = <&intca>;
 		interrupts = <0x1ac0 0x1ae0>;
 		vmmc-supply = <&reg_1p8v>;
+		bus-width = <8>;
+		cd-gpios = <&gpio 41 1>;
+		broken-cd;
+		pinctrl-names = "default";
+		pinctrl-0 = <&mmc0_pins>;
 	};
 
 	sdhi0: sdhi at 0xe6850000 {
@@ -83,22 +88,26 @@
 		interrupt-parent = <&intca>;
 		interrupts = <0x0e00 0x0e20 0x0e40>;
 		vmmc-supply = <&reg_3p3v>;
-	};
-
-	sdhi1: sdhi at 0xe6860000 {
-		compatible = "renesas,shmobile-sdhi";
-		reg = <0xe6860000 0x100>;
-		interrupt-parent = <&intca>;
-		interrupts = <0x0e80 0x0ea0 0x0ec0>;
-		vmmc-supply = <&reg_1p8v>;
+		bus-width = <4>;
+		cd-gpios = <&gpio 172 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdhi0_pins>;
+		toshiba,mmc-cap-sdio-irq;
 	};
 
 	sdhi2: sdhi at 0xe6870000 {
 		compatible = "renesas,shmobile-sdhi";
 		reg = <0xe6870000 0x100>;
 		interrupt-parent = <&intca>;
-		interrupts = <0x1200 0x1220 0x1240>;
+		interrupts = <0x1220 0x1240>;
 		vmmc-supply = <&reg_3p3v>;
+		bus-width = <4>;
+		cd-gpios = <&gpio 162 1>;
+		broken-cd;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdhi2_pins>;
+		toshiba,mmc-wrprotect-disable;
+		toshiba,mmc-cap-sdio-irq;
 	};
 
 	flash at 2000000 {
@@ -129,3 +138,18 @@
 		};
 	};
 };
+
+&gpio {
+	sdhi0_pins: pfc_sdhi0_pins {
+		renesas,pins = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_wp";
+		renesas,function = "sdhi0";
+	};
+	sdhi2_pins: pfc_sdhi2_pins {
+		renesas,pins = "sdhi2_data4", "sdhi2_ctrl";
+		renesas,function = "sdhi2";
+	};
+	mmc0_pins: pfc_mmc0_pins {
+		renesas,pins = "mmc0_data8_0", "mmc0_ctrl_0";
+		renesas,function = "mmc0";
+	};
+};
diff --git a/arch/arm/mach-shmobile/board-mackerel-reference.c b/arch/arm/mach-shmobile/board-mackerel-reference.c
index 1d83653..323a812 100644
--- a/arch/arm/mach-shmobile/board-mackerel-reference.c
+++ b/arch/arm/mach-shmobile/board-mackerel-reference.c
@@ -42,8 +42,6 @@ static void __init mackerel_init(void)
 	/* External clock source */
 	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
 
-	sh7372_pinmux_init();
-
 	/* enable SCIFA0 */
 	gpio_request(GPIO_FN_SCIFA0_TXD, NULL);
 	gpio_request(GPIO_FN_SCIFA0_RXD, NULL);
@@ -59,50 +57,6 @@ static void __init mackerel_init(void)
 	/* enable Accelerometer */
 	gpio_request(GPIO_FN_IRQ21,	NULL);
 	irq_set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);
-
-	/* enable SDHI0 */
-	gpio_request(GPIO_FN_SDHIWP0, NULL);
-	gpio_request(GPIO_FN_SDHICMD0, NULL);
-	gpio_request(GPIO_FN_SDHICLK0, NULL);
-	gpio_request(GPIO_FN_SDHID0_3, NULL);
-	gpio_request(GPIO_FN_SDHID0_2, NULL);
-	gpio_request(GPIO_FN_SDHID0_1, NULL);
-	gpio_request(GPIO_FN_SDHID0_0, NULL);
-
-	/* SDHI0 PORT172 card-detect IRQ26 */
-	gpio_request(GPIO_FN_IRQ26_172, NULL);
-
-	/* enable SDHI1 */
-	gpio_request(GPIO_FN_SDHICMD1, NULL);
-	gpio_request(GPIO_FN_SDHICLK1, NULL);
-	gpio_request(GPIO_FN_SDHID1_3, NULL);
-	gpio_request(GPIO_FN_SDHID1_2, NULL);
-	gpio_request(GPIO_FN_SDHID1_1, NULL);
-	gpio_request(GPIO_FN_SDHID1_0, NULL);
-
-	/* enable SDHI2 */
-	gpio_request(GPIO_FN_SDHICMD2, NULL);
-	gpio_request(GPIO_FN_SDHICLK2, NULL);
-	gpio_request(GPIO_FN_SDHID2_3, NULL);
-	gpio_request(GPIO_FN_SDHID2_2, NULL);
-	gpio_request(GPIO_FN_SDHID2_1, NULL);
-	gpio_request(GPIO_FN_SDHID2_0, NULL);
-
-	/* card detect pin for microSD slot (CN23) */
-	gpio_request(GPIO_PORT162, NULL);
-	gpio_direction_input(GPIO_PORT162);
-
-	/* MMCIF */
-	gpio_request(GPIO_FN_MMCD0_0, NULL);
-	gpio_request(GPIO_FN_MMCD0_1, NULL);
-	gpio_request(GPIO_FN_MMCD0_2, NULL);
-	gpio_request(GPIO_FN_MMCD0_3, NULL);
-	gpio_request(GPIO_FN_MMCD0_4, NULL);
-	gpio_request(GPIO_FN_MMCD0_5, NULL);
-	gpio_request(GPIO_FN_MMCD0_6, NULL);
-	gpio_request(GPIO_FN_MMCD0_7, NULL);
-	gpio_request(GPIO_FN_MMCCMD0, NULL);
-	gpio_request(GPIO_FN_MMCCLK0, NULL);
 }
 
 static const char *mackerel_compat_dt[] __initdata = {
-- 
1.7.2.5
