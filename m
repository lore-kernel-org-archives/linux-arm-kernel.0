From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 11 May 2013 03:08:09 +0200
Subject: [PATCH 09/10] ARM: mvebu: move DT boards to SoC-centric clock init
In-Reply-To: <1368234490-31416-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1368234490-31416-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1368234490-31416-10-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SoC centric clock init for Armada 370/XP can be used by calling of_clk_init.
Use it and get rid of mvebu_clocks_init.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-mvebu/Kconfig         |    5 ++---
 arch/arm/mach-mvebu/armada-370-xp.c |    4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index e11acbb..6512837 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -10,9 +10,6 @@ config ARCH_MVEBU
 	select PLAT_ORION
 	select SPARSE_IRQ
 	select CLKDEV_LOOKUP
-	select MVEBU_CLK_CORE
-	select MVEBU_CLK_CPU
-	select MVEBU_CLK_GATING
 	select MVEBU_MBUS
 	select ZONE_DMA if ARM_LPAE
 
@@ -29,6 +26,7 @@ config MACH_ARMADA_370_XP
 
 config MACH_ARMADA_370
 	bool "Marvell Armada 370 boards"
+	select ARMADA_370_CLK
 	select MACH_ARMADA_370_XP
 	select PINCTRL_ARMADA_370
 	help
@@ -37,6 +35,7 @@ config MACH_ARMADA_370
 
 config MACH_ARMADA_XP
 	bool "Marvell Armada XP boards"
+	select ARMADA_XP_CLK
 	select MACH_ARMADA_370_XP
 	select PINCTRL_ARMADA_XP
 	help
diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 42a4cb3..1d018e4 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -14,10 +14,10 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/clk-provider.h>
 #include <linux/of_platform.h>
 #include <linux/io.h>
 #include <linux/time-armada-370-xp.h>
-#include <linux/clk/mvebu.h>
 #include <linux/dma-mapping.h>
 #include <linux/mbus.h>
 #include <linux/irqchip.h>
@@ -45,7 +45,7 @@ void __init armada_370_xp_map_io(void)
 
 void __init armada_370_xp_timer_and_clk_init(void)
 {
-	mvebu_clocks_init();
+	of_clk_init(NULL);
 	armada_370_xp_timer_init();
 }
 
-- 
1.7.10.4
