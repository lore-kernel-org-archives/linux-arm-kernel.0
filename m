From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu,  1 Mar 2018 00:37:02 +0100
Subject: [PATCH] arm: mmp: Fix build issue due to PXA NAND pdata structure
 changes
Message-ID: <20180228233702.20378-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A previous work removed a few useless fields in PXA NAND platform data.
Changes have been reflected in all impacted files but the ones in the
mach-mpp directory. Update these file to fix build issues like:

    arch/arm/mach-mmp/aspenite.c:175:3:
    error: 'struct pxa3xx_nand_platform_data' has no member
    named 'enable_arbiter'

Fixes: 6e836cc71870 ("mtd: nand: remove useless fields from pxa3xx NAND platform data")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Hello,

This patch should fix the build issue raised today in linux-next, sorry
for not spotting it earlier.

The commit producing the build error with MMP files was introduced by
myself in the MTD tree. Boris, the MTD maintainer for this release, is
in copy. I don't know who should take the patch but it would probably be
better to fix the build issue from the MTD tree also?

Thank you,
Miqu?l


 arch/arm/mach-mmp/aspenite.c | 6 ++----
 arch/arm/mach-mmp/ttc_dkb.c  | 5 +----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index d2283009a5ff..6c2ebf01893a 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -172,10 +172,8 @@ static struct mtd_partition aspenite_nand_partitions[] = {
 };
 
 static struct pxa3xx_nand_platform_data aspenite_nand_info = {
-	.enable_arbiter	= 1,
-	.num_cs = 1,
-	.parts[0]	= aspenite_nand_partitions,
-	.nr_parts[0]	= ARRAY_SIZE(aspenite_nand_partitions),
+	.parts		= aspenite_nand_partitions,
+	.nr_parts	= ARRAY_SIZE(aspenite_nand_partitions),
 };
 
 static struct i2c_board_info aspenite_i2c_info[] __initdata = {
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index e0b6073c61a7..c7897fb2b6da 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -179,10 +179,7 @@ static struct mv_usb_platform_data ttc_usb_pdata = {
 #endif
 
 #if IS_ENABLED(CONFIG_MTD_NAND_MARVELL)
-static struct pxa3xx_nand_platform_data dkb_nand_info = {
-	.enable_arbiter = 1,
-	.num_cs = 1,
-};
+static struct pxa3xx_nand_platform_data dkb_nand_info = {};
 #endif
 
 #if IS_ENABLED(CONFIG_MMP_DISP)
-- 
2.14.1
