From: andrew@lunn.ch (Andrew Lunn)
Date: Sat,  3 May 2014 20:30:16 +0200
Subject: [PATCH v2 6/9] ARM: Kirkwood: t5325: Remove platform device to
 instantiate audio
In-Reply-To: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
Message-ID: <1399141819-23924-7-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove platform device instantiating of the audio, which results in
board-t5325.c being removed. A DT node will be added to take its
place.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-mvebu/Kconfig       |  7 -------
 arch/arm/mach-mvebu/Makefile      |  1 -
 arch/arm/mach-mvebu/board-t5325.c | 26 --------------------------
 arch/arm/mach-mvebu/board.h       |  6 ------
 arch/arm/mach-mvebu/kirkwood.c    |  3 ---
 5 files changed, 43 deletions(-)
 delete mode 100644 arch/arm/mach-mvebu/board-t5325.c

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 3f73eecbcfb0..9675f559f6fe 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -97,13 +97,6 @@ config MACH_KIRKWOOD
 	  Say 'Y' here if you want your kernel to support boards based
 	  on the Marvell Kirkwood device tree.
 
-config MACH_T5325
-	bool "HP T5325 thin client"
-	depends on MACH_KIRKWOOD
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  HP T5325 Thin client
-
 endmenu
 
 endif
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index a63e43b6b451..912c0cc4cc29 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -10,4 +10,3 @@ obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
 obj-$(CONFIG_MACH_KIRKWOOD)	 += kirkwood.o kirkwood-pm.o
-obj-$(CONFIG_MACH_T5325)	 += board-t5325.o
diff --git a/arch/arm/mach-mvebu/board-t5325.c b/arch/arm/mach-mvebu/board-t5325.c
deleted file mode 100644
index f2401b298218..000000000000
--- a/arch/arm/mach-mvebu/board-t5325.c
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * HP T5325 Board Setup
- *
- * Copyright (C) 2014
- *
- * Andrew Lunn <andrew@lunn.ch>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include "board.h"
-
-static struct platform_device hp_t5325_audio_device = {
-	.name		= "t5325-audio",
-	.id		= -1,
-};
-
-void __init t5325_init(void)
-{
-	platform_device_register(&hp_t5325_audio_device);
-}
diff --git a/arch/arm/mach-mvebu/board.h b/arch/arm/mach-mvebu/board.h
index de7f0a191394..9c7bb4386f8b 100644
--- a/arch/arm/mach-mvebu/board.h
+++ b/arch/arm/mach-mvebu/board.h
@@ -13,10 +13,4 @@
 #ifndef __ARCH_MVEBU_BOARD_H
 #define __ARCH_MVEBU_BOARD_H
 
-#ifdef CONFIG_MACH_T5325
-void t5325_init(void);
-#else
-static inline void t5325_init(void) {};
-#endif
-
 #endif
diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index 120207fc36f1..c30bc316f40d 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -180,9 +180,6 @@ static void __init kirkwood_dt_init(void)
 	kirkwood_pm_init();
 	kirkwood_dt_eth_fixup();
 
-	if (of_machine_is_compatible("hp,t5325"))
-		t5325_init();
-
 	of_platform_populate(NULL, of_default_bus_match_table, auxdata, NULL);
 }
 
-- 
2.0.0.rc0
