From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 23 Aug 2013 10:38:57 +0200
Subject: [PATCH] pinctrl: imx: Fix compilation with DEBUG enabled
Message-ID: <1377247137-19582-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This became broken with converting the pinmux arrays into struct
types. While at it replace the preprocessor magic with a simple
dev_dbg.

Reported-by: Tushar Behera <tushar.behera@linaro.org>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/pinctrl/pinctrl-imx.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index 587dc0a..10d800b 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -27,18 +27,6 @@
 #include "core.h"
 #include "pinctrl-imx.h"
 
-#define IMX_PMX_DUMP(info, p, m, c, n)			\
-{							\
-	int i, j;					\
-	printk(KERN_DEBUG "Format: Pin Mux Config\n");	\
-	for (i = 0; i < n; i++) {			\
-		j = p[i];				\
-		printk(KERN_DEBUG "%s %d 0x%lx\n",	\
-			info->pins[j].name,		\
-			m[i], c[i]);			\
-	}						\
-}
-
 /* The bits in CONFIG cell defined in binding doc*/
 #define IMX_NO_PAD_CTL	0x80000000	/* no pin config need */
 #define IMX_PAD_SION 0x40000000		/* set SION */
@@ -468,11 +456,10 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
 		if (config & IMX_PAD_SION)
 			pin->mux_mode |= IOMUXC_CONFIG_SION;
 		pin->config = config & ~IMX_PAD_SION;
-	}
 
-#ifdef DEBUG
-	IMX_PMX_DUMP(info, grp->pins, grp->mux_mode, grp->configs, grp->npins);
-#endif
+		dev_dbg(info->dev, "%s: %d 0x%08lx", info->pins[i].name,
+				pin->mux_mode, pin->config);
+	}
 
 	return 0;
 }
-- 
1.8.4.rc3
