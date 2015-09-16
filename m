From: s-anna@ti.com (Suman Anna)
Date: Wed, 16 Sep 2015 18:48:21 -0500
Subject: [PATCH 3/4] ARM: OMAP4: hwmod data: Remove legacy IOMMU attr and addrs
In-Reply-To: <1442447302-5246-1-git-send-email-s-anna@ti.com>
References: <1442447302-5246-1-git-send-email-s-anna@ti.com>
Message-ID: <1442447302-5246-4-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP4 has been DT-boot only for some time, and the legacy-mode
device creation logic for IOMMU devices has also been cleaned up,
so the dev_attr and address data is no longer required. So, remove
these attribute data and hwmod addr space for the IPU & DSP IOMMU
devices.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 31 ------------------------------
 1 file changed, 31 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 43eebf2c59e2..56586b5d6051 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -30,7 +30,6 @@
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <linux/platform_data/iommu-omap.h>
 #include <plat/dmtimer.h>
 
 #include "omap_hwmod.h"
@@ -2088,30 +2087,16 @@ static struct omap_hwmod_class omap44xx_mmu_hwmod_class = {
 
 /* mmu ipu */
 
-static struct omap_mmu_dev_attr mmu_ipu_dev_attr = {
-	.nr_tlb_entries = 32,
-};
-
 static struct omap_hwmod omap44xx_mmu_ipu_hwmod;
 static struct omap_hwmod_rst_info omap44xx_mmu_ipu_resets[] = {
 	{ .name = "mmu_cache", .rst_shift = 2 },
 };
 
-static struct omap_hwmod_addr_space omap44xx_mmu_ipu_addrs[] = {
-	{
-		.pa_start	= 0x55082000,
-		.pa_end		= 0x550820ff,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 /* l3_main_2 -> mmu_ipu */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__mmu_ipu = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_mmu_ipu_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_mmu_ipu_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -2130,35 +2115,20 @@ static struct omap_hwmod omap44xx_mmu_ipu_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.dev_attr	= &mmu_ipu_dev_attr,
 };
 
 /* mmu dsp */
 
-static struct omap_mmu_dev_attr mmu_dsp_dev_attr = {
-	.nr_tlb_entries = 32,
-};
-
 static struct omap_hwmod omap44xx_mmu_dsp_hwmod;
 static struct omap_hwmod_rst_info omap44xx_mmu_dsp_resets[] = {
 	{ .name = "mmu_cache", .rst_shift = 1 },
 };
 
-static struct omap_hwmod_addr_space omap44xx_mmu_dsp_addrs[] = {
-	{
-		.pa_start	= 0x4a066000,
-		.pa_end		= 0x4a0660ff,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 /* l4_cfg -> dsp */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__mmu_dsp = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_mmu_dsp_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_mmu_dsp_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -2177,7 +2147,6 @@ static struct omap_hwmod omap44xx_mmu_dsp_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.dev_attr	= &mmu_dsp_dev_attr,
 };
 
 /*
-- 
2.5.0
