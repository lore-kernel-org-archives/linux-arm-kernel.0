From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 11:42:15 +0100
Subject: [PATCH 01/17] ARM: pxa/raumfeld: add basic structure for devices
In-Reply-To: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
Message-ID: <1259145751-3331-2-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No function yet, just the file skeletons.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-pxa/Kconfig    |   18 ++++++
 arch/arm/mach-pxa/Makefile   |    3 +
 arch/arm/mach-pxa/raumfeld.c |  122 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-pxa/raumfeld.c

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 20e645a..f4dd069 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -399,6 +399,24 @@ config MACH_TREO680
 	  Say Y here if you intend to run this kernel on Palm Treo 680
 	  smartphone.
 
+config MACH_RAUMFELD_RC
+	bool "Raumfeld Controller"
+	select PXA3xx
+	select CPU_PXA300
+	select HAVE_PWM
+
+config MACH_RAUMFELD_CONNECTOR
+	bool "Raumfeld Connector"
+	select PXA3xx
+	select CPU_PXA300
+	select PXA_SSP
+
+config MACH_RAUMFELD_SPEAKER
+	bool "Raumfeld Speaker"
+	select PXA3xx
+	select CPU_PXA300
+	select PXA_SSP
+
 config PXA_SHARPSL
 	bool "SHARP Zaurus SL-5600, SL-C7xx and SL-Cxx00 Models"
 	select SHARP_SCOOP
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index b5d29e6..1ed7509 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -88,6 +88,9 @@ obj-$(CONFIG_MACH_E740)		+= e740.o
 obj-$(CONFIG_MACH_E750)		+= e750.o
 obj-$(CONFIG_MACH_E400)		+= e400.o
 obj-$(CONFIG_MACH_E800)		+= e800.o
+obj-$(CONFIG_MACH_RAUMFELD_RC)		+= raumfeld.o
+obj-$(CONFIG_MACH_RAUMFELD_CONNECTOR)	+= raumfeld.o
+obj-$(CONFIG_MACH_RAUMFELD_SPEAKER)	+= raumfeld.o
 
 # Support for blinky lights
 led-y := leds.o
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
new file mode 100644
index 0000000..89ead5f
--- /dev/null
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -0,0 +1,122 @@
+/*
+ * arch/arm/mach-pxa/raumfeld.c
+ *
+ * Support for the following Raumfeld devices:
+ *
+ * 	* Controller
+ *  	* Connector
+ *  	* Speaker S/M
+ *
+ * See http://www.raumfeld.com for details.
+ *
+ * Copyright (c) 2009 Daniel Mack <daniel@caiaq.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sysdev.h>
+#include <linux/interrupt.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/hardware.h>
+#include <mach/pxa3xx-regs.h>
+#include <mach/mfp-pxa3xx.h>
+#include <mach/mfp-pxa300.h>
+
+#include "generic.h"
+#include "devices.h"
+#include "clock.h"
+
+/*
+ * GPIO configuration (common for all hardware platforms)
+ */
+static mfp_cfg_t raumfeld_pin_config[] __initdata = {
+	/* UART1 */
+	GPIO77_UART1_RXD,
+	GPIO78_UART1_TXD,
+	GPIO79_UART1_CTS,
+	GPIO81_UART1_DSR,
+	GPIO83_UART1_DTR,
+	GPIO84_UART1_RTS,
+
+	/* UART3 */
+	GPIO110_UART3_RXD,
+};
+
+static void __init raumfeld_common_init(void)
+{
+	enable_irq_wake(IRQ_WAKEUP0);
+	pxa_set_ffuart_info(NULL);
+
+	gpio_request(mfp_to_gpio(GPIO_W2W_RESET), "Wi2Wi reset");
+	gpio_direction_output(mfp_to_gpio(GPIO_W2W_RESET), 0);
+
+	gpio_request(mfp_to_gpio(GPIO_W2W_PDN), "Wi2Wi powerup");
+	gpio_direction_output(mfp_to_gpio(GPIO_W2W_PDN), 0);
+
+	/* this can be used to switch off the device */
+	gpio_request(mfp_to_gpio(GPIO_SHUTDOWN_SUPPLY), "supply shutdown");
+	gpio_direction_output(mfp_to_gpio(GPIO_SHUTDOWN_SUPPLY), 0);
+
+	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_pin_config));
+}
+
+static void __init raumfeld_controller_init(void)
+{
+	raumfeld_common_init();
+}
+
+static void __init raumfeld_connector_init(void)
+{
+	raumfeld_common_init();
+}
+
+static void __init raumfeld_speaker_init(void)
+{
+	raumfeld_common_init();
+}
+
+/* physical memory regions */
+#define	RAUMFELD_SDRAM_BASE	0xa0000000	/* SDRAM region */
+
+#ifdef CONFIG_MACH_RAUMFELD_RC
+MACHINE_START(RAUMFELD_RC, "Raumfeld Controller")
+	.phys_io	= 0x40000000,
+	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
+	.init_machine	= raumfeld_controller_init,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa3xx_init_irq,
+	.timer		= &pxa_timer,
+MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_RAUMFELD_CONNECTOR
+MACHINE_START(RAUMFELD_CONNECTOR, "Raumfeld Connector")
+	.phys_io	= 0x40000000,
+	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
+	.init_machine	= raumfeld_connector_init,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa3xx_init_irq,
+	.timer		= &pxa_timer,
+MACHINE_END
+#endif
+
+#ifdef CONFIG_MACH_RAUMFELD_SPEAKER
+MACHINE_START(RAUMFELD_SPEAKER, "Raumfeld Speaker")
+	.phys_io	= 0x40000000,
+	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
+	.boot_params	= RAUMFELD_SDRAM_BASE + 0x100,
+	.init_machine	= raumfeld_speaker_init,
+	.map_io		= pxa_map_io,
+	.init_irq	= pxa3xx_init_irq,
+	.timer		= &pxa_timer,
+MACHINE_END
+#endif
-- 
1.6.5.2
