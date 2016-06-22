From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Wed, 22 Jun 2016 10:46:51 +0800
Subject: [PATCH V2 2/4] STM Ftrace: Adding generic buffer interface driver
In-Reply-To: <1466563613-31578-1-git-send-email-zhang.chunyan@linaro.org>
References: <1466563613-31578-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1466563613-31578-3-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a driver that models itself as an stm_source and
who's sole purpose is to be an interface to the rest of the
kernel.  Once the stm and stm_source have been linked via sysfs,
everything that is passed to the interface will endup in the STM
trace engine.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/hwtracing/stm/Kconfig  | 10 ++++++
 drivers/hwtracing/stm/Makefile |  2 ++
 drivers/hwtracing/stm/ftrace.c | 77 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 drivers/hwtracing/stm/ftrace.c

diff --git a/drivers/hwtracing/stm/Kconfig b/drivers/hwtracing/stm/Kconfig
index 847a39b..f4c69d2 100644
--- a/drivers/hwtracing/stm/Kconfig
+++ b/drivers/hwtracing/stm/Kconfig
@@ -39,4 +39,14 @@ config STM_SOURCE_HEARTBEAT
 	  If you want to send heartbeat messages over STM devices,
 	  say Y.
 
+config STM_SOURCE_FTRACE
+	tristate "Copy the output from kernel Ftrace to STM engine"
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
index 0000000..ccce91e
--- /dev/null
+++ b/drivers/hwtracing/stm/ftrace.c
@@ -0,0 +1,77 @@
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
+#include <linux/stm.h>
+#include <linux/trace_output_stm.h>
+
+#define STM_FTRACE_NR_CHANNELS 1
+
+static int stm_ftrace_link(struct stm_source_data *data);
+static void stm_ftrace_unlink(struct stm_source_data *data);
+static void stm_ftrace_write(struct stm_source_data *data, const char *buf,
+			     unsigned int len, unsigned int chan);
+
+static struct stm_ftrace ftrace = {
+	.data	= {
+		.name		= "ftrace",
+		.nr_chans	= STM_FTRACE_NR_CHANNELS,
+		.link		= stm_ftrace_link,
+		.unlink		= stm_ftrace_unlink,
+	},
+	.write			= stm_ftrace_write,
+};
+
+/**
+ * stm_ftrace_write() - write data to STM via 'stm_ftrace' source
+ * @buf:	buffer containing the data packet
+ * @len:	length of the data packet
+ * @chan:	offset above the start channel number allocated to 'stm_ftrace'
+ */
+static void notrace stm_ftrace_write(struct stm_source_data *data,
+				     const char *buf, unsigned int len,
+				     unsigned int chan)
+{
+	stm_source_write(data, chan, buf, len);
+}
+
+static int stm_ftrace_link(struct stm_source_data *data)
+{
+	struct stm_ftrace *sf = container_of(data, struct stm_ftrace, data);
+
+	trace_add_output(sf);
+
+	return 0;
+}
+
+static void stm_ftrace_unlink(struct stm_source_data *data)
+{
+	trace_rm_output();
+}
+
+static int __init stm_ftrace_init(void)
+{
+	return stm_source_register_device(NULL, &ftrace.data);
+}
+
+static void __exit stm_ftrace_exit(void)
+{
+	stm_source_unregister_device(&ftrace.data);
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
