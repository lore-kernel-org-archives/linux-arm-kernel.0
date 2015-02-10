From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 10 Feb 2015 20:00:00 +0100
Subject: [PATCH 6/6] [RFC] mtd: mxc-nand: Warn on unimplemented commands
In-Reply-To: <1423594800-24214-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1423594800-24214-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1423594800-24214-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PARAM command was long unimplemented and it probably wasn't
noticed because chip probing using only the few bytes returned by the
READID command are good enough in most cases to determine the chip in
use.

Still to notice such a shortcoming earlier in the future would be nice
in case it's something more vital.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 0083b4ee4f33..372e0e38f59b 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1160,6 +1160,10 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 		memcpy32_fromio(host->data_buf, host->main_area0, 512);
 		host->buf_start = 0;
 		break;
+	default:
+		WARN_ONCE(1, "Unimplemented command (cmd=%u)\n",
+			  command);
+		break;
 	}
 }
 
-- 
2.1.4
