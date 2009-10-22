From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 22 Oct 2009 16:09:40 -0700
Subject: [PATCH v2 19/32] OMAP3: PM: Fix PLL_MOD CLKEN offset in scratchpad
In-Reply-To: <1256252993-24328-19-git-send-email-khilman@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-4-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-14-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-15-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-16-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-17-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-18-git-send-email-khilman@deeprootsystems.com>
	<1256252993-24328-19-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1256252993-24328-20-git-send-email-khilman@deeprootsystems.com>
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

Problem reported by: Jouni Hogander <jouni.hogander@nokia.com>

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index b84cff7..c41565e 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -230,7 +230,7 @@ void omap3_save_scratchpad_contents(void)
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
