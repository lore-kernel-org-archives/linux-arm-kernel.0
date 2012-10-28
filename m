From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 28 Oct 2012 10:30:31 +0100
Subject: [PATCH v2 1/4] irqchip: add basic infrastructure
In-Reply-To: <1351416634-3352-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351416634-3352-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1351416634-3352-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
 drivers/irqchip/Kconfig   |    3 ++-
 drivers/irqchip/Makefile  |    1 +
 drivers/irqchip/irqchip.c |   23 +++++++++++++++++++++++
 drivers/irqchip/irqchip.h |   14 ++++++++++++++
 include/linux/irqchip.h   |   16 ++++++++++++++++
 5 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 drivers/irqchip/irqchip.c
 create mode 100644 drivers/irqchip/irqchip.h
 create mode 100644 include/linux/irqchip.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 1bb8bf6..e0ff166 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -1 +1,2 @@
-# empty
+config USE_IRQCHIP
+	bool
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 054321d..77adcb1 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -1 +1,2 @@
+obj-$(CONFIG_USE_IRQCHIP) += irqchip.o
 obj-$(CONFIG_ARCH_BCM2835) += irq-bcm2835.o
diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
new file mode 100644
index 0000000..410f99f
--- /dev/null
+++ b/drivers/irqchip/irqchip.c
@@ -0,0 +1,23 @@
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
+static const struct of_device_id irqchip_of_match[] __initconst = {
+	{},
+};
+
+void __init irqchip_init(void)
+{
+	of_irq_init(irqchip_of_match);
+}
diff --git a/drivers/irqchip/irqchip.h b/drivers/irqchip/irqchip.h
new file mode 100644
index 0000000..1e7a5c2
--- /dev/null
+++ b/drivers/irqchip/irqchip.h
@@ -0,0 +1,14 @@
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
+#endif
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
1.7.9.5
