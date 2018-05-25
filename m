From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 May 2018 23:07:42 +0200
Subject: [PATCH] mmc: sunxi: mark PM functions as __maybe_unused
Message-ID: <20180525210752.1794502-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added runtime-pm functions cause a harmless warning
when CONFIG_PM is disabled:

drivers/mmc/host/sunxi-mmc.c:1452:12: error: 'sunxi_mmc_runtime_suspend' defined but not used [-Werror=unused-function]
 static int sunxi_mmc_runtime_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/sunxi-mmc.c:1435:12: error: 'sunxi_mmc_runtime_resume' defined but not used [-Werror=unused-function]
 static int sunxi_mmc_runtime_resume(struct device *dev)

This marks them as __maybe_unused to shut up the warning.

Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/sunxi-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 97c6b79b7d6f..837888b96bd3 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1432,7 +1432,7 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int sunxi_mmc_runtime_resume(struct device *dev)
+static int __maybe_unused sunxi_mmc_runtime_resume(struct device *dev)
 {
 	struct mmc_host	*mmc = dev_get_drvdata(dev);
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
@@ -1449,7 +1449,7 @@ static int sunxi_mmc_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int sunxi_mmc_runtime_suspend(struct device *dev)
+static int __maybe_unused sunxi_mmc_runtime_suspend(struct device *dev)
 {
 	struct mmc_host	*mmc = dev_get_drvdata(dev);
 	struct sunxi_mmc_host *host = mmc_priv(mmc);
-- 
2.9.0
