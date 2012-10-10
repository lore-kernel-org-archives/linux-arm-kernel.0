From: mporter@ti.com (Matt Porter)
Date: Wed, 10 Oct 2012 10:30:49 -0400
Subject: [PATCH] ARM: OMAP2+: AM33XX: clock data: fix mcasp entries
Message-ID: <1349879449-22657-1-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

6ea74cb ARM: OMAP2+: hwmod: get rid of all omap_clk_get_by_name usage
exposes a bug in the AM33XX clock data for mcasp. After moving to
clk_get() usage, the _init() of all registered hwmods fails on mcasp0
due to incorrect clock data causing clk_get() to fail. This causes all
successive hwmods to fail to _init() leaving them in a bad state.

This patch updates the mcasp clock entries so clk_get() will succeed.
It is tested on BeagleBone and is needed for 3.7-rc1 to fix AM33xx
boot.

Signed-off-by: Matt Porter <mporter@ti.com>
---
 arch/arm/mach-omap2/clock33xx_data.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
index b87b88c..0a64139 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -1033,8 +1033,8 @@ static struct omap_clk am33xx_clks[] = {
 	CLK("481d0000.d_can",	NULL,		&dcan1_fck,	CK_AM33XX),
 	CLK(NULL,	"debugss_ick",		&debugss_ick,	CK_AM33XX),
 	CLK(NULL,	"pruss_ocp_gclk",	&pruss_ocp_gclk,	CK_AM33XX),
-	CLK("davinci-mcasp.0",  NULL,           &mcasp0_fck,    CK_AM33XX),
-	CLK("davinci-mcasp.1",  NULL,           &mcasp1_fck,    CK_AM33XX),
+	CLK(NULL,	"mcasp0_fck",		&mcasp0_fck,    CK_AM33XX),
+	CLK(NULL,	"mcasp1_fck",		&mcasp1_fck,    CK_AM33XX),
 	CLK("NULL",	"mmc2_fck",		&mmc2_fck,	CK_AM33XX),
 	CLK(NULL,	"mmu_fck",		&mmu_fck,	CK_AM33XX),
 	CLK(NULL,	"smartreflex0_fck",	&smartreflex0_fck,	CK_AM33XX),
-- 
1.7.9.5
