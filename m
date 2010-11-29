From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 29 Nov 2010 19:59:15 +0800
Subject: [PATCH v2 10/15] ARM: mxs: Add static memory mapping
In-Reply-To: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1291031956-30314-5-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create static memory mapping for MX23 and MX28.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Changes for v2:
 - Remove the calls to mxs_set_cpu_type()

 arch/arm/mach-mxs/mm-mx23.c |   47 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/mm-mx28.c |   47 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/mm-mx23.c
 create mode 100644 arch/arm/mach-mxs/mm-mx28.c

diff --git a/arch/arm/mach-mxs/mm-mx23.c b/arch/arm/mach-mxs/mm-mx23.c
new file mode 100644
index 0000000..d254064
--- /dev/null
+++ b/arch/arm/mach-mxs/mm-mx23.c
@@ -0,0 +1,47 @@
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
+#include <mach/hardware.h>
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
+	mxs_iomux_init(MX23_IO_ADDRESS(MX23_PINCTRL_BASE_ADDR));
+	mxs_arch_reset_init(MX23_IO_ADDRESS(MX23_RTC_BASE_ADDR));
+	iotable_init(mx23_io_desc, ARRAY_SIZE(mx23_io_desc));
+}
+
+void __init mx23_init_irq(void)
+{
+	icoll_init_irq(MX23_IO_ADDRESS(MX23_ICOLL_BASE_ADDR));
+	mx23_register_gpios();
+}
diff --git a/arch/arm/mach-mxs/mm-mx28.c b/arch/arm/mach-mxs/mm-mx28.c
new file mode 100644
index 0000000..38c27bc
--- /dev/null
+++ b/arch/arm/mach-mxs/mm-mx28.c
@@ -0,0 +1,47 @@
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
+#include <mach/hardware.h>
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
+	mxs_iomux_init(MX28_IO_ADDRESS(MX28_PINCTRL_BASE_ADDR));
+	mxs_arch_reset_init(MX28_IO_ADDRESS(MX28_RTC_BASE_ADDR));
+	iotable_init(mx28_io_desc, ARRAY_SIZE(mx28_io_desc));
+}
+
+void __init mx28_init_irq(void)
+{
+	icoll_init_irq(MX28_IO_ADDRESS(MX28_ICOLL_BASE_ADDR));
+	mx28_register_gpios();
+}
-- 
1.7.1
