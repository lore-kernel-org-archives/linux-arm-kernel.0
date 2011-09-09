From: amartin@nvidia.com (Allen Martin)
Date: Fri,  9 Sep 2011 01:02:19 -0700
Subject: [PATCH] arm/dt: Add SoC detection macros
Message-ID: <1315555339-12685-1-git-send-email-amartin@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These macros allow runtime query of SoC family and version via
soc_is_*()  If the corresponding SoC is not configured the macro will
evaluate to 0.  If the corresponding SoC is the only architecure
configured, the macro will evaluate to 1.  If multiple architecures
are configured the macro will evaluate to a runtime call to
soc_get_version().

I've added tegra2 and tegra3 SoCs as a starting point.

Signed-off-by: Allen Martin <amartin@nvidia.com>
---
 arch/arm/include/asm/soc.h |   76 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/Makefile   |    1 +
 arch/arm/kernel/setup.c    |    2 +
 arch/arm/kernel/soc.c      |   37 +++++++++++++++++++++
 4 files changed, 116 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/soc.h
 create mode 100644 arch/arm/kernel/soc.c

diff --git a/arch/arm/include/asm/soc.h b/arch/arm/include/asm/soc.h
new file mode 100644
index 0000000..d95f643
--- /dev/null
+++ b/arch/arm/include/asm/soc.h
@@ -0,0 +1,76 @@
+/*
+ * arch/arm/include/asm/soc.h
+ *
+ * Copyright (C) 2011 NVIDIA, Inc.
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
+/* determine if multiple SoCs are enabled */
+#undef MULTI_SOC
+#undef SOC_NAME
+
+#ifdef CONFIG_ARCH_TEGRA_2x_SOC
+# ifdef SOC_NAME
+#  undef MULTI_SOC
+#  define MULTI_SOC
+# else
+#   define SOC_NAME tegra2
+# endif
+#endif
+#ifdef CONFIG_ARCH_TEGRA_3x_SOC
+# ifdef SOC_NAME
+#  undef MULTI_SOC
+#  define MULTI_SOC
+# else
+#   define SOC_NAME tegra3
+# endif
+#endif
+
+#define soc_is_tegra2()			0
+#define soc_is_tegra3()			0
+
+#if defined(MULTI_SOC)
+# if defined(CONFIG_ARCH_TEGRA_2x_SOC)
+#  undef soc_is_tegra2
+#  define soc_is_tegra2()		is_tegra2()
+# endif
+# if defined(CONFIG_ARCH_TEGRA_3x_SOC)
+#  undef soc_is_tegra3
+#  define soc_is_tegra3()		is_tegra3()
+# endif
+#else /* non-multi, only one architecture is on */
+# if defined(CONFIG_ARCH_TEGRA_2x_SOC)
+#  undef soc_is_tegra2
+#  define soc_is_tegra2()		1
+# elif defined(CONFIG_ARCH_TEGRA_3x_SOC)
+#  undef soc_is_tegra3
+#  define soc_is_tegra3()		1
+# endif
+#endif
+
+enum soc_version {
+	SOC_UNKNOWN = 0,
+	TEGRA_T20,
+	TEGRA_T30,
+};
+
+void soc_init_version(void);
+enum soc_version soc_get_version(void);
+
+static inline int is_tegra2(void)
+{
+	return soc_get_version() == TEGRA_T20;
+}
+
+static inline int is_tegra3(void)
+{
+	return soc_get_version() == TEGRA_T30;
+}
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index c687bce..de29477 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
 obj-$(CONFIG_HAVE_TCM)		+= tcm.o
 obj-$(CONFIG_OF)		+= devtree.o
+obj-$(CONFIG_OF)		+= soc.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_SWP_EMULATE)	+= swp_emulate.o
 CFLAGS_swp_emulate.o		:= -Wa,-march=armv7-a
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 0ca06f7..63ad6de 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -52,6 +52,7 @@
 #include <asm/mach/time.h>
 #include <asm/traps.h>
 #include <asm/unwind.h>
+#include <asm/soc.h>
 
 #if defined(CONFIG_DEPRECATED_PARAM_STRUCT)
 #include "compat.h"
@@ -922,6 +923,7 @@ void __init setup_arch(char **cmdline_p)
 	request_standard_resources(mdesc);
 
 	unflatten_device_tree();
+	soc_init_version();
 
 #ifdef CONFIG_SMP
 	if (is_smp())
diff --git a/arch/arm/kernel/soc.c b/arch/arm/kernel/soc.c
new file mode 100644
index 0000000..8686468
--- /dev/null
+++ b/arch/arm/kernel/soc.c
@@ -0,0 +1,37 @@
+/*
+ * arch/arm/kernel/soc.c
+ *
+ * Copyright (C) 2011 NVIDIA, Inc.
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
+#include <linux/of.h>
+
+#include <asm/soc.h>
+
+static enum soc_version soc_version;
+
+enum soc_version soc_get_version(void)
+{
+	return soc_version;
+}
+
+void soc_init_version(void)
+{
+	if (of_machine_is_compatible("nvidia,tegra20"))
+		soc_version = TEGRA_T20;
+	else if (of_machine_is_compatible("nvidia,tegra30"))
+		soc_version = TEGRA_T30;
+	else
+		panic("Unknown SoC");
+}
-- 
1.7.4.1
