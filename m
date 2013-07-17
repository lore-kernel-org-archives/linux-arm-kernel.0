From: nm@ti.com (Nishanth Menon)
Date: Wed, 17 Jul 2013 11:45:38 -0500
Subject: [PATCH 9/9] ARM: dts: omap5-uevm: update SDCARD LDO9 and resource
 REGEN3
In-Reply-To: <1374079538-19548-1-git-send-email-nm@ti.com>
References: <1374079538-19548-1-git-send-email-nm@ti.com>
Message-ID: <1374079538-19548-10-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit e00c27ef3b4c23e39d0a77b7c8e5be44c28001c7
(ARM: dts: OMAP5: Add Palmas MFD node and regulator nodes)
introduced regulator entries for OMAP5uEVM.

However, The regulator information is based on an older temporary
pre-production board variant and does not reflect production board
750-2628-XXX boards.

LDO9 supplies the board specified vdds_sdcard supply going within SoC
specification of 1.8V or 3.0V. Further the supply is controlled by
switch enabled by REGEN3. So, introduce REGEN3 and map sdcard slot to
be powered by LDO9. Remove 'always-on' allowing the LDO to be disabled
on need basis.

Reported-by: Marc J?ttner <m-juettner@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index ef05676..65d7b60 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -235,7 +235,7 @@
 };
 
 &mmc1 {
-	vmmc-supply = <&vmmcsd_fixed>;
+	vmmc-supply = <&ldo9_reg>;
 	bus-width = <4>;
 };
 
@@ -417,8 +417,7 @@
 					/* VCC_DV_SDIO: vdds_sdcard */
 					regulator-name = "ldo9";
 					regulator-min-microvolt = <1800000>;
-					regulator-max-microvolt = <3300000>;
-					regulator-always-on;
+					regulator-max-microvolt = <3000000>;
 					regulator-boot-on;
 				};
 
@@ -439,6 +438,13 @@
 					regulator-always-on;
 					regulator-boot-on;
 				};
+
+				regen3_reg: regen3 {
+					/* REGEN3 controls LDO9 supply to card */
+					regulator-name = "regen3";
+					regulator-always-on;
+					regulator-boot-on;
+				};
 			};
 		};
 	};
-- 
1.7.9.5
