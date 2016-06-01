From: zhang.chunyan@linaro.org (Chunyan Zhang)
Date: Wed,  1 Jun 2016 19:18:57 +0800
Subject: [RFC PATCH 2/4] trace: Introduce an output interface from ftrace to
 STM
In-Reply-To: <1464779939-24986-1-git-send-email-zhang.chunyan@linaro.org>
References: <1464779939-24986-1-git-send-email-zhang.chunyan@linaro.org>
Message-ID: <1464779939-24986-3-git-send-email-zhang.chunyan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is introducing a new function to print Ftrace messages
to STM buffer when the traces happen.  In order to reduce the
effect on timing overhead as much as possible, only the current
function and its parent ip address will be recorded into STM in
this patch.  This idea was first introduced by Philippe Langlais
at ST-Microelectronics a long time ago[1].

[1] http://thread.gmane.org/gmane.linux.kernel/1114274/focus=1114275

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 kernel/trace/Makefile           |  1 +
 kernel/trace/trace_output_stm.c | 27 +++++++++++++++++++++++++++
 kernel/trace/trace_output_stm.h | 14 ++++++++++++++
 3 files changed, 42 insertions(+)
 create mode 100644 kernel/trace/trace_output_stm.c
 create mode 100644 kernel/trace/trace_output_stm.h

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 979e7bf..445afa8 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -69,4 +69,5 @@ obj-$(CONFIG_UPROBE_EVENT) += trace_uprobe.o
 
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
 
+obj-$(CONFIG_STM_FTRACE) += trace_output_stm.o
 libftrace-y := ftrace.o
diff --git a/kernel/trace/trace_output_stm.c b/kernel/trace/trace_output_stm.c
new file mode 100644
index 0000000..f6a3c01
--- /dev/null
+++ b/kernel/trace/trace_output_stm.c
@@ -0,0 +1,27 @@
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
+#include "trace_output_stm.h"
+
+/* Offset above the start channel number */
+#define STM_FTRACE_CHAN 0
+
+void ftrace_stm_func(unsigned long ip, unsigned long parent_ip)
+{
+	unsigned long ip_array[2] = {ip, parent_ip};
+
+	stm_ftrace_write((char *)ip_array, sizeof(unsigned long) * 2,
+			 STM_FTRACE_CHAN);
+}
+EXPORT_SYMBOL_GPL(ftrace_stm_func);
diff --git a/kernel/trace/trace_output_stm.h b/kernel/trace/trace_output_stm.h
new file mode 100644
index 0000000..fc3f989
--- /dev/null
+++ b/kernel/trace/trace_output_stm.h
@@ -0,0 +1,14 @@
+#ifndef __TRACE_OUTPUT_STM_H
+#define __TRACE_OUTPUT_STM_H
+
+#include <linux/module.h>
+
+#ifdef CONFIG_STM_FTRACE
+extern void stm_ftrace_write(const char *buf, unsigned int len,
+			     unsigned int chan);
+extern void ftrace_stm_func(unsigned long ip, unsigned long parent_ip);
+#else
+static inline void ftrace_stm_func(unsigned long ip, unsigned long parent_ip) {}
+#endif
+
+#endif /* __TRACE_OUTPUT_STM_H */
-- 
1.9.1
