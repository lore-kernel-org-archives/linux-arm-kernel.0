From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 20 Mar 2017 12:25:51 +0100
Subject: [PATCH] ARM: sun8i: a33: remove highest OPP to fix CPU crashes
Message-ID: <20170320112551.25825-1-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The highest supported frequency (1.2GHz) requires to "overvolt" the CPU.
However, some boards still do not have the cpu-supply DT property in the
cpu DT node which means that the CPU will always run with the same input
voltage but try to run at 1.2GHz frequency. This is the source of
(experienced) CPU crashes.

Remove the OPP which requires overvolting the CPU until all boards have
a cpu-supply property.

Fixes: 03749eb88e635ad67818827adde8e5eea7b64571 ("ARM: dts: sun8i: add
opp-v2 table for A33")

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 9d82414..463b2b3 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -121,12 +121,6 @@
 			opp-microvolt = <1200000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
-
-		opp at 1200000000 {
-			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <1320000>;
-			clock-latency-ns = <244144>; /* 8 32k periods */
-		};
 	};
 
 	cpus {
-- 
2.9.3
