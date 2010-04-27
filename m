From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 27 Apr 2010 15:25:00 +0800
Subject: [PATCH 1/3] pxa/tosa: move CONFIG_KEYBOARD_TOSA_USE_EXT_KEYCODES to
	mach/Kconfig
Message-ID: <r2kf17812d71004270025x8b13147cx20540d124910969@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 0c345a3bfd3d6f9de8b06b01f847518f1c466428
Author: Eric Miao <eric.y.miao@gmail.com>
Date:   Tue Apr 27 14:43:03 2010 +0800

    [ARM] pxa/tosa: move CONFIG_KEYBOARD_TOSA_USE_EXT_KEYCODES to mach/Kconfig

    Tosa is now able to use generic matrix keypad driver instead of
the deprecated
    tosakbd.c, where CONFIG_KEYBOARD_TOSA_USE_EXT_KEYCODES is still
useful.  Move
    it to mach/Kconfig.

    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 352dc4f..454cd5d 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -643,6 +643,18 @@ config TOSA_BT
 	  This is a simple driver that is able to control
 	  the state of built in bluetooth chip on tosa.

+config TOSA_USE_EXT_KEYCODES
+	bool "Tosa keyboard: use extended keycodes"
+	depends on MACH_TOSA
+	default n
+	help
+	  Say Y here to enable the tosa keyboard driver to generate extended
+	  (>= 127) keycodes. Be aware, that they can't be correctly interpreted
+	  by either console keyboard driver or by Kdrive keybd driver.
+
+	  Say Y only if you know, what you are doing!
+
+
 config PXA_HAVE_BOARD_IRQS
 	bool

diff --git a/arch/arm/mach-pxa/include/mach/tosa.h
b/arch/arm/mach-pxa/include/mach/tosa.h
index 4df2d38..1bbd1f2 100644
--- a/arch/arm/mach-pxa/include/mach/tosa.h
+++ b/arch/arm/mach-pxa/include/mach/tosa.h
@@ -167,7 +167,7 @@

 #define TOSA_KEY_SYNC		KEY_102ND /* ??? */

-#ifndef CONFIG_KEYBOARD_TOSA_USE_EXT_KEYCODES
+#ifndef CONFIG_TOSA_USE_EXT_KEYCODES
 #define TOSA_KEY_RECORD		KEY_YEN
 #define TOSA_KEY_ADDRESSBOOK	KEY_KATAKANA
 #define TOSA_KEY_CANCEL		KEY_ESC
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 64c1023..a74ee12 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -426,16 +426,6 @@ config KEYBOARD_TOSA
 	  To compile this driver as a module, choose M here: the
 	  module will be called tosakbd.

-config KEYBOARD_TOSA_USE_EXT_KEYCODES
-	bool "Tosa keyboard: use extended keycodes"
-	depends on KEYBOARD_TOSA
-	help
-	  Say Y here to enable the tosa keyboard driver to generate extended
-	  (>= 127) keycodes. Be aware, that they can't be correctly interpreted
-	  by either console keyboard driver or by Kdrive keybd driver.
-
-	  Say Y only if you know, what you are doing!
-
 config KEYBOARD_XTKBD
 	tristate "XT keyboard"
 	select SERIO
