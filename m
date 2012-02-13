From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Feb 2012 15:43:22 -0600
Subject: [PATCH 09/15] ARM: orion5x: clean-up mach/io.h
In-Reply-To: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
Message-ID: <1329169408-17253-10-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move orion5x specific mach/io.h parts into common.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-orion5x/common.h          |    9 +++++++++
 arch/arm/mach-orion5x/include/mach/io.h |   12 ------------
 arch/arm/mach-orion5x/pci.c             |    1 +
 arch/arm/mach-orion5x/tsx09-common.c    |    1 +
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
index d2513ac..2e6454c 100644
--- a/arch/arm/mach-orion5x/common.h
+++ b/arch/arm/mach-orion5x/common.h
@@ -57,5 +57,14 @@ struct meminfo;
 struct tag;
 extern void __init tag_fixup_mem32(struct tag *, char **, struct meminfo *);
 
+/*****************************************************************************
+ * Helpers to access Orion registers
+ ****************************************************************************/
+/*
+ * These are not preempt-safe.  Locks, if needed, must be taken
+ * care of by the caller.
+ */
+#define orion5x_setbits(r, mask)	writel(readl(r) | (mask), (r))
+#define orion5x_clrbits(r, mask)	writel(readl(r) & ~(mask), (r))
 
 #endif
diff --git a/arch/arm/mach-orion5x/include/mach/io.h b/arch/arm/mach-orion5x/include/mach/io.h
index e9d9afd..444136d 100644
--- a/arch/arm/mach-orion5x/include/mach/io.h
+++ b/arch/arm/mach-orion5x/include/mach/io.h
@@ -18,16 +18,4 @@
 #define __io(a)			__typesafe_io(a)
 #define __mem_pci(a)		(a)
 
-
-/*****************************************************************************
- * Helpers to access Orion registers
- ****************************************************************************/
-/*
- * These are not preempt-safe.  Locks, if needed, must be taken
- * care of by the caller.
- */
-#define orion5x_setbits(r, mask)	writel(readl(r) | (mask), (r))
-#define orion5x_clrbits(r, mask)	writel(readl(r) & ~(mask), (r))
-
-
 #endif
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 09a045f..a9d2151 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -19,6 +19,7 @@
 #include <asm/mach/pci.h>
 #include <plat/pcie.h>
 #include <plat/addr-map.h>
+#include <mach/orion5x.h>
 #include "common.h"
 
 /*****************************************************************************
diff --git a/arch/arm/mach-orion5x/tsx09-common.c b/arch/arm/mach-orion5x/tsx09-common.c
index c9abb8f..7189827 100644
--- a/arch/arm/mach-orion5x/tsx09-common.c
+++ b/arch/arm/mach-orion5x/tsx09-common.c
@@ -15,6 +15,7 @@
 #include <linux/mv643xx_eth.h>
 #include <linux/timex.h>
 #include <linux/serial_reg.h>
+#include <mach/orion5x.h>
 #include "tsx09-common.h"
 #include "common.h"
 
-- 
1.7.5.4
