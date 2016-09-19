From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 19 Sep 2016 13:52:07 +0200
Subject: [PATCH] ARM: mvebu: Select corediv clk for all mvebu v7 SoC
Message-ID: <20160919115207.19334-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the commit bd3677ff31a3 ("clk: mvebu: Remove corediv clock from
Armada XP"), the corediv clk is no more selected for Armada XP, however
this clock is used for Armada XP using the compatible
armada-370-corediv-clock.

More over even if with the commit 1594d568c6e3 ("clk: mvebu: Move corediv
config to mvebu config"), it was selected for Armada 38x and Armada 375,
it was still not selected for Armada 39x.

Actually all the SoC selecting MVEBU_V7 config need this clock:
git grep "\-corediv-clock" arch/arm/boot/dts
arch/arm/boot/dts/armada-370-xp.dtsi: compatible = "marvell,armada-370-corediv-clock";
arch/arm/boot/dts/armada-375.dtsi:    compatible = "marvell,armada-375-corediv-clock";
arch/arm/boot/dts/armada-38x.dtsi:    compatible = "marvell,armada-380-corediv-clock";
arch/arm/boot/dts/armada-39x.dtsi:    compatible = "marvell,armada-390-corediv-clock"

This commit now fixes this behavior.

Fixes: bd3677ff31a3 ("clk: mvebu: Remove corediv clock from Armada XP")
Cc: stable at vger.kernel.org
Reported-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index f9b6bd306cfe..541647f57192 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -23,6 +23,7 @@ config MACH_MVEBU_V7
 	select CACHE_L2X0
 	select ARM_CPU_SUSPEND
 	select MACH_MVEBU_ANY
+	select MVEBU_CLK_COREDIV
 
 config MACH_ARMADA_370
 	bool "Marvell Armada 370 boards"
@@ -32,7 +33,6 @@ config MACH_ARMADA_370
 	select CPU_PJ4B
 	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_370
-	select MVEBU_CLK_COREDIV
 	help
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada 370 SoC with device tree.
@@ -50,7 +50,6 @@ config MACH_ARMADA_375
 	select HAVE_SMP
 	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_375
-	select MVEBU_CLK_COREDIV
 	help
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada 375 SoC with device tree.
@@ -68,7 +67,6 @@ config MACH_ARMADA_38X
 	select HAVE_SMP
 	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_38X
-	select MVEBU_CLK_COREDIV
 	help
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Armada 380/385 SoC with device tree.
-- 
2.9.3
