From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 31 Jan 2013 10:50:51 +0900
Subject: [PATCH 4/4] ARM: mach-shmobile: marzen: Reference DT implementation
In-Reply-To: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
References: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1359597051-32700-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide alternate board code for the marzen to demonstrate
how DT may be used given the current state of driver
device tree support. This is intended to act as a reference
for mach-shmobile developers.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                      |    1 +
 arch/arm/boot/dts/r8a7779-marzen-reference.dts  |   41 +++++++++++++
 arch/arm/mach-shmobile/Kconfig                  |   11 ++++
 arch/arm/mach-shmobile/Makefile                 |    1 +
 arch/arm/mach-shmobile/board-marzen-reference.c |   71 +++++++++++++++++++++++
 5 files changed, 125 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7779-marzen-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-marzen-reference.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2c6f9ef..6dfa67a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -123,6 +123,7 @@ dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7740-armadillo800eva-reference.dtb \
+	r8a7779-marzen-reference.dtb \
 	sh73a0-kzm9g.dtb \
 	sh73a0-kzm9g-reference.dtb \
 	sh7372-mackerel.dtb \
diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
new file mode 100644
index 0000000..377d8df
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -0,0 +1,41 @@
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
+};
+
+&lan0 {
+	vddvario-supply = <&fixedregulator3v3>;
+	vdd33a-supply = <&fixedregulator3v3>;
+};
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 5f61e8f..4695bf8 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -120,6 +120,17 @@ config MACH_MARZEN
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
+config MACH_MARZEN_REFERENCE
+	bool "MARZEN board - Reference Device Tree Implementation"
+	depends on MACH_MARZEN
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
index fd7ec65..6ab7ee2 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_MACH_MACKEREL_REFERENCE)	+= board-mackerel-reference.o
 obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.o
 obj-$(CONFIG_MACH_BONITO)	+= board-bonito.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
+obj-$(CONFIG_MACH_MARZEN_REFERENCE)	+= board-marzen-reference.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)     += board-armadillo800eva-reference.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d.o
diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
new file mode 100644
index 0000000..012548f
--- /dev/null
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -0,0 +1,71 @@
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
+#include <linux/gpio.h>
+#include <mach/r8a7779.h>
+#include <mach/common.h>
+#include <mach/irqs.h>
+#include <asm/mach/arch.h>
+
+static void __init marzen_init(void)
+{
+	r8a7779_pinmux_init();
+
+	/* SCIF2 (CN18: DEBUG0) */
+	gpio_request(GPIO_FN_TX2_C, NULL);
+	gpio_request(GPIO_FN_RX2_C, NULL);
+
+	/* SCIF4 (CN19: DEBUG1) */
+	gpio_request(GPIO_FN_TX4, NULL);
+	gpio_request(GPIO_FN_RX4, NULL);
+
+	/* LAN89218 */
+	gpio_request(GPIO_FN_EX_CS0, NULL); /* nCS */
+	gpio_request(GPIO_FN_IRQ1_B, NULL); /* IRQ + PME */
+
+	/* SD0 (CN20) */
+	gpio_request(GPIO_FN_SD0_CLK, NULL);
+	gpio_request(GPIO_FN_SD0_CMD, NULL);
+	gpio_request(GPIO_FN_SD0_DAT0, NULL);
+	gpio_request(GPIO_FN_SD0_DAT1, NULL);
+	gpio_request(GPIO_FN_SD0_DAT2, NULL);
+	gpio_request(GPIO_FN_SD0_DAT3, NULL);
+	gpio_request(GPIO_FN_SD0_CD, NULL);
+	gpio_request(GPIO_FN_SD0_WP, NULL);
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
+	.init_early	= r8a7779_add_early_devices_dt,
+	.nr_irqs	= NR_IRQS_LEGACY,
+	.init_irq	= r8a7779_init_irq_dt,
+	.init_machine	= marzen_init,
+	.init_time	= shmobile_timer_init,
+	.dt_compat	= marzen_boards_compat_dt,
+MACHINE_END
-- 
1.7.10.4
