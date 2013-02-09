From: manabian@gmail.com (Joachim Eastwood)
Date: Sat,  9 Feb 2013 16:54:28 +0100
Subject: [PATCH 2/2] ARM: at91: move at91_ramc.h and clean up includes
In-Reply-To: <1360425268-29060-1-git-send-email-manabian@gmail.com>
References: <1360425268-29060-1-git-send-email-manabian@gmail.com>
Message-ID: <1360425268-29060-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the ebi interface isn't handled by ramc, make
ramc private to mach-at91.

And while at it clean up some unnecessary ramc includes
in the RM9200 board files.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/mach-at91/at91_ramc.h              | 31 +++++++++++++++++++++++++++++
 arch/arm/mach-at91/at91sam9_alt_reset.S     |  2 +-
 arch/arm/mach-at91/at91sam9g45_reset.S      |  2 +-
 arch/arm/mach-at91/board-cpuat91.c          |  2 --
 arch/arm/mach-at91/board-kb9202.c           |  2 --
 arch/arm/mach-at91/board-picotux200.c       |  3 ---
 arch/arm/mach-at91/board-rm9200dk.c         |  2 --
 arch/arm/mach-at91/board-rm9200ek.c         |  2 --
 arch/arm/mach-at91/include/mach/at91_ramc.h | 31 -----------------------------
 arch/arm/mach-at91/pm.h                     |  2 +-
 arch/arm/mach-at91/pm_slowclock.S           |  2 +-
 11 files changed, 35 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/mach-at91/at91_ramc.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_ramc.h

diff --git a/arch/arm/mach-at91/at91_ramc.h b/arch/arm/mach-at91/at91_ramc.h
new file mode 100644
index 0000000..038041d
--- /dev/null
+++ b/arch/arm/mach-at91/at91_ramc.h
@@ -0,0 +1,31 @@
+/*
+ * Header file for the Atmel RAM Controller
+ *
+ * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * Under GPLv2 only
+ */
+
+#ifndef __AT91_RAMC_H__
+#define __AT91_RAMC_H__
+
+#ifndef __ASSEMBLY__
+extern void __iomem *at91_ramc_base[];
+
+#define at91_ramc_read(id, field) \
+	__raw_readl(at91_ramc_base[id] + field)
+
+#define at91_ramc_write(id, field, value) \
+	__raw_writel(value, at91_ramc_base[id] + field)
+#else
+.extern at91_ramc_base
+#endif
+
+#define AT91_MEMCTRL_MC		0
+#define AT91_MEMCTRL_SDRAMC	1
+#define AT91_MEMCTRL_DDRSDR	2
+
+#include <mach/at91sam9_ddrsdr.h>
+#include <mach/at91sam9_sdramc.h>
+
+#endif /* __AT91_RAMC_H__ */
diff --git a/arch/arm/mach-at91/at91sam9_alt_reset.S b/arch/arm/mach-at91/at91sam9_alt_reset.S
index f039538..7430f3c 100644
--- a/arch/arm/mach-at91/at91sam9_alt_reset.S
+++ b/arch/arm/mach-at91/at91sam9_alt_reset.S
@@ -15,7 +15,7 @@
 
 #include <linux/linkage.h>
 #include <mach/hardware.h>
-#include <mach/at91_ramc.h>
+#include "at91_ramc.h"
 #include "at91_rstc.h"
 
 			.arm
diff --git a/arch/arm/mach-at91/at91sam9g45_reset.S b/arch/arm/mach-at91/at91sam9g45_reset.S
index 721a1a3..d021154 100644
--- a/arch/arm/mach-at91/at91sam9g45_reset.S
+++ b/arch/arm/mach-at91/at91sam9g45_reset.S
@@ -12,7 +12,7 @@
 
 #include <linux/linkage.h>
 #include <mach/hardware.h>
-#include <mach/at91_ramc.h>
+#include "at91_ramc.h"
 #include "at91_rstc.h"
 			.arm
 
diff --git a/arch/arm/mach-at91/board-cpuat91.c b/arch/arm/mach-at91/board-cpuat91.c
index 42f1353..89a9ea0 100644
--- a/arch/arm/mach-at91/board-cpuat91.c
+++ b/arch/arm/mach-at91/board-cpuat91.c
@@ -36,8 +36,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/at91rm9200_mc.h>
-#include <mach/at91_ramc.h>
 #include <mach/cpu.h>
 
 #include "at91_aic.h"
diff --git a/arch/arm/mach-at91/board-kb9202.c b/arch/arm/mach-at91/board-kb9202.c
index 0c519d9..4d4ef55 100644
--- a/arch/arm/mach-at91/board-kb9202.c
+++ b/arch/arm/mach-at91/board-kb9202.c
@@ -36,8 +36,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/cpu.h>
-#include <mach/at91rm9200_mc.h>
-#include <mach/at91_ramc.h>
 
 #include "at91_aic.h"
 #include "board.h"
diff --git a/arch/arm/mach-at91/board-picotux200.c b/arch/arm/mach-at91/board-picotux200.c
index ab2b2ec..69a8bce 100644
--- a/arch/arm/mach-at91/board-picotux200.c
+++ b/arch/arm/mach-at91/board-picotux200.c
@@ -37,9 +37,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/at91rm9200_mc.h>
-#include <mach/at91_ramc.h>
-
 #include "at91_aic.h"
 #include "board.h"
 #include "generic.h"
diff --git a/arch/arm/mach-at91/board-rm9200dk.c b/arch/arm/mach-at91/board-rm9200dk.c
index 690541b..dce4c77 100644
--- a/arch/arm/mach-at91/board-rm9200dk.c
+++ b/arch/arm/mach-at91/board-rm9200dk.c
@@ -39,8 +39,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91rm9200_mc.h>
-#include <mach/at91_ramc.h>
 
 #include "at91_aic.h"
 #include "board.h"
diff --git a/arch/arm/mach-at91/board-rm9200ek.c b/arch/arm/mach-at91/board-rm9200ek.c
index 8b17dad..1369bf6 100644
--- a/arch/arm/mach-at91/board-rm9200ek.c
+++ b/arch/arm/mach-at91/board-rm9200ek.c
@@ -39,8 +39,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
-#include <mach/at91rm9200_mc.h>
-#include <mach/at91_ramc.h>
 
 #include "at91_aic.h"
 #include "board.h"
diff --git a/arch/arm/mach-at91/include/mach/at91_ramc.h b/arch/arm/mach-at91/include/mach/at91_ramc.h
deleted file mode 100644
index 038041d..0000000
--- a/arch/arm/mach-at91/include/mach/at91_ramc.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Header file for the Atmel RAM Controller
- *
- * Copyright (C) 2011 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
- *
- * Under GPLv2 only
- */
-
-#ifndef __AT91_RAMC_H__
-#define __AT91_RAMC_H__
-
-#ifndef __ASSEMBLY__
-extern void __iomem *at91_ramc_base[];
-
-#define at91_ramc_read(id, field) \
-	__raw_readl(at91_ramc_base[id] + field)
-
-#define at91_ramc_write(id, field, value) \
-	__raw_writel(value, at91_ramc_base[id] + field)
-#else
-.extern at91_ramc_base
-#endif
-
-#define AT91_MEMCTRL_MC		0
-#define AT91_MEMCTRL_SDRAMC	1
-#define AT91_MEMCTRL_DDRSDR	2
-
-#include <mach/at91sam9_ddrsdr.h>
-#include <mach/at91sam9_sdramc.h>
-
-#endif /* __AT91_RAMC_H__ */
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index c5dd8dc..8f3a4f7 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -11,7 +11,7 @@
 #ifndef __ARCH_ARM_MACH_AT91_PM
 #define __ARCH_ARM_MACH_AT91_PM
 
-#include <mach/at91_ramc.h>
+#include "at91_ramc.h"
 
 /*
  * The AT91RM9200 goes into self-refresh mode with this command, and will
diff --git a/arch/arm/mach-at91/pm_slowclock.S b/arch/arm/mach-at91/pm_slowclock.S
index 098c28d..ac49fd4 100644
--- a/arch/arm/mach-at91/pm_slowclock.S
+++ b/arch/arm/mach-at91/pm_slowclock.S
@@ -15,7 +15,7 @@
 #include <linux/linkage.h>
 #include <mach/hardware.h>
 #include <mach/at91_pmc.h>
-#include <mach/at91_ramc.h>
+#include "at91_ramc.h"
 
 
 #ifdef CONFIG_SOC_AT91SAM9263
-- 
1.8.0
