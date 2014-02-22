From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 22 Feb 2014 20:14:43 +0100
Subject: [PATCH v4 01/22] ARM: Kirkwood: Give pm.c its own header file.
In-Reply-To: <1393096504-11844-1-git-send-email-andrew@lunn.ch>
References: <1393096504-11844-1-git-send-email-andrew@lunn.ch>
Message-ID: <1393096504-11844-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pm code needs to be separated from common.h in order to split DT
and non-DT systems apart. Move the declarations into a header file of
its own and include it where needed.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com> (on kirkwood)
---
v3:
s/seperated/separated
---
 arch/arm/mach-kirkwood/board-dt.c |  1 +
 arch/arm/mach-kirkwood/common.c   |  1 +
 arch/arm/mach-kirkwood/common.h   |  6 ------
 arch/arm/mach-kirkwood/pm.h       | 26 ++++++++++++++++++++++++++
 4 files changed, 28 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-kirkwood/pm.h

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 78188159484d..ceffdc8ffbbd 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -24,6 +24,7 @@
 #include <mach/bridge-regs.h>
 #include <plat/common.h>
 #include "common.h"
+#include "pm.h"
 
 #define MV643XX_ETH_MAC_ADDR_LOW	0x0414
 #define MV643XX_ETH_MAC_ADDR_HIGH	0x0418
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index f3407a5db216..52aca25432a7 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -36,6 +36,7 @@
 #include <plat/time.h>
 #include <linux/platform_data/dma-mv_xor.h>
 #include "common.h"
+#include "pm.h"
 
 /* These can go away once Kirkwood uses the mvebu-mbus DT binding */
 #define KIRKWOOD_MBUS_NAND_TARGET 0x01
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 05fd648df543..1296de94febf 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -58,12 +58,6 @@ void kirkwood_cpufreq_init(void);
 void kirkwood_restart(enum reboot_mode, const char *);
 void kirkwood_clk_init(void);
 
-#ifdef CONFIG_PM
-void kirkwood_pm_init(void);
-#else
-static inline void kirkwood_pm_init(void) {};
-#endif
-
 /* board init functions for boards not fully converted to fdt */
 #ifdef CONFIG_MACH_MV88F6281GTW_GE_DT
 void mv88f6281gtw_ge_init(void);
diff --git a/arch/arm/mach-kirkwood/pm.h b/arch/arm/mach-kirkwood/pm.h
new file mode 100644
index 000000000000..21e7530f368b
--- /dev/null
+++ b/arch/arm/mach-kirkwood/pm.h
@@ -0,0 +1,26 @@
+/*
+ * Power Management driver for Marvell Kirkwood SoCs
+ *
+ * Copyright (C) 2013 Ezequiel Garcia <ezequiel@free-electrons.com>
+ * Copyright (C) 2010 Simon Guinot <sguinot@lacie.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License,
+ * version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ARCH_KIRKWOOD_PM_H
+#define __ARCH_KIRKWOOD_PM_H
+
+#ifdef CONFIG_PM
+void kirkwood_pm_init(void);
+#else
+static inline void kirkwood_pm_init(void) {};
+#endif
+
+#endif
-- 
1.8.5.3
