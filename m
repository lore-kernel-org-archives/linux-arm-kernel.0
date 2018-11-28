From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 28 Nov 2018 12:45:07 +0200
Subject: [PATCH] ARM: dts: dra7: Move the ti, no-idle quirk on proper gmac node
Message-ID: <1543401907-14751-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hwmod parses the DT hierarchically from root to search for matching
ti,hwmod property. With the introduction of L4 data, we have two nodes
with the ti,hwmod = "gmac" declaration, and the hwmod core only matches
the first one found, which is the target-module one. This node incorrectly
dropped the ti,no-idle flag, which causes number of problems, like ignoring
errata i877, and also causing an intermittent boot failure on certain dra7
boards.

Fix the issue by moving the ti,no-idle flag to the proper node.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
FYI: The problem is seen in linux-next.

 arch/arm/boot/dts/dra7-l4.dtsi | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 7e5c0d4f..6c01ada 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -3021,6 +3021,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x84000 0x4000>;
+			/*
+			 * Do not allow gating of cpsw clock as workaround
+			 * for errata i877. Keeping internal clock disabled
+			 * causes the device switching characteristics
+			 * to degrade over time and eventually fail to meet
+			 * the data manual delay time/skew specs.
+			 */
+			ti,no-idle;
 
 			mac: ethernet at 0 {
 				compatible = "ti,dra7-cpsw","ti,cpsw";
@@ -3040,15 +3048,6 @@
 				#size-cells = <1>;
 
 				/*
-				 * Do not allow gating of cpsw clock as workaround
-				 * for errata i877. Keeping internal clock disabled
-				 * causes the device switching characteristics
-				 * to degrade over time and eventually fail to meet
-				 * the data manual delay time/skew specs.
-				 */
-				ti,no-idle;
-
-				/*
 				 * rx_thresh_pend
 				 * rx_pend
 				 * tx_pend
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
