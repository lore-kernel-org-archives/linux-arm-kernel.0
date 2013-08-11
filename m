From: jm@lentin.co.uk (Jamie Lentin)
Date: Sun, 11 Aug 2013 15:26:50 +0100
Subject: [PATCH 2/2] Remove all remaining trace of DNS-320/325 platform code
In-Reply-To: <1376231210-6484-1-git-send-email-jm@lentin.co.uk>
References: <1376231210-6484-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1376231210-6484-3-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No platform code left now, so remove all references to it.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/configs/kirkwood_defconfig  |  1 -
 arch/arm/mach-kirkwood/Kconfig       |  8 --------
 arch/arm/mach-kirkwood/Makefile      |  1 -
 arch/arm/mach-kirkwood/board-dnskw.c | 21 ---------------------
 arch/arm/mach-kirkwood/board-dt.c    |  3 ---
 arch/arm/mach-kirkwood/common.h      |  6 ------
 6 files changed, 40 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/board-dnskw.c

diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 19e0f2f..71bb429 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -29,7 +29,6 @@ CONFIG_MACH_SHEEVAPLUG=y
 CONFIG_MACH_T5325=y
 CONFIG_MACH_TS219=y
 CONFIG_MACH_TS41X=y
-CONFIG_MACH_DLINK_KIRKWOOD_DT=y
 # CONFIG_CPU_FEROCEON_OLD_ID is not set
 CONFIG_PCI_MVEBU=y
 CONFIG_PREEMPT=y
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index 780bca0..94540d5 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -105,14 +105,6 @@ config ARCH_KIRKWOOD_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Kirkwood using flattened device tree.
 
-config MACH_DLINK_KIRKWOOD_DT
-	bool "D-Link Kirkwood-based NAS (Flattened Device Tree)"
-	select ARCH_KIRKWOOD_DT
-	help
-	  Say 'Y' here if you want your kernel to support the
-	  Kirkwood-based D-Link NASes such as DNS-320 & DNS-325,
-	  using Flattened Device Tree.
-
 config MACH_MV88F6281GTW_GE_DT
 	bool "Marvell 88F6281 GTW GE Board (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 937d4e1..d1f8e3d 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -11,5 +11,4 @@ obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
 
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
-obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
 obj-$(CONFIG_MACH_MV88F6281GTW_GE_DT)	+= board-mv88f6281gtw_ge.o
diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
deleted file mode 100644
index 0b441b9..0000000
--- a/arch/arm/mach-kirkwood/board-dnskw.c
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Copyright 2012 (C), Jamie Lentin <jm@lentin.co.uk>
- *
- * arch/arm/mach-kirkwood/board-dnskw.c
- *
- * D-link DNS-320 & DNS-325 NAS Init for drivers not converted to
- * flattened device tree yet.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include "common.h"
-
-void __init dnskw_init(void)
-{
-}
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 713be4f..82d3ad8 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -107,9 +107,6 @@ static void __init kirkwood_dt_init(void)
 	kexec_reinit = kirkwood_enable_pcie;
 #endif
 
-	if (of_machine_is_compatible("dlink,dns-kirkwood"))
-		dnskw_init();
-
 	if (of_machine_is_compatible("marvell,mv88f6281gtw-ge"))
 		mv88f6281gtw_ge_init();
 
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index cc639bb..1296de9 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -59,12 +59,6 @@ void kirkwood_restart(enum reboot_mode, const char *);
 void kirkwood_clk_init(void);
 
 /* board init functions for boards not fully converted to fdt */
-#ifdef CONFIG_MACH_DLINK_KIRKWOOD_DT
-void dnskw_init(void);
-#else
-static inline void dnskw_init(void) {};
-#endif
-
 #ifdef CONFIG_MACH_MV88F6281GTW_GE_DT
 void mv88f6281gtw_ge_init(void);
 #else
-- 
1.8.3.1
