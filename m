From: nm@ti.com (Nishanth Menon)
Date: Tue,  4 Jan 2011 14:07:13 -0600
Subject: [PATCH 4/5] omap2+: wdt: trivial sparse fixes
In-Reply-To: <1294171634-13943-1-git-send-email-nm@ti.com>
References: <1294171634-13943-1-git-send-email-nm@ti.com>
Message-ID: <1294171634-13943-5-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap2_wd_timer_disable is declared in wdtimer.h and used by hwmod
function pointers for usage, the header inclusion is necessary
to ensure that the prototype and function remains consistent.
omap_wdt_latency is passed as a pointer and does not need global scope

Fixes sparse warnings:
arch/arm/mach-omap2/devices.c:981:31: warning: symbol 'omap_wdt_latency' was not declared. Should it be static?
arch/arm/mach-omap2/wd_timer.c:27:5: warning: symbol 'omap2_wd_timer_disable' was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/devices.c  |    2 +-
 arch/arm/mach-omap2/wd_timer.c |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 381f4eb..2c9c912 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -978,7 +978,7 @@ static int __init omap2_init_devices(void)
 arch_initcall(omap2_init_devices);
 
 #if defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
-struct omap_device_pm_latency omap_wdt_latency[] = {
+static struct omap_device_pm_latency omap_wdt_latency[] = {
 	[0] = {
 		.deactivate_func = omap_device_idle_hwmods,
 		.activate_func   = omap_device_enable_hwmods,
diff --git a/arch/arm/mach-omap2/wd_timer.c b/arch/arm/mach-omap2/wd_timer.c
index b0c4907..4067669 100644
--- a/arch/arm/mach-omap2/wd_timer.c
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -13,6 +13,8 @@
 
 #include <plat/omap_hwmod.h>
 
+#include "wd_timer.h"
+
 /*
  * In order to avoid any assumptions from bootloader regarding WDT
  * settings, WDT module is reset during init. This enables the watchdog
-- 
1.6.3.3
