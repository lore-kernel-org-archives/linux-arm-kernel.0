From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 20 Dec 2012 16:43:46 -0600
Subject: [PATCH] ARM: OMAP3: Add missing enable/disable for EMU clock
Message-ID: <1356043426-7381-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ETM/ETB drivers for OMAP3, enable the emu_src_ck clock in order
to access the ETM/ETB hardware. The emu_src_ck should enable the EMU
clock domain so that the ETM/ETB hardware is accessible. However,
currently when enabling the emu_src_ck the EMU clock domain is not
being enabled and so the ETM/ETB drivers are failing. Add enable/disable
clock functions to enable the EMU clock domain when enabling the
emu_src_ck.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/cclock3xxx_data.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index bdf3948..6ef8758 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -1167,6 +1167,8 @@ static const struct clk_ops emu_src_ck_ops = {
 	.recalc_rate	= &omap2_clksel_recalc,
 	.get_parent	= &omap2_clksel_find_parent_index,
 	.set_parent	= &omap2_clksel_set_parent,
+	.enable		= &omap2_clkops_enable_clkdm,
+	.disable	= &omap2_clkops_disable_clkdm,
 };
 
 static struct clk emu_src_ck;
-- 
1.7.10.4
