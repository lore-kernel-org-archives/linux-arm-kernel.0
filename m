From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 29 Sep 2015 11:10:47 +0200
Subject: [PATCH v7 09/20] drm/tegra: Probe dpaux devices on demand
In-Reply-To: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1443517859-30376-10-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a dpaux device through its OF node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---


 drivers/gpu/drm/tegra/dpaux.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index 224a7dc8e4ed..96a2eec7e020 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of_gpio.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/regulator/consumer.h>
@@ -439,6 +440,8 @@ struct tegra_dpaux *tegra_dpaux_find_by_of_node(struct device_node *np)
 {
 	struct tegra_dpaux *dpaux;
 
+	of_device_probe(np);
+
 	mutex_lock(&dpaux_lock);
 
 	list_for_each_entry(dpaux, &dpaux_list, list)
-- 
2.4.3
