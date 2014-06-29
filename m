From: a.heider@gmail.com (Andre Heider)
Date: Sun, 29 Jun 2014 18:21:39 +0200
Subject: [PATCH 05/13] ARM: OMAP2+: hwmod: Introduce a flag to deassert the HW
 reset line
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Message-ID: <1404058907-21112-6-git-send-email-a.heider@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hwmod's hardreset lines are not deasserted after a reset.
Add the HWMOD_INIT_DEASSERT_HARD_RESET flag to deassert those after a
successful reset.

This is required to get the PRU-ICSS in a usable state on am33xx SoCs.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 2 ++
 arch/arm/mach-omap2/omap_hwmod.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index f7bb435..1e56b65 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2622,6 +2622,8 @@ static int __init _setup_reset(struct omap_hwmod *oh)
 
 	if (!(oh->flags & HWMOD_INIT_NO_RESET))
 		r = _reset(oh);
+	if (!r && oh->flags & HWMOD_INIT_DEASSERT_HARD_RESET)
+		r = _deassert_hardreset(oh, oh->name);
 
 	return r;
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index 0f97d63..c41d44d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -514,6 +514,7 @@ struct omap_hwmod_omap4_prcm {
  * HWMOD_SWSUP_SIDLE_ACT: omap_hwmod code should manually bring the module
  *     out of idle, but rely on smart-idle to the put it back in idle,
  *     so the wakeups are still functional (Only known case for now is UART)
+ * HWMOD_INIT_DEASSERT_HARD_RESET: deassert the HW reset line at boot
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -528,6 +529,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_BLOCK_WFI				(1 << 10)
 #define HWMOD_FORCE_MSTANDBY			(1 << 11)
 #define HWMOD_SWSUP_SIDLE_ACT			(1 << 12)
+#define HWMOD_INIT_DEASSERT_HARD_RESET		(1 << 13)
 
 /*
  * omap_hwmod._int_flags definitions
-- 
2.0.0
