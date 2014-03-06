From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  6 Mar 2014 17:46:30 +0100
Subject: [PATCH 05/10] ARM: mvebu: enable the ARM SCU on Armada 375 and Armada
 38x
In-Reply-To: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1394124395-20030-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1394124395-20030-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Contrary to the Armada 370 and XP that used the PJ4B Marvell cores,
the Armada 375 and Armada 38x use the ARM Cortex-A9. A consequence of
this is that the unit responsible for the coherency between CPUs is
now the ARM SCU, and not the Marvell coherency unit (which is still
present to do coherency with I/O devices).

Therefore this commit:

 * Ensures that the selection of the Armada 375 or Armada 38x SoC
   support enables the ARM SCU support in the kernel.

 * Make sure to initialize the SCU at boot time.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig    |  2 ++
 arch/arm/mach-mvebu/board-v7.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 884b275a..8634222 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -44,6 +44,7 @@ config MACH_ARMADA_375
 	select ARM_GIC
 	select ARMADA_375_CLK
 	select CPU_V7
+	select HAVE_ARM_SCU
 	select MACH_MVEBU_V7
 	select NEON
 	select PINCTRL_ARMADA_375
@@ -58,6 +59,7 @@ config MACH_ARMADA_38X
 	select ARM_GIC
 	select ARMADA_38X_CLK
 	select CPU_V7
+	select HAVE_ARM_SCU
 	select MACH_MVEBU_V7
 	select NEON
 	select PINCTRL_ARMADA_38X
diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index e5d4f69..256e6f6 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -26,6 +26,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
+#include <asm/smp_scu.h>
 #include "armada-370-xp.h"
 #include "common.h"
 #include "coherency.h"
@@ -37,6 +38,23 @@ static void __init mvebu_map_io(void)
 }
 
 /*
+ * Enables the SCU when available. Obviously, this is only useful on
+ * Cortex-A based SOCs, not on PJ4B based ones.
+ */
+static void __init mvebu_scu_enable(void)
+{
+	void __iomem *scu_base;
+
+	struct device_node *np =
+		of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
+	if (np) {
+		scu_base = of_iomap(np, 0);
+		scu_enable(scu_base);
+		of_node_put(np);
+	}
+}
+
+/*
  * Early versions of Armada 375 SoC have a bug where the BootROM
  * leaves an external data abort pending. The kernel is hit by this
  * data abort as soon as it enters userspace, because it unmasks the
@@ -61,6 +79,7 @@ static void __init mvebu_timer_and_clk_init(void)
 {
 	of_clk_init(NULL);
 	clocksource_of_init();
+	mvebu_scu_enable();
 	coherency_init();
 	BUG_ON(mvebu_mbus_dt_init(coherency_available()));
 #ifdef CONFIG_CACHE_L2X0
-- 
1.8.3.2
