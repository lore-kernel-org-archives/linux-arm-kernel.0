From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 30 Sep 2011 13:03:24 -0300
Subject: [PATCH v2] ARM: mxs: Consolidate mm-mx23.c and mm-mx28.c into a
	single file
Message-ID: <1317398604-30144-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Consolidate mm-mx23.c and mm-mx28.c into a single file.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Rename from mm-mxs.c to mm.c

 arch/arm/mach-mxs/Makefile  |    6 ++--
 arch/arm/mach-mxs/mm-mx23.c |   44 ------------------------------
 arch/arm/mach-mxs/mm-mx28.c |   44 ------------------------------
 arch/arm/mach-mxs/mm.c  |   63 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 91 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/mm-mx23.c
 delete mode 100644 arch/arm/mach-mxs/mm-mx28.c
 create mode 100644 arch/arm/mach-mxs/mm.c

diff --git a/arch/arm/mach-mxs/Makefile b/arch/arm/mach-mxs/Makefile
index 6c38262..7474064 100644
--- a/arch/arm/mach-mxs/Makefile
+++ b/arch/arm/mach-mxs/Makefile
@@ -1,11 +1,11 @@
 # Common support
-obj-y := clock.o devices.o icoll.o iomux.o system.o timer.o
+obj-y := clock.o devices.o icoll.o iomux.o system.o timer.o mm.o
 
 obj-$(CONFIG_MXS_OCOTP) += ocotp.o
 obj-$(CONFIG_PM) += pm.o
 
-obj-$(CONFIG_SOC_IMX23) += clock-mx23.o mm-mx23.o
-obj-$(CONFIG_SOC_IMX28) += clock-mx28.o mm-mx28.o
+obj-$(CONFIG_SOC_IMX23) += clock-mx23.o
+obj-$(CONFIG_SOC_IMX28) += clock-mx28.o
 
 obj-$(CONFIG_MACH_STMP378X_DEVB) += mach-stmp378x_devb.o
 obj-$(CONFIG_MACH_MX23EVK) += mach-mx23evk.o
diff --git a/arch/arm/mach-mxs/mm-mx23.c b/arch/arm/mach-mxs/mm-mx23.c
deleted file mode 100644
index 1b2345a..0000000
--- a/arch/arm/mach-mxs/mm-mx23.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * The code contained herein is licensed under the GNU General Public
- * License.  You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- *
- * Create static mapping between physical to virtual memory.
- */
-
-#include <linux/mm.h>
-#include <linux/init.h>
-
-#include <asm/mach/map.h>
-
-#include <mach/mx23.h>
-#include <mach/common.h>
-#include <mach/iomux.h>
-
-/*
- * Define the MX23 memory map.
- */
-static struct map_desc mx23_io_desc[] __initdata = {
-	mxs_map_entry(MX23, OCRAM, MT_DEVICE),
-	mxs_map_entry(MX23, IO, MT_DEVICE),
-};
-
-/*
- * This function initializes the memory map. It is called during the
- * system startup to create static physical to virtual memory mappings
- * for the IO modules.
- */
-void __init mx23_map_io(void)
-{
-	iotable_init(mx23_io_desc, ARRAY_SIZE(mx23_io_desc));
-}
-
-void __init mx23_init_irq(void)
-{
-	icoll_init_irq();
-}
diff --git a/arch/arm/mach-mxs/mm-mx28.c b/arch/arm/mach-mxs/mm-mx28.c
deleted file mode 100644
index b6e18dd..0000000
--- a/arch/arm/mach-mxs/mm-mx28.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Copyright 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * The code contained herein is licensed under the GNU General Public
- * License.  You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- *
- * Create static mapping between physical to virtual memory.
- */
-
-#include <linux/mm.h>
-#include <linux/init.h>
-
-#include <asm/mach/map.h>
-
-#include <mach/mx28.h>
-#include <mach/common.h>
-#include <mach/iomux.h>
-
-/*
- * Define the MX28 memory map.
- */
-static struct map_desc mx28_io_desc[] __initdata = {
-	mxs_map_entry(MX28, OCRAM, MT_DEVICE),
-	mxs_map_entry(MX28, IO, MT_DEVICE),
-};
-
-/*
- * This function initializes the memory map. It is called during the
- * system startup to create static physical to virtual memory mappings
- * for the IO modules.
- */
-void __init mx28_map_io(void)
-{
-	iotable_init(mx28_io_desc, ARRAY_SIZE(mx28_io_desc));
-}
-
-void __init mx28_init_irq(void)
-{
-	icoll_init_irq();
-}
diff --git a/arch/arm/mach-mxs/mm.c b/arch/arm/mach-mxs/mm.c
new file mode 100644
index 0000000..50af5ce
--- /dev/null
+++ b/arch/arm/mach-mxs/mm.c
@@ -0,0 +1,63 @@
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
+#include <mach/mx28.h>
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
+void __init mx23_map_io(void)
+{
+	iotable_init(mx23_io_desc, ARRAY_SIZE(mx23_io_desc));
+}
+
+void __init mx23_init_irq(void)
+{
+	icoll_init_irq();
+}
+
+void __init mx28_map_io(void)
+{
+	iotable_init(mx28_io_desc, ARRAY_SIZE(mx28_io_desc));
+}
+
+void __init mx28_init_irq(void)
+{
+	icoll_init_irq();
+}
-- 
1.7.1
