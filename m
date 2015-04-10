From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 11 Apr 2015 00:01:32 +0200
Subject: [PATCH] serial: earlycon requires console support
Message-ID: <5009638.HyplLv73fU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A configuration that enables earlycon but not the core console
code causes a link error:

drivers/built-in.o: In function `setup_earlycon':
drivers/tty/serial/earlycon.c:70: undefined reference to `uart_parse_earlycon'

That error can be triggered by the newly added samsung earlycon support,
which is missing a 'select' statement. This patch adds the 'select'
to make serial-samsung behave like the other drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b94ba0328d3b3 ("serial: samsung: Add support for early console")

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f8120c1bde14..5cd8f38a36de 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -241,6 +241,7 @@ config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
 	depends on PLAT_SAMSUNG || ARCH_EXYNOS
 	select SERIAL_CORE
+	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
 	help
 	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
