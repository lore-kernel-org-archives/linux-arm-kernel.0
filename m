From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 23 Nov 2010 10:06:12 +0000
Subject: [RFC PATCH 11/13] picoxcell: add support for pc3x2 devices
In-Reply-To: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
References: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1290506774-17895-12-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PC3X2 is the first supported device family of picoXcell and this patch
defines the virtual clocks to allow drivers to work, the pin muxing
options, timer locations and the GPIO definitions.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/Kconfig          |    7 +
 arch/arm/mach-picoxcell/Makefile         |    1 +
 arch/arm/mach-picoxcell/pc3x2.c          |  453 ++++++++++++++++++++++++++++++
 arch/arm/mach-picoxcell/picoxcell_core.c |   13 +-
 arch/arm/mach-picoxcell/soc.h            |    1 +
 5 files changed, 474 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-picoxcell/Kconfig b/arch/arm/mach-picoxcell/Kconfig
index 3daba53..5141202 100644
--- a/arch/arm/mach-picoxcell/Kconfig
+++ b/arch/arm/mach-picoxcell/Kconfig
@@ -1,4 +1,11 @@
 menu "PICOXCELL platform type"
 	depends on ARCH_PICOXCELL
 
+config PICOXCELL_PC3X2
+	bool "Support PC3x2 devices"
+	default y
+	help
+	  Include support for picoChip PC3x2 family of devices. This
+	  includes PC302 and PC312.
+
 endmenu
diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index 09ae582..ab5dec1 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -6,3 +6,4 @@ obj-y				:= picoxcell_core.o axi2cfg.o \
 				   devices.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 obj-$(CONFIG_PM)		+= pm.o
+obj-$(CONFIG_PICOXCELL_PC3X2)	+= pc3x2.o
diff --git a/arch/arm/mach-picoxcell/pc3x2.c b/arch/arm/mach-picoxcell/pc3x2.c
new file mode 100644
index 0000000..31d52e9
--- /dev/null
+++ b/arch/arm/mach-picoxcell/pc3x2.c
@@ -0,0 +1,453 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+
+#include <asm/mach/map.h>
+
+#include <mach/clkdev.h>
+#include <mach/hardware.h>
+
+#include "mux.h"
+#include "picoxcell_core.h"
+#include "soc.h"
+
+FIXED_CLK(spi,		CLOCK_TICK_RATE, -1);
+FIXED_CLK(dmac0,	CLOCK_TICK_RATE, -1);
+FIXED_CLK(dmac1,	CLOCK_TICK_RATE, -1);
+FIXED_CLK(ebi,		CLOCK_TICK_RATE, -1);
+FIXED_CLK(ipsec,	CLOCK_TICK_RATE, -1);
+FIXED_CLK(l2_engine,	CLOCK_TICK_RATE, -1);
+FIXED_CLK(fuse,		CLOCK_TICK_RATE, -1);
+FIXED_CLK(tzpc,		CLOCK_TICK_RATE, -1);
+FIXED_CLK(wdt,		CLOCK_TICK_RATE, -1);
+
+static struct clk_lookup pc3x2_clk_lookup[] = {
+	CLK_LOOKUP("dw_spi_mmio.0",	NULL,		&spi_clk),
+	CLK_LOOKUP("dw_dmac.0",		NULL,		&dmac0_clk),
+	CLK_LOOKUP("dw_dmac.1",		NULL,		&dmac1_clk),
+	CLK_LOOKUP(NULL,		"ebi",		&ebi_clk),
+	CLK_LOOKUP(NULL,		"tzprot_ctrl",	&tzpc_clk),
+	CLK_LOOKUP("picoxcell-ipsec",	NULL,		&ipsec_clk),
+	CLK_LOOKUP("picoxcell-l2",	NULL,		&l2_engine_clk),
+	CLK_LOOKUP("picoxcell-fuse",	NULL,		&fuse_clk),
+	CLK_LOOKUP("dw_wdt",		NULL,		&wdt_clk),
+};
+
+static void pc3x2_clk_init(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pc3x2_clk_lookup); ++i) {
+		struct clk_lookup *lookup = &pc3x2_clk_lookup[i];
+
+		picoxcell_clk_add(lookup);
+	}
+}
+
+static ssize_t pc3x2_get_boot_mode(char *buf)
+{
+	unsigned long syscfg = syscfg_read();
+	const char *boot_mode;
+
+	switch (syscfg & 0x3) {
+	case 0x0:
+		boot_mode = "parallel";
+		break;
+	case 0x1:
+		boot_mode = "ssi";
+		break;
+	case 0x2:
+		boot_mode = "mii";
+		break;
+	default:
+		boot_mode = "unknown";
+	}
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", boot_mode);
+}
+
+static int
+pai_get_mux(struct muxed_pin *pin)
+{
+#define PAI_GPIO_PIN_ARM_4	0xB
+#define PAI_GPIO_PIN_ARM_5	0xA
+#define PAI_GPIO_PIN_ARM_6	0x9
+#define PAI_GPIO_PIN_ARM_7	0x8
+#define PAI_GPIO_PIN_SDGPIO_4	0x7
+#define PAI_GPIO_PIN_SDGPIO_5	0x6
+#define PAI_GPIO_PIN_SDGPIO_6	0x5
+#define PAI_GPIO_PIN_SDGPIO_7	0x4
+#define PICOXCELL_PAI_CAEID		0x8080
+#define PAI_SLEEP_REG		0xA060
+#define PAI_IO_CTRL_REG		0x0009
+
+	/* Make sure that the PAI block is awake. */
+	u16 data = 0, sd_mask = 0, arm_mask = 0;
+	int ret;
+
+	axi2cfg_config_write(PICOXCELL_PAI_CAEID, PAI_SLEEP_REG, &data, 1);
+	/* Get the current PAI muxing configuration. */
+	ret = axi2cfg_config_read(PICOXCELL_PAI_CAEID, PAI_IO_CTRL_REG,
+				  &data, 1);
+	if (1 != ret) {
+		pr_warning("unable to read PAI I/O control reg\n");
+		return -EIO;
+	}
+
+	if (pin->sd_pin == PC3X2_GPIO_PIN_SDGPIO_4) {
+		sd_mask |= PAI_GPIO_PIN_SDGPIO_4;
+	} else if (pin->sd_pin == PC3X2_GPIO_PIN_SDGPIO_5) {
+		sd_mask |= PAI_GPIO_PIN_SDGPIO_5;
+	} else if (pin->sd_pin == PC3X2_GPIO_PIN_SDGPIO_6) {
+		sd_mask |= PAI_GPIO_PIN_SDGPIO_6;
+	} else if (pin->sd_pin == PC3X2_GPIO_PIN_SDGPIO_7) {
+		sd_mask |= PAI_GPIO_PIN_SDGPIO_7;
+	} else if (pin->arm_pin == PC3X2_GPIO_PIN_ARM_4) {
+		arm_mask |= PAI_GPIO_PIN_ARM_4;
+	} else if (pin->arm_pin == PC3X2_GPIO_PIN_ARM_5) {
+		arm_mask |= PAI_GPIO_PIN_ARM_5;
+	} else if (pin->arm_pin == PC3X2_GPIO_PIN_ARM_6) {
+		arm_mask |= PAI_GPIO_PIN_ARM_6;
+	} else if (pin->arm_pin == PC3X2_GPIO_PIN_ARM_7) {
+		arm_mask |= PAI_GPIO_PIN_ARM_7;
+	} else {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (data & sd_mask)
+		ret = MUX_SD;
+	else if (data & arm_mask)
+		ret = MUX_ARM;
+	else
+		ret = MUX_PERIPHERAL;
+
+out:
+	return ret;
+}
+
+static int
+pai_set_mux(struct muxed_pin *pin,
+	    enum mux_setting setting)
+{
+	/* Make sure that the PAI block is awake. */
+	u16 data = 0;
+	int err;
+
+	axi2cfg_config_write(PICOXCELL_PAI_CAEID, PAI_SLEEP_REG, &data, 1);
+
+	/* Get the current PAI muxing configuration. */
+	err = axi2cfg_config_read(PICOXCELL_PAI_CAEID, PAI_IO_CTRL_REG,
+				  &data, 1);
+	if (1 != err) {
+		pr_warning("unable to read PAI I/O control reg\n");
+		return -EIO;
+	}
+
+	if (MUX_SD == setting) {
+		if (pin->sd_pin == PC3X2_GPIO_PIN_SDGPIO_4) {
+			data |= PAI_GPIO_PIN_SDGPIO_4;
+		} else if (pin->sd_pin == PC3X2_GPIO_PIN_SDGPIO_5) {
+			data |= PAI_GPIO_PIN_SDGPIO_5;
+		} else if (pin->sd_pin == PC3X2_GPIO_PIN_SDGPIO_6) {
+			data |= PAI_GPIO_PIN_SDGPIO_6;
+		} else if (pin->sd_pin == PC3X2_GPIO_PIN_SDGPIO_7) {
+			data |= PAI_GPIO_PIN_SDGPIO_7;
+		} else {
+			err = -EINVAL;
+			goto out;
+		}
+	} else if (MUX_ARM == setting) {
+		if (pin->arm_pin == PC3X2_GPIO_PIN_ARM_4) {
+			data |= PAI_GPIO_PIN_ARM_4;
+		} else if (pin->arm_pin == PC3X2_GPIO_PIN_ARM_5) {
+			data |= PAI_GPIO_PIN_ARM_5;
+		} else if (pin->arm_pin == PC3X2_GPIO_PIN_ARM_6) {
+			data |= PAI_GPIO_PIN_ARM_6;
+		} else if (pin->arm_pin == PC3X2_GPIO_PIN_ARM_7) {
+			data |= PAI_GPIO_PIN_ARM_7;
+		} else {
+			err = -EINVAL;
+			goto out;
+		}
+	} else if (MUX_PERIPHERAL == setting) {
+		/*
+		 * We don't do anything here. The PAI is only driven by the
+		 * picoArray so this will be automatically set in the loadfile
+		 * when the design is next loaded.
+		 */
+		err = 0;
+	} else if (MUX_UNMUXED == setting) {
+		/* This can't be changed at run-time! */
+		return -EPERM;
+	}
+
+	axi2cfg_config_write(PICOXCELL_PAI_CAEID, PAI_IO_CTRL_REG, &data, 1);
+	err = 0;
+
+out:
+	return err;
+}
+
+static struct muxed_pin pai_pins[] = {
+PIN(sdgpio4, PC3X2_GPIO_PIN_SDGPIO_4, -1, pai_set_mux, pai_get_mux),
+PIN(sdgpio5, PC3X2_GPIO_PIN_SDGPIO_5, -1, pai_set_mux, pai_get_mux),
+PIN(sdgpio6, PC3X2_GPIO_PIN_SDGPIO_6, -1, pai_set_mux, pai_get_mux),
+PIN(sdgpio7, PC3X2_GPIO_PIN_SDGPIO_7, -1, pai_set_mux, pai_get_mux),
+PIN(arm4, -1, PC3X2_GPIO_PIN_ARM_4, pai_set_mux, pai_get_mux),
+PIN(arm5, -1, PC3X2_GPIO_PIN_ARM_5, pai_set_mux, pai_get_mux),
+PIN(arm6, -1, PC3X2_GPIO_PIN_ARM_6, pai_set_mux, pai_get_mux),
+PIN(arm7, -1, PC3X2_GPIO_PIN_ARM_7, pai_set_mux, pai_get_mux),
+};
+
+static struct pin_group pai_group = {
+	.nr_pins    = ARRAY_SIZE(pai_pins),
+	.name	    = "pai/ebi",
+	.pins	    = pai_pins,
+};
+
+static int
+shd_get_mux(struct muxed_pin *pin)
+{
+	unsigned bit;
+	unsigned long syscfg = syscfg_read();
+
+	if (0 == (syscfg & 0x3) && pin->sd_pin == PC3X2_GPIO_PIN_SDGPIO_15)
+		return MUX_PERIPHERAL;
+
+	if (pin->sd_pin == PC3X2_GPIO_PIN_SDGPIO_0) {
+		if (syscfg & AXI2CFG_SYSCFG_FREQ_SYNTH_MUX_MASK)
+			return MUX_PERIPHERAL;
+		else
+			return MUX_SD;
+	}
+
+	bit = 1 << (AXI2CFG_SYSCFG_SD_ARM_GPIO_SEL_LO +
+			pin->sd_pin - PC3X2_GPIO_PIN_SDGPIO_8);
+
+	return syscfg & bit ? MUX_ARM : MUX_SD;
+}
+
+static int
+shd_set_mux(struct muxed_pin *pin,
+	    enum mux_setting setting)
+{
+	unsigned bit;
+	unsigned long syscfg = syscfg_read();
+
+	/*
+	 * In parallel boot mode, shared pin 7 can't be used as it is always
+	 * on the EBI.
+	 */
+	if (0 == (syscfg & 0x3) && pin->sd_pin == PC3X2_GPIO_PIN_SDGPIO_15)
+		return -EBUSY;
+
+	switch (setting) {
+	case MUX_PERIPHERAL:
+		/*
+		 * SDGPIO pin 0 is shared with the Frac-N.
+		 */
+		if (PC3X2_GPIO_PIN_SDGPIO_0 == pin->sd_pin) {
+			syscfg_update(AXI2CFG_SYSCFG_FREQ_SYNTH_MUX_MASK,
+				      AXI2CFG_SYSCFG_FREQ_SYNTH_MUX_MASK);
+			break;
+		}
+		return -EIO;
+
+	case MUX_SD:
+		syscfg_update(AXI2CFG_SYSCFG_FREQ_SYNTH_MUX_MASK, 0);
+		bit = 1 << (AXI2CFG_SYSCFG_SD_ARM_GPIO_SEL_LO +
+			    pin->sd_pin - PC3X2_GPIO_PIN_SDGPIO_8);
+		syscfg_update(bit, 0);
+		break;
+
+	case MUX_ARM:
+		if (PC3X2_GPIO_PIN_SDGPIO_0 == pin->sd_pin)
+			return -EINVAL;
+		syscfg_update(AXI2CFG_SYSCFG_FREQ_SYNTH_MUX_MASK, 0);
+		bit = 1 << (AXI2CFG_SYSCFG_SD_ARM_GPIO_SEL_LO +
+			    pin->arm_pin - PC3X2_GPIO_PIN_ARM_8);
+		syscfg_update(bit, bit);
+		break;
+
+	case MUX_UNMUXED:
+		/* This can't be changed at run-time! */
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+static struct muxed_pin shared_pins[] = {
+GPIO(shared0, PC3X2_GPIO_PIN_SDGPIO_8, PC3X2_GPIO_PIN_ARM_8, shd_set_mux,
+     shd_get_mux),
+GPIO(shared1, PC3X2_GPIO_PIN_SDGPIO_9, PC3X2_GPIO_PIN_ARM_9, shd_set_mux,
+     shd_get_mux),
+GPIO(shared2, PC3X2_GPIO_PIN_SDGPIO_10, PC3X2_GPIO_PIN_ARM_10, shd_set_mux,
+     shd_get_mux),
+GPIO(shared3, PC3X2_GPIO_PIN_SDGPIO_11, PC3X2_GPIO_PIN_ARM_11, shd_set_mux,
+     shd_get_mux),
+GPIO(shared4, PC3X2_GPIO_PIN_SDGPIO_12, PC3X2_GPIO_PIN_ARM_12, shd_set_mux,
+     shd_get_mux),
+GPIO(shared5, PC3X2_GPIO_PIN_SDGPIO_13, PC3X2_GPIO_PIN_ARM_13, shd_set_mux,
+     shd_get_mux),
+GPIO(shared6, PC3X2_GPIO_PIN_SDGPIO_14, PC3X2_GPIO_PIN_ARM_14, shd_set_mux,
+     shd_get_mux),
+PIN(shared7, PC3X2_GPIO_PIN_SDGPIO_15, PC3X2_GPIO_PIN_ARM_15, shd_set_mux,
+    shd_get_mux),
+};
+
+static struct pin_group shd_group = {
+	.nr_pins    = ARRAY_SIZE(shared_pins),
+	.name	    = "shared/ebi",
+	.pins	    = shared_pins,
+};
+
+static struct muxed_pin fracn_pins[] = {
+PIN(sdgpio0, PC3X2_GPIO_PIN_SDGPIO_0, -1, shd_set_mux, shd_get_mux),
+};
+
+static struct pin_group fracn_group = {
+	.nr_pins    = ARRAY_SIZE(fracn_pins),
+	.name	    = "fracn/sdgpio0",
+	.pins	    = fracn_pins,
+};
+
+static struct pin_group *pc3x2_groups[] = {
+	&shd_group,
+	&pai_group,
+	&fracn_group,
+};
+
+static int armgpio_number(int pin)
+{
+	if (pin >= PC3X2_GPIO_PIN_ARM_0 && pin <= PC3X2_GPIO_PIN_ARM_15)
+		return pin;
+
+	return -1;
+}
+
+static int sdgpio_number(int pin)
+{
+	if (pin >= PC3X2_GPIO_PIN_SDGPIO_0 &&
+	    pin <= PC3X2_GPIO_PIN_SDGPIO_15)
+		return pin - PC3X2_GPIO_PIN_SDGPIO_0;
+
+	return -1;
+}
+
+static void pc3x2_init_muxing(void)
+{
+	picoxcell_mux_register(pc3x2_groups, ARRAY_SIZE(pc3x2_groups),
+			       armgpio_number, sdgpio_number);
+}
+
+static const char * const pc3x2_armgpio_pins[] = {
+	"arm0",
+	"arm1",
+	"arm2",
+	"arm3",
+	"arm4",
+	"arm5",
+	"arm6",
+	"arm7",
+	"arm8",
+	"arm9",
+	"arm10",
+	"arm11",
+	"arm12",
+	"arm13",
+	"arm14",
+	"arm15",
+};
+
+static const char * const pc3x2_sdgpio_pins[] = {
+	"sdgpio0",
+	"sdgpio1",
+	"sdgpio2",
+	"sdgpio3",
+	"sdgpio4",
+	"sdgpio5",
+	"sdgpio6",
+	"sdgpio7",
+	"sdgpio8",
+	"sdgpio9",
+	"sdgpio10",
+	"sdgpio11",
+	"sdgpio12",
+	"sdgpio13",
+	"sdgpio14",
+	"sdgpio15",
+};
+
+static const struct picoxcell_timer pc3x2_timers[] = {
+	{
+		.name	= "timer0",
+		.type	= TIMER_TYPE_TIMER,
+		.base	= PICOXCELL_TIMER_BASE + 0 * TIMER_SPACING,
+		.irq	= IRQ_TIMER0,
+	},
+	{
+		.name	= "timer1",
+		.type	= TIMER_TYPE_TIMER,
+		.base	= PICOXCELL_TIMER_BASE + 1 * TIMER_SPACING,
+		.irq	= IRQ_TIMER1,
+	},
+	{
+		.name	= "timer2",
+		.type	= TIMER_TYPE_TIMER,
+		.base	= PICOXCELL_TIMER_BASE + 2 * TIMER_SPACING,
+		.irq	= IRQ_TIMER2,
+	},
+	{
+		.name	= "timer3",
+		.type	= TIMER_TYPE_TIMER,
+		.base	= PICOXCELL_TIMER_BASE + 3 * TIMER_SPACING,
+		.irq	= IRQ_TIMER3,
+	},
+	{
+		.name	= "rtc",
+		.type	= TIMER_TYPE_RTC,
+		.base	= PICOXCELL_RTCLK_BASE,
+		.irq	= IRQ_RTC,
+	},
+};
+
+static void pc3x2_init(void);
+
+struct picoxcell_soc pc3x2_soc = {
+	.init		= pc3x2_init,
+	.init_clocks	= pc3x2_clk_init,
+	.init_muxing	= pc3x2_init_muxing,
+	.get_boot_mode	= pc3x2_get_boot_mode,
+	.armgpio_pins	= pc3x2_armgpio_pins,
+	.nr_armgpio	= ARRAY_SIZE(pc3x2_armgpio_pins),
+	.armgpio_base	= PC3X2_GPIO_PIN_ARM_0,
+	.sdgpio_pins	= pc3x2_sdgpio_pins,
+	.nr_sdgpio	= ARRAY_SIZE(pc3x2_sdgpio_pins),
+	.sdgpio_base	= PC3X2_GPIO_PIN_SDGPIO_0,
+	.timers		= pc3x2_timers,
+	.nr_timers	= ARRAY_SIZE(pc3x2_timers),
+};
+
+static void pc3x2_init(void)
+{
+	/*
+	 * If we booted in parallel nor mode then we can continue to use the
+	 * EBI. If not then we only have a few bits of the EBI - just enough
+	 * to drive a NAND flash.
+	 */
+	if (syscfg_read() & 0x3)
+		set_bit(PICOXCELL_FEATURE_SW_NAND, pc3x2_soc.features);
+	else
+		set_bit(PICOXCELL_FEATURE_EBI, pc3x2_soc.features);
+}
diff --git a/arch/arm/mach-picoxcell/picoxcell_core.c b/arch/arm/mach-picoxcell/picoxcell_core.c
index 8386c83..5b5f0c6 100644
--- a/arch/arm/mach-picoxcell/picoxcell_core.c
+++ b/arch/arm/mach-picoxcell/picoxcell_core.c
@@ -43,6 +43,10 @@ struct picoxcell_soc *picoxcell_get_soc(void)
 	unsigned long device_id = readl(IO_ADDRESS(PICOXCELL_AXI2CFG_BASE +
 					AXI2CFG_DEVICE_ID_REG_OFFSET));
 	switch (device_id) {
+	case 0x8003:
+	case 0x8007:
+		return &pc3x2_soc;
+
 	default:
 		panic("unsupported device type %lx", device_id);
 	}
@@ -91,7 +95,14 @@ void __init picoxcell_init_irq(void)
 static const char *picoxcell_get_partname(void)
 {
 	unsigned long dev_id = axi2cfg_readl(AXI2CFG_DEVICE_ID_REG_OFFSET);
-	const char *part = "<unknown>";
+	const char *part;
+
+	if (0x8003 == dev_id)
+		part = "pc302";
+	else if (0x8007 == dev_id)
+		part = "pc312";
+	else
+		part = "<unknown>";
 
 	return part;
 }
diff --git a/arch/arm/mach-picoxcell/soc.h b/arch/arm/mach-picoxcell/soc.h
index 784d714..ec30eef 100644
--- a/arch/arm/mach-picoxcell/soc.h
+++ b/arch/arm/mach-picoxcell/soc.h
@@ -49,6 +49,7 @@ struct picoxcell_soc {
 };
 
 extern struct picoxcell_soc *picoxcell_get_soc(void);
+extern struct picoxcell_soc pc3x2_soc;
 
 static inline int picoxcell_has_feature(enum picoxcell_features feat)
 {
-- 
1.7.2.3
