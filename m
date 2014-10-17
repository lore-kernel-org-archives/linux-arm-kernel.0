From: addy.ke@rock-chips.com (Addy Ke)
Date: Fri, 17 Oct 2014 09:44:13 +0800
Subject: [PATCH] spi/rockchip: spi controller must be disabled in tx callback
 too
Message-ID: <1413510253-3519-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/spi/spi-rockchip.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 153269b..87bc16f 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -418,8 +418,10 @@ static void rockchip_spi_dma_txcb(void *data)
 	spin_lock_irqsave(&rs->lock, flags);
 
 	rs->state &= ~TXBUSY;
-	if (!(rs->state & RXBUSY))
+	if (!(rs->state & RXBUSY)) {
+		spi_enable_chip(rs, 0);
 		spi_finalize_current_transfer(rs->master);
+	}
 
 	spin_unlock_irqrestore(&rs->lock, flags);
 }
-- 
1.8.3.2
