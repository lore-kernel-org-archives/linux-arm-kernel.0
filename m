From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon,  6 Jun 2016 16:24:44 -0400
Subject: [PATCH 2/2] ARM: dts: exynos: Fix port nodes names for Exynos5420
 Peach Pit board
In-Reply-To: <1465244684-23612-1-git-send-email-javier@osg.samsung.com>
References: <1465244684-23612-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1465244684-23612-3-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit bea7eef6949c ("ARM: dts: exynos: Fix DTC unit name warnings in
Peach Pit") fixed the DTC warnings about mismatches between unit names
and reg properties in the Exynos5420 Peach Pit DTS.

But unfortunately it also added a regression on the Peach Pit when
changing the port node names since the OF graph logic expects the port
nodes to be always named 'port'.

The Documentation/devicetree/bindings/graph.txt binding document says
that when there is more than one port, '#address-cells', '#size-cells'
and 'reg' properties should be used to number the port nodes.

Fixes: bea7eef6949c ("ARM: dts: exynos: Fix DTC unit name warnings in  Peach Pit")
Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/boot/dts/exynos5420-peach-pit.dts | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index f3078430d866..7279f2a0b43d 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -163,7 +163,7 @@
 	hpd-gpios = <&gpx2 6 GPIO_ACTIVE_HIGH>;
 
 	ports {
-		port0 {
+		port {
 			dp_out: endpoint {
 				remote-endpoint = <&bridge_in>;
 			};
@@ -625,13 +625,20 @@
 		use-external-pwm;
 
 		ports {
-			port0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+
 				bridge_out: endpoint {
 					remote-endpoint = <&panel_in>;
 				};
 			};
 
-			port1 {
+			port at 1 {
+				reg = <1>;
+
 				bridge_in: endpoint {
 					remote-endpoint = <&dp_out>;
 				};
-- 
2.5.5
