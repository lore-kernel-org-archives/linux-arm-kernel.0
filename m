From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:19:46 +0000
Subject: [RFC 29/47] mtd: nand: stm_nand_bch: add Hamming-FLEX operations
In-Reply-To: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395735604-26706-30-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Including; a check for Ready/NotBusy (RBn) (i.e. wait for current
operation to finish and a method to issue Flex commands to the
controller.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/stm_nand_bch.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
index a4f3e46..baecc40 100644
--- a/drivers/mtd/nand/stm_nand_bch.c
+++ b/drivers/mtd/nand/stm_nand_bch.c
@@ -502,6 +502,42 @@ static uint8_t bch_write_page(struct nandi_controller *nandi,
 }
 
 /*
+ * Hamming-FLEX operations
+ */
+static int flex_wait_rbn(struct nandi_controller *nandi)
+{
+	int ret;
+
+	ret = wait_for_completion_timeout(&nandi->rbn_completed, HZ/2);
+	if (!ret)
+		dev_err(nandi->dev, "FLEX RBn timeout\n");
+
+	return ret;
+}
+
+static void flex_cmd(struct nandi_controller *nandi, uint8_t cmd)
+{
+	uint32_t val;
+
+	val = (FLEX_CMD_CSN | FLEX_CMD_BEATS_1 | cmd);
+	writel(val, nandi->base + NANDHAM_FLEX_CMD);
+}
+
+static void flex_addr(struct nandi_controller *nandi,
+		      uint32_t addr, int cycles)
+{
+	addr &= 0x00ffffff;
+
+	BUG_ON(cycles < 1);
+	BUG_ON(cycles > 3);
+
+	addr |= (FLEX_ADDR_CSN | FLEX_ADDR_ADD8_VALID);
+	addr |= (cycles & 0x3) << 28;
+
+	writel(addr, nandi->base + NANDHAM_FLEX_ADD);
+}
+
+/*
  * Bad Block Tables/Bad Block Markers
  */
 #define BBT_MARK_BAD_FACTORY	0x0
-- 
1.8.3.2
