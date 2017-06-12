From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 12 Jun 2017 11:27:24 +0200
Subject: [PATCH] ARM: dts: armadillo800eva: Split LCD mux and gpio
In-Reply-To: <cover.1497259417.git.horms+renesas@verge.net.au>
References: <cover.1497259417.git.horms+renesas@verge.net.au>
Message-ID: <13132b3f44d3600983aceb7e9920b8ebb55a7cf8.1497259417.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

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
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 7885075428bb..1788e186a512 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -266,7 +266,9 @@
 	lcd0_pins: lcd0 {
 		groups = "lcd0_data24_0", "lcd0_lclk_1", "lcd0_sync";
 		function = "lcd0";
+	};
 
+	lcd0_mux {
 		/* DBGMD/LCDC0/FSIA MUX */
 		gpio-hog;
 		gpios = <176 0>;
-- 
2.1.4
