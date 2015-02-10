From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 10 Feb 2015 19:59:59 +0100
Subject: [PATCH 5/6] mtd: mxc-nand: Implement support for PARAM command
In-Reply-To: <1423594800-24214-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423594800-24214-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1423594800-24214-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxc-nand driver never supported the PARAM command to read out the
ONFI parameter page and so always relied on probing my manufacturer and
device id (as provided by the READID command).

This patch implements reading out the first parameter page copy at least
which should be good enough in practise.

This makes the boot log change from

	nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xb1
	nand: Micron NAND 128MiB 1,8V 16-bit

to
	nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xb1
	nand: Micron MT29F1G16ABBDAH4

on my machine.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 0afe5904a337..0083b4ee4f33 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1153,6 +1153,13 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 		mxc_do_addr_cycle(mtd, column, page_addr);
 
 		break;
+	case NAND_CMD_PARAM:
+		host->devtype_data->send_cmd(host, command, false);
+		mxc_do_addr_cycle(mtd, column, page_addr);
+		host->devtype_data->send_page(mtd, NFC_OUTPUT);
+		memcpy32_fromio(host->data_buf, host->main_area0, 512);
+		host->buf_start = 0;
+		break;
 	}
 }
 
-- 
2.1.4
