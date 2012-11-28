From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 28 Nov 2012 16:04:59 -0600
Subject: [PATCH V2 3/4] ARM: AM335x: Fix warning in timer.c
In-Reply-To: <1354140300-16825-1-git-send-email-jon-hunter@ti.com>
References: <1354140300-16825-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1354140300-16825-4-git-send-email-jon-hunter@ti.com>
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

Fix this by adding the "__maybe_unused" compiler directive to the
omap2_sync32k_clocksource_init() function to indicate that this function
may be used for certain configurations.

Cc: Igor Grinberg <grinberg@compulab.co.il>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 3bbb244..79df809 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -392,7 +392,7 @@ static struct of_device_id omap_counter_match[] __initdata = {
 };
 
 /* Setup free-running counter for clocksource */
-static int __init omap2_sync32k_clocksource_init(void)
+static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
 {
 	int ret;
 	struct device_node *np = NULL;
-- 
1.7.10.4
