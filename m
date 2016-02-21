From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 21 Feb 2016 13:52:06 +0100
Subject: [PATCH RESEND] gpmi-nand: Handle ECC Errors in erased pages
Message-ID: <1456059126-25469-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ECC is only calculated for written pages. As erased pages are not
actively written the ECC is always invalid. For this purpose the
Hardware BCH unit is able to check for erased pages and does not raise
an ECC error in this case. This behaviour can be influenced using the
BCH_MODE register which sets the number of allowed bitflips in an erased
page. Unfortunately the unit is not capable of fixing the bitflips in
memory.

To avoid complete software checks for erased pages, we can simply check
buffers with uncorrectable ECC errors because we know that any erased
page with errors is uncorrectable by the BCH unit.

This patch adds the generic nand_check_erased_ecc_chunk() to gpmi-nand
to correct erased pages. To have the valid data in the buffer before
using them, this patch moves the read_page_swap_end() call before the
ECC status checking for-loop.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 49 ++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 235ddcb58f39..ce5a21252102 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1035,14 +1035,58 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	/* Loop over status bytes, accumulating ECC status. */
 	status = auxiliary_virt + nfc_geo->auxiliary_status_offset;
 
+	read_page_swap_end(this, buf, nfc_geo->payload_size,
+			   this->payload_virt, this->payload_phys,
+			   nfc_geo->payload_size,
+			   payload_virt, payload_phys);
+
 	for (i = 0; i < nfc_geo->ecc_chunk_count; i++, status++) {
 		if ((*status == STATUS_GOOD) || (*status == STATUS_ERASED))
 			continue;
 
 		if (*status == STATUS_UNCORRECTABLE) {
+			int flips;
+
+			/*
+			 * The ECC hardware has an uncorrectable ECC status
+			 * code in case we have bitflips in an erased page. As
+			 * nothing was written into this subpage the ECC is
+			 * obviously wrong and we can not trust it. We assume
+			 * at this point that we are reading an erased page and
+			 * try to correct the bitflips in buffer up to
+			 * ecc_strength bitflips. If this is a page with random
+			 * data, we exceed this number of bitflips and have a
+			 * ECC failure. Otherwise we use the corrected buffer.
+			 */
+			if (i == 0) {
+				/* The first block includes metadata */
+				flips = nand_check_erased_ecc_chunk(
+						buf + i * nfc_geo->ecc_chunk_size,
+						nfc_geo->ecc_chunk_size,
+						NULL, 0,
+						auxiliary_virt,
+						nfc_geo->metadata_size,
+						nfc_geo->ecc_strength);
+			} else {
+				flips = nand_check_erased_ecc_chunk(
+						buf + i * nfc_geo->ecc_chunk_size,
+						nfc_geo->ecc_chunk_size,
+						NULL, 0,
+						NULL, 0,
+						nfc_geo->ecc_strength);
+			}
+
+			if (flips > 0) {
+				max_bitflips = max_t(unsigned int, max_bitflips,
+						     flips);
+				mtd->ecc_stats.corrected += flips;
+				continue;
+			}
+
 			mtd->ecc_stats.failed++;
 			continue;
 		}
+
 		mtd->ecc_stats.corrected += *status;
 		max_bitflips = max_t(unsigned int, max_bitflips, *status);
 	}
@@ -1062,11 +1106,6 @@ static int gpmi_ecc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 		chip->oob_poi[0] = ((uint8_t *) auxiliary_virt)[0];
 	}
 
-	read_page_swap_end(this, buf, nfc_geo->payload_size,
-			this->payload_virt, this->payload_phys,
-			nfc_geo->payload_size,
-			payload_virt, payload_phys);
-
 	return max_bitflips;
 }
 
-- 
2.7.0
