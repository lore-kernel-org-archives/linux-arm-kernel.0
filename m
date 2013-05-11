From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 11 May 2013 03:08:07 +0200
Subject: [PATCH 07/10] ARM: dove: move DT boards to SoC-centric clock init
In-Reply-To: <1368234490-31416-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1368234490-31416-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1368234490-31416-8-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SoC centric clock init for Dove can be used by calling of_clk_init.
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
 arch/arm/mach-dove/Kconfig    |    3 +--
 arch/arm/mach-dove/board-dt.c |    3 +--
 arch/arm/mach-dove/common.c   |    1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
index 36469d8..dff7b2f 100644
--- a/arch/arm/mach-dove/Kconfig
+++ b/arch/arm/mach-dove/Kconfig
@@ -22,8 +22,7 @@ config MACH_CM_A510
 
 config MACH_DOVE_DT
 	bool "Marvell Dove Flattened Device Tree"
-	select MVEBU_CLK_CORE
-	select MVEBU_CLK_GATING
+	select DOVE_CLK
 	select REGULATOR
 	select REGULATOR_FIXED_VOLTAGE
 	select USE_OF
diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
index 0b14280..f3755ac 100644
--- a/arch/arm/mach-dove/board-dt.c
+++ b/arch/arm/mach-dove/board-dt.c
@@ -10,7 +10,6 @@
 
 #include <linux/init.h>
 #include <linux/clk-provider.h>
-#include <linux/clk/mvebu.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/usb-ehci-orion.h>
@@ -49,7 +48,7 @@ static void __init dove_legacy_clk_init(void)
 
 static void __init dove_of_clk_init(void)
 {
-	mvebu_clocks_init();
+	of_clk_init(NULL);
 	dove_legacy_clk_init();
 }
 
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index e2b5da0..2a9443d 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/clk/mvebu.h>
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/of.h>
-- 
1.7.10.4
