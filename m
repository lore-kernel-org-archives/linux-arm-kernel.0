From: robherring2@gmail.com (Rob Herring)
Date: Thu,  3 Jan 2013 11:54:10 -0600
Subject: [PATCH v4 01/19] irqchip: add basic infrastructure
In-Reply-To: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
Message-ID: <1357235668-9450-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

With the recent creation of the drivers/irqchip/ directory, it is
desirable to move irq controller drivers here. At the moment, the only
driver here is irq-bcm2835, the driver for the irq controller found in
the ARM BCM2835 SoC, present in Rasberry Pi systems. This irq
controller driver was exporting its initialization function and its
irq handling function through a header file in
<linux/irqchip/bcm2835.h>.

When proposing to also move another irq controller driver in
drivers/irqchip, Rob Herring raised the very valid point that moving
things to drivers/irqchip was good in order to remove more stuff from
arch/arm, but if it means adding gazillions of headers files in
include/linux/irqchip/, it would not be very nice.

So, upon the suggestion of Rob Herring and Arnd Bergmann, this commit
introduces a small infrastructure that defines a central
irqchip_init() function in drivers/irqchip/irqchip.c, which is meant
to be called as the ->init_irq() callback of ARM platforms. This
function calls of_irq_init() with an array that will progressively
contain the compatible strings of each irq controller driver, and also
a reference to the initialization functions of such drivers. The
drivers/irqchip/irqchip.h header file, currently empty, is added to
allow irq controller drivers to expose their initialization function
to the main irqchip.c file. Note that the irq controller driver
initialization function is responsible for setting the global
handle_arch_irq() variable, so that ARM platforms no longer have to
define the ->handle_irq field in their DT_MACHINE structure.

A global header, <linux/irqchip.h> is also added to expose the single
irqchip_init() function to the reset of the kernel.

A further commit moves the BCM2835 irq controller driver to this new
small infrastructure, therefore removing the include/linux/irqchip/
directory.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Stephen Warren <swarren@wwwdotorg.org>
Reviewed-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/irqchip/Kconfig           |    4 ++++
 drivers/irqchip/Makefile          |    2 ++
 drivers/irqchip/irqchip.c         |   30 ++++++++++++++++++++++++++++++
 drivers/irqchip/irqchip.h         |   29 +++++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |   12 +++++++++++-
 include/linux/irqchip.h           |   16 ++++++++++++++++
 6 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 drivers/irqchip/irqchip.c
 create mode 100644 drivers/irqchip/irqchip.h
 create mode 100644 include/linux/irqchip.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 62ca575..93dfd8f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -1,3 +1,7 @@
+config IRQCHIP
+	def_bool y
+	depends on OF_IRQ
+
 config VERSATILE_FPGA_IRQ
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index bf4609a..29b78c9 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1,3 +1,5 @@
+obj-$(CONFIG_IRQCHIP)			+= irqchip.o
+
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi.o
 obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
new file mode 100644
index 0000000..f496afc
--- /dev/null
+++ b/drivers/irqchip/irqchip.c
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2012 Thomas Petazzoni
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/of_irq.h>
+
+#include "irqchip.h"
+
+/*
+ * This special of_device_id is the sentinel at the end of the
+ * of_device_id[] array of all irqchips. It is automatically placed at
+ * the end of the array by the linker, thanks to being part of a
+ * special section.
+ */
+static const struct of_device_id
+irqchip_of_match_end __used __section(__irqchip_of_end);
+
+extern struct of_device_id __irqchip_begin[];
+
+void __init irqchip_init(void)
+{
+	of_irq_init(__irqchip_begin);
+}
diff --git a/drivers/irqchip/irqchip.h b/drivers/irqchip/irqchip.h
new file mode 100644
index 0000000..e445ba2
--- /dev/null
+++ b/drivers/irqchip/irqchip.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2012 Thomas Petazzoni
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef _IRQCHIP_H
+#define _IRQCHIP_H
+
+/*
+ * This macro must be used by the different irqchip drivers to declare
+ * the association between their DT compatible string and their
+ * initialization function.
+ *
+ * @name: name that must be unique accross all IRQCHIP_DECLARE of the
+ * same file.
+ * @compstr: compatible string of the irqchip driver
+ * @fn: initialization function
+ */
+#define IRQCHIP_DECLARE(name,compstr,fn)				\
+	static const struct of_device_id irqchip_of_match_##name	\
+	__used __section(__irqchip_of_table)				\
+	= { .compatible = compstr, .data = fn }
+
+#endif
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d1ea7ce..c80c599 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -149,6 +149,15 @@
 #define TRACE_SYSCALLS()
 #endif
 
+#ifdef CONFIG_IRQCHIP
+#define IRQCHIP_OF_MATCH_TABLE()					\
+	. = ALIGN(8);							\
+	VMLINUX_SYMBOL(__irqchip_begin) = .;				\
+	*(__irqchip_of_table)		  				\
+	*(__irqchip_of_end)
+#else
+#define IRQCHIP_OF_MATCH_TABLE()
+#endif
 
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
@@ -493,7 +502,8 @@
 	DEV_DISCARD(init.rodata)					\
 	CPU_DISCARD(init.rodata)					\
 	MEM_DISCARD(init.rodata)					\
-	KERNEL_DTB()
+	KERNEL_DTB()							\
+	IRQCHIP_OF_MATCH_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text)							\
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
new file mode 100644
index 0000000..e0006f1
--- /dev/null
+++ b/include/linux/irqchip.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) 2012 Thomas Petazzoni
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef _LINUX_IRQCHIP_H
+#define _LINUX_IRQCHIP_H
+
+void irqchip_init(void);
+
+#endif
-- 
1.7.10.4
