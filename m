From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Thu, 30 Jun 2016 02:15:47 +0800
Subject: [PATCH v6 04/10] acpi: Add some basic struct and functions in GTDT
 driver
In-Reply-To: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
References: <1467224153-22873-1-git-send-email-fu.wei@linaro.org>
Message-ID: <1467224153-22873-5-git-send-email-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/acpi/acpi_gtdt.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/acpi/acpi_gtdt.c b/drivers/acpi/acpi_gtdt.c
new file mode 100644
index 0000000..54d7644e
--- /dev/null
+++ b/drivers/acpi/acpi_gtdt.c
@@ -0,0 +1,85 @@
+/*
+ * ARM Specific GTDT table Support
+ *
+ * Copyright (C) 2015, Linaro Ltd.
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *         Fu Wei <fu.wei@linaro.org>
+ *         Hanjun Guo <hanjun.guo@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "GTDT: " fmt
+
+typedef struct {
+	struct acpi_table_gtdt *gtdt;
+	void *platform_timer_start;
+	void *gtdt_end;
+} acpi_gtdt_desc_t;
+
+static acpi_gtdt_desc_t acpi_gtdt_desc __initdata;
+
+static inline void *gtdt_next(void *platform_timer, void *end, int type)
+{
+	struct acpi_gtdt_header *gh = platform_timer;
+
+	while ((void *)(gh += gh->length) < end)
+		if (gh->type == type)
+			return (void *)gh;
+	return NULL;
+}
+
+#define for_each_gtdt_type(_g, _t)				\
+	for (_g = acpi_gtdt_desc.platform_timer_start; _g;	\
+	     _g = gtdt_next(_g, acpi_gtdt_desc.gtdt_end, _t))
+
+#define for_each_gtdt_timer(_g)				\
+	for_each_gtdt_type(_g, ACPI_GTDT_TYPE_TIMER_BLOCK)
+
+#define for_each_gtdt_watchdog(_g)			\
+	for_each_gtdt_type(_g, ACPI_GTDT_TYPE_WATCHDOG)
+
+/*
+ * Get some basic info from GTDT table, and init the global variables above
+ * for all timers initialization of Generic Timer.
+ * This function does some validation on GTDT table.
+ */
+static int __init acpi_gtdt_desc_init(struct acpi_table_header *table)
+{
+	struct acpi_table_gtdt *gtdt = container_of(table,
+						    struct acpi_table_gtdt,
+						    header);
+
+	acpi_gtdt_desc.gtdt = gtdt;
+	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
+
+	if (table->revision < 2) {
+		pr_info("Revision:%d doesn't support Platform Timers.\n",
+			table->revision);
+		return 0;
+	}
+
+	if (!gtdt->platform_timer_count) {
+		pr_info("No Platform Timer.\n");
+		return 0;
+	}
+
+	acpi_gtdt_desc.platform_timer_start = (void *)gtdt +
+					      gtdt->platform_timer_offset;
+	if (acpi_gtdt_desc.platform_timer_start <
+	    (void *)table + sizeof(struct acpi_table_gtdt)) {
+		pr_err(FW_BUG "Platform Timer pointer error.\n");
+		acpi_gtdt_desc.platform_timer_start = NULL;
+		return -EINVAL;
+	}
+
+	return gtdt->platform_timer_count;
+}
-- 
2.5.5
