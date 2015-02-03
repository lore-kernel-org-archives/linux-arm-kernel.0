From: ykk@rock-chips.com (Yakir Yang)
Date: Tue,  3 Feb 2015 10:08:59 -0500
Subject: [PATCH v3 03/15] drm: rockchip/dw_hdmi_rockchip: add resume/suspend
 support
In-Reply-To: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
References: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1422976139-30024-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v3:
- Setting the .pm member instead of suspend/resume

Changes in v2:
- Add suspend/resume support for dw_hdmi_rockchip driver

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index d236faa..fc1d02e 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -323,11 +323,27 @@ static int dw_hdmi_rockchip_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int dw_hdmi_rockchip_suspend(struct device *dev)
+{
+	return dw_hdmi_suspend(dev);
+}
+
+static int dw_hdmi_rockchip_resume(struct device *dev)
+{
+	return dw_hdmi_resume(dev);
+}
+
+static const struct dev_pm_ops dw_hdmi_rockchip_pm = {
+	.resume = dw_hdmi_rockchip_resume,
+	.suspend = dw_hdmi_rockchip_suspend,
+};
+
 static struct platform_driver dw_hdmi_rockchip_pltfm_driver = {
 	.probe  = dw_hdmi_rockchip_probe,
 	.remove = dw_hdmi_rockchip_remove,
 	.driver = {
 		.name = "dwhdmi-rockchip",
+		.pm = &dw_hdmi_rockchip_pm,
 		.of_match_table = dw_hdmi_rockchip_dt_ids,
 	},
 };
-- 
2.1.2
