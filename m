From: vm.rod25@gmail.com (Victor Rodriguez)
Date: Sat, 28 Aug 2010 13:18:23 -0500
Subject: [PATCH] hawkboard
Message-ID: <1283019503-3070-1-git-send-email-vm.rod25@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basic support for Hawkboard OMAPL138 just UART cominication is included

Signed-off-by: Victor Rodriguez <vm.rod25@gmail.com>

Notes: This patch is checked with 0a50e05b20f3c6af67656303bdb3661a2541ce03 from
	Kernel development tree for TI DaVinci family of processors

	This patch works with basic da8xx_omapl_defconfig, it just have basic support
	for UART console
---
 arch/arm/mach-davinci/Kconfig                   |    9 +++
 arch/arm/mach-davinci/Makefile                  |    1 +
 arch/arm/mach-davinci/board-da850-hawk.c        |   69 +++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/uncompress.h |    1 +
 4 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-davinci/board-da850-hawk.c

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 2bf03e9..fd8a11c 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -185,6 +185,15 @@ config MACH_TNETV107X
 	help
 	  Say Y here to select the TI TNETV107X Evaluation Module.
 
+config MACH_OMAPL138_HAWKBOARD
+	bool "TI DA850/OMAP-L138/AM18xx Hawkboard(.org) Platform"
+	default ARCH_DAVINCI_DA850
+	depends on ARCH_DAVINCI_DA850
+	help
+	  Say Y here to select the TI DA850/OMAP-L138/AM18xx Hawkboard.
+	  Information of this board may be found at
+	  http://www.hawkboard.org/
+
 config DAVINCI_MUX
 	bool "DAVINCI multiplexing support"
 	depends on ARCH_DAVINCI
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index eab4c0f..fd271cd 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_MACH_DAVINCI_DM365_EVM)	+= board-dm365-evm.o
 obj-$(CONFIG_MACH_DAVINCI_DA830_EVM)	+= board-da830-evm.o
 obj-$(CONFIG_MACH_DAVINCI_DA850_EVM)	+= board-da850-evm.o
 obj-$(CONFIG_MACH_TNETV107X)		+= board-tnetv107x-evm.o
+obj-$(CONFIG_MACH_OMAPL138_HAWKBOARD)	+= board-da850-hawk.o
 
 # Power Management
 obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o
diff --git a/arch/arm/mach-davinci/board-da850-hawk.c b/arch/arm/mach-davinci/board-da850-hawk.c
new file mode 100644
index 0000000..e34bcbb
--- /dev/null
+++ b/arch/arm/mach-davinci/board-da850-hawk.c
@@ -0,0 +1,69 @@
+/*
+ * Hawkboar.org based on TI's OMAP-L138 Platform
+ *
+ * Initial code: Syed Mohammed Khasim
+ *
+ * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Derived from: arch/arm/mach-davinci/board-da850-evm.c
+ * Original Copyrights follow:
+ *
+ * 2007, 2009 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/console.h>
+#include <linux/gpio.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/cp_intc.h>
+#include <mach/da8xx.h>
+
+
+
+static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
+	.enabled_uarts = 0x7,
+};
+
+static __init void omapl138_hawk_init(void)
+{
+
+	davinci_serial_init(&omapl138_hawk_uart_config);
+
+	/*
+	 * shut down uart 0 and 1; they are not used on the board and
+	 * accessing them causes endless "too much work in irq53" messages
+	 * with arago fs
+	 */
+	__raw_writel(0, IO_ADDRESS(DA8XX_UART1_BASE) + 0x30);
+	__raw_writel(0, IO_ADDRESS(DA8XX_UART0_BASE) + 0x30);
+
+}
+
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+static int __init omapl138_hawk_console_init(void)
+{
+	return add_preferred_console("ttyS", 2, "115200");
+}
+console_initcall(omapl138_hawk_console_init);
+#endif
+
+static void __init omapl138_hawk_map_io(void)
+{
+	da850_init();
+}
+
+MACHINE_START(OMAPL138_HAWKBOARD, "OMAPL 138 Hawkboard.org")
+	.phys_io	= IO_PHYS,
+	.io_pg_offst	= (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
+	.boot_params	= (DA8XX_DDR_BASE + 0x100),
+	.map_io		= omapl138_hawk_map_io,
+	.init_irq	= cp_intc_init,
+	.timer		= &davinci_timer,
+	.init_machine	= omapl138_hawk_init,
+MACHINE_END
diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
index 15a6192..640f834 100644
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ b/arch/arm/mach-davinci/include/mach/uncompress.h
@@ -88,6 +88,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		/* DA8xx boards */
 		DEBUG_LL_DA8XX(davinci_da830_evm,	2);
 		DEBUG_LL_DA8XX(davinci_da850_evm,	2);
+		DEBUG_LL_DA8XX(omapl138_hawkboard,	2);
 
 		/* TNETV107x boards */
 		DEBUG_LL_TNETV107X(tnetv107x,		1);
-- 
1.6.0.5
