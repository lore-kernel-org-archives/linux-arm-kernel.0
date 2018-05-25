From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 May 2018 17:50:08 +0200
Subject: [PATCH 1/8] drm/sun4i: mark PM functions as __maybe_unused
Message-ID: <20180525155030.3667352-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Disabling CONFIG_PM produces a compile time warning when these
functions are not referenced:

drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:1072:12: error: 'sun6i_dsi_runtime_suspend' defined but not used [-Werror=unused-function]
 static int sun6i_dsi_runtime_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c:1043:12: error: 'sun6i_dsi_runtime_resume' defined but not used [-Werror=unused-function]
 static int sun6i_dsi_runtime_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 133add5b5ad4 ("drm/sun4i: Add Allwinner A31 MIPI-DSI controller support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index bfbf761f0c1d..d4e7d16a2514 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1040,7 +1040,7 @@ static int sun6i_dsi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int sun6i_dsi_runtime_resume(struct device *dev)
+static int __maybe_unused sun6i_dsi_runtime_resume(struct device *dev)
 {
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
 
@@ -1069,7 +1069,7 @@ static int sun6i_dsi_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int sun6i_dsi_runtime_suspend(struct device *dev)
+static int __maybe_unused sun6i_dsi_runtime_suspend(struct device *dev)
 {
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
 
-- 
2.9.0
