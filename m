From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 May 2017 13:37:47 +0200
Subject: [PATCH] soc: imx: add PM dependency for IMX7_PM_DOMAINS
Message-ID: <20170511113806.2647189-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new pm domain driver causes a build failure when CONFIG_PM
is not set:

warning: (IMX7_PM_DOMAINS) selects PM_GENERIC_DOMAINS which has unmet direct dependencies (PM)
drivers/base/power/domain_governor.c: In function 'default_suspend_ok':
drivers/base/power/domain_governor.c:75:17: error: 'struct dev_pm_info' has no member named 'ignore_children'

This adds a dependency to ensure that we don't attempt to build the
driver without CONFIG_PM.

Fixes: 03aa12629fc4 ("soc: imx: Add GPCv2 power gating driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/imx/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 357a5d8f8da0..a5b86a28f343 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -2,8 +2,9 @@ menu "i.MX SoC drivers"
 
 config IMX7_PM_DOMAINS
 	bool "i.MX7 PM domains"
-	select PM_GENERIC_DOMAINS
 	depends on SOC_IMX7D || (COMPILE_TEST && OF)
+	depends on PM
+	select PM_GENERIC_DOMAINS
 	default y if SOC_IMX7D
 
 endmenu
-- 
2.9.0
