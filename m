From: stillcompiling@gmail.com (Joshua Clayton)
Date: Fri,  9 Jun 2017 15:39:39 -0700
Subject: [PATCH v13 6/6] fpga-manager: altera-ps-spi: use bitrev8x4
In-Reply-To: <03e591707dc72f4c2b5e63a1272060956294ea51.1497047816.git.stillcompiling@gmail.com>
References: <03e591707dc72f4c2b5e63a1272060956294ea51.1497047816.git.stillcompiling@gmail.com>
Message-ID: <133de0a3543747b6784c50ffe7d78e76639f1167.1497047816.git.stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Speed up bit reversal by using hardware bit reversal
Add extra code to handle less than 4byte remnants, if any

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/fpga/altera-ps-spi.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 0db8def668ed..14f14efdf0d5 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -149,12 +149,23 @@ static int altera_ps_write_init(struct fpga_manager *mgr,
 
 static void rev_buf(char *buf, size_t len)
 {
-	const char *fw_end = (buf + len);
+	u32 *fw32 = (u32 *)buf;
+	size_t extra_bytes = (len & 0x03);
+	const u32 *fw_end = (u32 *)(buf + len - extra_bytes);
 
 	/* set buffer to lsb first */
-	while (buf < fw_end) {
-		*buf = bitrev8(*buf);
-		buf++;
+	while (fw32 < fw_end) {
+		*fw32 = bitrev8x4(*fw32);
+		fw32++;
+	}
+
+	if (extra_bytes) {
+		buf = (char *)fw_end;
+		while (extra_bytes) {
+			*buf = bitrev8(*buf);
+			buf++;
+			extra_bytes--;
+		}
 	}
 }
 
-- 
2.11.0
