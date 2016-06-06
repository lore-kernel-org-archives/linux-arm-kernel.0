From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon,  6 Jun 2016 16:24:43 -0400
Subject: [PATCH 1/2] ARM: dts: exynos: Fix port nodes names for Exynos5250
 Snow board
In-Reply-To: <1465244684-23612-1-git-send-email-javier@osg.samsung.com>
References: <1465244684-23612-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1465244684-23612-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 5c9cbade0629 ("ARM: dts: exynos: Fix DTC unit name warnings in
Exynos5250") fixed all the DTC warnings about mismatchs between unit
names and reg properties in Exynos5250 boards DTS.

But unfortunately it also added a regression on the Exynos5250 Snow
Chromebook when changing the port node names since the OF graph logic
expects the port nodes to be always named 'port'.

The Documentation/devicetree/bindings/graph.txt binding document says
that when there is more than one port, '#address-cells', '#size-cells'
and 'reg' properties should be used to number the port nodes.

Fixes: 5c9cbade0629 ("ARM: dts: exynos: Fix DTC unit name warnings in Exynos5250")
Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index 419d59da1751..fadbea744e1a 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -242,7 +242,7 @@
 	hpd-gpios = <&gpx0 7 GPIO_ACTIVE_HIGH>;
 
 	ports {
-		port0 {
+		port {
 			dp_out: endpoint {
 				remote-endpoint = <&bridge_in>;
 			};
@@ -485,13 +485,20 @@
 		edid-emulation = <5>;
 
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
