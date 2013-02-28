From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 28 Feb 2013 11:37:09 -0800
Subject: [PATCH] mfd: Fix AB8500 build failure if POWER_SUPPLY is not
 configured
Message-ID: <1362080229-27334-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ab8500-sysctrl.c fails to build if POWER_SUPPLY is not configured.

drivers/built-in.o: In function `ab8500_power_off':
drivers/mfd/ab8500-sysctrl.c:37: undefined reference to `power_supply_get_by_name'
drivers/mfd/ab8500-sysctrl.c:53: undefined reference to `power_supply_get_by_name'

Select POWER_SUPPLY in Kconfig if AB8500_CORE is configured to fix the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/mfd/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 671f5b1..d5511de 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -860,6 +860,7 @@ config AB8500_CORE
 	depends on GENERIC_HARDIRQS && ABX500_CORE && MFD_DB8500_PRCMU
 	select MFD_CORE
 	select IRQ_DOMAIN
+	select POWER_SUPPLY
 	help
 	  Select this option to enable access to AB8500 power management
 	  chip. This connects to U8500 either on the SSP/SPI bus (deprecated
-- 
1.7.9.7
