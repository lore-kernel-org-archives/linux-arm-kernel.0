From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 20 Aug 2012 07:47:30 -0700
Subject: [PATCH 12/12] ARM: versatile: Make able to use UART ports for KGDB
 FIQ debugger
In-Reply-To: <20120820144449.GA32560@lizard>
References: <20120820144449.GA32560@lizard>
Message-ID: <1345474050-8339-12-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If enabled, kernel will able to enter KGDB upon serial line activity on
UART ports.

Note that even with this patch and CONFIG_KGDB_FIQ is enabled, you still
need to pass kgdb_fiq.enable=1 kernel command line option, otherwise UART
will behave in a normal way.

By default UART0 is used, but this can be changed via kgdb_fiq.uart_num
kernel command line option.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/arm/Kconfig                   |  1 +
 arch/arm/mach-versatile/Makefile   |  1 +
 arch/arm/mach-versatile/kgdb_fiq.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 arch/arm/mach-versatile/kgdb_fiq.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c978c74..689b716 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -330,6 +330,7 @@ config ARCH_VERSATILE
 	select ICST
 	select GENERIC_CLOCKEVENTS
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARCH_MIGHT_HAVE_KGDB_FIQ
 	select NEED_MACH_IO_H if PCI
 	select PLAT_VERSATILE
 	select PLAT_VERSATILE_CLOCK
diff --git a/arch/arm/mach-versatile/Makefile b/arch/arm/mach-versatile/Makefile
index 81fa3fe..bfd761f 100644
--- a/arch/arm/mach-versatile/Makefile
+++ b/arch/arm/mach-versatile/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_ARCH_VERSATILE_PB)		+= versatile_pb.o
 obj-$(CONFIG_MACH_VERSATILE_AB)		+= versatile_ab.o
 obj-$(CONFIG_MACH_VERSATILE_DT)		+= versatile_dt.o
 obj-$(CONFIG_PCI)			+= pci.o
+obj-$(CONFIG_KGDB_FIQ)			+= kgdb_fiq.o
diff --git a/arch/arm/mach-versatile/kgdb_fiq.c b/arch/arm/mach-versatile/kgdb_fiq.c
new file mode 100644
index 0000000..3cdf71d
--- /dev/null
+++ b/arch/arm/mach-versatile/kgdb_fiq.c
@@ -0,0 +1,31 @@
+/*
+ * KGDB FIQ board support
+ *
+ * Copyright 2012 Linaro Ltd.
+ *		  Anton Vorontsov <anton.vorontsov@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kgdb.h>
+#include <mach/hardware.h>
+#include <mach/platform.h>
+#include <asm/hardware/vic.h>
+
+static int kgdb_fiq;
+module_param_named(uart_num, kgdb_fiq, int, 0600);
+MODULE_PARM_DESC(uart_num, "UART<number> port to use for KGDB FIQ");
+
+static int __init kgdb_fiq_init(void)
+{
+	WARN_ON(kgdb_fiq > INT_UARTINT2 - INT_UARTINT0);
+
+	return kgdb_register_fiq(INT_UARTINT0 + kgdb_fiq,
+				 vic_fiq_select,
+				 vic_is_fiq_rised);
+}
+console_initcall(kgdb_fiq_init);
-- 
1.7.11.5
