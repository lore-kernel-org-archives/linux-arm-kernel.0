From: marex@denx.de (Marek Vasut)
Date: Tue,  4 Sep 2012 04:40:16 +0200
Subject: [PATCH 2/4] mxs/spi: Increment the transfer length only if transfer
 succeeded
In-Reply-To: <1346726418-2856-1-git-send-email-marex@denx.de>
References: <1346726418-2856-1-git-send-email-marex@denx.de>
Message-ID: <1346726418-2856-3-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The transfer function incremented (struct spi_message)->actual_length
unconditionally, even if the transfer failed. Rectify this by incrementing
this only if transfer succeeded.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-mxs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 3add52e..282bdd7 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -473,12 +473,12 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 						&first, &last, 0);
 		}
 
-		m->actual_length += t->len;
 		if (status) {
 			stmp_reset_block(ssp->base);
 			break;
 		}
 
+		m->actual_length += t->len;
 		first = last = 0;
 	}
 
-- 
1.7.10.4
