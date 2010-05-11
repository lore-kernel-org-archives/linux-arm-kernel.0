From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 11 May 2010 16:47:11 -0700
Subject: [PATCH 6/6] OMAP3: PM: Remove PER wakeup dependency on CORE.
In-Reply-To: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
References: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273621631-9148-7-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mike Chan <mike@android.com>

We can remove this wakeup dependency since now, when
GPIO2-6 are enabled for IO-pad wakeup, PER domain is gauranteed
to be awake or be woken up to service.

The previous dependency did not handle all corner cases. Since there
was no sleep dependency between CORE and PER domains, if PER enters
RET and CORE is ON, PER will not be active for GPIO handling.

Signed-off-by: Mike Chan <mike@android.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index eec0916..1d71698 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1096,14 +1096,6 @@ static int __init omap3_pm_init(void)
 	omap3_idle_init();
 
 	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
-	/*
-	 * REVISIT: This wkdep is only necessary when GPIO2-6 are enabled for
-	 * IO-pad wakeup.  Otherwise it will unnecessarily waste power
-	 * waking up PER with every CORE wakeup - see
-	 * http://marc.info/?l=linux-omap&m=121852150710062&w=2
-	*/
-	clkdm_add_wkdep(per_clkdm, core_clkdm);
-
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		omap3_secure_ram_storage =
 			kmalloc(0x803F, GFP_KERNEL);
-- 
1.7.0.2
