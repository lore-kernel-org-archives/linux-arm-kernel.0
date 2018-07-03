From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue,  3 Jul 2018 22:29:32 +0300
Subject: [PATCH 1/3] ARM: i.MX31: remove rnga registration as a platform device
In-Reply-To: <20180703192934.6080-1-vz@mleia.com>
References: <20180703192934.6080-1-vz@mleia.com>
Message-ID: <20180703192934.6080-2-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX31 powered boards with OF support Security Random Number
Generator Accelerator RNGA controller is initialized from device tree,
its registration as a platform device is redundant and actually it is
broken due to missing clock information:

  mxc_rnga mxc_rnga: Could not get rng_clk!
  mxc_rnga: probe of mxc_rnga failed with error -2

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/imx31-dt.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm/mach-imx/imx31-dt.c b/arch/arm/mach-imx/imx31-dt.c
index 668d74b..9d9640a 100644
--- a/arch/arm/mach-imx/imx31-dt.c
+++ b/arch/arm/mach-imx/imx31-dt.c
@@ -9,35 +9,17 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
-#include <linux/irq.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-
 #include "common.h"
-#include "mx31.h"
 
 static const char * const imx31_dt_board_compat[] __initconst = {
 	"fsl,imx31",
 	NULL
 };
 
-/* FIXME: replace with DT binding */
-static const struct resource imx31_rnga_res[] __initconst = {
-	DEFINE_RES_MEM(MX31_RNGA_BASE_ADDR, SZ_16K),
-};
-
-static void __init imx31_dt_mach_init(void)
-{
-	platform_device_register_simple("mxc_rnga", -1, imx31_rnga_res,
-					ARRAY_SIZE(imx31_rnga_res));
-}
-
 DT_MACHINE_START(IMX31_DT, "Freescale i.MX31 (Device Tree Support)")
 	.map_io		= mx31_map_io,
 	.init_early	= imx31_init_early,
 	.init_irq	= mx31_init_irq,
-	.init_machine	= imx31_dt_mach_init,
 	.dt_compat	= imx31_dt_board_compat,
 MACHINE_END
-- 
2.10.2
