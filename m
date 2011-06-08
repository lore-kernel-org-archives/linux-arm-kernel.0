From: khilman@ti.com (Kevin Hilman)
Date: Tue,  7 Jun 2011 17:05:02 -0700
Subject: [PATCH] OMAP1: PM: register notifiers with generic clock ops even
	when !PM_RUNTIME
Message-ID: <1307491502-28883-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When runtime PM is disabled, device clocks need to be enabled on
device add and disabled on device remove.  This currently is not
happening because in the !PM_RUNTIME case, no notifiers are registered
for OMAP1 devices.

Fix this by ensuring notifiers are registered, even in the !PM_RUNTIME case.

Reported-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Tested-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Tony, this fix should go in for v3.0-rc as well.

If you haven't pulled my pm-fixes branch, you can pull
for_3.0/pm-fixes-2 instead which includes this patch on top
of the original pull request.

 arch/arm/mach-omap1/Makefile |    4 ++--
 arch/arm/mach-omap1/pm_bus.c |    8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index af98117..5b114d1 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -4,14 +4,14 @@
 
 # Common support
 obj-y := io.o id.o sram.o time.o irq.o mux.o flash.o serial.o devices.o dma.o
-obj-y += clock.o clock_data.o opp_data.o reset.o
+obj-y += clock.o clock_data.o opp_data.o reset.o pm_bus.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
 obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
 
 # Power Management
-obj-$(CONFIG_PM) += pm.o sleep.o pm_bus.o
+obj-$(CONFIG_PM) += pm.o sleep.o
 
 # DSP
 obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
index fe31d93..334fb88 100644
--- a/arch/arm/mach-omap1/pm_bus.c
+++ b/arch/arm/mach-omap1/pm_bus.c
@@ -56,9 +56,13 @@ static struct dev_power_domain default_power_domain = {
 		USE_PLATFORM_PM_SLEEP_OPS
 	},
 };
+#define OMAP1_PWR_DOMAIN (&default_power_domain)
+#else
+#define OMAP1_PWR_DOMAIN NULL
+#endif /* CONFIG_PM_RUNTIME */
 
 static struct pm_clk_notifier_block platform_bus_notifier = {
-	.pwr_domain = &default_power_domain,
+	.pwr_domain = OMAP1_PWR_DOMAIN,
 	.con_ids = { "ick", "fck", NULL, },
 };
 
@@ -72,4 +76,4 @@ static int __init omap1_pm_runtime_init(void)
 	return 0;
 }
 core_initcall(omap1_pm_runtime_init);
-#endif /* CONFIG_PM_RUNTIME */
+
-- 
1.7.4
