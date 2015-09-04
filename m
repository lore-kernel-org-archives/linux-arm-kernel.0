From: vigneshr@ti.com (Vignesh R)
Date: Fri, 4 Sep 2015 14:00:00 +0530
Subject: [PATCH 3/5] mtd: devices: m25p80: add support for mmap read request
In-Reply-To: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
Message-ID: <1441355402-6837-4-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Certain spi controllers may support memory mapped interface to read from
m25p80 type flash devices. This interface provides better read
performance than regular SPI interface.
Call spi_mtd_mmap_read() function, if available, to make use of
memory-mapped interface.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/mtd/devices/m25p80.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index d313f948b96c..b8b391aab331 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -133,6 +133,14 @@ static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	/* convert the dummy cycles to the number of bytes */
 	dummy /= 8;
 
+	if (spi->master->spi_mtd_mmap_read) {
+		return  spi->master->spi_mtd_mmap_read(spi, from, len,
+						       retlen, buf,
+						       nor->read_opcode,
+						       nor->addr_width,
+						       dummy);
+	}
+
 	spi_message_init(&m);
 	memset(t, 0, (sizeof t));
 
-- 
2.5.1
