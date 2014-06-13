From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 18:01:06 +0200
Subject: [PATCH 04/14] bus/arm-cci: add dependency on OF && CPU_V7
In-Reply-To: <1402675276-538682-1-git-send-email-arnd@arndb.de>
References: <1402675276-538682-1-git-send-email-arnd@arndb.de>
Message-ID: <1402675276-538682-5-git-send-email-arnd@arndb.de>
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
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index a118ec1..1f37d98 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -45,7 +45,7 @@ config OMAP_INTERCONNECT
 
 config ARM_CCI
 	bool "ARM CCI driver support"
-	depends on ARM
+	depends on ARM && OF && CPU_V7
 	help
 	  Driver supporting the CCI cache coherent interconnect for ARM
 	  platforms.
-- 
1.8.3.2
