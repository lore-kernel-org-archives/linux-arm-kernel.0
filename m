From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Wed, 22 Jun 2016 10:46:50 +0800
Subject: [PATCH V2 1/4] trace: Introduce an output interface from ftrace to STM
In-Reply-To: <1466563613-31578-1-git-send-email-zhang.chunyan@linaro.org>
References: <1466563613-31578-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1466563613-31578-2-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is introducing a new output to print Ftrace messages
to STM buffer when the traces happen.  In order to reduce the
effect on timing overhead as much as possible, only the current
function and its parent's instruction pointer will be recorded
into STM. This idea was first introduced by Philippe Langlais
at ST-Microelectronics a long time ago[1].

[1] http://thread.gmane.org/gmane.linux.kernel/1114274/focus=1114275

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 include/linux/stm.h              |  7 +++++++
 include/linux/trace_output_stm.h | 17 +++++++++++++++++
 kernel/trace/Makefile            |  1 +
 kernel/trace/trace_output_stm.c  | 41 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+)
 create mode 100644 include/linux/trace_output_stm.h
 create mode 100644 kernel/trace/trace_output_stm.c

diff --git a/include/linux/stm.h b/include/linux/stm.h
index 8369d8a..2b6639a 100644
--- a/include/linux/stm.h
+++ b/include/linux/stm.h
@@ -129,6 +129,13 @@ struct stm_source_data {
 	void			(*unlink)(struct stm_source_data *data);
 };
 
+struct stm_ftrace {
+	struct stm_source_data	data;
+	void (*write)(struct stm_source_data *data, const char *buf,
+		      unsigned int len, unsigned int chan);
+	bool available;
+};
+
 int stm_source_register_device(struct device *parent,
 			       struct stm_source_data *data);
 void stm_source_unregister_device(struct stm_source_data *data);
diff --git a/include/linux/trace_output_stm.h b/include/linux/trace_output_stm.h
new file mode 100644
index 0000000..7edc680
--- /dev/null
+++ b/include/linux/trace_output_stm.h
@@ -0,0 +1,17 @@
+#ifndef __TRACE_OUTPUT_STM_H
+#define __TRACE_OUTPUT_STM_H
+
+#include <linux/module.h>
+
+#if IS_ENABLED(CONFIG_STM_SOURCE_FTRACE)
+struct stm_ftrace;
+extern void
+trace_func_to_stm(unsigned long ip, unsigned long parent_ip);
+extern void trace_add_output(struct stm_ftrace *stm);
+extern void trace_rm_output(void);
+#else
+static inline void
+trace_func_to_stm(unsigned long ip, unsigned long parent_ip) {}
+#endif
+
+#endif /* __TRACE_OUTPUT_STM_H */
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 979e7bf..5330803 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -69,4 +69,5 @@ obj-$(CONFIG_UPROBE_EVENT) += trace_uprobe.o
 
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
 
+obj-$(CONFIG_TRACING) += trace_output_stm.o
 libftrace-y := ftrace.o
diff --git a/kernel/trace/trace_output_stm.c b/kernel/trace/trace_output_stm.c
new file mode 100644
index 0000000..dc04952
--- /dev/null
+++ b/kernel/trace/trace_output_stm.c
@@ -0,0 +1,41 @@
+/*
+ * Output interface from Ftrace to STM buffer
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
+
+/* Offset above the start channel number */
+#define STM_FTRACE_CHAN 0
+
+static struct stm_ftrace *trace_output;
+
+void trace_func_to_stm(unsigned long ip, unsigned long parent_ip)
+{
+	unsigned long ip_array[2] = {ip, parent_ip};
+
+	if (trace_output)
+		trace_output->write(&trace_output->data, (char *)ip_array,
+				    sizeof(unsigned long) * 2, STM_FTRACE_CHAN);
+}
+
+void trace_add_output(struct stm_ftrace *stm)
+{
+	trace_output = stm;
+}
+EXPORT_SYMBOL_GPL(trace_add_output);
+
+void trace_rm_output(void)
+{
+	trace_output = NULL;
+}
+EXPORT_SYMBOL_GPL(trace_rm_output);
-- 
1.9.1
