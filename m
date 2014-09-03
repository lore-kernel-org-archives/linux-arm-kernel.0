From: dianders@chromium.org (Doug Anderson)
Date: Wed,  3 Sep 2014 13:44:25 -0700
Subject: [PATCH 1/3] spi/rockchip: Fix the wait_for_idle() timeout
In-Reply-To: <1409777067-17422-1-git-send-email-dianders@chromium.org>
References: <1409777067-17422-1-git-send-email-dianders@chromium.org>
Message-ID: <1409777067-17422-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wait_for_idle() could get unlucky and timeout too quickly.
Specifically, the old calculation was effectively:
  timeout = jiffies + 1;
  if (jiffies >= timeout) print warning;

>From the above it should be obvious that if jiffies ticks in just the
wrong place then we'll have an effective timeout of 0.

Fix this by effectively changing the above ">=" to a ">".  That gives
us an extra jiffy to finish.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/spi/spi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index cd0e08b0..84dbb86 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -220,7 +220,7 @@ static inline void wait_for_idle(struct rockchip_spi *rs)
 	do {
 		if (!(readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY))
 			return;
-	} while (time_before(jiffies, timeout));
+	} while (!time_after(jiffies, timeout));
 
 	dev_warn(rs->dev, "spi controller is in busy state!\n");
 }
-- 
2.1.0.rc2.206.gedb03e5
