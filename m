From: ricardo.ribalda@gmail.com (Ricardo Ribalda Delgado)
Date: Fri, 23 Jan 2015 17:08:48 +0100
Subject: [PATCH 16/18] spi/xilinx: Reset core before buffer_size detection
In-Reply-To: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <1422029330-10971-17-git-send-email-ricardo.ribalda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the core had some data on the buffer, the size detection could show
up a smaller size than real, affecting performance.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 704613c..8c25c59 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -295,6 +295,13 @@ static int xilinx_spi_find_buffer_size(struct xilinx_spi *xspi)
 	u8 sr;
 	int n_words = 0;
 
+	/*
+	 * Before the buffer_size detection we reset the core
+	 * to make sure we start with a clean state.
+	 */
+	xspi->write_fn(XIPIF_V123B_RESET_MASK,
+		xspi->regs + XIPIF_V123B_RESETR_OFFSET);
+
 	/* Fill the Tx FIFO with as many words as possible */
 	do {
 		xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
-- 
2.1.4
