From: vigneshr@ti.com (Vignesh R)
Date: Mon, 30 Nov 2015 10:45:13 +0530
Subject: [PATCH v4 3/5] mtd: devices: m25p80: add support for mmap read request
In-Reply-To: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
References: <1448860515-28336-1-git-send-email-vigneshr@ti.com>
Message-ID: <1448860515-28336-4-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Certain spi controllers may provide accelerated interface to read from
m25p80 type flash devices. This interface provides better read
performance than regular SPI interface.
Call spi_flash_read(), if supported, to make use of such interface.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v4: 
 * Use spi_flash_read_message struct to pass args.
 * support passing of opcode/addr/data nbits.

 drivers/mtd/devices/m25p80.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index fe9ceb7b5405..00094a668c62 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -131,6 +131,26 @@ static int m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	/* convert the dummy cycles to the number of bytes */
 	dummy /= 8;
 
+	if (spi_flash_read_supported(spi)) {
+		struct spi_flash_read_message msg;
+		int ret;
+
+		msg.buf = buf;
+		msg.from = from;
+		msg.len = len;
+		msg.read_opcode = nor->read_opcode;
+		msg.addr_width = nor->addr_width;
+		msg.dummy_bytes = dummy;
+		/* TODO: Support other combinations */
+		msg.opcode_nbits = SPI_NBITS_SINGLE;
+		msg.addr_nbits = SPI_NBITS_SINGLE;
+		msg.data_nbits = m25p80_rx_nbits(nor);
+
+		ret = spi_flash_read(spi, &msg);
+		*retlen = msg.retlen;
+		return ret;
+	}
+
 	spi_message_init(&m);
 	memset(t, 0, (sizeof t));
 
-- 
2.6.3
