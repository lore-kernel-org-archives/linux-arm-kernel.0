From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:06:24 +0200
Subject: [PATCH 13/15] ARM: shmobile: r8a7779: Remove explicit SYSC config and
 init
In-Reply-To: <cover.1529934908.git.horms+renesas@verge.net.au>
References: <cover.1529934908.git.horms+renesas@verge.net.au>
Message-ID: <16acd53b1547d3dbe3eabef5e3356674eb957ae4.1529934908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

If the R-Car H1 system controller is described in DT, the rcar-sysc
driver configures SYSCIER and SYSCIMR based on the SoC-specific power
area definitions in r8a7779-sysc.  The platform code still passed this
information to the rcar-sysc driver, for compatibility with old DTBs
predating commit b2df3aa487395a1b ("ARM: dts: r8a7779: Add SYSC PM
Domains") in v4.7.  The time has come to drop backwards compatibility,
and delegate everything to the DT enabled rcar-sysc driver.

After stopping powering down secondary CPUs during early boot, there is
no longer a need to force an early initialization of the rcar-sysc
driver.  It will be initialized in time for secondary CPU bringup by its
early_initcall().

Hence all explicit SYSC configuration and initialization can be removed
from the R-Car H1 platform code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile      |  2 +-
 arch/arm/mach-shmobile/pm-r8a7779.c  | 41 ------------------------------------
 arch/arm/mach-shmobile/r8a7779.h     |  2 --
 arch/arm/mach-shmobile/smp-r8a7779.c |  2 --
 4 files changed, 1 insertion(+), 46 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/pm-r8a7779.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 2b8d3896e1eb..05ba728ed4f6 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o
 obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
-obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
+obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
 
diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
deleted file mode 100644
index 5c9a93f5e650..000000000000
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * r8a7779 Power management support
- *
- * Copyright (C) 2011  Renesas Solutions Corp.
- * Copyright (C) 2011  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/soc/renesas/rcar-sysc.h>
-
-#include <asm/io.h>
-
-#include "r8a7779.h"
-
-/* SYSC */
-#define SYSCIER 0x0c
-#define SYSCIMR 0x10
-
-#if defined(CONFIG_PM) || defined(CONFIG_SMP)
-
-static void __init r8a7779_sysc_init(void)
-{
-	rcar_sysc_init(0xffd85000, 0x0131000e);
-}
-
-#else /* CONFIG_PM || CONFIG_SMP */
-
-static inline void r8a7779_sysc_init(void) {}
-
-#endif /* CONFIG_PM || CONFIG_SMP */
-
-void __init r8a7779_pm_init(void)
-{
-	static int once;
-
-	if (!once++)
-		r8a7779_sysc_init();
-}
diff --git a/arch/arm/mach-shmobile/r8a7779.h b/arch/arm/mach-shmobile/r8a7779.h
index 30668aa6acc3..ca9db8fde2f7 100644
--- a/arch/arm/mach-shmobile/r8a7779.h
+++ b/arch/arm/mach-shmobile/r8a7779.h
@@ -2,8 +2,6 @@
 #ifndef __ASM_R8A7779_H__
 #define __ASM_R8A7779_H__
 
-extern void r8a7779_pm_init(void);
-
 extern const struct smp_operations r8a7779_smp_ops;
 
 #endif /* __ASM_R8A7779_H__ */
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 3036f9100461..0d3ec5c2b8fc 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -60,8 +60,6 @@ static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
 
 	/* setup r8a7779 specific SCU bits */
 	shmobile_smp_scu_prepare_cpus(R8A7779_SCU_BASE, max_cpus);
-
-	r8a7779_pm_init();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.11.0
