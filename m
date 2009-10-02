From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  2 Oct 2009 11:14:54 -0700
Subject: [PATCH 4/5] OMAP3: PM: USBHOST: clear wakeup events on both hosts
In-Reply-To: <1254507295-11381-4-git-send-email-khilman@deeprootsystems.com>
References: <1254507295-11381-1-git-send-email-khilman@deeprootsystems.com>
	<1254507295-11381-2-git-send-email-khilman@deeprootsystems.com>
	<1254507295-11381-3-git-send-email-khilman@deeprootsystems.com>
	<1254507295-11381-4-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1254507295-11381-5-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vikram Pandita <vikram.pandita@ti.com>

USBHOST module has 2 fclocks (for HOST1 and HOST2), only one iclock
and only a single bit in the WKST register to indicate a wakeup event.

Because of the single WKST bit, we cannot know whether a wakeup event
was on HOST1 or HOST2, so enable both fclocks before clearing the
wakeup event to ensure both hosts can properly clear the event.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d9440a1..cf6ea9f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -63,7 +63,7 @@ static struct powerdomain *mpu_pwrdm;
  */
 static int prcm_clear_mod_irqs(s16 module, u8 regs)
 {
-	u32 wkst, fclk, iclk;
+	u32 wkst, fclk, iclk, clken;
 	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
 	u16 fclk_off = (regs == 3) ? OMAP3430ES2_CM_FCLKEN3 : CM_FCLKEN1;
 	u16 iclk_off = (regs == 3) ? CM_ICLKEN3 : CM_ICLKEN1;
@@ -77,8 +77,15 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
 		iclk = cm_read_mod_reg(module, iclk_off);
 		fclk = cm_read_mod_reg(module, fclk_off);
 		while (wkst) {
-			cm_set_mod_reg_bits(wkst, module, iclk_off);
-			cm_set_mod_reg_bits(wkst, module, fclk_off);
+			clken = wkst;
+			cm_set_mod_reg_bits(clken, module, iclk_off);
+			/*
+			 * For USBHOST, we don't know whether HOST1 or
+			 * HOST2 woke us up, so enable both f-clocks
+			 */
+			if (module == OMAP3430ES2_USBHOST_MOD)
+				clken |= 1 << OMAP3430ES2_EN_USBHOST2_SHIFT;
+			cm_set_mod_reg_bits(clken, module, fclk_off);
 			prm_write_mod_reg(wkst, module, wkst_off);
 			wkst = prm_read_mod_reg(module, wkst_off);
 			c++;
-- 
1.6.4.3
