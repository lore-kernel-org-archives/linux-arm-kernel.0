From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Sat, 26 Nov 2011 07:09:00 +0800
Subject: [PATCH 3/7] ARM: pxa: enable pinmux in pxa pwm
In-Reply-To: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1322262544-7854-4-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haojian Zhuang <hzhuang1@hexinfolabs.org>

Add pinmux operations in pxa pwm driver.

Signed-off-by: Haojian Zhuang <hzhuang1@hexinfolabs.org>
---
 arch/arm/plat-pxa/pwm.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-pxa/pwm.c b/arch/arm/plat-pxa/pwm.c
index ef32686..93c0986 100644
--- a/arch/arm/plat-pxa/pwm.c
+++ b/arch/arm/plat-pxa/pwm.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/pinmux.h>
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -47,6 +48,7 @@ struct pwm_device {
 	struct list_head	node;
 	struct pwm_device	*secondary;
 	struct platform_device	*pdev;
+	struct pinmux		*pmx;
 
 	const char	*label;
 	struct clk	*clk;
@@ -187,10 +189,16 @@ static int __devinit pwm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	pwm->pmx = pinmux_get(&pdev->dev, NULL);
+	if (IS_ERR(pwm->pmx)) {
+		ret = PTR_ERR(pwm->pmx);
+		goto err_free;
+	}
+	pinmux_enable(pwm->pmx);
 	pwm->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pwm->clk)) {
 		ret = PTR_ERR(pwm->clk);
-		goto err_free;
+		goto err_free_pwm;
 	}
 	pwm->clk_enabled = 0;
 
@@ -245,6 +253,9 @@ err_free_mem:
 	release_mem_region(r->start, resource_size(r));
 err_free_clk:
 	clk_put(pwm->clk);
+err_free_pwm:
+	pinmux_disable(pwm->pmx);
+	pinmux_put(pwm->pmx);
 err_free:
 	kfree(pwm);
 	return ret;
@@ -275,6 +286,8 @@ static int __devexit pwm_remove(struct platform_device *pdev)
 	release_mem_region(r->start, resource_size(r));
 
 	clk_put(pwm->clk);
+	pinmux_disable(pwm->pmx);
+	pinmux_put(pwm->pmx);
 	kfree(pwm);
 	return 0;
 }
-- 
1.7.0.4
