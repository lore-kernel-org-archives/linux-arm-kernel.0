From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 17:26:35 +0900
Subject: [PATCH 104/130] sh-pfc: Add support for SoC-specific initialization
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370420821-28420-105-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add two optional init and exit SoC operations and call them from the
core at probe and remove time.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/core.c   | 16 +++++++++++++++-
 drivers/pinctrl/sh-pfc/core.h   |  1 +
 drivers/pinctrl/sh-pfc/sh_pfc.h |  2 ++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 4540ce3..3b2fd43 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -372,6 +372,12 @@ static int sh_pfc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&pfc->lock);
 
+	if (info->ops && info->ops->init) {
+		ret = info->ops->init(pfc);
+		if (ret < 0)
+			return ret;
+	}
+
 	pinctrl_provide_dummies();
 
 	/*
@@ -379,7 +385,7 @@ static int sh_pfc_probe(struct platform_device *pdev)
 	 */
 	ret = sh_pfc_register_pinctrl(pfc);
 	if (unlikely(ret != 0))
-		return ret;
+		goto error;
 
 #ifdef CONFIG_GPIO_SH_PFC
 	/*
@@ -401,6 +407,11 @@ static int sh_pfc_probe(struct platform_device *pdev)
 	dev_info(pfc->dev, "%s support registered\n", info->name);
 
 	return 0;
+
+error:
+	if (info->ops && info->ops->exit)
+		info->ops->exit(pfc);
+	return ret;
 }
 
 static int sh_pfc_remove(struct platform_device *pdev)
@@ -412,6 +423,9 @@ static int sh_pfc_remove(struct platform_device *pdev)
 #endif
 	sh_pfc_unregister_pinctrl(pfc);
 
+	if (pfc->info->ops && pfc->info->ops->exit)
+		pfc->info->ops->exit(pfc);
+
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index e847afb..f02ba1d 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -28,6 +28,7 @@ struct sh_pfc_pinctrl;
 struct sh_pfc {
 	struct device *dev;
 	const struct sh_pfc_soc_info *info;
+	void *soc_data;
 	spinlock_t lock;
 
 	unsigned int num_windows;
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index b170761..830ae1f 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -129,6 +129,8 @@ struct pinmux_range {
 struct sh_pfc;
 
 struct sh_pfc_soc_operations {
+	int (*init)(struct sh_pfc *pfc);
+	void (*exit)(struct sh_pfc *pfc);
 	unsigned int (*get_bias)(struct sh_pfc *pfc, unsigned int pin);
 	void (*set_bias)(struct sh_pfc *pfc, unsigned int pin,
 			 unsigned int bias);
-- 
1.8.2.1
