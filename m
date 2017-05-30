From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 30 May 2017 17:47:48 +0300
Subject: [PATCHv3b 4/5] ARM: OMAP4: cminst: add support for clkdm_xlate_address
In-Reply-To: <1496155669-1677-1-git-send-email-t-kristo@ti.com>
References: <1496155669-1677-1-git-send-email-t-kristo@ti.com>
Message-ID: <1496155669-1677-5-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function gets the physical base address of a clockdomain.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 2ab27ad..3df268e 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -31,6 +31,7 @@
 #include "prm44xx.h"
 #include "prcm_mpu44xx.h"
 #include "prcm-common.h"
+#include "iomap.h"
 
 #define OMAP4430_IDLEST_SHIFT		16
 #define OMAP4430_IDLEST_MASK		(0x3 << 16)
@@ -475,6 +476,14 @@ static int omap4_clkdm_clk_disable(struct clockdomain *clkdm)
 	return 0;
 }
 
+static u32 omap4_clkdm_xlate_address(struct clockdomain *clkdm)
+{
+	u32 addr = (u32)_cm_bases[clkdm->prcm_partition] - OMAP2_L4_IO_OFFSET +
+		clkdm->cm_inst + clkdm->clkdm_offs;
+
+	return addr;
+}
+
 struct clkdm_ops omap4_clkdm_operations = {
 	.clkdm_add_wkdep	= omap4_clkdm_add_wkup_sleep_dep,
 	.clkdm_del_wkdep	= omap4_clkdm_del_wkup_sleep_dep,
@@ -490,6 +499,7 @@ struct clkdm_ops omap4_clkdm_operations = {
 	.clkdm_deny_idle	= omap4_clkdm_deny_idle,
 	.clkdm_clk_enable	= omap4_clkdm_clk_enable,
 	.clkdm_clk_disable	= omap4_clkdm_clk_disable,
+	.clkdm_xlate_address	= omap4_clkdm_xlate_address,
 };
 
 struct clkdm_ops am43xx_clkdm_operations = {
@@ -499,6 +509,7 @@ struct clkdm_ops am43xx_clkdm_operations = {
 	.clkdm_deny_idle	= omap4_clkdm_deny_idle,
 	.clkdm_clk_enable	= omap4_clkdm_clk_enable,
 	.clkdm_clk_disable	= omap4_clkdm_clk_disable,
+	.clkdm_xlate_address	= omap4_clkdm_xlate_address,
 };
 
 static struct cm_ll_data omap4xxx_cm_ll_data = {
-- 
1.9.1
