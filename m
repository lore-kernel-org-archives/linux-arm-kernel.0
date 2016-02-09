From: stephanolbrich@gmx.de (stephanolbrich at gmx.de)
Date: Tue,  9 Feb 2016 19:10:35 +0100
Subject: [PATCH 4/4] spi: bcm2835aux: fix CPOL/CPHA setting
In-Reply-To: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
Message-ID: <1455041435-8015-5-git-send-email-stephanolbrich@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephan Olbrich <stephanolbrich@gmx.de>

The auxiliary spi supports only CPHA=0 modes as the first bit is
always output to the pin before the first clock cycle. In CPHA=1
modes the first clock edge outputs the second bit hence the slave
can never read the first bit.

Also the CPHA registers switch between clocking data in/out on
rising/falling edge hence depend on the CPOL setting.

Signed-off-by: Stephan Olbrich <stephanolbrich@gmx.de>
---
 drivers/spi/spi-bcm2835aux.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index b90aa34..169f521 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -386,12 +386,12 @@ static int bcm2835aux_spi_prepare_message(struct spi_master *master,
 	bs->cntl[1] = BCM2835_AUX_SPI_CNTL1_MSBF_IN;
 
 	/* handle all the modes */
-	if (spi->mode & SPI_CPOL)
+	if (spi->mode & SPI_CPOL) {
 		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPOL;
-	if (spi->mode & SPI_CPHA)
-		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_OUT |
-			       BCM2835_AUX_SPI_CNTL0_CPHA_IN;
-
+		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_OUT;
+	} else {
+		bs->cntl[0] |= BCM2835_AUX_SPI_CNTL0_CPHA_IN;
+	}
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL1, bs->cntl[1]);
 	bcm2835aux_wr(bs, BCM2835_AUX_SPI_CNTL0, bs->cntl[0]);
 
-- 
2.5.0
