From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  7 Mar 2014 12:22:15 -0700
Subject: [PATCH 2/4] pinctrl: tegra: init Tegra20/30 at module_init time
In-Reply-To: <1394220137-16351-1-git-send-email-swarren@wwwdotorg.org>
References: <1394220137-16351-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1394220137-16351-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

The Tegra20/30 pinctrl drivers currently initializes at arch_initcall,
whereas Tegra114/124 pinctrl drivers initialize at module_init time.
Convert Tegra20/30 to work the same way as the other drivers.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/pinctrl/pinctrl-tegra20.c | 13 +------------
 drivers/pinctrl/pinctrl-tegra30.c | 13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-tegra20.c b/drivers/pinctrl/pinctrl-tegra20.c
index fcfb7d012c5b..a8ceb08172b2 100644
--- a/drivers/pinctrl/pinctrl-tegra20.c
+++ b/drivers/pinctrl/pinctrl-tegra20.c
@@ -2881,18 +2881,7 @@ static struct platform_driver tegra20_pinctrl_driver = {
 	.probe = tegra20_pinctrl_probe,
 	.remove = tegra_pinctrl_remove,
 };
-
-static int __init tegra20_pinctrl_init(void)
-{
-	return platform_driver_register(&tegra20_pinctrl_driver);
-}
-arch_initcall(tegra20_pinctrl_init);
-
-static void __exit tegra20_pinctrl_exit(void)
-{
-	platform_driver_unregister(&tegra20_pinctrl_driver);
-}
-module_exit(tegra20_pinctrl_exit);
+module_platform_driver(tegra20_pinctrl_driver);
 
 MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra20 pinctrl driver");
diff --git a/drivers/pinctrl/pinctrl-tegra30.c b/drivers/pinctrl/pinctrl-tegra30.c
index 2300deba25bd..4e591f62cfa1 100644
--- a/drivers/pinctrl/pinctrl-tegra30.c
+++ b/drivers/pinctrl/pinctrl-tegra30.c
@@ -3745,18 +3745,7 @@ static struct platform_driver tegra30_pinctrl_driver = {
 	.probe = tegra30_pinctrl_probe,
 	.remove = tegra_pinctrl_remove,
 };
-
-static int __init tegra30_pinctrl_init(void)
-{
-	return platform_driver_register(&tegra30_pinctrl_driver);
-}
-arch_initcall(tegra30_pinctrl_init);
-
-static void __exit tegra30_pinctrl_exit(void)
-{
-	platform_driver_unregister(&tegra30_pinctrl_driver);
-}
-module_exit(tegra30_pinctrl_exit);
+module_platform_driver(tegra30_pinctrl_driver);
 
 MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra30 pinctrl driver");
-- 
1.8.1.5
