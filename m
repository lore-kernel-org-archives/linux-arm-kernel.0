From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Tue, 16 Jul 2013 21:14:21 +0200
Subject: [RFC v2 1/2] ARM: BCM53XX: initial support for the BCM5301/BCM470X
 SoCs with ARM CPU
Message-ID: <1374002062-28952-1-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the BCM5301/BCM470X SoCs with an ARM CPUs.
Currently just booting to a shell is working and nothing else, no
Ethernet, wifi, flash, ...

This SoC is used in Small office and Home Router with Broadcom SoCs.
This code should support the BCM4707, BCM4708, BCM4709, BCM53010,
BCM53011 and BCM53012 SoC. It uses one or two ARM Cortex A9
Cores, some highlights are 2 PCIe 2.0 controllers, 4 Gigabit Ethernet
MACs and a USB 3.0 host controller.

This SoC uses a Dual core CPU, but this is currently not implemented.
More information about this SoC can be found here:
http://www.anandtech.com/show/5925/broadcom-announces-bcm4708x-and-bcm5301x-socs-for-80211ac-routers

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---

A bootlog can be found here:
http://pastebin.com/0MYYC7Fx

Changes since v1:
 * add file Documentation/devicetree/bindings/arm/bcm4708.txt
 * rename bcm5301x to bcm4708 in dts files
 * use preprocessor includes in dts file
 * add CONFIG_ARCH_BCM53XX to multi_v7_defconfig
 * remove init_machine callback
 * rename vendor prefix from brcm to bcm
 * split into two patches


 Documentation/devicetree/bindings/arm/bcm4708.txt |    8 +++
 MAINTAINERS                                       |    8 +++
 arch/arm/Kconfig                                  |    2 +
 arch/arm/Kconfig.debug                            |    5 ++
 arch/arm/Makefile                                 |    1 +
 arch/arm/boot/dts/Makefile                        |    1 +
 arch/arm/configs/multi_v7_defconfig               |    1 +
 arch/arm/include/debug/bcm53xx.S                  |   19 +++++++
 arch/arm/mach-bcm53xx/Kconfig                     |   10 ++++
 arch/arm/mach-bcm53xx/Makefile                    |    1 +
 arch/arm/mach-bcm53xx/bcm53xx.c                   |   61 +++++++++++++++++++++
 11 files changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm4708.txt
 create mode 100644 arch/arm/include/debug/bcm53xx.S
 create mode 100644 arch/arm/mach-bcm53xx/Kconfig
 create mode 100644 arch/arm/mach-bcm53xx/Makefile
 create mode 100644 arch/arm/mach-bcm53xx/bcm53xx.c

diff --git a/Documentation/devicetree/bindings/arm/bcm4708.txt b/Documentation/devicetree/bindings/arm/bcm4708.txt
new file mode 100644
index 0000000..2d4588c
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm4708.txt
@@ -0,0 +1,8 @@
+Broadcom BCM4708 device tree bindings
+-------------------------------------------
+
+Boards with the BCM4708 SoC shall have the following properties:
+
+Required root node property:
+
+compatible = "bcm,bcm4708";
diff --git a/MAINTAINERS b/MAINTAINERS
index bf61e04..ade242b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1795,6 +1795,14 @@ F:	arch/arm/boot/dts/bcm2835*
 F:	arch/arm/configs/bcm2835_defconfig
 F:	drivers/*/*bcm2835*
 
+BROADCOM BCM53XX ARM ARCHICTURE
+M:	Hauke Mehrtens <hauke@hauke-m.de>
+L:	linux-arm-kernel at lists.infradead.org
+S:	Maintained
+F:	arch/arm/mach-bcm53xx/
+F:	arch/arm/boot/dts/bcm53*
+F:	arch/arm/boot/dts/bcm47*
+
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Nithin Nayak Sujir <nsujir@broadcom.com>
 M:	Michael Chan <mchan@broadcom.com>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ba412e0..ee7362e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -930,6 +930,8 @@ source "arch/arm/mach-bcm/Kconfig"
 
 source "arch/arm/mach-bcm2835/Kconfig"
 
+source "arch/arm/mach-bcm53xx/Kconfig"
+
 source "arch/arm/mach-clps711x/Kconfig"
 
 source "arch/arm/mach-cns3xxx/Kconfig"
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e401a76..74e32f6 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -93,6 +93,10 @@ choice
 		bool "Kernel low-level debugging on BCM2835 PL011 UART"
 		depends on ARCH_BCM2835
 
+	config DEBUG_BCM53XX
+		bool "Kernel low-level debugging on BCM53XX UART1"
+		depends on ARCH_BCM53XX
+
 	config DEBUG_CLPS711X_UART1
 		bool "Kernel low-level debugging messages via UART1"
 		depends on ARCH_CLPS711X
@@ -762,6 +766,7 @@ endchoice
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/bcm2835.S" if DEBUG_BCM2835
+	default "debug/bcm53xx.S" if DEBUG_BCM53XX
 	default "debug/cns3xxx.S" if DEBUG_CNS3XXX
 	default "debug/exynos.S" if DEBUG_EXYNOS_UART
 	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c0ac0f5..4a69cd5 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -147,6 +147,7 @@ textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
 machine-$(CONFIG_ARCH_AT91)		+= at91
 machine-$(CONFIG_ARCH_BCM)		+= bcm
 machine-$(CONFIG_ARCH_BCM2835)		+= bcm2835
+machine-$(CONFIG_ARCH_BCM53XX)		+= bcm53xx
 machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
 machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
 machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 641b3c9..28c3351b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -242,6 +242,7 @@ dtb-$(CONFIG_ARCH_VT8500) += vt8500-bv07.dtb \
 dtb-$(CONFIG_ARCH_ZYNQ) += zynq-zc702.dtb \
 	zynq-zc706.dtb \
 	zynq-zed.dtb
+dtb-$(CONFIG_ARCH_BCM53XX) += bcm4708-netgear-r6250.dtb
 
 targets += dtbs
 targets += $(dtb-y)
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fe0bdc3..1d52727 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -6,6 +6,7 @@ CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_ARCH_BCM=y
+CONFIG_ARCH_BCM53XX=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_KEYSTONE=y
diff --git a/arch/arm/include/debug/bcm53xx.S b/arch/arm/include/debug/bcm53xx.S
new file mode 100644
index 0000000..98c836b
--- /dev/null
+++ b/arch/arm/include/debug/bcm53xx.S
@@ -0,0 +1,19 @@
+/*
+ * Macros used for EARLY_PRINTK, in low-level UART debug console
+ *
+ * Copyright 2013 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+#define BCM53XX_UART1_PHYS	0x18000300
+#define BCM53XX_UART1_VIRT	0xf1000300
+#define BCM53XX_UART1_SH	0
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =BCM53XX_UART1_PHYS 	@ MMU off, Physical
+	ldr	\rv, =BCM53XX_UART1_VIRT 	@ MMU on, Virtual
+	.endm
+
+#define UART_SHIFT	BCM53XX_UART1_SH
+#include <asm/hardware/debug-8250.S>
diff --git a/arch/arm/mach-bcm53xx/Kconfig b/arch/arm/mach-bcm53xx/Kconfig
new file mode 100644
index 0000000..1e16e87
--- /dev/null
+++ b/arch/arm/mach-bcm53xx/Kconfig
@@ -0,0 +1,10 @@
+config ARCH_BCM53XX
+	bool "Broadcom BCM47XX / BCM53XX ARM SoC"
+	select CPU_V7
+	select ARM_GIC
+	select HAVE_CLK
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_TIME
+	select ARM_GLOBAL_TIMER
+	help
+	  Support for Broadcom BCM47XX and BCM53XX SoCs with ARM CPU cores.
diff --git a/arch/arm/mach-bcm53xx/Makefile b/arch/arm/mach-bcm53xx/Makefile
new file mode 100644
index 0000000..88da84d
--- /dev/null
+++ b/arch/arm/mach-bcm53xx/Makefile
@@ -0,0 +1 @@
+obj-y += bcm53xx.o
diff --git a/arch/arm/mach-bcm53xx/bcm53xx.c b/arch/arm/mach-bcm53xx/bcm53xx.c
new file mode 100644
index 0000000..912d9dd
--- /dev/null
+++ b/arch/arm/mach-bcm53xx/bcm53xx.c
@@ -0,0 +1,61 @@
+/*
+ * Broadcom BCM47XX / BCM53XX ARM platform code.
+ *
+ * Copyright 2013 Hauke Mehrtens <hauke@hauke-m.de>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/irqchip.h>
+#include <linux/clocksource.h>
+#include <linux/clk-provider.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/signal.h>
+
+static int bcm53xx_abort_handler(unsigned long addr, unsigned int fsr,
+				 struct pt_regs *regs)
+{
+	/*
+	 * These happen for no good reason
+	 * possibly left over from CFE
+	 */
+	pr_warn("External imprecise Data abort at addr=%#lx, fsr=%#x ignored.\n",
+		addr, fsr);
+
+	/* Returning non-zero causes fault display and panic */
+	return 0;
+}
+
+static void bcm53xx_aborts_enable(void)
+{
+	/* Install our hook */
+	hook_fault_code(16 + 6, bcm53xx_abort_handler, SIGBUS, 0,
+			"imprecise external abort");
+}
+
+void __init bcm53xx_map_io(void)
+{
+	debug_ll_io_init();
+	bcm53xx_aborts_enable();
+}
+
+static void __init bcm53xx_timer_init(void)
+{
+	of_clk_init(NULL);
+	clocksource_of_init();
+}
+
+static const char const *bcm53xx_dt_compat[] = {
+	"bcm,bcm4708",
+	NULL,
+};
+
+DT_MACHINE_START(BCM53XX, "BCM53XX")
+	.map_io = bcm53xx_map_io,
+	.init_irq = irqchip_init,
+	.init_time = bcm53xx_timer_init,
+	.dt_compat = bcm53xx_dt_compat,
+MACHINE_END
-- 
1.7.10.4
