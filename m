From: marek@goldelico.com (Marek Belisko)
Date: Tue, 17 May 2016 21:48:51 +0200
Subject: [PATCH 5/5] ARM: dts: omap3-gat04: Fix wifi handling
In-Reply-To: <1463514531-7235-1-git-send-email-marek@goldelico.com>
References: <1463514531-7235-1-git-send-email-marek@goldelico.com>
Message-ID: <1463514531-7235-6-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

Without that change wifi card isn't probed because pwrseq is necessary for
libertas chip.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 55b6b88..6349257 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -155,6 +155,11 @@
 			};
 		};
 	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&tca6507 0 GPIO_ACTIVE_LOW>;	/* W2CBW003 reset through tca6507 */
+	};
 };
 
 &omap3_pmx_core {
@@ -354,8 +359,8 @@
 		interrupts = <24 IRQ_TYPE_EDGE_FALLING>; /* GPIO_56 */
 	};
 
-	/* leds */
-	tca6507 at 45 {
+	/* leds + gpios */
+	tca6507: tca6507 at 45 {
 		compatible = "ti,tca6507";
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -446,6 +451,7 @@
 	bus-width = <4>;
 	ti,non-removable;
 	cap-power-off-card;
+	mmc-pwrseq = <&wifi_pwrseq>;
 };
 
 &mmc3 {
-- 
2.5.0
