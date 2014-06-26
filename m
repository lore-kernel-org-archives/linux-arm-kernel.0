From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jun 2014 00:43:28 +0200
Subject: [PATCH 5/5] ARM: imx6q: Use the new function scu_standby_enable()
In-Reply-To: <1403822608-31158-1-git-send-email-gregory.clement@free-electrons.com>
References: <1403822608-31158-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1403822608-31158-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling the SCU standby is now done in smp_scu.c. We don't need
anymore to manipulate the SCU register outside of this file.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-imx/platsmp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 5b57c17c06bd..d57ff2c24c2e 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -20,8 +20,6 @@
 #include "common.h"
 #include "hardware.h"
 
-#define SCU_STANDBY_ENABLE	(1 << 5)
-
 u32 g_diag_reg;
 static void __iomem *scu_base;
 
@@ -47,10 +45,7 @@ void __init imx_scu_map_io(void)
 
 void imx_scu_standby_enable(void)
 {
-	u32 val = readl_relaxed(scu_base);
-
-	val |= SCU_STANDBY_ENABLE;
-	writel_relaxed(val, scu_base);
+	scu_standby_enable(scu_base, true);
 }
 
 static int imx_boot_secondary(unsigned int cpu, struct task_struct *idle)
-- 
1.8.1.2
