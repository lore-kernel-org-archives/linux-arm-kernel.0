From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Fri,  2 Mar 2018 18:57:54 +0100
Subject: [PATCH v9 2/5] drm/rockchip: inno_hdmi: Fix error handling path.
In-Reply-To: <20180302175757.28192-1-enric.balletbo@collabora.com>
References: <20180302175757.28192-1-enric.balletbo@collabora.com>
Message-ID: <20180302175757.28192-3-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeffy Chen <jeffy.chen@rock-chips.com>

Add missing error handling in bind().

Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
[moved clk_disable_unprepare reordering in unbind to separate patch]
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v9:
- Moved clk_disable_unprepare reordering in unbin to separate patch.

 drivers/gpu/drm/rockchip/inno_hdmi.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index f6ad48766d49..a5c661930250 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -849,8 +849,10 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto err_disable_clk;
+	}
 
 	inno_hdmi_reset(hdmi);
 
@@ -858,7 +860,7 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	if (IS_ERR(hdmi->ddc)) {
 		ret = PTR_ERR(hdmi->ddc);
 		hdmi->ddc = NULL;
-		return ret;
+		goto err_disable_clk;
 	}
 
 	/*
@@ -872,7 +874,7 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 
 	ret = inno_hdmi_register(drm, hdmi);
 	if (ret)
-		return ret;
+		goto err_put_adapter;
 
 	dev_set_drvdata(dev, hdmi);
 
@@ -882,7 +884,17 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	ret = devm_request_threaded_irq(dev, irq, inno_hdmi_hardirq,
 					inno_hdmi_irq, IRQF_SHARED,
 					dev_name(dev), hdmi);
+	if (ret < 0)
+		goto err_cleanup_hdmi;
 
+	return 0;
+err_cleanup_hdmi:
+	hdmi->connector.funcs->destroy(&hdmi->connector);
+	hdmi->encoder.funcs->destroy(&hdmi->encoder);
+err_put_adapter:
+	i2c_put_adapter(hdmi->ddc);
+err_disable_clk:
+	clk_disable_unprepare(hdmi->pclk);
 	return ret;
 }
 
-- 
2.16.1
