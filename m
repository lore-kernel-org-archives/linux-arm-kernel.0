From: marex@denx.de (Marek Vasut)
Date: Fri, 24 Aug 2012 04:34:18 +0200
Subject: [PATCH] mxs/spi: Restart the block after unsuccessful transfer
Message-ID: <1345775658-9739-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Restart the SSP block in case the SSP transfer failed in any way.
The block hung in some cases otherwise.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/spi/spi-mxs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 746359e..8075683 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -445,8 +445,10 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 		}
 
 		m->actual_length += t->len;
-		if (status)
+		if (status) {
+			stmp_reset_block(ssp->base);
 			break;
+		}
 
 		first = last = 0;
 	}
-- 
1.7.10.4
