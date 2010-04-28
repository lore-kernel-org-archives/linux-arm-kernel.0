From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 28 Apr 2010 17:46:48 +0200
Subject: [PATCH 4/5] drivers: mtd: onenand: add workaround for SYNC_WRITE mode
In-Reply-To: <1272469609-21876-1-git-send-email-m.szyprowski@samsung.com>
References: <1272469609-21876-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1272469609-21876-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Some chips fails to identify properly when SYNC_WRITE mode is enabled
(the example is OneNAND on S5PC110 SoC). This patch adds a workaround
for such chips.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mtd/onenand/onenand_base.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index 9827ab7..26caf25 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -3763,6 +3763,12 @@ static int onenand_probe(struct mtd_info *mtd)
 	/* Restore system configuration 1 */
 	this->write_word(syscfg, this->base + ONENAND_REG_SYS_CFG1);
 
+	/* Workaround */
+	if (syscfg & ONENAND_SYS_CFG1_SYNC_WRITE) {
+		bram_maf_id = this->read_word(this->base + ONENAND_REG_MANUFACTURER_ID);
+		bram_dev_id = this->read_word(this->base + ONENAND_REG_DEVICE_ID);
+	}
+
 	/* Check manufacturer ID */
 	if (onenand_check_maf(bram_maf_id))
 		return -ENXIO;
@@ -3782,6 +3788,9 @@ static int onenand_probe(struct mtd_info *mtd)
 	this->device_id = dev_id;
 	this->version_id = ver_id;
 
+	/* Check OneNAND features */
+	onenand_check_features(mtd);
+
 	density = onenand_get_density(dev_id);
 	if (FLEXONENAND(this)) {
 		this->dies = ONENAND_IS_DDP(this) ? 2 : 1;
@@ -3833,9 +3842,6 @@ static int onenand_probe(struct mtd_info *mtd)
 	else
 		mtd->size = this->chipsize;
 
-	/* Check OneNAND features */
-	onenand_check_features(mtd);
-
 	/*
 	 * We emulate the 4KiB page and 256KiB erase block size
 	 * But oobsize is still 64 bytes.
-- 
1.6.4
