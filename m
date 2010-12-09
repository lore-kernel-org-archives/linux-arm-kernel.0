From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 9 Dec 2010 23:12:45 +0800
Subject: [PATCH v2 10/15] ARM: mxs: Add static memory mapping
In-Reply-To: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1291907569-8925-10-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create static memory mapping for MX23 and MX28.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Changes for v2:
 - Change the inclusion of hardware.h to mx23.h and mx28.h respectively
 - Remove the call to mxs_iomux_init() and mxs_arch_reset_init() from
   map_io callback, and turn them into __initcall, as the call here is
   a little late.

 arch/arm/mach-mxs/mm-mx23.c |   45 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/mm-mx28.c |   45 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/mm-mx23.c
 create mode 100644 arch/arm/mach-mxs/mm-mx28.c

diff --git a/arch/arm/mach-mxs/mm-mx23.c b/arch/arm/mach-mxs/mm-mx23.c
new file mode 100644
index 0000000..5148cd6
--- /dev/null
+++ b/arch/arm/mach-mxs/mm-mx23.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License.  You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ *
+ * Create static mapping between physical to virtual memory.
+ */
+
+#include <linux/mm.h>
+#include <linux/init.h>
+
+#include <asm/mach/map.h>
+
+#include <mach/mx23.h>
+#include <mach/common.h>
+#include <mach/iomux.h>
+
+/*
+ * Define the MX23 memory map.
+ */
+static struct map_desc mx23_io_desc[] __initdata = {
+	mxs_map_entry(MX23, OCRAM, MT_DEVICE),
+	mxs_map_entry(MX23, IO, MT_DEVICE),
+};
+
+/*
+ * This function initializes the memory map. It is called during the
+ * system startup to create static physical to virtual memory mappings
+ * for the IO modules.
+ */
+void __init mx23_map_io(void)
+{
+	iotable_init(mx23_io_desc, ARRAY_SIZE(mx23_io_desc));
+}
+
+void __init mx23_init_irq(void)
+{
+	icoll_init_irq();
+	mx23_register_gpios();
+}
diff --git a/arch/arm/mach-mxs/mm-mx28.c b/arch/arm/mach-mxs/mm-mx28.c
new file mode 100644
index 0000000..7e4cea3
--- /dev/null
+++ b/arch/arm/mach-mxs/mm-mx28.c
@@ -0,0 +1,45 @@
+/*
+ * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License.  You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ *
+ * Create static mapping between physical to virtual memory.
+ */
+
+#include <linux/mm.h>
+#include <linux/init.h>
+
+#include <asm/mach/map.h>
+
+#include <mach/mx28.h>
+#include <mach/common.h>
+#include <mach/iomux.h>
+
+/*
+ * Define the MX28 memory map.
+ */
+static struct map_desc mx28_io_desc[] __initdata = {
+	mxs_map_entry(MX28, OCRAM, MT_DEVICE),
+	mxs_map_entry(MX28, IO, MT_DEVICE),
+};
+
+/*
+ * This function initializes the memory map. It is called during the
+ * system startup to create static physical to virtual memory mappings
+ * for the IO modules.
+ */
+void __init mx28_map_io(void)
+{
+	iotable_init(mx28_io_desc, ARRAY_SIZE(mx28_io_desc));
+}
+
+void __init mx28_init_irq(void)
+{
+	icoll_init_irq();
+	mx28_register_gpios();
+}
-- 
1.7.1
