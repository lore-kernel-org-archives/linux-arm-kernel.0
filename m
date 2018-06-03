From: Anson.Huang@nxp.com (Anson Huang)
Date: Sun,  3 Jun 2018 10:33:46 +0800
Subject: [PATCH V2 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu idle
 driver
In-Reply-To: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
References: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1527993226-19587-3-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SLL supports ARM power off in cpu idle, better to reuse
i.MX6SX cpu idle driver instead of i.MX6SL which does NOT
support ARM power off.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change since V1.
 arch/arm/mach-imx/cpuidle-imx6sl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c b/arch/arm/mach-imx/cpuidle-imx6sl.c
index fa8ead1..8d866fb 100644
--- a/arch/arm/mach-imx/cpuidle-imx6sl.c
+++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
@@ -12,7 +12,6 @@
 
 #include "common.h"
 #include "cpuidle.h"
-#include "hardware.h"
 
 static int imx6sl_enter_wait(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
@@ -22,11 +21,9 @@ static int imx6sl_enter_wait(struct cpuidle_device *dev,
 	 * Software workaround for ERR005311, see function
 	 * description for details.
 	 */
-	if (cpu_is_imx6sl())
-		imx6sl_set_wait_clk(true);
+	imx6sl_set_wait_clk(true);
 	cpu_do_idle();
-	if (cpu_is_imx6sl())
-		imx6sl_set_wait_clk(false);
+	imx6sl_set_wait_clk(false);
 	imx6_set_lpm(WAIT_CLOCKED);
 
 	return index;
-- 
2.7.4
