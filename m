From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Mar 2016 16:59:06 +0100
Subject: [PATCH 14/14] ASoC: rockchip: use __maybe_unused to hide
 st_irq_syscfg_resume
In-Reply-To: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
Message-ID: <1456934350-1389172-15-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rockchip spdif driver uses SIMPLE_DEV_PM_OPS to conditionally
set its power management functions, but we get a warning
about rk_spdif_runtime_resume being unused when CONFIG_PM is not
set:

sound/soc/rockchip/rockchip_spdif.c:67:12: error: 'rk_spdif_runtime_resume' defined but not used [-Werror=unused-function]

This adds a __maybe_unused annotation so the compiler knows
it can silently drop it instead of warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/rockchip/rockchip_spdif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 5a806da89f42..274599d4caeb 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -54,7 +54,7 @@ static const struct of_device_id rk_spdif_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rk_spdif_match);
 
-static int rk_spdif_runtime_suspend(struct device *dev)
+static int __maybe_unused rk_spdif_runtime_suspend(struct device *dev)
 {
 	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
 
@@ -64,7 +64,7 @@ static int rk_spdif_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int rk_spdif_runtime_resume(struct device *dev)
+static int __maybe_unused rk_spdif_runtime_resume(struct device *dev)
 {
 	struct rk_spdif_dev *spdif = dev_get_drvdata(dev);
 	int ret;
-- 
2.7.0
