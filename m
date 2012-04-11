From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 10 Apr 2012 20:43:24 -0400
Subject: [PATCH V3 1/5] ARM: kirkwood: Basic support for DNS-320 and
 DNS-325
In-Reply-To: <alpine.DEB.2.00.1204091418400.23719@marmot.wormnet.eu>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
 <1332885255-8304-2-git-send-email-jm@lentin.co.uk>
 <20120406234955.840F73E1323@localhost>
 <alpine.DEB.2.00.1204091418400.23719@marmot.wormnet.eu>
Message-ID: <20120411004324.GB14790@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2012 at 02:20:26PM +0100, Jamie Lentin wrote:
> On Fri, 6 Apr 2012, Grant Likely wrote:
> 
> >On Tue, 27 Mar 2012 22:54:11 +0100, Jamie Lentin <jm@lentin.co.uk> wrote:
> >>Add support for the DNS-320 and DNS-325. Describe as much as currently possible
> >>in the devicetree files, create a board-dnskw.c for everything else.
> >>
> >>Use IEEE-compliant "okay", rather than "ok"
> >>
> >>Acked-by: Arnd Bergmann <arnd@arndb.de>
> >>Acked-by: Jason Cooper <jason@lakedaemon.net>
> >>Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> >>---
> >> arch/arm/boot/dts/kirkwood-dns320.dts |   29 +++
> >> arch/arm/boot/dts/kirkwood-dns325.dts |   24 +++
> >> arch/arm/mach-kirkwood/Kconfig        |   23 +++
> >> arch/arm/mach-kirkwood/Makefile       |    1 +
> >> arch/arm/mach-kirkwood/Makefile.boot  |    2 +
> >> arch/arm/mach-kirkwood/board-dnskw.c  |  306 +++++++++++++++++++++++++++++++++
> >> arch/arm/mach-kirkwood/board-dt.c     |    5 +
> >> arch/arm/mach-kirkwood/common.h       |    6 +
> >> 8 files changed, 396 insertions(+), 0 deletions(-)
> >> create mode 100644 arch/arm/boot/dts/kirkwood-dns320.dts
> >> create mode 100644 arch/arm/boot/dts/kirkwood-dns325.dts
> >> create mode 100644 arch/arm/mach-kirkwood/board-dnskw.c
> >>
> >>diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/kirkwood-dns320.dts
> >>new file mode 100644
> >>index 0000000..78c834f
> >>--- /dev/null
> >>+++ b/arch/arm/boot/dts/kirkwood-dns320.dts
> >>@@ -0,0 +1,29 @@
> >>+/dts-v1/;
> >>+
> >>+/include/ "kirkwood.dtsi"
> >>+
> >>+/ {
> >>+	model = "D-Link DNS-320 NAS (Rev A1)";
> >>+	compatible = "dlink,dns-320-a1", "dlink,dns-320", "dlink,dns-kirkwood", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
> >>+
> >>+	memory {
> >>+		device_type = "memory";
> >>+		reg = <0x00000000 0x8000000>;
> >>+	};
> >>+
> >>+	chosen {
> >>+		bootargs = "console=ttyS0,115200n8 earlyprintk";
> >>+	};
> >>+
> >>+	ocp at f1000000 {
> >>+		serial at 12000 {
> >>+			clock-frequency = <166666667>;
> >>+			status = "okay";
> >>+		};
> >>+
> >>+		serial at 12100 {
> >>+			clock-frequency = <166666667>;
> >>+			status = "okay";
> >>+		};
> >>+	};
> >>+};
> >>diff --git a/arch/arm/boot/dts/kirkwood-dns325.dts b/arch/arm/boot/dts/kirkwood-dns325.dts
> >>new file mode 100644
> >>index 0000000..23241ab
> >>--- /dev/null
> >>+++ b/arch/arm/boot/dts/kirkwood-dns325.dts
> >>@@ -0,0 +1,24 @@
> >>+/dts-v1/;
> >>+
> >>+/include/ "kirkwood.dtsi"
> >>+
> >>+/ {
> >>+	model = "D-Link DNS-325 NAS (Rev A1)";
> >>+	compatible = "dlink,dns-325-a1", "dlink,dns-325", "dlink,dns-kirkwood", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
> >>+
> >>+	memory {
> >>+		device_type = "memory";
> >>+		reg = <0x00000000 0x10000000>;
> >>+	};
> >>+
> >>+	chosen {
> >>+		bootargs = "console=ttyS0,115200n8 earlyprintk";
> >>+	};
> >>+
> >>+	ocp at f1000000 {
> >>+		serial at 12000 {
> >>+			clock-frequency = <200000000>;
> >>+			status = "okay";
> >>+		};
> >>+	};
> >>+};
> >>diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> >>index 90ceab7..d594b6e 100644
> >>--- a/arch/arm/mach-kirkwood/Kconfig
> >>+++ b/arch/arm/mach-kirkwood/Kconfig
> >>@@ -58,6 +58,29 @@ config MACH_DREAMPLUG_DT
> >> 	  Say 'Y' here if you want your kernel to support the
> >> 	  Marvell DreamPlug (Flattened Device Tree).
> >>
> >>+config MACH_DNSKW_DT
> >>+        bool
> >>+
> >>+config MACH_DNS320_DT
> >>+	bool "D-Link DNS-320 (Flattened Device Tree)"
> >>+	select ARCH_KIRKWOOD_DT
> >>+	select MACH_DNSKW_DT
> >>+	select CONFIG_MTD_OF_PARTS
> >>+	select CONFIG_SERIAL_OF_PLATFORM
> >
> >These two lines are dangerous.  It is not safe to 'select' Kconfig
> >symbols that have 'depends' constraints.  Otherwise, the symbol will
> >get forced on without it's dependencies.
> >
> >Typically other code handles this by creating blank "HAVE_*" symbols
> >that the needed symbol can do something like "default y if HAVE_*"
> >
> 
> Okay I didn't realise this, thanks. The options in question aren't
> hard dependencies per-se, but no serial or NAND support is probably a
> mistake, so added them here to avoid a certain amount of shooting in foot.
> 
> What's the etiquette in this situation? Adding HAVE_* seems excessive,
> would selecting them in kirkwood_defconfig make more sense? Or would it
> simply be covered by having a reasonable config on my website or suchlike?

The latter sounds good.  kirkwood_defconfig is in need of some love, and
I haven't had time to get to it.

> Jason, given you've already applied this patch, would you rather me
> submit something else to ditch these, or resumbit the entire series,
> combining feedback?

I only applied it locally, I was waiting for comments like this before
doing a pull request.  Go ahead and redo the series based on the input
and repost.  I'll replace what I have.

> 
> >>+	help
> >>+	  Say 'Y' here if you want your kernel to support the
> >>+	  D-Link DNS-320 NAS, using Flattened Device Tree.
> >>+
> >>+config MACH_DNS325_DT
> >>+	bool "D-Link DNS-325 (Flattened Device Tree)"
> >>+	select ARCH_KIRKWOOD_DT
> >>+	select MACH_DNSKW_DT
> >>+	select CONFIG_MTD_OF_PARTS
> >>+	select CONFIG_SERIAL_OF_PLATFORM
> >>+	help
> >>+	  Say 'Y' here if you want your kernel to support the
> >>+	  D-Link DNS-325 NAS, using Flattened Device Tree.
> >>+
> >
> >The *only* difference between these two configs is the .dtb file that
> >gets built.  Don't create a separate Kconfig entry for each dnskw
> >board.  Just build all the dnskw dtb files when MACH_DNSKW_DT is
> >selected.  Building .dtb files is cheap.
> >
> 
> The rationale for this is the code in dnskw.c is (hopefully!) temporary,
> and when it goes there isn't any need for MACH_DNSKW_DT either.
> 
> In a future land where everything has been converted to devicetree, what
> would be best? An option to "Build all kirkwood-based .dtb's", an option
> to build all D-link .dtb's, Q-QNAP .dtb's, etc. or an option for each
> board? I've not got any strong opinion, so will reformat the above to
> whatever is considered best.

Based on Grant's comment, I'll probably be working towards a
MACH_GLOBALSCALE_DT option to catch dreamplug,sheevaplug,guruplug, etc.
Perhaps this should be MACH_BUFFALO_DT?

> >> config MACH_TS219
> >> 	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
> >> 	help
> >>diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> >>index e299a95..b092af5 100644
> >>--- a/arch/arm/mach-kirkwood/Makefile
> >>+++ b/arch/arm/mach-kirkwood/Makefile
> >>@@ -22,3 +22,4 @@ obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
> >> obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
> >> obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
> >> obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
> >>+obj-$(CONFIG_MACH_DNSKW_DT)		+= board-dnskw.o
> >>diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
> >>index 16f9385..9c5e45f 100644
> >>--- a/arch/arm/mach-kirkwood/Makefile.boot
> >>+++ b/arch/arm/mach-kirkwood/Makefile.boot
> >>@@ -3,3 +3,5 @@ params_phys-y	:= 0x00000100
> >> initrd_phys-y	:= 0x00800000
> >>
> >> dtb-$(CONFIG_MACH_DREAMPLUG_DT) += kirkwood-dreamplug.dtb
> >>+dtb-$(CONFIG_MACH_DNS320_DT) += kirkwood-dns320.dtb
> >>+dtb-$(CONFIG_MACH_DNS325_DT) += kirkwood-dns325.dtb
> >>diff --git a/arch/arm/mach-kirkwood/board-dnskw.c b/arch/arm/mach-kirkwood/board-dnskw.c
> >>new file mode 100644
> >>index 0000000..7cb7f6a
> >>--- /dev/null
> >>+++ b/arch/arm/mach-kirkwood/board-dnskw.c
> >>@@ -0,0 +1,306 @@
> >>+/*
> >>+ * Copyright 2012 (C), Jamie Lentin <jm@lentin.co.uk>
> >>+ *
> >>+ * arch/arm/mach-kirkwood/board-dnskw.c
> >>+ *
> >>+ * D-link DNS-320 & DNS-325 NAS Init for drivers not converted to
> >>+ * flattened device tree yet.
> >>+ *
> >>+ * This file is licensed under the terms of the GNU General Public
> >>+ * License version 2.  This program is licensed "as is" without any
> >>+ * warranty of any kind, whether express or implied.
> >>+ */
> >>+
> >>+#include <linux/kernel.h>
> >>+#include <linux/init.h>
> >>+#include <linux/platform_device.h>
> >>+#include <linux/i2c.h>
> >>+#include <linux/ata_platform.h>
> >>+#include <linux/mv643xx_eth.h>
> >>+#include <linux/of.h>
> >>+#include <linux/gpio.h>
> >>+#include <linux/input.h>
> >>+#include <linux/gpio_keys.h>
> >>+#include <linux/gpio-fan.h>
> >>+#include <linux/leds.h>
> >>+#include <linux/mtd/physmap.h>
> >>+#include <asm/mach-types.h>
> >>+#include <asm/mach/arch.h>
> >>+#include <asm/mach/map.h>
> >>+#include <mach/kirkwood.h>
> >>+#include <mach/bridge-regs.h>
> >>+#include "common.h"
> >>+#include "mpp.h"
> >>+
> >>+static struct mtd_partition dnskw_nand_parts[] = {
> >>+	{
> >>+		.name		= "u-boot",
> >>+		.offset		= 0,
> >>+		.size		= SZ_1M,
> >>+		.mask_flags	= MTD_WRITEABLE
> >>+	}, {
> >>+		.name		= "uImage",
> >>+		.offset		= MTDPART_OFS_NXTBLK,
> >>+		.size		= 5 * SZ_1M
> >>+	}, {
> >>+		.name		= "ramdisk",
> >>+		.offset		= MTDPART_OFS_NXTBLK,
> >>+		.size		= 5 * SZ_1M
> >>+	}, {
> >>+		.name		= "image",
> >>+		.offset		= MTDPART_OFS_NXTBLK,
> >>+		.size		= 102 * SZ_1M
> >>+	}, {
> >>+		.name		= "mini firmware",
> >>+		.offset		= MTDPART_OFS_NXTBLK,
> >>+		.size		= 10 * SZ_1M
> >>+	}, {
> >>+		.name		= "config",
> >>+		.offset		= MTDPART_OFS_NXTBLK,
> >>+		.size		= 5 * SZ_1M
> >>+	},
> >>+};
> >
> >This patch adds a static partition mapping, and then a later patch in
> >this same series removes it again.  Please don't do that.  Just squash
> >the patches together.  Or, if sqashing is not appropriate, then just
> >omit the partitions.
> >
> >I also suggest omiting similar data when there are patches already in
> >progess to do it properly.  It is okay for the inital support to go in
> >to be incomplete when enhancements will be ready soon.
> >
> 
> Noted. If the entire patchset needs resubmitting, I'll combine the patch
> that moves this definition to the .dtb

See my comment in my other reply, just don't add nand/partition support
in the beginning.

thx,

Jason.
