From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Tue, 20 Oct 2015 10:19:56 -0700
Subject: [PATCHv2] fpga: zynq-fpga: Change fw format to handle bin instead of
 bit.
In-Reply-To: <1445361596-12024-1-git-send-email-moritz.fischer@ettus.com>
References: <1445361596-12024-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1445361596-12024-2-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gets rid of the code to strip away the header and byteswap,
as well as the check for the sync word.

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
v2:
 - Removed early exit path in case synq seq is not found
---
 drivers/fpga/zynq-fpga.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 617d382..31db550 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -287,9 +287,9 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
 	struct zynq_fpga_priv *priv;
 	int err;
 	char *kbuf;
-	size_t i, in_count;
+	size_t in_count;
 	dma_addr_t dma_addr;
-	u32 transfer_length = 0;
+	u32 transfer_length;
 	u32 intr_status;
 
 	in_count = count;
@@ -301,26 +301,6 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr,
 
 	memcpy(kbuf, buf, count);
 
-	/* look for the sync word */
-	for (i = 0; i < count - 4; i++) {
-		if (memcmp(kbuf + i, "\xAA\x99\x55\x66", 4) == 0) {
-			dev_dbg(priv->dev, "Found swapped sync word\n");
-			break;
-		}
-	}
-
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
-	}
-
 	/* enable clock */
 	err = clk_enable(priv->clk);
 	if (err)
-- 
2.6.1
