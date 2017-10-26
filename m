From: ludovic.Barre@st.com (Ludovic Barre)
Date: Thu, 26 Oct 2017 13:54:52 +0200
Subject: [PATCH 1/3] mtd: spi-nor: stm32-quadspi: Fix uninitialized error
 return code
In-Reply-To: <1509018894-15111-1-git-send-email-ludovic.Barre@st.com>
References: <1509018894-15111-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1509018894-15111-2-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert@linux-m68k.org>

With gcc 4.1.2:

    drivers/mtd/spi-nor/stm32-quadspi.c: In function ?stm32_qspi_tx_poll?:
    drivers/mtd/spi-nor/stm32-quadspi.c:230: warning: ?ret? may be used uninitialized in this function

Indeed, if stm32_qspi_cmd.len is zero, ret will be uninitialized.
This length is passed from outside the driver using the
spi_nor.{read,write}{,_reg}() callbacks.

Several functions in drivers/mtd/spi-nor/spi-nor.c (e.g. write_enable(),
write_disable(), and erase_chip()) call spi_nor.write_reg() with a zero
length.

Fix this by returning an explicit zero on success.

Fixes: 0d43d7ab277a048c ("mtd: spi-nor: add driver for STM32 quad spi flash controller")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mtd/spi-nor/stm32-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/stm32-quadspi.c b/drivers/mtd/spi-nor/stm32-quadspi.c
index 86c0931..ad6a3e1 100644
--- a/drivers/mtd/spi-nor/stm32-quadspi.c
+++ b/drivers/mtd/spi-nor/stm32-quadspi.c
@@ -240,12 +240,12 @@ static int stm32_qspi_tx_poll(struct stm32_qspi *qspi,
 						 STM32_QSPI_FIFO_TIMEOUT_US);
 		if (ret) {
 			dev_err(qspi->dev, "fifo timeout (stat:%#x)\n", sr);
-			break;
+			return ret;
 		}
 		tx_fifo(buf++, qspi->io_base + QUADSPI_DR);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int stm32_qspi_tx_mm(struct stm32_qspi *qspi,
-- 
2.7.4
