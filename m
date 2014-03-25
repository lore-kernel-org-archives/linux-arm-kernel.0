From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:19:43 +0000
Subject: [RFC 26/47] mtd: nand: stm_nand_bch: populate IBBT BCH Header
In-Reply-To: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395735604-26706-27-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The STM NAND BCH Controller driver has extended the IBBT header with
some extra convenience properties. This function populates both those
and the standard header specified by 'struct nand_ibbt_header'.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/stm_nand_bch.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
index e1c71be..2d03113 100644
--- a/drivers/mtd/nand/stm_nand_bch.c
+++ b/drivers/mtd/nand/stm_nand_bch.c
@@ -26,6 +26,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/stm_nand.h>
 #include <linux/mtd/partitions.h>
+#include <generated/utsrelease.h>
 
 #include "stm_nand_regs.h"
 #include "stm_nand_dt.h"
@@ -524,6 +525,22 @@ static int bbt_is_block_bad(uint8_t *bbt, uint32_t block)
 	return bbt_get_block_mark(bbt, block) == BBT_MARK_GOOD ? 0 : 1;
 }
 
+/* Populate IBBT BCH Header */
+static void bch_fill_ibbt_header(struct nandi_controller *nandi,
+				 struct nand_ibbt_bch_header *ibbt_header,
+				 int bak, uint8_t vers)
+{
+	const char author[] = "STLinux " UTS_RELEASE " (stm-nand-bch)";
+
+	memcpy(ibbt_header->base.signature, ibbt_sigs[bak], NAND_IBBT_SIGLEN);
+	ibbt_header->base.version = vers;
+	memset(ibbt_header->base.schema, NAND_IBBT_SCHEMA, 4);
+
+	memset(ibbt_header->schema, NAND_IBBT_SCHEMA, 4);
+	memset(ibbt_header->ecc_size, bch_ecc_sizes[nandi->bch_ecc_mode], 4);
+	memcpy(ibbt_header->author, author, sizeof(author));
+}
+
 /* Scan block for IBBT signature */
 static int bch_find_ibbt_sig(struct nandi_controller *nandi,
 			     uint32_t block, int *bak, uint8_t *vers,
-- 
1.8.3.2
