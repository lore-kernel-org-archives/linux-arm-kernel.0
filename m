From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:19:47 +0000
Subject: [RFC 30/47] mtd: nand: stm_nand_bch: read and write raw (FLEX)
In-Reply-To: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395735604-26706-31-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once the correct READ/WRITE(SEQIN) commands and address locations have
been sent to the Controller, these calls are able to read/write the
requested information from the FLEX_DATA register.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/stm_nand_bch.c | 77 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
index baecc40..4812431 100644
--- a/drivers/mtd/nand/stm_nand_bch.c
+++ b/drivers/mtd/nand/stm_nand_bch.c
@@ -537,6 +537,83 @@ static void flex_addr(struct nandi_controller *nandi,
 	writel(addr, nandi->base + NANDHAM_FLEX_ADD);
 }
 
+static int flex_read_raw(struct nandi_controller *nandi,
+			 uint32_t page_addr,
+			 uint32_t col_addr,
+			 uint8_t *buf, uint32_t len)
+{
+	dev_dbg(nandi->dev, "%s %u bytes at [0x%06x,0x%04x]\n",
+		__func__, len, page_addr, col_addr);
+
+	BUG_ON(len & 0x3);
+	BUG_ON((unsigned long)buf & 0x3);
+
+	emiss_nandi_select(STM_NANDI_HAMMING);
+	nandi_enable_interrupts(nandi, NAND_INT_RBN);
+	reinit_completion(&nandi->rbn_completed);
+
+	writel(FLEX_DATA_CFG_BEATS_4 | FLEX_DATA_CFG_CSN,
+	       nandi->base + NANDHAM_FLEX_DATAREAD_CONFIG);
+
+	flex_cmd(nandi, NAND_CMD_READ0);
+	flex_addr(nandi, col_addr, 2);
+	flex_addr(nandi, page_addr, nandi->extra_addr ? 3 : 2);
+	flex_cmd(nandi, NAND_CMD_READSTART);
+
+	flex_wait_rbn(nandi);
+
+	readsl(nandi->base + NANDHAM_FLEX_DATA, buf, len / 4);
+
+	nandi_disable_interrupts(nandi, NAND_INT_RBN);
+
+	writel(FLEX_DATA_CFG_BEATS_1 | FLEX_DATA_CFG_CSN,
+	       nandi->base + NANDHAM_FLEX_DATAREAD_CONFIG);
+
+	return 0;
+}
+
+static int flex_write_raw(struct nandi_controller *nandi,
+			  uint32_t page_addr,
+			  uint32_t col_addr,
+			  uint8_t *buf, uint32_t len)
+{
+	uint8_t status;
+
+	dev_dbg(nandi->dev, "%s %u bytes at [0x%06x,0x%04x]\n",
+		__func__, len, page_addr, col_addr);
+
+	BUG_ON(len & 0x3);
+	BUG_ON((unsigned long)buf & 0x3);
+
+	emiss_nandi_select(STM_NANDI_HAMMING);
+	nandi_enable_interrupts(nandi, NAND_INT_RBN);
+	reinit_completion(&nandi->rbn_completed);
+
+	writel(FLEX_DATA_CFG_BEATS_4 | FLEX_DATA_CFG_CSN,
+	       nandi->base + NANDHAM_FLEX_DATAWRITE_CONFIG);
+
+	flex_cmd(nandi, NAND_CMD_SEQIN);
+	flex_addr(nandi, col_addr, 2);
+	flex_addr(nandi, page_addr, nandi->extra_addr ? 3 : 2);
+
+	writesl(nandi->base + NANDHAM_FLEX_DATA, buf, len / 4);
+
+	flex_cmd(nandi, NAND_CMD_PAGEPROG);
+
+	flex_wait_rbn(nandi);
+
+	nandi_disable_interrupts(nandi, NAND_INT_RBN);
+
+	writel(FLEX_DATA_CFG_BEATS_1 | FLEX_DATA_CFG_CSN,
+	       nandi->base + NANDHAM_FLEX_DATAWRITE_CONFIG);
+
+	flex_cmd(nandi, NAND_CMD_STATUS);
+
+	status = (uint8_t)(readl(nandi->base + NANDHAM_FLEX_DATA) & 0xff);
+
+	return status;
+}
+
 /*
  * Bad Block Tables/Bad Block Markers
  */
-- 
1.8.3.2
