From: gbean@codeaurora.org (Gregory Bean)
Date: Thu, 22 Jul 2010 14:05:58 -0700
Subject: [PATCH] gpio: remove spurious gpio_unexport debug error.
Message-ID: <1279832758-25442-1-git-send-email-gbean@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make gpio_unexport generate success instead of an -EINVAL
if asked to unexport a line which is not exported, because
the only result of that condition is a pr_debug
which complains of what is really a harmless no-op:
when an unexported gpio is unexported again, nothing happens.
That's not a failure, just a trivial border case.
Since gpio_free calls gpio_unexport unconditionally
and exported gpio lines are uncommon, most calls to
gpio_free with debug flags enabled generate -EINVAL
warnings in the log, causing unnecessary stress.

Signed-off-by: Gregory Bean <gbean@codeaurora.org>
---
 drivers/gpio/gpiolib.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 3ca3654..b718aea 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -914,7 +914,8 @@ void gpio_unexport(unsigned gpio)
 			status = 0;
 		} else
 			status = -ENODEV;
-	}
+	} else
+		status = 0;
 
 	mutex_unlock(&sysfs_lock);
 done:
-- 
1.7.0.4

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
