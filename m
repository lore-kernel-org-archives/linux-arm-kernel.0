From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 19 Feb 2014 15:12:38 +0100
Subject: [Patch v3 07/23] ARM: Kirkwood: ioremap memory control register
In-Reply-To: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
References: <1392819174-11634-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392819174-11634-8-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow removal of the global map of registers, make the pm code
ioremap the registers it needs.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h | 1 +
 arch/arm/mach-kirkwood/pm.c                       | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
index 2bd12fde1781..6e5077e2ec26 100644
--- a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
+++ b/arch/arm/mach-kirkwood/include/mach/bridge-regs.h
@@ -80,5 +80,6 @@
 #define CGC_RESERVED		(0x6 << 21)
 
 #define MEMORY_PM_CTRL		(BRIDGE_VIRT_BASE + 0x118)
+#define MEMORY_PM_CTRL_PHYS	(BRIDGE_PHYS_BASE + 0x118)
 
 #endif
diff --git a/arch/arm/mach-kirkwood/pm.c b/arch/arm/mach-kirkwood/pm.c
index c6ab8d9303a5..8e5e0329d04c 100644
--- a/arch/arm/mach-kirkwood/pm.c
+++ b/arch/arm/mach-kirkwood/pm.c
@@ -21,15 +21,16 @@
 #include "common.h"
 
 static void __iomem *ddr_operation_base;
+static void __iomem *memory_pm_ctrl;
 
 static void kirkwood_low_power(void)
 {
 	u32 mem_pm_ctrl;
 
-	mem_pm_ctrl = readl(MEMORY_PM_CTRL);
+	mem_pm_ctrl = readl(memory_pm_ctrl);
 
 	/* Set peripherals to low-power mode */
-	writel_relaxed(~0, MEMORY_PM_CTRL);
+	writel_relaxed(~0, memory_pm_ctrl);
 
 	/* Set DDR in self-refresh */
 	writel_relaxed(0x7, ddr_operation_base);
@@ -41,7 +42,7 @@ static void kirkwood_low_power(void)
 	 */
 	cpu_do_idle();
 
-	writel_relaxed(mem_pm_ctrl, MEMORY_PM_CTRL);
+	writel_relaxed(mem_pm_ctrl, memory_pm_ctrl);
 }
 
 static int kirkwood_suspend_enter(suspend_state_t state)
@@ -69,5 +70,7 @@ static const struct platform_suspend_ops kirkwood_suspend_ops = {
 void __init kirkwood_pm_init(void)
 {
 	ddr_operation_base = ioremap(DDR_OPERATION_BASE, 4);
+	memory_pm_ctrl = ioremap(MEMORY_PM_CTRL_PHYS, 4);
+
 	suspend_set_ops(&kirkwood_suspend_ops);
 }
-- 
1.8.5.3
