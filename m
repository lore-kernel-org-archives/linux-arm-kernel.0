From: per.forlin@stericsson.com (Per Forlin)
Date: Mon, 6 Dec 2010 13:52:24 +0100
Subject: [PATCH 2/3] ux500: Add eMMC support in U5500.
In-Reply-To: <1291639945-2866-2-git-send-email-per.forlin@stericsson.com>
References: <1291639945-2866-1-git-send-email-per.forlin@stericsson.com>
	<1291639945-2866-2-git-send-email-per.forlin@stericsson.com>
Message-ID: <1291639945-2866-3-git-send-email-per.forlin@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Per Forlin <per.forlin@linaro.org>

U5500 now boots from sdi0 (onboard eMMC).
Change machine type to U5500.
Adjust uart and sdi0 clock rates for u5500.
All necessary clocks must be enabled before Linux starts because
there is no clock tree support in u5500 yet.

Signed-off-by: Per Forlin <per.forlin@linaro.org>
---
 arch/arm/mach-ux500/Makefile             |    2 +-
 arch/arm/mach-ux500/board-u5500-sdi.c    |   49 ++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/board-u5500.c        |    3 +-
 arch/arm/mach-ux500/clock.c              |    2 +
 arch/arm/mach-ux500/include/mach/setup.h |    3 ++
 5 files changed, 57 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-u5500-sdi.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 0612013..fb65e59 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -6,7 +6,7 @@ obj-y				:= clock.o cpu.o devices.o devices-common.o
 obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o devices-db5500.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o prcmu.o
 obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o board-mop500-sdi.o
-obj-$(CONFIG_MACH_U5500)	+= board-u5500.o
+obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
diff --git a/arch/arm/mach-ux500/board-u5500-sdi.c b/arch/arm/mach-ux500/board-u5500-sdi.c
new file mode 100644
index 0000000..54712ac
--- /dev/null
+++ b/arch/arm/mach-ux500/board-u5500-sdi.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Hanumath Prasad <ulf.hansson@stericsson.com>
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/amba/mmci.h>
+#include <linux/mmc/host.h>
+#include <linux/gpio.h>
+
+#include <plat/pincfg.h>
+#include <mach/db5500-regs.h>
+#include <plat/ste_dma40.h>
+
+#include "pins-db5500.h"
+#include "devices-db5500.h"
+#include "ste-dma40-db5500.h"
+
+static pin_cfg_t u5500_sdi_pins[] = {
+	/* SDI0 (POP eMMC) */
+	GPIO5_MC0_DAT0		| PIN_DIR_INPUT | PIN_PULL_UP,
+	GPIO6_MC0_DAT1		| PIN_DIR_INPUT | PIN_PULL_UP,
+	GPIO7_MC0_DAT2		| PIN_DIR_INPUT | PIN_PULL_UP,
+	GPIO8_MC0_DAT3		| PIN_DIR_INPUT | PIN_PULL_UP,
+	GPIO9_MC0_DAT4		| PIN_DIR_INPUT | PIN_PULL_UP,
+	GPIO10_MC0_DAT5		| PIN_DIR_INPUT | PIN_PULL_UP,
+	GPIO11_MC0_DAT6		| PIN_DIR_INPUT | PIN_PULL_UP,
+	GPIO12_MC0_DAT7		| PIN_DIR_INPUT | PIN_PULL_UP,
+	GPIO13_MC0_CMD		| PIN_DIR_INPUT | PIN_PULL_UP,
+	GPIO14_MC0_CLK		| PIN_DIR_OUTPUT | PIN_VAL_LOW,
+};
+
+static struct mmci_platform_data u5500_sdi0_data = {
+	.ocr_mask	= MMC_VDD_165_195,
+	.f_max		= 50000000,
+	.capabilities	= MMC_CAP_4_BIT_DATA |
+				MMC_CAP_8_BIT_DATA |
+				MMC_CAP_MMC_HIGHSPEED,
+	.gpio_cd	= -1,
+	.gpio_wp	= -1,
+};
+
+void __init u5500_sdi_init(void)
+{
+	nmk_config_pins(u5500_sdi_pins, ARRAY_SIZE(u5500_sdi_pins));
+
+	db5500_add_sdi0(&u5500_sdi0_data);
+}
diff --git a/arch/arm/mach-ux500/board-u5500.c b/arch/arm/mach-ux500/board-u5500.c
index 9a5db95..39d370c 100644
--- a/arch/arm/mach-ux500/board-u5500.c
+++ b/arch/arm/mach-ux500/board-u5500.c
@@ -31,10 +31,11 @@ static void __init u5500_init_machine(void)
 {
 	u5500_init_devices();
 
+	u5500_sdi_init();
 	u5500_uart_init();
 }
 
-MACHINE_START(U8500, "ST-Ericsson U5500 Platform")
+MACHINE_START(U5500, "ST-Ericsson U5500 Platform")
 	.boot_params	= 0x00000100,
 	.map_io		= u5500_map_io,
 	.init_irq	= ux500_init_irq,
diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index 1675047..22c0572 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -610,6 +610,8 @@ int __init clk_init(void)
 		clk_prcc_ops.enable = clk_prcc_ops.disable = NULL;
 		clk_prcmu_ops.enable = clk_prcmu_ops.disable = NULL;
 		clk_per6clk.rate = 26000000;
+		clk_uartclk.rate = 36360000;
+		clk_sdmmcclk.rate = 99900000;
 	}
 
 	clkdev_add_table(u8500_common_clks, ARRAY_SIZE(u8500_common_clks));
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index 322a1c1..22788a7 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -22,6 +22,9 @@ extern void __init u5500_init_devices(void);
 extern void __init u8500_init_devices(void);
 
 extern void __init ux500_init_irq(void);
+
+extern void __init u5500_sdi_init(void);
+
 /* We re-use nomadik_timer for this platform */
 extern void nmdk_timer_init(void);
 
-- 
1.6.3.3
