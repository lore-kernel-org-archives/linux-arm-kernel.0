From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 27 Apr 2015 15:19:10 +0200
Subject: [PATCH 1/4] ARM: at91/dt: sama5d3 xplained: fill in mmc1 and set it
 to disabled
Message-ID: <1430140753-19998-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

The mmc1 channel is not populated on the SAM5D3 Xplained board, however
it is enabled and therefore the driver is attaching to it.

The node configuration for mmc1 is missing, so add an mmc1 node in the
device tree and set its status to disabled. Also add the vmmc and the
necessary slot configuration if this node were enabled to avoid the following
warnings from the driver:

atmel_mci f8000000.mmc: No vmmc regulator found
atmel_mci f8000000.mmc: No vqmmc regulator found

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index 9991240..af8b263 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -43,6 +43,17 @@
 				};
 			};
 
+			mmc1: mmc at f8000000 {
+				vmmc-supply = <&vcc_3v3_reg>;
+				vqmmc-supply = <&vcc_3v3_reg>;
+				status = "disabled";
+				slot at 0 {
+					reg = <0>;
+					bus-width = <4>;
+					cd-gpios = <&pioE 1 GPIO_ACTIVE_LOW>;
+				};
+			};
+
 			spi0: spi at f0004000 {
 				cs-gpios = <&pioD 13 0>, <0>, <0>, <&pioD 16 0>;
 				status = "okay";
-- 
2.2.0
