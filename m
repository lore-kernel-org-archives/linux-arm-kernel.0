From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 15 Feb 2012 17:37:53 +0200
Subject: [PATCHv2 7/8] arm: omap: clockdomain: add support for preventing
 domain transitions
In-Reply-To: <1329320274-481-1-git-send-email-t-kristo@ti.com>
References: <1329320274-481-1-git-send-email-t-kristo@ti.com>
Message-ID: <1329320274-481-8-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clockdomains can't support manual domain transitions triggered by
clock framework, and must be prevented from doing so. Added clkdm flag
CLKDM_NO_MANUAL_TRANS for doing this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |    6 ++++++
 arch/arm/mach-omap2/clockdomain.h |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index c0b6187..850665d 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -944,6 +944,9 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
 	if ((clkdm_usecount_inc(clkdm) > 1) && autodeps)
 		return 0;
 
+	if (clkdm->flags & CLKDM_NO_MANUAL_TRANS)
+		return 0;
+
 	spin_lock_irqsave(&clkdm->lock, flags);
 	arch_clkdm->clkdm_clk_enable(clkdm);
 	pwrdm_wait_transition(clkdm->pwrdm.ptr);
@@ -970,6 +973,9 @@ static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
 	if (clkdm_usecount_dec(clkdm) > 0)
 		return 0;
 
+	if (clkdm->flags & CLKDM_NO_MANUAL_TRANS)
+		return 0;
+
 	spin_lock_irqsave(&clkdm->lock, flags);
 	arch_clkdm->clkdm_clk_disable(clkdm);
 	pwrdm_clkdm_state_switch(clkdm);
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index 373399a..8693bec 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -31,12 +31,15 @@
  *
  * CLKDM_NO_AUTODEPS: Prevent "autodeps" from being added/removed from this
  *     clockdomain.  (Currently, this applies to OMAP3 clockdomains only.)
+ * CLKDM_NO_MANUAL_TRANS: Prevent clockdomain code from attempting to change
+ *     clockdomain state manually. Needed for PER domain on omap3.
  */
 #define CLKDM_CAN_FORCE_SLEEP			(1 << 0)
 #define CLKDM_CAN_FORCE_WAKEUP			(1 << 1)
 #define CLKDM_CAN_ENABLE_AUTO			(1 << 2)
 #define CLKDM_CAN_DISABLE_AUTO			(1 << 3)
 #define CLKDM_NO_AUTODEPS			(1 << 4)
+#define CLKDM_NO_MANUAL_TRANS			(1 << 5)
 
 #define CLKDM_CAN_HWSUP		(CLKDM_CAN_ENABLE_AUTO | CLKDM_CAN_DISABLE_AUTO)
 #define CLKDM_CAN_SWSUP		(CLKDM_CAN_FORCE_SLEEP | CLKDM_CAN_FORCE_WAKEUP)
-- 
1.7.4.1
