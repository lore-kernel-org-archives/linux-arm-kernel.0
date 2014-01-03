From: b32955@freescale.com (Huang Shijie)
Date: Fri, 3 Jan 2014 11:01:41 +0800
Subject: [PATCH 2/3] mtd: gpmi: do not use the mtd->writesize
In-Reply-To: <a>
References: <a>
Message-ID: <1388718102-26097-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nfc_geo->payload_size is equal to the mtd->writesize now,
use the nfc_geo->payload_size to replace the mtd->writesize.

This patch makes preparation for the gpmi's subpage read support.
In the subpage support, the nfc_geo->payload_size maybe smaller then
the mtd->writesize.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 1908709..c92df74 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1010,7 +1010,7 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	int           ret;
 
 	dev_dbg(this->dev, "page number is : %d\n", page);
-	ret = read_page_prepare(this, buf, mtd->writesize,
+	ret = read_page_prepare(this, buf, nfc_geo->payload_size,
 					this->payload_virt, this->payload_phys,
 					nfc_geo->payload_size,
 					&payload_virt, &payload_phys);
@@ -1024,7 +1024,7 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 
 	/* go! */
 	ret = gpmi_read_page(this, payload_phys, auxiliary_phys);
-	read_page_end(this, buf, mtd->writesize,
+	read_page_end(this, buf, nfc_geo->payload_size,
 			this->payload_virt, this->payload_phys,
 			nfc_geo->payload_size,
 			payload_virt, payload_phys);
@@ -1079,7 +1079,7 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 		chip->oob_poi[0] = ((uint8_t *) auxiliary_virt)[0];
 	}
 
-	read_page_swap_end(this, buf, mtd->writesize,
+	read_page_swap_end(this, buf, nfc_geo->payload_size,
 			this->payload_virt, this->payload_phys,
 			nfc_geo->payload_size,
 			payload_virt, payload_phys);
-- 
1.7.2.rc3
