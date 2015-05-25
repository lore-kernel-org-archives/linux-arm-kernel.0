From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 25 May 2015 16:53:18 +0200
Subject: [PATCH 14/21] pwm: Probe PWM chip devices on demand
In-Reply-To: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1432565608-26036-15-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a PWM chip through its DT node, ensure that the
corresponding device has been registered.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/pwm/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index ba34c7d..31f486c 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -24,6 +24,7 @@
 #include <linux/radix-tree.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/of_platform.h>
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/device.h>
@@ -479,6 +480,8 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
 {
 	struct pwm_chip *chip;
 
+	of_platform_device_ensure(np);
+
 	mutex_lock(&pwm_lock);
 
 	list_for_each_entry(chip, &pwm_chips, list)
-- 
2.4.1
