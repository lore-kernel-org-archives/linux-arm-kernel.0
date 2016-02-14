From: stephanolbrich@gmx.de (Stephan Olbrich)
Date: Sun, 14 Feb 2016 11:04:29 +0100
Subject: [PATCH v2 2/2] spi: bcm2835aux: fix CPOL/CPHA setting
In-Reply-To: <1455444269-4797-1-git-send-email-stephanolbrich@gmx.de>
References: <1455444269-4797-1-git-send-email-stephanolbrich@gmx.de>
Message-ID: <1455444269-4797-3-git-send-email-stephanolbrich@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The auxiliary spi supports only CPHA=0 modes as the first bit is
always output to the pin before the first clock cycle. In CPHA=1
modes the first clock edge outputs the second bit hence the slave
can never read the first bit.

Also the CPHA registers switch between clocking data in/out on
rising/falling edge hence depend on the CPOL setting.

Signed-off-by: Stephan Olbrich <stephanolbrich@gmx.de>
---
 drivers/spi/spi-bcm2835aux.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 103335e..7428091 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -64,9 +64,9 @@
 #define BCM2835_AUX_SPI_CNTL0_VAR_WIDTH	0x00004000
 #define BCM2835_AUX_SPI_CNTL0_DOUTHOLD	0x00003000
 #define BCM2835_AUX_SPI_CNTL0_ENABLE	0x00000800
-#define BCM2835_AUX_SPI_CNTL0_CPHA_IN	0x00000400
+#define BCM2835_AUX_SPI_CNTL0_IN_RISING	0x00000400
 #define BCM2835_AUX_SPI_CNTL0_CLEARFIFO	0x00000200
-#define BCM2835_AUX_SPI_CNTL0_CPHA_OUT	0x00000100
+#define BCM2835_AUX_SPI_CNTL0_OUT_RISING	0x00000100
 #define BCM2835_AUX_SPI_CNTL0_CPOL	0x00000080
 #define BCM2835_AUX_SPI_CNTL0_MSBF_OUT	0x00000040
 #define BCM2835_AUX_SPI_CNTL0_SHIFTLEN	0x0000003F
@@ -92,9 +92,6 @@
 #define BCM2835_AUX_SPI_POLLING_LIMIT_US	30
 #define BCM2835_AUX_SPI_POLLING_JIFFIES		2
 
-#define BCM2835_AUX_SPI_MODE_BITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
-				  | SPI_NO_CS)
-
 struct bcm2835aux_spi {
 	void __iomem *regs;
 	struct clk *clk;
@@ -389,12 +386,12 @@ static int bcm2835aux_spi_prepare_message(struct spi_master *master,
 	bs->cntl[1] = BCM2835_AUX_SPI_CNTL1_MSBF_IN;
 
 	/* handle all the modes */
-	if (spi->mode & SPI_CPOL)
+	if (spi->mode & SPI_CPOL) {
 		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPOL;
-	if (spi->mode & SPI_CPHA)
-		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_OUT |
-			       BCM2835_AUX_SPI_CNTL0_CPHA_IN;
-
+		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_OUT_RISING;
+	} else {
+		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_IN_RISING;
+	}
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);
 
@@ -434,7 +431,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, master);
-	master->mode_bits = BCM2835_AUX_SPI_MODE_BITS;
+	master->mode_bits = (SPI_CPOL | SPI_CS_HIGH | SPI_NO_CS);
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->num_chipselect = -1;
 	master->transfer_one = bcm2835aux_spi_transfer_one;
-- 
2.5.0
