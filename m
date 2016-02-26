From: plaes@plaes.org (Priit Laes)
Date: Fri, 26 Feb 2016 07:56:57 +0200
Subject: [PATCH 2/2] ARM: sunxi: spi: add notice about SPI FIFO limit.
In-Reply-To: <1456466217-6793-1-git-send-email-plaes@plaes.org>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
Message-ID: <1456466217-6793-3-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Suchanek <hramrach@gmail.com>

When testing SPI without DMA I noticed that filling the FIFO on the
spi controller causes timeout. This should never happen with DMA support
so just adding a comment.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi-sun4i.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 78141a6..b750664 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -333,7 +333,9 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 		sun4i_spi_write(sspi, SUN4I_DMA_CTL_REG, 0);
 
 		/* Fill the TX FIFO */
-		sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
+		/* Filling the fifo fully causes timeout for some reason - at least on spi2 on a10s */
+		/* The can_dma check is txlen >= SUN4I_FIFO_DEPTH so with DMA this should never happen anyway. */
+		sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH - 1);
 	}
 
 	/* Start the transfer */
-- 
2.7.2
