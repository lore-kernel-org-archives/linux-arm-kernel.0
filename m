From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 23:38:56 +0200
Subject: [PATCH 1/3] pinctrl: mvebu: allow plat-orion architectures to use
 pinctrl-mvebu
Message-ID: <1351114738-26793-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mach-kirkwood and mach-dove architectures have not yet been
integrated into the mach-mvebu directory, which should ultimately
contain the support for all Marvell SoCs from the Engineering Business
Unit.

However, before this can happen, we need to let mach-kirkwood and
mach-dove use the pinctrl-mvebu driver, which supports the kirkwood
and dove SoC families. In order to do that, we make this driver
available as soon as PLAT_ORION is selected, instead of using
ARCH_MVEBU as a condition. In the long term, PLAT_ORION should
disappear and be fully replaced by ARCH_MVEBU, but the plan is to make
the migration step by step, by first having the existing mach-*
directories for Marvell SoCs converge on several infrastructures,
including the pinctrl one.

Also, like the spear pinctrl driver, we put all pinctrl-mvebu Kconfig
options under a if, in order to avoid having certain options
(PINCTRL_DOVE, PINCTRL_KIRKWOOD, etc.) selecting an option
(PINCTLR_MVEBU) which itself has a dependency (on ARCH_MVEBU). In this
a construct, the dependency is in fact ignored due to the selects.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pinctrl/Kconfig |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 7bf914d..a9d756e 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -186,9 +186,10 @@ config PINCTRL_EXYNOS4
 	bool "Pinctrl driver data for Exynos4 SoC"
 	select PINCTRL_SAMSUNG
 
+if PLAT_ORION
+
 config PINCTRL_MVEBU
 	bool
-	depends on ARCH_MVEBU
 	select PINMUX
 	select PINCONF
 
@@ -208,6 +209,8 @@ config PINCTRL_ARMADA_XP
 	bool
 	select PINCTRL_MVEBU
 
+endif
+
 source "drivers/pinctrl/spear/Kconfig"
 
 config PINCTRL_XWAY
-- 
1.7.9.5
