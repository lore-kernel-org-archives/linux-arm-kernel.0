From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 17:37:13 +0200
Subject: [PATCH 1/2] arm: mvebu: split Kconfig options for Armada 370 and XP
In-Reply-To: <1347377834-19402-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347377834-19402-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1347377834-19402-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now, all the code for Armada 370 and XP was common, so we had a
single Kconfig option to support all boards using both SoCs. With the
addition of pinctrl drivers, this situation has changed: those two
SoCs are radically different in terms of pinctrl, so they have two
separate drivers. Since pinctrl drivers are typically select-ed from
the SoC Kconfig option, it makes sense to split the 370/XP option into
two separate options: one for Armada 370 and another for Armada XP.

We keep an hidden option selected by both ARMADA_370 and ARMADA_XP in
order to easily compile common code.

A followup patch actually makes use of this split to select the
appropriate pinctrl drivers.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index caa2c5e..b0924b1 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -3,13 +3,23 @@ if ARCH_MVEBU
 menu "Marvell SOC with device tree"
 
 config MACH_ARMADA_370_XP
-	bool "Marvell Armada 370 and Aramada XP boards"
+	bool
 	select ARMADA_370_XP_TIMER
 	select CPU_V7
+
+config MACH_ARMADA_370
+	bool "Marvell Armada 370 boads"
+	select MACH_ARMADA_370_XP
 	help
+	  Say 'Y' here if you want your kernel to support boards based
+	  on the Marvell Armada XP SoC with device tree.
 
-	  Say 'Y' here if you want your kernel to support boards based on
-	  Marvell Armada 370 or Armada XP with device tree.
+config MACH_ARMADA_XP
+	bool "Marvell Armada XP boards"
+	select MACH_ARMADA_370_XP
+	help
+	  Say 'Y' here if you want your kernel to support boards based
+	  on the Marvell Armada XP SoC with device tree.
 
 endmenu
 
-- 
1.7.9.5
