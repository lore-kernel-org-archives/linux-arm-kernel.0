From: nm@ti.com (Nishanth Menon)
Date: Wed, 17 Jul 2013 11:45:37 -0500
Subject: [PATCH 8/9] ARM: dts: omap5-uevm: update LDO7 voltage to 2V and
 settings
In-Reply-To: <1374079538-19548-1-git-send-email-nm@ti.com>
References: <1374079538-19548-1-git-send-email-nm@ti.com>
Message-ID: <1374079538-19548-9-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit e00c27ef3b4c23e39d0a77b7c8e5be44c28001c7
(ARM: dts: OMAP5: Add Palmas MFD node and regulator nodes)
introduced regulator entries for OMAP5uEVM.

However, The regulator information is based on an older temporary
pre-production board variant and does not reflect production board
750-2628-XXX boards.

LDO4 supplies VDD_VPP which is vpp1. This is currently configured for
1.5V which as per data manual "A pulse width of 1000 ns and an amplitude
of 2V is required to program each eFuse bit. Otherwise, VPP1 must not
be supplied".

So, fix the voltage to 2V. and disable the supply since we have no plans
of programming efuse bits - it can only be done once - in factory.

Further it is not enabled by default by PMIC so, 'boot-on' must be
removed, and the 'always-on' needs to be removed to achieve pulsing
if efuse needs to be programmed.

Reported-by: Marc J?ttner <m-juettner@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 3ff5874..ef05676 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -397,10 +397,10 @@
 				ldo7_reg: ldo7 {
 					/* VDD_VPP: vpp1 */
 					regulator-name = "ldo7";
-					regulator-min-microvolt = <1500000>;
-					regulator-max-microvolt = <1500000>;
-					regulator-always-on;
-					regulator-boot-on;
+					regulator-min-microvolt = <2000000>;
+					regulator-max-microvolt = <2000000>;
+					/* Only for efuse reprograming! */
+					status = "disabled";
 				};
 
 				ldo8_reg: ldo8 {
-- 
1.7.9.5
