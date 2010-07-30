From: ccross@google.com (Colin Cross)
Date: Thu, 29 Jul 2010 17:29:27 -0700
Subject: [PATCH 6/9] [ARM] tegra: Add support for reading fuses
In-Reply-To: <1280449771-24043-1-git-send-email-ccross@google.com>
References: <1280449771-24043-1-git-send-email-ccross@google.com>
Message-ID: <1280449771-24043-7-git-send-email-ccross@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

The Tegra SOC contains fuses to identify the CPU type and
bin, and a unique id.  The CPU info is required to determine
the correct voltages for each cpu and core frequency.

Signed-off-by: Colin Cross <ccross@android.com>
---
 arch/arm/mach-tegra/Makefile |    1 +
 arch/arm/mach-tegra/common.c |    2 +
 arch/arm/mach-tegra/fuse.c   |   84 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/fuse.h   |   24 ++++++++++++
 4 files changed, 111 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/fuse.c
 create mode 100644 arch/arm/mach-tegra/fuse.h

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 87d065e..6203475 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -5,6 +5,7 @@ obj-y                                   += clock.o
 obj-y                                   += timer.o
 obj-y                                   += gpio.o
 obj-y                                   += pinmux.o
+obj-y					+= fuse.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clock.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pinmux-t2-tables.o
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 039a514..9aedaf7 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -26,6 +26,7 @@
 
 #include "board.h"
 #include "clock.h"
+#include "fuse.h"
 
 static __initdata struct tegra_clk_init_table common_clk_init_table[] = {
 	/* name		parent		rate		enabled */
@@ -55,6 +56,7 @@ void __init tegra_init_cache(void)
 
 void __init tegra_common_init(void)
 {
+	tegra_init_fuse();
 	tegra_init_clock();
 	tegra_clk_init_from_table(common_clk_init_table);
 	tegra_init_cache();
diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
new file mode 100644
index 0000000..1fa26d9
--- /dev/null
+++ b/arch/arm/mach-tegra/fuse.c
@@ -0,0 +1,84 @@
+/*
+ * arch/arm/mach-tegra/fuse.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@android.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include <mach/iomap.h>
+
+#include "fuse.h"
+
+#define FUSE_UID_LOW		0x108
+#define FUSE_UID_HIGH		0x10c
+#define FUSE_SKU_INFO		0x110
+#define FUSE_SPARE_BIT		0x200
+
+static inline u32 fuse_readl(unsigned long offset)
+{
+	return readl(IO_TO_VIRT(TEGRA_FUSE_BASE + offset));
+}
+
+static inline void fuse_writel(u32 value, unsigned long offset)
+{
+	writel(value, IO_TO_VIRT(TEGRA_FUSE_BASE + offset));
+}
+
+void tegra_init_fuse(void)
+{
+	u32 reg = readl(IO_TO_VIRT(TEGRA_CLK_RESET_BASE + 0x48));
+	reg |= 1 << 28;
+	writel(reg, IO_TO_VIRT(TEGRA_CLK_RESET_BASE + 0x48));
+
+	pr_info("Tegra SKU: %d CPU Process: %d Core Process: %d\n",
+		tegra_sku_id(), tegra_cpu_process_id(),
+		tegra_core_process_id());
+}
+
+unsigned long long tegra_chip_uid(void)
+{
+	unsigned long long lo, hi;
+
+	lo = fuse_readl(FUSE_UID_LOW);
+	hi = fuse_readl(FUSE_UID_HIGH);
+	return (hi << 32ull) | lo;
+}
+
+int tegra_sku_id(void)
+{
+	int sku_id;
+	u32 reg = fuse_readl(FUSE_SKU_INFO);
+	sku_id = reg & 0xFF;
+	return sku_id;
+}
+
+int tegra_cpu_process_id(void)
+{
+	int cpu_process_id;
+	u32 reg = fuse_readl(FUSE_SPARE_BIT);
+	cpu_process_id = (reg >> 6) & 3;
+	return cpu_process_id;
+}
+
+int tegra_core_process_id(void)
+{
+	int core_process_id;
+	u32 reg = fuse_readl(FUSE_SPARE_BIT);
+	core_process_id = (reg >> 12) & 3;
+	return core_process_id;
+}
diff --git a/arch/arm/mach-tegra/fuse.h b/arch/arm/mach-tegra/fuse.h
new file mode 100644
index 0000000..584b2e2
--- /dev/null
+++ b/arch/arm/mach-tegra/fuse.h
@@ -0,0 +1,24 @@
+/*
+ * arch/arm/mach-tegra/fuse.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@android.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+unsigned long long tegra_chip_uid(void);
+int tegra_sku_id(void);
+int tegra_cpu_process_id(void);
+int tegra_core_process_id(void);
+void tegra_init_fuse(void);
-- 
1.7.1
