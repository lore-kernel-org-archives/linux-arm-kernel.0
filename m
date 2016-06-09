From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu,  9 Jun 2016 12:57:12 +0100
Subject: [PATCH] ARM: Kirkwood: fix kirkwood_pm_init() declaration/type
Message-ID: <1465473432-24323-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kirkwood-pm.c was missing the include of kirkwood-pm.h to
define the kirkwood_pm_init() function. However once this is
included, the types do not match.

Fixup the include, and then the prototype to avoid the following
warning:

arch/arm/mach-mvebu/kirkwood-pm.c:69:12: warning: symbol 'kirkwood_pm_init' was not declared. Should it be static?
Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-mvebu/kirkwood-pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/kirkwood-pm.c b/arch/arm/mach-mvebu/kirkwood-pm.c
index cbb816f..1e1f879 100644
--- a/arch/arm/mach-mvebu/kirkwood-pm.c
+++ b/arch/arm/mach-mvebu/kirkwood-pm.c
@@ -18,6 +18,7 @@
 #include <linux/suspend.h>
 #include <linux/io.h>
 #include "kirkwood.h"
+#include "kirkwood-pm.h"
 
 static void __iomem *ddr_operation_base;
 static void __iomem *memory_pm_ctrl;
@@ -66,11 +67,10 @@ static const struct platform_suspend_ops kirkwood_suspend_ops = {
 	.valid = kirkwood_pm_valid_standby,
 };
 
-int __init kirkwood_pm_init(void)
+void __init kirkwood_pm_init(void)
 {
 	ddr_operation_base = ioremap(DDR_OPERATION_BASE, 4);
 	memory_pm_ctrl = ioremap(MEMORY_PM_CTRL_PHYS, 4);
 
 	suspend_set_ops(&kirkwood_suspend_ops);
-	return 0;
 }
-- 
2.8.1
