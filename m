From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Mar 2015 10:07:22 +0900
Subject: [PATCH 3/3] ARM: shmobile: Consolidate the pm code for R-Car Gen2
In-Reply-To: <cover.1426812951.git.horms+renesas@verge.net.au>
References: <cover.1426812951.git.horms+renesas@verge.net.au>
Message-ID: <a8caad66904a7923c05fc4a137110085533ef00c.1426812951.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

The pm code for R-Car Gen2 is scatterd in each SoC. These files
(pm-r8a7790.c/pm-r8a7791.c) have some overlap code. This change
consolidate the pm code for R-Car Gen2 into one.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile       |   5 +-
 arch/arm/mach-shmobile/pm-r8a7790.c   |  82 ------------------------
 arch/arm/mach-shmobile/pm-r8a7791.c   |  73 ---------------------
 arch/arm/mach-shmobile/pm-rcar-gen2.c | 115 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/r8a7790.h      |   1 -
 arch/arm/mach-shmobile/r8a7791.h      |   1 -
 arch/arm/mach-shmobile/rcar-gen2.h    |   1 +
 arch/arm/mach-shmobile/smp-r8a7790.c  |   3 +-
 arch/arm/mach-shmobile/smp-r8a7791.c  |   2 +-
 9 files changed, 122 insertions(+), 161 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/pm-r8a7790.c
 delete mode 100644 arch/arm/mach-shmobile/pm-r8a7791.c
 create mode 100644 arch/arm/mach-shmobile/pm-rcar-gen2.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index d53996e..0ae702b 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -12,8 +12,8 @@ obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o pm-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
-obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o pm-r8a7790.o
-obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o pm-r8a7791.o
+obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
+obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
 obj-$(CONFIG_ARCH_R8A7794)	+= setup-r8a7794.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
@@ -50,6 +50,7 @@ obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 obj-$(CONFIG_PM_RCAR)		+= pm-rcar.o
 obj-$(CONFIG_PM_RMOBILE)	+= pm-rmobile.o
+obj-$(CONFIG_ARCH_RCAR_GEN2)	+= pm-rcar-gen2.o
 
 # special sh7372 handling for IRQ objects and low level sleep code
 obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o sleep-sh7372.o
diff --git a/arch/arm/mach-shmobile/pm-r8a7790.c b/arch/arm/mach-shmobile/pm-r8a7790.c
deleted file mode 100644
index 23b61f1..0000000
--- a/arch/arm/mach-shmobile/pm-r8a7790.c
+++ /dev/null
@@ -1,82 +0,0 @@
-/*
- * r8a7790 Power management support
- *
- * Copyright (C) 2013  Renesas Electronics Corporation
- * Copyright (C) 2011  Renesas Solutions Corp.
- * Copyright (C) 2011  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/smp.h>
-#include <asm/io.h>
-#include "common.h"
-#include "pm-rcar.h"
-#include "r8a7790.h"
-
-/* RST */
-#define RST		0xe6160000
-#define CA15BAR		0x0020
-#define CA7BAR		0x0030
-#define CA15RESCNT	0x0040
-#define CA7RESCNT	0x0044
-
-/* On-chip RAM */
-#define MERAM          0xe8080000
-
-/* SYSC */
-#define SYSCIER 0x0c
-#define SYSCIMR 0x10
-
-#if defined(CONFIG_SMP)
-
-static void __init r8a7790_sysc_init(void)
-{
-	void __iomem *base = rcar_sysc_init(0xe6180000);
-
-	/* enable all interrupt sources, but do not use interrupt handler */
-	iowrite32(0x013111ef, base + SYSCIER);
-	iowrite32(0, base + SYSCIMR);
-}
-
-#else /* CONFIG_SMP */
-
-static inline void r8a7790_sysc_init(void) {}
-
-#endif /* CONFIG_SMP */
-
-void __init r8a7790_pm_init(void)
-{
-	void __iomem *p;
-	u32 bar;
-	static int once;
-
-	if (once++)
-		return;
-
-	/* MERAM for jump stub, because BAR requires 256KB aligned address */
-	p = ioremap_nocache(MERAM, shmobile_boot_size);
-	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
-	iounmap(p);
-
-	/* setup reset vectors */
-	p = ioremap_nocache(RST, 0x63);
-	bar = (MERAM >> 8) & 0xfffffc00;
-	writel_relaxed(bar, p + CA15BAR);
-	writel_relaxed(bar, p + CA7BAR);
-	writel_relaxed(bar | 0x10, p + CA15BAR);
-	writel_relaxed(bar | 0x10, p + CA7BAR);
-
-	/* de-assert reset for all CPUs */
-	writel_relaxed((readl_relaxed(p + CA15RESCNT) & ~0x0f) | 0xa5a50000,
-		       p + CA15RESCNT);
-	writel_relaxed((readl_relaxed(p + CA7RESCNT) & ~0x0f) | 0x5a5a0000,
-		       p + CA7RESCNT);
-	iounmap(p);
-
-	r8a7790_sysc_init();
-	shmobile_smp_apmu_suspend_init();
-}
diff --git a/arch/arm/mach-shmobile/pm-r8a7791.c b/arch/arm/mach-shmobile/pm-r8a7791.c
deleted file mode 100644
index f7cfb3b..0000000
--- a/arch/arm/mach-shmobile/pm-r8a7791.c
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- * r8a7791 Power management support
- *
- * Copyright (C) 2014  Renesas Electronics Corporation
- * Copyright (C) 2011  Renesas Solutions Corp.
- * Copyright (C) 2011  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/smp.h>
-#include <asm/io.h>
-#include "common.h"
-#include "pm-rcar.h"
-#include "r8a7791.h"
-
-#define RST		0xe6160000
-#define CA15BAR		0x0020
-#define CA15RESCNT	0x0040
-#define RAM		0xe6300000
-
-/* SYSC */
-#define SYSCIER 0x0c
-#define SYSCIMR 0x10
-
-#if defined(CONFIG_SMP)
-
-static void __init r8a7791_sysc_init(void)
-{
-	void __iomem *base = rcar_sysc_init(0xe6180000);
-
-	/* enable all interrupt sources, but do not use interrupt handler */
-	iowrite32(0x00111003, base + SYSCIER);
-	iowrite32(0, base + SYSCIMR);
-}
-
-#else /* CONFIG_SMP */
-
-static inline void r8a7791_sysc_init(void) {}
-
-#endif /* CONFIG_SMP */
-
-void __init r8a7791_pm_init(void)
-{
-	void __iomem *p;
-	u32 bar;
-	static int once;
-
-	if (once++)
-		return;
-
-	/* RAM for jump stub, because BAR requires 256KB aligned address */
-	p = ioremap_nocache(RAM, shmobile_boot_size);
-	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
-	iounmap(p);
-
-	/* setup reset vectors */
-	p = ioremap_nocache(RST, 0x63);
-	bar = (RAM >> 8) & 0xfffffc00;
-	writel_relaxed(bar, p + CA15BAR);
-	writel_relaxed(bar | 0x10, p + CA15BAR);
-
-	/* enable clocks to all CPUs */
-	writel_relaxed((readl_relaxed(p + CA15RESCNT) & ~0x0f) | 0xa5a50000,
-		       p + CA15RESCNT);
-	iounmap(p);
-
-	r8a7791_sysc_init();
-	shmobile_smp_apmu_suspend_init();
-}
diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
new file mode 100644
index 0000000..6815781
--- /dev/null
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -0,0 +1,115 @@
+/*
+ * R-Car Generation 2 Power management support
+ *
+ * Copyright (C) 2013 - 2015  Renesas Electronics Corporation
+ * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011  Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/smp.h>
+#include <asm/io.h>
+#include "common.h"
+#include "pm-rcar.h"
+#include "rcar-gen2.h"
+
+/* RST */
+#define RST		0xe6160000
+#define CA15BAR		0x0020
+#define CA7BAR		0x0030
+#define CA15RESCNT	0x0040
+#define CA7RESCNT	0x0044
+
+/* On-chip RAM */
+#define MERAM		0xe8080000
+#define RAM		0xe6300000
+
+/* SYSC */
+#define SYSCIER 0x0c
+#define SYSCIMR 0x10
+
+#if defined(CONFIG_SMP)
+
+static void __init rcar_gen2_sysc_init(u32 syscier)
+{
+	void __iomem *base = rcar_sysc_init(0xe6180000);
+
+	/* enable all interrupt sources, but do not use interrupt handler */
+	iowrite32(syscier, base + SYSCIER);
+	iowrite32(0, base + SYSCIMR);
+}
+
+#else /* CONFIG_SMP */
+
+static inline void rcar_gen2_sysc_init(u32 syscier) {}
+
+#endif /* CONFIG_SMP */
+
+void __init rcar_gen2_pm_init(void)
+{
+	void __iomem *p;
+	u32 bar;
+	static int once;
+	struct device_node *np, *cpus;
+	bool has_a7 = false;
+	bool has_a15 = false;
+	phys_addr_t boot_vector_addr = 0;
+	u32 syscier = 0;
+
+	if (once++)
+		return;
+
+	cpus = of_find_node_by_path("/cpus");
+	if (!cpus)
+		return;
+
+	for_each_child_of_node(cpus, np) {
+		if (of_device_is_compatible(np, "arm,cortex-a15"))
+			has_a15 = true;
+		else if (of_device_is_compatible(np, "arm,cortex-a7"))
+			has_a7 = true;
+	}
+
+	if (of_machine_is_compatible("renesas,r8a7790")) {
+		boot_vector_addr = MERAM;
+		syscier = 0x013111ef;
+
+	} else if (of_machine_is_compatible("renesas,r8a7791")) {
+		boot_vector_addr = RAM;
+		syscier = 0x00111003;
+	}
+
+	/* RAM for jump stub, because BAR requires 256KB aligned address */
+	p = ioremap_nocache(boot_vector_addr, shmobile_boot_size);
+	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
+	iounmap(p);
+
+	/* setup reset vectors */
+	p = ioremap_nocache(RST, 0x63);
+	bar = (boot_vector_addr >> 8) & 0xfffffc00;
+	if (has_a15) {
+		writel_relaxed(bar, p + CA15BAR);
+		writel_relaxed(bar | 0x10, p + CA15BAR);
+
+		/* de-assert reset for CA15 CPUs */
+		writel_relaxed((readl_relaxed(p + CA15RESCNT) & ~0x0f) |
+				0xa5a50000, p + CA15RESCNT);
+	}
+	if (has_a7) {
+		writel_relaxed(bar, p + CA7BAR);
+		writel_relaxed(bar | 0x10, p + CA7BAR);
+
+		/* de-assert reset for CA7 CPUs */
+		writel_relaxed((readl_relaxed(p + CA7RESCNT) & ~0x0f) |
+				0x5a5a0000, p + CA7RESCNT);
+	}
+	iounmap(p);
+
+	rcar_gen2_sysc_init(syscier);
+	shmobile_smp_apmu_suspend_init();
+}
diff --git a/arch/arm/mach-shmobile/r8a7790.h b/arch/arm/mach-shmobile/r8a7790.h
index bf73a85..1a46d02 100644
--- a/arch/arm/mach-shmobile/r8a7790.h
+++ b/arch/arm/mach-shmobile/r8a7790.h
@@ -1,7 +1,6 @@
 #ifndef __ASM_R8A7790_H__
 #define __ASM_R8A7790_H__
 
-void r8a7790_pm_init(void);
 extern struct smp_operations r8a7790_smp_ops;
 
 #endif /* __ASM_R8A7790_H__ */
diff --git a/arch/arm/mach-shmobile/r8a7791.h b/arch/arm/mach-shmobile/r8a7791.h
index 6cf11eb..7ca0b7d 100644
--- a/arch/arm/mach-shmobile/r8a7791.h
+++ b/arch/arm/mach-shmobile/r8a7791.h
@@ -1,7 +1,6 @@
 #ifndef __ASM_R8A7791_H__
 #define __ASM_R8A7791_H__
 
-void r8a7791_pm_init(void);
 extern struct smp_operations r8a7791_smp_ops;
 
 #endif /* __ASM_R8A7791_H__ */
diff --git a/arch/arm/mach-shmobile/rcar-gen2.h b/arch/arm/mach-shmobile/rcar-gen2.h
index ce53cb5..8a66b4a 100644
--- a/arch/arm/mach-shmobile/rcar-gen2.h
+++ b/arch/arm/mach-shmobile/rcar-gen2.h
@@ -5,5 +5,6 @@ void rcar_gen2_timer_init(void);
 #define MD(nr) BIT(nr)
 u32 rcar_gen2_read_mode_pins(void);
 void rcar_gen2_reserve(void);
+void rcar_gen2_pm_init(void);
 
 #endif /* __ASM_RCAR_GEN2_H__ */
diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index 9c3da13..f8be415 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -23,6 +23,7 @@
 #include "common.h"
 #include "platsmp-apmu.h"
 #include "pm-rcar.h"
+#include "rcar-gen2.h"
 #include "r8a7790.h"
 
 static struct rcar_sysc_ch r8a7790_ca15_scu = {
@@ -54,7 +55,7 @@ static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
 				       ARRAY_SIZE(r8a7790_apmu_config));
 
 	/* turn on power to SCU */
-	r8a7790_pm_init();
+	rcar_gen2_pm_init();
 	rcar_sysc_power_up(&r8a7790_ca15_scu);
 	rcar_sysc_power_up(&r8a7790_ca7_scu);
 }
diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
index 7e49e0a..6658682 100644
--- a/arch/arm/mach-shmobile/smp-r8a7791.c
+++ b/arch/arm/mach-shmobile/smp-r8a7791.c
@@ -39,7 +39,7 @@ static void __init r8a7791_smp_prepare_cpus(unsigned int max_cpus)
 				       r8a7791_apmu_config,
 				       ARRAY_SIZE(r8a7791_apmu_config));
 
-	r8a7791_pm_init();
+	rcar_gen2_pm_init();
 }
 
 static int r8a7791_smp_boot_secondary(unsigned int cpu,
-- 
2.1.4
