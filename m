From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 21:35:26 +0000
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <201205151626.49173.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515173909.383a0d8a@skate> <201205151626.49173.arnd@arndb.de>
Message-ID: <201205152135.26759.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Arnd Bergmann wrote:

> Another way would be to reorganize those directories upfront:
> 
> plat-orion -> mach-orion
> mach-*/*.c -> mach/orion/*/*.c
> mach-*/include/mach/* -> mach-orion/include/mach/*.h
> 
> and then go from there. The differences between the headers are fairly
> small already, so that should be manageable.

Actually we could do a trivial move of all files into one directory at any
time, e.g. at the end of the merge window, to minimize conflicts with
other patches.

This is a semi-automated move of all plat-orion based machines into
a single mach-orion directory, and we could of course add the new stuff
in there as well. I've specifically tried to keep this move simple,
even if that means a lot of the easy cleanups for code that are mostly
identical are not done here. Cleanups after this could come one at
a time to reduce this duplication and simplify the platform.

Obvious next steps are to merge the various Makefile and Kconfig files
as well as all the headers, and to actually allow building stuff together.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

 arch/arm/mach-dove/Makefile.boot                 |    3 --
 arch/arm/mach-dove/include/mach/gpio.h           |    9 -------
 arch/arm/mach-dove/include/mach/hardware.h       |   19 ----------------
 arch/arm/mach-kirkwood/include/mach/gpio.h       |    9 -------
 arch/arm/mach-kirkwood/include/mach/hardware.h   |   14 ------------
 arch/arm/mach-kirkwood/include/mach/timex.h      |   10 --------
 arch/arm/mach-mv78xx0/Makefile.boot              |    3 --
 arch/arm/mach-mv78xx0/include/mach/gpio.h        |    9 -------
 arch/arm/mach-mv78xx0/include/mach/hardware.h    |   14 ------------
 arch/arm/mach-mv78xx0/include/mach/timex.h       |    9 -------
 arch/arm/mach-orion5x/Makefile.boot              |    3 --
 arch/arm/mach-orion5x/include/mach/gpio.h        |    9 -------
 arch/arm/mach-orion5x/include/mach/hardware.h    |   14 ------------
 arch/arm/mach-orion5x/include/mach/timex.h       |   11 ---------
 arch/arm/plat-orion/Makefile                     |   10 --------
 b/arch/arm/Kconfig                               |    8 -------
 b/arch/arm/Makefile                              |    9 +++----
 b/arch/arm/mach-orion/Kconfig                    |    7 ++++++
 b/arch/arm/mach-orion/Makefile                   |   26 +++++++++++++++++++++++
 b/arch/arm/mach-orion/Makefile.dove              |    2 -
 b/arch/arm/mach-orion/Makefile.kirkwood          |    2 -
 b/arch/arm/mach-orion/Makefile.mv78xx0           |    2 -
 b/arch/arm/mach-orion/Makefile.orion5x           |    2 -
 b/arch/arm/mach-orion/addr-map-dove.c            |    4 +--
 b/arch/arm/mach-orion/addr-map-kirkwood.c        |    4 +--
 b/arch/arm/mach-orion/addr-map-mv78xx0.c         |    4 +--
 b/arch/arm/mach-orion/addr-map-orion5x.c         |    4 +--
 b/arch/arm/mach-orion/addr-map.c                 |    2 -
 b/arch/arm/mach-orion/board-dnskw.c              |    4 +--
 b/arch/arm/mach-orion/board-dreamplug.c          |    6 ++---
 b/arch/arm/mach-orion/board-dt.c                 |    2 -
 b/arch/arm/mach-orion/board-ib62x0.c             |    4 +--
 b/arch/arm/mach-orion/board-iconnect.c           |    4 +--
 b/arch/arm/mach-orion/buffalo-wxl-setup.c        |    4 +--
 b/arch/arm/mach-orion/cm-a510.c                  |    2 -
 b/arch/arm/mach-orion/common.c                   |    6 ++---
 b/arch/arm/mach-orion/d2net-setup.c              |    4 +--
 b/arch/arm/mach-orion/d2net_v2-setup.c           |    4 +--
 b/arch/arm/mach-orion/db78x00-bp-setup.c         |    2 -
 b/arch/arm/mach-orion/db88f5281-setup.c          |    6 ++---
 b/arch/arm/mach-orion/db88f6281-bp-setup.c       |    6 ++---
 b/arch/arm/mach-orion/dns323-setup.c             |    4 +--
 b/arch/arm/mach-orion/dockstar-setup.c           |    6 ++---
 b/arch/arm/mach-orion/dove-db-setup.c            |    2 -
 b/arch/arm/mach-orion/dove.c                     |   10 ++++----
 b/arch/arm/mach-orion/edmini_v2-setup.c          |    4 +--
 b/arch/arm/mach-orion/guruplug-setup.c           |    6 ++---
 b/arch/arm/mach-orion/include/mach/bridge-regs.h |   12 ++++++++++
 b/arch/arm/mach-orion/include/mach/debug-macro.S |   12 ++++++++++
 b/arch/arm/mach-orion/include/mach/entry-macro.S |   12 ++++++++++
 b/arch/arm/mach-orion/include/mach/hardware.h    |   12 ++++++++++
 b/arch/arm/mach-orion/include/mach/io.h          |   12 ++++++++++
 b/arch/arm/mach-orion/include/mach/irqs.h        |   12 ++++++++++
 b/arch/arm/mach-orion/include/mach/uncompress.h  |   12 ++++++++++
 b/arch/arm/mach-orion/irq-dove.c                 |    4 +--
 b/arch/arm/mach-orion/irq-kirkwood.c             |    4 +--
 b/arch/arm/mach-orion/irq-mv78xx0.c              |    4 +--
 b/arch/arm/mach-orion/irq-orion5x.c              |    4 +--
 b/arch/arm/mach-orion/irq.c                      |    2 -
 b/arch/arm/mach-orion/kirkwood.c                 |   18 +++++++--------
 b/arch/arm/mach-orion/kurobox_pro-setup.c        |    6 ++---
 b/arch/arm/mach-orion/lacie_v2-common.c          |    4 +--
 b/arch/arm/mach-orion/ls-chl-setup.c             |    4 +--
 b/arch/arm/mach-orion/ls_hgl-setup.c             |    4 +--
 b/arch/arm/mach-orion/lsmini-setup.c             |    4 +--
 b/arch/arm/mach-orion/mpp-dove.c                 |    4 +--
 b/arch/arm/mach-orion/mpp-kirkwood.c             |    6 ++---
 b/arch/arm/mach-orion/mpp-mv78xx0.c              |    6 ++---
 b/arch/arm/mach-orion/mpp-orion5x.c              |    6 ++---
 b/arch/arm/mach-orion/mpp.c                      |    2 -
 b/arch/arm/mach-orion/mss2-setup.c               |    4 +--
 b/arch/arm/mach-orion/mv2120-setup.c             |    4 +--
 b/arch/arm/mach-orion/mv78xx0.c                  |   14 ++++++------
 b/arch/arm/mach-orion/mv88f6281gtw_ge-setup.c    |    4 +--
 b/arch/arm/mach-orion/net2big-setup.c            |    4 +--
 b/arch/arm/mach-orion/netspace_v2-setup.c        |    4 +--
 b/arch/arm/mach-orion/netxbig_v2-setup.c         |    4 +--
 b/arch/arm/mach-orion/openrd-setup.c             |    6 ++---
 b/arch/arm/mach-orion/orion5x.c                  |   12 +++++-----
 b/arch/arm/mach-orion/pci-orion5x.c              |    6 ++---
 b/arch/arm/mach-orion/pcie-dove.c                |    6 ++---
 b/arch/arm/mach-orion/pcie-kirkwood.c            |    6 ++---
 b/arch/arm/mach-orion/pcie-mv78xx0.c             |    6 ++---
 b/arch/arm/mach-orion/pcie.c                     |    4 +--
 b/arch/arm/mach-orion/rd78x00-masa-setup.c       |    2 -
 b/arch/arm/mach-orion/rd88f5181l-fxo-setup.c     |    4 +--
 b/arch/arm/mach-orion/rd88f5181l-ge-setup.c      |    4 +--
 b/arch/arm/mach-orion/rd88f5182-setup.c          |    4 +--
 b/arch/arm/mach-orion/rd88f6183ap-ge-setup.c     |    2 -
 b/arch/arm/mach-orion/rd88f6192-nas-setup.c      |    2 -
 b/arch/arm/mach-orion/rd88f6281-setup.c          |    6 ++---
 b/arch/arm/mach-orion/sheevaplug-setup.c         |    6 ++---
 b/arch/arm/mach-orion/t5325-setup.c              |    4 +--
 b/arch/arm/mach-orion/terastation_pro2-setup.c   |    4 +--
 b/arch/arm/mach-orion/ts209-setup.c              |    4 +--
 b/arch/arm/mach-orion/ts219-setup.c              |    4 +--
 b/arch/arm/mach-orion/ts409-setup.c              |    4 +--
 b/arch/arm/mach-orion/ts41x-setup.c              |    6 ++---
 b/arch/arm/mach-orion/ts78xx-setup.c             |    4 +--
 b/arch/arm/mach-orion/tsx09-common.c             |    2 -
 b/arch/arm/mach-orion/tsx1x-common.c             |    2 -
 b/arch/arm/mach-orion/wnr854t-setup.c            |    4 +--
 b/arch/arm/mach-orion/wrt350n-v2-setup.c         |    4 +--
 b/arch/arm/mm/cache-feroceon-l2.c                |    2 -
 b/drivers/dma/mv_xor.c                           |    2 -
 b/drivers/mmc/host/mvsdio.c                      |    2 -
 b/drivers/mtd/nand/orion_nand.c                  |    2 -
 b/drivers/usb/host/ehci-orion.c                  |    2 -
 b/drivers/watchdog/orion_wdt.c                   |    2 -
 b/sound/soc/kirkwood/kirkwood-i2s.c              |    2 -
 b/sound/soc/kirkwood/kirkwood-openrd.c           |    2 -
 b/sound/soc/kirkwood/kirkwood-t5325.c            |    2 -
 112 files changed, 306 insertions(+), 342 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 852b12b..196dfbf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1013,8 +1013,6 @@ source "arch/arm/mach-cns3xxx/Kconfig"
 
 source "arch/arm/mach-davinci/Kconfig"
 
-source "arch/arm/mach-dove/Kconfig"
-
 source "arch/arm/mach-ep93xx/Kconfig"
 
 source "arch/arm/mach-footbridge/Kconfig"
@@ -1033,16 +1031,12 @@ source "arch/arm/mach-iop13xx/Kconfig"
 
 source "arch/arm/mach-ixp4xx/Kconfig"
 
-source "arch/arm/mach-kirkwood/Kconfig"
-
 source "arch/arm/mach-ks8695/Kconfig"
 
 source "arch/arm/mach-lpc32xx/Kconfig"
 
 source "arch/arm/mach-msm/Kconfig"
 
-source "arch/arm/mach-mv78xx0/Kconfig"
-
 source "arch/arm/plat-mxc/Kconfig"
 
 source "arch/arm/mach-mxs/Kconfig"
@@ -1058,7 +1052,7 @@ source "arch/arm/mach-omap1/Kconfig"
 
 source "arch/arm/mach-omap2/Kconfig"
 
-source "arch/arm/mach-orion5x/Kconfig"
+source "arch/arm/mach-orion/Kconfig"
 
 source "arch/arm/mach-pxa/Kconfig"
 source "arch/arm/plat-pxa/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index b3eb01a..ec55498 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -139,7 +139,7 @@ machine-$(CONFIG_ARCH_BCMRING)		:= bcmring
 machine-$(CONFIG_ARCH_CLPS711X)		:= clps711x
 machine-$(CONFIG_ARCH_CNS3XXX)		:= cns3xxx
 machine-$(CONFIG_ARCH_DAVINCI)		:= davinci
-machine-$(CONFIG_ARCH_DOVE)		:= dove
+machine-$(CONFIG_ARCH_DOVE)		:= orion
 machine-$(CONFIG_ARCH_EBSA110)		:= ebsa110
 machine-$(CONFIG_ARCH_EP93XX)		:= ep93xx
 machine-$(CONFIG_ARCH_GEMINI)		:= gemini
@@ -150,12 +150,12 @@ machine-$(CONFIG_ARCH_IOP13XX)		:= iop13xx
 machine-$(CONFIG_ARCH_IOP32X)		:= iop32x
 machine-$(CONFIG_ARCH_IOP33X)		:= iop33x
 machine-$(CONFIG_ARCH_IXP4XX)		:= ixp4xx
-machine-$(CONFIG_ARCH_KIRKWOOD)		:= kirkwood
+machine-$(CONFIG_ARCH_KIRKWOOD)		:= orion
 machine-$(CONFIG_ARCH_KS8695)		:= ks8695
 machine-$(CONFIG_ARCH_LPC32XX)		:= lpc32xx
 machine-$(CONFIG_ARCH_MMP)		:= mmp
 machine-$(CONFIG_ARCH_MSM)		:= msm
-machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
+machine-$(CONFIG_ARCH_MV78XX0)		:= orion
 machine-$(CONFIG_ARCH_IMX_V4_V5)	:= imx
 machine-$(CONFIG_ARCH_IMX_V6_V7)	:= imx
 machine-$(CONFIG_ARCH_MXS)		:= mxs
@@ -163,7 +163,7 @@ machine-$(CONFIG_ARCH_NETX)		:= netx
 machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
 machine-$(CONFIG_ARCH_OMAP1)		:= omap1
 machine-$(CONFIG_ARCH_OMAP2PLUS)	:= omap2
-machine-$(CONFIG_ARCH_ORION5X)		:= orion5x
+machine-$(CONFIG_ARCH_ORION5X)		:= orion
 machine-$(CONFIG_ARCH_PICOXCELL)	:= picoxcell
 machine-$(CONFIG_ARCH_PNX4008)		:= pnx4008
 machine-$(CONFIG_ARCH_PRIMA2)		:= prima2
@@ -204,7 +204,6 @@ plat-$(CONFIG_ARCH_S3C64XX)	:= samsung
 plat-$(CONFIG_ARCH_ZYNQ)	:= versatile
 plat-$(CONFIG_PLAT_IOP)		:= iop
 plat-$(CONFIG_PLAT_NOMADIK)	:= nomadik
-plat-$(CONFIG_PLAT_ORION)	:= orion
 plat-$(CONFIG_PLAT_PXA)		:= pxa
 plat-$(CONFIG_PLAT_S3C24XX)	:= s3c24xx samsung
 plat-$(CONFIG_PLAT_S5P)		:= samsung
diff --git a/arch/arm/mach-dove/Makefile.boot b/arch/arm/mach-dove/Makefile.boot
deleted file mode 100644
index 760a0ef..0000000
--- a/arch/arm/mach-dove/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-dove/include/mach/gpio.h b/arch/arm/mach-dove/include/mach/gpio.h
deleted file mode 100644
index e7e5101..0000000
--- a/arch/arm/mach-dove/include/mach/gpio.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/*
- * arch/arm/mach-dove/include/mach/gpio.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <plat/gpio.h>
diff --git a/arch/arm/mach-dove/include/mach/hardware.h b/arch/arm/mach-dove/include/mach/hardware.h
deleted file mode 100644
index f1368b9..0000000
--- a/arch/arm/mach-dove/include/mach/hardware.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * arch/arm/mach-dove/include/mach/hardware.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-#include "dove.h"
-
-/* Macros below are required for compatibility with PXA AC'97 driver.	*/
-#define __REG(x)	(*((volatile u32 *)((x) - DOVE_SB_REGS_PHYS_BASE + \
-				DOVE_SB_REGS_VIRT_BASE)))
-#define __PREG(x)	(((u32)&(x)) - DOVE_SB_REGS_VIRT_BASE + \
-		DOVE_SB_REGS_PHYS_BASE)
-#endif
diff --git a/arch/arm/mach-kirkwood/include/mach/gpio.h b/arch/arm/mach-kirkwood/include/mach/gpio.h
deleted file mode 100644
index 84f340b..0000000
--- a/arch/arm/mach-kirkwood/include/mach/gpio.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/*
- * arch/asm-arm/mach-kirkwood/include/mach/gpio.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <plat/gpio.h>
diff --git a/arch/arm/mach-kirkwood/include/mach/hardware.h b/arch/arm/mach-kirkwood/include/mach/hardware.h
deleted file mode 100644
index 742b74f..0000000
--- a/arch/arm/mach-kirkwood/include/mach/hardware.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/include/mach/hardware.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-#include "kirkwood.h"
-
-#endif
diff --git a/arch/arm/mach-kirkwood/include/mach/timex.h b/arch/arm/mach-kirkwood/include/mach/timex.h
deleted file mode 100644
index c923cd1..0000000
--- a/arch/arm/mach-kirkwood/include/mach/timex.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/*
- * arch/arm/mach-kirkwood/include/mach/timex.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#define CLOCK_TICK_RATE		(100 * HZ)
-
diff --git a/arch/arm/mach-mv78xx0/Makefile.boot b/arch/arm/mach-mv78xx0/Makefile.boot
deleted file mode 100644
index 760a0ef..0000000
--- a/arch/arm/mach-mv78xx0/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-mv78xx0/include/mach/gpio.h b/arch/arm/mach-mv78xx0/include/mach/gpio.h
deleted file mode 100644
index 77e1b84..0000000
--- a/arch/arm/mach-mv78xx0/include/mach/gpio.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/*
- * arch/asm-arm/mach-mv78xx0/include/mach/gpio.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <plat/gpio.h>
diff --git a/arch/arm/mach-mv78xx0/include/mach/hardware.h b/arch/arm/mach-mv78xx0/include/mach/hardware.h
deleted file mode 100644
index 67cab0a..0000000
--- a/arch/arm/mach-mv78xx0/include/mach/hardware.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * arch/arm/mach-mv78xx0/include/mach/hardware.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-#include "mv78xx0.h"
-
-#endif
diff --git a/arch/arm/mach-mv78xx0/include/mach/timex.h b/arch/arm/mach-mv78xx0/include/mach/timex.h
deleted file mode 100644
index 0e8c443..0000000
--- a/arch/arm/mach-mv78xx0/include/mach/timex.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/*
- * arch/arm/mach-mv78xx0/include/mach/timex.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#define CLOCK_TICK_RATE		(100 * HZ)
diff --git a/arch/arm/mach-orion/Kconfig b/arch/arm/mach-orion/Kconfig
new file mode 100644
index 0000000..769908f
--- /dev/null
+++ b/arch/arm/mach-orion/Kconfig
@@ -0,0 +1,7 @@
+source "arch/arm/mach-orion/Kconfig.dove"
+
+source "arch/arm/mach-orion/Kconfig.kirkwood"
+
+source "arch/arm/mach-orion/Kconfig.mv78xx0"
+
+source "arch/arm/mach-orion/Kconfig.orion5x"
diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-orion/Kconfig.dove
similarity index 100%
rename from arch/arm/mach-dove/Kconfig
rename to arch/arm/mach-orion/Kconfig.dove
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-orion/Kconfig.kirkwood
similarity index 100%
rename from arch/arm/mach-kirkwood/Kconfig
rename to arch/arm/mach-orion/Kconfig.kirkwood
diff --git a/arch/arm/mach-mv78xx0/Kconfig b/arch/arm/mach-orion/Kconfig.mv78xx0
similarity index 100%
rename from arch/arm/mach-mv78xx0/Kconfig
rename to arch/arm/mach-orion/Kconfig.mv78xx0
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion/Kconfig.orion5x
similarity index 100%
rename from arch/arm/mach-orion5x/Kconfig
rename to arch/arm/mach-orion/Kconfig.orion5x
diff --git a/arch/arm/mach-orion/Makefile b/arch/arm/mach-orion/Makefile
new file mode 100644
index 0000000..d91869d
--- /dev/null
+++ b/arch/arm/mach-orion/Makefile
@@ -0,0 +1,26 @@
+#
+# Makefile for the linux kernel.
+#
+
+obj-y	:= irq.o pcie.o time.o common.o mpp.o addr-map.o
+obj-m	:=
+obj-n	:=
+obj-	:=
+
+obj-$(CONFIG_GENERIC_GPIO) += gpio.o
+
+ifdef CONFIG_ARCH_DOVE
+include arch/arm/mach-orion/Makefile.dove
+endif
+
+ifdef CONFIG_ARCH_KIRKWOOD
+include arch/arm/mach-orion/Makefile.kirkwood
+endif
+
+ifdef CONFIG_ARCH_MV78xx0
+include arch/arm/mach-orion/Makefile.mv78xx0
+endif
+
+ifdef CONFIG_ARCH_ORION5X
+include arch/arm/mach-orion/Makefile.orion5x
+endif
diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-orion/Makefile.boot
similarity index 100%
rename from arch/arm/mach-kirkwood/Makefile.boot
rename to arch/arm/mach-orion/Makefile.boot
diff --git a/arch/arm/mach-dove/Makefile b/arch/arm/mach-orion/Makefile.dove
similarity index 55%
rename from arch/arm/mach-dove/Makefile
rename to arch/arm/mach-orion/Makefile.dove
index fa0f018..0625023 100644
--- a/arch/arm/mach-dove/Makefile
+++ b/arch/arm/mach-orion/Makefile.dove
@@ -1,4 +1,4 @@
-obj-y				+= common.o addr-map.o irq.o pcie.o mpp.o
+obj-y				+= dove.o addr-map-dove.o irq-dove.o pcie-dove.o mpp-dove.o
 
 obj-$(CONFIG_MACH_DOVE_DB)	+= dove-db-setup.o
 obj-$(CONFIG_MACH_CM_A510)	+= cm-a510.o
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-orion/Makefile.kirkwood
similarity index 93%
rename from arch/arm/mach-kirkwood/Makefile
rename to arch/arm/mach-orion/Makefile.kirkwood
index d2b0590..223d581 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-orion/Makefile.kirkwood
@@ -1,4 +1,4 @@
-obj-y				+= common.o addr-map.o irq.o pcie.o mpp.o
+obj-y				+= kirkwood.o addr-map-kirkwood.o irq-kirkwood.o pcie-kirkwood.o mpp-kirkwood.o
 
 obj-$(CONFIG_MACH_DB88F6281_BP)		+= db88f6281-bp-setup.o
 obj-$(CONFIG_MACH_RD88F6192_NAS)	+= rd88f6192-nas-setup.o
diff --git a/arch/arm/mach-mv78xx0/Makefile b/arch/arm/mach-orion/Makefile.mv78xx0
similarity index 66%
rename from arch/arm/mach-mv78xx0/Makefile
rename to arch/arm/mach-orion/Makefile.mv78xx0
index 67a13f9..29032eb 100644
--- a/arch/arm/mach-mv78xx0/Makefile
+++ b/arch/arm/mach-orion/Makefile.mv78xx0
@@ -1,4 +1,4 @@
-obj-y				+= common.o addr-map.o mpp.o irq.o pcie.o
+obj-y				+= mv78xx0.o addr-map-mv78xx0.o mpp-mv78xx0.o irq-mv78xx0.o pcie-mv78xx0.o
 obj-$(CONFIG_MACH_DB78X00_BP)	+= db78x00-bp-setup.o
 obj-$(CONFIG_MACH_RD78X00_MASA)	+= rd78x00-masa-setup.o
 obj-$(CONFIG_MACH_TERASTATION_WXL) += buffalo-wxl-setup.o
diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion/Makefile.orion5x
similarity index 93%
rename from arch/arm/mach-orion5x/Makefile
rename to arch/arm/mach-orion/Makefile.orion5x
index 7f18cda..7eb9c7b 100644
--- a/arch/arm/mach-orion5x/Makefile
+++ b/arch/arm/mach-orion/Makefile.orion5x
@@ -1,4 +1,4 @@
-obj-y				+= common.o addr-map.o pci.o irq.o mpp.o
+obj-y				+= orion5x.o addr-map-orion5x.o pci-orion5x.o irq-orion5x.o mpp-orion5x.o
 obj-$(CONFIG_MACH_DB88F5281)	+= db88f5281-setup.o
 obj-$(CONFIG_MACH_RD88F5182)	+= rd88f5182-setup.o
 obj-$(CONFIG_MACH_KUROBOX_PRO)	+= kurobox_pro-setup.o
diff --git a/arch/arm/mach-dove/addr-map.c b/arch/arm/mach-orion/addr-map-dove.c
similarity index 98%
rename from arch/arm/mach-dove/addr-map.c
rename to arch/arm/mach-orion/addr-map-dove.c
index 2a06c01..32e68ff 100644
--- a/arch/arm/mach-dove/addr-map.c
+++ b/arch/arm/mach-orion/addr-map-dove.c
@@ -15,8 +15,8 @@
 #include <asm/mach/arch.h>
 #include <asm/setup.h>
 #include <mach/dove.h>
-#include <plat/addr-map.h>
-#include "common.h"
+#include <mach/addr-map.h>
+#include "dove.h"
 
 /*
  * Generic Address Decode Windows bit settings
diff --git a/arch/arm/mach-kirkwood/addr-map.c b/arch/arm/mach-orion/addr-map-kirkwood.c
similarity index 97%
rename from arch/arm/mach-kirkwood/addr-map.c
rename to arch/arm/mach-orion/addr-map-kirkwood.c
index e9a7180..63e1932 100644
--- a/arch/arm/mach-kirkwood/addr-map.c
+++ b/arch/arm/mach-orion/addr-map-kirkwood.c
@@ -13,8 +13,8 @@
 #include <linux/mbus.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
-#include <plat/addr-map.h>
-#include "common.h"
+#include <mach/addr-map.h>
+#include "kirkwood.h"
 
 /*
  * Generic Address Decode Windows bit settings
diff --git a/arch/arm/mach-mv78xx0/addr-map.c b/arch/arm/mach-orion/addr-map-mv78xx0.c
similarity index 98%
rename from arch/arm/mach-mv78xx0/addr-map.c
rename to arch/arm/mach-orion/addr-map-mv78xx0.c
index 62b53d7..99da1bb 100644
--- a/arch/arm/mach-mv78xx0/addr-map.c
+++ b/arch/arm/mach-orion/addr-map-mv78xx0.c
@@ -12,8 +12,8 @@
 #include <linux/init.h>
 #include <linux/mbus.h>
 #include <linux/io.h>
-#include <plat/addr-map.h>
-#include "common.h"
+#include <mach/addr-map.h>
+#include "mv78xx0.h"
 
 /*
  * Generic Address Decode Windows bit settings
diff --git a/arch/arm/mach-orion5x/addr-map.c b/arch/arm/mach-orion/addr-map-orion5x.c
similarity index 98%
rename from arch/arm/mach-orion5x/addr-map.c
rename to arch/arm/mach-orion/addr-map-orion5x.c
index eaac83d..582362d 100644
--- a/arch/arm/mach-orion5x/addr-map.c
+++ b/arch/arm/mach-orion/addr-map-orion5x.c
@@ -15,8 +15,8 @@
 #include <linux/mbus.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
-#include <plat/addr-map.h>
-#include "common.h"
+#include <mach/addr-map.h>
+#include "orion5x.h"
 
 /*
  * The Orion has fully programmable address map. There's a separate address
diff --git a/arch/arm/plat-orion/addr-map.c b/arch/arm/mach-orion/addr-map.c
similarity index 99%
rename from arch/arm/plat-orion/addr-map.c
rename to arch/arm/mach-orion/addr-map.c
index 367ca89..cd53710 100644
--- a/arch/arm/plat-orion/addr-map.c
+++ b/arch/arm/mach-orion/addr-map.c
@@ -13,7 +13,7 @@
 #include <linux/init.h>
 #include <linux/mbus.h>
 #include <linux/io.h>
-#include <plat/addr-map.h>
+#include <mach/addr-map.h>
 
 struct mbus_dram_target_info orion_mbus_dram_info;
 
diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-orion/board-dnskw.c
similarity index 99%
rename from arch/arm/mach-kirkwood/board-dnskw.c
rename to arch/arm/mach-orion/board-dnskw.c
index 58c2d68..c61858c 100644
--- a/arch/arm/mach-kirkwood/board-dnskw.c
+++ b/arch/arm/mach-orion/board-dnskw.c
@@ -28,8 +28,8 @@
 #include <asm/mach/map.h>
 #include <mach/kirkwood.h>
 #include <mach/bridge-regs.h>
-#include "common.h"
-#include "mpp.h"
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 
 static struct mv643xx_eth_platform_data dnskw_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
diff --git a/arch/arm/mach-kirkwood/board-dreamplug.c b/arch/arm/mach-orion/board-dreamplug.c
similarity index 97%
rename from arch/arm/mach-kirkwood/board-dreamplug.c
rename to arch/arm/mach-orion/board-dreamplug.c
index 9854539..eab6db6 100644
--- a/arch/arm/mach-kirkwood/board-dreamplug.c
+++ b/arch/arm/mach-orion/board-dreamplug.c
@@ -33,9 +33,9 @@
 #include <asm/mach/map.h>
 #include <mach/kirkwood.h>
 #include <mach/bridge-regs.h>
-#include <plat/mvsdio.h>
-#include "common.h"
-#include "mpp.h"
+#include <mach/mvsdio.h>
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 
 struct mtd_partition dreamplug_partitions[] = {
 	{
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-orion/board-dt.c
similarity index 99%
rename from arch/arm/mach-kirkwood/board-dt.c
rename to arch/arm/mach-orion/board-dt.c
index 10d1969..6ecdcf9 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-orion/board-dt.c
@@ -18,7 +18,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/bridge-regs.h>
-#include "common.h"
+#include "kirkwood.h"
 
 static struct of_device_id kirkwood_dt_match_table[] __initdata = {
 	{ .compatible = "simple-bus", },
diff --git a/arch/arm/mach-kirkwood/board-ib62x0.c b/arch/arm/mach-orion/board-ib62x0.c
similarity index 98%
rename from arch/arm/mach-kirkwood/board-ib62x0.c
rename to arch/arm/mach-orion/board-ib62x0.c
index eddf1df..5c8fa27 100644
--- a/arch/arm/mach-kirkwood/board-ib62x0.c
+++ b/arch/arm/mach-orion/board-ib62x0.c
@@ -24,8 +24,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include "common.h"
-#include "mpp.h"
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 
 #define IB62X0_GPIO_POWER_OFF	24
 
diff --git a/arch/arm/mach-kirkwood/board-iconnect.c b/arch/arm/mach-orion/board-iconnect.c
similarity index 98%
rename from arch/arm/mach-kirkwood/board-iconnect.c
rename to arch/arm/mach-orion/board-iconnect.c
index 2222c57..6c1c647 100644
--- a/arch/arm/mach-kirkwood/board-iconnect.c
+++ b/arch/arm/mach-orion/board-iconnect.c
@@ -28,8 +28,8 @@
 #include <linux/gpio_keys.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include "common.h"
-#include "mpp.h"
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 
 static struct mv643xx_eth_platform_data iconnect_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(11),
diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-orion/buffalo-wxl-setup.c
similarity index 98%
rename from arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
rename to arch/arm/mach-orion/buffalo-wxl-setup.c
index ee74ec9..1d602ae 100644
--- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
+++ b/arch/arm/mach-orion/buffalo-wxl-setup.c
@@ -20,8 +20,8 @@
 #include <mach/mv78xx0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include "common.h"
-#include "mpp.h"
+#include "mv78xx0.h"
+#include "mpp-mv78xx0.h"
 
 
 /* This arch has 2 Giga Ethernet */
diff --git a/arch/arm/mach-dove/cm-a510.c b/arch/arm/mach-orion/cm-a510.c
similarity index 99%
rename from arch/arm/mach-dove/cm-a510.c
rename to arch/arm/mach-orion/cm-a510.c
index 792b4e2..c011f15 100644
--- a/arch/arm/mach-dove/cm-a510.c
+++ b/arch/arm/mach-orion/cm-a510.c
@@ -24,7 +24,7 @@
 
 #include <mach/dove.h>
 
-#include "common.h"
+#include "dove.h"
 
 static struct mv643xx_eth_platform_data cm_a510_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR_DEFAULT,
diff --git a/arch/arm/plat-orion/common.c b/arch/arm/mach-orion/common.c
similarity index 99%
rename from arch/arm/plat-orion/common.c
rename to arch/arm/mach-orion/common.c
index 74daf5e..90afe40 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/mach-orion/common.c
@@ -18,9 +18,9 @@
 #include <linux/mv643xx_i2c.h>
 #include <net/dsa.h>
 #include <linux/spi/orion_spi.h>
-#include <plat/orion_wdt.h>
-#include <plat/mv_xor.h>
-#include <plat/ehci-orion.h>
+#include <mach/orion_wdt.h>
+#include <mach/mv_xor.h>
+#include <mach/ehci-orion.h>
 #include <mach/bridge-regs.h>
 
 /* Fill in the resources structure and link it into the platform
diff --git a/arch/arm/mach-kirkwood/cpuidle.c b/arch/arm/mach-orion/cpuidle.c
similarity index 100%
rename from arch/arm/mach-kirkwood/cpuidle.c
rename to arch/arm/mach-orion/cpuidle.c
diff --git a/arch/arm/mach-orion5x/d2net-setup.c b/arch/arm/mach-orion/d2net-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/d2net-setup.c
rename to arch/arm/mach-orion/d2net-setup.c
index d75dcfa..272b55c 100644
--- a/arch/arm/mach-orion5x/d2net-setup.c
+++ b/arch/arm/mach-orion/d2net-setup.c
@@ -27,8 +27,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 /*****************************************************************************
  * LaCie d2 Network Info
diff --git a/arch/arm/mach-kirkwood/d2net_v2-setup.c b/arch/arm/mach-orion/d2net_v2-setup.c
similarity index 99%
rename from arch/arm/mach-kirkwood/d2net_v2-setup.c
rename to arch/arm/mach-orion/d2net_v2-setup.c
index 6e1bac9..dc1c879 100644
--- a/arch/arm/mach-kirkwood/d2net_v2-setup.c
+++ b/arch/arm/mach-orion/d2net_v2-setup.c
@@ -33,8 +33,8 @@
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
 #include <mach/leds-ns2.h>
-#include "common.h"
-#include "mpp.h"
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 #include "lacie_v2-common.h"
 
 /*****************************************************************************
diff --git a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c b/arch/arm/mach-orion/db78x00-bp-setup.c
similarity index 99%
rename from arch/arm/mach-mv78xx0/db78x00-bp-setup.c
rename to arch/arm/mach-orion/db78x00-bp-setup.c
index 4d6d48b..b82889d 100644
--- a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
+++ b/arch/arm/mach-orion/db78x00-bp-setup.c
@@ -18,7 +18,7 @@
 #include <mach/mv78xx0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include "common.h"
+#include "mv78xx0.h"
 
 static struct mv643xx_eth_platform_data db78x00_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion/db88f5281-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/db88f5281-setup.c
rename to arch/arm/mach-orion/db88f5281-setup.c
index e52108c..030b643 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion/db88f5281-setup.c
@@ -24,9 +24,9 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-#include <plat/orion_nand.h>
-#include "common.h"
-#include "mpp.h"
+#include <mach/orion_nand.h>
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 /*****************************************************************************
  * DB-88F5281 on board devices
diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c b/arch/arm/mach-orion/db88f6281-bp-setup.c
similarity index 97%
rename from arch/arm/mach-kirkwood/db88f6281-bp-setup.c
rename to arch/arm/mach-orion/db88f6281-bp-setup.c
index d933593..43b01c9 100644
--- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
+++ b/arch/arm/mach-orion/db88f6281-bp-setup.c
@@ -17,9 +17,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include <plat/mvsdio.h>
-#include "common.h"
-#include "mpp.h"
+#include <mach/mvsdio.h>
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 
 static struct mtd_partition db88f6281_nand_parts[] = {
 	{
diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion/dns323-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/dns323-setup.c
rename to arch/arm/mach-orion/dns323-setup.c
index 13d2bec..6ddb272 100644
--- a/arch/arm/mach-orion5x/dns323-setup.c
+++ b/arch/arm/mach-orion/dns323-setup.c
@@ -34,8 +34,8 @@
 #include <asm/mach/pci.h>
 #include <asm/system_info.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 /* Rev A1 and B1 */
 #define DNS323_GPIO_LED_RIGHT_AMBER	1
diff --git a/arch/arm/mach-kirkwood/dockstar-setup.c b/arch/arm/mach-orion/dockstar-setup.c
similarity index 97%
rename from arch/arm/mach-kirkwood/dockstar-setup.c
rename to arch/arm/mach-orion/dockstar-setup.c
index 61d9a55..6fb0e83 100644
--- a/arch/arm/mach-kirkwood/dockstar-setup.c
+++ b/arch/arm/mach-orion/dockstar-setup.c
@@ -19,9 +19,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include <plat/mvsdio.h>
-#include "common.h"
-#include "mpp.h"
+#include <mach/mvsdio.h>
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 
 static struct mtd_partition dockstar_nand_parts[] = {
 	{
diff --git a/arch/arm/mach-dove/dove-db-setup.c b/arch/arm/mach-orion/dove-db-setup.c
similarity index 99%
rename from arch/arm/mach-dove/dove-db-setup.c
rename to arch/arm/mach-orion/dove-db-setup.c
index ea77ae4..2aca495 100644
--- a/arch/arm/mach-dove/dove-db-setup.c
+++ b/arch/arm/mach-orion/dove-db-setup.c
@@ -26,7 +26,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/dove.h>
-#include "common.h"
+#include "dove.h"
 
 static struct mv643xx_eth_platform_data dove_db_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR_DEFAULT,
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-orion/dove.c
similarity index 98%
rename from arch/arm/mach-dove/common.c
rename to arch/arm/mach-orion/dove.c
index 42ab1e7..e008c60 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-orion/dove.c
@@ -27,11 +27,11 @@
 #include <mach/bridge-regs.h>
 #include <asm/mach/arch.h>
 #include <linux/irq.h>
-#include <plat/time.h>
-#include <plat/ehci-orion.h>
-#include <plat/common.h>
-#include <plat/addr-map.h>
-#include "common.h"
+#include <mach/time.h>
+#include <mach/ehci-orion.h>
+#include <mach/common.h>
+#include <mach/addr-map.h>
+#include "dove.h"
 
 static int get_tclk(void);
 
diff --git a/arch/arm/mach-dove/common.h b/arch/arm/mach-orion/dove.h
similarity index 100%
rename from arch/arm/mach-dove/common.h
rename to arch/arm/mach-orion/dove.h
diff --git a/arch/arm/mach-orion5x/edmini_v2-setup.c b/arch/arm/mach-orion/edmini_v2-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/edmini_v2-setup.c
rename to arch/arm/mach-orion/edmini_v2-setup.c
index 355e962..7adbb5c 100644
--- a/arch/arm/mach-orion5x/edmini_v2-setup.c
+++ b/arch/arm/mach-orion/edmini_v2-setup.c
@@ -35,8 +35,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 /*****************************************************************************
  * EDMINI_V2 Info
diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/mach-orion/gpio.c
similarity index 100%
rename from arch/arm/plat-orion/gpio.c
rename to arch/arm/mach-orion/gpio.c
diff --git a/arch/arm/mach-kirkwood/guruplug-setup.c b/arch/arm/mach-orion/guruplug-setup.c
similarity index 97%
rename from arch/arm/mach-kirkwood/guruplug-setup.c
rename to arch/arm/mach-orion/guruplug-setup.c
index bdaed38..8901101 100644
--- a/arch/arm/mach-kirkwood/guruplug-setup.c
+++ b/arch/arm/mach-orion/guruplug-setup.c
@@ -19,9 +19,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include <plat/mvsdio.h>
-#include "common.h"
-#include "mpp.h"
+#include <mach/mvsdio.h>
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 
 static struct mtd_partition guruplug_nand_parts[] = {
 	{
diff --git a/arch/arm/plat-orion/include/plat/addr-map.h b/arch/arm/mach-orion/include/mach/addr-map.h
similarity index 100%
rename from arch/arm/plat-orion/include/plat/addr-map.h
rename to arch/arm/mach-orion/include/mach/addr-map.h
diff --git a/arch/arm/plat-orion/include/plat/audio.h b/arch/arm/mach-orion/include/mach/audio.h
similarity index 100%
rename from arch/arm/plat-orion/include/plat/audio.h
rename to arch/arm/mach-orion/include/mach/audio.h
diff --git a/arch/arm/mach-dove/include/mach/bridge-regs.h b/arch/arm/mach-orion/include/mach/bridge-regs-dove.h
similarity index 100%
rename from arch/arm/mach-dove/include/mach/bridge-regs.h
rename to arch/arm/mach-orion/include/mach/bridge-regs-dove.h
diff --git a/arch/arm/mach-kirkwood/include/mach/bridge-regs.h b/arch/arm/mach-orion/include/mach/bridge-regs-kirkwood.h
similarity index 100%
rename from arch/arm/mach-kirkwood/include/mach/bridge-regs.h
rename to arch/arm/mach-orion/include/mach/bridge-regs-kirkwood.h
diff --git a/arch/arm/mach-mv78xx0/include/mach/bridge-regs.h b/arch/arm/mach-orion/include/mach/bridge-regs-mv78xx0.h
similarity index 100%
rename from arch/arm/mach-mv78xx0/include/mach/bridge-regs.h
rename to arch/arm/mach-orion/include/mach/bridge-regs-mv78xx0.h
diff --git a/arch/arm/mach-orion5x/include/mach/bridge-regs.h b/arch/arm/mach-orion/include/mach/bridge-regs-orion5x.h
similarity index 100%
rename from arch/arm/mach-orion5x/include/mach/bridge-regs.h
rename to arch/arm/mach-orion/include/mach/bridge-regs-orion5x.h
diff --git a/arch/arm/mach-orion/include/mach/bridge-regs.h b/arch/arm/mach-orion/include/mach/bridge-regs.h
new file mode 100644
index 0000000..29cfc01
--- /dev/null
+++ b/arch/arm/mach-orion/include/mach/bridge-regs.h
@@ -0,0 +1,12 @@
+#ifdef CONFIG_ARCH_DOVE
+#include <mach/bridge-regs-dove.h>
+#endif
+#ifdef CONFIG_ARCH_KIRKWOOD
+#include <mach/bridge-regs-kirkwood.h>
+#endif
+#ifdef CONFIG_ARCH_MV78XX0
+#include <mach/bridge-regs-mv78xx0.h>
+#endif
+#ifdef CONFIG_ARCH_ORION5X
+#include <mach/bridge-regs-orion5x.h>
+#endif
diff --git a/arch/arm/plat-orion/include/plat/cache-feroceon-l2.h b/arch/arm/mach-orion/include/mach/cache-feroceon-l2.h
similarity index 100%
rename from arch/arm/plat-orion/include/plat/cache-feroceon-l2.h
rename to arch/arm/mach-orion/include/mach/cache-feroceon-l2.h
diff --git a/arch/arm/plat-orion/include/plat/common.h b/arch/arm/mach-orion/include/mach/common.h
similarity index 100%
rename from arch/arm/plat-orion/include/plat/common.h
rename to arch/arm/mach-orion/include/mach/common.h
diff --git a/arch/arm/mach-dove/include/mach/debug-macro.S b/arch/arm/mach-orion/include/mach/debug-macro-dove.S
similarity index 100%
rename from arch/arm/mach-dove/include/mach/debug-macro.S
rename to arch/arm/mach-orion/include/mach/debug-macro-dove.S
diff --git a/arch/arm/mach-kirkwood/include/mach/debug-macro.S b/arch/arm/mach-orion/include/mach/debug-macro-kirkwood.S
similarity index 100%
rename from arch/arm/mach-kirkwood/include/mach/debug-macro.S
rename to arch/arm/mach-orion/include/mach/debug-macro-kirkwood.S
diff --git a/arch/arm/mach-mv78xx0/include/mach/debug-macro.S b/arch/arm/mach-orion/include/mach/debug-macro-mv78xx0.S
similarity index 100%
rename from arch/arm/mach-mv78xx0/include/mach/debug-macro.S
rename to arch/arm/mach-orion/include/mach/debug-macro-mv78xx0.S
diff --git a/arch/arm/mach-orion5x/include/mach/debug-macro.S b/arch/arm/mach-orion/include/mach/debug-macro-orion5x.S
similarity index 100%
rename from arch/arm/mach-orion5x/include/mach/debug-macro.S
rename to arch/arm/mach-orion/include/mach/debug-macro-orion5x.S
diff --git a/arch/arm/mach-orion/include/mach/debug-macro.S b/arch/arm/mach-orion/include/mach/debug-macro.S
new file mode 100644
index 0000000..9f1118e
--- /dev/null
+++ b/arch/arm/mach-orion/include/mach/debug-macro.S
@@ -0,0 +1,12 @@
+#ifdef CONFIG_ARCH_DOVE
+#include <mach/debug-macro-dove.S>
+#endif
+#ifdef CONFIG_ARCH_KIRKWOOD
+#include <mach/debug-macro-kirkwood.S>
+#endif
+#ifdef CONFIG_ARCH_MV78XX0
+#include <mach/debug-macro-mv78xx0.S>
+#endif
+#ifdef CONFIG_ARCH_ORION5X
+#include <mach/debug-macro-orion5x.S>
+#endif
diff --git a/arch/arm/mach-dove/include/mach/dove.h b/arch/arm/mach-orion/include/mach/dove.h
similarity index 100%
rename from arch/arm/mach-dove/include/mach/dove.h
rename to arch/arm/mach-orion/include/mach/dove.h
diff --git a/arch/arm/plat-orion/include/plat/ehci-orion.h b/arch/arm/mach-orion/include/mach/ehci-orion.h
similarity index 100%
rename from arch/arm/plat-orion/include/plat/ehci-orion.h
rename to arch/arm/mach-orion/include/mach/ehci-orion.h
diff --git a/arch/arm/mach-dove/include/mach/entry-macro.S b/arch/arm/mach-orion/include/mach/entry-macro-dove.S
similarity index 100%
rename from arch/arm/mach-dove/include/mach/entry-macro.S
rename to arch/arm/mach-orion/include/mach/entry-macro-dove.S
diff --git a/arch/arm/mach-kirkwood/include/mach/entry-macro.S b/arch/arm/mach-orion/include/mach/entry-macro-kirkwood.S
similarity index 100%
rename from arch/arm/mach-kirkwood/include/mach/entry-macro.S
rename to arch/arm/mach-orion/include/mach/entry-macro-kirkwood.S
diff --git a/arch/arm/mach-mv78xx0/include/mach/entry-macro.S b/arch/arm/mach-orion/include/mach/entry-macro-mv78xx0.S
similarity index 100%
rename from arch/arm/mach-mv78xx0/include/mach/entry-macro.S
rename to arch/arm/mach-orion/include/mach/entry-macro-mv78xx0.S
diff --git a/arch/arm/mach-orion5x/include/mach/entry-macro.S b/arch/arm/mach-orion/include/mach/entry-macro-orion5x.S
similarity index 100%
rename from arch/arm/mach-orion5x/include/mach/entry-macro.S
rename to arch/arm/mach-orion/include/mach/entry-macro-orion5x.S
diff --git a/arch/arm/mach-orion/include/mach/entry-macro.S b/arch/arm/mach-orion/include/mach/entry-macro.S
new file mode 100644
index 0000000..c30bac5
--- /dev/null
+++ b/arch/arm/mach-orion/include/mach/entry-macro.S
@@ -0,0 +1,12 @@
+#ifdef CONFIG_ARCH_DOVE
+#include <mach/entry-macro-dove.S>
+#endif
+#ifdef CONFIG_ARCH_KIRKWOOD
+#include <mach/entry-macro-kirkwood.S>
+#endif
+#ifdef CONFIG_ARCH_MV78XX0
+#include <mach/entry-macro-mv78xx0.S>
+#endif
+#ifdef CONFIG_ARCH_ORION5X
+#include <mach/entry-macro-orion5x.S>
+#endif
diff --git a/arch/arm/plat-orion/include/plat/gpio.h b/arch/arm/mach-orion/include/mach/gpio.h
similarity index 100%
rename from arch/arm/plat-orion/include/plat/gpio.h
rename to arch/arm/mach-orion/include/mach/gpio.h
diff --git a/arch/arm/mach-orion/include/mach/hardware.h b/arch/arm/mach-orion/include/mach/hardware.h
new file mode 100644
index 0000000..c3eb636
--- /dev/null
+++ b/arch/arm/mach-orion/include/mach/hardware.h
@@ -0,0 +1,12 @@
+#ifdef CONFIG_ARCH_DOVE
+#include <mach/dove.h>
+#endif
+#ifdef CONFIG_ARCH_KIRKWOOD
+#include <mach/kirkwood.h>
+#endif
+#ifdef CONFIG_ARCH_MV78XX0
+#include <mach/mv78xx0.h>
+#endif
+#ifdef CONFIG_ARCH_ORION5X
+#include <mach/orion5x.h>
+#endif
diff --git a/arch/arm/mach-dove/include/mach/io.h b/arch/arm/mach-orion/include/mach/io-dove.h
similarity index 100%
rename from arch/arm/mach-dove/include/mach/io.h
rename to arch/arm/mach-orion/include/mach/io-dove.h
diff --git a/arch/arm/mach-kirkwood/include/mach/io.h b/arch/arm/mach-orion/include/mach/io-kirkwood.h
similarity index 100%
rename from arch/arm/mach-kirkwood/include/mach/io.h
rename to arch/arm/mach-orion/include/mach/io-kirkwood.h
diff --git a/arch/arm/mach-mv78xx0/include/mach/io.h b/arch/arm/mach-orion/include/mach/io-mv78xx0.h
similarity index 100%
rename from arch/arm/mach-mv78xx0/include/mach/io.h
rename to arch/arm/mach-orion/include/mach/io-mv78xx0.h
diff --git a/arch/arm/mach-orion/include/mach/io.h b/arch/arm/mach-orion/include/mach/io.h
new file mode 100644
index 0000000..044956d
--- /dev/null
+++ b/arch/arm/mach-orion/include/mach/io.h
@@ -0,0 +1,12 @@
+#ifdef CONFIG_ARCH_DOVE
+#include <mach/io-dove.h>
+#endif
+#ifdef CONFIG_ARCH_KIRKWOOD
+#include <mach/io-kirkwood.h>
+#endif
+#ifdef CONFIG_ARCH_MV78XX0
+#include <mach/io-mv78xx0.h>
+#endif
+#ifdef CONFIG_ARCH_ORION5X
+#include <mach/io-orion5x.h>
+#endif
diff --git a/arch/arm/plat-orion/include/plat/irq.h b/arch/arm/mach-orion/include/mach/irq.h
similarity index 100%
rename from arch/arm/plat-orion/include/plat/irq.h
rename to arch/arm/mach-orion/include/mach/irq.h
diff --git a/arch/arm/mach-dove/include/mach/irqs.h b/arch/arm/mach-orion/include/mach/irqs-dove.h
similarity index 100%
rename from arch/arm/mach-dove/include/mach/irqs.h
rename to arch/arm/mach-orion/include/mach/irqs-dove.h
diff --git a/arch/arm/mach-kirkwood/include/mach/irqs.h b/arch/arm/mach-orion/include/mach/irqs-kirkwood.h
similarity index 100%
rename from arch/arm/mach-kirkwood/include/mach/irqs.h
rename to arch/arm/mach-orion/include/mach/irqs-kirkwood.h
diff --git a/arch/arm/mach-mv78xx0/include/mach/irqs.h b/arch/arm/mach-orion/include/mach/irqs-mv78xx0.h
similarity index 100%
rename from arch/arm/mach-mv78xx0/include/mach/irqs.h
rename to arch/arm/mach-orion/include/mach/irqs-mv78xx0.h
diff --git a/arch/arm/mach-orion5x/include/mach/irqs.h b/arch/arm/mach-orion/include/mach/irqs-orion5x.h
similarity index 100%
rename from arch/arm/mach-orion5x/include/mach/irqs.h
rename to arch/arm/mach-orion/include/mach/irqs-orion5x.h
diff --git a/arch/arm/mach-orion/include/mach/irqs.h b/arch/arm/mach-orion/include/mach/irqs.h
new file mode 100644
index 0000000..2f06667
--- /dev/null
+++ b/arch/arm/mach-orion/include/mach/irqs.h
@@ -0,0 +1,12 @@
+#ifdef CONFIG_ARCH_DOVE
+#include <mach/irqs-dove.h>
+#endif
+#ifdef CONFIG_ARCH_KIRKWOOD
+#include <mach/irqs-kirkwood.h>
+#endif
+#ifdef CONFIG_ARCH_MV78XX0
+#include <mach/irqs-mv78xx0.h>
+#endif
+#ifdef CONFIG_ARCH_ORION5X
+#include <mach/irqs-orion5x.h>
+#endif
diff --git a/arch/arm/mach-kirkwood/include/mach/kirkwood.h b/arch/arm/mach-orion/include/mach/kirkwood.h
similarity index 100%
rename from arch/arm/mach-kirkwood/include/mach/kirkwood.h
rename to arch/arm/mach-orion/include/mach/kirkwood.h
diff --git a/arch/arm/mach-kirkwood/include/mach/leds-netxbig.h b/arch/arm/mach-orion/include/mach/leds-netxbig.h
similarity index 100%
rename from arch/arm/mach-kirkwood/include/mach/leds-netxbig.h
rename to arch/arm/mach-orion/include/mach/leds-netxbig.h
diff --git a/arch/arm/mach-kirkwood/include/mach/leds-ns2.h b/arch/arm/mach-orion/include/mach/leds-ns2.h
similarity index 100%
rename from arch/arm/mach-kirkwood/include/mach/leds-ns2.h
rename to arch/arm/mach-orion/include/mach/leds-ns2.h
diff --git a/arch/arm/plat-orion/include/plat/mpp.h b/arch/arm/mach-orion/include/mach/mpp.h
similarity index 100%
rename from arch/arm/plat-orion/include/plat/mpp.h
rename to arch/arm/mach-orion/include/mach/mpp.h
diff --git a/arch/arm/mach-mv78xx0/include/mach/mv78xx0.h b/arch/arm/mach-orion/include/mach/mv78xx0.h
similarity index 100%
rename from arch/arm/mach-mv78xx0/include/mach/mv78xx0.h
rename to arch/arm/mach-orion/include/mach/mv78xx0.h
diff --git a/arch/arm/plat-orion/include/plat/mv_xor.h b/arch/arm/mach-orion/include/mach/mv_xor.h
similarity index 100%
rename from arch/arm/plat-orion/include/plat/mv_xor.h
rename to arch/arm/mach-orion/include/mach/mv_xor.h
diff --git a/arch/arm/plat-orion/include/plat/mvsdio.h b/arch/arm/mach-orion/include/mach/mvsdio.h
similarity index 100%
rename from arch/arm/plat-orion/include/plat/mvsdio.h
rename to arch/arm/mach-orion/include/mach/mvsdio.h
diff --git a/arch/arm/mach-orion5x/include/mach/orion5x.h b/arch/arm/mach-orion/include/mach/orion5x.h
similarity index 100%
rename from arch/arm/mach-orion5x/include/mach/orion5x.h
rename to arch/arm/mach-orion/include/mach/orion5x.h
diff --git a/arch/arm/plat-orion/include/plat/orion_nand.h b/arch/arm/mach-orion/include/mach/orion_nand.h
similarity index 100%
rename from arch/arm/plat-orion/include/plat/orion_nand.h
rename to arch/arm/mach-orion/include/mach/orion_nand.h
diff --git a/arch/arm/plat-orion/include/plat/orion_wdt.h b/arch/arm/mach-orion/include/mach/orion_wdt.h
similarity index 100%
rename from arch/arm/plat-orion/include/plat/orion_wdt.h
rename to arch/arm/mach-orion/include/mach/orion_wdt.h
diff --git a/arch/arm/plat-orion/include/plat/pcie.h b/arch/arm/mach-orion/include/mach/pcie.h
similarity index 100%
rename from arch/arm/plat-orion/include/plat/pcie.h
rename to arch/arm/mach-orion/include/mach/pcie.h
diff --git a/arch/arm/mach-dove/include/mach/pm.h b/arch/arm/mach-orion/include/mach/pm.h
similarity index 100%
rename from arch/arm/mach-dove/include/mach/pm.h
rename to arch/arm/mach-orion/include/mach/pm.h
diff --git a/arch/arm/plat-orion/include/plat/time.h b/arch/arm/mach-orion/include/mach/time.h
similarity index 100%
rename from arch/arm/plat-orion/include/plat/time.h
rename to arch/arm/mach-orion/include/mach/time.h
diff --git a/arch/arm/mach-dove/include/mach/timex.h b/arch/arm/mach-orion/include/mach/timex.h
similarity index 100%
rename from arch/arm/mach-dove/include/mach/timex.h
rename to arch/arm/mach-orion/include/mach/timex.h
diff --git a/arch/arm/mach-dove/include/mach/uncompress.h b/arch/arm/mach-orion/include/mach/uncompress-dove.h
similarity index 100%
rename from arch/arm/mach-dove/include/mach/uncompress.h
rename to arch/arm/mach-orion/include/mach/uncompress-dove.h
diff --git a/arch/arm/mach-kirkwood/include/mach/uncompress.h b/arch/arm/mach-orion/include/mach/uncompress-kirkwood.h
similarity index 100%
rename from arch/arm/mach-kirkwood/include/mach/uncompress.h
rename to arch/arm/mach-orion/include/mach/uncompress-kirkwood.h
diff --git a/arch/arm/mach-mv78xx0/include/mach/uncompress.h b/arch/arm/mach-orion/include/mach/uncompress-mv78xx0.h
similarity index 100%
rename from arch/arm/mach-mv78xx0/include/mach/uncompress.h
rename to arch/arm/mach-orion/include/mach/uncompress-mv78xx0.h
diff --git a/arch/arm/mach-orion5x/include/mach/uncompress.h b/arch/arm/mach-orion/include/mach/uncompress-orion5x.h
similarity index 100%
rename from arch/arm/mach-orion5x/include/mach/uncompress.h
rename to arch/arm/mach-orion/include/mach/uncompress-orion5x.h
diff --git a/arch/arm/mach-orion/include/mach/uncompress.h b/arch/arm/mach-orion/include/mach/uncompress.h
new file mode 100644
index 0000000..fa1ba53
--- /dev/null
+++ b/arch/arm/mach-orion/include/mach/uncompress.h
@@ -0,0 +1,12 @@
+#ifdef CONFIG_ARCH_DOVE
+#include <mach/uncompress-dove.h>
+#endif
+#ifdef CONFIG_ARCH_KIRKWOOD
+#include <mach/uncompress-kirkwood.h>
+#endif
+#ifdef CONFIG_ARCH_MV78XX0
+#include <mach/uncompress-mv78xx0.h>
+#endif
+#ifdef CONFIG_ARCH_ORION5X
+#include <mach/uncompress-orion5x.h>
+#endif
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-orion/irq-dove.c
similarity index 98%
rename from arch/arm/mach-dove/irq.c
rename to arch/arm/mach-orion/irq-dove.c
index f07fd16..1a78639 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-orion/irq-dove.c
@@ -14,11 +14,11 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <asm/mach/arch.h>
-#include <plat/irq.h>
+#include <mach/irq.h>
 #include <asm/mach/irq.h>
 #include <mach/pm.h>
 #include <mach/bridge-regs.h>
-#include "common.h"
+#include "dove.h"
 
 static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
diff --git a/arch/arm/mach-kirkwood/irq.c b/arch/arm/mach-orion/irq-kirkwood.c
similarity index 97%
rename from arch/arm/mach-kirkwood/irq.c
rename to arch/arm/mach-orion/irq-kirkwood.c
index c4c68e5..75e124f 100644
--- a/arch/arm/mach-kirkwood/irq.c
+++ b/arch/arm/mach-orion/irq-kirkwood.c
@@ -13,8 +13,8 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <mach/bridge-regs.h>
-#include <plat/irq.h>
-#include "common.h"
+#include <mach/irq.h>
+#include "kirkwood.h"
 
 static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-orion/irq-mv78xx0.c
similarity index 97%
rename from arch/arm/mach-mv78xx0/irq.c
rename to arch/arm/mach-orion/irq-mv78xx0.c
index e421b70..695ae9b 100644
--- a/arch/arm/mach-mv78xx0/irq.c
+++ b/arch/arm/mach-orion/irq-mv78xx0.c
@@ -13,8 +13,8 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <mach/bridge-regs.h>
-#include <plat/irq.h>
-#include "common.h"
+#include <mach/irq.h>
+#include "mv78xx0.h"
 
 static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion/irq-orion5x.c
similarity index 96%
rename from arch/arm/mach-orion5x/irq.c
rename to arch/arm/mach-orion/irq-orion5x.c
index b1b45ff..6d1f1f7 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion/irq-orion5x.c
@@ -15,8 +15,8 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <mach/bridge-regs.h>
-#include <plat/irq.h>
-#include "common.h"
+#include <mach/irq.h>
+#include "orion5x.h"
 
 static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
diff --git a/arch/arm/plat-orion/irq.c b/arch/arm/mach-orion/irq.c
similarity index 97%
rename from arch/arm/plat-orion/irq.c
rename to arch/arm/mach-orion/irq.c
index 2d5b9c1..b108805 100644
--- a/arch/arm/plat-orion/irq.c
+++ b/arch/arm/mach-orion/irq.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/io.h>
-#include <plat/irq.h>
+#include <mach/irq.h>
 
 void __init orion_irq_init(unsigned int irq_start, void __iomem *maskaddr)
 {
diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-orion/kirkwood.c
similarity index 98%
rename from arch/arm/mach-kirkwood/common.c
rename to arch/arm/mach-orion/kirkwood.c
index 3ad0373..3dd3b3f 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-orion/kirkwood.c
@@ -24,15 +24,15 @@
 #include <asm/mach/time.h>
 #include <mach/kirkwood.h>
 #include <mach/bridge-regs.h>
-#include <plat/audio.h>
-#include <plat/cache-feroceon-l2.h>
-#include <plat/mvsdio.h>
-#include <plat/orion_nand.h>
-#include <plat/ehci-orion.h>
-#include <plat/common.h>
-#include <plat/time.h>
-#include <plat/addr-map.h>
-#include "common.h"
+#include <mach/audio.h>
+#include <mach/cache-feroceon-l2.h>
+#include <mach/mvsdio.h>
+#include <mach/orion_nand.h>
+#include <mach/ehci-orion.h>
+#include <mach/common.h>
+#include <mach/time.h>
+#include <mach/addr-map.h>
+#include "kirkwood.h"
 
 /*****************************************************************************
  * I/O Address Mapping
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-orion/kirkwood.h
similarity index 100%
rename from arch/arm/mach-kirkwood/common.h
rename to arch/arm/mach-orion/kirkwood.h
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion/kurobox_pro-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/kurobox_pro-setup.c
rename to arch/arm/mach-orion/kurobox_pro-setup.c
index 47587b8..827d446 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion/kurobox_pro-setup.c
@@ -24,9 +24,9 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-#include <plat/orion_nand.h>
-#include "common.h"
-#include "mpp.h"
+#include <mach/orion_nand.h>
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 /*****************************************************************************
  * KUROBOX-PRO Info
diff --git a/arch/arm/mach-kirkwood/lacie_v2-common.c b/arch/arm/mach-orion/lacie_v2-common.c
similarity index 98%
rename from arch/arm/mach-kirkwood/lacie_v2-common.c
rename to arch/arm/mach-orion/lacie_v2-common.c
index 285edab..21aca25 100644
--- a/arch/arm/mach-kirkwood/lacie_v2-common.c
+++ b/arch/arm/mach-orion/lacie_v2-common.c
@@ -17,8 +17,8 @@
 #include <asm/mach/time.h>
 #include <mach/kirkwood.h>
 #include <mach/irqs.h>
-#include <plat/time.h>
-#include "common.h"
+#include <mach/time.h>
+#include "kirkwood.h"
 
 /*****************************************************************************
  * 512KB SPI Flash on Boot Device (MACRONIX MX25L4005)
diff --git a/arch/arm/mach-kirkwood/lacie_v2-common.h b/arch/arm/mach-orion/lacie_v2-common.h
similarity index 100%
rename from arch/arm/mach-kirkwood/lacie_v2-common.h
rename to arch/arm/mach-orion/lacie_v2-common.h
diff --git a/arch/arm/mach-orion5x/ls-chl-setup.c b/arch/arm/mach-orion/ls-chl-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/ls-chl-setup.c
rename to arch/arm/mach-orion/ls-chl-setup.c
index 0c9e413..48f0c39 100644
--- a/arch/arm/mach-orion5x/ls-chl-setup.c
+++ b/arch/arm/mach-orion/ls-chl-setup.c
@@ -23,8 +23,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 /*****************************************************************************
  * Linkstation LS-CHL Info
diff --git a/arch/arm/mach-orion5x/ls_hgl-setup.c b/arch/arm/mach-orion/ls_hgl-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/ls_hgl-setup.c
rename to arch/arm/mach-orion/ls_hgl-setup.c
index c1b5d8a..af617d8 100644
--- a/arch/arm/mach-orion5x/ls_hgl-setup.c
+++ b/arch/arm/mach-orion/ls_hgl-setup.c
@@ -22,8 +22,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 /*****************************************************************************
  * Linkstation LS-HGL Info
diff --git a/arch/arm/mach-orion5x/lsmini-setup.c b/arch/arm/mach-orion/lsmini-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/lsmini-setup.c
rename to arch/arm/mach-orion/lsmini-setup.c
index 949eaa8..52b2f9d 100644
--- a/arch/arm/mach-orion5x/lsmini-setup.c
+++ b/arch/arm/mach-orion/lsmini-setup.c
@@ -22,8 +22,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 /*****************************************************************************
  * Linkstation Mini Info
diff --git a/arch/arm/mach-dove/mpp.c b/arch/arm/mach-orion/mpp-dove.c
similarity index 98%
rename from arch/arm/mach-dove/mpp.c
rename to arch/arm/mach-orion/mpp-dove.c
index 7f70afc..fa36a48 100644
--- a/arch/arm/mach-dove/mpp.c
+++ b/arch/arm/mach-orion/mpp-dove.c
@@ -11,9 +11,9 @@
 #include <linux/kernel.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
-#include <plat/mpp.h>
+#include <mach/mpp.h>
 #include <mach/dove.h>
-#include "mpp.h"
+#include "mpp-dove.h"
 
 struct dove_mpp_grp {
 	int start;
diff --git a/arch/arm/mach-dove/mpp.h b/arch/arm/mach-orion/mpp-dove.h
similarity index 100%
rename from arch/arm/mach-dove/mpp.h
rename to arch/arm/mach-orion/mpp-dove.h
diff --git a/arch/arm/mach-kirkwood/mpp.c b/arch/arm/mach-orion/mpp-kirkwood.c
similarity index 93%
rename from arch/arm/mach-kirkwood/mpp.c
rename to arch/arm/mach-orion/mpp-kirkwood.c
index 0c6ad63..da21b1b 100644
--- a/arch/arm/mach-kirkwood/mpp.c
+++ b/arch/arm/mach-orion/mpp-kirkwood.c
@@ -12,9 +12,9 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
-#include <plat/mpp.h>
-#include "common.h"
-#include "mpp.h"
+#include <mach/mpp.h>
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 
 static unsigned int __init kirkwood_variant(void)
 {
diff --git a/arch/arm/mach-kirkwood/mpp.h b/arch/arm/mach-orion/mpp-kirkwood.h
similarity index 100%
rename from arch/arm/mach-kirkwood/mpp.h
rename to arch/arm/mach-orion/mpp-kirkwood.h
diff --git a/arch/arm/mach-mv78xx0/mpp.c b/arch/arm/mach-orion/mpp-mv78xx0.c
similarity index 92%
rename from arch/arm/mach-mv78xx0/mpp.c
rename to arch/arm/mach-orion/mpp-mv78xx0.c
index df50342..9d785d3 100644
--- a/arch/arm/mach-mv78xx0/mpp.c
+++ b/arch/arm/mach-orion/mpp-mv78xx0.c
@@ -11,10 +11,10 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <plat/mpp.h>
+#include <mach/mpp.h>
 #include <mach/hardware.h>
-#include "common.h"
-#include "mpp.h"
+#include "mv78xx0.h"
+#include "mpp-mv78xx0.h"
 
 static unsigned int __init mv78xx0_variant(void)
 {
diff --git a/arch/arm/mach-mv78xx0/mpp.h b/arch/arm/mach-orion/mpp-mv78xx0.h
similarity index 100%
rename from arch/arm/mach-mv78xx0/mpp.h
rename to arch/arm/mach-orion/mpp-mv78xx0.h
diff --git a/arch/arm/mach-orion5x/mpp.c b/arch/arm/mach-orion/mpp-orion5x.c
similarity index 93%
rename from arch/arm/mach-orion5x/mpp.c
rename to arch/arm/mach-orion/mpp-orion5x.c
index 5b70026..2706cfc 100644
--- a/arch/arm/mach-orion5x/mpp.c
+++ b/arch/arm/mach-orion/mpp-orion5x.c
@@ -12,9 +12,9 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <mach/hardware.h>
-#include <plat/mpp.h>
-#include "mpp.h"
-#include "common.h"
+#include <mach/mpp.h>
+#include "mpp-orion5x.h"
+#include "orion5x.h"
 
 static unsigned int __init orion5x_variant(void)
 {
diff --git a/arch/arm/mach-orion5x/mpp.h b/arch/arm/mach-orion/mpp-orion5x.h
similarity index 100%
rename from arch/arm/mach-orion5x/mpp.h
rename to arch/arm/mach-orion/mpp-orion5x.h
diff --git a/arch/arm/plat-orion/mpp.c b/arch/arm/mach-orion/mpp.c
similarity index 98%
rename from arch/arm/plat-orion/mpp.c
rename to arch/arm/mach-orion/mpp.c
index 3b1e17b..137c622 100644
--- a/arch/arm/plat-orion/mpp.c
+++ b/arch/arm/mach-orion/mpp.c
@@ -14,7 +14,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <mach/hardware.h>
-#include <plat/mpp.h>
+#include <mach/mpp.h>
 
 /* Address of the ith MPP control register */
 static __init unsigned long mpp_ctrl_addr(unsigned int i,
diff --git a/arch/arm/mach-orion5x/mss2-setup.c b/arch/arm/mach-orion/mss2-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/mss2-setup.c
rename to arch/arm/mach-orion/mss2-setup.c
index 65faaa3..529f745 100644
--- a/arch/arm/mach-orion5x/mss2-setup.c
+++ b/arch/arm/mach-orion/mss2-setup.c
@@ -27,8 +27,8 @@
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
 #include <mach/bridge-regs.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 #define MSS2_NOR_BOOT_BASE	0xff800000
 #define MSS2_NOR_BOOT_SIZE	SZ_256K
diff --git a/arch/arm/mach-orion5x/mv2120-setup.c b/arch/arm/mach-orion/mv2120-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/mv2120-setup.c
rename to arch/arm/mach-orion/mv2120-setup.c
index c87fde4..89e29de 100644
--- a/arch/arm/mach-orion5x/mv2120-setup.c
+++ b/arch/arm/mach-orion/mv2120-setup.c
@@ -22,8 +22,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 #define MV2120_NOR_BOOT_BASE	0xf4000000
 #define MV2120_NOR_BOOT_SIZE	SZ_512K
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-orion/mv78xx0.c
similarity index 98%
rename from arch/arm/mach-mv78xx0/common.c
rename to arch/arm/mach-orion/mv78xx0.c
index a5dcf766..a4bfa12 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-orion/mv78xx0.c
@@ -18,13 +18,13 @@
 #include <asm/mach/time.h>
 #include <mach/mv78xx0.h>
 #include <mach/bridge-regs.h>
-#include <plat/cache-feroceon-l2.h>
-#include <plat/ehci-orion.h>
-#include <plat/orion_nand.h>
-#include <plat/time.h>
-#include <plat/common.h>
-#include <plat/addr-map.h>
-#include "common.h"
+#include <mach/cache-feroceon-l2.h>
+#include <mach/ehci-orion.h>
+#include <mach/orion_nand.h>
+#include <mach/time.h>
+#include <mach/common.h>
+#include <mach/addr-map.h>
+#include "mv78xx0.h"
 
 static int get_tclk(void);
 
diff --git a/arch/arm/mach-mv78xx0/common.h b/arch/arm/mach-orion/mv78xx0.h
similarity index 100%
rename from arch/arm/mach-mv78xx0/common.h
rename to arch/arm/mach-orion/mv78xx0.h
diff --git a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c b/arch/arm/mach-orion/mv88f6281gtw_ge-setup.c
similarity index 98%
rename from arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
rename to arch/arm/mach-orion/mv88f6281gtw_ge-setup.c
index 85f6169..ec3a7b3 100644
--- a/arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c
+++ b/arch/arm/mach-orion/mv88f6281gtw_ge-setup.c
@@ -29,8 +29,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/kirkwood.h>
-#include "common.h"
-#include "mpp.h"
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 
 static struct mv643xx_eth_platform_data mv88f6281gtw_ge_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_NONE,
diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion/net2big-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/net2big-setup.c
rename to arch/arm/mach-orion/net2big-setup.c
index 0180c39..c56e1c4 100644
--- a/arch/arm/mach-orion5x/net2big-setup.c
+++ b/arch/arm/mach-orion/net2big-setup.c
@@ -25,8 +25,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 /*****************************************************************************
  * LaCie 2Big Network Info
diff --git a/arch/arm/mach-kirkwood/netspace_v2-setup.c b/arch/arm/mach-orion/netspace_v2-setup.c
similarity index 99%
rename from arch/arm/mach-kirkwood/netspace_v2-setup.c
rename to arch/arm/mach-orion/netspace_v2-setup.c
index e6bba01..3c5d210 100644
--- a/arch/arm/mach-kirkwood/netspace_v2-setup.c
+++ b/arch/arm/mach-orion/netspace_v2-setup.c
@@ -35,8 +35,8 @@
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
 #include <mach/leds-ns2.h>
-#include "common.h"
-#include "mpp.h"
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 #include "lacie_v2-common.h"
 
 /*****************************************************************************
diff --git a/arch/arm/mach-kirkwood/netxbig_v2-setup.c b/arch/arm/mach-orion/netxbig_v2-setup.c
similarity index 99%
rename from arch/arm/mach-kirkwood/netxbig_v2-setup.c
rename to arch/arm/mach-orion/netxbig_v2-setup.c
index 31ae8de..a5e443e 100644
--- a/arch/arm/mach-kirkwood/netxbig_v2-setup.c
+++ b/arch/arm/mach-orion/netxbig_v2-setup.c
@@ -33,8 +33,8 @@
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
 #include <mach/leds-netxbig.h>
-#include "common.h"
-#include "mpp.h"
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 #include "lacie_v2-common.h"
 
 /*****************************************************************************
diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-orion/openrd-setup.c
similarity index 98%
rename from arch/arm/mach-kirkwood/openrd-setup.c
rename to arch/arm/mach-orion/openrd-setup.c
index 7e99c3f..229b266 100644
--- a/arch/arm/mach-kirkwood/openrd-setup.c
+++ b/arch/arm/mach-orion/openrd-setup.c
@@ -20,9 +20,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include <plat/mvsdio.h>
-#include "common.h"
-#include "mpp.h"
+#include <mach/mvsdio.h>
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 
 static struct mtd_partition openrd_nand_parts[] = {
 	{
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion/orion5x.c
similarity index 98%
rename from arch/arm/mach-orion5x/common.c
rename to arch/arm/mach-orion/orion5x.c
index e2e9db4..8e0c16b 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion/orion5x.c
@@ -29,12 +29,12 @@
 #include <mach/bridge-regs.h>
 #include <mach/hardware.h>
 #include <mach/orion5x.h>
-#include <plat/orion_nand.h>
-#include <plat/ehci-orion.h>
-#include <plat/time.h>
-#include <plat/common.h>
-#include <plat/addr-map.h>
-#include "common.h"
+#include <mach/orion_nand.h>
+#include <mach/ehci-orion.h>
+#include <mach/time.h>
+#include <mach/common.h>
+#include <mach/addr-map.h>
+#include "orion5x.h"
 
 /*****************************************************************************
  * I/O Address Mapping
diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion/orion5x.h
similarity index 100%
rename from arch/arm/mach-orion5x/common.h
rename to arch/arm/mach-orion/orion5x.h
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion/pci-orion5x.c
similarity index 99%
rename from arch/arm/mach-orion5x/pci.c
rename to arch/arm/mach-orion/pci-orion5x.c
index cb19e16..a545ae0 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion/pci-orion5x.c
@@ -17,10 +17,10 @@
 #include <video/vga.h>
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
-#include <plat/pcie.h>
-#include <plat/addr-map.h>
+#include <mach/pcie.h>
+#include <mach/addr-map.h>
 #include <mach/orion5x.h>
-#include "common.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * Orion has one PCIe controller and one PCI controller.
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-orion/pcie-dove.c
similarity index 98%
rename from arch/arm/mach-dove/pcie.c
rename to arch/arm/mach-orion/pcie-dove.c
index 48a0320..57134be 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-orion/pcie-dove.c
@@ -15,11 +15,11 @@
 #include <asm/mach/arch.h>
 #include <asm/setup.h>
 #include <asm/delay.h>
-#include <plat/pcie.h>
+#include <mach/pcie.h>
 #include <mach/irqs.h>
 #include <mach/bridge-regs.h>
-#include <plat/addr-map.h>
-#include "common.h"
+#include <mach/addr-map.h>
+#include "dove.h"
 
 struct pcie_port {
 	u8			index;
diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-orion/pcie-kirkwood.c
similarity index 98%
rename from arch/arm/mach-kirkwood/pcie.c
rename to arch/arm/mach-orion/pcie-kirkwood.c
index f56a011..2b65cb4 100644
--- a/arch/arm/mach-kirkwood/pcie.c
+++ b/arch/arm/mach-orion/pcie-kirkwood.c
@@ -14,10 +14,10 @@
 #include <video/vga.h>
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
-#include <plat/pcie.h>
+#include <mach/pcie.h>
 #include <mach/bridge-regs.h>
-#include <plat/addr-map.h>
-#include "common.h"
+#include <mach/addr-map.h>
+#include "kirkwood.h"
 
 void kirkwood_enable_pcie(void)
 {
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-orion/pcie-mv78xx0.c
similarity index 99%
rename from arch/arm/mach-mv78xx0/pcie.c
rename to arch/arm/mach-orion/pcie-mv78xx0.c
index df3e380..c9616bf 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-orion/pcie-mv78xx0.c
@@ -13,9 +13,9 @@
 #include <video/vga.h>
 #include <asm/irq.h>
 #include <asm/mach/pci.h>
-#include <plat/pcie.h>
-#include <plat/addr-map.h>
-#include "common.h"
+#include <mach/pcie.h>
+#include <mach/addr-map.h>
+#include "mv78xx0.h"
 
 struct pcie_port {
 	u8			maj;
diff --git a/arch/arm/plat-orion/pcie.c b/arch/arm/mach-orion/pcie.c
similarity index 99%
rename from arch/arm/plat-orion/pcie.c
rename to arch/arm/mach-orion/pcie.c
index 86dbb5b..921333a 100644
--- a/arch/arm/plat-orion/pcie.c
+++ b/arch/arm/mach-orion/pcie.c
@@ -12,8 +12,8 @@
 #include <linux/pci.h>
 #include <linux/mbus.h>
 #include <asm/mach/pci.h>
-#include <plat/pcie.h>
-#include <plat/addr-map.h>
+#include <mach/pcie.h>
+#include <mach/addr-map.h>
 #include <linux/delay.h>
 
 /*
diff --git a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c b/arch/arm/mach-orion/rd78x00-masa-setup.c
similarity index 99%
rename from arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
rename to arch/arm/mach-orion/rd78x00-masa-setup.c
index 9a88270..1e53e29 100644
--- a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
+++ b/arch/arm/mach-orion/rd78x00-masa-setup.c
@@ -17,7 +17,7 @@
 #include <mach/mv78xx0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include "common.h"
+#include "mv78xx0.h"
 
 static struct mv643xx_eth_platform_data rd78x00_masa_ge00_data = {
 	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion/rd88f5181l-fxo-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
rename to arch/arm/mach-orion/rd88f5181l-fxo-setup.c
index 292038f..b5a5c8a 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion/rd88f5181l-fxo-setup.c
@@ -22,8 +22,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 /*****************************************************************************
  * RD-88F5181L FXO Info
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion/rd88f5181l-ge-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
rename to arch/arm/mach-orion/rd88f5181l-ge-setup.c
index c44eaba..9802382 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion/rd88f5181l-ge-setup.c
@@ -23,8 +23,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 /*****************************************************************************
  * RD-88F5181L GE Info
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion/rd88f5182-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/rd88f5182-setup.c
rename to arch/arm/mach-orion/rd88f5182-setup.c
index e3ce617..ac2fcaa 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion/rd88f5182-setup.c
@@ -24,8 +24,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 /*****************************************************************************
  * RD-88F5182 Info
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion/rd88f6183ap-ge-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
rename to arch/arm/mach-orion/rd88f6183ap-ge-setup.c
index 2c5fab0..25e5727 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion/rd88f6183ap-ge-setup.c
@@ -25,7 +25,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-#include "common.h"
+#include "orion5x.h"
 
 static struct mv643xx_eth_platform_data rd88f6183ap_ge_eth_data = {
 	.phy_addr	= -1,
diff --git a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c b/arch/arm/mach-orion/rd88f6192-nas-setup.c
similarity index 99%
rename from arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
rename to arch/arm/mach-orion/rd88f6192-nas-setup.c
index fd2c9c8..8f37693 100644
--- a/arch/arm/mach-kirkwood/rd88f6192-nas-setup.c
+++ b/arch/arm/mach-orion/rd88f6192-nas-setup.c
@@ -20,7 +20,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include "common.h"
+#include "kirkwood.h"
 
 #define RD88F6192_GPIO_USB_VBUS		10
 
diff --git a/arch/arm/mach-kirkwood/rd88f6281-setup.c b/arch/arm/mach-orion/rd88f6281-setup.c
similarity index 97%
rename from arch/arm/mach-kirkwood/rd88f6281-setup.c
rename to arch/arm/mach-orion/rd88f6281-setup.c
index ef92207..5dbdec9 100644
--- a/arch/arm/mach-kirkwood/rd88f6281-setup.c
+++ b/arch/arm/mach-orion/rd88f6281-setup.c
@@ -20,9 +20,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include <plat/mvsdio.h>
-#include "common.h"
-#include "mpp.h"
+#include <mach/mvsdio.h>
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 
 static struct mtd_partition rd88f6281_nand_parts[] = {
 	{
diff --git a/arch/arm/mach-kirkwood/sheevaplug-setup.c b/arch/arm/mach-orion/sheevaplug-setup.c
similarity index 98%
rename from arch/arm/mach-kirkwood/sheevaplug-setup.c
rename to arch/arm/mach-orion/sheevaplug-setup.c
index 4ea70e5f..5c128fa 100644
--- a/arch/arm/mach-kirkwood/sheevaplug-setup.c
+++ b/arch/arm/mach-orion/sheevaplug-setup.c
@@ -19,9 +19,9 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include <plat/mvsdio.h>
-#include "common.h"
-#include "mpp.h"
+#include <mach/mvsdio.h>
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 
 static struct mtd_partition sheevaplug_nand_parts[] = {
 	{
diff --git a/arch/arm/mach-kirkwood/t5325-setup.c b/arch/arm/mach-orion/t5325-setup.c
similarity index 98%
rename from arch/arm/mach-kirkwood/t5325-setup.c
rename to arch/arm/mach-orion/t5325-setup.c
index f9d2a11..7d7f5a0 100644
--- a/arch/arm/mach-kirkwood/t5325-setup.c
+++ b/arch/arm/mach-orion/t5325-setup.c
@@ -27,8 +27,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include "common.h"
-#include "mpp.h"
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 
 struct mtd_partition hp_t5325_partitions[] = {
 	{
diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion/terastation_pro2-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/terastation_pro2-setup.c
rename to arch/arm/mach-orion/terastation_pro2-setup.c
index 632a861..7dcb50e 100644
--- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
+++ b/arch/arm/mach-orion/terastation_pro2-setup.c
@@ -23,8 +23,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 /*****************************************************************************
  * Terastation Pro 2/Live Info
diff --git a/arch/arm/plat-orion/time.c b/arch/arm/mach-orion/time.c
similarity index 100%
rename from arch/arm/plat-orion/time.c
rename to arch/arm/mach-orion/time.c
diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion/ts209-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/ts209-setup.c
rename to arch/arm/mach-orion/ts209-setup.c
index 5d64087..3686739 100644
--- a/arch/arm/mach-orion5x/ts209-setup.c
+++ b/arch/arm/mach-orion/ts209-setup.c
@@ -26,8 +26,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 #include "tsx09-common.h"
 
 #define QNAP_TS209_NOR_BOOT_BASE 0xf4000000
diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-orion/ts219-setup.c
similarity index 98%
rename from arch/arm/mach-kirkwood/ts219-setup.c
rename to arch/arm/mach-orion/ts219-setup.c
index 73e2b6c..32b118d 100644
--- a/arch/arm/mach-kirkwood/ts219-setup.c
+++ b/arch/arm/mach-orion/ts219-setup.c
@@ -22,8 +22,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include "common.h"
-#include "mpp.h"
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 #include "tsx1x-common.h"
 
 static struct i2c_board_info __initdata qnap_ts219_i2c_rtc = {
diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion/ts409-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/ts409-setup.c
rename to arch/arm/mach-orion/ts409-setup.c
index 4e6ff75..de31108 100644
--- a/arch/arm/mach-orion5x/ts409-setup.c
+++ b/arch/arm/mach-orion/ts409-setup.c
@@ -28,8 +28,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 #include "tsx09-common.h"
 
 /*****************************************************************************
diff --git a/arch/arm/mach-kirkwood/ts41x-setup.c b/arch/arm/mach-orion/ts41x-setup.c
similarity index 98%
rename from arch/arm/mach-kirkwood/ts41x-setup.c
rename to arch/arm/mach-orion/ts41x-setup.c
index 5bbca26..d121b63 100644
--- a/arch/arm/mach-kirkwood/ts41x-setup.c
+++ b/arch/arm/mach-orion/ts41x-setup.c
@@ -23,12 +23,12 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
-#include "common.h"
-#include "mpp.h"
+#include "kirkwood.h"
+#include "mpp-kirkwood.h"
 #include "tsx1x-common.h"
 
 /* for the PCIe reset workaround */
-#include <plat/pcie.h>
+#include <mach/pcie.h>
 
 
 #define QNAP_TS41X_JUMPER_JP1	45
diff --git a/arch/arm/mach-orion5x/ts78xx-fpga.h b/arch/arm/mach-orion/ts78xx-fpga.h
similarity index 100%
rename from arch/arm/mach-orion5x/ts78xx-fpga.h
rename to arch/arm/mach-orion/ts78xx-fpga.h
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion/ts78xx-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/ts78xx-setup.c
rename to arch/arm/mach-orion/ts78xx-setup.c
index a74f3cf..4040a76 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion/ts78xx-setup.c
@@ -24,8 +24,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 #include "ts78xx-fpga.h"
 
 /*****************************************************************************
diff --git a/arch/arm/mach-orion5x/tsx09-common.c b/arch/arm/mach-orion/tsx09-common.c
similarity index 99%
rename from arch/arm/mach-orion5x/tsx09-common.c
rename to arch/arm/mach-orion/tsx09-common.c
index 7189827..ee3aaec 100644
--- a/arch/arm/mach-orion5x/tsx09-common.c
+++ b/arch/arm/mach-orion/tsx09-common.c
@@ -17,7 +17,7 @@
 #include <linux/serial_reg.h>
 #include <mach/orion5x.h>
 #include "tsx09-common.h"
-#include "common.h"
+#include "orion5x.h"
 
 /*****************************************************************************
  * QNAP TS-x09 specific power off method via UART1-attached PIC
diff --git a/arch/arm/mach-orion5x/tsx09-common.h b/arch/arm/mach-orion/tsx09-common.h
similarity index 100%
rename from arch/arm/mach-orion5x/tsx09-common.h
rename to arch/arm/mach-orion/tsx09-common.h
diff --git a/arch/arm/mach-kirkwood/tsx1x-common.c b/arch/arm/mach-orion/tsx1x-common.c
similarity index 99%
rename from arch/arm/mach-kirkwood/tsx1x-common.c
rename to arch/arm/mach-orion/tsx1x-common.c
index 24294b2..49c1d16 100644
--- a/arch/arm/mach-kirkwood/tsx1x-common.c
+++ b/arch/arm/mach-orion/tsx1x-common.c
@@ -7,7 +7,7 @@
 #include <linux/spi/orion_spi.h>
 #include <linux/serial_reg.h>
 #include <mach/kirkwood.h>
-#include "common.h"
+#include "kirkwood.h"
 
 /*
  * QNAP TS-x1x Boards flash
diff --git a/arch/arm/mach-kirkwood/tsx1x-common.h b/arch/arm/mach-orion/tsx1x-common.h
similarity index 100%
rename from arch/arm/mach-kirkwood/tsx1x-common.h
rename to arch/arm/mach-orion/tsx1x-common.h
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion/wnr854t-setup.c
similarity index 98%
rename from arch/arm/mach-orion5x/wnr854t-setup.c
rename to arch/arm/mach-orion/wnr854t-setup.c
index 078c03f..cf11e60 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion/wnr854t-setup.c
@@ -20,8 +20,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 static unsigned int wnr854t_mpp_modes[] __initdata = {
 	MPP0_GPIO,		/* Power LED green (0=on) */
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion/wrt350n-v2-setup.c
similarity index 99%
rename from arch/arm/mach-orion5x/wrt350n-v2-setup.c
rename to arch/arm/mach-orion/wrt350n-v2-setup.c
index 46a9778..a435be2 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion/wrt350n-v2-setup.c
@@ -23,8 +23,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/pci.h>
 #include <mach/orion5x.h>
-#include "common.h"
-#include "mpp.h"
+#include "orion5x.h"
+#include "mpp-orion5x.h"
 
 /*
  * LEDs attached to GPIO
diff --git a/arch/arm/mach-orion5x/Makefile.boot b/arch/arm/mach-orion5x/Makefile.boot
deleted file mode 100644
index 760a0ef..0000000
--- a/arch/arm/mach-orion5x/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y	+= 0x00008000
-params_phys-y	:= 0x00000100
-initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-orion5x/include/mach/gpio.h b/arch/arm/mach-orion5x/include/mach/gpio.h
deleted file mode 100644
index a1d0b78..0000000
--- a/arch/arm/mach-orion5x/include/mach/gpio.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/*
- * arch/arm/mach-orion5x/include/mach/gpio.h
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <plat/gpio.h>
diff --git a/arch/arm/mach-orion5x/include/mach/hardware.h b/arch/arm/mach-orion5x/include/mach/hardware.h
deleted file mode 100644
index 3957354..0000000
--- a/arch/arm/mach-orion5x/include/mach/hardware.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * arch/arm/mach-orion5x/include/mach/hardware.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-#include "orion5x.h"
-
-#endif
diff --git a/arch/arm/mach-orion5x/include/mach/timex.h b/arch/arm/mach-orion5x/include/mach/timex.h
deleted file mode 100644
index 4c69820..0000000
--- a/arch/arm/mach-orion5x/include/mach/timex.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * arch/arm/mach-orion5x/include/mach/timex.h
- *
- * Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#define CLOCK_TICK_RATE		(100 * HZ)
diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
index dd3d591..2ace351 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -16,7 +16,7 @@
 #include <linux/highmem.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
-#include <plat/cache-feroceon-l2.h>
+#include <mach/cache-feroceon-l2.h>
 
 /*
  * Low-level cache maintenance operations.
diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
deleted file mode 100644
index c20ce0f..0000000
--- a/arch/arm/plat-orion/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# Makefile for the linux kernel.
-#
-
-obj-y	:= irq.o pcie.o time.o common.o mpp.o addr-map.o
-obj-m	:=
-obj-n	:=
-obj-	:=
-
-obj-$(CONFIG_GENERIC_GPIO) += gpio.o
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index fa5d55f..425e972 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -25,7 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/memory.h>
-#include <plat/mv_xor.h>
+#include <mach/mv_xor.h>
 
 #include "dmaengine.h"
 #include "mv_xor.h"
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index eeb8cd1..7d2daff 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -24,7 +24,7 @@
 
 #include <asm/sizes.h>
 #include <asm/unaligned.h>
-#include <plat/mvsdio.h>
+#include <mach/mvsdio.h>
 
 #include "mvsdio.h"
 
diff --git a/drivers/mtd/nand/orion_nand.c b/drivers/mtd/nand/orion_nand.c
index 0f50ef3..407f43d 100644
--- a/drivers/mtd/nand/orion_nand.c
+++ b/drivers/mtd/nand/orion_nand.c
@@ -20,7 +20,7 @@
 #include <asm/io.h>
 #include <asm/sizes.h>
 #include <mach/hardware.h>
-#include <plat/orion_nand.h>
+#include <mach/orion_nand.h>
 
 static void orion_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 6c6a5a3..7b6eccb 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/mbus.h>
-#include <plat/ehci-orion.h>
+#include <mach/ehci-orion.h>
 
 #define rdl(off)	__raw_readl(hcd->regs + (off))
 #define wrl(off, val)	__raw_writel((val), hcd->regs + (off))
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 788aa15..a26bbb5 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -25,7 +25,7 @@
 #include <linux/io.h>
 #include <linux/spinlock.h>
 #include <mach/bridge-regs.h>
-#include <plat/orion_wdt.h>
+#include <mach/orion_wdt.h>
 
 /*
  * Watchdog timer block registers.
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 3cb9aa4..49db36c 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -20,7 +20,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-#include <plat/audio.h>
+#include <mach/audio.h>
 #include "kirkwood.h"
 
 #define DRV_NAME	"kirkwood-i2s"
diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index 80bd59c..778b1dd 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -17,7 +17,7 @@
 #include <linux/slab.h>
 #include <sound/soc.h>
 #include <mach/kirkwood.h>
-#include <plat/audio.h>
+#include <mach/audio.h>
 #include <asm/mach-types.h>
 #include "../codecs/cs42l51.h"
 
diff --git a/sound/soc/kirkwood/kirkwood-t5325.c b/sound/soc/kirkwood/kirkwood-t5325.c
index f898363..e3c7b32 100644
--- a/sound/soc/kirkwood/kirkwood-t5325.c
+++ b/sound/soc/kirkwood/kirkwood-t5325.c
@@ -16,7 +16,7 @@
 #include <linux/slab.h>
 #include <sound/soc.h>
 #include <mach/kirkwood.h>
-#include <plat/audio.h>
+#include <mach/audio.h>
 #include <asm/mach-types.h>
 #include "../codecs/alc5623.h"
 
