From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Fri, 12 Feb 2016 20:43:35 +0300
Subject: [PATCH v2 4/9] ACPI: parse SPCR and enable matching console
In-Reply-To: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
References: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1455299022-11641-5-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'ARM Server Base Boot Requiremets' [1] mentions SPCR (Serial Port
Console Redirection Table) [2] as a mandatory ACPI table that
specifies the configuration of serial console.

Parse this table and check if any registered console match the
description.  If it does, enable that console.

In the original submission [3] the ACPI devices are traversed to find
one that has the same address as specified by SPCR. Then while
registering a serial device it is checked if it has an ACPI companion
and it is the same device that was found at traversal. If so,
add_preferred_console() was used to specify the device as preferred.
The console name and index are known at the time of registration of
serial device.

The problem is that SPCR can specify the console not only by the base
address but also with PCI Device ID/PCI Vendor ID or PCI Bus
Number/PCI Device Number.  In general, there is no way to get serial
name and index from the SPCR table.

To implement that, introduce a new member

        int (*acpi_match)(struct console *, struct acpi_table_spcr *)

of struct console.  It allows drivers to check if they provide a
matching console device.

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0044a/index.html
[2] http://msdn.microsoft.com/en-us/library/windows/hardware/dn639131(v=vs.85).aspx
[3] https://lkml.kernel.org/g/1441716217-23786-1-git-send-email-leif.lindholm at linaro.org

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/acpi/Kconfig    |  3 ++
 drivers/acpi/Makefile   |  1 +
 drivers/acpi/spcr.c     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/console.h | 12 ++++++++
 kernel/printk/printk.c  | 22 ++++++++++++--
 5 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100644 drivers/acpi/spcr.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 65fb483..5611eb6 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -77,6 +77,9 @@ config ACPI_DEBUGGER_USER
 
 endif
 
+config ACPI_SPCR_TABLE
+	bool
+
 config ACPI_SLEEP
 	bool
 	depends on SUSPEND || HIBERNATION
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 346101c..708b143 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
 obj-$(CONFIG_ACPI_CUSTOM_METHOD)+= custom_method.o
 obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
+obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
 
 # processor has its own "processor." module_param namespace
diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
new file mode 100644
index 0000000..0475840
--- /dev/null
+++ b/drivers/acpi/spcr.c
@@ -0,0 +1,77 @@
+/*
+ * Copyright (c) 2012, Intel Corporation
+ * Copyright (c) 2015, Red Hat, Inc.
+ * Copyright (c) 2015, 2016 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/console.h>
+#include <linux/kernel.h>
+
+struct spcr_table_handler_match_data {
+	struct console *console;
+	char **options;
+};
+
+static int spcr_table_handler_match(struct acpi_table_header *t, void *d)
+{
+	struct acpi_table_spcr *table = (struct acpi_table_spcr *)t;
+	struct spcr_table_handler_match_data *data = d;
+	int err;
+
+	if (table->header.revision < 2)
+		return -EOPNOTSUPP;
+
+	err = data->console->acpi_match(data->console, table);
+	if (err < 0)
+		return err;
+
+	if (data->options) {
+		switch (table->baud_rate) {
+		case 3:
+			*data->options = "9600";
+			break;
+		case 4:
+			*data->options = "19200";
+			break;
+		case 6:
+			*data->options = "57600";
+			break;
+		case 7:
+			*data->options = "115200";
+			break;
+		default:
+			*data->options = "";
+			break;
+		}
+	}
+
+	return err;
+}
+
+/**
+ * acpi_console_match - Check if console matches one specified by SPCR.
+ *
+ * @console:	console to match
+ * @options:	if the console matches, this will return options for the console
+ *		as in kernel command line
+ *
+ * Return: a non-error value if the console matches.
+ */
+int acpi_console_match(struct console *console, char **options)
+{
+	struct spcr_table_handler_match_data d = {
+		.console = console,
+		.options = options,
+	};
+
+	if (acpi_disabled || !console->acpi_match || console_set_on_cmdline)
+		return -ENODEV;
+
+	return acpi_table_parse2(ACPI_SIG_SPCR, spcr_table_handler_match, &d);
+}
diff --git a/include/linux/console.h b/include/linux/console.h
index ea731af..dcc2b59 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -15,6 +15,7 @@
 #define _LINUX_CONSOLE_H_ 1
 
 #include <linux/types.h>
+#include <linux/errno.h>
 
 struct vc_data;
 struct console_font_op;
@@ -117,6 +118,7 @@ static inline int con_debug_leave(void)
 #define CON_BRL		(32) /* Used for a braille device */
 #define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
 
+struct acpi_table_spcr;
 struct console {
 	char	name[16];
 	void	(*write)(struct console *, const char *, unsigned);
@@ -125,6 +127,7 @@ struct console {
 	void	(*unblank)(void);
 	int	(*setup)(struct console *, char *);
 	int	(*match)(struct console *, char *name, int idx, char *options);
+	int	(*acpi_match)(struct console *, struct acpi_table_spcr *);
 	short	flags;
 	short	index;
 	int	cflag;
@@ -132,6 +135,15 @@ struct console {
 	struct	 console *next;
 };
 
+#ifdef CONFIG_ACPI_SPCR_TABLE
+int acpi_console_match(struct console *c, char **options);
+#else
+static inline int acpi_console_match(struct console *c, char **options)
+{
+	return -ENODEV;
+}
+#endif
+
 /*
  * for_each_console() allows you to iterate on each console
  */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0cc9542..5c270cf 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2572,8 +2572,26 @@ void register_console(struct console *newcon)
 		break;
 	}
 
-	if (!(newcon->flags & CON_ENABLED))
-		return;
+	if (!(newcon->flags & CON_ENABLED)) {
+		char *opts;
+		int err;
+
+		if (newcon->flags & CON_BOOT)
+			return;
+
+		err = acpi_console_match(newcon, &opts);
+		if (err < 0)
+			return;
+
+		if (newcon->index < 0)
+			newcon->index = 0;
+
+		if (newcon->setup && newcon->setup(newcon, opts) != 0)
+			return;
+
+		newcon->flags |= CON_ENABLED | CON_CONSDEV;
+		has_preferred = true;
+	}
 
 	/*
 	 * If we have a bootconsole, and are switching to a real console,
-- 
2.7.0
