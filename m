From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 11 Jan 2013 21:46:13 +0100
Subject: [PATCH] pinctrl: do not defer device tree hogs
Message-ID: <1357937173-4634-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

commit af1024e0f7cde9023ddd0f3116db03911d5914c0
"pinctrl: skip deferral of hogs"

Attempts to avoid probe deferral on hogged pins, but we
forgot the device tree case. This patch fixes this.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reported-by: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/devicetree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index fe2d1af..fd40a11 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -141,6 +141,11 @@ static int dt_to_map_one_config(struct pinctrl *p, const char *statename,
 		pctldev = find_pinctrl_by_of_node(np_pctldev);
 		if (pctldev)
 			break;
+		/* Do not defer probing of hogs (circular loop) */
+		if (np_pctldev == p->dev->of_node) {
+			of_node_put(np_pctldev);
+			return -ENODEV;
+		}
 	}
 	of_node_put(np_pctldev);
 
-- 
1.7.11.3
