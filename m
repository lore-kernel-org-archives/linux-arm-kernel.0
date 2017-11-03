From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 3 Nov 2017 16:26:36 +0200
Subject: [PATCH 2/7] ARM: OMAP4: CMINST: add support for translating clkctrl
 addresses
In-Reply-To: <1509719201-32700-1-git-send-email-t-kristo@ti.com>
References: <1509719201-32700-1-git-send-email-t-kristo@ti.com>
Message-ID: <1509719201-32700-3-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?Needed to map clkctrl clocks against hwmods. This patch also removes
the obsolete clkdm_xlate_address function which is no longer needed
for anything.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 8774e98..0ea4c90 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -476,12 +476,9 @@ static int omap4_clkdm_clk_disable(struct clockdomain *clkdm)
 	return 0;
 }
 
-static u32 omap4_clkdm_xlate_address(struct clockdomain *clkdm)
+static u32 omap4_cminst_xlate_clkctrl(u8 part, u16 inst, u16 offset)
 {
-	u32 addr = _cm_bases[clkdm->prcm_partition].pa + clkdm->cm_inst +
-		clkdm->clkdm_offs;
-
-	return addr;
+	return _cm_bases[part].pa + inst + offset;
 }
 
 struct clkdm_ops omap4_clkdm_operations = {
@@ -499,7 +496,6 @@ struct clkdm_ops omap4_clkdm_operations = {
 	.clkdm_deny_idle	= omap4_clkdm_deny_idle,
 	.clkdm_clk_enable	= omap4_clkdm_clk_enable,
 	.clkdm_clk_disable	= omap4_clkdm_clk_disable,
-	.clkdm_xlate_address	= omap4_clkdm_xlate_address,
 };
 
 struct clkdm_ops am43xx_clkdm_operations = {
@@ -509,7 +505,6 @@ struct clkdm_ops am43xx_clkdm_operations = {
 	.clkdm_deny_idle	= omap4_clkdm_deny_idle,
 	.clkdm_clk_enable	= omap4_clkdm_clk_enable,
 	.clkdm_clk_disable	= omap4_clkdm_clk_disable,
-	.clkdm_xlate_address	= omap4_clkdm_xlate_address,
 };
 
 static struct cm_ll_data omap4xxx_cm_ll_data = {
@@ -517,6 +512,7 @@ struct clkdm_ops am43xx_clkdm_operations = {
 	.wait_module_idle	= &omap4_cminst_wait_module_idle,
 	.module_enable		= &omap4_cminst_module_enable,
 	.module_disable		= &omap4_cminst_module_disable,
+	.xlate_clkctrl		= &omap4_cminst_xlate_clkctrl,
 };
 
 int __init omap4_cm_init(const struct omap_prcm_init_data *data)
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
