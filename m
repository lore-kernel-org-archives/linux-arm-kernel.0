From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:11:15 +0900
Subject: [PATCH 03/11] ARM: shmobile: APE6EVM base support
In-Reply-To: <1364879483-11144-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879483-11144-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879483-11144-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

V3 of APE6EVM base board support making use of
1 GiB of memory, the SCIFA0 serial port and
ARM architected timer.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile             |    1 +
 arch/arm/boot/dts/r8a73a4-ape6evm.dts  |   31 +++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig         |    8 +++++-
 arch/arm/mach-shmobile/Makefile        |    1 +
 arch/arm/mach-shmobile/board-ape6evm.c |   46 ++++++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm.dts
 create mode 100644 arch/arm/mach-shmobile/board-ape6evm.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 363fa507..a99b0f7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -140,6 +140,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7779-marzen-reference.dtb \
 	sh73a0-kzm9g.dtb \
 	sh73a0-kzm9g-reference.dtb \
+	r8a73a4-ape6evm.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
 	socfpga_vt.dtb
diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
new file mode 100644
index 0000000..833f703
--- /dev/null
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -0,0 +1,31 @@
+/*
+ * Device Tree Source for the APE6EVM board
+ *
+ * Copyright (C) 2013 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "r8a73a4.dtsi"
+
+/ {
+	model = "APE6EVM";
+	compatible = "renesas,ape6evm", "renesas,r8a73a4";
+
+	chosen {
+		bootargs = "console=ttySC0,115200 ignore_loglevel";
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+
+	lbsc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 18712ad..c0da6af 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -96,6 +96,11 @@ config MACH_AG5EVM
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select SH_LCD_MIPI_DSI
 
+config MACH_APE6EVM
+	bool "APE6EVM board"
+	depends on ARCH_R8A73A4
+	select USE_OF
+
 config MACH_MACKEREL
 	bool "mackerel board"
 	depends on ARCH_SH7372
@@ -189,7 +194,7 @@ config MEMORY_START
 	hex "Physical memory start address"
 	default "0x40000000" if MACH_AP4EVB || MACH_AG5EVM || \
 				MACH_MACKEREL || MACH_BONITO || \
-				MACH_ARMADILLO800EVA
+				MACH_ARMADILLO800EVA || MACH_APE6EVM
 	default "0x41000000" if MACH_KOTA2
 	default "0x00000000"
 	---help---
@@ -199,6 +204,7 @@ config MEMORY_START
 
 config MEMORY_SIZE
 	hex "Physical memory size"
+	default "0x40000000" if MACH_APE6EVM
 	default "0x20000000" if MACH_AG5EVM || MACH_BONITO || \
 				MACH_ARMADILLO800EVA
 	default "0x1e000000" if MACH_KOTA2
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 5eada96..ec2524e 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 # Board objects
 obj-$(CONFIG_MACH_AP4EVB)	+= board-ap4evb.o
 obj-$(CONFIG_MACH_AG5EVM)	+= board-ag5evm.o
+obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.o
 obj-$(CONFIG_MACH_BONITO)	+= board-bonito.o
diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
new file mode 100644
index 0000000..9234d4f
--- /dev/null
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -0,0 +1,46 @@
+/*
+ * APE6EVM board support
+ *
+ * Copyright (C) 2013  Renesas Solutions Corp.
+ * Copyright (C) 2013  Magnus Damm
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
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <mach/common.h>
+#include <mach/r8a73a4.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+static void __init ape6evm_add_standard_devices(void)
+{
+	r8a73a4_clock_init();
+	r8a73a4_add_standard_devices();
+}
+
+static const char *ape6evm_boards_compat_dt[] __initdata = {
+	"renesas,ape6evm",
+	NULL,
+};
+
+DT_MACHINE_START(APE6EVM_DT, "ape6evm")
+	.init_irq	= irqchip_init,
+	.init_time	= shmobile_timer_init,
+	.init_machine	= ape6evm_add_standard_devices,
+	.dt_compat	= ape6evm_boards_compat_dt,
+MACHINE_END
-- 
1.7.10.4
