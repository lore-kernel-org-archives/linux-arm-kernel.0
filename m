From: fisaksen@baylibre.com (Frode Isaksen)
Date: Fri, 17 Mar 2017 16:41:10 +0100
Subject: [PATCH] spi: davinci: add comment about dummy tx buffer usage
Message-ID: <1489765270-17950-1-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add explanation about using the the rx buffer as the
dummy tx buffer.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-davinci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index f37bbdd..595acdc 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -660,7 +660,11 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
 			goto err_desc;
 
 		if (!t->tx_buf) {
-			/* use rx buffer as dummy tx buffer */
+			/* To avoid errors when doing rx-only transfers with
+			 * many SG entries (> 20), use the rx buffer as the
+			 * dummy tx buffer so that dma reloads are done at the
+			 * same time for rx and tx.
+			 */
 			t->tx_sg.sgl = t->rx_sg.sgl;
 			t->tx_sg.nents = t->rx_sg.nents;
 		}
-- 
2.7.4
