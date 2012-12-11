From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 11 Dec 2012 12:07:34 +0900
Subject: [PATCH 6/6] ARM: mach-shmobile: kzm9g: Reference DT implementation
In-Reply-To: <1355195254-4563-1-git-send-email-horms+renesas@verge.net.au>
References: <1355195254-4563-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1355195254-4563-7-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide alternate board code for the kzm9g to demonstrate
how DT may be used given the current state of driver
device tree support. This is intended to act as a reference
for mach-shmobile developers.

Some notes:

* Brings up the GIC interrupt handler using device tree
* Brings up the following device using device tree:
  - MMCIF (MMC)
* Does not bring up the INTC interrupt controller at all,
  thus external devices may not be used. In particular,
  the SMSC ethernet device may not be used and thus
  NFS root may not be used.
* Uses existing C code and not device tree to initialise the following,
  which are needed for a working board:
  - SCIF (Serial)
  - CMT (Clock)
  - PFC (GPIO)

To use this alternate board code instead of the normal board code,
CONFIG_MACH_KZM9G_REFERENCE should be selected in the kernel config.
And the sh73a0-kzm9g-reference.dtb flattened device tree blob should be used.

*** Please note that the clock initialisation shcheme used in
    this patch does not currently work with SMP as there
    is a yet to be resolved lock-up in workqueue initialisation.

    CONFIG_SMP must be disabled when using this code. ***

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v3
* Compile board-kzm9g.c even if CONFIG_MACH_KZM9G_REFERENCE is selected,
  it can co-exist with board-kzm9g-reference.c

v2
* Do not initialise touchscreen, it requires the INTC interrupt controller
  but for now this configuration only has the GIC interrupt controller.
* Define mmcif and sdhi in SoC dtsi and reference in board dts.
* Do not initialise SDHI, the driver needs to be updated
---
 arch/arm/boot/dts/Makefile                     |    3 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |   37 +++++++++
 arch/arm/mach-shmobile/Kconfig                 |   10 +++
 arch/arm/mach-shmobile/Makefile                |    1 +
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   99 ++++++++++++++++++++++++
 5 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-kzm9g-reference.c

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f37cf9f..c606375 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -77,7 +77,8 @@ dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
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
index 0000000..588016e
--- /dev/null
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -0,0 +1,37 @@
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
+/include/ "sh73a0-reference.dtsi"
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
+	fixedregulator1v8: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+};
+
+&mmcif {
+	vmmc-supply = <&fixedregulator1v8>;
+	vqmmc-supply = <&fixedregulator1v8>;
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
index e3556c6..b4d3920 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
+obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
 
 # Framework support
 obj-$(CONFIG_SMP)		+= $(smp-y)
diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
new file mode 100644
index 0000000..140781c
--- /dev/null
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -0,0 +1,99 @@
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
+static void __init kzm_init(void)
+{
+	/* enable SCIFA4 */
+	gpio_request(GPIO_FN_SCIFA4_TXD, NULL);
+	gpio_request(GPIO_FN_SCIFA4_RXD, NULL);
+	gpio_request(GPIO_FN_SCIFA4_RTS_, NULL);
+	gpio_request(GPIO_FN_SCIFA4_CTS_, NULL);
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
+/* Please note that the clock initialisation shcheme used in
+ * sh73a0_add_early_devices_dt() and sh73a0_add_standard_devices_dt()
+ * does not work with SMP as there is a yet to be resolved lock-up in
+ * workqueue initialisation.
+ *
+ * CONFIG_SMP should be disabled when using this code.
+ */
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
