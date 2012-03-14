From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 14 Mar 2012 13:04:58 +0000
Subject: [PATCH 02/10] ARM: ux500: Initial Device Tree support for Snowball
In-Reply-To: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
References: <1331730306-11461-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1331730306-11461-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

This provides very basic Device Tree support for ST-Ericsson's
low-cost development platform, Snowball. If Device Tree for
ux500 is enabled and the correct board is configured within the
Device Tree blob, the correct *_init_machine() will be called.

This patch is based on some original work completed by:
  Niklas Hernaeus <niklas.hernaeus@linaro.org>

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Niklas Hernaeus <niklas.hernaeus@linaro.org>
---
 arch/arm/boot/dts/snowball.dts     |   31 +++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/Makefile.boot  |    1 +
 arch/arm/mach-ux500/board-mop500.c |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/snowball.dts

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
new file mode 100644
index 0000000..ebcff9a
--- /dev/null
+++ b/arch/arm/boot/dts/snowball.dts
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2011 ST-Ericsson AB
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+
+/ {
+	model = "Calao Systems Snowball platform with device tree";
+	compatible = "calaosystems,snowball-a9500";
+
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory {
+		reg = <0x00000000 0x20000000>;
+	};
+
+	soc-u9500 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+	};
+};
diff --git a/arch/arm/mach-ux500/Makefile.boot b/arch/arm/mach-ux500/Makefile.boot
index ff0a4b5..dd5cd00 100644
--- a/arch/arm/mach-ux500/Makefile.boot
+++ b/arch/arm/mach-ux500/Makefile.boot
@@ -2,3 +2,4 @@
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 
+dtb-$(CONFIG_MACH_SNOWBALL) += snowball.dtb
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 04afcdf..0fb5dfd 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -30,6 +30,9 @@
 #include <linux/gpio_keys.h>
 #include <linux/delay.h>
 
+#include <linux/of.h>
+#include <linux/of_platform.h>
+
 #include <linux/leds.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -738,3 +741,34 @@ MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= snowball_init_machine,
 MACHINE_END
+
+#ifdef CONFIG_MACH_UX500_DT
+static void __init u8500_init_machine(void)
+{
+	if (of_machine_is_compatible("calaosystems,snowball-a9500"))
+		return snowball_init_machine();
+	else if (of_machine_is_compatible("st-ericsson,hrefv60+"))
+		return hrefv60_init_machine();
+	else if (of_machine_is_compatible("st-ericsson,mop500"))
+		return mop500_init_machine();
+}
+
+static const char * u8500_dt_board_compat[] = {
+	"calaosystems,snowball-a9500",
+	"st-ericsson,hrefv60+",
+	"st-ericsson,u8500",
+	"st-ericsson,mop500",
+	NULL,
+};
+
+
+DT_MACHINE_START(U8500_DT, "ST-Ericsson U8500 platform (Device Tree Support)")
+	.map_io		= u8500_map_io,
+	.init_irq	= ux500_init_irq,
+	/* we re-use nomadik timer here */
+	.timer		= &ux500_timer,
+	.handle_irq	= gic_handle_irq,
+	.init_machine	= u8500_init_machine,
+	.dt_compat      = u8500_dt_board_compat,
+MACHINE_END
+#endif
-- 
1.7.5.4
