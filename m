From: nm@ti.com (Nishanth Menon)
Date: Thu, 14 Mar 2013 15:58:08 -0500
Subject: [PATCH 1/8] ARM: dts: OMAP34xx: move CPU OPP tables to device tree
In-Reply-To: <1363294695-658-1-git-send-email-nm@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com>
Message-ID: <1363294695-658-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT OPP table for OMAP34xx family of devices. This data is
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
 arch/arm/boot/dts/omap3.dtsi       |   10 ++++++++++
 arch/arm/mach-omap2/opp3xxx_data.c |   11 -----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..9a15066 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -23,6 +23,16 @@
 	cpus {
 		cpu at 0 {
 			compatible = "arm,cortex-a8";
+			/* OMAP3430 variants OPP1-5 */
+			operating-points = <
+				/* kHz    uV */
+				125000   975000
+				250000  1075000
+				500000  1200000
+				550000  1270000
+				600000  1350000
+			>;
+			clock-latency = <300000>; /* From legacy driver */
 		};
 	};
 
diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
index fc67add..1de18c2 100644
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -87,17 +87,6 @@ struct omap_volt_data omap36xx_vddcore_volt_data[] = {
 /* OPP data */
 
 static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
-	/* MPU OPP1 */
-	OPP_INITIALIZER("mpu", true, 125000000, OMAP3430_VDD_MPU_OPP1_UV),
-	/* MPU OPP2 */
-	OPP_INITIALIZER("mpu", true, 250000000, OMAP3430_VDD_MPU_OPP2_UV),
-	/* MPU OPP3 */
-	OPP_INITIALIZER("mpu", true, 500000000, OMAP3430_VDD_MPU_OPP3_UV),
-	/* MPU OPP4 */
-	OPP_INITIALIZER("mpu", true, 550000000, OMAP3430_VDD_MPU_OPP4_UV),
-	/* MPU OPP5 */
-	OPP_INITIALIZER("mpu", true, 600000000, OMAP3430_VDD_MPU_OPP5_UV),
-
 	/*
 	 * L3 OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
 	 * almost the same than the one at 83MHz thus providing very little
-- 
1.7.9.5
