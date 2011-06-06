From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon,  6 Jun 2011 18:04:15 +0400
Subject: [PATCH 2/3] ts72xx: use MTDPART_OFS_RETAIN for mtd partitioning
In-Reply-To: <1307369056-29319-1-git-send-email-dbaryshkov@gmail.com>
References: <1307369056-29319-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1307369056-29319-3-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of specifying a callback for dynamic partitioning, use
MTDPART_OFS_RETAIN for reserving a place near the end of flash for
RedBoot.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <ryan@bluewatersys.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-ep93xx/ts72xx.c |   23 +++++------------------
 1 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index c2d2cf4..dea42e2 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -116,8 +116,9 @@ static struct mtd_partition ts72xx_nand_parts[] = {
 		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
 	}, {
 		.name		= "Linux",
-		.offset		= MTDPART_OFS_APPEND,
-		.size		= 0,			/* filled in later */
+		.offset		= MTDPART_OFS_RETAIN,
+		.size		= TS72XX_REDBOOT_PART_SIZE,
+				/* leave so much for last partition */
 	}, {
 		.name		= "RedBoot",
 		.offset		= MTDPART_OFS_APPEND,
@@ -126,28 +127,14 @@ static struct mtd_partition ts72xx_nand_parts[] = {
 	},
 };
 
-static void ts72xx_nand_set_parts(uint64_t size,
-				  struct platform_nand_chip *chip)
-{
-	/* Factory TS-72xx boards only come with 32MiB or 128MiB NAND options */
-	if (size == SZ_32M || size == SZ_128M) {
-		/* Set the "Linux" partition size */
-		ts72xx_nand_parts[1].size = size - TS72XX_REDBOOT_PART_SIZE;
-
-		chip->partitions = ts72xx_nand_parts;
-		chip->nr_partitions = ARRAY_SIZE(ts72xx_nand_parts);
-	} else {
-		pr_warning("Unknown nand disk size:%lluMiB\n", size >> 20);
-	}
-}
-
 static struct platform_nand_data ts72xx_nand_data = {
 	.chip = {
 		.nr_chips	= 1,
 		.chip_offset	= 0,
 		.chip_delay	= 15,
 		.part_probe_types = ts72xx_nand_part_probes,
-		.set_parts	= ts72xx_nand_set_parts,
+		.partitions	= ts72xx_nand_parts,
+		.nr_partitions	= ARRAY_SIZE(ts72xx_nand_parts),
 	},
 	.ctrl = {
 		.cmd_ctrl	= ts72xx_nand_hwcontrol,
-- 
1.7.4.4
