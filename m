From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 11:20:07 +0100
Subject: [PATCH v2 09/23] ARM: Orion: Move cache-feroceon-l2.h out of
 plat-orion
In-Reply-To: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392459621-24003-10-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the gradual move to DT, kirkwood has become a lot less dependent
on plat-orion. cache-feroceon-l2.h is the last dependency. Move it out
so we can drop plat-orion when building DT only kirkwood boards.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/include/asm/hardware/cache-feroceon-l2.h    | 11 +++++++++++
 arch/arm/mach-kirkwood/board-dt.c                    |  2 +-
 arch/arm/mach-kirkwood/common.c                      |  2 +-
 arch/arm/mach-mv78xx0/common.c                       |  2 +-
 arch/arm/mm/cache-feroceon-l2.c                      |  2 +-
 arch/arm/plat-orion/include/plat/cache-feroceon-l2.h | 11 -----------
 6 files changed, 15 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/include/asm/hardware/cache-feroceon-l2.h
 delete mode 100644 arch/arm/plat-orion/include/plat/cache-feroceon-l2.h

diff --git a/arch/arm/include/asm/hardware/cache-feroceon-l2.h b/arch/arm/include/asm/hardware/cache-feroceon-l2.h
new file mode 100644
index 000000000000..8edd330aabf6
--- /dev/null
+++ b/arch/arm/include/asm/hardware/cache-feroceon-l2.h
@@ -0,0 +1,11 @@
+/*
+ * arch/arm/include/asm/hardware/cache-feroceon-l2.h
+ *
+ * Copyright (C) 2008 Marvell Semiconductor
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+extern void __init feroceon_l2_init(int l2_wt_override);
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 91b61a971af2..34c35510fd17 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -20,11 +20,11 @@
 #include <linux/dma-mapping.h>
 #include <linux/irqchip.h>
 #include <linux/kexec.h>
+#include <asm/hardware/cache-feroceon-l2.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/bridge-regs.h>
 #include <plat/common.h>
-#include <plat/cache-feroceon-l2.h>
 #include <plat/pcie.h>
 #include "pm.h"
 
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 52aca25432a7..255f33a3903c 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -25,10 +25,10 @@
 #include <asm/page.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
+#include <asm/hardware/cache-feroceon-l2.h>
 #include <mach/kirkwood.h>
 #include <mach/bridge-regs.h>
 #include <linux/platform_data/asoc-kirkwood.h>
-#include <plat/cache-feroceon-l2.h>
 #include <linux/platform_data/mmc-mvsdio.h>
 #include <linux/platform_data/mtd-orion_nand.h>
 #include <linux/platform_data/usb-ehci-orion.h>
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index 75062eff2494..e6ac679bece9 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -15,11 +15,11 @@
 #include <linux/ata_platform.h>
 #include <linux/clk-provider.h>
 #include <linux/ethtool.h>
+#include <asm/hardware/cache-feroceon-l2.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <mach/mv78xx0.h>
 #include <mach/bridge-regs.h>
-#include <plat/cache-feroceon-l2.h>
 #include <linux/platform_data/usb-ehci-orion.h>
 #include <linux/platform_data/mtd-orion_nand.h>
 #include <plat/time.h>
diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
index 48bc3c0a87ce..898362e7972b 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -16,7 +16,7 @@
 #include <linux/highmem.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
-#include <plat/cache-feroceon-l2.h>
+#include <asm/hardware/cache-feroceon-l2.h>
 
 /*
  * Low-level cache maintenance operations.
diff --git a/arch/arm/plat-orion/include/plat/cache-feroceon-l2.h b/arch/arm/plat-orion/include/plat/cache-feroceon-l2.h
deleted file mode 100644
index 06f982d55697..000000000000
--- a/arch/arm/plat-orion/include/plat/cache-feroceon-l2.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * arch/arm/plat-orion/include/plat/cache-feroceon-l2.h
- *
- * Copyright (C) 2008 Marvell Semiconductor
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-extern void __init feroceon_l2_init(int l2_wt_override);
-- 
1.8.5.3
