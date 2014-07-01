From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  1 Jul 2014 00:12:52 -0300
Subject: [PATCH] ARM: mx6: Only check for 1.2GHz for mx6quad
Message-ID: <1404184372-5321-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

It is only the mx6quad variant that can run up to 1.2GHz, so add the check 
accordingly.

This avoids getting the following warning on a mx6solo:

failed to disable 1.2 GHz OPP

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-imx6q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index e60456d..9b3a233 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -320,7 +320,7 @@ static void __init imx6q_opp_check_speed_grading(struct device *cpu_dev)
 	val >>= OCOTP_CFG3_SPEED_SHIFT;
 	val &= 0x3;
 
-	if (val != OCOTP_CFG3_SPEED_1P2GHZ)
+	if ((val != OCOTP_CFG3_SPEED_1P2GHZ) && cpu_is_imx6q())
 		if (dev_pm_opp_disable(cpu_dev, 1200000000))
 			pr_warn("failed to disable 1.2 GHz OPP\n");
 	if (val < OCOTP_CFG3_SPEED_996MHZ)
-- 
1.8.3.2
