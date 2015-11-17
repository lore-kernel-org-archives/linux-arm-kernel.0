From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:40:32 +0800
Subject: [PATCH v3 33/62] arm/uart: Create generic uart initialization function
In-Reply-To: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447753261-7552-34-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Parth Dixit <parth.dixit@linaro.org>

Rename dt-uart.c to arm-uart.c and create new generic uart init function.
Move dt_uart_init to arm_uart_init.

Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 xen/arch/arm/setup.c        |   2 +-
 xen/drivers/char/Makefile   |   2 +-
 xen/drivers/char/arm-uart.c | 136 ++++++++++++++++++++++++++++++++++++++++++++
 xen/drivers/char/dt-uart.c  | 107 ----------------------------------
 xen/include/xen/serial.h    |   2 +-
 5 files changed, 139 insertions(+), 110 deletions(-)
 create mode 100644 xen/drivers/char/arm-uart.c
 delete mode 100644 xen/drivers/char/dt-uart.c

diff --git a/xen/arch/arm/setup.c b/xen/arch/arm/setup.c
index c15a09d..63feadf 100644
--- a/xen/arch/arm/setup.c
+++ b/xen/arch/arm/setup.c
@@ -766,7 +766,7 @@ void __init start_xen(unsigned long boot_phys_offset,
 
     gic_preinit();
 
-    dt_uart_init();
+    arm_uart_init();
     console_init_preirq();
     console_init_ring();
 
diff --git a/xen/drivers/char/Makefile b/xen/drivers/char/Makefile
index 47fc3f9..a8f65c1 100644
--- a/xen/drivers/char/Makefile
+++ b/xen/drivers/char/Makefile
@@ -6,5 +6,5 @@ obj-$(HAS_EXYNOS4210) += exynos4210-uart.o
 obj-$(HAS_OMAP) += omap-uart.o
 obj-$(HAS_SCIF) += scif-uart.o
 obj-$(HAS_EHCI) += ehci-dbgp.o
-obj-$(CONFIG_ARM) += dt-uart.o
+obj-$(CONFIG_ARM) += arm-uart.o
 obj-y += serial.o
diff --git a/xen/drivers/char/arm-uart.c b/xen/drivers/char/arm-uart.c
new file mode 100644
index 0000000..2ddd744
--- /dev/null
+++ b/xen/drivers/char/arm-uart.c
@@ -0,0 +1,136 @@
+/*
+ * xen/drivers/char/arm-uart.c
+ *
+ * Generic uart retrieved via the device tree or acpi
+ *
+ * Julien Grall <julien.grall@linaro.org>
+ * Copyright (c) 2013 Linaro Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <asm/device.h>
+#include <asm/types.h>
+#include <xen/console.h>
+#include <xen/device_tree.h>
+#include <xen/serial.h>
+#include <xen/errno.h>
+#include <xen/acpi.h>
+
+/*
+ * Configure UART port with a string:
+ * path:options
+ *
+ * @path: full path used in the device tree for the UART. If the path
+ * doesn't start with '/', we assuming that it's an alias.
+ * @options: UART speficic options (see in each UART driver)
+ */
+static char __initdata opt_dtuart[256] = "";
+string_param("dtuart", opt_dtuart);
+
+static void __init dt_uart_init(void)
+{
+    struct dt_device_node *dev;
+    int ret;
+    const char *devpath = opt_dtuart;
+    char *options;
+
+    if ( !console_has("dtuart") )
+        return; /* Not for us */
+
+    if ( !strcmp(opt_dtuart, "") )
+    {
+        const struct dt_device_node *chosen = dt_find_node_by_path("/chosen");
+
+        if ( chosen )
+        {
+            const char *stdout;
+
+            ret = dt_property_read_string(chosen, "stdout-path", &stdout);
+            if ( ret >= 0 )
+            {
+                printk("Taking dtuart configuration from /chosen/stdout-path\n");
+                if ( strlcpy(opt_dtuart, stdout, sizeof(opt_dtuart))
+                     >= sizeof(opt_dtuart) )
+                    printk("WARNING: /chosen/stdout-path too long, truncated\n");
+            }
+            else if ( ret != -EINVAL /* Not present */ )
+                printk("Failed to read /chosen/stdout-path (%d)\n", ret);
+        }
+    }
+
+    if ( !strcmp(opt_dtuart, "") )
+    {
+        printk("No dtuart path configured\n");
+        return;
+    }
+
+    options = strchr(opt_dtuart, ':');
+    if ( options != NULL )
+        *(options++) = '\0';
+    else
+        options = "";
+
+    printk("Looking for dtuart at \"%s\", options \"%s\"\n", devpath, options);
+    if ( *devpath == '/' )
+        dev = dt_find_node_by_path(devpath);
+    else
+        dev = dt_find_node_by_alias(devpath);
+
+    if ( !dev )
+    {
+        printk("Unable to find device \"%s\"\n", devpath);
+        return;
+    }
+
+    ret = device_init(dev, DEVICE_SERIAL, options);
+
+    if ( ret )
+        printk("Unable to initialize dtuart: %d\n", ret);
+}
+
+static void __init acpi_uart_init(void)
+{
+#ifdef CONFIG_ACPI
+    struct acpi_table_spcr *spcr=NULL;
+    int ret;
+
+    acpi_get_table(ACPI_SIG_SPCR, 0,(struct acpi_table_header **)&spcr);
+
+    if ( spcr == NULL )
+        printk("Unable to get spcr table\n");
+    else
+    {
+        ret = acpi_device_init(DEVICE_SERIAL, NULL, spcr->interface_type);
+
+        if ( ret )
+            printk("Unable to initialize acpi uart: %d\n", ret);
+    }
+#endif
+}
+
+void __init arm_uart_init(void)
+{
+    if ( acpi_disabled )
+        dt_uart_init();
+    else
+        acpi_uart_init();
+}
+
+/*
+ * Local variables:
+ * mode: C
+ * c-file-style: "BSD"
+ * c-basic-offset: 4
+ * tab-width: 4
+ * indent-tabs-mode: nil
+ * End:
+ */
diff --git a/xen/drivers/char/dt-uart.c b/xen/drivers/char/dt-uart.c
deleted file mode 100644
index d599322..0000000
--- a/xen/drivers/char/dt-uart.c
+++ /dev/null
@@ -1,107 +0,0 @@
-/*
- * xen/drivers/char/dt-uart.c
- *
- * Generic uart retrieved via the device tree
- *
- * Julien Grall <julien.grall@linaro.org>
- * Copyright (c) 2013 Linaro Limited.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <asm/device.h>
-#include <asm/types.h>
-#include <xen/console.h>
-#include <xen/device_tree.h>
-#include <xen/serial.h>
-#include <xen/errno.h>
-
-/*
- * Configure UART port with a string:
- * path:options
- *
- * @path: full path used in the device tree for the UART. If the path
- * doesn't start with '/', we assuming that it's an alias.
- * @options: UART speficic options (see in each UART driver)
- */
-static char __initdata opt_dtuart[256] = "";
-string_param("dtuart", opt_dtuart);
-
-void __init dt_uart_init(void)
-{
-    struct dt_device_node *dev;
-    int ret;
-    const char *devpath = opt_dtuart;
-    char *options;
-
-    if ( !console_has("dtuart") )
-        return; /* Not for us */
-
-    if ( !strcmp(opt_dtuart, "") )
-    {
-        const struct dt_device_node *chosen = dt_find_node_by_path("/chosen");
-
-        if ( chosen )
-        {
-            const char *stdout;
-
-            ret = dt_property_read_string(chosen, "stdout-path", &stdout);
-            if ( ret >= 0 )
-            {
-                printk("Taking dtuart configuration from /chosen/stdout-path\n");
-                if ( strlcpy(opt_dtuart, stdout, sizeof(opt_dtuart))
-                     >= sizeof(opt_dtuart) )
-                    printk("WARNING: /chosen/stdout-path too long, truncated\n");
-            }
-            else if ( ret != -EINVAL /* Not present */ )
-                printk("Failed to read /chosen/stdout-path (%d)\n", ret);
-        }
-    }
-
-    if ( !strcmp(opt_dtuart, "") )
-    {
-        printk("No dtuart path configured\n");
-        return;
-    }
-
-    options = strchr(opt_dtuart, ':');
-    if ( options != NULL )
-        *(options++) = '\0';
-    else
-        options = "";
-
-    printk("Looking for dtuart at \"%s\", options \"%s\"\n", devpath, options);
-    if ( *devpath == '/' )
-        dev = dt_find_node_by_path(devpath);
-    else
-        dev = dt_find_node_by_alias(devpath);
-
-    if ( !dev )
-    {
-        printk("Unable to find device \"%s\"\n", devpath);
-        return;
-    }
-
-    ret = device_init(dev, DEVICE_SERIAL, options);
-
-    if ( ret )
-        printk("Unable to initialize dtuart: %d\n", ret);
-}
-
-/*
- * Local variables:
- * mode: C
- * c-file-style: "BSD"
- * c-basic-offset: 4
- * tab-width: 4
- * indent-tabs-mode: nil
- * End:
- */
diff --git a/xen/include/xen/serial.h b/xen/include/xen/serial.h
index 71e6ade..5e1a536 100644
--- a/xen/include/xen/serial.h
+++ b/xen/include/xen/serial.h
@@ -170,7 +170,7 @@ struct ns16550_defaults {
 void ns16550_init(int index, struct ns16550_defaults *defaults);
 void ehci_dbgp_init(void);
 
-void __init dt_uart_init(void);
+void __init arm_uart_init(void);
 
 struct physdev_dbgp_op;
 int dbgp_op(const struct physdev_dbgp_op *);
-- 
2.1.0
