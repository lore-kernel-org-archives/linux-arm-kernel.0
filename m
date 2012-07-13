From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 13 Jul 2012 19:37:35 +0300
Subject: [RFC 2/6] ARM: OMAP3: clock data: prevent IVA2 DPLL low power stop
 mode
In-Reply-To: <1342197459-7920-1-git-send-email-t-kristo@ti.com>
References: <1342197459-7920-1-git-send-email-t-kristo@ti.com>
Message-ID: <1342197459-7920-3-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If IVA2 DPLL is in low power stop mode, this will prevent IVA2
powerdomain sleep transition. Typically the DPLL is in locked
autoidle mode, which will allow sleep. With the wrong config,
the DPLL will end up in the wrong mode if IVA2 clock is first
enabled, then disabled by SW. This happens for example once
IVA2 hwmod reset sequence is implemented properly within hwmod
preprogram hook, as the IVA2 clock must be enabled during this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 1efdec2..3b7e9c8 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -353,8 +353,7 @@ static struct dpll_data dpll2_dd = {
 	.freqsel_mask	= OMAP3430_IVA2_DPLL_FREQSEL_MASK,
 	.control_reg	= OMAP_CM_REGADDR(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKEN_PLL),
 	.enable_mask	= OMAP3430_EN_IVA2_DPLL_MASK,
-	.modes		= (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED) |
-				(1 << DPLL_LOW_POWER_BYPASS),
+	.modes		= (1 << DPLL_LOCKED) | (1 << DPLL_LOW_POWER_BYPASS),
 	.auto_recal_bit	= OMAP3430_EN_IVA2_DPLL_DRIFTGUARD_SHIFT,
 	.recal_en_bit	= OMAP3430_PRM_IRQENABLE_MPU_IVA2_DPLL_RECAL_EN_SHIFT,
 	.recal_st_bit	= OMAP3430_PRM_IRQSTATUS_MPU_IVA2_DPLL_ST_SHIFT,
-- 
1.7.4.1
