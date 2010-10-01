From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:30:11 -0700
Subject: [PATCH 47/47] davinci: Initial support for Omapl138-Hawkboard
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-48-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Rodriguez <vm.rod25@gmail.com>

This patch adds initial support for the Hawkboard-L138 system
It is under the machine name "omapl138_hawkboard".
This system is based on the da850 davinci CPU architecture.
Information on these system may be found at http://www.hawkboard.org.
Basic support for the UART console is included in this patch.
It's tested with latest Angstrom File Systems like ramdisk
from http://alturl.com/imb45.

Signed-off-by: Victor Rodriguez <victor.rodriguez@sasken.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/configs/da8xx_omapl_defconfig          |    1 +
 arch/arm/mach-davinci/Kconfig                   |    8 +++
 arch/arm/mach-davinci/Makefile                  |    1 +
 arch/arm/mach-davinci/board-omapl138-hawk.c     |   64 +++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/uncompress.h |    1 +
 5 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-davinci/board-omapl138-hawk.c

diff --git a/arch/arm/configs/da8xx_omapl_defconfig b/arch/arm/configs/da8xx_omapl_defconfig
index f8a47ee..cdc40c4 100644
--- a/arch/arm/configs/da8xx_omapl_defconfig
+++ b/arch/arm/configs/da8xx_omapl_defconfig
@@ -18,6 +18,7 @@ CONFIG_ARCH_DAVINCI=y
 CONFIG_ARCH_DAVINCI_DA830=y
 CONFIG_ARCH_DAVINCI_DA850=y
 CONFIG_MACH_MITYOMAPL138=y
+CONFIG_MACH_OMAPL138_HAWKBOARD=y
 CONFIG_DAVINCI_RESET_CLOCKS=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 9aca60c..b77b860 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -193,6 +193,14 @@ config MACH_MITYOMAPL138
 	  System on Module.  Information on this SoM may be found at
 	  http://www.mitydsp.com
 
+config MACH_OMAPL138_HAWKBOARD
+	bool "TI AM1808 / OMAPL-138 Hawkboard platform"
+	depends on ARCH_DAVINCI_DA850
+	help
+	  Say Y here to select the TI AM1808 / OMAPL-138 Hawkboard platform .
+	  Information of this board may be found at
+	  http://www.hawkboard.org/
+
 config DAVINCI_MUX
 	bool "DAVINCI multiplexing support"
 	depends on ARCH_DAVINCI
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index a7a70d1..0b87a1c 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_MACH_DAVINCI_DA830_EVM)	+= board-da830-evm.o
 obj-$(CONFIG_MACH_DAVINCI_DA850_EVM)	+= board-da850-evm.o
 obj-$(CONFIG_MACH_TNETV107X)		+= board-tnetv107x-evm.o
 obj-$(CONFIG_MACH_MITYOMAPL138)		+= board-mityomapl138.o
+obj-$(CONFIG_MACH_OMAPL138_HAWKBOARD)	+= board-omapl138-hawk.o
 
 # Power Management
 obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
new file mode 100644
index 0000000..c472dd8
--- /dev/null
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -0,0 +1,64 @@
+/*
+ * Hawkboard.org based on TI's OMAP-L138 Platform
+ *
+ * Initial code: Syed Mohammed Khasim
+ *
+ * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of
+ * any kind, whether express or implied.
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
+static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
+	.enabled_uarts = 0x7,
+};
+
+static __init void omapl138_hawk_init(void)
+{
+	int ret;
+
+	davinci_serial_init(&omapl138_hawk_uart_config);
+
+	ret = da8xx_register_watchdog();
+	if (ret)
+		pr_warning("omapl138_hawk_init: "
+			"watchdog registration failed: %d\n",
+			ret);
+}
+
+#ifdef CONFIG_SERIAL_8250_CONSOLE
+static int __init omapl138_hawk_console_init(void)
+{
+	if (!machine_is_omapl138_hawkboard())
+		return 0;
+
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
+MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
+	.phys_io	= IO_PHYS,
+	.io_pg_offst	= (__IO_ADDRESS(IO_PHYS) >> 18) & 0xfffc,
+	.boot_params	= (DA8XX_DDR_BASE + 0x100),
+	.map_io		= omapl138_hawk_map_io,
+	.init_irq	= cp_intc_init,
+	.timer		= &davinci_timer,
+	.init_machine	= omapl138_hawk_init,
+MACHINE_END
diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
index d370391..47723e8 100644
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ b/arch/arm/mach-davinci/include/mach/uncompress.h
@@ -89,6 +89,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		DEBUG_LL_DA8XX(davinci_da830_evm,	2);
 		DEBUG_LL_DA8XX(davinci_da850_evm,	2);
 		DEBUG_LL_DA8XX(mityomapl138,		1);
+		DEBUG_LL_DA8XX(omapl138_hawkboard,	2);
 
 		/* TNETV107x boards */
 		DEBUG_LL_TNETV107X(tnetv107x,		1);
-- 
1.7.2.1
