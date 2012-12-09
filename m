From: w@1wt.eu (Willy Tarreau)
Date: Sun, 9 Dec 2012 19:40:04 +0100
Subject: [PATCH v2] ARM: kirkwood: convert Guruplug Server Plus to use the
 device tree
In-Reply-To: <20121202234110.GM12509@titan.lakedaemon.net>
References: <20121202155124.GA30807@1wt.eu>
 <20121202230926.GJ12509@titan.lakedaemon.net> <20121202232226.GL30822@1wt.eu>
 <20121202234110.GM12509@titan.lakedaemon.net>
Message-ID: <20121209184004.GC28052@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Sun, Dec 02, 2012 at 06:41:10PM -0500, Jason Cooper wrote:
> On Mon, Dec 03, 2012 at 12:22:26AM +0100, Willy Tarreau wrote:
> > Since there are already pending changes for the merge window, I'll
> > rather resend it after the merge window when the changes are already
> > done, what do you think ?
> 
> Doesn't matter in this case, I'll handle any conflicts.  Please resend
> when ready.  You can just base off of v3.7-rc7, or v3.8 if it drops.

OK, I've updated it according to your comments and ensured it still
works on my GPSP.

I have based the patch on the ARM tree because it includes some dtsi
files that are needed by this patch. Please find it attached.

Best regards,
Willy

-------------- next part --------------
>From 075e116c6cb513af0e0b9d9167ddd47e1b084bca Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Sun, 9 Dec 2012 19:21:09 +0100
Subject: ARM: kirkwood: convert Guruplug Server Plus to device tree

Add a device tree entry for the Guruplug Server Plus board. This port
was based both on the work done on the dreamplug and the dockstar.

It builds, boots and works on my Guruplug Server Plus.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/arm/boot/dts/Makefile                         |  1 +
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts | 94 ++++++++++++++++++++++
 arch/arm/mach-kirkwood/Kconfig                     |  7 ++
 arch/arm/mach-kirkwood/Makefile                    |  1 +
 arch/arm/mach-kirkwood/board-dt.c                  |  4 +
 arch/arm/mach-kirkwood/board-guruplug.c            | 39 +++++++++
 arch/arm/mach-kirkwood/common.h                    |  5 ++
 7 files changed, 151 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
 create mode 100644 arch/arm/mach-kirkwood/board-guruplug.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index da15d69..0674409 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -40,6 +40,7 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
 	kirkwood-dockstar.dtb \
 	kirkwood-dreamplug.dtb \
 	kirkwood-goflexnet.dtb \
+	kirkwood-guruplug-server-plus.dtb \
 	kirkwood-ib62x0.dtb \
 	kirkwood-iconnect.dtb \
 	kirkwood-iomega_ix2_200.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
new file mode 100644
index 0000000..a1c1d1e
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
@@ -0,0 +1,94 @@
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+/include/ "kirkwood-6281.dtsi"
+
+/ {
+	model = "Globalscale Technologies Guruplug Server Plus";
+	compatible = "globalscale,guruplug-server-plug", "globalscale,guruplug", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp at f1000000 {
+		pinctrl: pinctrl at 10000 {
+
+			pinctrl-0 = < &pmx_led_health_r &pmx_led_health_g
+				      &pmx_led_wmode_r &pmx_led_wmode_g >;
+			pinctrl-names = "default";
+
+			pmx_led_health_r: pmx-led-health-r {
+				marvell,pins = "mpp46";
+				marvell,function = "gpio";
+			};
+			pmx_led_health_g: pmx-led-health-g {
+				marvell,pins = "mpp47";
+				marvell,function = "gpio";
+			};
+			pmx_led_wmode_r: pmx-led-wmode-r {
+				marvell,pins = "mpp48";
+				marvell,function = "gpio";
+			};
+			pmx_led_wmode_g: pmx-led-wmode-g {
+				marvell,pins = "mpp49";
+				marvell,function = "gpio";
+			};
+		};
+		serial at 12000 {
+			clock-frequency = <200000000>;
+			status = "ok";
+		};
+
+		nand at 3000000 {
+			status = "okay";
+
+			partition at 0 {
+				label = "u-boot";
+				reg = <0x00000000 0x00100000>;
+				read-only;
+			};
+
+			partition at 100000 {
+				label = "uImage";
+				reg = <0x00100000 0x00400000>;
+			};
+
+			partition at 500000 {
+				label = "data";
+				reg = <0x00500000 0x1fb00000>;
+			};
+		};
+
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <1>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		health-r {
+			label = "guruplug:red:health";
+			gpios = <&gpio1 14 1>;
+		};
+		health-g {
+			label = "guruplug:green:health";
+			gpios = <&gpio1 15 1>;
+		};
+		wmode-r {
+			label = "guruplug:red:wmode";
+			gpios = <&gpio1 16 1>;
+		};
+		wmode-g {
+			label = "guruplug:green:wmode";
+			gpios = <&gpio1 17 1>;
+		};
+	};
+};
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index f91cdff..7b6a64b 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -58,6 +58,13 @@ config ARCH_KIRKWOOD_DT
 	  Say 'Y' here if you want your kernel to support the
 	  Marvell Kirkwood using flattened device tree.
 
+config MACH_GURUPLUG_DT
+	bool "Marvell GuruPlug Reference Board (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Marvell GuruPlug Reference Board (Flattened Device Tree).
+
 config MACH_DREAMPLUG_DT
 	bool "Marvell DreamPlug (Flattened Device Tree)"
 	select ARCH_KIRKWOOD_DT
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 8d2e5a9..e0b7600 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_MACH_T5325)		+= t5325-setup.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_ARCH_KIRKWOOD_DT)		+= board-dt.o
 obj-$(CONFIG_MACH_DREAMPLUG_DT)		+= board-dreamplug.o
+obj-$(CONFIG_MACH_GURUPLUG_DT)		+= board-guruplug.o
 obj-$(CONFIG_MACH_ICONNECT_DT)		+= board-iconnect.o
 obj-$(CONFIG_MACH_DLINK_KIRKWOOD_DT)	+= board-dnskw.o
 obj-$(CONFIG_MACH_IB62X0_DT)		+= board-ib62x0.o
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index ff4150a..1dac98d 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -101,6 +101,9 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("globalscale,dreamplug"))
 		dreamplug_init();
 
+	if (of_machine_is_compatible("globalscale,guruplug"))
+		guruplug_dt_init();
+
 	if (of_machine_is_compatible("dlink,dns-kirkwood"))
 		dnskw_init();
 
@@ -152,6 +155,7 @@ static void __init kirkwood_dt_init(void)
 
 static const char * const kirkwood_dt_board_compat[] = {
 	"globalscale,dreamplug",
+	"globalscale,guruplug",
 	"dlink,dns-320",
 	"dlink,dns-325",
 	"iom,iconnect",
diff --git a/arch/arm/mach-kirkwood/board-guruplug.c b/arch/arm/mach-kirkwood/board-guruplug.c
new file mode 100644
index 0000000..0a0df45
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-guruplug.c
@@ -0,0 +1,39 @@
+/*
+ * arch/arm/mach-kirkwood/board-guruplug.c
+ *
+ * Marvell Guruplug Reference Board Init for drivers not converted to
+ * flattened device tree yet.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/gpio.h>
+#include <linux/platform_data/mmc-mvsdio.h>
+#include "common.h"
+
+static struct mv643xx_eth_platform_data guruplug_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(0),
+};
+
+static struct mv643xx_eth_platform_data guruplug_ge01_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(1),
+};
+
+static struct mvsdio_platform_data guruplug_mvsdio_data = {
+	/* unfortunately the CD signal has not been connected */
+};
+
+void __init guruplug_dt_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_ge00_init(&guruplug_ge00_data);
+	kirkwood_ge01_init(&guruplug_ge01_data);
+	kirkwood_sdio_init(&guruplug_mvsdio_data);
+}
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 5ffa57f..e9ae919 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -59,6 +59,11 @@ void dreamplug_init(void);
 #else
 static inline void dreamplug_init(void) {};
 #endif
+#ifdef CONFIG_MACH_GURUPLUG_DT
+void guruplug_dt_init(void);
+#else
+static inline void guruplug_dt_init(void) {};
+#endif
 #ifdef CONFIG_MACH_TS219_DT
 void qnap_dt_ts219_init(void);
 #else
-- 
1.7.12.2.21.g234cd45.dirty
