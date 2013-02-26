From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 26 Feb 2013 11:30:41 -0600
Subject: [PATCH 14/14] ARM: OMAP2+: Convert ONENAND to retrieve GPMC settings
 from DT
In-Reply-To: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1361899842-30303-15-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting with device-tree, retrieve GPMC settings for ONENAND from
the device-tree blob. This will allow us to remove all static settings
stored in the gpmc-nand.c in the future once the migration to
device-tree is complete.

The user must now specify the ONENAND device width in the device-tree
binding so that the GPMC can be programmed correctly. Therefore, update
the device-tree binding documentation for ONENAND devices connected to
the GPMC to reflect this.

Please note that this does not include GPMC timings for ONENAND. The
timings are being calculated at runtime.

There is some legacy code that only enables read wait monitoring for
non-OMAP3 devices. There are no known OMAP3 device issues that prevent
this feature being enabled and so when booting with device-tree use the
wait-monitoring settings described in the device-tree blob.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 .../devicetree/bindings/mtd/gpmc-onenand.txt       |    3 +++
 arch/arm/mach-omap2/gpmc-onenand.c                 |   21 ++++++++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
index deec9da..b752942 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
@@ -10,6 +10,8 @@ Documentation/devicetree/bindings/bus/ti-gpmc.txt
 Required properties:
 
  - reg:			The CS line the peripheral is connected to
+ - gpmc,device-width	Width of the ONENAND device connected to the GPMC
+			in bytes. Must be 1 or 2.
 
 Optional properties:
 
@@ -34,6 +36,7 @@ Example for an OMAP3430 board:
 
 		onenand at 0 {
 			reg = <0 0 0>; /* CS0, offset 0 */
+			gpmc,device-width = <2>;
 
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index 1e2191c..ade8ca0 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -272,6 +272,10 @@ static int omap2_onenand_setup_async(void __iomem *onenand_base)
 	struct gpmc_timings t;
 	int ret;
 
+	if (gpmc_onenand_data->of_node)
+		gpmc_read_settings_dt(gpmc_onenand_data->of_node,
+				      &onenand_async);
+
 	omap2_onenand_set_async_mode(onenand_base);
 
 	omap2_onenand_calc_async_timings(&t);
@@ -300,12 +304,17 @@ static int omap2_onenand_setup_sync(void __iomem *onenand_base, int *freq_ptr)
 		set_onenand_cfg(onenand_base);
 	}
 
-	/*
-	 * FIXME: Appears to be legacy code from initial ONENAND commit.
-	 * Unclear what boards this is for and if this can be removed.
-	 */
-	if (!cpu_is_omap34xx())
-		onenand_sync.wait_on_read = true;
+	if (gpmc_onenand_data->of_node) {
+		gpmc_read_settings_dt(gpmc_onenand_data->of_node,
+				      &onenand_sync);
+	} else {
+		/*
+		 * FIXME: Appears to be legacy code from initial ONENAND commit.
+		 * Unclear what boards this is for and if this can be removed.
+		 */
+		if (!cpu_is_omap34xx())
+			onenand_sync.wait_on_read = true;
+	}
 
 	omap2_onenand_calc_sync_timings(&t, gpmc_onenand_data->flags, freq);
 
-- 
1.7.10.4
