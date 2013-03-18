From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:59:32 +0900
Subject: [PATCH 05/13] ARM: shmobile: marzen: Reference DT implementation
In-Reply-To: <1363607980-22153-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607980-22153-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607980-22153-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide alternate board code for the marzen to demonstrate
how DT may be used given the current state of driver
device tree support. This is intended to act as a reference
for mach-shmobile developers.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                      |    1 +
 arch/arm/boot/dts/r8a7779-marzen-reference.dts  |   47 ++++++++++++++
 arch/arm/mach-shmobile/Kconfig                  |   13 ++++
 arch/arm/mach-shmobile/Makefile                 |    1 +
 arch/arm/mach-shmobile/board-marzen-reference.c |   75 +++++++++++++++++++++++
 5 files changed, 137 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7779-marzen-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-marzen-reference.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c62558..7965b9a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -136,6 +136,7 @@ dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
 	ccu9540.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7740-armadillo800eva.dtb \
+	r8a7779-marzen-reference.dtb \
 	sh73a0-kzm9g.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
new file mode 100644
index 0000000..72be4c8
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -0,0 +1,47 @@
+/*
+ * Reference Device Tree Source for the Marzen board
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ * Copyright (C) 2013 Simon Horman
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "r8a7779.dtsi"
+
+/ {
+	model = "marzen";
+	compatible = "renesas,marzen-reference", "renesas,r8a7779";
+
+	chosen {
+		bootargs = "console=ttySC2,115200 earlyprintk=sh-sci.2,115200 ignore_loglevel root=/dev/nfs ip=on";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
+	};
+
+	fixedregulator3v3: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	lan0 at 18000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x18000000 0x100>;
+		phy-mode = "mii";
+		interrupt-parent = <&gic>;
+		interrupts = <0 28 0x4>;
+		reg-io-width = <4>;
+		vddvario-supply = <&fixedregulator3v3>;
+		vdd33a-supply = <&fixedregulator3v3>;
+	};
+};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 9255546..b15d4ff 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -102,6 +102,19 @@ config MACH_MARZEN
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
+config MACH_MARZEN_REFERENCE
+	bool "MARZEN board - Reference Device Tree Implementation"
+	depends on ARCH_R8A7779
+	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select USE_OF
+	---help---
+	   Use reference implementation of Marzen board support
+	   which makes use of device tree at the expense
+	   of not supporting a number of devices.
+
+	   This is intended to aid developers
+
 config MACH_KZM9D
 	bool "KZM9D board"
 	depends on ARCH_EMEV2
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index b646ff4..3705d4f 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.o
 obj-$(CONFIG_MACH_BONITO)	+= board-bonito.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
+obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
new file mode 100644
index 0000000..480d882
--- /dev/null
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -0,0 +1,75 @@
+/*
+ * marzen board support - Reference DT implementation
+ *
+ * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011  Magnus Damm
+ * Copyright (C) 2013  Simon Horman
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
+#include <linux/pinctrl/machine.h>
+#include <mach/r8a7779.h>
+#include <mach/common.h>
+#include <mach/irqs.h>
+#include <asm/irq.h>
+#include <asm/mach/arch.h>
+
+static const struct pinctrl_map marzen_pinctrl_map[] = {
+	/* SCIF2 (CN18: DEBUG0) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-r8a7779",
+				  "scif2_data_c", "scif2"),
+	/* SCIF4 (CN19: DEBUG1) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-r8a7779",
+				  "scif4_data", "scif4"),
+	/* SDHI0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+				  "sdhi0_cd", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+				  "sdhi0_wp", "sdhi0"),
+	/* SMSC */
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a7779",
+				  "intc_irq1_b", "intc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a7779",
+				  "lbsc_ex_cs0", "lbsc"),
+};
+
+static void __init marzen_init(void)
+{
+	pinctrl_register_mappings(marzen_pinctrl_map,
+				  ARRAY_SIZE(marzen_pinctrl_map));
+	r8a7779_pinmux_init();
+
+	r8a7779_add_standard_devices_dt();
+}
+
+static const char *marzen_boards_compat_dt[] __initdata = {
+	"renesas,marzen-reference",
+	NULL,
+};
+
+DT_MACHINE_START(MARZEN, "marzen")
+	.smp		= smp_ops(r8a7779_smp_ops),
+	.map_io		= r8a7779_map_io,
+	.init_early	= r8a7779_init_delay,
+	.nr_irqs	= NR_IRQS_LEGACY,
+	.init_irq	= r8a7779_init_irq_dt,
+	.init_machine	= marzen_init,
+	.init_time	= shmobile_timer_init,
+	.dt_compat	= marzen_boards_compat_dt,
+MACHINE_END
-- 
1.7.10.4
