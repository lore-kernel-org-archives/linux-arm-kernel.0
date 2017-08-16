From: huibin.hong@rock-chips.com (Huibin Hong)
Date: Wed, 16 Aug 2017 10:12:02 +0800
Subject: [PATCH] spi: rockchip: configure CTRLR1 according to size and data
 frame
Message-ID: <1502849522-10073-1-git-send-email-huibin.hong@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CTRLR1 is number of data frames, when rx only.
When data frame is 8 bit, CTRLR1 is len-1.
When data frame is 16 bit, CTRLR1 is (len/2)-1.

Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
---

 drivers/spi/spi-rockchip.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 0b4a52b..6b1bac8 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -568,7 +568,13 @@ static void rockchip_spi_config(struct rockchip_spi *rs)
 
 	writel_relaxed(cr0, rs->regs + ROCKCHIP_SPI_CTRLR0);
 
-	writel_relaxed(rs->len - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+	if (rs->n_bytes == 1)
+		writel_relaxed(rs->len - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+	else if (rs->n_bytes == 2)
+		writel_relaxed((rs->len / 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+	else
+		writel_relaxed((rs->len * 2) - 1, rs->regs + ROCKCHIP_SPI_CTRLR1);
+
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_TXFTLR);
 	writel_relaxed(rs->fifo_len / 2 - 1, rs->regs + ROCKCHIP_SPI_RXFTLR);
 
-- 
1.9.1
