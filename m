From: grygorii.strashko@linaro.org (grygorii.strashko at linaro.org)
Date: Tue,  3 Feb 2015 17:51:24 +0200
Subject: [PATCH] ARM: dra7xx: hwmod: drop .modulemode from pcie1/2 hwmods
Message-ID: <1422978684-4826-1-git-send-email-grygorii.strashko@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@linaro.org>

Now DRA7xx pcie1/2 hwmods define PRCM configuration as following:
  .clkctrl_offs = DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
  .rstctrl_offs = DRA7XX_RM_L3INIT_RSTCTRL_OFFSET,
  .modulemode   = MODULEMODE_SWCTRL,
which is completely wrong because DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET
is clockdomain ctrl register and NOT module ctrl register.
And they have diffrent allowed values for bits[0,1]:
CLKTRCTRL?????????MODULEMODE??????????????????????????????????
0x0:?NO_SLEEP?????0x0:?Module?is?disabled?by?SW.??????????????
0x1:?SW_SLEEP?????0x1:?Module?is?managed?automatically?by?HW??
0x2:?SW_WKUP??????0x2:?Module?is?explicitly?enabled.??????????
0x3:?HW_AUTO??????0x3:?Reserved??

As result, following message can be seen during suspend:
  "omap_hwmod: pcie1: _wait_target_disable failed"

Fix it by removing .modulemode from pcie1/2 hwmods and, in that
way, prevent clockdomain ctrl register writing from HWMOD core.

Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
---

More over, it looks like pcie1/2 hwmods are fake and have to be dropped at all.
The real HWMODs are PCIESS1/2.
Unfortunatelly, not all information on PCIE is public, so
I could be wrong here.
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index ffd6604..a428b2d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1478,7 +1478,6 @@ static struct omap_hwmod dra7xx_pcie1_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs	= DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1492,7 +1491,6 @@ static struct omap_hwmod dra7xx_pcie2_hwmod = {
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_PCIE_CLKSTCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
-- 
1.9.1
