From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 12 Nov 2012 16:52:37 +0800
Subject: [PATCH 17/17] mtd: m25p80: change the m25p80_read to reading page to
 page
In-Reply-To: <1352710357-3265-1-git-send-email-wenyou.yang@atmel.com>
References: <1352710357-3265-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1352710357-3265-18-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When run "flashcp /bin/busybox /dev/mtdX", it arised a OOPS. changing to fix the [BUG].

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: dwmw2 at infradead.org
Cc: linux-mtd at lists.infradead.org
---
 drivers/mtd/devices/m25p80.c |   44 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 03838ba..73e5fea 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -340,6 +340,7 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
 	size_t *retlen, u_char *buf)
 {
 	struct m25p *flash = mtd_to_m25p(mtd);
+	u32 page_offset, page_size;
 	struct spi_transfer t[2];
 	struct spi_message m;
 
@@ -358,7 +359,6 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
 	spi_message_add_tail(&t[0], &m);
 
 	t[1].rx_buf = buf;
-	t[1].len = len;
 	spi_message_add_tail(&t[1], &m);
 
 	mutex_lock(&flash->lock);
@@ -379,9 +379,47 @@ static int m25p80_read(struct mtd_info *mtd, loff_t from, size_t len,
 	flash->command[0] = OPCODE_READ;
 	m25p_addr2cmd(flash, from, flash->command);
 
-	spi_sync(flash->spi, &m);
+	page_offset = from & (flash->page_size - 1);
+
+	/* do all the bytes fit onto one page? */
+	if (page_offset + len <= flash->page_size) {
+		t[1].len = len;
+
+		spi_sync(flash->spi, &m);
+
+		*retlen = m.actual_length - m25p_cmdsz(flash)
+					- FAST_READ_DUMMY_BYTE;
+
+	} else {
+		u32 i;
+
+		/* the size of data remaining on the first page */
+		page_size = flash->page_size - page_offset;
+
+		t[1].len = page_size;
+		spi_sync(flash->spi, &m);
+
+		*retlen = m.actual_length - m25p_cmdsz(flash)
+					- FAST_READ_DUMMY_BYTE;
+
+		/* write everything in flash->page_size chunks */
+		for (i = page_size; i < len; i += page_size) {
+			page_size = len - i;
+			if (page_size > flash->page_size)
+				page_size = flash->page_size;
+
+			/* write the next page to flash */
+			m25p_addr2cmd(flash, from + i, flash->command);
+
+			t[1].rx_buf = buf + i;
+			t[1].len = page_size;
+
+			spi_sync(flash->spi, &m);
 
-	*retlen = m.actual_length - m25p_cmdsz(flash) - FAST_READ_DUMMY_BYTE;
+			*retlen += m.actual_length - m25p_cmdsz(flash)
+						- FAST_READ_DUMMY_BYTE;
+		}
+	}
 
 	mutex_unlock(&flash->lock);
 
-- 
1.7.9.5
