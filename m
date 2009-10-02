From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  2 Oct 2009 11:14:52 -0700
Subject: [PATCH 2/5] OMAP3: PM: PRCM interrupt: check MPUGRPSEL register
In-Reply-To: <1254507295-11381-2-git-send-email-khilman@deeprootsystems.com>
References: <1254507295-11381-1-git-send-email-khilman@deeprootsystems.com>
	<1254507295-11381-2-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1254507295-11381-3-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Paul Walmsley <paul@pwsan.com>

PM_WKST register contents should be ANDed with the contents of the
MPUGRPSEL registers.  Otherwise the MPU PRCM interrupt handler could
wind up clearing wakeup events meant for the IVA PRCM interrupt
handler. A future revision to this code should be to read a cached
version of MPUGRPSEL from the powerdomain code, since PRM reads are
relatively slow.

Updated after Jon Hunter's PRCM IRQ change by Kevin Hilman

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1e7aae2..0e7bd8e 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -67,8 +67,11 @@ static void prcm_clear_mod_irqs(s16 module, u8 regs)
 	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
 	u16 fclk_off = (regs == 3) ? OMAP3430ES2_CM_FCLKEN3 : CM_FCLKEN1;
 	u16 iclk_off = (regs == 3) ? CM_ICLKEN3 : CM_ICLKEN1;
+	u16 grpsel_off = (regs == 3) ?
+		OMAP3430ES2_PM_MPUGRPSEL3 : OMAP3430_PM_MPUGRPSEL;
 
 	wkst = prm_read_mod_reg(module, wkst_off);
+	wkst &= prm_read_mod_reg(module, grpsel_off);
 	if (wkst) {
 		iclk = cm_read_mod_reg(module, iclk_off);
 		fclk = cm_read_mod_reg(module, fclk_off);
-- 
1.6.4.3
