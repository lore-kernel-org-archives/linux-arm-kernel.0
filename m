From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Mar 2016 16:59:01 +0100
Subject: [PATCH 09/14] amd-xgbe: use __maybe_unused to hide pm functions
In-Reply-To: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
Message-ID: <1456934350-1389172-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The amd-xgbe ethernet driver hides its suspend/resume functions
in #ifdef CONFIG_PM, but uses SIMPLE_DEV_PM_OPS() to make the
reference conditional on CONFIG_PM_SLEEP, which results in a
warning when PM_SLEEP is not set but PM is:

drivers/net/ethernet/amd/xgbe/xgbe-main.c:833:12: warning: 'xgbe_suspend' defined but not used [-Wunused-function]
drivers/net/ethernet/amd/xgbe/xgbe-main.c:853:12: warning: 'xgbe_resume' defined but not used [-Wunused-function]

This removes the incorrect #ifdef and instead uses a __maybe_unused
annotation to let the compiler know it can silently drop
the function definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/amd/xgbe/xgbe-main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-main.c b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
index 3eee3201b58f..a86f32106639 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-main.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
@@ -829,8 +829,7 @@ static int xgbe_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int xgbe_suspend(struct device *dev)
+static int __maybe_unused xgbe_suspend(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
@@ -850,7 +849,7 @@ static int xgbe_suspend(struct device *dev)
 	return ret;
 }
 
-static int xgbe_resume(struct device *dev)
+static int __maybe_unused xgbe_resume(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
@@ -868,7 +867,6 @@ static int xgbe_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM */
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id xgbe_acpi_match[] = {
-- 
2.7.0
