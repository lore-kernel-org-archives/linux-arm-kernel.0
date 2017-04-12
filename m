From: rdunlap@infradead.org (Randy Dunlap)
Date: Wed, 12 Apr 2017 11:22:19 -0700
Subject: [PATCH -next] imx7: fix Kconfig warning and build errors
Message-ID: <47fc2167-bf0a-866a-e075-8247a10aa6e0@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Kconfig warning in drivers/soc/imx/Kconfig and subsequent build errors
elsewhere when CONFIG_PM is not enabled.

warning: (IMX7_PM_DOMAINS) selects PM_GENERIC_DOMAINS which has unmet direct dependencies (PM)

This warning causes multiple build errors in drivers/base/power/domain.c:

../drivers/base/power/domain.c: In function 'genpd_queue_power_off_work':
../drivers/base/power/domain.c:279:13: error: 'pm_wq' undeclared (first use in this function)
  queue_work(pm_wq, &genpd->power_off_work);
../drivers/base/power/domain.c: In function 'genpd_dev_pm_qos_notifier':
../drivers/base/power/domain.c:462:25: error: 'struct dev_pm_info' has no member named 'ignore_children'
   if (!dev || dev->power.ignore_children)
../drivers/base/power/domain.c: In function 'rtpm_status_str':
../drivers/base/power/domain.c:2207:16: error: 'struct dev_pm_info' has no member named 'runtime_error'
  if (dev->power.runtime_error)
../drivers/base/power/domain.c:2209:21: error: 'struct dev_pm_info' has no member named 'disable_depth'
  else if (dev->power.disable_depth)
../drivers/base/power/domain.c:2211:21: error: 'struct dev_pm_info' has no member named 'runtime_status'
  else if (dev->power.runtime_status < ARRAY_SIZE(status_lookup))
   p = status_lookup[dev->power.runtime_status];

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Shawn Guo <shawnguo@kernel.org>
Cc:	Sascha Hauer <kernel@pengutronix.de>
Cc:	Fabio Estevam <fabio.estevam@nxp.com>
Cc:	linux-arm-kernel at lists.infradead.org
---
 drivers/soc/imx/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20170412.orig/drivers/soc/imx/Kconfig
+++ linux-next-20170412/drivers/soc/imx/Kconfig
@@ -2,6 +2,7 @@ menu "i.MX SoC drivers"
 
 config IMX7_PM_DOMAINS
 	bool "i.MX7 PM domains"
+	depends on PM
 	select PM_GENERIC_DOMAINS
 	depends on SOC_IMX7D || (COMPILE_TEST && OF)
 	default y if SOC_IMX7D
