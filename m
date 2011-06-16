From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jun 2011 20:06:40 +0100
Subject: [RFC PATCH 12/16] ARM: watchdog: make mpcore_wdt independant from
	asm/smp_twd.h
In-Reply-To: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1308251204-16719-13-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the life expectancy of asm/smp_twd.h seems rather limited,
move the few defines concerning mpcore_wdt to the driver itself.

Change the dependency to ARM_SMP_TWD as well.

Cc: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/watchdog/Kconfig      |    2 +-
 drivers/watchdog/mpcore_wdt.c |    7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c70f82b..55647ac 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -197,7 +197,7 @@ config DW_WATCHDOG
 
 config MPCORE_WATCHDOG
 	tristate "MPcore watchdog"
-	depends on HAVE_ARM_TWD
+	depends on ARM_SMP_TWD
 	help
 	  Watchdog timer embedded into the MPcore system.
 
diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 2b4af22..f638206 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -33,7 +33,12 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 
-#include <asm/smp_twd.h>
+#define TWD_WDOG_LOAD			0x20
+#define TWD_WDOG_COUNTER		0x24
+#define TWD_WDOG_CONTROL		0x28
+#define TWD_WDOG_INTSTAT		0x2C
+#define TWD_WDOG_RESETSTAT		0x30
+#define TWD_WDOG_DISABLE		0x34
 
 struct mpcore_wdt {
 	unsigned long	timer_alive;
-- 
1.7.0.4
