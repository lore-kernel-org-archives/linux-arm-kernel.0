From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Tue, 17 Oct 2017 18:16:21 +0800
Subject: [RFC PATCH v4 5/8] drm/rockchip: inno_hdmi: Fix error handling path
In-Reply-To: <20171017101624.12506-1-jeffy.chen@rock-chips.com>
References: <20171017101624.12506-1-jeffy.chen@rock-chips.com>
Message-ID: <20171017101624.12506-6-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing error handling in bind().

Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/gpu/drm/rockchip/inno_hdmi.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index ee584d87111f..9c258b05dfa5 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -851,8 +851,10 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
+	if (irq < 0) {
+		ret = irq;
+		goto err_disable_clk;
+	}
 
 	inno_hdmi_reset(hdmi);
 
@@ -860,7 +862,7 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	if (IS_ERR(hdmi->ddc)) {
 		ret = PTR_ERR(hdmi->ddc);
 		hdmi->ddc = NULL;
-		return ret;
+		goto err_disable_clk;
 	}
 
 	/*
@@ -874,7 +876,7 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 
 	ret = inno_hdmi_register(drm, hdmi);
 	if (ret)
-		return ret;
+		goto err_put_adapter;
 
 	dev_set_drvdata(dev, hdmi);
 
@@ -884,7 +886,17 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 	ret = devm_request_threaded_irq(dev, irq, inno_hdmi_hardirq,
 					inno_hdmi_irq, IRQF_SHARED,
 					dev_name(dev), hdmi);
+	if (ret < 0)
+		goto err_cleanup_hdmi;
 
+	return 0;
+err_cleanup_hdmi:
+	drm_connector_cleanup(&hdmi->connector);
+	drm_encoder_cleanup(&hdmi->encoder);
+err_put_adapter:
+	i2c_put_adapter(hdmi->ddc);
+err_disable_clk:
+	clk_disable_unprepare(hdmi->pclk);
 	return ret;
 }
 
-- 
2.11.0
