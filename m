From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 23 Jun 2015 20:49:05 -0700
Subject: [PATCH v2] ARM: Fix build if CLKDEV_LOOKUP is not configured
Message-ID: <1435117745-19032-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mips:allmodconfig fails to build with

drivers/clocksource/timer-sp804.c:
	In function '__sp804_clocksource_and_sched_clock_init':
drivers/clocksource/timer-sp804.c:88:3: error:
	implicit declaration of function 'clk_get_sys'

because CLKDEV_LOOKUP is not configured and the driver depends on it.

Fixes: 0b7402dce445 ("ARM: 8366/1: move Dual-Timer SP804 driver to
	drivers/clocksource")
Cc: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added Ack
    Send to ARM mailing list and maintainer

 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 60d7d3d204d3..d2a26f1f30e9 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -144,7 +144,7 @@ config ARM_GLOBAL_TIMER
 
 config ARM_TIMER_SP804
 	bool "Support for Dual Timer SP804 module"
-	depends on GENERIC_SCHED_CLOCK
+	depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select CLKSRC_OF if OF
 
-- 
2.1.0
