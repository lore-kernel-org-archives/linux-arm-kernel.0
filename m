From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  8 Feb 2016 13:51:43 +0100
Subject: [PATCH 2/2] serial: 8250: fix building Ingenic with SERIAL_8250=m
In-Reply-To: <1454935947-2743255-1-git-send-email-arnd@arndb.de>
References: <1454935947-2743255-1-git-send-email-arnd@arndb.de>
Message-ID: <1454935947-2743255-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Ingenic 8250 driver has a 'bool' Kconfig symbol, but that
breaks when SERIAL_8250 is a loadable module:

drivers/tty/built-in.o: In function `ingenic_uart_probe':
8250_ingenic.c:(.text+0x1c1a0): undefined reference to `serial8250_register_8250_port'

This changes the symbol to a 'tristate', plus a dependency on
SERIAL_8250, which makes it work again. Unlike the other
soc-specific backends, this one has no dependency on an
architecture or a platform. I'm adding a dependency on
MIPS || COMPILE_TEST as well here, to avoid showing the driver
on architectures that are not interested in it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/8250/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 6ae0fae4f796..13c63b14179f 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -384,8 +384,8 @@ config SERIAL_8250_UNIPHIER
 	  serial ports, say Y to this option. If unsure, say N.
 
 config SERIAL_8250_INGENIC
-	bool "Support for Ingenic SoC serial ports"
-	depends on OF_FLATTREE
+	tristate "Support for Ingenic SoC serial ports"
+	depends on SERIAL_8250 && OF_FLATTREE && (MIPS || COMPILE_TEST)
 	select LIBFDT
 	help
 	  If you have a system using an Ingenic SoC and wish to make use of
-- 
2.7.0
