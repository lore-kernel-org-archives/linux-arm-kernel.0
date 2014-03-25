From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:19:55 +0000
Subject: [RFC 38/47] mtd: nand: stm_nand_bch: check WP (FLEX)
In-Reply-To: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395735604-26706-39-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return status of the Write Protect bit for the NAND device.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/stm_nand_bch.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
index 3853e7a..18601e5 100644
--- a/drivers/mtd/nand/stm_nand_bch.c
+++ b/drivers/mtd/nand/stm_nand_bch.c
@@ -543,6 +543,22 @@ static void flex_addr(struct nandi_controller *nandi,
 	writel(addr, nandi->base + NANDHAM_FLEX_ADD);
 }
 
+/*
+ * Hamming-FLEX operations (optimised replacements for nand_base.c versions)
+ */
+static int flex_check_wp(struct nandi_controller *nandi)
+{
+	uint8_t status;
+
+	emiss_nandi_select(STM_NANDI_HAMMING);
+
+	flex_cmd(nandi, NAND_CMD_STATUS);
+
+	status = (uint8_t)(readl(nandi->base + NANDHAM_FLEX_DATA) & 0xff);
+
+	return status & NAND_STATUS_WP ? 0 : 1;
+}
+
 static int flex_read_raw(struct nandi_controller *nandi,
 			 uint32_t page_addr,
 			 uint32_t col_addr,
-- 
1.8.3.2
