From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 25 Jan 2013 11:23:51 +0900
Subject: [PATCH 15/80] sh-pfc: Let the compiler decide whether to inline
 functions
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359080696-31489-16-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The compiler should be smart enough to automatically inline static
functions that are called from a single location.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/pfc/pinctrl.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/sh/pfc/pinctrl.c b/drivers/sh/pfc/pinctrl.c
index b3dbefd..47dbd02 100644
--- a/drivers/sh/pfc/pinctrl.c
+++ b/drivers/sh/pfc/pinctrl.c
@@ -116,7 +116,7 @@ static void sh_pfc_noop_disable(struct pinctrl_dev *pctldev, unsigned func,
 {
 }
 
-static inline int sh_pfc_config_function(struct sh_pfc *pfc, unsigned offset)
+static int sh_pfc_config_function(struct sh_pfc *pfc, unsigned offset)
 {
 	if (sh_pfc_config_gpio(pfc, offset,
 			       PINMUX_TYPE_FUNCTION,
@@ -328,10 +328,8 @@ static struct pinctrl_desc sh_pfc_pinctrl_desc = {
 	.confops	= &sh_pfc_pinconf_ops,
 };
 
-static inline void sh_pfc_map_one_gpio(struct sh_pfc *pfc,
-				       struct sh_pfc_pinctrl *pmx,
-				       struct pinmux_gpio *gpio,
-				       unsigned offset)
+static void sh_pfc_map_one_gpio(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx,
+				struct pinmux_gpio *gpio, unsigned offset)
 {
 	struct pinmux_data_reg *dummy;
 	unsigned long flags;
-- 
1.7.10.4
