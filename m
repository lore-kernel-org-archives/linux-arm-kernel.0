From: robh@kernel.org (Rob Herring)
Date: Thu, 24 May 2018 12:50:21 -0500
Subject: [PATCH v2 5/8] pinctrl: optionally stop deferring probe at end of
 initcalls
In-Reply-To: <20180524175024.19874-1-robh@kernel.org>
References: <20180524175024.19874-1-robh@kernel.org>
Message-ID: <20180524175024.19874-6-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the pinctrl node in DT indicates that pin setup is optional and the
defaults can be used with the 'pinctrl-use-default', then only defer probe
until initcalls are done. This gives platforms the option to work without
their pinctrl driver being enabled.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pinctrl/devicetree.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index b601039d6c69..74a31074b406 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -110,17 +110,23 @@ static int dt_to_map_one_config(struct pinctrl *p,
 	int ret;
 	struct pinctrl_map *map;
 	unsigned num_maps;
+	bool pctl_optional = false;
 
 	/* Find the pin controller containing np_config */
 	np_pctldev = of_node_get(np_config);
 	for (;;) {
+		if (!pctl_optional)
+			pctl_optional = of_property_read_bool(np_pctldev, "pinctrl-use-default");
+
 		np_pctldev = of_get_next_parent(np_pctldev);
 		if (!np_pctldev || of_node_is_root(np_pctldev)) {
-			dev_info(p->dev, "could not find pctldev for node %pOF, deferring probe\n",
-				np_config);
 			of_node_put(np_pctldev);
-			/* OK let's just assume this will appear later then */
-			return -EPROBE_DEFER;
+			ret = driver_deferred_probe_check_init_done(p->dev, pctl_optional);
+			if (ret == -EPROBE_DEFER)
+				/* OK let's just assume this will appear later then */
+				dev_info(p->dev, "could not find pctldev for node %pOF, deferring probe\n",
+					np_config);
+			return ret;
 		}
 		/* If we're creating a hog we can use the passed pctldev */
 		if (pctldev && (np_pctldev == p->dev->of_node))
-- 
2.17.0
