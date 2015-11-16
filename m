From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Nov 2015 17:51:17 +0100
Subject: [PATCH] clocksource: disallow drivers for ARCH_USES_GETTIMEOFFSET
Message-ID: <7579471.4N90fYPQOK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can now select clocksource drivers like ti-32k and CONFIG_OF
on ancient machines that still use gettimeoffset, and the combination
results in a link error.

arch/arm/kernel/built-in.o: In function `time_init':
(.init.text+0xc28): undefined reference to `clocksource_probe'

The reason for this is that the Makefile is hidden behind
CONFIG_ARCH_USES_GETTIMEOFFSET, but the Kconfig file is not, and
it has shown up just now because the ti-32k driver was added
and can be selected using COMPILE_TEST on all platforms.

This patch hides the Kconfig menu in CONFIG_ARCH_USES_GETTIMEOFFSET
as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: dfedaf105d60 ("clocksource: ti-32k: make it depend on GENERIC_CLOCKSOURCE")

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c479f815b99a..db240cb56da7 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -1,4 +1,5 @@
 menu "Clock Source drivers"
+	depends on !ARCH_USES_GETTIMEOFFSET
 
 config CLKSRC_OF
 	bool
