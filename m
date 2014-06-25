From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 25 Jun 2014 16:35:13 +0900
Subject: [PATCH 01/14] ARM: shmobile: r8a7791 SYSC setup code
In-Reply-To: <cover.1403681315.git.horms+renesas@verge.net.au>
References: <cover.1403681315.git.horms+renesas@verge.net.au>
Message-ID: <5f6108bb9643949bf5ec0bc9f5cbde588c542c7f.1403681315.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: keita kobayashi <keita.kobayashi.ym@renesas.com>

Add r8a7791 SYSC power management support.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
[horms+renesas at verge.net.au: rebased]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile               |  1 +
 arch/arm/mach-shmobile/include/mach/r8a7791.h |  1 +
 arch/arm/mach-shmobile/pm-r8a7791.c           | 47 +++++++++++++++++++++++++++
 arch/arm/mach-shmobile/smp-r8a7791.c          |  2 ++
 4 files changed, 51 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/pm-r8a7791.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 38d5fe8..9c0ad3e 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o pm-rcar.o
 obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790.o pm-rcar.o
+obj-$(CONFIG_ARCH_R8A7791)	+= pm-r8a7791.o pm-rcar.o
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7791.h b/arch/arm/mach-shmobile/include/mach/r8a7791.h
index 664274c..86eae7b 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7791.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7791.h
@@ -5,6 +5,7 @@ void r8a7791_add_standard_devices(void);
 void r8a7791_add_dt_devices(void);
 void r8a7791_clock_init(void);
 void r8a7791_pinmux_init(void);
+void r8a7791_pm_init(void);
 extern struct smp_operations r8a7791_smp_ops;
 
 #endif /* __ASM_R8A7791_H__ */
diff --git a/arch/arm/mach-shmobile/pm-r8a7791.c b/arch/arm/mach-shmobile/pm-r8a7791.c
new file mode 100644
index 0000000..1519087
--- /dev/null
+++ b/arch/arm/mach-shmobile/pm-r8a7791.c
@@ -0,0 +1,47 @@
+/*
+ * r8a7791 Power management support
+ *
+ * Copyright (C) 2014  Renesas Electronics Corporation
+ * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011  Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <asm/io.h>
+#include <linux/kernel.h>
+#include <mach/r8a7791.h>
+#include "pm-rcar.h"
+
+/* SYSC */
+#define SYSCIER 0x0c
+#define SYSCIMR 0x10
+
+#if defined(CONFIG_SMP)
+
+static void __init r8a7791_sysc_init(void)
+{
+	void __iomem *base = rcar_sysc_init(0xe6180000);
+
+	/* enable all interrupt sources, but do not use interrupt handler */
+	iowrite32(0x0131000e, base + SYSCIER);
+	iowrite32(0, base + SYSCIMR);
+}
+
+#else /* CONFIG_SMP */
+
+static inline void r8a7791_sysc_init(void) {}
+
+#endif /* CONFIG_SMP */
+
+void __init r8a7791_pm_init(void)
+{
+	static int once;
+
+	if (once++)
+		return;
+
+	r8a7791_sysc_init();
+}
diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
index 2648d68..1772086 100644
--- a/arch/arm/mach-shmobile/smp-r8a7791.c
+++ b/arch/arm/mach-shmobile/smp-r8a7791.c
@@ -50,6 +50,8 @@ static void __init r8a7791_smp_prepare_cpus(unsigned int max_cpus)
 	writel_relaxed((readl_relaxed(p + CA15RESCNT) & ~0x0f) | 0xa5a50000,
 		       p + CA15RESCNT);
 	iounmap(p);
+
+	r8a7791_pm_init();
 }
 
 static int r8a7791_smp_boot_secondary(unsigned int cpu,
-- 
2.0.0.rc2
