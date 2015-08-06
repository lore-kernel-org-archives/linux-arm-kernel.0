From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu,  6 Aug 2015 16:11:51 +0200
Subject: [PATCH v3 14/18] pinctrl: Probe pinctrl devices on demand
In-Reply-To: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438870315-18689-15-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a pin controller through its OF node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/pinctrl/devicetree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index fe04e748dfe4..2326ae99e06a 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -18,6 +18,7 @@
 
 #include <linux/device.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/slab.h>
 
@@ -110,6 +111,8 @@ static int dt_to_map_one_config(struct pinctrl *p, const char *statename,
 	struct pinctrl_map *map;
 	unsigned num_maps;
 
+	of_platform_probe(np_config);
+
 	/* Find the pin controller containing np_config */
 	np_pctldev = of_node_get(np_config);
 	for (;;) {
-- 
2.4.3
