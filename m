From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 22 Oct 2009 16:09:37 -0700
Subject: [PATCH v2 16/32] OMAP3: PM: Save and restore also CM_CLKSEL1_PLL_IVA2
In-Reply-To: <1256252993-24328-16-git-send-email-khilman@deeprootsystems.com>
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
Message-ID: <1256252993-24328-17-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jouni Hogander <jouni.hogander@nokia.com>

CM_CLKSEL1_PLL_IVA2 is not saved/restored currently. This patch is
adding save and restore for it.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/prcm.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 56f77df..221eed1 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -39,6 +39,7 @@ static void __iomem *cm_base;
 
 struct omap3_prcm_regs {
 	u32 control_padconf_sys_nirq;
+	u32 iva2_cm_clksel1;
 	u32 iva2_cm_clksel2;
 	u32 cm_sysconfig;
 	u32 sgx_cm_clksel;
@@ -262,6 +263,8 @@ void omap3_prcm_save_context(void)
 {
 	prcm_context.control_padconf_sys_nirq =
 			 omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_SYSNIRQ);
+	prcm_context.iva2_cm_clksel1 =
+			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
 	prcm_context.iva2_cm_clksel2 =
 			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL2);
 	prcm_context.cm_sysconfig = __raw_readl(OMAP3430_CM_SYSCONFIG);
@@ -417,6 +420,8 @@ void omap3_prcm_restore_context(void)
 {
 	omap_ctrl_writel(prcm_context.control_padconf_sys_nirq,
 					 OMAP343X_CONTROL_PADCONF_SYSNIRQ);
+	cm_write_mod_reg(prcm_context.iva2_cm_clksel1, OMAP3430_IVA2_MOD,
+					 CM_CLKSEL1);
 	cm_write_mod_reg(prcm_context.iva2_cm_clksel2, OMAP3430_IVA2_MOD,
 					 CM_CLKSEL2);
 	__raw_writel(prcm_context.cm_sysconfig, OMAP3430_CM_SYSCONFIG);
-- 
1.6.4.3
