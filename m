From: ludovic.Barre@st.com (Ludovic Barre)
Date: Thu, 26 Oct 2017 13:54:53 +0200
Subject: [PATCH 2/3] mtd: spi-nor: stm32-quadspi: fix prefetching outside fsize
In-Reply-To: <1509018894-15111-1-git-send-email-ludovic.Barre@st.com>
References: <1509018894-15111-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1509018894-15111-3-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

When memory-mapped mode is used, a prefetching mechanism fully
managed by the hardware allows to optimize the read from external
the QSPI memory. A 32-bytes FIFO is used for prefetching.
When the limit of flash size - fifo size is reached the prefetching
mechanism tries to read outside the fsize.
The stm32 quadspi hardware become busy and should be aborted.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Reported-by: Bruno Herrera <bruherrera@gmail.com>
Tested-by: Bruno Herrera <bruherrera@gmail.com>
---
 drivers/mtd/spi-nor/stm32-quadspi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/stm32-quadspi.c b/drivers/mtd/spi-nor/stm32-quadspi.c
index ad6a3e1..70710be 100644
--- a/drivers/mtd/spi-nor/stm32-quadspi.c
+++ b/drivers/mtd/spi-nor/stm32-quadspi.c
@@ -113,6 +113,7 @@
 #define STM32_MAX_MMAP_SZ	SZ_256M
 #define STM32_MAX_NORCHIP	2
 
+#define STM32_QSPI_FIFO_SZ	32
 #define STM32_QSPI_FIFO_TIMEOUT_US 30000
 #define STM32_QSPI_BUSY_TIMEOUT_US 100000
 
@@ -124,6 +125,7 @@ struct stm32_qspi_flash {
 	u32 presc;
 	u32 read_mode;
 	bool registered;
+	u32 prefetch_limit;
 };
 
 struct stm32_qspi {
@@ -272,6 +274,7 @@ static int stm32_qspi_send(struct stm32_qspi_flash *flash,
 {
 	struct stm32_qspi *qspi = flash->qspi;
 	u32 ccr, dcr, cr;
+	u32 last_byte;
 	int err;
 
 	err = stm32_qspi_wait_nobusy(qspi);
@@ -314,6 +317,10 @@ static int stm32_qspi_send(struct stm32_qspi_flash *flash,
 		if (err)
 			goto abort;
 		writel_relaxed(FCR_CTCF, qspi->io_base + QUADSPI_FCR);
+	} else {
+		last_byte = cmd->addr + cmd->len;
+		if (last_byte > flash->prefetch_limit)
+			goto abort;
 	}
 
 	return err;
@@ -322,7 +329,9 @@ static int stm32_qspi_send(struct stm32_qspi_flash *flash,
 	cr = readl_relaxed(qspi->io_base + QUADSPI_CR) | CR_ABORT;
 	writel_relaxed(cr, qspi->io_base + QUADSPI_CR);
 
-	dev_err(qspi->dev, "%s abort err:%d\n", __func__, err);
+	if (err)
+		dev_err(qspi->dev, "%s abort err:%d\n", __func__, err);
+
 	return err;
 }
 
@@ -550,6 +559,7 @@ static int stm32_qspi_flash_setup(struct stm32_qspi *qspi,
 	}
 
 	flash->fsize = FSIZE_VAL(mtd->size);
+	flash->prefetch_limit = mtd->size - STM32_QSPI_FIFO_SZ;
 
 	flash->read_mode = CCR_FMODE_MM;
 	if (mtd->size > qspi->mm_size)
-- 
2.7.4
