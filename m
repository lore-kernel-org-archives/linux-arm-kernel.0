From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 11 May 2013 03:08:08 +0200
Subject: [PATCH 08/10] ARM: kirkwood: move DT boards to SoC-centric clock init
In-Reply-To: <1368234490-31416-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1368234490-31416-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1368234490-31416-9-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SoC centric clock init for Kirkwood can be used by calling of_clk_init.
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
 arch/arm/mach-kirkwood/Kconfig    |    3 +--
 arch/arm/mach-kirkwood/board-dt.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 7509a89..79ee9f2 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -134,13 +134,12 @@ comment "Device tree entries"
 
 config ARCH_KIRKWOOD_DT
 	bool "Marvell Kirkwood Flattened Device Tree"
+	select KIRKWOOD_CLK
 	select POWER_SUPPLY
 	select POWER_RESET
 	select POWER_RESET_GPIO
 	select REGULATOR
 	select REGULATOR_FIXED_VOLTAGE
-	select MVEBU_CLK_CORE
-	select MVEBU_CLK_GATING
 	select USE_OF
 	help
 	  Say 'Y' here if you want your kernel to support the
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index e9647b8..2f695e5 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -15,7 +15,6 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/clk-provider.h>
-#include <linux/clk/mvebu.h>
 #include <linux/kexec.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -77,7 +76,7 @@ static void __init kirkwood_legacy_clk_init(void)
 
 static void __init kirkwood_of_clk_init(void)
 {
-	mvebu_clocks_init();
+	of_clk_init(NULL);
 	kirkwood_legacy_clk_init();
 }
 
-- 
1.7.10.4
