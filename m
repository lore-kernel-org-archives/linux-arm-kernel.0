From: marex@denx.de (Marek Vasut)
Date: Tue, 25 Apr 2017 18:42:24 +0200
Subject: [PATCH] [RFC] ARM: dts: imx6sx-sdb: Drop OPP hackery
Message-ID: <20170425164224.26537-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx6sx-sdb has one power supply that drives both VDDARM_IN
and VDDSOC_IN, which is the sw1a regulator on the PFUZE PMIC.
Connect both inputs to the sw1a regulator on the PMIC and drop
the OPP hackery which is no longer needed as the power framework
will take care of the regulator configuration as needed.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
---
Note: Fabio, if you have a chance, please give this a spin and see
      if this works.
---
 arch/arm/boot/dts/imx6sx-sdb.dts | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
index 5bb8fd57e7f5..c0139d7e497a 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
@@ -12,23 +12,6 @@
 	model = "Freescale i.MX6 SoloX SDB RevB Board";
 };
 
-&cpu0 {
-	operating-points = <
-		/* kHz    uV */
-		996000  1250000
-		792000  1175000
-		396000  1175000
-		198000  1175000
-		>;
-	fsl,soc-operating-points = <
-		/* ARM kHz      SOC uV */
-		996000	1250000
-		792000	1175000
-		396000	1175000
-		198000  1175000
-	>;
-};
-
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -145,3 +128,11 @@
 		reg = <1>;
 	};
 };
+
+&reg_arm {
+	vin-supply = <&sw1a_reg>;
+};
+
+&reg_soc {
+	vin-supply = <&sw1a_reg>;
+};
-- 
2.11.0
