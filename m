From: csd@broadcom.com (Christian Daudt)
Date: Thu, 8 Nov 2012 08:13:16 -0800
Subject: [PATCH] Add support for generic BCM SoC chipsets
Message-ID: <1352391196-9984-1-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to start upstreaming Broadcom SoC support, create
a starting hierarchy, arch and dts files.
The first support SoC family that is planned is the
 BCM281XX (BCM28145/28150/28155) family of dual A9 mobile SoC cores
This code is just the skeleton code for get the machine upstreamed. It
has been made MULTIPLATFORM compatible.
Next steps
----------
Upstream a basic set of drivers - sufficient for a console boot to
ramdisk. These will includer timer, gpio, i2c drivers.
After this basic set, we will proceed with a more comprehensive set
of drivers for the 281XX SoC family.

Signed-off-by: Christian Daudt <csd@broadcom.com>
Reviewed-by: James King <jamesk@broadcom.com>
---
 arch/arm/Kconfig                |    2 +
 arch/arm/Makefile               |    1 +
 arch/arm/boot/dts/Makefile      |    1 +
 arch/arm/boot/dts/capri-brt.dts |   32 +++++++++++
 arch/arm/boot/dts/capri.dtsi    |   50 +++++++++++++++++
 arch/arm/configs/bcm_defconfig  |  114 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-bcm/Kconfig       |   18 +++++++
 arch/arm/mach-bcm/Makefile      |   13 +++++
 arch/arm/mach-bcm/board_bcm.c   |   66 +++++++++++++++++++++++
 9 files changed, 297 insertions(+)
 create mode 100644 arch/arm/boot/dts/capri-brt.dts
 create mode 100644 arch/arm/boot/dts/capri.dtsi
 create mode 100644 arch/arm/configs/bcm_defconfig
 create mode 100644 arch/arm/mach-bcm/Kconfig
 create mode 100644 arch/arm/mach-bcm/Makefile
 create mode 100644 arch/arm/mach-bcm/board_bcm.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ade7e92..3da77ba 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1022,6 +1022,8 @@ source "arch/arm/mach-mvebu/Kconfig"
 
 source "arch/arm/mach-at91/Kconfig"
 
+source "arch/arm/mach-bcm/Kconfig"
+
 source "arch/arm/mach-clps711x/Kconfig"
 
 source "arch/arm/mach-cns3xxx/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 5f914fc..8523fdb 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -137,6 +137,7 @@ textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
 machine-$(CONFIG_ARCH_AT91)		+= at91
+machine-$(CONFIG_ARCH_BCM)		+= bcm
 machine-$(CONFIG_ARCH_BCM2835)		+= bcm2835
 machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
 machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f37cf9f..25d347a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -17,6 +17,7 @@ dtb-$(CONFIG_ARCH_AT91) += aks-cdu.dtb \
 	usb_a9263.dtb \
 	usb_a9g20.dtb
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
+dtb-$(CONFIG_ARCH_BCM) += capri-brt.dtb
 dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
 	dove-cubox.dtb \
 	dove-dove-db.dtb
diff --git a/arch/arm/boot/dts/capri-brt.dts b/arch/arm/boot/dts/capri-brt.dts
new file mode 100644
index 0000000..5db7335
--- /dev/null
+++ b/arch/arm/boot/dts/capri-brt.dts
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) 2012 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+
+/include/ "capri.dtsi"
+
+/ {
+	model = "Capri BRT board";
+	compatible = "bcm,capri";
+	interrupt-parent = <&gic>;
+
+	memory {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>; /* 1 GB */
+	};
+
+	uart at 3e000000 {
+		status = "okay";
+	};
+
+};
diff --git a/arch/arm/boot/dts/capri.dtsi b/arch/arm/boot/dts/capri.dtsi
new file mode 100644
index 0000000..895a928
--- /dev/null
+++ b/arch/arm/boot/dts/capri.dtsi
@@ -0,0 +1,50 @@
+/*
+ * Copyright (C) 2012 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "Capri SoC";
+	compatible = "bcm,capri";
+	interrupt-parent = <&gic>;
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8";
+	};
+
+	gic: interrupt-controller at 3ff00100 {
+		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x3ff01000 0x1000>,
+		      <0x3ff00100 0x100>;
+	};
+
+	uart at 3e000000 {
+		compatible = "snps,dw-apb-uart";
+		status = "disabled";
+		reg = <0x3e000000 0x1000>;
+		clock-frequency = <13000000>;
+		interrupts = <0x0 67 0x4>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+	};
+
+	L2: l2-cache {
+		    compatible = "arm,pl310-cache";
+		    reg = <0x3ff20000 0x1000>;
+		    cache-unified;
+		    cache-level = <2>;
+	};
+};
diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
new file mode 100644
index 0000000..e3bf2d6
--- /dev/null
+++ b/arch/arm/configs/bcm_defconfig
@@ -0,0 +1,114 @@
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=19
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_RESOURCE_COUNTERS=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_BLK_CGROUP=y
+CONFIG_NAMESPACES=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_EMBEDDED=y
+# CONFIG_COMPAT_BRK is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_EFI_PARTITION=y
+CONFIG_ARCH_BCM=y
+CONFIG_ARM_THUMBEE=y
+CONFIG_ARM_ERRATA_743622=y
+CONFIG_PREEMPT=y
+CONFIG_AEABI=y
+# CONFIG_OABI_COMPAT is not set
+# CONFIG_COMPACTION is not set
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_CMDLINE="console=ttyS0,115200n8 mem=128M"
+CONFIG_CPU_IDLE=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_PM_RUNTIME=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_BLK_DEV is not set
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_SG=y
+CONFIG_SCSI_MULTI_LUN=y
+CONFIG_SCSI_SCAN_ASYNC=y
+CONFIG_INPUT_FF_MEMLESS=y
+CONFIG_INPUT_JOYDEV=y
+CONFIG_INPUT_EVDEV=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_UINPUT=y
+# CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_8250_RSA=y
+CONFIG_SERIAL_8250_DW=y
+CONFIG_HW_RANDOM=y
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+# CONFIG_HWMON is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=y
+CONFIG_FB=y
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_CLASS_DEVICE=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
+# CONFIG_USB_SUPPORT is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_AUTOFS4_FS=y
+CONFIG_FUSE_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_CONFIGFS_FS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_PRINTK_TIME=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=110
+CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_FTRACE is not set
+CONFIG_DEBUG_LL=y
+CONFIG_CRC_CCITT=y
+CONFIG_CRC_T10DIF=y
+CONFIG_CRC_ITU_T=y
+CONFIG_CRC7=y
+CONFIG_XZ_DEC=y
+CONFIG_AVERAGE=y
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
new file mode 100644
index 0000000..d53b48c
--- /dev/null
+++ b/arch/arm/mach-bcm/Kconfig
@@ -0,0 +1,18 @@
+config ARCH_BCM
+	bool "Broadcom SoC" if ARCH_MULTI_V7
+	depends on MMU
+	select CPU_V7
+	select ARM_GIC
+	select GENERIC_GPIO
+	select GPIO_BCM
+	select ARCH_REQUIRE_GPIOLIB
+	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
+	select TICK_ONESHOT
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369 if SMP
+	select SPARSE_IRQ
+	help
+	  This enables support for system based on Broadcom SoCs.
+          It currently supports BCM28145/28150/28155 chips.
+
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
new file mode 100644
index 0000000..bbf4122
--- /dev/null
+++ b/arch/arm/mach-bcm/Makefile
@@ -0,0 +1,13 @@
+#
+# Copyright (C) 2012 Broadcom Corporation
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation version 2.
+#
+# This program is distributed "as is" WITHOUT ANY WARRANTY of any
+# kind, whether express or implied; without even the implied warranty
+# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+obj-$(CONFIG_ARCH_BCM) := board_bcm.o
diff --git a/arch/arm/mach-bcm/board_bcm.c b/arch/arm/mach-bcm/board_bcm.c
new file mode 100644
index 0000000..a8165a5
--- /dev/null
+++ b/arch/arm/mach-bcm/board_bcm.c
@@ -0,0 +1,66 @@
+/*
+ * Copyright (C) 2012 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <asm/io.h>
+
+#include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#include <asm/mach/time.h>
+
+
+
+static const struct of_device_id irq_match[] = {
+	{.compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
+	{}
+};
+
+static void timer_init(void)
+{
+}
+
+static struct sys_timer timer = {
+	.init = timer_init,
+};
+
+static void __init init_irq(void)
+{
+	of_irq_init(irq_match);
+}
+
+static void __init board_init(void)
+{
+	l2x0_of_init(0x78450000, 0xC200ffff);
+
+	/* TODO: Add call to secure monitor to actually enable L2 */
+
+	of_platform_populate(NULL, of_default_bus_match_table, NULL,
+		&platform_bus);
+}
+
+static const char * const capri_dt_compat[] = { "bcm,capri", NULL, };
+
+
+DT_MACHINE_START(CAPRI_DT, "Broadcom Application Processor")
+	.init_irq = init_irq,
+	.timer = &timer,
+	.init_machine = board_init,
+	.dt_compat = capri_dt_compat,
+	.handle_irq = gic_handle_irq,
+MACHINE_END
-- 
1.7.9.5
