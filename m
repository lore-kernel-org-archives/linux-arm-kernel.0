From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Tue, 18 Oct 2016 16:08:59 +0800
Subject: [PATCH V7 2/3] stm class: ftrace: Add ftrace-export-over-stm driver
In-Reply-To: <1476778140-10319-1-git-send-email-zhang.chunyan@linaro.org>
References: <1476778140-10319-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1476778140-10319-3-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a driver that models itself as an stm_source called
stm_ftrace. Once the stm device and stm_ftrace have been linked via
sysfs, the driver registers itself as a trace_export and everything
passed to the interface from Ftrace subsystem will end up in the STM
trace engine.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/hwtracing/stm/Kconfig  | 11 ++++++
 drivers/hwtracing/stm/Makefile |  2 +
 drivers/hwtracing/stm/ftrace.c | 88 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 drivers/hwtracing/stm/ftrace.c

diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
index 847a39b..b34ea96 100644
--- a/drivers/hwtracing/stm/Kconfig
+++ b/drivers/hwtracing/stm/Kconfig
@@ -39,4 +39,15 @@ config STM_SOURCE_HEARTBEAT
 	  If you want to send heartbeat messages over STM devices,
 	  say Y.
 
+config STM_SOURCE_FTRACE
+	tristate "Copy the output from kernel Ftrace to STM engine"
+	depends on TRACING
+	help
+	  This option can be used to copy the output from kernel Ftrace
+	  to STM engine. Enabling this option will introduce a slight
+	  timing effect.
+
+	  If you want to send kernel Ftrace messages over STM devices,
+	  say Y.
+
 endif
diff --git a/drivers/hwtracing/stm/Makefile b/drivers/hwtracing/stm/Makefile
index a9ce3d4..3abd84c 100644
--- a/drivers/hwtracing/stm/Makefile
+++ b/drivers/hwtracing/stm/Makefile
@@ -6,6 +6,8 @@ obj-$(CONFIG_STM_DUMMY)	+= dummy_stm.o
 
 obj-$(CONFIG_STM_SOURCE_CONSOLE)	+= stm_console.o
 obj-$(CONFIG_STM_SOURCE_HEARTBEAT)	+= stm_heartbeat.o
+obj-$(CONFIG_STM_SOURCE_FTRACE)		+= stm_ftrace.o
 
 stm_console-y		:= console.o
 stm_heartbeat-y		:= heartbeat.o
+stm_ftrace-y		:= ftrace.o
diff --git a/drivers/hwtracing/stm/ftrace.c b/drivers/hwtracing/stm/ftrace.c
new file mode 100644
index 0000000..1a114c8f
--- /dev/null
+++ b/drivers/hwtracing/stm/ftrace.c
@@ -0,0 +1,88 @@
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
+ *
+ * STM Ftrace will be registered as a trace_export.
+ */
+
+#include <linux/module.h>
+#include <linux/stm.h>
+#include <linux/trace.h>
+
+#define STM_FTRACE_NR_CHANNELS 1
+#define STM_FTRACE_CHAN 0
+
+static int stm_ftrace_link(struct stm_source_data *data);
+static void stm_ftrace_unlink(struct stm_source_data *data);
+
+static struct stm_ftrace {
+	struct stm_source_data	data;
+	struct trace_export	ftrace;
+} stm_ftrace = {
+	.data	= {
+		.name		= "ftrace",
+		.nr_chans	= STM_FTRACE_NR_CHANNELS,
+		.link		= stm_ftrace_link,
+		.unlink		= stm_ftrace_unlink,
+	},
+};
+
+/**
+ * stm_ftrace_write() - write data to STM via 'stm_ftrace' source
+ * @buf:	buffer containing the data packet
+ * @len:	length of the data packet
+ */
+static void notrace
+stm_ftrace_write(const char *buf, unsigned int len)
+{
+	stm_source_write(&stm_ftrace.data, STM_FTRACE_CHAN, buf, len);
+}
+
+static int stm_ftrace_link(struct stm_source_data *data)
+{
+	struct stm_ftrace *sf = container_of(data, struct stm_ftrace, data);
+
+	sf->ftrace.write = stm_ftrace_write;
+	sf->ftrace.next = NULL;
+
+	return register_ftrace_export(&sf->ftrace);
+}
+
+static void stm_ftrace_unlink(struct stm_source_data *data)
+{
+	struct stm_ftrace *sf = container_of(data, struct stm_ftrace, data);
+
+	unregister_ftrace_export(&sf->ftrace);
+}
+
+static int __init stm_ftrace_init(void)
+{
+	int ret;
+
+	ret = stm_source_register_device(NULL, &stm_ftrace.data);
+	if (ret)
+		pr_err("Failed to register stm_source - ftrace.\n");
+
+	return ret;
+}
+
+static void __exit stm_ftrace_exit(void)
+{
+	stm_source_unregister_device(&stm_ftrace.data);
+}
+
+module_init(stm_ftrace_init);
+module_exit(stm_ftrace_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("stm_ftrace driver");
+MODULE_AUTHOR("Chunyan Zhang <zhang.chunyan@linaro.org>");
-- 
2.7.4
