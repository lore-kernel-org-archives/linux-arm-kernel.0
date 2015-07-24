From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:41:58 +0900
Subject: [PATCH 1/2] ARM: shmobile: Basic r8a7793 SoC support
In-Reply-To: <cover.1437725057.git.horms+renesas@verge.net.au>
References: <cover.1437725057.git.horms+renesas@verge.net.au>
Message-ID: <ec60d95b4faccd61c7ce10316ebc9333f2d7674a.1437725057.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Minimal support without power management or SMP.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig         |  4 ++++
 arch/arm/mach-shmobile/Makefile        |  1 +
 arch/arm/mach-shmobile/setup-r8a7793.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7793.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 45006479d461..c59d75eff7a4 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -80,6 +80,10 @@ config ARCH_R8A7791
 	select ARCH_RCAR_GEN2
 	select I2C
 
+config ARCH_R8A7793
+	bool "R-Car M2-N (R8A7793)"
+	select ARCH_RCAR_GEN2
+
 config ARCH_R8A7794
 	bool "R-Car E2 (R8A77940)"
 	select ARCH_RCAR_GEN2
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 89e463de4479..e4b8fdbf6c96 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
 obj-$(CONFIG_ARCH_R8A7791)	+= setup-r8a7791.o
+obj-$(CONFIG_ARCH_R8A7793)	+= setup-r8a7793.o
 obj-$(CONFIG_ARCH_R8A7794)	+= setup-r8a7794.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)	+= setup-r7s72100.o
diff --git a/arch/arm/mach-shmobile/setup-r8a7793.c b/arch/arm/mach-shmobile/setup-r8a7793.c
new file mode 100644
index 000000000000..1d2825cb7a65
--- /dev/null
+++ b/arch/arm/mach-shmobile/setup-r8a7793.c
@@ -0,0 +1,33 @@
+/*
+ * r8a7793 processor support
+ *
+ * Copyright (C) 2015  Ulrich Hecht
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/init.h>
+#include <asm/mach/arch.h>
+
+#include "common.h"
+#include "rcar-gen2.h"
+
+static const char *r8a7793_boards_compat_dt[] __initconst = {
+	"renesas,r8a7793",
+	NULL,
+};
+
+DT_MACHINE_START(R8A7793_DT, "Generic R8A7793 (Flattened Device Tree)")
+	.init_early	= shmobile_init_delay,
+	.init_time	= rcar_gen2_timer_init,
+	.init_late	= shmobile_init_late,
+	.reserve	= rcar_gen2_reserve,
+	.dt_compat	= r8a7793_boards_compat_dt,
+MACHINE_END
-- 
2.1.4
