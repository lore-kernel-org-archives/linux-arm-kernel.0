From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 19 Oct 2016 15:34:16 +0530
Subject: [PATCH V2] gpu/drm/exynos/exynos_hdmi - Unmap region obtained by
 of_iomap
Message-ID: <1476871456-1098-1-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Free memory mapping, if hdmi_probe is not successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 2275efe..ba28dec 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1901,6 +1901,8 @@ err_disable_pm_runtime:
 err_hdmiphy:
 	if (hdata->hdmiphy_port)
 		put_device(&hdata->hdmiphy_port->dev);
+	if (hdata->regs_hdmiphy)
+		iounmap(hdata->regs_hdmiphy);
 err_ddc:
 	put_device(&hdata->ddc_adpt->dev);
 
@@ -1923,6 +1925,9 @@ static int hdmi_remove(struct platform_device *pdev)
 	if (hdata->hdmiphy_port)
 		put_device(&hdata->hdmiphy_port->dev);
 
+	if (hdata->regs_hdmiphy)
+		iounmap(hdata->regs_hdmiphy);
+
 	put_device(&hdata->ddc_adpt->dev);
 
 	return 0;
-- 
1.7.9.5
