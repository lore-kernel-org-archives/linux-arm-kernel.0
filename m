From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 15 Jan 2014 21:25:49 +0900
Subject: [PATCH 01/04] ARM: shmobile: r8a7790 SYSC setup code
In-Reply-To: <20140115122539.9437.63968.sendpatchset@w520>
References: <20140115122539.9437.63968.sendpatchset@w520>
Message-ID: <20140115122549.9437.86422.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

Add r8a7790 SYSC power management support.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
[damm at opensource.se: Converted to use broken out SYSC code]
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/include/mach/r8a7790.h |    1 
 arch/arm/mach-shmobile/pm-r8a7790.c           |   45 +++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

--- 0002/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-01-15 14:21:49.000000000 +0900
@@ -53,6 +53,7 @@ obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o
 obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o pm-rcar.o
+obj-$(CONFIG_ARCH_R8A7790)	+= pm-r8a7790.o pm-rcar.o
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
--- 0001/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7790.h	2014-01-15 14:26:29.000000000 +0900
@@ -32,6 +32,7 @@ void r8a7790_add_standard_devices(void);
 void r8a7790_add_dt_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
+void r8a7790_pm_init(void);
 void r8a7790_init_early(void);
 extern struct smp_operations r8a7790_smp_ops;
 
--- /dev/null
+++ work/arch/arm/mach-shmobile/pm-r8a7790.c	2014-01-15 14:23:40.000000000 +0900
@@ -0,0 +1,45 @@
+/*
+ * r8a7790 Power management support
+ *
+ * Copyright (C) 2013  Renesas Electronics Corporation
+ * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011  Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/kernel.h>
+#include <asm/io.h>
+#include <mach/pm-rcar.h>
+#include <mach/r8a7790.h>
+
+/* SYSC */
+#define SYSCIER 0x0c
+#define SYSCIMR 0x10
+
+#if defined(CONFIG_SMP)
+
+static void __init r8a7790_sysc_init(void)
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
+static inline void r8a7790_sysc_init(void) {}
+
+#endif /* CONFIG_SMP */
+
+void __init r8a7790_pm_init(void)
+{
+	static int once;
+
+	if (!once++)
+		r8a7790_sysc_init();
+}
