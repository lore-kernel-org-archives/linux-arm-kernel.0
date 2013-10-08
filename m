From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Tue,  8 Oct 2013 16:04:09 +0530
Subject: [PATCH] BUS: CCI : Fix arm-cci implicit declarations dependence
 errors.
Message-ID: <1381228449-19575-1-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a OF dependency to configure the ARM_CCI in drivers/bus/Kconfig.
Without this patch, build system can lead to build failure. This was observed
during randconfig testing, in which ARM_CCI was enabled w/o OF being enabled.
Following was the error:

CC      drivers/bus/arm-cci.o
drivers/bus/arm-cci.c: In function ?cci_ace_init_ports?:
drivers/bus/arm-cci.c:131:2: error: implicit declaration of function
?of_find_node_by_path? [-Werror=implicit-function-declaration]
  cpus = of_find_node_by_path("/cpus");
  ^
drivers/bus/arm-cci.c:131:7: warning: assignment makes pointer from integer
without a cast [enabled by default]
  cpus = of_find_node_by_path("/cpus");
       ^
cc1: some warnings being treated as errors
make[2]: *** [drivers/bus/arm-cci.o] Error 1
make[1]: *** [drivers/bus] Error 2

Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-kernel at vger.kernel.org
---
 drivers/bus/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 552373c..e522bd6 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -37,7 +37,7 @@ config OMAP_INTERCONNECT
 
 config ARM_CCI
 	bool "ARM CCI driver support"
-	depends on ARM
+	depends on ARM && OF
 	help
 	  Driver supporting the CCI cache coherent interconnect for ARM
 	  platforms.
-- 
1.7.9.5
