From: robh@kernel.org (Rob Herring)
Date: Mon,  9 Jul 2018 09:41:50 -0600
Subject: [PATCH v4 3/6] pinctrl: Support stopping deferred probe after
 initcalls
In-Reply-To: <20180709154153.15742-1-robh@kernel.org>
References: <20180709154153.15742-1-robh@kernel.org>
Message-ID: <20180709154153.15742-4-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pinctrl drivers are a common dependency which can prevent a system
booting even if the default or bootloader configured settings can work.
If a pinctrl node in DT indicates that the default pin setup can be used
with the 'pinctrl-use-default' property, then only defer probe until
initcalls are done. If the deferred probe timeout is enabled or loadable
modules are disabled, then we'll stop deferring probe regardless of the
DT property. This gives platforms the option to work without their
pinctrl driver being enabled.

Dropped the pinctrl specific deferring probe message as the driver core
can print deferred probe related messages if needed.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v4:
- Add Linus' R-by.

v3:
- Drop pinctrl deferred probe msg in favor of driver core messages
- Move the handling of "pinctrl-use-default" option out of driver core
- Stop deferring probe if modules are not enabled.

 drivers/pinctrl/devicetree.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index c4aa411f5935..2969ff3162c3 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -111,17 +111,24 @@ static int dt_to_map_one_config(struct pinctrl *p,
 	int ret;
 	struct pinctrl_map *map;
 	unsigned num_maps;
+	bool allow_default = false;

 	/* Find the pin controller containing np_config */
 	np_pctldev = of_node_get(np_config);
 	for (;;) {
+		if (!allow_default)
+			allow_default = of_property_read_bool(np_pctldev,
+							      "pinctrl-use-default");
+
 		np_pctldev = of_get_next_parent(np_pctldev);
 		if (!np_pctldev || of_node_is_root(np_pctldev)) {
-			dev_info(p->dev, "could not find pctldev for node %pOF, deferring probe\n",
-				np_config);
 			of_node_put(np_pctldev);
-			/* OK let's just assume this will appear later then */
-			return -EPROBE_DEFER;
+			ret = driver_deferred_probe_check_state(p->dev);
+			/* keep deferring if modules are enabled unless we've timed out */
+			if (IS_ENABLED(CONFIG_MODULES) && !allow_default && ret == -ENODEV)
+				ret = -EPROBE_DEFER;
+
+			return ret;
 		}
 		/* If we're creating a hog we can use the passed pctldev */
 		if (hog_pctldev && (np_pctldev == p->dev->of_node)) {
--
2.17.1
