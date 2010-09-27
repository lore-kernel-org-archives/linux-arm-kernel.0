From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Mon, 27 Sep 2010 14:59:30 +0200
Subject: [PATCH] KS8695: make add_preferred_console() and device name
	configurable
Message-ID: <4CA09532.7010804@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add_preferred_console() makes sense only when bootloader doesn't
provide "console" parameter or KS8695s serial port is the only
UART provided on the system. Otherwise the external UART will
be omitted even if proper "console" parameter is provided.

This patch makes add_preferred_console() configurable and port
name is now configurable too.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Index: b/drivers/serial/Kconfig
===================================================================
--- a/drivers/serial/Kconfig	2010-08-27 01:47:12.000000000 +0200
+++ b/drivers/serial/Kconfig	2010-09-13 12:31:26.000000000 +0200
@@ -426,6 +426,20 @@
 	  receives all kernel messages and warnings and which allows
 	  logins in single user mode).
 
+config SERIAL_KS8695_CONSOLE_NAME
+	string "Console device name"
+	depends on SERIAL_KS8695_CONSOLE=y
+	default "ttyAM"
+	help
+	  Specify console device name
+
+config SERIAL_KS8695_CONSOLE_PREFFERED
+	bool "Add KS8695 console as preffered one"
+	depends on SERIAL_KS8695_CONSOLE=y
+	help
+	  Adds specified console device name as a preffered console, so any
+	  console=x kernel parameter will be ignored
+
 config SERIAL_CLPS711X
 	tristate "CLPS711X serial port support"
 	depends on ARM && ARCH_CLPS711X
Index: b/drivers/serial/serial_ks8695.c
===================================================================
--- a/drivers/serial/serial_ks8695.c	2010-08-27 01:47:12.000000000 +0200
+++ b/drivers/serial/serial_ks8695.c	2010-09-13 12:23:33.000000000 +0200
@@ -38,7 +38,7 @@
 
 #define SERIAL_KS8695_MAJOR	204
 #define SERIAL_KS8695_MINOR	16
-#define SERIAL_KS8695_DEVNAME	"ttyAM"
+#define SERIAL_KS8695_DEVNAME	CONFIG_SERIAL_KS8695_CONSOLE_NAME
 
 #define SERIAL_KS8695_NR	1
 
@@ -650,7 +650,9 @@
 
 static int __init ks8695_console_init(void)
 {
+#ifdef CONFIG_SERIAL_KS8695_CONSOLE_PREFFERED
 	add_preferred_console(SERIAL_KS8695_DEVNAME, 0, NULL);
+#endif
 	register_console(&ks8695_console);
 	return 0;
 }
