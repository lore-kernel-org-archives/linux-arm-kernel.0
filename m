From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 11 Dec 2012 14:36:05 +0100
Subject: [PATCH 2/2] pinctrl: skip deferral of hogs
Message-ID: <1355232965-16596-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Up until now, as hogs were always taken at the end of the
pin control device registration, it didn't cause any problem.
But when starting to hog pins from the device core it will
cause deferral of the pin controller device itself since the
default pin fetch is done *before* the device probes, so
let's fix this annoyance (which is also aesthetically ugly).

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 59f5a96..55d67bf 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -609,13 +609,16 @@ static int add_setting(struct pinctrl *p, struct pinctrl_map const *map)
 
 	setting->pctldev = get_pinctrl_dev_from_devname(map->ctrl_dev_name);
 	if (setting->pctldev == NULL) {
-		dev_info(p->dev, "unknown pinctrl device %s in map entry, deferring probe",
-			map->ctrl_dev_name);
 		kfree(setting);
+		/* Do not defer probing of hogs (circular loop) */
+		if (!strcmp(map->ctrl_dev_name, map->dev_name))
+			return -ENODEV;
 		/*
 		 * OK let us guess that the driver is not there yet, and
 		 * let's defer obtaining this pinctrl handle to later...
 		 */
+		dev_info(p->dev, "unknown pinctrl device %s in map entry, deferring probe",
+			map->ctrl_dev_name);
 		return -EPROBE_DEFER;
 	}
 
-- 
1.7.11.3
