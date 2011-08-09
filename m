From: jason@lakedaemon.net (Jason Cooper)
Date: Tue,  9 Aug 2011 16:47:33 +0000
Subject: [PATCH 3/3 v2] RFC: arm: kirkwood: dreamplug fdt support
In-Reply-To: <cover.1312906908.git.jason@lakedaemon.net>
References: <cover.1312906908.git.jason@lakedaemon.net>
Message-ID: <4662b823dbc543bf9a3b6645a0d19804ac8a7d3e.1312906908.git.jason@lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do Not Apply!  Does not build!  This patch is just a conversation
starter to help me learn how to add devicetree support to arm
devices.

I chose the dreamplug because it isn't supported in mainline yet.

Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/kirkwood-dreamplug.dts |   64 ++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/Kconfig           |    6 ++-
 arch/arm/mach-kirkwood/Makefile.boot     |    2 +
 arch/arm/mach-kirkwood/dreamplug-setup.c |   15 +++++--
 4 files changed, 81 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-dreamplug.dts

diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
new file mode 100644
index 0000000..954d03f
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -0,0 +1,64 @@
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "marvell,kirkwood-dreamplug";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu at 0 {
+			compatible = "arm,arm926ejs";
+			reg = <0>;
+		};
+	};
+
+	rtc at f1000300 {
+		compatible = "marvell,mvrtc";
+		reg = <0xf1000300 0xXXX>;
+	};
+
+	spi at f1000600 {
+		compatible = "marvell,orion_spi";
+		reg = <0xf1000600 0xXXX>;
+	};
+
+	i2c at f1001000 {
+		compatible = "marvell,XXX";
+		reg = <0xf1001000 0xXXX>;
+	};
+
+	serial at f1002000 {
+		compatible = "marvell,serial8250";
+		reg = <0xf1002000 0xXXXX>;
+	};
+
+	serial at f1002100 {
+		compatible = "marvell,serial8250";
+		reg = <0xf1002100 0xXXXX>;
+	};
+
+	usb at f1050000 {
+		compatible = "marvell,orion-ehci";
+		reg = <0xf1050000 0xXXX>;
+	};
+
+	ethernet at f1070000 {
+		compatible = "marvell,XXX";
+		reg = <0xf1070000 0xXXXX>;
+	};
+
+	ethernet at f1074000 {
+		compatible = "marvell,XXX";
+		reg = <0xf1074000 0xXXXX>;
+	};
+
+	sata at f1080000 {
+		compatible = "marvell,sata_mv";
+		reg = <0xf1080000 0xXXXX>;
+	};
+
+	sdio at f1090000 {
+		compatible = "marvell,XXX";
+		reg = <0xf1090000 0xXXX>;
+	};
+};
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index e93c610..ea87090 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -45,10 +45,12 @@ config MACH_GURUPLUG
 	  Marvell GuruPlug Reference Board.
 
 config MACH_DREAMPLUG
-	bool "Marvell DreamPlug Reference Board"
+	bool "Marvell DreamPlug Reference Board (FDT Support)"
+	select USE_OF
 	help
 	  Say 'Y' here if you want your kernel to support the
-	  Marvell DreamPlug Reference Board.
+	  Marvell DreamPlug Reference Board using the Flattened
+	  Device Tree.
 
 config MACH_TS219
 	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
index 67039c3..53dbe1f 100644
--- a/arch/arm/mach-kirkwood/Makefile.boot
+++ b/arch/arm/mach-kirkwood/Makefile.boot
@@ -1,3 +1,5 @@
    zreladdr-y	:= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
+
+dtb-$(CONFIG_MACH_DREAMPLUG) += kirkwood-dreamplug.dtb
diff --git a/arch/arm/mach-kirkwood/dreamplug-setup.c b/arch/arm/mach-kirkwood/dreamplug-setup.c
index 981bc71..4128ab7 100644
--- a/arch/arm/mach-kirkwood/dreamplug-setup.c
+++ b/arch/arm/mach-kirkwood/dreamplug-setup.c
@@ -11,6 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
 #include <linux/mtd/partitions.h>
 #include <linux/ata_platform.h>
 #include <linux/mv643xx_eth.h>
@@ -110,6 +112,10 @@ static unsigned int dreamplug_mpp_config[] __initdata = {
 	0
 };
 
+static struct of_device_id dreamplug_dt_match_table[] __initdata = {
+	{ .compatible = "marvell,kirkwood-dreamplug", },
+};
+
 static void __init dreamplug_init(void)
 {
 	/*
@@ -131,14 +137,15 @@ static void __init dreamplug_init(void)
 	kirkwood_sdio_init(&dreamplug_mvsdio_data);
 
 	platform_device_register(&dreamplug_leds);
+	of_platform_populate(NULL, dreamplug_dt_match_table, NULL, NULL);
 }
 
-MACHINE_START(DREAMPLUG, "Marvell DreamPlug Reference Board")
-	/* Maintainer: Siddarth Gore <gores@marvell.com> */
-	.boot_params	= 0x00000100,
-	.init_machine	= dreamplug_init,
+MACHINE_START(DREAMPLUG, "Marvell DreamPlug (Flattened Device Tree)")
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_init_early,
 	.init_irq	= kirkwood_init_irq,
 	.timer		= &kirkwood_timer,
+	.init_machine	= dreamplug_init,
+	.dt_compat	= kirkwood_dt_board_compat,
+	.boot_params	= 0x00000100,
 MACHINE_END
-- 
1.7.0.4
