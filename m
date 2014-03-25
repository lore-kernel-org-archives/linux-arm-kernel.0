From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:19:39 +0000
Subject: [RFC 22/47] mtd: nand: stm_nand_bch: check erased page for zeros
In-Reply-To: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395735604-26706-23-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Detect an erased page, tolerating and correcting up to a specified number
of bits at '0'. Downgrade uncorrectable ECC error for an erased page,
tolerating 'sectors_per_page' bits at '0'.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/stm_nand_bch.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
index 2042cdd..7874d85 100644
--- a/drivers/mtd/nand/stm_nand_bch.c
+++ b/drivers/mtd/nand/stm_nand_bch.c
@@ -319,6 +319,33 @@ static uint8_t bch_erase_block(struct nandi_controller *nandi,
 }
 
 /*
+ * Detect an erased page, tolerating and correcting up to a specified number of
+ * bits at '0'.  (For many devices, it is now deemed within spec for an erased
+ * page to include a number of bits at '0', either as a result of read-disturb
+ * behaviour or 'stuck-at-zero' failures.)  Returns the number of corrected
+ * bits, or a '-1' if we have exceeded the maximum number of bits at '0' (likely
+ * to be a genuine uncorrectable ECC error).  In the latter case, the data must
+ * be returned unmodified, in accordance with the MTD API.
+ */
+static int check_erased_page(uint8_t *data, uint32_t page_size, int max_zeros)
+{
+	uint8_t *b = data;
+	int zeros = 0;
+	int i;
+
+	for (i = 0; i < page_size; i++) {
+		zeros += hweight8(~*b++);
+		if (zeros > max_zeros)
+			return -1;
+	}
+
+	if (zeros)
+		memset(data, 0xff, page_size);
+
+	return zeros;
+}
+
+/*
  * Initialisation
  */
 static int bch_check_compatibility(struct nandi_controller *nandi,
-- 
1.8.3.2
