From: nm@ti.com (Nishanth Menon)
Date: Thu, 14 Mar 2013 15:58:11 -0500
Subject: [PATCH 4/8] ARM: dts: OMAP443x: move CPU OPP tables to device tree
In-Reply-To: <1363294695-658-1-git-send-email-nm@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com>
Message-ID: <1363294695-658-5-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT OPP table for OMAP443x family of devices. This data is
decoded by OF with of_init_opp_table() helper function.

This is in preparation to use generic cpu0-cpufreq driver.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Beno?t Cousson" <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>
Cc: linux-omap at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: cpufreq at vger.kernel.org
Cc: linux-pm at vger.kernel.org

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi       |   10 ++++++++++
 arch/arm/mach-omap2/opp4xxx_data.c |    8 --------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 739bb79..08983a3 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -31,6 +31,16 @@
 		cpu at 0 {
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
+			/* OMAP4430 variants OPP50-OPPNT */
+			operating-points = <
+				/* kHz    uV */
+				300000  1025000
+				600000  1200000
+				800000  1313000
+				1008000 1375000
+			>;
+			clock-latency = <300000>; /* From omap-cpufreq driver */
+			voltage-tolerance = <2>; /* 2 % */
 		};
 		cpu at 1 {
 			compatible = "arm,cortex-a9";
diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index 1ef7a3e..478e2ee 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -65,14 +65,6 @@ struct omap_volt_data omap443x_vdd_core_volt_data[] = {
 
 
 static struct omap_opp_def __initdata omap443x_opp_def_list[] = {
-	/* MPU OPP1 - OPP50 */
-	OPP_INITIALIZER("mpu", true, 300000000, OMAP4430_VDD_MPU_OPP50_UV),
-	/* MPU OPP2 - OPP100 */
-	OPP_INITIALIZER("mpu", true, 600000000, OMAP4430_VDD_MPU_OPP100_UV),
-	/* MPU OPP3 - OPP-Turbo */
-	OPP_INITIALIZER("mpu", true, 800000000, OMAP4430_VDD_MPU_OPPTURBO_UV),
-	/* MPU OPP4 - OPP-SB */
-	OPP_INITIALIZER("mpu", true, 1008000000, OMAP4430_VDD_MPU_OPPNITRO_UV),
 	/* L3 OPP1 - OPP50 */
 	OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP4430_VDD_CORE_OPP50_UV),
 	/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
-- 
1.7.9.5
