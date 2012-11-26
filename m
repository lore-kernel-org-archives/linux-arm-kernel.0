From: horms@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2012 09:16:54 +0900
Subject: [PATCH 7/7] ARM: mach-shmobile: kzm9g: Reference DT implementation
In-Reply-To: <1353889014-17142-1-git-send-email-horms@verge.net.au>
References: <1353889014-17142-1-git-send-email-horms@verge.net.au>
Message-ID: <1353889014-17142-8-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide alternate board code for the kzm9g to demonstrate
how DT may be used given the current state of driver
device tree support. This is intended to act as a reference
for mach-shmobile developers.

Some notes:

* Brings up the GIC interrupt handler using device tree
* Brings up the following devices using device tree
  - ST1232 (Touchscreen)
  - MMCIF (MMC)
  - SDHI (MMC)
* Does not bring up the INTC interrupt controller at all,
  thus external devices may not be used
* Uses existing C code and not device tree to initialise the following,
  which are needed for a working board:
  - SCIF (Serial)
  - CMT (Clock)
  - PFC (GPIO)

To use this alternate board code instead of the normal board code,
CONFIG_MACH_KZM9G_REFERENCE should be selected in the kernel config.
And the sh73a0-kzm9g-reference.dtb flattened device tree blob should be used.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/boot/dts/Makefile                     |    3 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |  153 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                 |   10 ++
 arch/arm/mach-shmobile/Makefile                |    8 +-
 arch/arm/mach-shmobile/board-kzm9g-reference.c |  142 ++++++++++++++++++++++
 5 files changed, 314 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-kzm9g-reference.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index c1ce813..b6c4fa2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -75,7 +75,8 @@ dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_U8500) += snowball.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7740-armadillo800eva.dtb \
-	sh73a0-kzm9g.dtb
+	sh73a0-kzm9g.dtb \
+	sh73a0-kzm9g-reference.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
 	spear1340-evb.dtb
 dtb-$(CONFIG_ARCH_SPEAR3XX)+= spear300-evb.dtb \
diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
new file mode 100644
index 0000000..978892a
--- /dev/null
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -0,0 +1,153 @@
+/*
+ * Device Tree Source for the KZM-A9-GT board
+ *
+ * Copyright (C) 2012 Horms Solutions Ltd.
+ *
+ * Based on sh73a0-kzm9g.dts
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "KZM-A9-GT";
+	compatible = "renesas,kzm9g-reference", "renesas,sh73a0";
+
+	memory {
+		device_type = "memory";
+		reg = <0x41000000 0x1e800000>;
+	};
+
+	gic: interrupt-controller at f0001000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <1>;
+		interrupt-controller;
+		reg = <0xf0001000 0x1000>,
+		      <0xf0000100 0x100>;
+	};
+
+	i2c0: i2c at 0xe6820000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xe6820000 0x425>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 167 0x4
+			      0 170 0x4>;
+	};
+
+	i2c1: i2c at 0xe6822000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xe6822000 0x425>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 51 0x4
+			      0 44 0x4>;
+
+		touchscreen at 55 {
+			compatible = "sitronix,st1232";
+			reg = <0x55>;
+			interrupt-parent = <&gic>;
+			interrupts = <0 9 0x4>;
+		};
+	};
+
+	i2c2: i2c at 0xe6824000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xe6824000 0x425>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 171 0x4
+			      0 174 0x4>;
+	};
+
+	i2c3: i2c at 0xe6826000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xe6826000 0x425>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 183 0x4
+			      0 186 0x4>;
+	};
+
+	i2c4: i2c at 0xe6828000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0xe6828000 0x425>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 187 0x4
+			      0 190 0x4>;
+	};
+
+	gpio: gpio at 0 {
+		compatible = "renesas,sh_pfc-sh73a0";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	fixedregulator1v8: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	fixedregulator2v8: fixedregulator at 1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-2.8V";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+	};
+
+	mmcif at 0x10010000 {
+		compatible = "renesas,sh-mmcif";
+		reg = <0xe6bd0000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 140 0x4
+			      0 141 0x4>;
+		reg-io-width = <4>;
+		vmmc-supply = <&fixedregulator1v8>;
+		vqmmc-supply = <&fixedregulator1v8>;
+	};
+
+	sdhi0 at 0xee100000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xee100000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 83 0x4
+			      0 84 0x4
+			      0 85 0x4>;
+		interrupt-names = "card_detect", "sdcard", "sdio";
+		reg-io-width = <2>;
+		vmmc-supply = <&fixedregulator2v8>;
+		vqmmc-supply = <&fixedregulator2v8>;
+		renesas,shmobile-sdhi-has-idle-wait;
+	};
+
+	sdhi2 at 0xee140000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xee140000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 103 0x4
+			      0 104 0x4
+			      0 105 0x4>;
+		interrupt-names = "card_detect", "sdcard", "sdio";
+		reg-io-width = <2>;
+		vmmc-supply = <&fixedregulator2v8>;
+		vqmmc-supply = <&fixedregulator2v8>;
+		renesas,shmobile-sdhi-has-idle-wait;
+		renesas,shmobile-sdhi-use-gpio-cd;
+		renesas,shmobile-sdhi-wrprotect-disable;
+		cd-gpios = <&gpio 13 1>;
+	};
+};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 8ae100c..ca95c2b 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -136,6 +136,16 @@ config MACH_KZM9G
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
 	select USE_OF
 
+config MACH_KZM9G_REFERENCE
+	bool "KZM-A9-GT board - Reference Device Tree Implementation"
+	depends on MACH_KZM9G
+	---help---
+	   Use reference implementation of KZM-A9-GT board support
+	   which makes as greater use of device tree at the expense
+	   of not supporting a number of devices.
+
+	   This is intended to aid developers
+
 comment "SH-Mobile System Configuration"
 
 config CPU_HAS_INTEVT
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index fe2c97c..87f50fa 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -55,7 +55,13 @@ obj-$(CONFIG_MACH_BONITO)	+= board-bonito.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d.o
-obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
+ifeq ($(CONFIG_MACH_KZM9G),y)
+ifeq ($(CONFIG_MACH_KZM9G_REFERENCE),y)
+obj-y	+= board-kzm9g-reference.o
+else
+obj-y	+= board-kzm9g.o
+endif
+endif
 
 # Framework support
 obj-$(CONFIG_SMP)		+= $(smp-y)
diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
new file mode 100644
index 0000000..a3bee425
--- /dev/null
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -0,0 +1,142 @@
+/*
+ * KZM-A9-GT board support - Reference Device Tree Implementation
+ *
+ * Copyright (C) 2012	Horms Solutions Ltd.
+ *
+ * Based on board-kzm9g.c
+ * Copyright (C) 2012	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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
+
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/input.h>
+#include <linux/of_platform.h>
+#include <mach/sh73a0.h>
+#include <mach/common.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+static const struct of_dev_auxdata kzm_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("renesas,rmobile-iic", 0xe6820000,
+		       "i2c-sh_mobile.0", NULL),
+	OF_DEV_AUXDATA("renesas,rmobile-iic", 0xe6822000,
+		       "i2c-sh_mobile.1", NULL),
+	OF_DEV_AUXDATA("renesas,rmobile-iic", 0xe6824000,
+		       "i2c-sh_mobile.2", NULL),
+	OF_DEV_AUXDATA("renesas,rmobile-iic", 0xe6826000,
+		       "i2c-sh_mobile.3", NULL),
+	OF_DEV_AUXDATA("renesas,rmobile-iic", 0xe6828000,
+		       "i2c-sh_mobile.4", NULL),
+	OF_DEV_AUXDATA("renesas,shmobile-sdhi", 0xee100000,
+		       "sh_mobile_sdhi.0", NULL),
+	OF_DEV_AUXDATA("renesas,shmobile-sdhi", 0xee140000,
+		       "sh_mobile_sdhi.2", NULL),
+	OF_DEV_AUXDATA("renesas,sh-mmcif", 0xe6bd0000, "sh_mmcif.0", NULL),
+	{},
+};
+
+static void __init kzm_init(void)
+{
+	sh73a0_pinmux_init();
+
+	/* enable SCIFA4 */
+	gpio_request(GPIO_FN_SCIFA4_TXD, NULL);
+	gpio_request(GPIO_FN_SCIFA4_RXD, NULL);
+	gpio_request(GPIO_FN_SCIFA4_RTS_, NULL);
+	gpio_request(GPIO_FN_SCIFA4_CTS_, NULL);
+
+	/* Touchscreen */
+	gpio_request(GPIO_PORT223, NULL); /* IRQ8 */
+	gpio_direction_input(GPIO_PORT223);
+
+	/* enable MMCIF */
+	gpio_request(GPIO_FN_MMCCLK0,		NULL);
+	gpio_request(GPIO_FN_MMCCMD0_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_0_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_1_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_2_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_3_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_4_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_5_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_6_PU,	NULL);
+	gpio_request(GPIO_FN_MMCD0_7_PU,	NULL);
+
+	/* enable SD */
+	gpio_request(GPIO_FN_SDHIWP0,		NULL);
+	gpio_request(GPIO_FN_SDHICD0,		NULL);
+	gpio_request(GPIO_FN_SDHICMD0,		NULL);
+	gpio_request(GPIO_FN_SDHICLK0,		NULL);
+	gpio_request(GPIO_FN_SDHID0_3,		NULL);
+	gpio_request(GPIO_FN_SDHID0_2,		NULL);
+	gpio_request(GPIO_FN_SDHID0_1,		NULL);
+	gpio_request(GPIO_FN_SDHID0_0,		NULL);
+	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
+	gpio_request(GPIO_PORT15, NULL);
+	gpio_direction_output(GPIO_PORT15, 1); /* power */
+
+	/* enable Micro SD */
+	gpio_request(GPIO_FN_SDHID2_0,		NULL);
+	gpio_request(GPIO_FN_SDHID2_1,		NULL);
+	gpio_request(GPIO_FN_SDHID2_2,		NULL);
+	gpio_request(GPIO_FN_SDHID2_3,		NULL);
+	gpio_request(GPIO_FN_SDHICMD2,		NULL);
+	gpio_request(GPIO_FN_SDHICLK2,		NULL);
+	gpio_request(GPIO_PORT14, NULL);
+	gpio_direction_output(GPIO_PORT14, 1); /* power */
+
+	/* I2C 3 */
+	gpio_request(GPIO_FN_PORT27_I2C_SCL3, NULL);
+	gpio_request(GPIO_FN_PORT28_I2C_SDA3, NULL);
+
+#ifdef CONFIG_CACHE_L2X0
+	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
+	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
+#endif
+
+	sh73a0_add_standard_devices_dt();
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     kzm_auxdata_lookup, NULL);
+}
+
+static void kzm9g_restart(char mode, const char *cmd)
+{
+#define RESCNT2 IOMEM(0xe6188020)
+	/* Do soft power on reset */
+	writel((1 << 31), RESCNT2);
+}
+
+static const char *kzm9g_boards_compat_dt[] __initdata = {
+	"renesas,kzm9g-reference",
+	NULL,
+};
+
+DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
+	.smp		= smp_ops(sh73a0_smp_ops),
+	.map_io		= sh73a0_map_io,
+	.init_early	= sh73a0_add_early_devices_dt,
+	.nr_irqs	= NR_IRQS_LEGACY,
+	.init_irq	= sh73a0_init_irq_dt,
+	.handle_irq	= gic_handle_irq,
+	.init_machine	= kzm_init,
+	.init_late	= shmobile_init_late,
+	.timer		= &shmobile_timer,
+	.restart	= kzm9g_restart,
+	.dt_compat	= kzm9g_boards_compat_dt,
+MACHINE_END
-- 
1.7.10.4
