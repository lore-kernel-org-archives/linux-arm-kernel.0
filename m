From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 08 Feb 2010 20:02:54 +0900
Subject: [PATCH] ARM: mach-shmobile: early console support using earlyprintk
Message-ID: <20100208110254.6001.31943.sendpatchset@rxone.opensource.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add support for early console to the SH-Mobile boards.

Simply perform an early platform probe for "earlyprintk"
to trigger the early serial console code in sh-sci.c.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/configs/ap4evb_defconfig            |    2 -
 arch/arm/configs/g3evm_defconfig             |    2 -
 arch/arm/configs/g4evm_defconfig             |    2 -
 arch/arm/mach-shmobile/Makefile              |    2 -
 arch/arm/mach-shmobile/board-ap4evb.c        |    3 +-
 arch/arm/mach-shmobile/board-g3evm.c         |    3 +-
 arch/arm/mach-shmobile/board-g4evm.c         |    3 +-
 arch/arm/mach-shmobile/console.c             |   32 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 9 files changed, 43 insertions(+), 7 deletions(-)

--- 0011/arch/arm/configs/ap4evb_defconfig
+++ work/arch/arm/configs/ap4evb_defconfig	2010-02-08 12:46:02.000000000 +0900
@@ -322,7 +322,7 @@ CONFIG_ALIGNMENT_TRAP=y
 #
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=ttySC0,115200"
+CONFIG_CMDLINE="console=ttySC0,115200 earlyprintk=sh-sci.0,115200"
 # CONFIG_XIP_KERNEL is not set
 CONFIG_KEXEC=y
 CONFIG_ATAGS_PROC=y
--- 0011/arch/arm/configs/g3evm_defconfig
+++ work/arch/arm/configs/g3evm_defconfig	2010-02-08 12:45:34.000000000 +0900
@@ -317,7 +317,7 @@ CONFIG_ALIGNMENT_TRAP=y
 #
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=ttySC1,115200"
+CONFIG_CMDLINE="console=ttySC1,115200 earlyprintk=sh-sci.1,115200"
 # CONFIG_XIP_KERNEL is not set
 CONFIG_KEXEC=y
 CONFIG_ATAGS_PROC=y
--- 0011/arch/arm/configs/g4evm_defconfig
+++ work/arch/arm/configs/g4evm_defconfig	2010-02-08 12:45:50.000000000 +0900
@@ -322,7 +322,7 @@ CONFIG_ALIGNMENT_TRAP=y
 #
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=ttySC4,115200"
+CONFIG_CMDLINE="console=ttySC4,115200 earlyprintk=sh-sci.4,115200"
 # CONFIG_XIP_KERNEL is not set
 CONFIG_KEXEC=y
 CONFIG_ATAGS_PROC=y
--- 0004/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-02-08 12:43:21.000000000 +0900
@@ -3,7 +3,7 @@
 #
 
 # Common objects
-obj-y				:= timer.o
+obj-y				:= timer.o console.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o
--- 0004/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2010-02-08 12:47:07.000000000 +0900
@@ -105,9 +105,10 @@ static void __init ap4evb_map_io(void)
 {
 	iotable_init(ap4evb_io_desc, ARRAY_SIZE(ap4evb_io_desc));
 
-	/* setup early devices and clocks here as well */
+	/* setup early devices, clocks and console here as well */
 	sh7372_add_early_devices();
 	sh7367_clock_init(); /* use g3 clocks for now */
+	shmobile_setup_console();
 }
 
 static void __init ap4evb_init(void)
--- 0002/arch/arm/mach-shmobile/board-g3evm.c
+++ work/arch/arm/mach-shmobile/board-g3evm.c	2010-02-08 12:46:31.000000000 +0900
@@ -105,9 +105,10 @@ static void __init g3evm_map_io(void)
 {
 	iotable_init(g3evm_io_desc, ARRAY_SIZE(g3evm_io_desc));
 
-	/* setup early devices and clocks here as well */
+	/* setup early devices, clocks and console here as well */
 	sh7367_add_early_devices();
 	sh7367_clock_init();
+	shmobile_setup_console();
 }
 
 static void __init g3evm_init(void)
--- 0003/arch/arm/mach-shmobile/board-g4evm.c
+++ work/arch/arm/mach-shmobile/board-g4evm.c	2010-02-08 12:46:50.000000000 +0900
@@ -105,9 +105,10 @@ static void __init g4evm_map_io(void)
 {
 	iotable_init(g4evm_io_desc, ARRAY_SIZE(g4evm_io_desc));
 
-	/* setup early devices and clocks here as well */
+	/* setup early devices, clocks and console here as well */
 	sh7377_add_early_devices();
 	sh7367_clock_init(); /* use g3 clocks for now */
+	shmobile_setup_console();
 }
 
 static void __init g4evm_init(void)
--- /dev/null
+++ work/arch/arm/mach-shmobile/console.c	2010-02-08 12:47:32.000000000 +0900
@@ -0,0 +1,32 @@
+/*
+ * SH-Mobile Console
+ *
+ * Copyright (C) 2010  Magnus Damm
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
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <mach/common.h>
+#include <asm/mach/map.h>
+
+void __init shmobile_setup_console(void)
+{
+	parse_early_param();
+
+	/* Let earlyprintk output early console messages */
+	early_platform_driver_probe("earlyprintk", 1, 1);
+}
+
--- 0004/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-02-08 12:47:15.000000000 +0900
@@ -2,6 +2,7 @@
 #define __ARCH_MACH_COMMON_H
 
 extern struct sys_timer shmobile_timer;
+extern void shmobile_setup_console(void);
 
 extern void sh7367_init_irq(void);
 extern void sh7367_add_early_devices(void);
