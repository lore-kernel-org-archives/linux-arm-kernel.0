From: ezequiel.garcia@imgtec.com (Ezequiel Garcia)
Date: Wed, 25 Feb 2015 08:47:50 -0300
Subject: [PATCH 6/7] efuse: Move Sunxi fuse driver
Message-ID: <1424864870-3517-1-git-send-email-ezequiel.garcia@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Sunxi SoC eFuse support is currently located under drivers/eeprom,
although the driver is not an eeprom. This commit just moves the driver
to drivers/efuse. There's no functionality change.

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/efuse/Kconfig                      | 12 ++++++++++++
 drivers/efuse/Makefile                     |  1 +
 drivers/{misc/eeprom => efuse}/sunxi_sid.c |  0
 drivers/misc/eeprom/Kconfig                | 13 -------------
 drivers/misc/eeprom/Makefile               |  1 -
 5 files changed, 13 insertions(+), 14 deletions(-)
 rename drivers/{misc/eeprom => efuse}/sunxi_sid.c (100%)

diff --git a/drivers/efuse/Kconfig b/drivers/efuse/Kconfig
index b84e06b..a91a16e 100644
--- a/drivers/efuse/Kconfig
+++ b/drivers/efuse/Kconfig
@@ -6,5 +6,17 @@ config EFUSE_TEGRA
 	help
 	  Support for the eFuses available on Tegra SoCs
 
+config EFUSE_SUNXI_SID
+	tristate "Allwinner sunxi security ID support"
+	depends on ARCH_SUNXI && SYSFS
+	help
+	  This is a driver for the 'security ID' available on various Allwinner
+	  devices.
+
+	  Due to the potential risks involved with changing e-fuses,
+	  this driver is read-only.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called sunxi_sid.
 
 endmenu
diff --git a/drivers/efuse/Makefile b/drivers/efuse/Makefile
index b69a0d6..30f8d5e 100644
--- a/drivers/efuse/Makefile
+++ b/drivers/efuse/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_EFUSE_TEGRA)	+= tegra/
+obj-$(CONFIG_EFUSE_SUNXI_SID)	+= sunxi_sid.o
diff --git a/drivers/misc/eeprom/sunxi_sid.c b/drivers/efuse/sunxi_sid.c
similarity index 100%
rename from drivers/misc/eeprom/sunxi_sid.c
rename to drivers/efuse/sunxi_sid.c
diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 9536852f..04f2e1f 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -96,17 +96,4 @@ config EEPROM_DIGSY_MTC_CFG
 
 	  If unsure, say N.
 
-config EEPROM_SUNXI_SID
-	tristate "Allwinner sunxi security ID support"
-	depends on ARCH_SUNXI && SYSFS
-	help
-	  This is a driver for the 'security ID' available on various Allwinner
-	  devices.
-
-	  Due to the potential risks involved with changing e-fuses,
-	  this driver is read-only.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called sunxi_sid.
-
 endmenu
diff --git a/drivers/misc/eeprom/Makefile b/drivers/misc/eeprom/Makefile
index 9507aec..fc1e81d 100644
--- a/drivers/misc/eeprom/Makefile
+++ b/drivers/misc/eeprom/Makefile
@@ -4,5 +4,4 @@ obj-$(CONFIG_EEPROM_LEGACY)	+= eeprom.o
 obj-$(CONFIG_EEPROM_MAX6875)	+= max6875.o
 obj-$(CONFIG_EEPROM_93CX6)	+= eeprom_93cx6.o
 obj-$(CONFIG_EEPROM_93XX46)	+= eeprom_93xx46.o
-obj-$(CONFIG_EEPROM_SUNXI_SID)	+= sunxi_sid.o
 obj-$(CONFIG_EEPROM_DIGSY_MTC_CFG) += digsy_mtc_eeprom.o
-- 
2.3.0
