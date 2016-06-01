From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Wed,  1 Jun 2016 19:18:56 +0800
Subject: [RFC PATCH 1/4] STM Ftrace: Adding generic buffer interface driver
In-Reply-To: <1464779939-24986-1-git-send-email-zhang.chunyan@linaro.org>
References: <1464779939-24986-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1464779939-24986-2-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a driver that models itself as an stm_source and
who's sole purpose is to export an interface to the rest of the
kernel.  Once the stm and stm_source have been linked via sysfs,
everything that is passed to the interface will endup in the STM
trace engine.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/hwtracing/stm/Kconfig      |  9 +++++++
 drivers/hwtracing/stm/Makefile     |  2 ++
 drivers/hwtracing/stm/stm_ftrace.c | 54 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 drivers/hwtracing/stm/stm_ftrace.c

diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
index 847a39b..a36633a 100644
--- a/drivers/hwtracing/stm/Kconfig
+++ b/drivers/hwtracing/stm/Kconfig
@@ -39,4 +39,13 @@ config STM_SOURCE_HEARTBEAT
 	  If you want to send heartbeat messages over STM devices,
 	  say Y.
 
+config STM_FTRACE
+	tristate "Redirect/copy the output from kernel Ftrace to STM engine"
+	help
+	  This option can be used to redirect or copy the output from kernel Ftrace
+	  to STM engine. Enabling this option will introduce a slight timing effect.
+
+	  If you want to send kernel Ftrace messages over STM devices,
+	  say Y.
+
 endif
diff --git a/drivers/hwtracing/stm/Makefile b/drivers/hwtracing/stm/Makefile
index a9ce3d4..5eef041 100644
--- a/drivers/hwtracing/stm/Makefile
+++ b/drivers/hwtracing/stm/Makefile
@@ -9,3 +9,5 @@ obj-$(CONFIG_STM_SOURCE_HEARTBEAT)	+= stm_heartbeat.o
 
 stm_console-y		:= console.o
 stm_heartbeat-y		:= heartbeat.o
+
+obj-$(CONFIG_STM_FTRACE)	+= stm_ftrace.o
diff --git a/drivers/hwtracing/stm/stm_ftrace.c b/drivers/hwtracing/stm/stm_ftrace.c
new file mode 100644
index 0000000..0b4eb70
--- /dev/null
+++ b/drivers/hwtracing/stm/stm_ftrace.c
@@ -0,0 +1,54 @@
+/*
+ * Simple kernel driver to link kernel Ftrace and an STM device
+ * Copyright (c) 2016, Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/console.h>
+#include <linux/stm.h>
+
+static struct stm_source_data stm_ftrace_data = {
+	.name		= "stm_ftrace",
+	.nr_chans	= 1,
+};
+
+/**
+ * stm_ftrace_write() - write data to STM via 'stm_ftrace' source
+ * @buf:	buffer containing the data packet
+ * @len:	length of the data packet
+ * @chan:	offset above the start channel number allocated to 'stm_ftrace'
+ */
+void notrace stm_ftrace_write(const char *buf, unsigned int len,
+			      unsigned int chan)
+{
+	stm_source_write(&stm_ftrace_data, chan, buf, len);
+}
+EXPORT_SYMBOL_GPL(stm_ftrace_write);
+
+static int __init stm_ftrace_init(void)
+{
+	return stm_source_register_device(NULL, &stm_ftrace_data);
+}
+
+static void __exit stm_ftrace_exit(void)
+{
+	stm_source_unregister_device(&stm_ftrace_data);
+}
+
+module_init(stm_ftrace_init);
+module_exit(stm_ftrace_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("stm_ftrace driver");
+MODULE_AUTHOR("Chunyan Zhang <zhang.chunyan@linaro.org>");
-- 
1.9.1
