From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:59 +0900
Subject: [PATCH 28/30] ARM: shmobile: ape6evm: Fix LAN9220 VDDVARIO voltage
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <09ee81da85b10e0ca876977d333c8761441ecc78.1419812186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The LAN9220 VDDVARIO supply is powered by a 1.8V source, not 3.3V. Fix
it in the device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 6b7bc1f..0d50bef 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -55,8 +55,16 @@
 		enable-active-high;
 	};
 
-	/* Common 3.3V rail, used by several devices on APE6EVM */
-	ape6evm_fixed_3v3: regulator at 2 {
+	/* Common 1.8V and 3.3V rails, used by several devices on APE6EVM */
+	ape6evm_fixed_1v8: regulator at 2 {
+		compatible = "regulator-fixed";
+		regulator-name = "1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	ape6evm_fixed_3v3: regulator at 3 {
 		compatible = "regulator-fixed";
 		regulator-name = "3V3";
 		regulator-min-microvolt = <3300000>;
@@ -80,7 +88,7 @@
 			smsc,irq-active-high;
 			smsc,irq-push-pull;
 			vdd33a-supply = <&ape6evm_fixed_3v3>;
-			vddvario-supply = <&ape6evm_fixed_3v3>;
+			vddvario-supply = <&ape6evm_fixed_1v8>;
 		};
 	};
 
-- 
2.1.3
