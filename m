From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 25 May 2017 10:29:11 -0700
Subject: [PATCH v11 6/6] fpga-manager: altera-ps-spi: use bitrev8x4
In-Reply-To: <20170525172911.11467-1-stillcompiling@gmail.com>
References: <20170525172911.11467-1-stillcompiling@gmail.com>
Message-ID: <20170525172911.11467-7-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Speed up bit reversal by using hardware bit reversal
Add extra code to handle less than 4byte remnants, if any

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/fpga/altera-ps-spi.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 9e90f8086cd5..baddead15476 100644
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
