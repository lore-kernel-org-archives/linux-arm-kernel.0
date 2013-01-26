From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 26 Jan 2013 20:50:20 +0000
Subject: [PATCH V4 11/11] ARM: Kirkwood: Convert QNAP TS219 Ethernet to DT.
In-Reply-To: <cover.1359232975.git.jason@lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359232975.git.jason@lakedaemon.net>
Message-ID: <f2d2ca7fbc759b412b30f1e7b9c7059ab5a7f00f.1359232975.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

Add DT nodes for the Ethernet ports and remove the C code. The PHY
addresses depends on which SoC is used, so place the nodes into the
SoC specific DTS files.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/kirkwood-ts219-6281.dts |  9 ++++++++
 arch/arm/boot/dts/kirkwood-ts219-6282.dts | 10 +++++++++
 arch/arm/mach-kirkwood/Kconfig            | 17 ++------------
 arch/arm/mach-kirkwood/Makefile           |  1 -
 arch/arm/mach-kirkwood/board-dt.c         |  3 ---
 arch/arm/mach-kirkwood/board-ts219.c      | 37 -------------------------------
 arch/arm/mach-kirkwood/common.h           |  6 -----
 7 files changed, 21 insertions(+), 62 deletions(-)
 delete mode 100644 arch/arm/mach-kirkwood/board-ts219.c

diff --git a/arch/arm/boot/dts/kirkwood-ts219-6281.dts b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
index 8295c83..00b2c7f 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6281.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
@@ -32,6 +32,15 @@
 				marvell,function = "gpio";
 			};
 		};
+
+		smi0: mdio at 72000 {
+			status = "ok";
+		};
+
+		egiga0 {
+			phy_addr = <0x88>;
+			status = "ok";
+		};
 	};
 
 	gpio_keys {
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
index df3f95d..61d69f5 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6282.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
@@ -32,6 +32,16 @@
 				marvell,function = "gpio";
 			};
 		};
+
+		smi0: mdio at 72000 {
+			status = "ok";
+		};
+
+		egiga0 {
+			phy_addr = <0x80>;
+			status = "ok";
+		};
+
 	};
 
 	gpio_keys {
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index ac27a3d..aa10096 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -46,10 +46,12 @@ config MACH_GURUPLUG
 
 config ARCH_KIRKWOOD_DT
 	bool "Marvell Kirkwood Flattened Device Tree"
+	select ARM_APPENDED_DTB
 	select POWER_SUPPLY
 	select POWER_RESET
 	select POWER_RESET_RESTART
 	select POWER_RESET_GPIO
+	select POWER_RESET_QNAP
 	select REGULATOR
 	select REGULATOR_FIXED_VOLTAGE
 	select MVEBU_CLK_CORE
@@ -67,21 +69,6 @@ config MACH_DLINK_KIRKWOOD_DT
 	  Kirkwood-based D-Link NASes such as DNS-320 & DNS-325,
 	  using Flattened Device Tree.
 
-config MACH_TS219_DT
-	bool "Device Tree for QNAP TS-11X, TS-21X NAS"
-	select ARCH_KIRKWOOD_DT
-	select ARM_APPENDED_DTB
-	select ARM_ATAG_DTB_COMPAT
-	select POWER_RESET_QNAP
-	help
-	  Say 'Y' here if you want your kernel to support the QNAP
-	  TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and
-	  TS-219P+ Turbo NAS devices using Fattened Device Tree.
-	  There are two different Device Tree descriptions, depending
-	  on if the device is based on an if the board uses the MV6281
-	  or MV6282. If you have the wrong one, the buttons will not
-	  work.
-
 config MACH_IOMEGA_IX2_200_DT
 	bool "Iomega StorCenter ix2-200 (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index ab739b0..e94973c 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -21,6 +21,5 @@ obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
 
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
 obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
-obj-$(CONFIG_MACH_TS219_DT)		+= board-ts219.o tsx1x-common.o
 obj-$(CONFIG_MACH_IOMEGA_IX2_200_DT)	+= board-iomega_ix2_200.o
 obj-$(CONFIG_MACH_KM_KIRKWOOD_DT)	+= board-km_kirkwood.o
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index edb1215..70c8d7d 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -121,9 +121,6 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("dlink,dns-kirkwood"))
 		dnskw_init();
 
-	if (of_machine_is_compatible("qnap,ts219"))
-		qnap_dt_ts219_init();
-
 	if (of_machine_is_compatible("iom,ix2-200"))
 		iomega_ix2_200_init();
 
diff --git a/arch/arm/mach-kirkwood/board-ts219.c b/arch/arm/mach-kirkwood/board-ts219.c
deleted file mode 100644
index f00c0a9..0000000
--- a/arch/arm/mach-kirkwood/board-ts219.c
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- *
- * QNAP TS-11x/TS-21x Turbo NAS Board Setup via DT
- *
- * Copyright (C) 2012 Andrew Lunn <andrew@lunn.ch>
- *
- * Based on the board file ts219-setup.c:
- *
- * Copyright (C) 2009  Martin Michlmayr <tbm@cyrius.com>
- * Copyright (C) 2008  Byron Bradley <byron.bbradley@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/mv643xx_eth.h>
-#include <mach/kirkwood.h>
-#include "common.h"
-
-static struct mv643xx_eth_platform_data qnap_ts219_ge00_data = {
-	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
-};
-
-void __init qnap_dt_ts219_init(void)
-{
-	u32 dev, rev;
-
-	kirkwood_pcie_id(&dev, &rev);
-	if (dev == MV88F6282_DEV_ID)
-		qnap_ts219_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
-
-	kirkwood_ge00_init(&qnap_ts219_ge00_data);
-}
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index ba6eb9c..8f98b67 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -55,12 +55,6 @@ void kirkwood_restart(char, const char *);
 void kirkwood_clk_init(void);
 
 /* board init functions for boards not fully converted to fdt */
-#ifdef CONFIG_MACH_TS219_DT
-void qnap_dt_ts219_init(void);
-#else
-static inline void qnap_dt_ts219_init(void) {};
-#endif
-
 #ifdef CONFIG_MACH_DLINK_KIRKWOOD_DT
 void dnskw_init(void);
 #else
-- 
1.8.1.1
