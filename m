From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 14 Oct 2009 14:57:57 -0700
Subject: [PATCH 14/27] OMAP3: PM: save secure RAM only during init
In-Reply-To: <1255557490-16787-14-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-9-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-10-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-11-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-12-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-13-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-14-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255557490-16787-15-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <tero.kristo@nokia.com>

The function omap3_save_secure_ram() is now called only once during
the initialization of the device and consequent sleep cycles will
re-use the same saved contents for secure RAM. Users who need secure
services should do secure RAM saving before entering off-mode, if a
secure service has been accessed after last save.

There are both latency and reliability issues with saving secure RAM
context in the idle path. The context save uses a hardware resource
which takes an order of hundreds of milliseconds to initialize after a
wake up from off-mode, and also there is no way of checking whether it
is ready from kernel side or not. It just crashes if you use it too
quickly

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b8055f9..ab8f66a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -113,6 +113,12 @@ static void omap3_core_restore_context(void)
 	omap_dma_global_context_restore();
 }
 
+/*
+ * FIXME: This function should be called before entering off-mode after
+ * OMAP3 secure services have been accessed. Currently it is only called
+ * once during boot sequence, but this works as we are not using secure
+ * services.
+ */
 static void omap3_save_secure_ram_context(u32 target_mpu_state)
 {
 	u32 ret;
@@ -338,7 +344,6 @@ static void omap_sram_idle(void)
 		if (core_next_state == PWRDM_POWER_OFF) {
 			omap3_core_save_context();
 			omap3_prcm_save_context();
-			omap3_save_secure_ram_context(mpu_next_state);
 		}
 		/* Enable IO-PAD wakeup */
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
@@ -1002,6 +1007,18 @@ static int __init omap3_pm_init(void)
 	}
 	omap3_save_scratchpad_contents();
 
+	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
+		local_irq_disable();
+		local_fiq_disable();
+
+		omap_dma_global_context_save();
+		omap3_save_secure_ram_context(PWRDM_POWER_ON);
+		omap_dma_global_context_restore();
+
+		local_irq_enable();
+		local_fiq_enable();
+	}
+
 err1:
 	return ret;
 err2:
-- 
1.6.4.3
