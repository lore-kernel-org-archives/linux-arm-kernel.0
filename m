From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 25 Apr 2012 19:38:13 +0800
Subject: [PATCH 1/2] pinctrl: support gpio request deferred probing
Message-ID: <1335353894-22096-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

As pinctrl handles, it may be possible the pinctrl gpio ranges
are still not got registered when user call pinctrl_gpio_request.
Thus, add defer support for it too.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 drivers/pinctrl/core.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 5cd5a5a..ea2412a 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -276,7 +276,8 @@ pinctrl_match_gpio_range(struct pinctrl_dev *pctldev, unsigned gpio)
  *
  * Find the pin controller handling a certain GPIO pin from the pinspace of
  * the GPIO subsystem, return the device and the matching GPIO range. Returns
- * negative if the GPIO range could not be found in any device.
+ * -EPROBE_DEFER if the GPIO range could not be found in any device since it
+ * may still have not been registered.
  */
 static int pinctrl_get_device_gpio_range(unsigned gpio,
 					 struct pinctrl_dev **outdev,
@@ -296,7 +297,7 @@ static int pinctrl_get_device_gpio_range(unsigned gpio,
 		}
 	}
 
-	return -EINVAL;
+	return -EPROBE_DEFER;
 }
 
 /**
@@ -382,7 +383,7 @@ int pinctrl_request_gpio(unsigned gpio)
 	ret = pinctrl_get_device_gpio_range(gpio, &pctldev, &range);
 	if (ret) {
 		mutex_unlock(&pinctrl_mutex);
-		return -EINVAL;
+		return ret;
 	}
 
 	/* Convert to the pin controllers number space */
-- 
1.7.0.4
