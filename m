From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Oct 2015 00:03:38 +0200
Subject: [PATCH] bluetooth: bpa10x: fix BT_HCIUART dependency
Message-ID: <4199320.WWtqtXexhZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change to bpa10x to use the h4_recv_buf helper added a dependency
on BT_HCIUART. This was incorrectly added to Kconfig by adding a
'select' statement, which now in turn causes build failures
when CONFIG_TTY is not set:

warning: (BT_HCIBPA10X) selects BT_HCIUART which has unmet direct dependencies (NET && BT && TTY)
vers/built-in.o: In function `hci_uart_tty_receive':
fpga-mgr.c:(.text+0x282824): undefined reference to `tty_unthrottle'
drivers/built-in.o: In function `hci_uart_tty_ioctl':
fpga-mgr.c:(.text+0x282aa0): undefined reference to `n_tty_ioctl_helper'
drivers/built-in.o: In function `hci_uart_flush':

This replaces the 'select BT_HCIUART' dependency with 'depends on', which
does not have this kind of problem. Alternatively, one could add 'depends
on TTY', but avoiding 'select' on user-visible options is generally the
preferred choice as that does not introduce the potential for dependency
loops or incomplete dependency chains.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: a4a4affca68c ("Bluetooth: bpa10x: Fix missing BT_HCIUART dependency")
Fixes: 943cc592195e ("Bluetooth: bpa10x: Use h4_recv_buf helper for frame reassembly")
---
Found on ARM randconfig builds

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index fcf52fdb1ba3..ec6af1595062 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -183,8 +183,7 @@ config BT_HCIBCM203X
 
 config BT_HCIBPA10X
 	tristate "HCI BPA10x USB driver"
-	depends on USB
-	select BT_HCIUART
+	depends on USB && BT_HCIUART
 	select BT_HCIUART_H4
 	help
 	  Bluetooth HCI BPA10x USB driver.
