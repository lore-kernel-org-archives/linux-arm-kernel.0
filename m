From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 8 Oct 2012 11:07:46 +0530
Subject: [PATCH v2 10/14] ARM: OMAP2+: nand: bch capability check
In-Reply-To: <cover.1349672877.git.afzal@ti.com>
References: <cover.1349672877.git.afzal@ti.com>
Message-ID: <9575950c712e397fa9ddca535d167e6c77e1934d.1349672877.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Capability of bch schemes could be discovered using soc
revision checks. If soc revision indicates that selected
ecc scheme is not supported bail out.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index c1b9b1d..7983d54 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -90,6 +90,27 @@ static int omap2_nand_gpmc_retime(
 	return 0;
 }
 
+static bool __init gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
+{
+	/* support only OMAP3 class */
+	if (!cpu_is_omap34xx()) {
+		pr_err("BCH ecc is not supported on this CPU\n");
+		return 0;
+	}
+
+	/*
+	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1.
+	 * Other chips may be added if confirmed to work.
+	 */
+	if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW) &&
+	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0))) {
+		pr_err("BCH 4-bit mode is not supported on this CPU\n");
+		return 0;
+	}
+
+	return 1;
+}
+
 int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 			  struct gpmc_timings *gpmc_t)
 {
@@ -128,6 +149,9 @@ int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 
 	gpmc_update_nand_reg(&gpmc_nand_data->reg, gpmc_nand_data->cs);
 
+	if (!gpmc_hwecc_bch_capable(gpmc_nand_data->ecc_opt))
+		return -EINVAL;
+
 	err = platform_device_register(&gpmc_nand_device);
 	if (err < 0) {
 		dev_err(dev, "Unable to register NAND device\n");
-- 
1.7.12
