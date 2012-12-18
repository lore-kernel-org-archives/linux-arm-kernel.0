From: hechtb@gmail.com (Bastian Hecht)
Date: Tue, 18 Dec 2012 18:22:39 +0100
Subject: [PATCH 2/2] ARM: shmobile: armadillo800eva: Reference DT
 implementation
In-Reply-To: <1355851359-8871-1-git-send-email-hechtb+renesas@gmail.com>
References: <1355851359-8871-1-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <1355851359-8871-3-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide alternate board code for the Armadillo 800 EVA to
demonstrate how DT may be used given the current state of
driver device tree support. This is intended to act as a
reference for mach-shmobile developers.

This is based on Simon Horman's reference implementation for
the board kzm9g.

Currently only the ethernet controller is brought up.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
 arch/arm/boot/dts/Makefile                         |    1 +
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   33 ++++
 arch/arm/mach-shmobile/Kconfig                     |   10 ++
 arch/arm/mach-shmobile/Makefile                    |    1 +
 .../board-armadillo800eva-reference.c              |  172 ++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h       |    2 +
 6 files changed, 219 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-armadillo800eva-reference.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0632239..8338bcc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -75,6 +75,7 @@ dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
 dtb-$(CONFIG_ARCH_U8500) += snowball.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7740-armadillo800eva.dtb \
+	r8a7740-armadillo800eva-reference.dtb \
 	sh73a0-kzm9g.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
new file mode 100644
index 0000000..5b5afd3
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -0,0 +1,33 @@
+/*
+ * Reference Device Tree Source for the armadillo 800 eva board
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "r8a7740.dtsi"
+
+/ {
+	model = "armadillo 800 eva";
+	compatible = "renesas,armadillo800eva-reference", "renesas,r8a7740";
+
+	memory {
+		device_type = "memory";
+		reg = <0x40000000 0x20000000>;
+	};
+
+	sh-eth at e9a00000 {
+		compatible = "renesas,sh-eth";
+		interrupt-parent = <&intca>;
+		reg = <0xe9a00000 0x800>, <0xe9a01800 0x800>;
+		interrupts = <0x500>;
+		phy-mode = "mii";
+		sh-eth,edmac-endian = "little";
+		sh-eth,register-type = "gigabit";
+		sh-eth,phy-id = <0>;
+	};
+};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 9255546..6766752 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -96,6 +96,16 @@ config MACH_ARMADILLO800EVA
 	select SND_SOC_WM8978 if SND_SIMPLE_CARD
 	select USE_OF
 
+config MACH_ARMADILLO800EVA_REFERENCE
+	bool "Armadillo-800 EVA board - Reference Device Tree Implementation"
+	depends on MACH_ARMADILLO800EVA
+	---help---
+	  Use reference implementation of Aramdillo800 EVA board support
+	  which makes a greater use of device tree at the expense
+	  of not supporting a number of devices.
+
+	  This is intended to aid developers
+
 config MACH_MARZEN
 	bool "MARZEN board"
 	depends on ARCH_R8A7779
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 0b71479..87fdc64 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.o
 obj-$(CONFIG_MACH_BONITO)	+= board-bonito.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
+obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)     += board-armadillo800eva-reference.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
 
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
new file mode 100644
index 0000000..644f2de
--- /dev/null
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -0,0 +1,172 @@
+/*
+ * armadillo 800 eva board support - Interim Reference Device Tree Implementation
+ * This will be merged to board-armadillo800eva.c when DT support is complete
+ *
+ * Copyright (C) 2012 Bastian Hecht <hechtb+renesas@gmail.com>
+ *
+ * based on the reference implementation of the board kzm9g from Simon Horman
+ * and board-armadilloeva800.c
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ * Copyright (C) 2012 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <mach/common.h>
+#include <mach/r8a7740.h>
+#include <asm/mach/arch.h>
+#include <asm/hardware/cache-l2x0.h>
+
+/*
+ * CON1		Camera Module
+ * CON2		Extension Bus
+ * CON3		HDMI Output
+ * CON4		Composite Video Output
+ * CON5		H-UDI JTAG
+ * CON6		ARM JTAG
+ * CON7		SD1
+ * CON8		SD2
+ * CON9		RTC BackUp
+ * CON10	Monaural Mic Input
+ * CON11	Stereo Headphone Output
+ * CON12	Audio Line Output(L)
+ * CON13	Audio Line Output(R)
+ * CON14	AWL13 Module
+ * CON15	Extension
+ * CON16	LCD1
+ * CON17	LCD2
+ * CON19	Power Input
+ * CON20	USB1
+ * CON21	USB2
+ * CON22	Serial
+ * CON23	LAN
+ * CON24	USB3
+ * LED1		Camera LED(Yellow)
+ * LED2		Power LED (Green)
+ * ED3-LED6	User LED(Yellow)
+ * LED7		LAN link LED(Green)
+ * LED8		LAN activity LED(Yellow)
+ */
+
+/*
+ * DipSwitch
+ *
+ *                    SW1
+ *
+ * -12345678-+---------------+----------------------------
+ *  1        | boot          | hermit
+ *  0        | boot          | OS auto boot
+ * -12345678-+---------------+----------------------------
+ *   00      | boot device   | eMMC
+ *   10      | boot device   | SDHI0 (CON7)
+ *   01      | boot device   | -
+ *   11      | boot device   | Extension Buss (CS0)
+ * -12345678-+---------------+----------------------------
+ *     0     | Extension Bus | D8-D15 disable, eMMC enable
+ *     1     | Extension Bus | D8-D15 enable,  eMMC disable
+ * -12345678-+---------------+----------------------------
+ *      0    | SDHI1         | COM8 disable, COM14 enable
+ *      1    | SDHI1         | COM8 enable,  COM14 disable
+ * -12345678-+---------------+----------------------------
+ *       0   | USB0          | COM20 enable,  COM24 disable
+ *       1   | USB0          | COM20 disable, COM24 enable
+ * -12345678-+---------------+----------------------------
+ *        00 | JTAG          | SH-X2
+ *        10 | JTAG          | ARM
+ *        01 | JTAG          | -
+ *        11 | JTAG          | Boundary Scan
+ *-----------+---------------+----------------------------
+ */
+
+/*
+ * FSI-WM8978
+ *
+ * this command is required when playback.
+ *
+ * # amixer set "Headphone" 50
+ */
+
+/*
+ * board init
+ */
+static void __init eva_init(void)
+{
+	r8a7740_pinmux_init();
+	r8a7740_meram_workaround();
+
+	/* SCIFA1 */
+	gpio_request(GPIO_FN_SCIFA1_RXD, NULL);
+	gpio_request(GPIO_FN_SCIFA1_TXD, NULL);
+
+	/* GETHER */
+	gpio_request(GPIO_FN_ET_CRS,		NULL);
+	gpio_request(GPIO_FN_ET_MDC,		NULL);
+	gpio_request(GPIO_FN_ET_MDIO,		NULL);
+	gpio_request(GPIO_FN_ET_TX_ER,		NULL);
+	gpio_request(GPIO_FN_ET_RX_ER,		NULL);
+	gpio_request(GPIO_FN_ET_ERXD0,		NULL);
+	gpio_request(GPIO_FN_ET_ERXD1,		NULL);
+	gpio_request(GPIO_FN_ET_ERXD2,		NULL);
+	gpio_request(GPIO_FN_ET_ERXD3,		NULL);
+	gpio_request(GPIO_FN_ET_TX_CLK,		NULL);
+	gpio_request(GPIO_FN_ET_TX_EN,		NULL);
+	gpio_request(GPIO_FN_ET_ETXD0,		NULL);
+	gpio_request(GPIO_FN_ET_ETXD1,		NULL);
+	gpio_request(GPIO_FN_ET_ETXD2,		NULL);
+	gpio_request(GPIO_FN_ET_ETXD3,		NULL);
+	gpio_request(GPIO_FN_ET_PHY_INT,	NULL);
+	gpio_request(GPIO_FN_ET_COL,		NULL);
+	gpio_request(GPIO_FN_ET_RX_DV,		NULL);
+	gpio_request(GPIO_FN_ET_RX_CLK,		NULL);
+
+	gpio_request(GPIO_PORT18, NULL); /* PHY_RST */
+	gpio_direction_output(GPIO_PORT18, 1);
+
+#ifdef CONFIG_CACHE_L2X0
+	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
+	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
+#endif
+
+	r8a7740_add_standard_devices_dt();
+}
+
+#define RESCNT2 IOMEM(0xe6188020)
+static void eva_restart(char mode, const char *cmd)
+{
+	/* Do soft power on reset */
+	writel((1 << 31), RESCNT2);
+}
+
+static const char *eva_boards_compat_dt[] __initdata = {
+	"renesas,armadillo800eva-reference",
+	NULL,
+};
+
+DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva-reference")
+	.map_io		= r8a7740_map_io,
+	.init_early	= r8a7740_add_early_devices_dt,
+	.init_irq	= r8a7740_init_irq_of,
+	.nr_irqs	= NR_IRQS_LEGACY,
+	.handle_irq	= shmobile_handle_irq_intc,
+	.init_machine	= eva_init,
+	.init_late	= shmobile_init_late,
+	.timer		= &shmobile_timer,
+	.dt_compat	= eva_boards_compat_dt,
+	.restart	= eva_restart,
+MACHINE_END
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index dfeca79..9249459 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -44,7 +44,9 @@ extern struct clk sh73a0_extalr_clk;
 extern void r8a7740_init_irq(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
+extern void r8a7740_add_early_devices_dt(void);
 extern void r8a7740_add_standard_devices(void);
+extern void r8a7740_add_standard_devices_dt(void);
 extern void r8a7740_clock_init(u8 md_ck);
 extern void r8a7740_pinmux_init(void);
 
-- 
1.7.9.5
