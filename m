From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  8 May 2014 16:56:18 +0200
Subject: [PATCH] bus/arm-cci: add dependency on OF && CPU_V7
In-Reply-To: <1399560990-1402858-1-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
Message-ID: <1399560990-1402858-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm-cci code uses device tree helpers for initialization
that don't work on kernels built without CONFIG_OF. Further,
it contains an inline assembly in cci_enable_port_for_self()
that uses ARMv7 instructions and fails to build when targetting
other ARM instruction set versions.

This works around both issues by limiting the scope of the
Kconfig symbol to platforms that can actually build this driver
cleanly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 552373c..d53417e 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -37,7 +37,7 @@ config OMAP_INTERCONNECT
 
 config ARM_CCI
 	bool "ARM CCI driver support"
-	depends on ARM
+	depends on ARM && OF && CPU_V7
 	help
 	  Driver supporting the CCI cache coherent interconnect for ARM
 	  platforms.
-- 
1.8.3.2
