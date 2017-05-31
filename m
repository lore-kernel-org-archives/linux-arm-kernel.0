From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 31 May 2017 18:00:02 +0300
Subject: [PATCHv4 5/6] ARM: OMAP4: cminst: add support for clkdm_xlate_address
In-Reply-To: <1496242803-6101-1-git-send-email-t-kristo@ti.com>
References: <1496242803-6101-1-git-send-email-t-kristo@ti.com>
Message-ID: <1496242803-6101-6-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function gets the physical base address of a clockdomain.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index cfa10a3..8774e98 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -476,6 +476,14 @@ static int omap4_clkdm_clk_disable(struct clockdomain *clkdm)
 	return 0;
 }
 
+static u32 omap4_clkdm_xlate_address(struct clockdomain *clkdm)
+{
+	u32 addr = _cm_bases[clkdm->prcm_partition].pa + clkdm->cm_inst +
+		clkdm->clkdm_offs;
+
+	return addr;
+}
+
 struct clkdm_ops omap4_clkdm_operations = {
 	.clkdm_add_wkdep	= omap4_clkdm_add_wkup_sleep_dep,
 	.clkdm_del_wkdep	= omap4_clkdm_del_wkup_sleep_dep,
@@ -491,6 +499,7 @@ struct clkdm_ops omap4_clkdm_operations = {
 	.clkdm_deny_idle	= omap4_clkdm_deny_idle,
 	.clkdm_clk_enable	= omap4_clkdm_clk_enable,
 	.clkdm_clk_disable	= omap4_clkdm_clk_disable,
+	.clkdm_xlate_address	= omap4_clkdm_xlate_address,
 };
 
 struct clkdm_ops am43xx_clkdm_operations = {
@@ -500,6 +509,7 @@ struct clkdm_ops am43xx_clkdm_operations = {
 	.clkdm_deny_idle	= omap4_clkdm_deny_idle,
 	.clkdm_clk_enable	= omap4_clkdm_clk_enable,
 	.clkdm_clk_disable	= omap4_clkdm_clk_disable,
+	.clkdm_xlate_address	= omap4_clkdm_xlate_address,
 };
 
 static struct cm_ll_data omap4xxx_cm_ll_data = {
-- 
1.9.1
