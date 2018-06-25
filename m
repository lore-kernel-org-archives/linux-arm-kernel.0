From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:06:13 +0200
Subject: [PATCH 02/15] ARM: shmobile: r8a7790: Use common R-Car Gen2 machine
 definition
In-Reply-To: <cover.1529934908.git.horms+renesas@verge.net.au>
References: <cover.1529934908.git.horms+renesas@verge.net.au>
Message-ID: <78a9057fcc6341bb468e7ec5ac599f06e6a75547.1529934908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Now r8a7790 no longer needs the SMP initialization fallback, it can use
the common R-Car Gen2 machine definition, and the r8a7790-specific one
can be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile          |  1 -
 arch/arm/mach-shmobile/setup-r8a7790.c   | 36 --------------------------------
 arch/arm/mach-shmobile/setup-rcar-gen2.c |  3 ++-
 3 files changed, 2 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/setup-r8a7790.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 9133949b5df2..13aca853a162 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -12,7 +12,6 @@ obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
-obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
 obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
deleted file mode 100644
index fd2435b39529..000000000000
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * r8a7790 processor support
- *
- * Copyright (C) 2013  Renesas Solutions Corp.
- * Copyright (C) 2013  Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/init.h>
-
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "rcar-gen2.h"
-
-static const char * const r8a7790_boards_compat_dt[] __initconst = {
-	"renesas,r8a7790",
-	NULL,
-};
-
-DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
-	.smp_init	= smp_init_ops(shmobile_smp_init_fallback_ops),
-	.init_early	= shmobile_init_delay,
-	.init_time	= rcar_gen2_timer_init,
-	.init_late	= shmobile_init_late,
-	.reserve	= rcar_gen2_reserve,
-	.dt_compat	= r8a7790_boards_compat_dt,
-MACHINE_END
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 88fdc1801d90..e01f21d17167 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -186,8 +186,9 @@ void __init rcar_gen2_reserve(void)
 }
 
 static const char * const rcar_gen2_boards_compat_dt[] __initconst = {
+	"renesas,r8a7790",
 	/*
-	 * R8A7790 and R8A7791 can't be handled here as long as they need SMP
+	 * R8A7791 can't be handled here as long as it needs SMP
 	 * initialization fallback.
 	 */
 	"renesas,r8a7792",
-- 
2.11.0
