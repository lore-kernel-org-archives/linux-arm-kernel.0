From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed,  8 Jun 2016 20:42:46 +0000
Subject: [PATCH net-next RFT] net: fec: handle small PHY reset durations more
 precisely
Message-ID: <1465418567-2694-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since msleep is based on jiffies the PHY reset could take longer
than expected. So use msleep for values greater than 20 msec otherwise
usleep_range.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/net/ethernet/freescale/fec_main.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 3c0255e..49f8055 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3191,7 +3191,12 @@ static void fec_reset_phy(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to get phy-reset-gpios: %d\n", err);
 		return;
 	}
-	msleep(msec);
+
+	if (msec > 20)
+		msleep(msec);
+	else
+		usleep_range(msec * 1000, msec * 1000 + 1000);
+
 	gpio_set_value_cansleep(phy_reset, !active_high);
 }
 #else /* CONFIG_OF */
-- 
1.7.9.5
