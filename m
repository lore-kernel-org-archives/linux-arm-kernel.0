From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Feb 2016 22:08:42 +0100
Subject: [PATCH 8/8] drm: msm: separate out module driver registration
In-Reply-To: <1456175331-714117-1-git-send-email-arnd@arndb.de>
References: <1456175331-714117-1-git-send-email-arnd@arndb.de>
Message-ID: <1456175331-714117-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The msm driver currently has a single module_init() function but
consists of multiple modules that each register a platform driver.

This changes the msm_drm_register() function to not call the
other functions but instead rely on module load order and/or
link order to ensure that the other modules were probed earlier.

The patch is not tested but should not change behavior.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/msm/dsi/dsi.c         | 17 ++++++++++++-----
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c |  2 +-
 drivers/gpu/drm/msm/edp/edp.c         | 15 +--------------
 drivers/gpu/drm/msm/hdmi/hdmi.c       | 16 +++++++++++-----
 drivers/gpu/drm/msm/hdmi/hdmi.h       |  2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c   |  2 +-
 drivers/gpu/drm/msm/msm_drv.c         |  6 ------
 drivers/gpu/drm/msm/msm_drv.h         | 28 ----------------------------
 8 files changed, 27 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 8523a7cdc419..db260814dfff 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -172,21 +172,28 @@ static struct platform_driver dsi_driver = {
 	},
 };
 
-void __init msm_dsi_register(void)
+static int __init msm_dsi_register(void)
 {
+	int ret;
+
 	DBG("");
 	msm_dsi_phy_driver_register();
-	platform_driver_register(&dsi_driver);
+	ret = platform_driver_register(&dsi_driver);
+
+	if (ret)
+		msm_dsi_phy_driver_unregister();
+
+	return ret;
 }
-EXPORT_SYMBOL_GPL(msm_dsi_register);
+module_init(msm_dsi_register);
 
-void __exit msm_dsi_unregister(void)
+static void __exit msm_dsi_unregister(void)
 {
 	DBG("");
 	msm_dsi_phy_driver_unregister();
 	platform_driver_unregister(&dsi_driver);
 }
-EXPORT_SYMBOL_GPL(msm_dsi_unregister);
+module_exit(msm_dsi_unregister);
 
 int msm_dsi_modeset_init(struct msm_dsi *msm_dsi, struct drm_device *dev,
 		struct drm_encoder *encoders[MSM_DSI_ENCODER_NUM])
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 91a95fb04a4a..ab7106c150da 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -393,7 +393,7 @@ void __init msm_dsi_phy_driver_register(void)
 	platform_driver_register(&dsi_phy_platform_driver);
 }
 
-void __exit msm_dsi_phy_driver_unregister(void)
+void msm_dsi_phy_driver_unregister(void)
 {
 	platform_driver_unregister(&dsi_phy_platform_driver);
 }
diff --git a/drivers/gpu/drm/msm/edp/edp.c b/drivers/gpu/drm/msm/edp/edp.c
index 48645d0d649a..fb952bb4e0e0 100644
--- a/drivers/gpu/drm/msm/edp/edp.c
+++ b/drivers/gpu/drm/msm/edp/edp.c
@@ -131,20 +131,7 @@ static struct platform_driver edp_driver = {
 		.of_match_table = dt_match,
 	},
 };
-
-void __init msm_edp_register(void)
-{
-	DBG("");
-	platform_driver_register(&edp_driver);
-}
-EXPORT_SYMBOL_GPL(msm_edp_register);
-
-void __exit msm_edp_unregister(void)
-{
-	DBG("");
-	platform_driver_unregister(&edp_driver);
-}
-EXPORT_SYMBOL_GPL(msm_edp_unregister);
+module_platform_driver(edp_driver);
 
 /* Second part of initialization, the drm/kms level modeset_init */
 int msm_edp_modeset_init(struct msm_edp *edp, struct drm_device *dev,
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 8e01d942d1c9..20c77d933556 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -518,16 +518,22 @@ static struct platform_driver msm_hdmi_driver = {
 	},
 };
 
-void __init msm_hdmi_register(void)
+static int __init msm_hdmi_register(void)
 {
+	int ret;
+
 	msm_hdmi_phy_driver_register();
-	platform_driver_register(&msm_hdmi_driver);
+	ret = platform_driver_register(&msm_hdmi_driver);
+	if (ret)
+		msm_hdmi_phy_driver_unregister();
+
+	return ret;
 }
-EXPORT_SYMBOL_GPL(msm_hdmi_register);
+module_init(msm_hdmi_register);
 
-void __exit msm_hdmi_unregister(void)
+static void __exit msm_hdmi_unregister(void)
 {
 	platform_driver_unregister(&msm_hdmi_driver);
 	msm_hdmi_phy_driver_unregister();
 }
-EXPORT_SYMBOL_GPL(msm_hdmi_unregister);
+module_exit(msm_hdmi_unregister);
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index b04a64664673..23702d0057e4 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -190,7 +190,7 @@ void msm_hdmi_phy_resource_disable(struct hdmi_phy *phy);
 void msm_hdmi_phy_powerup(struct hdmi_phy *phy, unsigned long int pixclock);
 void msm_hdmi_phy_powerdown(struct hdmi_phy *phy);
 void __init msm_hdmi_phy_driver_register(void);
-void __exit msm_hdmi_phy_driver_unregister(void);
+void msm_hdmi_phy_driver_unregister(void);
 
 #ifdef CONFIG_COMMON_CLK
 int msm_hdmi_pll_8960_init(struct platform_device *pdev);
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index 5530631e2d49..05ca860add6d 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -222,7 +222,7 @@ void __init msm_hdmi_phy_driver_register(void)
 	platform_driver_register(&msm_hdmi_phy_platform_driver);
 }
 
-void __exit msm_hdmi_phy_driver_unregister(void)
+void msm_hdmi_phy_driver_unregister(void)
 {
 	platform_driver_unregister(&msm_hdmi_phy_platform_driver);
 }
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 5430ea7d2375..3d04cd922cf0 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -954,9 +954,6 @@ static struct platform_driver msm_platform_driver = {
 static int __init msm_drm_register(void)
 {
 	DBG("init");
-	msm_dsi_register();
-	msm_edp_register();
-	msm_hdmi_register();
 	adreno_register();
 	return platform_driver_register(&msm_platform_driver);
 }
@@ -965,10 +962,7 @@ static void __exit msm_drm_unregister(void)
 {
 	DBG("fini");
 	platform_driver_unregister(&msm_platform_driver);
-	msm_hdmi_unregister();
 	adreno_unregister();
-	msm_edp_unregister();
-	msm_dsi_unregister();
 }
 
 module_init(msm_drm_register);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 905c17e373e7..abb15334bfa3 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -247,39 +247,19 @@ struct hdmi;
 #if IS_ENABLED(CONFIG_DRM_MSM_HDMI)
 int msm_hdmi_modeset_init(struct hdmi *hdmi, struct drm_device *dev,
 		struct drm_encoder *encoder);
-void __init msm_hdmi_register(void);
-void __exit msm_hdmi_unregister(void);
 #else
 static inline int msm_hdmi_modeset_init(struct hdmi *hdmi, struct drm_device *dev,
 				    struct drm_encoder *encoder)
 {
 	return -EINVAL;
 }
-
-static inline void __init msm_hdmi_register(void)
-{
-}
-
-static inline void __exit msm_hdmi_unregister(void)
-{
-}
 #endif
 
 struct msm_edp;
 #if IS_ENABLED(CONFIG_DRM_MSM_EDP)
-void __init msm_edp_register(void);
-void __exit msm_edp_unregister(void);
 int msm_edp_modeset_init(struct msm_edp *edp, struct drm_device *dev,
 		struct drm_encoder *encoder);
 #else
-static inline void __init msm_edp_register(void)
-{
-}
-
-static inline void __exit msm_edp_unregister(void)
-{
-}
-
 static inline int msm_edp_modeset_init(struct msm_edp *edp,
 				       struct drm_device *dev,
 				       struct drm_encoder *encoder)
@@ -295,17 +275,9 @@ enum msm_dsi_encoder_id {
 	MSM_DSI_ENCODER_NUM = 2
 };
 #if IS_ENABLED(CONFIG_DRM_MSM_DSI)
-void __init msm_dsi_register(void);
-void __exit msm_dsi_unregister(void);
 int msm_dsi_modeset_init(struct msm_dsi *msm_dsi, struct drm_device *dev,
 		struct drm_encoder *encoders[MSM_DSI_ENCODER_NUM]);
 #else
-static inline void __init msm_dsi_register(void)
-{
-}
-static inline void __exit msm_dsi_unregister(void)
-{
-}
 static inline int msm_dsi_modeset_init(struct msm_dsi *msm_dsi,
 		struct drm_device *dev,
 		struct drm_encoder *encoders[MSM_DSI_ENCODER_NUM])
-- 
2.7.0
