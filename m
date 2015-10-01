From: s-anna@ti.com (Suman Anna)
Date: Thu, 1 Oct 2015 14:32:38 -0500
Subject: [PATCH 2/4] ARM: OMAP2+: timer: Remove secure timer for DRA7xx devices
In-Reply-To: <1443727960-32232-1-git-send-email-s-anna@ti.com>
References: <1443727960-32232-1-git-send-email-s-anna@ti.com>
Message-ID: <1443727960-32232-3-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Timer 12 on DRA7 SoCs is reserved for secure usage on high-secure (HS)
devices. The timer cannot be used by the kernel on HS devices, but is
available on regular general purpose (GP) devices. This is similar to the
behavior on OMAP3 devices, so extend the logic used in commit ad24bde8f102
("ARM: OMAP3: Dynamically disable secure timer nodes for secure devices")
to remove the secure timer on DRA7xx SoCs at run-time based on the SoC
device type.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index a55655127ef2..1e346aa0a687 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -193,8 +193,8 @@ static struct device_node * __init omap_get_timer_dt(const struct of_device_id *
 /**
  * omap_dmtimer_init - initialisation function when device tree is used
  *
- * For secure OMAP3 devices, timers with device type "timer-secure" cannot
- * be used by the kernel as they are reserved. Therefore, to prevent the
+ * For secure OMAP3/DRA7xx devices, timers with device type "timer-secure"
+ * cannot be used by the kernel as they are reserved. Therefore, to prevent the
  * kernel registering these devices remove them dynamically from the device
  * tree on boot.
  */
@@ -202,7 +202,7 @@ static void __init omap_dmtimer_init(void)
 {
 	struct device_node *np;
 
-	if (!cpu_is_omap34xx())
+	if (!cpu_is_omap34xx() && !soc_is_dra7xx())
 		return;
 
 	/* If we are a secure device, remove any secure timer nodes */
-- 
2.6.0
