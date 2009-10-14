From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 14 Oct 2009 14:58:02 -0700
Subject: [PATCH 19/27] OMAP3: PM: Fix PLL_MOD CLKEN offset in scratchpad
In-Reply-To: <1255557490-16787-19-git-send-email-khilman@deeprootsystems.com>
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
	<1255557490-16787-15-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-16-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-17-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-18-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-19-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1255557490-16787-20-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

The CM_CLKEN_PLL register saved in scratchpad memory
was wrongly using offset of 0x0004 instead of 0x0000.

The effect of this was that boot ROM code would
restore the wrong value when waking up from off mode.
This wrong value, however, will be overwritten by
prcm context restore. Still, a short period of wrong
clock settings in CM_CLKEN_PLL remained between ROM
code and prcm context restore. This is fixed by the
patch.

Problem reported by: Jouni H?gander <jouni.hogander@nokia.com>

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 6c462c7..50b3afc 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -228,7 +228,7 @@ void omap3_save_scratchpad_contents(void)
 	prcm_block_contents.cm_clksel_wkup =
 			cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
 	prcm_block_contents.cm_clken_pll =
-			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKEN_PLL);
+			cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 	prcm_block_contents.cm_autoidle_pll =
 			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_AUTOIDLE_PLL);
 	prcm_block_contents.cm_clksel1_pll =
-- 
1.6.4.3
