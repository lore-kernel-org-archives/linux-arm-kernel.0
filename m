From: baolin.wang@linaro.org (Baolin Wang)
Date: Mon, 14 May 2018 16:55:33 +0800
Subject: [RFC PATCH 07/10] clocksource: timer-ti-32k: Register the persistent
 clock
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
Message-ID: <353359ad77f87c01e9cc5a5fce382dbf6e9318e6.1526285602.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the 32K counter is always available, then we can register the
persistent clock to compensate the suspend time for the OS time.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/Kconfig        |    1 +
 drivers/clocksource/timer-ti-32k.c |    4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 884719c..ed19757 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -262,6 +262,7 @@ config CLKSRC_TI_32K
 	bool "Texas Instruments 32.768 Hz Clocksource" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK
 	select TIMER_OF if OF
+	select PERSISTENT_CLOCK
 	help
 	  This option enables support for Texas Instruments 32.768 Hz clocksource
 	  available on many OMAP-like platforms.
diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-ti-32k.c
index 880a861..353ff9d 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -41,6 +41,7 @@
 #include <linux/clocksource.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/persistent_clock.h>
 
 /*
  * 32KHz clocksource ... always available, on pretty most chips except
@@ -120,6 +121,9 @@ static int __init ti_32k_timer_init(struct device_node *np)
 	}
 
 	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
+	persistent_clock_init_and_register(omap_32k_read_sched_clock,
+					   CLOCKSOURCE_MASK(32), 32768, 0);
+
 	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
 
 	return 0;
-- 
1.7.9.5
