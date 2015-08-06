From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu,  6 Aug 2015 16:11:47 +0200
Subject: [PATCH v3 10/18] pwm: Probe PWM chip devices on demand
In-Reply-To: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438870315-18689-11-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a PWM chip through its OF node, probe it if it hasn't
already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/pwm/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3a7769fe53de..86649ab60cad 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -29,6 +29,7 @@
 #include <linux/device.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/of_platform.h>
 
 #include <dt-bindings/pwm/pwm.h>
 
@@ -496,6 +497,8 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
 {
 	struct pwm_chip *chip;
 
+	of_platform_probe(np);
+
 	mutex_lock(&pwm_lock);
 
 	list_for_each_entry(chip, &pwm_chips, list)
-- 
2.4.3
