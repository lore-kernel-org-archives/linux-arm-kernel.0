From: jon-hunter@ti.com (Jon Hunter)
Date: Tue, 27 Nov 2012 20:15:15 -0600
Subject: [PATCH 3/3] ARM: AM335x: Fix warning in timer.c
In-Reply-To: <1354068915-3378-1-git-send-email-jon-hunter@ti.com>
References: <1354068915-3378-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1354068915-3378-4-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiling the kernel with configuration options ...

 # CONFIG_ARCH_OMAP2 is not set
 # CONFIG_ARCH_OMAP3 is not set
 # CONFIG_ARCH_OMAP4 is not set
 # CONFIG_SOC_OMAP5 is not set
 CONFIG_SOC_AM33XX=y

 ... the following build warning is seen.

  CC      arch/arm/mach-omap2/timer.o
  arch/arm/mach-omap2/timer.c:395:19: warning: ?omap2_sync32k_clocksource_init?
  	defined but not used [-Wunused-function]

This issue was introduced by commit 6f80b3b (ARM: OMAP2+: timer: remove
CONFIG_OMAP_32K_TIMER) where the omap2_sync32k_clocksource_init() is no
longer referenced by the timer initialisation function for the AM335x
device as it has no 32k-sync timer.

Fix this by only including the omap2_sync32k_clocksource_init() function
if either OMAP2, OMAP3, OMAP4 or OMAP5 devices are enabled.

Cc: Igor Grinberg <grinberg@compulab.co.il>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index eb96712..085c7e7 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -386,6 +386,8 @@ static u32 notrace dmtimer_read_sched_clock(void)
 	return 0;
 }
 
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
 static struct of_device_id omap_counter_match[] __initdata = {
 	{ .compatible = "ti,omap-counter32k", },
 	{ }
@@ -451,6 +453,7 @@ static int __init omap2_sync32k_clocksource_init(void)
 
 	return ret;
 }
+#endif
 
 static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 						const char *fck_source)
-- 
1.7.10.4
