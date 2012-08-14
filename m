From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:31 +0200
Subject: [PATCH 17/23] [BUG] atmel-spi && DMA: OOPS if buffer > 4400 bytes
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-18-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this is just a quick and suboptimal workaround
---
 drivers/spi/spi-atmel.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index d629422..0899da2 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -638,7 +638,8 @@ static void atmel_spi_next_xfer(struct spi_master *master,
 
 	as->current_transfer = xfer;
 
-	if (atmel_spi_use_dma(xfer)) {
+	/* quick (and *really* not optimal) workaround for DMA BUG */
+	if (atmel_spi_use_dma(xfer) && (xfer->len < BUFFER_SIZE)) {
 		if (!atmel_spi_next_xfer_dma(master, xfer))
 			return;
 		else
-- 
1.7.2.5
