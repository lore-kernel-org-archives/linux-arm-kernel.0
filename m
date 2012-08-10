From: b32955@freescale.com (Huang Shijie)
Date: Fri, 10 Aug 2012 11:18:57 +0800
Subject: [PATCH] mtd: gpmi: add NAND write verify support
Message-ID: <1344568737-902-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add NAND write verify support in gpmi-nand driver.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 8c0d2f0..6394483 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1488,6 +1488,22 @@ static int gpmi_set_geometry(struct gpmi_nand_data *this)
 	return gpmi_alloc_dma_buffer(this);
 }
 
+#define MAX_PAGESIZE 8192
+static uint8_t verify_buf[MAX_PAGESIZE];
+
+static int gpmi_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+{
+	struct nand_chip *nand = mtd->priv;
+	int ret;
+
+	ret = gpmi_ecc_read_page(mtd, nand, verify_buf, 0, 0);
+	if (ret)
+		return -EFAULT;
+	if (memcmp(buf, verify_buf, len))
+		return -EFAULT;
+	return 0;
+}
+
 static int gpmi_pre_bbt_scan(struct gpmi_nand_data  *this)
 {
 	int ret;
@@ -1556,6 +1572,7 @@ static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
 	chip->read_byte		= gpmi_read_byte;
 	chip->read_buf		= gpmi_read_buf;
 	chip->write_buf		= gpmi_write_buf;
+	chip->verify_buf	= gpmi_verify_buf;
 	chip->ecc.read_page	= gpmi_ecc_read_page;
 	chip->ecc.write_page	= gpmi_ecc_write_page;
 	chip->ecc.read_oob	= gpmi_ecc_read_oob;
-- 
1.7.0.4
