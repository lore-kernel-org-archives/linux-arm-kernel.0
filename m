From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 16 Nov 2015 14:37:53 +0100
Subject: [PATCH 20/27] cris: nand: remove useless mtd->priv = chip assignments
In-Reply-To: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1447681080-31232-21-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtd_to_nand_chip() now uses the container_of() approach to transform an
mtd_info pointer into a nand_chip one. Drop useless mtd->priv
assignments from NAND controller drivers.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Patch generated with the following coccinelle script:

---8<----
virtual patch

@@
struct mtd_info mtd;
struct mtd_info *mtdptr;
struct nand_chip *chipptr;
expression d;
@@
(
-(mtd).priv = (chipptr);
|
-(mtdptr)->priv = (chipptr);
---8<----
---
 arch/cris/arch-v32/drivers/mach-a3/nandflash.c | 3 ---
 arch/cris/arch-v32/drivers/mach-fs/nandflash.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
index ad78b97..2f65261 100644
--- a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
+++ b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
@@ -149,9 +149,6 @@ struct mtd_info *__init crisv32_nand_flash_probe(void)
 	this = &wrapper->chip;
 	crisv32_mtd = nand_to_mtd(&wrapper->chip);
 
-	/* Link the private data with the MTD structure */
-	crisv32_mtd->priv = this;
-
 	/* Set address of NAND IO lines */
 	this->IO_ADDR_R = read_cs;
 	this->IO_ADDR_W = write_cs;
diff --git a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
index 00a277b..4ab9d4e 100644
--- a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
+++ b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
@@ -140,9 +140,6 @@ struct mtd_info *__init crisv32_nand_flash_probe(void)
 	bif_cfg.gated_csp1 = regk_bif_core_wr;
 	REG_WR(bif_core, regi_bif_core, rw_grp3_cfg, bif_cfg);
 
-	/* Link the private data with the MTD structure */
-	crisv32_mtd->priv = this;
-
 	/* Set address of NAND IO lines */
 	this->IO_ADDR_R = read_cs;
 	this->IO_ADDR_W = write_cs;
-- 
2.1.4
