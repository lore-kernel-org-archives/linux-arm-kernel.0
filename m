From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 04 Oct 2012 21:12:41 +0530
Subject: [PATCH v1 03/14] drm: exynos: hdmi: fix interrupt handling
In-Reply-To: <1349365372-21417-1-git-send-email-rahul.sharma@samsung.com>
References: <1349365372-21417-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1349365372-21417-4-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tomasz Stanislawski <t.stanislaws@samsung.com>

This patch fixes 'unsigned < 0' check in probe. Moreover it
releases an interrupt at remove.

Signed-off-by: Tomasz Stanislawski <t.stanislaws@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index b3a802b..3902917 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -64,8 +64,8 @@ struct hdmi_context {
 	struct mutex			hdmi_mutex;
 
 	void __iomem			*regs;
-	unsigned int			external_irq;
-	unsigned int			internal_irq;
+	int				external_irq;
+	int				internal_irq;
 
 	struct i2c_client		*ddc_port;
 	struct i2c_client		*hdmiphy_port;
@@ -2424,6 +2424,7 @@ static int __devexit hdmi_remove(struct platform_device *pdev)
 	pm_runtime_disable(dev);
 
 	free_irq(hdata->internal_irq, hdata);
+	free_irq(hdata->external_irq, hdata);
 
 	hdmi_resources_cleanup(hdata);
 
-- 
1.7.0.4
