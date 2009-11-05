From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 05 Nov 2009 12:35:12 +0000
Subject: [RFC PATCH] Add an earlyprintk debug console
Message-ID: <20091105123448.27637.97119.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows an earlyprintk console if CONFIG_DEBUG_LL is enabled,
using the printch asm function.

The patch is based on the original work by Sascha Hauer.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---

The first variant of this patch was posted earlier this year -
http://thread.gmane.org/gmane.linux.ports.arm.kernel/52478 - and there
were a few comments but no follow-up patch. I implemented those
comments and I think we should merge this (it's much easier to pass
earlyprintk on the kernel command line than hacking the printk code to
do a printascii).


 arch/arm/Kconfig.debug         |    8 ++++++
 arch/arm/kernel/Makefile       |    1 +
 arch/arm/kernel/early_printk.c |   57 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/kernel/early_printk.c

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 1a6f70e..feb7b11 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -71,6 +71,14 @@ config DEBUG_LL
 	  in the kernel.  This is helpful if you are debugging code that
 	  executes before the console is initialized.
 
+config EARLY_PRINTK
+	bool "Early printk"
+	depends on DEBUG_LL
+	help
+	  Say Y here if you want to have an early console using the
+	  kernel low-level debugging functions. Add earlyprintk to your
+	  kernel parameters to enable this console.
+
 config DEBUG_ICEDCC
 	bool "Kernel low-level debugging via EmbeddedICE DCC channel"
 	depends on DEBUG_LL
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 79087dd..d0e40b7 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -52,5 +52,6 @@ endif
 
 head-y			:= head$(MMUEXT).o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
+obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 extra-y := $(head-y) init_task.o vmlinux.lds
diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
new file mode 100644
index 0000000..85aa2b2
--- /dev/null
+++ b/arch/arm/kernel/early_printk.c
@@ -0,0 +1,57 @@
+/*
+ *  linux/arch/arm/kernel/early_printk.c
+ *
+ *  Copyright (C) 2009 Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include <linux/init.h>
+
+extern void printch(int);
+
+static void early_write(const char *s, unsigned n)
+{
+	while (n-- > 0) {
+		if (*s == '\n')
+			printch('\r');
+		printch(*s);
+		s++;
+	}
+}
+
+static void early_console_write(struct console *con, const char *s, unsigned n)
+{
+	early_write(s, n);
+}
+
+static struct console early_console = {
+	.name =		"earlycon",
+	.write =	early_console_write,
+	.flags =	CON_PRINTBUFFER | CON_BOOT,
+	.index =	-1,
+};
+
+asmlinkage void early_printk(const char *fmt, ...)
+{
+	char buf[512];
+	int n;
+	va_list ap;
+
+	va_start(ap, fmt);
+	n = vscnprintf(buf, sizeof(buf), fmt, ap);
+	early_write(buf, n);
+	va_end(ap);
+}
+
+static int __init setup_early_printk(char *buf)
+{
+	register_console(&early_console);
+	return 0;
+}
+
+early_param("earlyprintk", setup_early_printk);
