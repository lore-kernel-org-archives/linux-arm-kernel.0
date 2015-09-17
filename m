From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 17 Sep 2015 14:57:07 +0200
Subject: [PATCH v5 13/23] pwm: Probe PWM chip devices on demand
In-Reply-To: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442494637-3674-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1442494637-3674-14-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a PWM chip through its OF node, probe it if it hasn't
already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/pwm/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3f9df3ea3350..794a923df0d8 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -29,6 +29,7 @@
 #include <linux/device.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/of_device.h>
 
 #include <dt-bindings/pwm/pwm.h>
 
@@ -516,6 +517,8 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
 {
 	struct pwm_chip *chip;
 
+	of_device_probe(np);
+
 	mutex_lock(&pwm_lock);
 
 	list_for_each_entry(chip, &pwm_chips, list)
-- 
2.4.3
