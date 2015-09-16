From: s-anna@ti.com (Suman Anna)
Date: Wed, 16 Sep 2015 18:48:20 -0500
Subject: [PATCH 2/4] ARM: OMAP3: hwmod data: Remove legacy IOMMU data
In-Reply-To: <1442447302-5246-1-git-send-email-s-anna@ti.com>
References: <1442447302-5246-1-git-send-email-s-anna@ti.com>
Message-ID: <1442447302-5246-3-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The legacy-mode device creation logic for IOMMU devices has
been cleaned up, so the device attribute data, irq information
and address data are no longer required. Remove all of these
data for the ISP & IVA IOMMU devices.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 42 ------------------------------
 1 file changed, 42 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index dc55f8dedf2c..01dfccaa0c3e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -25,7 +25,6 @@
 #include "l4_3xxx.h"
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <linux/platform_data/iommu-omap.h>
 #include <linux/platform_data/mailbox-omap.h>
 #include <plat/dmtimer.h>
 
@@ -2976,80 +2975,40 @@ static struct omap_hwmod_class omap3xxx_mmu_hwmod_class = {
 };
 
 /* mmu isp */
-
-static struct omap_mmu_dev_attr mmu_isp_dev_attr = {
-	.nr_tlb_entries = 8,
-};
-
 static struct omap_hwmod omap3xxx_mmu_isp_hwmod;
-static struct omap_hwmod_irq_info omap3xxx_mmu_isp_irqs[] = {
-	{ .irq = 24 + OMAP_INTC_START, },
-	{ .irq = -1 }
-};
-
-static struct omap_hwmod_addr_space omap3xxx_mmu_isp_addrs[] = {
-	{
-		.pa_start	= 0x480bd400,
-		.pa_end		= 0x480bd47f,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 /* l4_core -> mmu isp */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmu_isp = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_mmu_isp_hwmod,
-	.addr		= omap3xxx_mmu_isp_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 static struct omap_hwmod omap3xxx_mmu_isp_hwmod = {
 	.name		= "mmu_isp",
 	.class		= &omap3xxx_mmu_hwmod_class,
-	.mpu_irqs	= omap3xxx_mmu_isp_irqs,
 	.main_clk	= "cam_ick",
-	.dev_attr	= &mmu_isp_dev_attr,
 	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* mmu iva */
 
-static struct omap_mmu_dev_attr mmu_iva_dev_attr = {
-	.nr_tlb_entries = 32,
-};
-
 static struct omap_hwmod omap3xxx_mmu_iva_hwmod;
-static struct omap_hwmod_irq_info omap3xxx_mmu_iva_irqs[] = {
-	{ .irq = 28 + OMAP_INTC_START, },
-	{ .irq = -1 }
-};
 
 static struct omap_hwmod_rst_info omap3xxx_mmu_iva_resets[] = {
 	{ .name = "mmu", .rst_shift = 1, .st_shift = 9 },
 };
 
-static struct omap_hwmod_addr_space omap3xxx_mmu_iva_addrs[] = {
-	{
-		.pa_start	= 0x5d000000,
-		.pa_end		= 0x5d00007f,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 /* l3_main -> iva mmu */
 static struct omap_hwmod_ocp_if omap3xxx_l3_main__mmu_iva = {
 	.master		= &omap3xxx_l3_main_hwmod,
 	.slave		= &omap3xxx_mmu_iva_hwmod,
-	.addr		= omap3xxx_mmu_iva_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 static struct omap_hwmod omap3xxx_mmu_iva_hwmod = {
 	.name		= "mmu_iva",
 	.class		= &omap3xxx_mmu_hwmod_class,
-	.mpu_irqs	= omap3xxx_mmu_iva_irqs,
 	.clkdm_name	= "iva2_clkdm",
 	.rst_lines	= omap3xxx_mmu_iva_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap3xxx_mmu_iva_resets),
@@ -3062,7 +3021,6 @@ static struct omap_hwmod omap3xxx_mmu_iva_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_IVA2_SHIFT,
 		},
 	},
-	.dev_attr	= &mmu_iva_dev_attr,
 	.flags		= HWMOD_NO_IDLEST,
 };
 
-- 
2.5.0
