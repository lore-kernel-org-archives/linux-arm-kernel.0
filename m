From: mweseloh42@gmail.com (Marcus Weseloh)
Date: Sat, 26 Dec 2015 16:53:06 +0100
Subject: [PATCH v6 3/3] spi: sun4i: Add support for wait time between word
 transmissions
In-Reply-To: <1451145186-14235-1-git-send-email-mweseloh42@gmail.com>
References: <1451145186-14235-1-git-send-email-mweseloh42@gmail.com>
Message-ID: <1451145186-14235-4-git-send-email-mweseloh42@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modifies the sun4i SPI master driver to make use of the
"spi-word-wait-ns" property. This specific SPI controller needs 3 clock
cycles to set up the delay, which makes the minimum non-zero wait time
on this hardware 4 clock cycles.

Signed-off-by: Marcus Weseloh <mweseloh42@gmail.com>
---
 drivers/spi/spi-sun4i.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index d67e142..4d6f77c 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -176,6 +176,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	unsigned int tx_len = 0;
 	int ret = 0;
 	u32 reg;
+	int wait_clk = 0;
+	int clk_ns = 0;
+	unsigned int speed_hz;
 
 	/* We don't support transfer larger than the FIFO */
 	if (tfr->len > SUN4I_FIFO_DEPTH)
@@ -260,13 +263,34 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	div = DIV_ROUND_UP(mclk_rate, 2 * tfr->speed_hz) - 1;
 	if (div <= SUN4I_CLK_CTL_CDR2_MASK) {
 		reg = SUN4I_CLK_CTL_CDR2(div) | SUN4I_CLK_CTL_DRS;
+		speed_hz = mclk_rate / (2 * (div + 1));
 	} else {
 		div = ilog2(roundup_pow_of_two(mclk_rate / tfr->speed_hz));
 		reg = SUN4I_CLK_CTL_CDR1(div);
+		speed_hz = mclk_rate / (1 << div);
 	}
 
 	sun4i_spi_write(sspi, SUN4I_CLK_CTL_REG, reg);
 
+	/*
+	 * Setup wait time between words.
+	 *
+	 * Wait time is set in SPI_CLK cycles. The SPI hardware needs 3
+	 * additional cycles to setup the wait counter, so the minimum delay
+	 * time is 4 cycles.
+	 */
+	if (spi->word_wait_ns) {
+		clk_ns = DIV_ROUND_UP(1000000000, speed_hz);
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
