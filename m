From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 21 Sep 2015 16:02:56 +0200
Subject: [PATCH v6 16/22] pinctrl: Probe pinctrl devices on demand
In-Reply-To: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1442844182-27787-17-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a pin controller through its OF node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---


 drivers/pinctrl/devicetree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index fe04e748dfe4..f5340b8e1dbe 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -18,6 +18,7 @@
 
 #include <linux/device.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/slab.h>
 
@@ -110,6 +111,8 @@ static int dt_to_map_one_config(struct pinctrl *p, const char *statename,
 	struct pinctrl_map *map;
 	unsigned num_maps;
 
+	of_device_probe(np_config);
+
 	/* Find the pin controller containing np_config */
 	np_pctldev = of_node_get(np_config);
 	for (;;) {
-- 
2.4.3
