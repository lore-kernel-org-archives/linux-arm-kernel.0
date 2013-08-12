From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 12 Aug 2013 18:51:37 +0000
Subject: [PATCH] ARM: kirkwood: fix DT building and update defconfig
In-Reply-To: <1376231210-6484-3-git-send-email-jm@lentin.co.uk>
References: <1376231210-6484-3-git-send-email-jm@lentin.co.uk>
Message-ID: <1376333497-28352-1-git-send-email-jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit

  844703c ARM: kirkwood: Remove all remaining trace of DNS-320/325 platform code

removed the last kirkwood DT/platform board in kirkwood_defconfig, this
triggered a rescan of the config symbols, the result of which breaks the
build because KIRKWOOD_DT does not select OF_IRQ.

This commit fixes the regression and updates the defconfig to
explicitly enable SERIAL_OF_PLATFORM and KIRWOOD_DT.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
Note: I switch the one remaining DT board to 'depends on' so that once it's
removed, KIRKWOOD_DT will still be in the defconfig.  With 'select', the board
is there, but not KIRKWOOD_DT as it's implied.

 arch/arm/configs/kirkwood_defconfig | 17 ++++-------------
 arch/arm/mach-kirkwood/Kconfig      |  3 ++-
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index d9ea71f..e3f667a 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -10,25 +10,18 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_KIRKWOOD=y
 CONFIG_MACH_D2NET_V2=y
-CONFIG_MACH_DB88F6281_BP=y
-CONFIG_MACH_DOCKSTAR=y
-CONFIG_MACH_ESATA_SHEEVAPLUG=y
-CONFIG_MACH_GURUPLUG=y
-CONFIG_MACH_INETSPACE_V2=y
-CONFIG_MACH_MV88F6281GTW_GE=y
 CONFIG_MACH_NET2BIG_V2=y
 CONFIG_MACH_NET5BIG_V2=y
-CONFIG_MACH_NETSPACE_MAX_V2=y
-CONFIG_MACH_NETSPACE_V2=y
 CONFIG_MACH_OPENRD_BASE=y
 CONFIG_MACH_OPENRD_CLIENT=y
 CONFIG_MACH_OPENRD_ULTIMATE=y
 CONFIG_MACH_RD88F6192_NAS=y
 CONFIG_MACH_RD88F6281=y
-CONFIG_MACH_SHEEVAPLUG=y
 CONFIG_MACH_T5325=y
 CONFIG_MACH_TS219=y
 CONFIG_MACH_TS41X=y
+CONFIG_ARCH_KIRKWOOD_DT=y
+CONFIG_MACH_MV88F6281GTW_GE_DT=y
 # CONFIG_CPU_FEROCEON_OLD_ID is not set
 CONFIG_PCI_MVEBU=y
 CONFIG_PREEMPT=y
@@ -76,7 +69,6 @@ CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
-CONFIG_MII=y
 CONFIG_NET_DSA_MV88E6123_61_65=y
 CONFIG_MV643XX_ETH=y
 CONFIG_MARVELL_PHY=y
@@ -101,7 +93,6 @@ CONFIG_SPI_ORION=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
-CONFIG_KIRKWOOD_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ORION_WATCHDOG=y
 CONFIG_HID_DRAGONRISE=y
@@ -162,12 +153,12 @@ CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
 CONFIG_NLS_UTF8=y
-CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_FS=y
+CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
-CONFIG_DEBUG_INFO=y
 # CONFIG_FTRACE is not set
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 94540d5..fe8319a 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -93,6 +93,7 @@ comment "Device tree entries"
 config ARCH_KIRKWOOD_DT
 	bool "Marvell Kirkwood Flattened Device Tree"
 	select KIRKWOOD_CLK
+	select OF_IRQ
 	select ORION_IRQCHIP
 	select ORION_TIMER
 	select POWER_SUPPLY
@@ -107,7 +108,7 @@ config ARCH_KIRKWOOD_DT
 
 config MACH_MV88F6281GTW_GE_DT
 	bool "Marvell 88F6281 GTW GE Board (Flattened Device Tree)"
-	select ARCH_KIRKWOOD_DT
+	depends on ARCH_KIRKWOOD_DT
 	help
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell 88F6281 GTW GE Board (Flattened Device Tree).
-- 
1.8.3.2
