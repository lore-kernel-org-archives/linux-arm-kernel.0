From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Fri, 26 Jul 2013 00:42:13 +0200
Subject: [PATCH v3 1/3] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
In-Reply-To: <1374792135-30343-1-git-send-email-hauke@hauke-m.de>
References: <1374792135-30343-1-git-send-email-hauke@hauke-m.de>
Message-ID: <1374792135-30343-2-git-send-email-hauke@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the BCM5301X/BCM470X SoCs with an ARM CPUs.
Currently just booting to a shell is working and nothing else, no
Ethernet, wifi, flash, ...

This SoC is used in small office and home router with Broadcom SoCs.
This code should support the BCM4707, BCM4708, BCM4709, BCM53010,
BCM53011 and BCM53012 SoC. It uses one or two ARM Cortex A9
Cores, some highlights are 2 PCIe 2.0 controllers, 4 Gigabit Ethernet
MACs and a USB 3.0 host controller.

This SoC uses a dual core CPU, but this is currently not implemented.
More information about this SoC can be found here:
http://www.anandtech.com/show/5925/broadcom-announces-bcm4708x-and-bcm5301x-socs-for-80211ac-routers

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 Documentation/devicetree/bindings/arm/bcm4708.txt |    8 +++
 MAINTAINERS                                       |    8 +++
 arch/arm/Makefile                                 |    2 +-
 arch/arm/configs/multi_v7_defconfig               |    1 +
 arch/arm/mach-bcm/Kconfig                         |   21 ++++++++
 arch/arm/mach-bcm/Makefile                        |    1 +
 arch/arm/mach-bcm/bcm5301x.c                      |   59 +++++++++++++++++++++
 7 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm4708.txt
 create mode 100644 arch/arm/mach-bcm/bcm5301x.c

diff --git a/Documentation/devicetree/bindings/arm/bcm4708.txt b/Documentation/devicetree/bindings/arm/bcm4708.txt
new file mode 100644
index 0000000..6b0f49f
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
+compatible = "brcm,bcm4708";
diff --git a/MAINTAINERS b/MAINTAINERS
index bf61e04..b38f141 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1795,6 +1795,14 @@ F:	arch/arm/boot/dts/bcm2835*
 F:	arch/arm/configs/bcm2835_defconfig
 F:	drivers/*/*bcm2835*
 
+BROADCOM BCM5301X ARM ARCHICTURE
+M:	Hauke Mehrtens <hauke@hauke-m.de>
+L:	linux-arm-kernel at lists.infradead.org
+S:	Maintained
+F:	arch/arm/mach-bcm/bcm5301x.c
+F:	arch/arm/boot/dts/bcm5301*
+F:	arch/arm/boot/dts/bcm470*
+
 BROADCOM TG3 GIGABIT ETHERNET DRIVER
 M:	Nithin Nayak Sujir <nsujir@broadcom.com>
 M:	Michael Chan <mchan@broadcom.com>
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c0ac0f5..230b5d7 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -145,7 +145,7 @@ textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
 machine-$(CONFIG_ARCH_AT91)		+= at91
-machine-$(CONFIG_ARCH_BCM)		+= bcm
+machine-y				+= bcm
 machine-$(CONFIG_ARCH_BCM2835)		+= bcm2835
 machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
 machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fe0bdc3..f449bd7 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -6,6 +6,7 @@ CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_ARCH_BCM=y
+CONFIG_ARCH_BCM5301X=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_ARCH_HIGHBANK=y
 CONFIG_ARCH_KEYSTONE=y
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index f112895..979433b 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -17,3 +17,24 @@ config ARCH_BCM
 	  It currently supports the 'BCM281XX' family, which includes
 	  BCM11130, BCM11140, BCM11351, BCM28145 and
 	  BCM28155 variants.
+
+config ARCH_BCM5301X
+	bool "Broadcom BCM470X / BCM5301X ARM SoC"
+	select CPU_V7
+	select ARM_GIC
+	select HAVE_CLK
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_TIME
+	select ARM_GLOBAL_TIMER
+	help
+	  Support for Broadcom BCM470X and BCM5301X SoCs with ARM CPU cores.
+
+	  This is a network SoC line mostly used in home routers and
+	  wifi access points.
+	  This inclused the following SoC: BCM53010, BCM53011, BCM53012,
+	  BCM53014, BCM53015, BCM53016, BCM53017, BCM53018, BCM4707,
+	  BCM4708 and BCM4709.
+
+	  Do not confuse this with the BCM4760 which is a totally
+	  different SoC or with the older BCM47XX and BCM53XX based
+	  network SoC using a MIPS CPU, they are supported by arch/mips/bcm47xx
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 6adb6aec..b5b8046 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -13,3 +13,4 @@
 obj-$(CONFIG_ARCH_BCM)		:= board_bcm.o bcm_kona_smc.o bcm_kona_smc_asm.o
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_bcm_kona_smc_asm.o	:=-Wa,-march=armv7-a$(plus_sec)
+obj-$(CONFIG_ARCH_BCM5301X)	+= bcm5301x.o
diff --git a/arch/arm/mach-bcm/bcm5301x.c b/arch/arm/mach-bcm/bcm5301x.c
new file mode 100644
index 0000000..5168f94
--- /dev/null
+++ b/arch/arm/mach-bcm/bcm5301x.c
@@ -0,0 +1,59 @@
+/*
+ * Broadcom BCM470X / BCM5301X ARM platform code.
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
+static int bcm5301x_abort_handler(unsigned long addr, unsigned int fsr,
+				 struct pt_regs *regs)
+{
+	/*
+	 * These happen for no good reason, possibly left over from CFE
+	 */
+	pr_warn("External imprecise Data abort at addr=%#lx, fsr=%#x ignored.\n",
+		addr, fsr);
+
+	/* Returning non-zero causes fault display and panic */
+	return 0;
+}
+
+static void __init bcm5301x_init_early(void)
+{
+	/* Install our hook */
+	hook_fault_code(16 + 6, bcm5301x_abort_handler, SIGBUS, 0,
+			"imprecise external abort");
+}
+
+static void __init bcm5301x_map_io(void)
+{
+	debug_ll_io_init();
+}
+
+static void __init bcm5301x_timer_init(void)
+{
+	of_clk_init(NULL);
+	clocksource_of_init();
+}
+
+static const char const *bcm5301x_dt_compat[] = {
+	"brcm,bcm4708",
+	NULL,
+};
+
+DT_MACHINE_START(BCM5301X, "BCM5301X")
+	.init_early = bcm5301x_init_early,
+	.map_io = bcm5301x_map_io,
+	.init_time = bcm5301x_timer_init,
+	.dt_compat = bcm5301x_dt_compat,
+MACHINE_END
-- 
1.7.10.4
