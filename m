From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 15:06:32 +0100
Subject: [PATCH 8/9] ARM: pxa: don't select RFKILL if CONFIG_NET is disabled
In-Reply-To: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
References: <1454076396-3563101-1-git-send-email-arnd@arndb.de>
Message-ID: <1454076396-3563101-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bluetooth is only supported when network support is part of the kernel,
so it is a bit pointless to build the tosa-bt support without networking.
If we try anyway, we get a Kconfig warning:

warning: (TOSA_BT && H1940BT) selects RFKILL which has unmet direct dependencies (NET)

This adds a dependency on CONFIG_NET to avoid that case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 01066cff16e4..7ee4652b4c61 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -528,7 +528,7 @@ config MACH_TOSA
 
 config TOSA_BT
 	tristate "Control the state of built-in bluetooth chip on Sharp SL-6000"
-	depends on MACH_TOSA
+	depends on MACH_TOSA && NET
 	select RFKILL
 	help
 	  This is a simple driver that is able to control
-- 
2.7.0
