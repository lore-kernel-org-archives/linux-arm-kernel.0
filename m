From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 21 Dec 2015 00:44:04 +0000
Subject: [PATCH] pinctrl: bcm2835: Fix memory leak in error path
Message-ID: <1450658644-20858-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of an invalid pin value bcm2835_pctl_dt_node_to_map()
would leak the pull configs of already assigned pins.
So avoid this by calling the free map function in error case.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: e1b2dc70cd5b ("pinctrl: add bcm2835 driver")
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 2e6ca69..75b0d8c 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -795,7 +795,7 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
 	return 0;
 
 out:
-	kfree(maps);
+	bcm2835_pctl_dt_free_map(pctldev, maps, num_pins * maps_per_pin);
 	return err;
 }
 
-- 
1.7.9.5
