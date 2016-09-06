From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue,  6 Sep 2016 12:39:14 +0200
Subject: [PATCH 6/7] mtd: nand: mxc: implement onfi get/set features
In-Reply-To: <1473158355-22451-1-git-send-email-s.hauer@pengutronix.de>
References: <1473158355-22451-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1473158355-22451-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be able to support different ONFI timing modes we have to implement
the onfi_set_features and onfi_get_features. Tested on an i.MX25 SoC.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 5173fad..1db8299 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1239,6 +1239,57 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 	}
 }
 
+static int mxc_nand_onfi_set_features(struct mtd_info *mtd, struct nand_chip *chip,
+			int addr, uint8_t *subfeature_param)
+{
+	struct nand_chip *nand_chip = mtd_to_nand(mtd);
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
+	int i;
+
+	if (!chip->onfi_version ||
+	    !(le16_to_cpu(chip->onfi_params.opt_cmd)
+	      & ONFI_OPT_CMD_SET_GET_FEATURES))
+		return -EINVAL;
+
+	host->buf_start = 0;
+
+	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
+		chip->write_byte(mtd, subfeature_param[i]);
+
+	memcpy32_toio(host->main_area0, host->data_buf, mtd->writesize);
+	host->devtype_data->send_cmd(host, NAND_CMD_SET_FEATURES, false);
+	mxc_do_addr_cycle(mtd, addr, -1);
+	host->devtype_data->send_page(mtd, NFC_INPUT);
+
+	return 0;
+}
+
+static int mxc_nand_onfi_get_features(struct mtd_info *mtd, struct nand_chip *chip,
+			int addr, uint8_t *subfeature_param)
+{
+	struct nand_chip *nand_chip = mtd_to_nand(mtd);
+	struct mxc_nand_host *host = nand_get_controller_data(nand_chip);
+	int i;
+
+	if (!chip->onfi_version ||
+	    !(le16_to_cpu(chip->onfi_params.opt_cmd)
+	      & ONFI_OPT_CMD_SET_GET_FEATURES))
+		return -EINVAL;
+
+	*(uint32_t *)host->main_area0 = 0xdeadbeef;
+
+	host->devtype_data->send_cmd(host, NAND_CMD_GET_FEATURES, false);
+	mxc_do_addr_cycle(mtd, addr, -1);
+	host->devtype_data->send_page(mtd, NFC_OUTPUT);
+	memcpy32_fromio(host->data_buf, host->main_area0, 512);
+	host->buf_start = 0;
+
+	for (i = 0; i < ONFI_SUBFEATURE_PARAM_LEN; ++i)
+		*subfeature_param++ = chip->read_byte(mtd);
+
+	return 0;
+}
+
 /*
  * The generic flash bbt decriptors overlap with our ecc
  * hardware, so define some i.MX specific ones.
@@ -1513,6 +1564,8 @@ static int mxcnd_probe(struct platform_device *pdev)
 	this->read_word = mxc_nand_read_word;
 	this->write_buf = mxc_nand_write_buf;
 	this->read_buf = mxc_nand_read_buf;
+	this->onfi_set_features = mxc_nand_onfi_set_features;
+	this->onfi_get_features = mxc_nand_onfi_get_features;
 
 	host->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(host->clk))
-- 
2.8.1
