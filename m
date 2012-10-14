From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 14 Oct 2012 23:46:38 +0200
Subject: [PATCH 4/5] ARM: AT91: Add AT91RM9200 DT board
In-Reply-To: <1350251199-28065-1-git-send-email-manabian@gmail.com>
References: <1350251199-28065-1-git-send-email-manabian@gmail.com>
Message-ID: <1350251199-28065-5-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/mach-at91/Kconfig           |  8 +++++
 arch/arm/mach-at91/Makefile          |  1 +
 arch/arm/mach-at91/board-rm9200-dt.c | 59 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/generic.h         |  1 +
 arch/arm/mach-at91/setup.c           | 14 +++++++++
 5 files changed, 83 insertions(+)
 create mode 100644 arch/arm/mach-at91/board-rm9200-dt.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index d9b0546..3f45906 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -505,6 +505,14 @@ endif
 
 comment "Generic Board Type"
 
+config MACH_AT91RM9200_DT
+	bool "Atmel AT91RM9200 Evaluation Kits with device-tree support"
+	select SOC_AT91RM9200
+	select USE_OF
+	help
+	  Select this if you want to experiment device-tree with
+	  an Atmel RM9200 Evaluation Kit.
+
 config MACH_AT91SAM_DT
 	bool "Atmel AT91SAM Evaluation Kits with device-tree support"
 	select SOC_AT91SAM9
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index d6e0d21..75dee683 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_MACH_SNAPPER_9260)	+= board-snapper9260.o
 obj-$(CONFIG_MACH_AT91SAM9M10G45EK) += board-sam9m10g45ek.o
 
 # AT91SAM board with device-tree
+obj-$(CONFIG_MACH_AT91RM9200_DT) += board-rm9200-dt.o
 obj-$(CONFIG_MACH_AT91SAM_DT) += board-dt.o
 
 # AT91X40 board-specific support
diff --git a/arch/arm/mach-at91/board-rm9200-dt.c b/arch/arm/mach-at91/board-rm9200-dt.c
new file mode 100644
index 0000000..47e91d9
--- /dev/null
+++ b/arch/arm/mach-at91/board-rm9200-dt.c
@@ -0,0 +1,59 @@
+/*
+ *  Setup code for AT91RM9200 Evaluation Kits with Device Tree support
+ *
+ *  Copyright (C) 2011 Atmel,
+ *                2011 Nicolas Ferre <nicolas.ferre@atmel.com>
+ *                2012 Joachim Eastwood <manabian@gmail.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+
+#include <mach/board.h>
+#include <mach/at91_aic.h>
+
+#include <asm/setup.h>
+#include <asm/irq.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include "generic.h"
+
+
+static const struct of_device_id irq_of_match[] __initconst = {
+	{ .compatible = "atmel,at91rm9200-aic", .data = at91_aic_of_init },
+	{ /*sentinel*/ }
+};
+
+static void __init at91rm9200_dt_init_irq(void)
+{
+	of_irq_init(irq_of_match);
+}
+
+static void __init at91rm9200_dt_device_init(void)
+{
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
+static const char *at91rm9200_dt_board_compat[] __initdata = {
+	"atmel,at91rm9200",
+	NULL
+};
+
+DT_MACHINE_START(at91rm9200_dt, "Atmel AT91RM9200 (Device Tree)")
+	.timer		= &at91rm9200_timer,
+	.map_io		= at91_map_io,
+	.handle_irq	= at91_aic_handle_irq,
+	.init_early	= at91rm9200_dt_initialize,
+	.init_irq	= at91rm9200_dt_init_irq,
+	.init_machine	= at91rm9200_dt_device_init,
+	.dt_compat	= at91rm9200_dt_board_compat,
+MACHINE_END
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index f496506..9bb5ce5 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -20,6 +20,7 @@ extern void __init at91_init_sram(int bank, unsigned long base,
 extern void __init at91rm9200_set_type(int type);
 extern void __init at91_initialize(unsigned long main_clock);
 extern void __init at91x40_initialize(unsigned long main_clock);
+extern void __init at91rm9200_dt_initialize(void);
 extern void __init at91_dt_initialize(void);
 
  /* Interrupts */
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 523daa9..e3f1ea4 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -339,6 +339,7 @@ static void at91_dt_rstc(void)
 }
 
 static struct of_device_id ramc_ids[] = {
+	{ .compatible = "atmel,at91rm9200-sdramc" },
 	{ .compatible = "atmel,at91sam9260-sdramc" },
 	{ .compatible = "atmel,at91sam9g45-ddramc" },
 	{ /*sentinel*/ }
@@ -437,6 +438,19 @@ end:
 	of_node_put(np);
 }
 
+void __init at91rm9200_dt_initialize(void)
+{
+	at91_dt_ramc();
+
+	/* Init clock subsystem */
+	at91_dt_clock_init();
+
+	/* Register the processor-specific clocks */
+	at91_boot_soc.register_clocks();
+
+	at91_boot_soc.init();
+}
+
 void __init at91_dt_initialize(void)
 {
 	at91_dt_rstc();
-- 
1.7.12.3
