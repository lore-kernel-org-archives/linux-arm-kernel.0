From: peda@axentia.se (Peter Rosin)
Date: Fri, 17 Mar 2017 23:24:46 +0100
Subject: [PATCH] ARM: dts: at91: add envelope detector mux to the Axentia
 TSE-850
Message-ID: <1489789486-30985-1-git-send-email-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The envelope detector can analyze 6 different signals, selectable with a
mux controlled by three gpio pins.

Signed-off-by: Peter Rosin <peda@axentia.se>
---

Hi!

This patch makes use of the mux subsystem and a couple of drivers
available in linux-next since a week or two. The stuff this depends
on has relevant acks, specifically on the DT bindings, so the bindings
should be stable and not cause trouble for this patch. Which is why I
thought I'd try to get this in for v4.12-rc1 along with that mux
subsystem series.

Please consider applying.

Cheers,
peda

arch/arm/boot/dts/at91-tse850-3.dts | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-tse850-3.dts b/arch/arm/boot/dts/at91-tse850-3.dts
index 669a2c6bdefc..7a68805a4eb5 100644
--- a/arch/arm/boot/dts/at91-tse850-3.dts
+++ b/arch/arm/boot/dts/at91-tse850-3.dts
@@ -86,16 +86,43 @@
 		#io-channel-cells = <1>;
 	};
 
-	envelope-detector {
+	env_det: envelope-detector {
 		compatible = "axentia,tse850-envelope-detector";
 		io-channels = <&dac 0>;
 		io-channel-names = "dac";
+		#io-channel-cells = <1>;
 
 		interrupt-parent = <&pioA>;
 		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
 		interrupt-names = "comp";
 	};
 
+	mux: mux-controller {
+		compatible = "mux-gpio";
+		#mux-control-cells = <0>;
+
+		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,
+			    <&pioA 1 GPIO_ACTIVE_HIGH>,
+			    <&pioA 2 GPIO_ACTIVE_HIGH>;
+		idle-state = <0>;
+	};
+
+	envelope-detector-mux {
+		compatible = "io-channel-mux";
+		io-channels = <&env_det 0>;
+		io-channel-names = "parent";
+
+		mux-controls = <&mux>;
+
+		channels = "", "",
+			 "sync-1",
+			 "in",
+			 "out",
+			 "sync-2",
+			 "sys-reg",
+			 "ana-reg";
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
-- 
2.1.4
