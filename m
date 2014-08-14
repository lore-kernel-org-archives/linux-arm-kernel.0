From: addy.ke@rock-chips.com (Addy Ke)
Date: Thu, 14 Aug 2014 08:52:24 +0800
Subject: [PATCH] spi: rockchip: return 0 if tx_buf and rx_buf are NULL
Message-ID: <1407977544-2989-1-git-send-email-addy.ke@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To do so, spi communication can use an empty buf to pull up CS.

This patch merged from ChromiumOS tree.
Cros_ec use this function to turn off CS and add a delay to ensure
the rising edge doesn't come too soon after the end of the data.

Tested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/spi/spi-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 72fb287..1e3bcfa 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -511,8 +511,8 @@ static int rockchip_spi_transfer_one(struct spi_master *master,
 	WARN_ON((readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY));
 
 	if (!xfer->tx_buf && !xfer->rx_buf) {
-		dev_err(rs->dev, "No buffer for transfer\n");
-		return -EINVAL;
+		dev_dbg(rs->dev, "No buffer for transfer\n");
+		return 0;
 	}
 
 	rs->speed = xfer->speed_hz;
-- 
1.8.3.2
