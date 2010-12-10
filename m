From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 10 Dec 2010 16:28:23 +0000
Subject: [PATCH v3 12/14] picoxcell: add support for pc3x3 devices
In-Reply-To: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
References: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1291998505-25891-13-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PC3X3 is the second supported device family of picoXcell and this patch
defines the virtual clocks to allow drivers to work, the pin muxing
options, timer locations and the GPIO definitions. This also implements
the PLL control for the ARM PLL.

v2: remove device specific IO mappings as the only peripherals not
accessed through ioremap() share a common address space in all devices.

v3:
	- Use the new muxing return types.
	- Add muxing support for ebi_addr26.
	- Convert to __raw_ io accessors.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/Kconfig          |   18 +
 arch/arm/mach-picoxcell/Makefile         |    1 +
 arch/arm/mach-picoxcell/pc3x3.c          | 1336 ++++++++++++++++++++++++++++++
 arch/arm/mach-picoxcell/picoxcell_core.c |   11 +
 arch/arm/mach-picoxcell/soc.h            |    1 +
 5 files changed, 1367 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-picoxcell/pc3x3.c

diff --git a/arch/arm/mach-picoxcell/Kconfig b/arch/arm/mach-picoxcell/Kconfig
index 5141202..671cadc 100644
--- a/arch/arm/mach-picoxcell/Kconfig
+++ b/arch/arm/mach-picoxcell/Kconfig
@@ -8,4 +8,22 @@ config PICOXCELL_PC3X2
 	  Include support for picoChip PC3x2 family of devices. This
 	  includes PC302 and PC312.
 
+config PICOXCELL_PC3X3
+	bool "Support PC3x3 devices"
+	default y
+	select ARCH_HAS_CPUFREQ
+	help
+	  Include support for picoChip PC3x3 family of devices. This includes
+	  PC313, PC323 and PC333.
+
+config PC3X3_STOP_WDT_IN_SUSPEND
+	bool "Stop WDT in PM suspend"
+	depends on PICOCHIP_PC3X3
+	default y
+	help
+	  If you say yes here, then when the platform is put into suspend mode,
+	  the watchdog timer will be paused. Saying no will cause the watchdog
+	  to keep running. If you say no here, make sure that the watchdog uses
+	  the pretimeout mode and mark the watchdog as a wakeup source.
+
 endmenu
diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index bc2dc75..7ed0d7c 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -7,3 +7,4 @@ obj-y				:= picoxcell_core.o io.o axi2cfg.o \
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_PICOXCELL_PC3X2)	+= pc3x2.o
+obj-$(CONFIG_PICOXCELL_PC3X3)	+= pc3x3.o
diff --git a/arch/arm/mach-picoxcell/pc3x3.c b/arch/arm/mach-picoxcell/pc3x3.c
new file mode 100644
index 0000000..1fb9e2f
--- /dev/null
+++ b/arch/arm/mach-picoxcell/pc3x3.c
@@ -0,0 +1,1336 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+
+#include <mach/clkdev.h>
+#include <mach/hardware.h>
+
+#include "mux.h"
+#include "picoxcell_core.h"
+#include "soc.h"
+
+static DEFINE_SPINLOCK(pc3x3_clk_lock);
+
+FIXED_CLK(tzprot,	CLOCK_TICK_RATE, 0);
+FIXED_CLK(spi,		CLOCK_TICK_RATE, 1);
+FIXED_CLK(dmac0,	CLOCK_TICK_RATE, 2);
+FIXED_CLK(dmac1,	CLOCK_TICK_RATE, 3);
+FIXED_CLK(ebi,		CLOCK_TICK_RATE, 4);
+FIXED_CLK(ipsec,	CLOCK_TICK_RATE, 5);
+FIXED_CLK(l2_engine,	CLOCK_TICK_RATE, 6);
+FIXED_CLK(trng,		CLOCK_TICK_RATE, 7);
+FIXED_CLK(fuse,		CLOCK_TICK_RATE, 8);
+FIXED_CLK(otp,		CLOCK_TICK_RATE, 9);
+FIXED_CLK(wdt,		CLOCK_TICK_RATE, -1);
+VARIABLE_CLK(arm,			 -1, 140000, 700000, 5000);
+
+static struct clk *pc3x3_clks[] = {
+	&tzprot_clk,
+	&spi_clk,
+	&dmac0_clk,
+	&dmac1_clk,
+	&ebi_clk,
+	&ipsec_clk,
+	&l2_engine_clk,
+	&trng_clk,
+	&fuse_clk,
+	&otp_clk,
+	&wdt_clk,
+	&arm_clk,
+};
+
+static struct clk_lookup pc3x3_clk_lookup[] = {
+	CLK_LOOKUP(NULL,		"tzprot_ctl",	&tzprot_clk),
+	CLK_LOOKUP("dw_spi_mmio.0",	NULL,		&spi_clk),
+	CLK_LOOKUP("dw_dmac.0",		NULL,		&dmac0_clk),
+	CLK_LOOKUP("dw_dmac.1",		NULL,		&dmac1_clk),
+	CLK_LOOKUP(NULL,		"ebi",		&ebi_clk),
+	CLK_LOOKUP("picoxcell-ipsec",	NULL,		&ipsec_clk),
+	CLK_LOOKUP("picoxcell-l2",	NULL,		&l2_engine_clk),
+	CLK_LOOKUP("picoxcell-trng",	NULL,		&trng_clk),
+	CLK_LOOKUP("picoxcell-fuse",	NULL,		&fuse_clk),
+	CLK_LOOKUP("picoxcell-otp",	NULL,		&otp_clk),
+	CLK_LOOKUP("dw_wdt",		NULL,		&wdt_clk),
+	CLK_LOOKUP(NULL,		"arm",		&arm_clk),
+};
+
+static int pc3x3_clk_is_enabled(struct clk *clk)
+{
+	unsigned long clk_gate =
+		axi2cfg_readl(AXI2CFG_CLOCK_GATING_REG_OFFSET);
+	return !(clk_gate & (1 << clk->clk_num));
+}
+
+static void pc3x3_clk_disable(struct clk *clk)
+{
+	unsigned long clk_gate;
+
+	if (clk->clk_num < 0)
+		return;
+
+	/*
+	 * Make sure that all outstanding transactions have reached the device
+	 * before we turn off the clock to prevent taking an exception.
+	 */
+	dsb();
+
+	clk_gate = axi2cfg_readl(AXI2CFG_CLOCK_GATING_REG_OFFSET);
+	clk_gate |= (1 << clk->clk_num);
+	axi2cfg_writel(clk_gate, AXI2CFG_CLOCK_GATING_REG_OFFSET);
+}
+
+static inline void pc3x3_clk_enable(struct clk *clk)
+{
+	unsigned long clk_gate;
+
+	if (clk->clk_num < 0)
+		return;
+
+	clk_gate = axi2cfg_readl(AXI2CFG_CLOCK_GATING_REG_OFFSET);
+	clk_gate &= ~(1 << clk->clk_num);
+	axi2cfg_writel(clk_gate, AXI2CFG_CLOCK_GATING_REG_OFFSET);
+}
+
+static long pc3x3_clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	long ret = -EINVAL;
+	unsigned long offset = rate % clk->step;
+
+	if (WARN_ON(clk != &arm_clk))
+		goto out;
+
+	rate -= offset;
+	if (offset > clk->step - offset)
+		ret = rate + clk->step;
+	else
+		ret = rate;
+
+out:
+	return ret;
+}
+
+/* The register that the CLKF value is programmed into. */
+#define AXI2CFG_ARM_PLL_CLKF_REG_OFFS		0x0050
+/* The frequency sensing control register. */
+#define AXI2CFG_ARM_PLL_FREQ_SENSE_REG_OFFS	0x0054
+
+/* The value in the sense register is a valid frequency. */
+#define AXI2CFG_ARM_PLL_FREQ_SENSE_VALID	(1 << 29)
+/* The sensing process is active. */
+#define AXI2CFG_ARM_PLL_FREQ_SENSE_ACTIVE	(1 << 30)
+/* Write this to the sense register to start sensing. Self clearing. */
+#define AXI2CFG_ARM_PLL_FREQ_SENSE_START	(1 << 31)
+/*
+ * The frequency (in MHz) is returned in the bottom 10 bits of the sense
+ * register and is valid when bit 29 is asserted.
+ */
+#define AXI2CFG_ARM_PLL_FREQ_SENSE_FREQ_MASK	0x3FF
+
+static int __pc3x3_clk_get_rate(struct clk *clk)
+{
+	unsigned int mhz = 0;
+	unsigned long sense_val;
+	int ret = -EINVAL;
+
+	if (WARN_ON(clk != &arm_clk))
+		goto out;
+
+	while (0 == mhz) {
+		do {
+			axi2cfg_writel(AXI2CFG_ARM_PLL_FREQ_SENSE_START,
+				       AXI2CFG_ARM_PLL_FREQ_SENSE_REG_OFFS);
+
+			/* Wait for the frequency sense to complete. */
+			do {
+				sense_val = axi2cfg_readl(AXI2CFG_ARM_PLL_FREQ_SENSE_REG_OFFS);
+			} while ((sense_val &
+				  AXI2CFG_ARM_PLL_FREQ_SENSE_ACTIVE));
+		} while (!(sense_val & AXI2CFG_ARM_PLL_FREQ_SENSE_VALID));
+
+		/* The frequency sense returns the frequency in MHz. */
+		mhz = (sense_val & AXI2CFG_ARM_PLL_FREQ_SENSE_FREQ_MASK);
+	}
+	ret = mhz * 1000;
+
+out:
+	return ret;
+}
+
+static int pc3x3_clk_get_rate(struct clk *clk)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&pc3x3_clk_lock, flags);
+	ret = __pc3x3_clk_get_rate(clk);
+	spin_unlock_irqrestore(&pc3x3_clk_lock, flags);
+
+	return ret;
+}
+
+static void
+pc3x3_cpu_pll_set(unsigned int freq)
+{
+	/* Set the new frequency. */
+	axi2cfg_writel(((freq / 1000) / 5) - 1, AXI2CFG_ARM_PLL_CLKF_REG_OFFS);
+	udelay(2);
+}
+
+static int pc3x3_clk_set_rate(struct clk *clk, unsigned long target)
+{
+	int ret = -EINVAL;
+	unsigned long flags, current_khz;
+
+	if (WARN_ON(clk != &arm_clk) || target % clk->step) {
+		pr_err("unable to set rate for non-cpu clock (%lu)\n", target);
+		goto out;
+	}
+
+	pr_debug("set cpu clock rate to %luKHz\n", target);
+
+	spin_lock_irqsave(&pc3x3_clk_lock, flags);
+
+	/*
+	 * We can only reliably step by 20% at a time. We may need to
+	 * do this in several iterations.
+	 */
+	while ((current_khz = __pc3x3_clk_get_rate(clk)) != target) {
+		unsigned long next_step, next_target;
+
+		if (target < current_khz) {
+			next_step = current_khz - ((4 * current_khz) / 5);
+			next_target = current_khz -
+				min(current_khz - target, next_step);
+			next_target = roundup(next_target, clk->step);
+		} else {
+			next_step = ((6 * current_khz) / 5) - current_khz;
+			next_target =
+				min(target - current_khz, next_step) +
+				current_khz;
+			next_target =
+				(next_target / clk->step) * clk->step;
+		}
+
+		pc3x3_cpu_pll_set(next_target);
+	}
+
+	spin_unlock_irqrestore(&pc3x3_clk_lock, flags);
+	ret = 0;
+
+out:
+	return ret;
+}
+
+static void pc3x3_clk_init(void)
+{
+	int i;
+
+	clkdev_add_table(pc3x3_clk_lookup, ARRAY_SIZE(pc3x3_clk_lookup));
+
+	for (i = 0; i < ARRAY_SIZE(pc3x3_clks); ++i) {
+		struct clk *clk = pc3x3_clks[i];
+
+		clk->enable	= pc3x3_clk_enable;
+		clk->disable	= pc3x3_clk_disable;
+		clk->is_enabled	= pc3x3_clk_is_enabled;
+
+		if (clk->rate < 0) {
+			clk->round_rate	= pc3x3_clk_round_rate;
+			clk->set_rate	= pc3x3_clk_set_rate;
+			clk->get_rate	= pc3x3_clk_get_rate;
+		}
+
+		picoxcell_clk_add(clk);
+	}
+
+	/*
+	 * For PC3x3, disable the clocks that aren't required in the core
+	 * code. The drivers will enable the clocks when they get initialised.
+	 */
+	__clk_disable(&spi_clk);
+	__clk_disable(&dmac0_clk);
+	__clk_disable(&dmac1_clk);
+	__clk_disable(&ipsec_clk);
+	__clk_disable(&l2_engine_clk);
+	__clk_disable(&trng_clk);
+	__clk_disable(&otp_clk);
+}
+
+static ssize_t pc3x3_get_boot_mode(char *buf)
+{
+	unsigned long syscfg = syscfg_read();
+	unsigned long otp_fuses =
+		__raw_readl(IO_ADDRESS(PICOXCELL_FUSE_BASE + 124));
+	const char *boot_mode;
+	const char *otp_boot = NULL;
+	/* We're interested in fuses 1018:1017, and otp_fuses starts at 992. */
+	unsigned otp_boot_mode = (otp_fuses >> 25) & 0x3;
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
+	if (0x2 == otp_boot_mode)
+		otp_boot = ":otp";
+	else if (0x1 == otp_boot_mode)
+		boot_mode = "otp";
+
+	return snprintf(buf, PAGE_SIZE, "%s%s\n", boot_mode,
+			otp_boot ? otp_boot : "");
+}
+
+static DEFINE_SPINLOCK(mux_lock);
+
+#define AXI2CFG_SHD_GPIO_MUX_REG_OFFSET		0x34
+#define AXI2CFG_USE_PAI_GPIO_REG_OFFSET		0x38
+#define AXI2CFG_USE_EBI_GPIO_REG_OFFSET		0x3c
+#define AXI2CFG_USE_DECODE_GPIO_REG_OFFSET	0x40
+#define AXI2CFG_USE_MISC_INT_GPIO_REG_OFFSET	0x44
+
+/*
+ * Set the muxing of one of the shared pins.
+ *
+ * Must be called with mux_lock held.
+ */
+static int pc3x3_shd_gpio_set_mux(int arm_pin_nr, enum mux_setting setting)
+{
+	unsigned long shd_mux = axi2cfg_readl(AXI2CFG_SHD_GPIO_MUX_REG_OFFSET);
+
+	if (MUX_ARM == setting)
+		shd_mux |= (1 << arm_pin_nr);
+	else if (MUX_SD == setting)
+		shd_mux &= ~(1 << arm_pin_nr);
+	else
+		return -EINVAL;
+
+	axi2cfg_writel(shd_mux, AXI2CFG_SHD_GPIO_MUX_REG_OFFSET);
+
+	return 0;
+}
+
+static int pc3x3_get_shd_mux(struct muxed_pin *pin)
+{
+	unsigned long shd_mux = axi2cfg_readl(AXI2CFG_SHD_GPIO_MUX_REG_OFFSET);
+	unsigned long syscfg = syscfg_read();
+
+	if (pin->sd_pin == PC3X3_GPIO_PIN_SDGPIO_0) {
+		if (syscfg & AXI2CFG_SYSCFG_FREQ_SYNTH_MUX_MASK)
+			return MUX_PERIPHERAL_FRACN;
+		else
+			return MUX_SD;
+	}
+
+	return shd_mux & (1 << pin->arm_pin) ? MUX_ARM : MUX_SD;
+}
+
+/*
+ * Shared ARM/SD gpio pins. These pins go to the arm_gpio[3:0] pads but can
+ * be arm or sdgpio.
+ */
+static int pc3x3_shd_mux(struct muxed_pin *pin, enum mux_setting setting)
+{
+	int ret;
+
+	if (MUX_PERIPHERAL_FRACN == setting) {
+		if (pin->sd_pin != PC3X3_GPIO_PIN_SDGPIO_0)
+			return -EINVAL;
+
+		syscfg_update(AXI2CFG_SYSCFG_FREQ_SYNTH_MUX_MASK,
+			      AXI2CFG_SYSCFG_FREQ_SYNTH_MUX_MASK);
+	} else if (PC3X3_GPIO_PIN_SDGPIO_0 == pin->sd_pin)
+		syscfg_update(AXI2CFG_SYSCFG_FREQ_SYNTH_MUX_MASK, 0);
+	else
+		return -EINVAL;
+
+	if (PC3X3_GPIO_PIN_SDGPIO_0 == pin->sd_pin && MUX_ARM == setting)
+		return -EINVAL;
+
+	spin_lock(&mux_lock);
+	ret = pc3x3_shd_gpio_set_mux(pin->arm_pin, setting);
+	spin_unlock(&mux_lock);
+
+	return ret;
+}
+
+static struct muxed_pin armgpio_0_4[] = {
+GPIO(arm_gpio0, PC3X3_GPIO_PIN_SDGPIO_16, PC3X3_GPIO_PIN_ARM_0, pc3x3_shd_mux,
+     pc3x3_get_shd_mux),
+GPIO(arm_gpio1, PC3X3_GPIO_PIN_SDGPIO_17, PC3X3_GPIO_PIN_ARM_1, pc3x3_shd_mux,
+     pc3x3_get_shd_mux),
+GPIO(arm_gpio2, PC3X3_GPIO_PIN_SDGPIO_18, PC3X3_GPIO_PIN_ARM_2, pc3x3_shd_mux,
+     pc3x3_get_shd_mux),
+GPIO(arm_gpio3, PC3X3_GPIO_PIN_SDGPIO_19, PC3X3_GPIO_PIN_ARM_3, pc3x3_shd_mux,
+     pc3x3_get_shd_mux),
+};
+
+static struct pin_group armgpio_0_4_group = {
+	.nr_pins    = ARRAY_SIZE(armgpio_0_4),
+	.name	    = "arm_gpio[3:0]",
+	.pins	    = armgpio_0_4,
+};
+
+static struct muxed_pin shd_gpio[] = {
+GPIO(shd_gpio, PC3X3_GPIO_PIN_SDGPIO_8, PC3X3_GPIO_PIN_ARM_8, pc3x3_shd_mux,
+     pc3x3_get_shd_mux),
+};
+
+static struct pin_group pc3x3_shd_group = {
+	.nr_pins    = ARRAY_SIZE(shd_gpio),
+	.name	    = "shd_gpio",
+	.pins	    = shd_gpio,
+};
+
+/*
+ * boot_mode[1:0] pads - the pins switch to gpio automatically after boot and
+ * can be either arm or sdgpio.
+ */
+static struct muxed_pin boot_mode_0_1[] = {
+GPIO(boot_mode0, PC3X3_GPIO_PIN_SDGPIO_9, PC3X3_GPIO_PIN_ARM_9,
+     pc3x3_shd_mux, pc3x3_get_shd_mux),
+GPIO(boot_mode1, PC3X3_GPIO_PIN_SDGPIO_10, PC3X3_GPIO_PIN_ARM_10,
+     pc3x3_shd_mux, pc3x3_get_shd_mux),
+};
+
+static struct pin_group boot_mode_group = {
+	.nr_pins    = ARRAY_SIZE(boot_mode_0_1),
+	.name	    = "boot_mode[1:0]",
+	.pins	    = boot_mode_0_1,
+};
+
+/*
+ * sdram_speed_sel pad - automatically switches to gpio after boot and can be
+ * arm or sdgpio.
+ */
+static struct muxed_pin sdram_speed_sel[] = {
+GPIO(sdram_speed_sel, PC3X3_GPIO_PIN_SDGPIO_11, PC3X3_GPIO_PIN_ARM_11,
+     pc3x3_shd_mux, pc3x3_get_shd_mux),
+};
+
+static struct pin_group sdram_speed_sel_group = {
+	.nr_pins    = ARRAY_SIZE(sdram_speed_sel),
+	.name	    = "sdram_speed_sel",
+	.pins	    = sdram_speed_sel,
+};
+
+/*
+ * mii_rev_en pad - automatically switches to gpio after boot and can be
+ * arm or sdgpio.
+ */
+static struct muxed_pin mii_rev_en[] = {
+GPIO(mii_rev_en, PC3X3_GPIO_PIN_SDGPIO_12, PC3X3_GPIO_PIN_ARM_12,
+     pc3x3_shd_mux, pc3x3_get_shd_mux),
+};
+
+static struct pin_group mii_rev_en_group = {
+	.nr_pins    = ARRAY_SIZE(mii_rev_en),
+	.name	    = "mii_rev_en",
+	.pins	    = mii_rev_en,
+};
+
+/*
+ * mii_rmii_en pad - automatically switches to gpio after boot and can be
+ * arm or sdgpio.
+ */
+static struct muxed_pin mii_rmii_en[] = {
+GPIO(mii_rmii_en, PC3X3_GPIO_PIN_SDGPIO_13, PC3X3_GPIO_PIN_ARM_13,
+     pc3x3_shd_mux, pc3x3_get_shd_mux),
+};
+
+static struct pin_group mii_rmii_en_group = {
+	.nr_pins    = ARRAY_SIZE(mii_rmii_en),
+	.name	    = "mii_rmii_en",
+	.pins	    = mii_rmii_en,
+};
+
+/*
+ * mii_speed_sel pad - automatically switches to gpio after boot and can be
+ * arm or sdgpio.
+ */
+static struct muxed_pin mii_speed_sel[] = {
+GPIO(mii_speed_sel, PC3X3_GPIO_PIN_SDGPIO_14, PC3X3_GPIO_PIN_ARM_14,
+     pc3x3_shd_mux, pc3x3_get_shd_mux),
+};
+
+static struct pin_group mii_speed_sel_group = {
+	.nr_pins    = ARRAY_SIZE(mii_speed_sel),
+	.name	    = "mii_speed_sel",
+	.pins	    = mii_speed_sel,
+};
+
+static int pc3x3_shd_ebi_get_mux(struct muxed_pin *pin)
+{
+	int ebi_pin, err = 0, can_be_sd = 1;
+	unsigned long ebi_mux;
+
+	spin_lock(&mux_lock);
+
+	ebi_mux = axi2cfg_readl(AXI2CFG_USE_EBI_GPIO_REG_OFFSET);
+
+	/*
+	 * Find out what EBI pin our GPIO maps to.
+	 */
+	if (pin->arm_pin >= PC3X3_GPIO_PIN_ARM_4 &&
+	    pin->arm_pin < PC3X3_GPIO_PIN_ARM_8) {
+		ebi_pin = 22 + (pin->arm_pin - PC3X3_GPIO_PIN_ARM_4);
+	} else if (pin->arm_pin >= PC3X3_GPIO_PIN_ARM_20 &&
+		   pin->arm_pin < PC3X3_GPIO_PIN_ARM_24) {
+		ebi_pin = 18 + (pin->arm_pin - PC3X3_GPIO_PIN_ARM_20);
+	} else {
+		/* These aren't shared gpio pins. */
+		ebi_pin = 14 + (pin->arm_pin - PC3X3_GPIO_PIN_ARM_14);
+		can_be_sd = 0;
+	}
+
+	if (!(ebi_mux & (1 << (ebi_pin - 14)))) {
+		err = MUX_PERIPHERAL_EBI;
+		goto out;
+	}
+
+	if (can_be_sd)
+		err = pc3x3_get_shd_mux(pin);
+	else
+		err = MUX_ARM;
+
+out:
+	spin_unlock(&mux_lock);
+
+	return err;
+}
+
+static int pc3x3_shd_ebi_set_mux(struct muxed_pin *pin,
+				 enum mux_setting setting)
+{
+	int ebi_pin, err = 0, can_be_sd = 1;
+	unsigned long ebi_mux;
+
+	if (!(setting == MUX_ARM || setting == MUX_SD ||
+	      setting == MUX_PERIPHERAL_EBI))
+		return -EINVAL;
+
+	spin_lock(&mux_lock);
+
+	ebi_mux = axi2cfg_readl(AXI2CFG_USE_EBI_GPIO_REG_OFFSET);
+
+	/*
+	 * Find out what EBI pin our GPIO maps to.
+	 */
+	if (pin->arm_pin >= PC3X3_GPIO_PIN_ARM_4 &&
+	    pin->arm_pin < PC3X3_GPIO_PIN_ARM_8) {
+		ebi_pin = 22 + (pin->arm_pin - PC3X3_GPIO_PIN_ARM_4);
+	} else if (pin->arm_pin >= PC3X3_GPIO_PIN_ARM_20 &&
+		   pin->arm_pin < PC3X3_GPIO_PIN_ARM_24) {
+		ebi_pin = 18 + (pin->arm_pin - PC3X3_GPIO_PIN_ARM_20);
+	} else {
+		/* These aren't shared gpio pins. */
+		ebi_pin = 14 + (pin->arm_pin - PC3X3_GPIO_PIN_ARM_14);
+		can_be_sd = 0;
+	}
+
+	if (MUX_SD == setting && !can_be_sd) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* Use the pin as EBI. */
+	if (MUX_PERIPHERAL_EBI == setting)
+		ebi_mux &= ~(1 << (ebi_pin - 14));
+	else
+		ebi_mux |= (1 << (ebi_pin - 14));
+
+	axi2cfg_writel(ebi_mux, AXI2CFG_USE_EBI_GPIO_REG_OFFSET);
+
+	/*
+	 * Make sure that the configuration is valid (the GPIO isn't going to
+	 * the PAI).
+	 */
+	if (axi2cfg_readl(AXI2CFG_USE_EBI_GPIO_REG_OFFSET) != ebi_mux) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	/*
+	 * If we can be SD or ARM and we want to be gpio, pick the correct
+	 * one now.
+	 */
+	if (MUX_PERIPHERAL_EBI != setting && can_be_sd)
+		err = pc3x3_shd_gpio_set_mux(pin->arm_pin, setting);
+
+out:
+	spin_unlock(&mux_lock);
+
+	return err;
+}
+
+/*
+ * ebi_addr[25:18] pads - these pads can be either the EBI or arm gpio or
+ * sdgpio. Note: the gpio pins can also be routed to the pai_tx/rx_data pads.
+ *
+ * A pad may only be used for GPIO if the corresponding GPIO pin is not
+ * already routed to the pai tx/rx data pad. The same applies in the reverse
+ * direction. Hardware interlocks exist to prevent this from happening.
+ */
+static struct muxed_pin ebi_addr_18_25[] = {
+PIN(ebi_addr18, PC3X3_GPIO_PIN_SDGPIO_4, PC3X3_GPIO_PIN_ARM_20,
+    pc3x3_shd_ebi_set_mux, pc3x3_shd_ebi_get_mux),
+PIN(ebi_addr19, PC3X3_GPIO_PIN_SDGPIO_5, PC3X3_GPIO_PIN_ARM_21,
+    pc3x3_shd_ebi_set_mux, pc3x3_shd_ebi_get_mux),
+PIN(ebi_addr20, PC3X3_GPIO_PIN_SDGPIO_6, PC3X3_GPIO_PIN_ARM_22,
+    pc3x3_shd_ebi_set_mux, pc3x3_shd_ebi_get_mux),
+PIN(ebi_addr21, PC3X3_GPIO_PIN_SDGPIO_7, PC3X3_GPIO_PIN_ARM_23,
+    pc3x3_shd_ebi_set_mux, pc3x3_shd_ebi_get_mux),
+PIN(ebi_addr22, PC3X3_GPIO_PIN_SDGPIO_20, PC3X3_GPIO_PIN_ARM_4,
+    pc3x3_shd_ebi_set_mux, pc3x3_shd_ebi_get_mux),
+PIN(ebi_addr23, PC3X3_GPIO_PIN_SDGPIO_21, PC3X3_GPIO_PIN_ARM_5,
+    pc3x3_shd_ebi_set_mux, pc3x3_shd_ebi_get_mux),
+PIN(ebi_addr24, PC3X3_GPIO_PIN_SDGPIO_22, PC3X3_GPIO_PIN_ARM_6,
+    pc3x3_shd_ebi_set_mux, pc3x3_shd_ebi_get_mux),
+PIN(ebi_addr25, PC3X3_GPIO_PIN_SDGPIO_23, PC3X3_GPIO_PIN_ARM_7,
+    pc3x3_shd_ebi_set_mux, pc3x3_shd_ebi_get_mux),
+};
+
+static struct pin_group ebi_addr_18_25_group = {
+	.nr_pins    = ARRAY_SIZE(ebi_addr_18_25),
+	.name	    = "ebi_addr[25:18]",
+	.pins	    = ebi_addr_18_25,
+};
+
+static int pc3x3_ebi26_get_mux(struct muxed_pin *pin)
+{
+	enum mux_setting setting;
+	unsigned long ebi_mux, shd_gpio;
+
+	spin_lock(&mux_lock);
+
+	ebi_mux = axi2cfg_readl(AXI2CFG_USE_EBI_GPIO_REG_OFFSET);
+	shd_gpio = axi2cfg_readl(AXI2CFG_SHD_GPIO_MUX_REG_OFFSET);
+
+	if (!(ebi_mux & (1 << 12)))
+		setting = MUX_PERIPHERAL_EBI;
+	else if (shd_gpio & (1 << 15))
+		setting = MUX_ARM;
+	else
+		setting = MUX_SD;
+
+	spin_unlock(&mux_lock);
+
+	return setting;
+}
+
+static int pc3x3_ebi26_set_mux(struct muxed_pin *pin, enum mux_setting setting)
+{
+	unsigned long ebi_mux, shd_gpio;
+
+	if (!(setting == MUX_ARM || setting == MUX_SD ||
+	      setting == MUX_PERIPHERAL_EBI))
+		return -EINVAL;
+
+	spin_lock(&mux_lock);
+
+	ebi_mux = axi2cfg_readl(AXI2CFG_USE_EBI_GPIO_REG_OFFSET);
+	shd_gpio = axi2cfg_readl(AXI2CFG_SHD_GPIO_MUX_REG_OFFSET);
+
+	if (setting == MUX_PERIPHERAL_EBI) {
+		ebi_mux &= ~(1 << 12);
+	} else if (setting == MUX_SD) {
+		ebi_mux |= (1 << 12);
+		shd_gpio &= ~(1 << 15);
+	} else {
+		ebi_mux |= (1 << 12);
+		shd_gpio |= (1 << 15);
+	}
+
+	axi2cfg_writel(ebi_mux, AXI2CFG_USE_EBI_GPIO_REG_OFFSET);
+	axi2cfg_writel(shd_gpio, AXI2CFG_SHD_GPIO_MUX_REG_OFFSET);
+
+	spin_unlock(&mux_lock);
+
+	return 0;
+}
+
+/*
+ * ebi_addr[26] pad - this has different muxing to ebi_addr[25:18] as it isn't
+ * shared with the PAI pins.
+ */
+static struct muxed_pin ebi_addr_26[] = {
+PIN(ebi_addr26, PC3X3_GPIO_PIN_SDGPIO_15, PC3X3_GPIO_PIN_ARM_15,
+    pc3x3_ebi26_set_mux, pc3x3_ebi26_get_mux),
+};
+
+static struct pin_group ebi_addr_26_group = {
+	.nr_pins    = ARRAY_SIZE(ebi_addr_26),
+	.name	    = "ebi_addr[26]",
+	.pins	    = ebi_addr_26,
+};
+
+static int pc3x3_shd_pai_get_mux(struct muxed_pin *pin)
+{
+	int bit, err = 0, can_be_sd = 1;
+	unsigned long pai_mux;
+
+	spin_lock(&mux_lock);
+
+	pai_mux = axi2cfg_readl(AXI2CFG_USE_PAI_GPIO_REG_OFFSET);
+
+	/*
+	 * Find out what pai pin our GPIO maps to.
+	 */
+	if (pin->arm_pin >= PC3X3_GPIO_PIN_ARM_4 &&
+	    pin->arm_pin < PC3X3_GPIO_PIN_ARM_8) {
+		/* pai_tx_data[3:0] */
+		bit = pin->arm_pin - PC3X3_GPIO_PIN_ARM_4;
+	} else if (pin->arm_pin >= PC3X3_GPIO_PIN_ARM_20 &&
+		   pin->arm_pin < PC3X3_GPIO_PIN_ARM_24) {
+		/* pai_rx_data[3:0] */
+		bit = 8 + (pin->arm_pin - PC3X3_GPIO_PIN_ARM_20);
+	} else if (pin->arm_pin >= PC3X3_GPIO_PIN_ARM_24 &&
+		   pin->arm_pin < PC3X3_GPIO_PIN_ARM_28) {
+		/* pai_tx_data[7:4] */
+		bit = 4 + (pin->arm_pin - PC3X3_GPIO_PIN_ARM_24);
+		can_be_sd = 0;
+	} else {
+		/* pai_rx_data[7:4] */
+		bit = 12 + (pin->arm_pin - PC3X3_GPIO_PIN_ARM_28);
+		can_be_sd = 0;
+	}
+
+	if (!(pai_mux & (1 << bit))) {
+		err = MUX_PERIPHERAL_PAI;
+		goto out;
+	}
+
+	if (can_be_sd)
+		err = pc3x3_get_shd_mux(pin);
+	else
+		err = MUX_ARM;
+
+out:
+	spin_unlock(&mux_lock);
+
+	return err;
+}
+
+static int pc3x3_shd_pai_set_mux(struct muxed_pin *pin,
+				 enum mux_setting setting)
+{
+	int bit, err = 0, can_be_sd = 1;
+	unsigned long pai_mux;
+
+	if (!(setting == MUX_ARM || setting == MUX_SD ||
+	      setting == MUX_PERIPHERAL_PAI))
+		return -EINVAL;
+
+	spin_lock(&mux_lock);
+
+	pai_mux = axi2cfg_readl(AXI2CFG_USE_PAI_GPIO_REG_OFFSET);
+
+	/*
+	 * Find out what pai pin our GPIO maps to.
+	 */
+	if (pin->arm_pin >= PC3X3_GPIO_PIN_ARM_4 &&
+	    pin->arm_pin < PC3X3_GPIO_PIN_ARM_8) {
+		/* pai_tx_data[3:0] */
+		bit = pin->arm_pin - PC3X3_GPIO_PIN_ARM_4;
+	} else if (pin->arm_pin >= PC3X3_GPIO_PIN_ARM_20 &&
+		   pin->arm_pin < PC3X3_GPIO_PIN_ARM_24) {
+		/* pai_rx_data[3:0] */
+		bit = 8 + (pin->arm_pin - PC3X3_GPIO_PIN_ARM_20);
+	} else if (pin->arm_pin >= PC3X3_GPIO_PIN_ARM_24 &&
+		   pin->arm_pin < PC3X3_GPIO_PIN_ARM_28) {
+		/* pai_tx_data[7:4] */
+		bit = 4 + (pin->arm_pin - PC3X3_GPIO_PIN_ARM_24);
+		can_be_sd = 0;
+	} else {
+		/* pai_rx_data[7:4] */
+		bit = 12 + (pin->arm_pin - PC3X3_GPIO_PIN_ARM_28);
+		can_be_sd = 0;
+	}
+
+	if (MUX_SD == setting && !can_be_sd) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* Use the pin as pai. */
+	if (MUX_PERIPHERAL_PAI == setting)
+		pai_mux &= ~(1 << bit);
+	else
+		pai_mux |= (1 << bit);
+
+	axi2cfg_writel(pai_mux, AXI2CFG_USE_PAI_GPIO_REG_OFFSET);
+
+	/*
+	 * Make sure that the configuration is valid (the GPIO isn't going to
+	 * the EBI).
+	 */
+	if (axi2cfg_readl(AXI2CFG_USE_PAI_GPIO_REG_OFFSET) != pai_mux) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	/*
+	 * If we can be SD or ARM and we want to be gpio, pick the correct
+	 * one now.
+	 */
+	if (MUX_PERIPHERAL_PAI != setting && can_be_sd)
+		err = pc3x3_shd_gpio_set_mux(pin->arm_pin, setting);
+
+out:
+	spin_unlock(&mux_lock);
+
+	return err;
+}
+
+/*
+ * pai_rx_data[3:0] pads - these pads can be either the pai_rx_data or arm
+ * gpio or sdgpio. Note: the gpio pins can also be routed to the
+ * ebi_addr pads.
+ *
+ * A pad may only be used for GPIO if the corresponding GPIO pin is not
+ * already routed to the ebi address pad. The same applies in the reverse
+ * direction. Hardware interlocks exist to prevent this from happening.
+ */
+static struct muxed_pin pai_rx_data_0_3[] = {
+PIN(pai_rx_data0, PC3X3_GPIO_PIN_SDGPIO_4, PC3X3_GPIO_PIN_ARM_20,
+    pc3x3_shd_pai_set_mux, pc3x3_shd_pai_get_mux),
+PIN(pai_rx_data1, PC3X3_GPIO_PIN_SDGPIO_5, PC3X3_GPIO_PIN_ARM_21,
+    pc3x3_shd_pai_set_mux, pc3x3_shd_pai_get_mux),
+PIN(pai_rx_data2, PC3X3_GPIO_PIN_SDGPIO_6, PC3X3_GPIO_PIN_ARM_22,
+    pc3x3_shd_pai_set_mux, pc3x3_shd_pai_get_mux),
+PIN(pai_rx_data3, PC3X3_GPIO_PIN_SDGPIO_7, PC3X3_GPIO_PIN_ARM_23,
+    pc3x3_shd_pai_set_mux, pc3x3_shd_pai_get_mux),
+};
+
+static struct pin_group pai_rx_data_0_3_group = {
+	.nr_pins    = ARRAY_SIZE(pai_rx_data_0_3),
+	.name	    = "pai_rx_data[3:0]",
+	.pins	    = pai_rx_data_0_3,
+};
+
+/*
+ * pai_tx_data[3:0] pads - these pads can be either the pai_tx_data or arm
+ * gpio or sdgpio. Note: the gpio pins can also be routed to the
+ * ebi_addr pads.
+ *
+ * A pad may only be used for GPIO if the corresponding GPIO pin is not
+ * already routed to the ebi address pad. The same applies in the reverse
+ * direction. Hardware interlocks exist to prevent this from happening.
+ */
+static struct muxed_pin pai_tx_data_0_3[] = {
+PIN(pai_tx_data0, PC3X3_GPIO_PIN_SDGPIO_20, PC3X3_GPIO_PIN_ARM_4,
+    pc3x3_shd_pai_set_mux, pc3x3_shd_pai_get_mux),
+PIN(pai_tx_data1, PC3X3_GPIO_PIN_SDGPIO_21, PC3X3_GPIO_PIN_ARM_5,
+    pc3x3_shd_pai_set_mux, pc3x3_shd_pai_get_mux),
+PIN(pai_tx_data2, PC3X3_GPIO_PIN_SDGPIO_22, PC3X3_GPIO_PIN_ARM_6,
+    pc3x3_shd_pai_set_mux, pc3x3_shd_pai_get_mux),
+PIN(pai_tx_data3, PC3X3_GPIO_PIN_SDGPIO_23, PC3X3_GPIO_PIN_ARM_7,
+    pc3x3_shd_pai_set_mux, pc3x3_shd_pai_get_mux),
+};
+
+static struct pin_group pai_tx_data_0_3_group = {
+	.nr_pins    = ARRAY_SIZE(pai_tx_data_0_3),
+	.name	    = "pai_tx_data[3:0]",
+	.pins	    = pai_tx_data_0_3,
+};
+
+/*
+ * pai_tx_data[7:4] pads - these pads can either be pai_tx_data or arm gpio.
+ */
+static struct muxed_pin pai_tx_data_4_7[] = {
+PIN(pai_tx_data4, -1, PC3X3_GPIO_PIN_ARM_24, pc3x3_shd_pai_set_mux,
+    pc3x3_shd_pai_get_mux),
+PIN(pai_tx_data5, -1, PC3X3_GPIO_PIN_ARM_25, pc3x3_shd_pai_set_mux,
+    pc3x3_shd_pai_get_mux),
+PIN(pai_tx_data6, -1, PC3X3_GPIO_PIN_ARM_26, pc3x3_shd_pai_set_mux,
+    pc3x3_shd_pai_get_mux),
+PIN(pai_tx_data7, -1, PC3X3_GPIO_PIN_ARM_27, pc3x3_shd_pai_set_mux,
+    pc3x3_shd_pai_get_mux),
+};
+
+static struct pin_group pai_tx_data_4_7_group = {
+	.nr_pins    = ARRAY_SIZE(pai_tx_data_4_7),
+	.name	    = "pai_tx_data[7:4]",
+	.pins	    = pai_tx_data_4_7,
+};
+
+/*
+ * pai_rx_data[7:4] pads - these pads can either be pai_rx_data or arm gpio.
+ */
+static struct muxed_pin pai_rx_data_4_7[] = {
+PIN(pai_rx_data4, -1, PC3X3_GPIO_PIN_ARM_28, pc3x3_shd_pai_set_mux,
+    pc3x3_shd_pai_get_mux),
+PIN(pai_rx_data5, -1, PC3X3_GPIO_PIN_ARM_29, pc3x3_shd_pai_set_mux,
+    pc3x3_shd_pai_get_mux),
+PIN(pai_rx_data6, -1, PC3X3_GPIO_PIN_ARM_30, pc3x3_shd_pai_set_mux,
+    pc3x3_shd_pai_get_mux),
+PIN(pai_rx_data7, -1, PC3X3_GPIO_PIN_ARM_31, pc3x3_shd_pai_set_mux,
+    pc3x3_shd_pai_get_mux),
+};
+
+static struct pin_group pai_rx_data_4_7_group = {
+	.nr_pins    = ARRAY_SIZE(pai_rx_data_4_7),
+	.name	    = "pai_rx_data[7:4]",
+	.pins	    = pai_rx_data_4_7,
+};
+
+/*
+ * ebi_addr[17:14] pads - these pads can either be ebi_addr or arm gpio.
+ */
+static struct muxed_pin ebi_addr_14_17[] = {
+PIN(ebi_addr14, -1, PC3X3_GPIO_PIN_ARM_32, pc3x3_shd_ebi_set_mux,
+    pc3x3_shd_ebi_get_mux),
+PIN(ebi_addr15, -1, PC3X3_GPIO_PIN_ARM_33, pc3x3_shd_ebi_set_mux,
+    pc3x3_shd_ebi_get_mux),
+PIN(ebi_addr16, -1, PC3X3_GPIO_PIN_ARM_34, pc3x3_shd_ebi_set_mux,
+    pc3x3_shd_ebi_get_mux),
+PIN(ebi_addr17, -1, PC3X3_GPIO_PIN_ARM_35, pc3x3_shd_ebi_set_mux,
+    pc3x3_shd_ebi_get_mux),
+};
+
+static struct pin_group ebi_addr_14_17_group = {
+	.nr_pins    = ARRAY_SIZE(ebi_addr_14_17),
+	.name	    = "ebi_addr[17:14]",
+	.pins	    = ebi_addr_14_17,
+};
+
+static int decode_get_mux(struct muxed_pin *pin)
+{
+	unsigned bit = pin->arm_pin - PC3X3_GPIO_PIN_ARM_36;
+	unsigned long use_decode_gpio =
+		axi2cfg_readl(AXI2CFG_USE_DECODE_GPIO_REG_OFFSET);
+
+	return use_decode_gpio & (1 << bit) ? MUX_ARM : MUX_PERIPHERAL_DECODE;
+}
+
+static int decode_set_mux(struct muxed_pin *pin,
+			  enum mux_setting setting)
+{
+	unsigned long use_decode_gpio;
+	unsigned bit = pin->arm_pin - PC3X3_GPIO_PIN_ARM_36;
+
+	if (!(setting == MUX_ARM || setting == MUX_PERIPHERAL_DECODE))
+		return -EINVAL;
+
+	spin_lock(&mux_lock);
+
+	use_decode_gpio = axi2cfg_readl(AXI2CFG_USE_DECODE_GPIO_REG_OFFSET);
+	if (MUX_ARM == setting)
+		use_decode_gpio |= (1 << bit);
+	else
+		use_decode_gpio &= ~(1 << bit);
+	axi2cfg_writel(use_decode_gpio, AXI2CFG_USE_DECODE_GPIO_REG_OFFSET);
+
+	spin_unlock(&mux_lock);
+
+	return 0;
+}
+
+/*
+ * decode[3:0] pads - these pads can either be decode pins or arm gpio.
+ */
+static struct muxed_pin decode_0_3[] = {
+PIN(decode0, -1, PC3X3_GPIO_PIN_ARM_36, decode_set_mux, decode_get_mux),
+PIN(decode1, -1, PC3X3_GPIO_PIN_ARM_37, decode_set_mux, decode_get_mux),
+PIN(decode2, -1, PC3X3_GPIO_PIN_ARM_38, decode_set_mux, decode_get_mux),
+PIN(decode3, -1, PC3X3_GPIO_PIN_ARM_39, decode_set_mux, decode_get_mux),
+};
+
+static struct pin_group decode_0_3_group = {
+	.nr_pins    = ARRAY_SIZE(decode_0_3),
+	.name	    = "decode[3:0]",
+	.pins	    = decode_0_3,
+};
+
+static int ssi_set_mux(struct muxed_pin *pin, enum mux_setting setting);
+
+static int
+ssi_get_mux(struct muxed_pin *pin);
+
+/*
+ * ssi pads - these pads can either be ssi block pins or arm gpio.
+ */
+static struct muxed_pin ssi[] = {
+PIN(ssi_clk, -1, PC3X3_GPIO_PIN_ARM_40, ssi_set_mux, ssi_get_mux),
+PIN(ssi_data_in, -1, PC3X3_GPIO_PIN_ARM_41, ssi_set_mux, ssi_get_mux),
+PIN(ssi_data_out, -1, PC3X3_GPIO_PIN_ARM_42, ssi_set_mux, ssi_get_mux),
+};
+
+static int ssi_get_mux(struct muxed_pin *pin)
+{
+	unsigned long use_misc_int_gpio =
+		axi2cfg_readl(AXI2CFG_USE_MISC_INT_GPIO_REG_OFFSET);
+
+	return use_misc_int_gpio & (1 << 0) ? MUX_ARM : MUX_PERIPHERAL_SSI;
+}
+
+static int ssi_set_mux(struct muxed_pin *pin, enum mux_setting setting)
+{
+	unsigned long use_misc_int_gpio;
+
+	if (!(setting == MUX_ARM || setting == MUX_PERIPHERAL_SSI))
+		return -EINVAL;
+
+	spin_lock(&mux_lock);
+
+	use_misc_int_gpio = axi2cfg_readl(AXI2CFG_USE_MISC_INT_GPIO_REG_OFFSET);
+	if (MUX_PERIPHERAL_SSI == setting)
+		use_misc_int_gpio &= ~(1 << 0);
+	else
+		use_misc_int_gpio |= (1 << 0);
+	axi2cfg_writel(use_misc_int_gpio, AXI2CFG_USE_MISC_INT_GPIO_REG_OFFSET);
+
+	spin_unlock(&mux_lock);
+
+	return 0;
+}
+
+static struct pin_group ssi_group = {
+	.nr_pins    = ARRAY_SIZE(ssi),
+	.name	    = "ssi",
+	.pins	    = ssi,
+};
+
+static int mii_get_mux(struct muxed_pin *pin)
+{
+	unsigned long syscfg = syscfg_read();
+
+	return syscfg & (1 << 13) ? MUX_ARM : MUX_PERIPHERAL_MII;
+}
+
+static int mii_set_mux(struct muxed_pin *pin, enum mux_setting setting)
+{
+	/*
+	 * These are automatically configured by hardware if we are in
+	 * reduced MII mode.
+	 */
+	return -EOPNOTSUPP;
+}
+
+/*
+ * mii pads - these pads can either be mii pins or arm gpio.
+ */
+static struct muxed_pin mii[] = {
+PIN(mii_tx_data2, -1, PC3X3_GPIO_PIN_ARM_43, mii_set_mux, mii_get_mux),
+PIN(mii_tx_data3, -1, PC3X3_GPIO_PIN_ARM_44, mii_set_mux, mii_get_mux),
+PIN(mii_rx_data2, -1, PC3X3_GPIO_PIN_ARM_45, mii_set_mux, mii_get_mux),
+PIN(mii_rx_data3, -1, PC3X3_GPIO_PIN_ARM_46, mii_set_mux, mii_get_mux),
+PIN(mii_col, -1, PC3X3_GPIO_PIN_ARM_47, mii_set_mux, mii_get_mux),
+PIN(mii_crs, -1, PC3X3_GPIO_PIN_ARM_48, mii_set_mux, mii_get_mux),
+PIN(mii_tx_clk, -1, PC3X3_GPIO_PIN_ARM_49, mii_set_mux, mii_get_mux),
+};
+
+static struct pin_group mii_group = {
+	.nr_pins    = ARRAY_SIZE(mii),
+	.name	    = "mii",
+	.pins	    = mii,
+};
+
+static int max_set_mux(struct muxed_pin *pin, enum mux_setting setting);
+
+static int max_get_mux(struct muxed_pin *pin);
+
+/*
+ * maxim pads - these pads can either be maxim pins or arm gpio.
+ */
+static struct muxed_pin max[] = {
+PIN(max_tx_ctrl, -1, PC3X3_GPIO_PIN_ARM_50, max_set_mux, max_get_mux),
+PIN(max_ref_clk, -1, PC3X3_GPIO_PIN_ARM_51, max_set_mux, max_get_mux),
+PIN(max_trig_clk, -1, PC3X3_GPIO_PIN_ARM_52, max_set_mux, max_get_mux),
+};
+
+static int max_get_mux(struct muxed_pin *pin)
+{
+	unsigned long use_misc_int_gpio =
+		axi2cfg_readl(AXI2CFG_USE_MISC_INT_GPIO_REG_OFFSET);
+
+	return use_misc_int_gpio & (1 << 1) ? MUX_ARM : MUX_PERIPHERAL_MAXIM;
+}
+
+static int max_set_mux(struct muxed_pin *pin, enum mux_setting setting)
+{
+	unsigned long use_misc_int_gpio;
+
+	if (!(setting == MUX_ARM || setting == MUX_PERIPHERAL_MAXIM))
+		return -EINVAL;
+
+	spin_lock(&mux_lock);
+
+	use_misc_int_gpio = axi2cfg_readl(AXI2CFG_USE_MISC_INT_GPIO_REG_OFFSET);
+	if (MUX_PERIPHERAL_MAXIM == setting)
+		use_misc_int_gpio &= ~(1 << 1);
+	else
+		use_misc_int_gpio |= (1 << 1);
+	axi2cfg_writel(use_misc_int_gpio, AXI2CFG_USE_MISC_INT_GPIO_REG_OFFSET);
+
+	spin_unlock(&mux_lock);
+
+	return 0;
+}
+
+
+static struct pin_group max_group = {
+	.nr_pins    = ARRAY_SIZE(max),
+	.name	    = "mii",
+	.pins	    = max,
+};
+
+static int ebi_clk_get_mux(struct muxed_pin *pin)
+{
+	unsigned long ebi_mux = axi2cfg_readl(AXI2CFG_USE_EBI_GPIO_REG_OFFSET);
+
+	return ebi_mux & (1 << 13) ? MUX_ARM : MUX_PERIPHERAL_EBI;
+}
+
+static int ebi_clk_set_mux(struct muxed_pin *pin, enum mux_setting setting)
+{
+	unsigned long ebi_mux;
+
+	if (!(setting == MUX_ARM || setting == MUX_PERIPHERAL_EBI))
+		return -EINVAL;
+
+	spin_lock(&mux_lock);
+
+	ebi_mux = axi2cfg_readl(AXI2CFG_USE_EBI_GPIO_REG_OFFSET);
+	if (MUX_PERIPHERAL_EBI == setting)
+		ebi_mux &= ~(1 << 13);
+	else
+		ebi_mux |= (1 << 13);
+	axi2cfg_writel(ebi_mux, AXI2CFG_USE_EBI_GPIO_REG_OFFSET);
+
+	spin_unlock(&mux_lock);
+
+	return 0;
+}
+
+/*
+ * ebi clock pads - this pad can either be the ebi clock or an arm gpio.
+ */
+static struct muxed_pin ebi_clk_pin[] = {
+PIN(ebi_clk_pin, -1, PC3X3_GPIO_PIN_ARM_53, ebi_clk_set_mux, ebi_clk_get_mux),
+};
+
+static struct pin_group ebi_clk_group = {
+	.nr_pins    = ARRAY_SIZE(ebi_clk_pin),
+	.name	    = "ebi_clk",
+	.pins	    = ebi_clk_pin,
+};
+
+static struct muxed_pin pc3x3_fracn_pins[] = {
+PIN(sdgpio0, PC3X3_GPIO_PIN_SDGPIO_0, -1, pc3x3_shd_mux, pc3x3_get_shd_mux),
+};
+
+static struct pin_group pc3x3_fracn_group = {
+	.nr_pins    = ARRAY_SIZE(pc3x3_fracn_pins),
+	.name	    = "fracn/sdgpio0",
+	.pins	    = pc3x3_fracn_pins,
+};
+
+static struct pin_group *pc3x3_groups[] = {
+	&armgpio_0_4_group,
+	&pc3x3_shd_group,
+	&boot_mode_group,
+	&sdram_speed_sel_group,
+	&mii_rev_en_group,
+	&mii_rmii_en_group,
+	&mii_speed_sel_group,
+	&ebi_addr_26_group,
+	&ebi_addr_18_25_group,
+	&pai_tx_data_0_3_group,
+	&pai_rx_data_0_3_group,
+	&pai_tx_data_4_7_group,
+	&pai_rx_data_4_7_group,
+	&ebi_addr_14_17_group,
+	&decode_0_3_group,
+	&ssi_group,
+	&mii_group,
+	&max_group,
+	&ebi_clk_group,
+	&pc3x3_fracn_group,
+};
+
+static int armgpio_number(int pin)
+{
+	if (pin < 0 || pin > PC3X3_GPIO_PIN_ARM_53)
+		return -1;
+	return pin;
+}
+
+static int sdgpio_number(int pin)
+{
+	if (pin < PC3X3_GPIO_PIN_SDGPIO_0 ||
+	    pin > PC3X3_GPIO_PIN_SDGPIO_23)
+		return -1;
+	return pin - PC3X3_GPIO_PIN_SDGPIO_0;
+}
+
+static void pc3x3_init_muxing(void)
+{
+	picoxcell_mux_register(pc3x3_groups, ARRAY_SIZE(pc3x3_groups),
+			       armgpio_number, sdgpio_number);
+}
+
+static const char * const pc3x3_armgpio_pins[] = {
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
+	"arm16",
+	"arm17",
+	"arm18",
+	"arm19",
+	"arm20",
+	"arm21",
+	"arm22",
+	"arm23",
+	"arm24",
+	"arm25",
+	"arm26",
+	"arm27",
+	"arm28",
+	"arm29",
+	"arm30",
+	"arm31",
+	"arm32",
+	"arm33",
+	"arm34",
+	"arm35",
+	"arm36",
+	"arm37",
+	"arm38",
+	"arm39",
+	"arm40",
+	"arm41",
+	"arm42",
+	"arm43",
+	"arm44",
+	"arm45",
+	"arm46",
+	"arm47",
+	"arm48",
+	"arm49",
+	"arm50",
+	"arm51",
+};
+
+static const char * const pc3x3_sdgpio_pins[] = {
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
+	"sdgpio16",
+	"sdgpio17",
+	"sdgpio18",
+	"sdgpio19",
+	"sdgpio20",
+	"sdgpio21",
+	"sdgpio22",
+	"sdgpio23",
+};
+
+static const struct picoxcell_timer pc3x3_timers[] = {
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
+		.base	= PC3X3_TIMER2_BASE + 0 * TIMER_SPACING,
+		.irq	= IRQ_TIMER2,
+	},
+	{
+		.name	= "timer3",
+		.type	= TIMER_TYPE_TIMER,
+		.base	= PC3X3_TIMER2_BASE + 1 * TIMER_SPACING,
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
+static void pc3x3_init(void);
+
+struct picoxcell_soc pc3x3_soc = {
+	.init		= pc3x3_init,
+	.init_clocks	= pc3x3_clk_init,
+	.init_muxing	= pc3x3_init_muxing,
+	.get_boot_mode	= pc3x3_get_boot_mode,
+	.armgpio_pins	= pc3x3_armgpio_pins,
+	.nr_armgpio	= ARRAY_SIZE(pc3x3_armgpio_pins),
+	.armgpio_base	= PC3X3_GPIO_PIN_ARM_0,
+	.sdgpio_pins	= pc3x3_sdgpio_pins,
+	.nr_sdgpio	= ARRAY_SIZE(pc3x3_sdgpio_pins),
+	.sdgpio_base	= PC3X3_GPIO_PIN_SDGPIO_0,
+	.timers		= pc3x3_timers,
+	.nr_timers	= ARRAY_SIZE(pc3x3_timers),
+};
+
+static void pc3x3_init(void)
+{
+	/*
+	 * If we booted in parallel nor mode then we can continue to use the
+	 * EBI. If not then we only have a few bits of the EBI - just enough
+	 * to drive a NAND flash.
+	 */
+	if (syscfg_read() & 0x3)
+		set_bit(PICOXCELL_FEATURE_SW_NAND, pc3x3_soc.features);
+	else
+		set_bit(PICOXCELL_FEATURE_EBI, pc3x3_soc.features);
+	set_bit(PICOXCELL_FEATURE_PM, pc3x3_soc.features);
+	set_bit(PICOXCELL_FEATURE_CPUFREQ, pc3x3_soc.features);
+}
diff --git a/arch/arm/mach-picoxcell/picoxcell_core.c b/arch/arm/mach-picoxcell/picoxcell_core.c
index fd4cc26..2cfefd4 100644
--- a/arch/arm/mach-picoxcell/picoxcell_core.c
+++ b/arch/arm/mach-picoxcell/picoxcell_core.c
@@ -46,6 +46,11 @@ struct picoxcell_soc *picoxcell_get_soc(void)
 	case 0x8007:
 		return &pc3x2_soc;
 
+	case 0x20:
+	case 0x21:
+	case 0x22:
+		return &pc3x3_soc;
+
 	default:
 		panic("unsupported device type %lx", device_id);
 	}
@@ -99,6 +104,12 @@ static const char *picoxcell_get_partname(void)
 		part = "pc302";
 	else if (0x8007 == dev_id)
 		part = "pc312";
+	else if (0x20 == dev_id)
+		part = "pc313";
+	else if (0x21 == dev_id)
+		part = "pc323";
+	else if (0x22 == dev_id)
+		part = "pc333";
 	else
 		part = "<unknown>";
 
diff --git a/arch/arm/mach-picoxcell/soc.h b/arch/arm/mach-picoxcell/soc.h
index fccd278..4b4d92f 100644
--- a/arch/arm/mach-picoxcell/soc.h
+++ b/arch/arm/mach-picoxcell/soc.h
@@ -49,6 +49,7 @@ struct picoxcell_soc {
 
 extern struct picoxcell_soc *picoxcell_get_soc(void);
 extern struct picoxcell_soc pc3x2_soc;
+extern struct picoxcell_soc pc3x3_soc;
 
 static inline int picoxcell_has_feature(enum picoxcell_features feat)
 {
-- 
1.7.2.3
