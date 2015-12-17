From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Thu, 17 Dec 2015 12:40:27 +0100
Subject: [PATCH v5 2/2] spi: sun4i: Add support for wait time between word
 transmissions
In-Reply-To: <1450352427-25350-1-git-send-email-mweseloh42@gmail.com>
References: <1450352427-25350-1-git-send-email-mweseloh42@gmail.com>
Message-ID: <1450352427-25350-3-git-send-email-mweseloh42@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modifies the sun4i SPI master driver to make use of the
"spi-word-wait-ns" property. This specific SPI controller needs 3 clock
cycles to set up the delay, which makes the minimum non-zero wait time
on this hardware 4 clock cycles.

Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>
---
 drivers/spi/spi-sun4i.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index f60a6d6..3b4f5f4 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/of.h>
 
 #include <linux/spi/spi.h>
 
@@ -173,6 +174,8 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	unsigned int tx_len = 0;
 	int ret = 0;
 	u32 reg;
+	int wait_clk = 0;
+	int clk_ns = 0;
 
 	/* We don't support transfer larger than the FIFO */
 	if (tfr->len > SUN4I_FIFO_DEPTH)
@@ -261,6 +264,25 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 
 	sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);
 
+	/*
+	 * Setup wait time between words.
+	 *
+	 * Wait time is set in SPI_CLK cycles. The SPI hardware needs 3
+	 * additional cycles to setup the wait counter, so the minimum delay
+	 * time is 4 cycles.
+	 */
+	if (spi->word_wait_ns) {
+		clk_ns = DIV_ROUND_UP(1000000000, tfr->speed_hz);
+		wait_clk = DIV_ROUND_UP(spi->word_wait_ns, clk_ns) - 3;
+		if (wait_clk < 1) {
+			wait_clk = 1;
+			dev_dbg(&spi->dev,
+				"using minimum of 4 word wait cycles (%uns)",
+				4 * clk_ns);
+		}
+	}
+	sun4i_spi_write(sspi, SUN4I_WAIT_REG, (u16)wait_clk);
+
 	/* Setup the transfer now... */
 	if (sspi->tx_buf)
 		tx_len = tfr->len;
-- 
1.9.1
