From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  1 Dec 2015 12:03:15 +0100
Subject: [PATCH v2 18/25] cris: nand: remove useless mtd->priv = chip
 assignments
In-Reply-To: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1448967802-25796-19-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtd_to_nand() now uses the container_of() approach to transform an
mtd_info pointer into a nand_chip one. Drop useless mtd->priv
assignments from NAND controller drivers.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Patch generated with the following coccinelle script:

---8<----
virtual patch

@@
struct mtd_info m;
struct mtd_info *mp;
struct nand_chip *c;
@@
(
-(m).priv = c;
|
-(mp)->priv = c;
|
-(mp)->priv = (void *)c;
)
---8<----
---
 arch/cris/arch-v32/drivers/mach-a3/nandflash.c | 3 ---
 arch/cris/arch-v32/drivers/mach-fs/nandflash.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
index ee74e45..5aa3f51 100644
--- a/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
+++ b/arch/cris/arch-v32/drivers/mach-a3/nandflash.c
@@ -149,9 +149,6 @@ struct mtd_info *__init crisv32_nand_flash_probe(void)
 	this = &wrapper->chip;
 	crisv32_mtd = nand_to_mtd(this);
 
-	/* Link the private data with the MTD structure */
-	crisv32_mtd->priv = this;
-
 	/* Set address of NAND IO lines */
 	this->IO_ADDR_R = read_cs;
 	this->IO_ADDR_W = write_cs;
diff --git a/arch/cris/arch-v32/drivers/mach-fs/nandflash.c b/arch/cris/arch-v32/drivers/mach-fs/nandflash.c
index 5626297..a7c17b0 100644
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
