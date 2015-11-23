From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Nov 2015 14:39:33 +0100
Subject: [PATCH] mtd: cfi: enforce valid geometry configuration
Message-ID: <3747078.dk5V5gxuXa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MTD allows compile-time configuration of the possible CFI geometry
settings that are allowed by the kernel, but that includes a couple of
invalid configurations, where no bank width or no interleave setting
is allowed. These are then caught with a compile-time warning:

include/linux/mtd/cfi.h:76:2: warning: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
include/linux/mtd/map.h:145:2: warning: #warning "No CONFIG_MTD_MAP_BANK_WIDTH_xx selected. No NOR chip support can work"

This is a bit annoying for randconfig tests, and can be avoided if
we change the Kconfig logic to always select the simplest configuration
when no other one is enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
index 63b6b536b044..741ec69e0b46 100644
--- a/drivers/mtd/chips/Kconfig
+++ b/drivers/mtd/chips/Kconfig
@@ -69,6 +69,10 @@ endchoice
 config MTD_CFI_GEOMETRY
 	bool "Specific CFI Flash geometry selection"
 	depends on MTD_CFI_ADV_OPTIONS
+	select MTD_MAP_BANK_WIDTH_1 if  !(MTD_MAP_BANK_WIDTH_2 || \
+		 MTD_MAP_BANK_WIDTH_4  || MTD_MAP_BANK_WIDTH_8 || \
+		 MTD_MAP_BANK_WIDTH_16 || MTD_MAP_BANK_WIDTH_32)
+	select MTD_CFI_I1 if !(MTD_CFI_I2 || MTD_CFI_I4 || MTD_CFI_I8)
 	help
 	  This option does not affect the code directly, but will enable
 	  some other configuration options which would allow you to reduce
