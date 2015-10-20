From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Mon, 19 Oct 2015 17:01:59 -0700
Subject: [PATCH] fpga: zynq-fpga: Change fw format to handle bin instead of
 bit.
In-Reply-To: <1445299319-14921-1-git-send-email-moritz.fischer@ettus.com>
References: <1445299319-14921-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1445299319-14921-2-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gets rid of the code to strip away the header and byteswap.

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 drivers/fpga/zynq-fpga.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 617d382..916c551 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -104,6 +104,8 @@
 #define INIT_POLL_TIMEOUT		2500000
 /* Delay for polling reset bits */
 #define INIT_POLL_DELAY			20
+/* Sync sequence for firmware */
+#define SYNC_SEQUENCE			"\x66\x55\x99\xAA"
 
 /* Masks for controlling stuff in SLCR */
 /* Disable all Level shifters */
@@ -301,24 +303,19 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
 
 	memcpy(kbuf, buf, count);
 
-	/* look for the sync word */
+	/* look for the sync sequence */
 	for (i = 0; i < count - 4; i++) {
-		if (memcmp(kbuf + i, "\xAA\x99\x55\x66", 4) == 0) {
-			dev_dbg(priv->dev, "Found swapped sync word\n");
+		if (memcmp(kbuf + i, SYNC_SEQUENCE, 4) == 0) {
+			dev_dbg(priv->dev, "Found sync sequence");
 			break;
 		}
 	}
 
-	/* remove the header, align the data on word boundary */
-	if (i != count - 4) {
-		count -= i;
-		memmove(kbuf, kbuf + i, count);
-	}
-
-	/* fixup endianness of the data */
-	for (i = 0; i < count; i += 4) {
-		u32 *p = (u32 *)&kbuf[i];
-		*p = swab32(*p);
+	/* if we detect something obviously broken, bail ... */
+	if ((count - 4) == i) {
+		dev_err(priv->dev, "No sync sequence found, invalid bitstream.");
+		err = -EINVAL;
+		goto out_free;
 	}
 
 	/* enable clock */
-- 
2.6.1
