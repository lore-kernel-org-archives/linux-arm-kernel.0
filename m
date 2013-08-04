From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Sun,  4 Aug 2013 13:30:49 +0530
Subject: [PATCH] MFD: Make VEXPRESS MFD controller depends on VEXPRESS systems
Message-ID: <1375603249-27206-1-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a Kconfig dependency on an ARCH_VEXPRESS(it is for
both ARM and ARM64) or ARCH_VEXPRESS_CA9X being available before
VEXPRESS_CONFIG can be enabled. Without this patch,build system
can lead to issues. This was discovered during randconfig testing,
in which VEXPRESS_CONFIG was enabled w/o ARCH_VEXPRESS or VEXPRESS_CONFIG
being enabled,leading to the following error:

CC      drivers/mfd/vexpress-config.o
drivers/mfd/vexpress-config.c: In function ?__vexpress_config_func_get?:
drivers/mfd/vexpress-config.c:117:4: error: implicit declaration of function
?of_find_node_by_phandle? [-Werror=implicit-function-declaration]
    bridge_node = of_find_node_by_phandle(
    ^
drivers/mfd/vexpress-config.c:117:16: warning: assignment makes pointer from
integer without a cast [enabled by default]
    bridge_node = of_find_node_by_phandle(

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Deepak Saxena <dsaxena@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 633ee43..c9202f6 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1174,7 +1174,7 @@ endmenu
 
 config VEXPRESS_CONFIG
 	bool "ARM Versatile Express platform infrastructure"
-	depends on ARM || ARM64
+	depends on ARCH_VEXPRESS || ARCH_VEXPRESS_CA9X4
 	help
 	  Platform configuration infrastructure for the ARM Ltd.
 	  Versatile Express.
-- 
1.7.9.5
