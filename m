From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 31 Dec 2012 12:23:54 +0100 (CET)
Subject: [PATCH 2/2] ARM: shmobile: add a reference DT implementation for
 mackerel
In-Reply-To: <Pine.LNX.4.64.1212311213510.24596@axis700.grange>
References: <Pine.LNX.4.64.1212311213510.24596@axis700.grange>
Message-ID: <Pine.LNX.4.64.1212311214370.24596@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DT-only mackerel implementation. So far it only contains a limited
set of devices, already implementing DT support. As more drivers are
extended with DT initialisation option, respective devices shall be added
to sh7372-mackerel-reference.dts.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Some notes:

1. since INTCS isn't currently supported, no peripherals, whose interrupts 
are routed to it, can be used, e.g. I2C0, TMU.

2. MMCIF and SDHI device nodes in .dts lack card-detect and write-protect 
GPIOs because of missing pinctrl support on sh7372.

3. on mackerel MMCIF and SDHI1 share one slot. A micro-switch is used to 
switch between the two interfaces and a jumper can be used to switch 
between 1.8 and 3.3V. This patch enables both interfaces simultaneously 
and sets voltage on both of them to 1.8V. If desired, this can be changed 
to specify 3.3V on the SDHI1 device and expect the used to switch the 
jumper.

4. patches are based on a recent (of 28.12) Linus' tree + shmobile patches 
from

http://git.kernel.org/?p=linux/kernel/git/horms/renesas.git;a=shortlog;h=refs/heads/devel/intc-of

plus my earlier patch to add DT-specific clock lookup entries to 
clock-sh7372.c, currently in -next:

http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commit;h=d5ffbe1dfdb7963d29cfbfa0f2d0e4becba32d5b

 arch/arm/boot/dts/Makefile                        |    3 +-
 arch/arm/boot/dts/sh7372-mackerel-reference.dts   |  131 +++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                    |    8 ++
 arch/arm/mach-shmobile/Makefile                   |    1 +
 arch/arm/mach-shmobile/board-mackerel-reference.c |  122 +++++++++++++++++++
 5 files changed, 264 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/sh7372-mackerel-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-mackerel-reference.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e44da40..7fb4696 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -123,7 +123,8 @@ dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7740-armadillo800eva.dtb \
 	sh73a0-kzm9g.dtb \
-	sh7372-mackerel.dtb
+	sh7372-mackerel.dtb \
+	sh7372-mackerel-reference.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
 	spear1340-evb.dtb
 dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
diff --git a/arch/arm/boot/dts/sh7372-mackerel-reference.dts b/arch/arm/boot/dts/sh7372-mackerel-reference.dts
new file mode 100644
index 0000000..2fd1eff
--- /dev/null
+++ b/arch/arm/boot/dts/sh7372-mackerel-reference.dts
@@ -0,0 +1,131 @@
+/*
+ * Device Tree Source for the mackerel board
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "sh7372.dtsi"
+
+/ {
+	model = "Mackerel (AP4 EVM 2nd)";
+	compatible = "renesas,mackerel-reference";
+
+	memory {
+		device_type = "memory";
+		reg = <0x40000000 0x10000000>;
+	};
+
+	reg_1p8v: regulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "1P8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator at 1 {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	lan9220 at 14000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x14000000 0x2000000>;
+		phy-mode = "mii";
+		interrupt-parent = <&intca_irq_pins_lo>;
+		interrupts = <0x2c0>;
+		reg-io-width = <4>;
+		smsc,irq-push-pull;
+		smsc,save-mac-address;
+		vddvario-supply = <&reg_1p8v>;
+		vdd33a-supply = <&reg_3p3v>;
+	};
+
+	i2c1: i2c at e6c20000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xe6c20000 0x1000>;
+		interrupt-parent = <&intca>;
+		interrupts = <0x780 0x7a0 0x7c0 0x7e0>;
+
+		clock-frequency = <100000>;
+
+		accelerometer at 53 {
+			compatible = "analog-devices,adxl34x";
+			reg = <0x53>;
+			interrupt-parent = <&intca_irq_pins_hi>;
+			interrupts = <0x32a0>;
+		};
+	};
+
+	mmcif0: mmcif at 0xe6bd0000 {
+		compatible = "renesas,sh-mmcif", "renesas,sh7372-mmcif";
+		reg = <0xe6bd0000 0x100>;
+		interrupt-parent = <&intca>;
+		interrupts = <0x1ac0 0x1ae0>;
+		vmmc-supply = <&reg_1p8v>;
+	};
+
+	sdhi0: sdhi at 0xe6850000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xe6850000 0x100>;
+		interrupt-parent = <&intca>;
+		interrupts = <0x0e00 0x0e20 0x0e40>;
+		vmmc-supply = <&reg_3p3v>;
+	};
+
+	sdhi1: sdhi at 0xe6860000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xe6860000 0x100>;
+		interrupt-parent = <&intca>;
+		interrupts = <0x0e80 0x0ea0 0x0ec0>;
+		vmmc-supply = <&reg_1p8v>;
+	};
+
+	sdhi2: sdhi at 0xe6870000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xe6870000 0x100>;
+		interrupt-parent = <&intca>;
+		interrupts = <0x1200 0x1220 0x1240>;
+		vmmc-supply = <&reg_3p3v>;
+	};
+
+	flash at 2000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-flash";
+		reg = <0x20000000 0x8000000>;
+		bank-width = <2>;
+		partition at 0 {
+			label = "loader";
+			reg = <0 0x80000>;
+		};
+		partition at 1 {
+			label = "bootenv";
+			reg = <0x80000 0x80000>;
+		};
+		partition at 2 {
+			label = "kernel_ro";
+			reg = <0x100000 0x800000>;
+		};
+		partition at 3 {
+			label = "kernel";
+			reg = <0x900000 0x800000>;
+		};
+		partition at 4 {
+			label = "data";
+			reg = <0x1100000 0x6f00000>;
+		};
+	};
+};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 9255546..c25784b 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -76,6 +76,14 @@ config MACH_MACKEREL
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
 	select USE_OF
 
+config MACH_MACKEREL_REFERENCE
+	bool "mackerel board - Reference Device Tree Implementation"
+	depends on ARCH_SH7372
+	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SND_SOC_AK4642 if SND_SIMPLE_CARD
+	select USE_OF
+
 config MACH_KOTA2
 	bool "KOTA2 board"
 	depends on ARCH_SH73A0
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 0b71479..8035165 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
 obj-$(CONFIG_MACH_AP4EVB)	+= board-ap4evb.o
 obj-$(CONFIG_MACH_AG5EVM)	+= board-ag5evm.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
+obj-$(CONFIG_MACH_MACKEREL_REFERENCE)	+= board-mackerel-reference.o
 obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.o
 obj-$(CONFIG_MACH_BONITO)	+= board-bonito.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
diff --git a/arch/arm/mach-shmobile/board-mackerel-reference.c b/arch/arm/mach-shmobile/board-mackerel-reference.c
new file mode 100644
index 0000000..1d83653
--- /dev/null
+++ b/arch/arm/mach-shmobile/board-mackerel-reference.c
@@ -0,0 +1,122 @@
+/*
+ * mackerel board support - Reference Device Tree Implementation
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * Copyright (C) 2010 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * based on ap4evb
+ * Copyright (C) 2010  Magnus Damm
+ * Copyright (C) 2008  Yoshihiro Shimoda
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+
+#include <mach/common.h>
+#include <mach/irqs.h>
+#include <mach/sh7372.h>
+
+#include <asm/mach/arch.h>
+
+#define IRQ7 evt2irq(0x02e0)
+#define IRQ21 evt2irq(0x32a0)
+
+static void __init mackerel_init(void)
+{
+	sh7372_add_standard_devices_dt();
+
+	/* External clock source */
+	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
+
+	sh7372_pinmux_init();
+
+	/* enable SCIFA0 */
+	gpio_request(GPIO_FN_SCIFA0_TXD, NULL);
+	gpio_request(GPIO_FN_SCIFA0_RXD, NULL);
+
+	/* enable SMSC911X */
+	gpio_request(GPIO_FN_CS5A,	NULL);
+	gpio_request(GPIO_FN_IRQ6_39,	NULL);
+
+	/* enable Touchscreen */
+	gpio_request(GPIO_FN_IRQ7_40,	NULL);
+	irq_set_irq_type(IRQ7, IRQ_TYPE_LEVEL_LOW);
+
+	/* enable Accelerometer */
+	gpio_request(GPIO_FN_IRQ21,	NULL);
+	irq_set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);
+
+	/* enable SDHI0 */
+	gpio_request(GPIO_FN_SDHIWP0, NULL);
+	gpio_request(GPIO_FN_SDHICMD0, NULL);
+	gpio_request(GPIO_FN_SDHICLK0, NULL);
+	gpio_request(GPIO_FN_SDHID0_3, NULL);
+	gpio_request(GPIO_FN_SDHID0_2, NULL);
+	gpio_request(GPIO_FN_SDHID0_1, NULL);
+	gpio_request(GPIO_FN_SDHID0_0, NULL);
+
+	/* SDHI0 PORT172 card-detect IRQ26 */
+	gpio_request(GPIO_FN_IRQ26_172, NULL);
+
+	/* enable SDHI1 */
+	gpio_request(GPIO_FN_SDHICMD1, NULL);
+	gpio_request(GPIO_FN_SDHICLK1, NULL);
+	gpio_request(GPIO_FN_SDHID1_3, NULL);
+	gpio_request(GPIO_FN_SDHID1_2, NULL);
+	gpio_request(GPIO_FN_SDHID1_1, NULL);
+	gpio_request(GPIO_FN_SDHID1_0, NULL);
+
+	/* enable SDHI2 */
+	gpio_request(GPIO_FN_SDHICMD2, NULL);
+	gpio_request(GPIO_FN_SDHICLK2, NULL);
+	gpio_request(GPIO_FN_SDHID2_3, NULL);
+	gpio_request(GPIO_FN_SDHID2_2, NULL);
+	gpio_request(GPIO_FN_SDHID2_1, NULL);
+	gpio_request(GPIO_FN_SDHID2_0, NULL);
+
+	/* card detect pin for microSD slot (CN23) */
+	gpio_request(GPIO_PORT162, NULL);
+	gpio_direction_input(GPIO_PORT162);
+
+	/* MMCIF */
+	gpio_request(GPIO_FN_MMCD0_0, NULL);
+	gpio_request(GPIO_FN_MMCD0_1, NULL);
+	gpio_request(GPIO_FN_MMCD0_2, NULL);
+	gpio_request(GPIO_FN_MMCD0_3, NULL);
+	gpio_request(GPIO_FN_MMCD0_4, NULL);
+	gpio_request(GPIO_FN_MMCD0_5, NULL);
+	gpio_request(GPIO_FN_MMCD0_6, NULL);
+	gpio_request(GPIO_FN_MMCD0_7, NULL);
+	gpio_request(GPIO_FN_MMCCMD0, NULL);
+	gpio_request(GPIO_FN_MMCCLK0, NULL);
+}
+
+static const char *mackerel_compat_dt[] __initdata = {
+	"renesas,mackerel-reference",
+	NULL,
+};
+
+DT_MACHINE_START(MACKEREL, "mackerel-reference")
+	.map_io		= sh7372_map_io,
+	.init_early	= sh7372_add_early_devices_dt,
+	.init_irq	= sh7372_init_irq_of,
+	.handle_irq	= shmobile_handle_irq_intc,
+	.init_machine	= mackerel_init,
+	.init_late	= sh7372_pm_init_late,
+	.timer		= &shmobile_timer,
+	.dt_compat	= mackerel_compat_dt,
+MACHINE_END
-- 
1.7.2.5
