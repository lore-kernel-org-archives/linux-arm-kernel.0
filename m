From: john.ogness@linutronix.de (John Ogness)
Date: Fri, 18 Jun 2010 18:59:47 +0200
Subject: [PATCH 1/5] mtd: mxc_nand fixups
Message-ID: <80hbl0b7jw.fsf@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch avoids byte access to the NFC buffer. Byte access to the
NFC is not allowed.

The patch is against linux-next 20100618.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: linux-next-20100618/drivers/mtd/nand/mxc_nand.c
===================================================================
--- linux-next-20100618.orig/drivers/mtd/nand/mxc_nand.c
+++ linux-next-20100618/drivers/mtd/nand/mxc_nand.c
@@ -289,16 +289,16 @@ static void send_read_id(struct mxc_nand
 	/* Wait for operation to complete */
 	wait_op_done(host, true);
 
+	memcpy(host->data_buf, host->main_area0, 16);
+
 	if (this->options & NAND_BUSWIDTH_16) {
-		void __iomem *main_buf = host->main_area0;
 		/* compress the ID info */
-		writeb(readb(main_buf + 2), main_buf + 1);
-		writeb(readb(main_buf + 4), main_buf + 2);
-		writeb(readb(main_buf + 6), main_buf + 3);
-		writeb(readb(main_buf + 8), main_buf + 4);
-		writeb(readb(main_buf + 10), main_buf + 5);
+		host->data_buf[1] = host->data_buf[2];
+		host->data_buf[2] = host->data_buf[4];
+		host->data_buf[3] = host->data_buf[6];
+		host->data_buf[4] = host->data_buf[8];
+		host->data_buf[5] = host->data_buf[10];
 	}
-	memcpy(host->data_buf, host->main_area0, 16);
 }
 
 /* This function requests the NANDFC to perform a read of the
