From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 15 May 2017 09:33:31 -0700
Subject: [PATCH] soc: imx: Select PM_GENERIC_DOMAINS only if PM is enabled
Message-ID: <1494866011-23360-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Selecting PM_GENERIC_DOMAINS without PM results in the following build
errors, seen when building sparc32:allmodconfig.

drivers/base/power/domain.c: In function 'genpd_queue_power_off_work':
drivers/base/power/domain.c:279:13: error: 'pm_wq' undeclared
drivers/base/power/domain.c: In function 'genpd_dev_pm_qos_notifier':
drivers/base/power/domain.c:462:25: error:
	'struct dev_pm_info' has no member named 'ignore_children'
drivers/base/power/domain.c: In function 'rtpm_status_str':
drivers/base/power/domain.c:2207:16: error:
	'struct dev_pm_info' has no member named 'runtime_error'
drivers/base/power/domain.c:2209:21: error:
	'struct dev_pm_info' has no member named 'disable_depth'
drivers/base/power/domain.c:2211:21: error:
	'struct dev_pm_info' has no member named 'runtime_status'
drivers/base/power/domain.c:2212:31: error:
	'struct dev_pm_info' has no member named 'runtime_status'

Fixes: 03aa12629fc4 ("soc: imx: Add GPCv2 power gating driver")
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/soc/imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 357a5d8f8da0..9c1c75f282c2 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -2,7 +2,7 @@ menu "i.MX SoC drivers"
 
 config IMX7_PM_DOMAINS
 	bool "i.MX7 PM domains"
-	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS if PM
 	depends on SOC_IMX7D || (COMPILE_TEST && OF)
 	default y if SOC_IMX7D
 
-- 
2.7.4
