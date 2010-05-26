From: hjk@linutronix.de (Hans J. Koch)
Date: Wed, 26 May 2010 19:53:38 +0200
Subject: [PATCH 7/7 v6] Add board support for Telechips TCC8000-SDK board
In-Reply-To: <20100526174240.GC2006@bluebox.local>
References: <20100526174240.GC2006@bluebox.local>
Message-ID: <20100526175336.GJ2006@bluebox.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Telechips TCC8000-SDK development board.

Signed-off-by: "Hans J. Koch" <hjk@linutronix.de>
---
 arch/arm/mach-tcc8k/Kconfig             |    6 +++
 arch/arm/mach-tcc8k/Makefile            |    3 ++
 arch/arm/mach-tcc8k/Makefile.boot       |    3 ++
 arch/arm/mach-tcc8k/board-tcc8000-sdk.c |   59 +++++++++++++++++++++++++++++++
 arch/arm/mach-tcc8k/board-tcc8000-sdk.h |   18 +++++++++
 5 files changed, 89 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tcc8k/Makefile.boot
 create mode 100644 arch/arm/mach-tcc8k/board-tcc8000-sdk.c
 create mode 100644 arch/arm/mach-tcc8k/board-tcc8000-sdk.h

diff --git a/arch/arm/mach-tcc8k/Kconfig b/arch/arm/mach-tcc8k/Kconfig
index ec7f71b..ad86415 100644
--- a/arch/arm/mach-tcc8k/Kconfig
+++ b/arch/arm/mach-tcc8k/Kconfig
@@ -2,4 +2,10 @@ if ARCH_TCC8K
 
 comment "TCC8000 systems:"
 
+config MACH_TCC8000_SDK
+	bool "Telechips TCC8000-SDK development kit"
+	default y
+	help
+	  Support for the Telechips TCC8000-SDK board.
+
 endif
diff --git a/arch/arm/mach-tcc8k/Makefile b/arch/arm/mach-tcc8k/Makefile
index e8a1134..cd92cde 100644
--- a/arch/arm/mach-tcc8k/Makefile
+++ b/arch/arm/mach-tcc8k/Makefile
@@ -5,3 +5,6 @@
 # Common support
 obj-y += clock.o irq.o time.o io.o devices.o
 
+# Specific board support
+obj-$(CONFIG_MACH_TCC8000_SDK) += board-tcc8000-sdk.o
+
diff --git a/arch/arm/mach-tcc8k/Makefile.boot b/arch/arm/mach-tcc8k/Makefile.boot
new file mode 100644
index 0000000..f135c9d
--- /dev/null
+++ b/arch/arm/mach-tcc8k/Makefile.boot
@@ -0,0 +1,3 @@
+   zreladdr-y		:= 0x20008000
+params_phys-y		:= 0x20000100
+initrd_phys-y		:= 0x20800000
diff --git a/arch/arm/mach-tcc8k/board-tcc8000-sdk.c b/arch/arm/mach-tcc8k/board-tcc8000-sdk.c
new file mode 100644
index 0000000..545e586
--- /dev/null
+++ b/arch/arm/mach-tcc8k/board-tcc8000-sdk.c
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2009 Hans J. Koch <hjk@linutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#include <asm/mach-types.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/time.h>
+
+#include "board-tcc8000-sdk.h"
+
+#ifdef CONFIG_MTD_NAND_TCC
+/* NAND */
+static struct tcc_nand_platform_data tcc8k_sdk_nand_data = {
+	.width = 1,
+	.hw_ecc = 0,
+};
+#endif
+
+static void __init tcc8k_init(void)
+{
+#ifdef CONFIG_MTD_NAND_TCC
+	tcc_nand_device.dev.platform_data = &tcc8k_sdk_nand_data;
+	platform_device_register(&tcc_nand_device);
+#endif
+}
+
+static void __init tcc8k_timer_init(void)
+{
+	tcc_clocks_init(XI_FREQUENCY, XTI_FREQUENCY);
+}
+
+static struct sys_timer tcc8k_timer = {
+	.init	= tcc8k_timer_init,
+};
+
+static void __init tcc8k_map_io(void)
+{
+	tcc8k_map_common_io();
+}
+
+MACHINE_START(TCC8000_SDK, "Telechips TCC8000-SDK Demo Board")
+	.phys_io	= 0x90000000,
+	.io_pg_offst	= ((0xf1000000) >> 18) & 0xfffc,
+	.boot_params	= PHYS_OFFSET + 0x00000100,
+	.map_io		= tcc8k_map_io,
+	.init_irq	= tcc8k_init_irq,
+	.init_machine	= tcc8k_init,
+	.timer		= &tcc8k_timer,
+MACHINE_END
diff --git a/arch/arm/mach-tcc8k/board-tcc8000-sdk.h b/arch/arm/mach-tcc8k/board-tcc8000-sdk.h
new file mode 100644
index 0000000..1d4e791
--- /dev/null
+++ b/arch/arm/mach-tcc8k/board-tcc8000-sdk.h
@@ -0,0 +1,18 @@
+/*
+ * Some defines for arch/arm/mach-tcc8k/board-tcc8000-sdk.c
+ *
+ */
+
+#ifndef _BOARD_TCC_8000_SDK_H_
+#define _BOARD_TCC_8000_SDK_H_
+
+extern void __init tcc8k_init_irq(void);
+extern void __init tcc8k_map_common_io(void);
+extern int __init tcc_clocks_init(unsigned long xi_freq,
+					unsigned long xti_freq);
+extern struct platform_device tcc_nand_device;
+
+#define XI_FREQUENCY	12000000
+#define XTI_FREQUENCY	32768
+
+#endif
-- 
1.6.3.3
