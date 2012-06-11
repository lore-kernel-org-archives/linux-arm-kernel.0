From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 11 Jun 2012 18:52:59 +0200
Subject: [PATCH v2 2/8] arm: mach-mvebu: add source files
In-Reply-To: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1339433585-28087-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 arch/arm/mach-mvebu/Kconfig       |    7 +++++++
 arch/arm/mach-mvebu/Makefile      |    1 +
 arch/arm/mach-mvebu/Makefile.boot |    1 +
 arch/arm/mach-mvebu/common.c      |   36 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/common.h      |   20 ++++++++++++++++++++
 5 files changed, 65 insertions(+)
 create mode 100644 arch/arm/mach-mvebu/Kconfig
 create mode 100644 arch/arm/mach-mvebu/Makefile
 create mode 100644 arch/arm/mach-mvebu/Makefile.boot
 create mode 100644 arch/arm/mach-mvebu/common.c
 create mode 100644 arch/arm/mach-mvebu/common.h

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
new file mode 100644
index 0000000..72d39e5
--- /dev/null
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -0,0 +1,7 @@
+if ARCH_MVEBU
+
+menu "Marvell SOC with device tree"
+
+endmenu
+
+endif
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
new file mode 100644
index 0000000..f95691b
--- /dev/null
+++ b/arch/arm/mach-mvebu/Makefile
@@ -0,0 +1 @@
+obj-y += common.o
diff --git a/arch/arm/mach-mvebu/Makefile.boot b/arch/arm/mach-mvebu/Makefile.boot
new file mode 100644
index 0000000..b327175
--- /dev/null
+++ b/arch/arm/mach-mvebu/Makefile.boot
@@ -0,0 +1 @@
+zreladdr-y := 0x00008000
diff --git a/arch/arm/mach-mvebu/common.c b/arch/arm/mach-mvebu/common.c
new file mode 100644
index 0000000..b48cecd
--- /dev/null
+++ b/arch/arm/mach-mvebu/common.c
@@ -0,0 +1,36 @@
+/*
+ * Core functions for Marvell System On Chip
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <asm/page.h>
+#include <asm/setup.h>
+#include <asm/mach/map.h>
+#include <mach/mvebu.h>
+#include "common.h"
+
+static struct map_desc mvebu_io_desc[] __initdata = {
+	{
+		.virtual	= MVEBU_REGS_VIRT_BASE,
+		.pfn		= __phys_to_pfn(MVEBU_REGS_PHYS_BASE),
+		.length		= MVEBU_REGS_SIZE,
+		.type		= MT_DEVICE,
+	},
+};
+
+void __init mvebu_map_io(void)
+{
+	iotable_init(mvebu_io_desc, ARRAY_SIZE(mvebu_io_desc));
+}
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
new file mode 100644
index 0000000..7bf0879
--- /dev/null
+++ b/arch/arm/mach-mvebu/common.h
@@ -0,0 +1,20 @@
+/*
+ * Core functions for Marvell Armada System On Chip
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ARCH_ARMADA_COMMON_H
+#define __ARCH_ARMADA_COMMON_H
+
+void mvebu_map_io(void);
+
+#endif
-- 
1.7.9.5
