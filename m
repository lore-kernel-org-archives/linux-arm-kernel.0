From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:32 +0100
Subject: [PATCH v4 48/58] cris: nand: use the mtd instance embedded in struct
 nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-49-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device. Patch all drivers to make use
of this mtd instance instead of using the instance embedded in their
private struct or dynamically allocated.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Most of those changes were generated with the coccinelle script added
in commit c671312 "coccinelle: nand: detect and correct drivers embedding
an mtd_info object"
---
 arch/cris/arch-v32/drivers/mach-a3/nandflash.c | 3 +--
 arch/cris/arch-v32/drivers/mach-fs/nandflash.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
index db953cf..ee74e45 100644
--- a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
+++ b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
@@ -36,7 +36,6 @@
 #define CE_BIT 12
 
 struct mtd_info_wrapper {
-	struct mtd_info info;
 	struct nand_chip chip;
 };
 
@@ -148,7 +147,7 @@ struct mtd_info *__init crisv32_nand_flash_probe(void)
 
 	/* Get pointer to private data */
 	this = &wrapper->chip;
-	crisv32_mtd = &wrapper->info;
+	crisv32_mtd = nand_to_mtd(this);
 
 	/* Link the private data with the MTD structure */
 	crisv32_mtd->priv = this;
diff --git a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
index 22a6467..5626297 100644
--- a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
+++ b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
@@ -31,7 +31,6 @@
 #define BY_BIT 7
 
 struct mtd_info_wrapper {
-	struct mtd_info info;
 	struct nand_chip chip;
 };
 
@@ -129,7 +128,7 @@ struct mtd_info *__init crisv32_nand_flash_probe(void)
 
 	/* Get pointer to private data */
 	this = &wrapper->chip;
-	crisv32_mtd = &wrapper->info;
+	crisv32_mtd = nand_to_mtd(this);
 
 	pa_oe.oe |= 1 << CE_BIT;
 	pa_oe.oe |= 1 << ALE_BIT;
-- 
2.1.4
