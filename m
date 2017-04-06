From: you@example.com (Your Name)
Date: Thu,  6 Apr 2017 20:22:18 +0800
Subject: [PATCH v4 07/12] drm/rockchip: vop: Enable pm domain before
 vop_initial
In-Reply-To: <1491481343-11025-1-git-send-email-you@example.com>
References: <1491481343-11025-1-git-send-email-you@example.com>
Message-ID: <1491481343-11025-8-git-send-email-you@example.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeffy Chen <jeffy.chen@rock-chips.com>

We're trying to access vop registers here, so need to make sure
the pm domain is on.

Normally it should be enabled by the bootloader, but there's no
guarantee of it. And if we wanna do unbind/bind, it would also
cause the device to hang.

And this patch also does these:
1/ move vop_initial to the end of vop_bind for eaiser error handling.
2/ correct the err_put_pm_runtime of vop_enable.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Your Name <you@example.com>
---

Changes in v4: None
Changes in v3:
Address Sean Paul <seanpaul@chromium.org>'s comments.
Update commit message.

Changes in v2: None

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 2151e1c..b65b296 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -506,7 +506,7 @@ static int vop_enable(struct drm_crtc *crtc)
 	ret = pm_runtime_get_sync(vop->dev);
 	if (ret < 0) {
 		dev_err(vop->dev, "failed to get pm runtime: %d\n", ret);
-		goto err_put_pm_runtime;
+		return ret;
 	}
 
 	ret = clk_enable(vop->hclk);
@@ -1405,10 +1405,16 @@ static int vop_initial(struct vop *vop)
 		return PTR_ERR(vop->dclk);
 	}
 
+	ret = pm_runtime_get_sync(vop->dev);
+	if (ret < 0) {
+		dev_err(vop->dev, "failed to get pm runtime: %d\n", ret);
+		return ret;
+	}
+
 	ret = clk_prepare(vop->dclk);
 	if (ret < 0) {
 		dev_err(vop->dev, "failed to prepare dclk\n");
-		return ret;
+		goto err_put_pm_runtime;
 	}
 
 	/* Enable both the hclk and aclk to setup the vop */
@@ -1468,6 +1474,8 @@ static int vop_initial(struct vop *vop)
 
 	vop->is_enabled = false;
 
+	pm_runtime_put_sync(vop->dev);
+
 	return 0;
 
 err_disable_aclk:
@@ -1476,6 +1484,8 @@ static int vop_initial(struct vop *vop)
 	clk_disable_unprepare(vop->hclk);
 err_unprepare_dclk:
 	clk_unprepare(vop->dclk);
+err_put_pm_runtime:
+	pm_runtime_put_sync(vop->dev);
 	return ret;
 }
 
@@ -1576,12 +1586,6 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 	if (!vop->regsbak)
 		return -ENOMEM;
 
-	ret = vop_initial(vop);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot initial vop dev - err %d\n", ret);
-		return ret;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "cannot find irq for vop\n");
@@ -1608,8 +1612,17 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 
 	pm_runtime_enable(&pdev->dev);
 
+	ret = vop_initial(vop);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cannot initial vop dev - err %d\n", ret);
+		goto err_disable_pm_runtime;
+	}
+
 	return 0;
 
+err_disable_pm_runtime:
+	pm_runtime_disable(&pdev->dev);
+	vop_destroy_crtc(vop);
 err_enable_irq:
 	enable_irq(vop->irq); /* To balance out the disable_irq above */
 	return ret;
-- 
2.1.4
