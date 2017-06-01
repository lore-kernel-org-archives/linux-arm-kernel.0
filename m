From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu,  1 Jun 2017 12:27:00 +0200
Subject: [PATCH v2] ARM: dts: armadillo800eva: Split LCD mux and gpio
Message-ID: <1496312820-27237-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configuration of the lcd0 pinmux group and GPIO hog for the external
GPIO mux are done using a single device node, causing the "output-high"
property to be applied to both.  This will fail for the pinmux group,
but doesn't cause any harm, as the failure is ignored silently.

However, after "pinctrl: sh-pfc: propagate errors on group config", the
failure will become fatal, leading to a broken display:

    sh-pfc e6050000.pin-controller: pin_config_group_set op failed for group 102
    sh-pfc e6050000.pin-controller: Error applying setting, reverse things back
    sh-pfc e6050000.pin-controller: failed to select default state

Move the GPIO hog to its own node to fix this.

Fixes: ffd2f9a5afb730b9 ("ARM: shmobile: armadillo800eva dts: Add pinctrl and gpio-hog for lcdc0")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is a hard dependency for "pinctrl: sh-pfc: propagate errors on
group config" (https://patchwork.kernel.org/patch/9186713/).

v2:
  - Keep the GPIO hog, but move it to its own node, instead of using
    another level of subnodes.  As the GPIO hog node is not referenced from
    a pinctrl-0 property, pinconf doesn't fail with "No pin or group
    provided in DT node".
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 297b1f10f7346a9f..8c85d3ee5f5e7bfd 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -273,7 +273,9 @@
 	lcd0_pins: lcd0 {
 		groups = "lcd0_data24_0", "lcd0_lclk_1", "lcd0_sync";
 		function = "lcd0";
+	};
 
+	lcd0_mux {
 		/* DBGMD/LCDC0/FSIA MUX */
 		gpio-hog;
 		gpios = <176 0>;
-- 
2.7.4
