From: linux-arm@overkiz.com (Boris BREZILLON)
Date: Sat, 12 May 2012 10:53:55 +0200
Subject: [PATCH 2/5] ARM: at91: Implementation of PMC clks using the common
 clk framework.
In-Reply-To: <1336812838-3649-1-git-send-email-linux-arm@overkiz.com>
References: <1336812838-3649-1-git-send-email-linux-arm@overkiz.com>
Message-ID: <1336812838-3649-3-git-send-email-linux-arm@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchs implements the PMC clks using the common clk framework.
Some clks are not implemented yet (UTMI, USB host, USB device).

---
 arch/arm/mach-at91/Kconfig      |    1 +
 arch/arm/mach-at91/Makefile     |    5 +-
 arch/arm/mach-at91/pmc-master.c |  401 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/pmc-osc.c    |  165 ++++++++++++++++
 arch/arm/mach-at91/pmc-periph.c |  111 +++++++++++
 arch/arm/mach-at91/pmc-pll.c    |  371 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/pmc-prog.c   |  194 +++++++++++++++++++
 arch/arm/mach-at91/pmc-sys.c    |   81 ++++++++
 arch/arm/mach-at91/pmc.c        |  260 +++++++++++++++++++++++++
 arch/arm/mach-at91/pmc.h        |   70 +++++++
 10 files changed, 1658 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-at91/pmc-master.c
 create mode 100644 arch/arm/mach-at91/pmc-osc.c
 create mode 100644 arch/arm/mach-at91/pmc-periph.c
 create mode 100644 arch/arm/mach-at91/pmc-pll.c
 create mode 100644 arch/arm/mach-at91/pmc-prog.c
 create mode 100644 arch/arm/mach-at91/pmc-sys.c
 create mode 100644 arch/arm/mach-at91/pmc.c
 create mode 100644 arch/arm/mach-at91/pmc.h

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 98a42f3..b2686c6 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -489,6 +489,7 @@ comment "Generic Board Type"
 config MACH_AT91SAM_DT
 	bool "Atmel AT91SAM Evaluation Kits with device-tree support"
 	select USE_OF
+	select COMMON_CLK
 	help
 	  Select this if you want to experiment device-tree with
 	  an Atmel Evaluation Kit.
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 79d0f60..29f8812 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -6,8 +6,11 @@ obj-y		:= irq.o gpio.o setup.o
 obj-m		:=
 obj-n		:=
 obj-		:=
-
+ifeq ($(CONFIG_COMMON_CLK),y)
+obj-$(CONFIG_AT91_PMC_UNIT)	+= pmc-osc.o pmc-pll.o pmc-master.o pmc-sys.o pmc-periph.o pmc-prog.o pmc.o
+else
 obj-$(CONFIG_AT91_PMC_UNIT)	+= clock.o
+endif
 obj-$(CONFIG_AT91_SAM9_ALT_RESET) += at91sam9_alt_reset.o
 obj-$(CONFIG_AT91_SAM9G45_RESET) += at91sam9g45_reset.o
 obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam926x_time.o sam9_smc.o
diff --git a/arch/arm/mach-at91/pmc-master.c b/arch/arm/mach-at91/pmc-master.c
new file mode 100644
index 0000000..cac6f60
--- /dev/null
+++ b/arch/arm/mach-at91/pmc-master.c
@@ -0,0 +1,401 @@
+#include <linux/slab.h>
+
+#include "pmc.h"
+
+
+struct at91_pmc_pres_clk {
+	struct at91_pmc_clk base;
+	u32 offset : 5;
+};
+
+#define pmc_clk_to_pmc_pres_clk(pmcck) container_of(pmcck, struct at91_pmc_pres_clk, base)
+
+struct at91_pmc_master_clk {
+	struct at91_pmc_clk base;
+	u32 div[4];
+};
+
+#define pmc_clk_to_pmc_master_clk(pmcck) container_of(pmcck, struct at91_pmc_master_clk, base)
+
+struct at91_pmc_proc_clk {
+	struct at91_pmc_clk base;
+	u32 div : 1;
+};
+
+#define pmc_clk_to_pmc_proc_clk(pmcck) container_of(pmcck, struct at91_pmc_proc_clk, base)
+
+
+static unsigned long at91_pmc_pres_clk_recalc_rate(struct clk_hw *hw, unsigned long irate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_pres_clk *presclk = pmc_clk_to_pmc_pres_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	unsigned long value = (at91_pmc_read(pmc, AT91_PMC_MCKR) >> presclk->offset) & 0x7;
+
+	return irate >> value;
+
+}
+
+static long at91_pmc_pres_clk_round_rate (struct clk_hw *hw, unsigned long orate, unsigned long *prate) {
+	struct clk *parent = __clk_get_parent(hw->clk);
+	unsigned long irate = __clk_get_rate(parent);
+	unsigned long rate, prev;
+	int i;
+
+	if (orate > irate) {
+		return irate;
+	}
+
+	prev = irate;
+
+	for (i = 0; i < 7; ++i) {
+		rate = irate >> i;
+		if (rate < orate) {
+			return prev - orate > orate - rate ? rate : prev;
+		}
+		prev = rate;
+	}
+
+	return rate;
+
+}
+
+
+static int at91_pmc_pres_clk_set_parent(struct clk_hw *hw, u8 index) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_pres_clk *presclk = pmc_clk_to_pmc_pres_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+
+	unsigned long value = at91_pmc_read(pmc, AT91_PMC_MCKR);
+
+	if (index > AT91_PMC_CSS)
+		return -EINVAL;
+
+
+	if (index & AT91_PMC_CSS_PLLA) {
+		value &= ~(7 << presclk->offset);
+		value |= (6 << presclk->offset);
+		at91_pmc_write(pmc, AT91_PMC_MCKR, value);
+		while (at91_pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MCKRDY);
+
+		value &= ~AT91_PMC_CSS;
+		value |= index;
+		at91_pmc_write(pmc, AT91_PMC_MCKR, value);
+		while (at91_pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MCKRDY);
+	}
+	else {
+		value &= ~AT91_PMC_CSS;
+		value |= index;
+		at91_pmc_write(pmc, AT91_PMC_MCKR, value);
+		while (at91_pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MCKRDY);
+
+		value &= ~(7 << presclk->offset);
+		at91_pmc_write(pmc, AT91_PMC_MCKR, value);
+		while (at91_pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MCKRDY);
+	}
+
+	return 0;
+}
+
+static u8 at91_pmc_pres_clk_get_parent(struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc *pmc = pmcclk->pmc;
+
+
+	return at91_pmc_read(pmc, AT91_PMC_MCKR) & AT91_PMC_CSS;
+}
+
+static int at91_pmc_pres_clk_set_rate(struct clk_hw *hw, unsigned long orate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_pres_clk *presclk = pmc_clk_to_pmc_pres_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	struct clk *parent = __clk_get_parent(hw->clk);
+	unsigned long irate = __clk_get_rate(parent);
+	unsigned long rate;
+	int i;
+	unsigned long value;
+
+	for (i = 0; i < 7; ++i) {
+		rate = irate >> i;
+		if (rate == orate) {
+			value = at91_pmc_read(pmc, AT91_PMC_MCKR) & ~(0x7 << presclk->offset);
+			value |= (i << presclk->offset);
+			at91_pmc_write(pmc, AT91_PMC_MCKR, value);
+			while (at91_pmc_read(pmc, AT91_PMC_SR) & AT91_PMC_MCKRDY);
+			return 0;
+		}
+
+		if (rate < orate)
+			break;
+	}
+
+	return -EINVAL;
+}
+
+
+static int at91_pmc_pres_clk_is_enabled(struct clk_hw *hw) {
+	return 1;
+}
+
+struct clk_ops at91_pmc_pres_clk_ops = {
+	.is_enabled = at91_pmc_pres_clk_is_enabled,
+	.recalc_rate = at91_pmc_pres_clk_recalc_rate,
+	.round_rate = at91_pmc_pres_clk_round_rate,
+	.set_parent = at91_pmc_pres_clk_set_parent,
+	.get_parent = at91_pmc_pres_clk_get_parent,
+	.set_rate = at91_pmc_pres_clk_set_rate,
+};
+
+
+static unsigned long at91_pmc_master_clk_recalc_rate(struct clk_hw *hw, unsigned long irate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_master_clk *masterclk = pmc_clk_to_pmc_master_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	unsigned long value = (at91_pmc_read(pmc, AT91_PMC_MCKR) >> 8) & 0x3;
+
+	if (!masterclk->div[value]) {
+		return irate;
+	}
+
+	return irate / masterclk->div[value];
+
+}
+
+static long at91_pmc_master_clk_round_rate (struct clk_hw *hw, unsigned long orate, unsigned long *bestprate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_master_clk *masterclk = pmc_clk_to_pmc_master_clk(pmcclk);
+	struct clk *parent = __clk_get_parent(hw->clk);
+	unsigned long rate, bestrate = __clk_get_rate(parent);
+	unsigned long prate;
+	unsigned long dist, bestdist = 0xffffffff;
+	int i;
+
+	for (i = 0; i < 3; ++i) {
+		if (!masterclk->div[i])
+			break;
+
+		rate = orate * masterclk->div[i];
+		prate = __clk_round_rate(parent, rate);
+		rate = prate / masterclk->div[i];
+
+		if (rate > orate)
+			dist = rate - orate;
+		else
+			dist = orate - rate;
+
+		if (dist < bestdist) {
+			*bestprate = prate;
+			bestrate = rate;
+			bestdist = dist;
+		}
+
+	}
+
+	return bestrate;
+
+}
+
+
+static int at91_pmc_master_clk_set_rate(struct clk_hw *hw, unsigned long orate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_master_clk *masterclk = pmc_clk_to_pmc_master_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	struct clk *parent = __clk_get_parent(hw->clk);
+	unsigned long irate = __clk_get_rate(parent);
+	unsigned long rate;
+	int i;
+	unsigned long value;
+
+
+	for (i = 0; i < 3; ++i) {
+		if (!masterclk->div[i])
+			break;
+		rate = irate / masterclk->div[i];
+		if (rate == orate) {
+			value = at91_pmc_read(pmc, AT91_PMC_MCKR) & ~AT91_PMC_MDIV;
+			value |= (i << 8);
+			at91_pmc_write(pmc, AT91_PMC_MCKR, value);
+			return 0;
+		}
+
+		if (rate < orate)
+			break;
+	}
+
+	return -EINVAL;
+}
+
+static int at91_pmc_master_clk_is_enabled(struct clk_hw *hw) {
+	return 1;
+}
+
+struct clk_ops at91_pmc_master_clk_ops = {
+	.is_enabled = at91_pmc_master_clk_is_enabled,
+	.recalc_rate = at91_pmc_master_clk_recalc_rate,
+	.round_rate = at91_pmc_master_clk_round_rate,
+	.set_rate = at91_pmc_master_clk_set_rate,
+};
+
+
+static unsigned long at91_pmc_proc_clk_recalc_rate(struct clk_hw *hw, unsigned long irate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_proc_clk *procclk = pmc_clk_to_pmc_proc_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+
+	if (!procclk->div)
+		return irate;
+
+	return irate >> ((at91_pmc_read(pmc, AT91_PMC_MCKR) >> 12) & 0x1);
+
+}
+
+static long at91_pmc_proc_clk_round_rate (struct clk_hw *hw, unsigned long orate, unsigned long *bestprate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_proc_clk *procclk = pmc_clk_to_pmc_proc_clk(pmcclk);
+	struct clk *parent = __clk_get_parent(hw->clk);
+	unsigned long rate, prate, dist, bestdist, bestrate;
+
+	if (!procclk->div) {
+		*bestprate = __clk_round_rate(parent, orate);
+		return *bestprate;
+	}
+
+	bestrate = *bestprate = __clk_round_rate(parent, orate);
+	bestdist = orate > bestrate ? orate - bestrate : bestrate - orate;
+	prate = __clk_round_rate(parent, orate * 2);
+	rate = prate / 2;
+	dist = orate > rate ? orate - rate : rate - orate;
+
+	if (dist < bestdist) {
+		*bestprate = prate;
+		bestrate = rate;
+	}
+
+	return bestrate;
+
+}
+
+
+static int at91_pmc_proc_clk_set_rate(struct clk_hw *hw, unsigned long orate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_proc_clk *procclk = pmc_clk_to_pmc_proc_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	struct clk *parent = __clk_get_parent(hw->clk);
+	unsigned long irate = __clk_get_rate(parent);
+	unsigned long value;
+
+	if (!procclk->div) {
+		if (orate != irate)
+			return -EINVAL;
+		else
+			return 0;
+	}
+
+	value = at91_pmc_read(pmc, AT91_PMC_MCKR);
+
+	if (irate == orate)
+		value &= ~AT91_PMC_PDIV;
+	else if ((irate >> 1) == orate)
+		value |= AT91_PMC_PDIV;
+	else
+		return -EINVAL;
+
+	at91_pmc_write(pmc, AT91_PMC_MCKR, value);
+
+	return 0;
+}
+
+static void at91_pmc_proc_clk_disable(struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc *pmc = pmcclk->pmc;
+
+	at91_pmc_write(pmc, AT91_PMC_SCDR, AT91_PMC_PCK);
+}
+
+static int at91_pmc_proc_clk_is_enabled(struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc *pmc = pmcclk->pmc;
+
+	return !!(at91_pmc_read(pmc, AT91_PMC_SCSR) & AT91_PMC_PCK);
+}
+
+struct clk_ops at91_pmc_proc_clk_ops = {
+	.disable = at91_pmc_proc_clk_disable,
+	.is_enabled = at91_pmc_proc_clk_is_enabled,
+	.recalc_rate = at91_pmc_proc_clk_recalc_rate,
+	.round_rate = at91_pmc_proc_clk_round_rate,
+	.set_rate = at91_pmc_proc_clk_set_rate,
+};
+
+
+int __init at91_pmc_pres_clk_register (struct device_node *np) {
+	struct at91_pmc_pres_clk *clk;
+	int err;
+	u32 tmp;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return -ENOMEM;
+
+	err = of_property_read_u32(np, "offset", &tmp);
+	if (err)
+		clk->offset = 2;
+	else
+		clk->offset = tmp;
+
+	err = at91_pmc_clk_register (np, &at91_pmc_pres_clk_ops, &clk->base, 0);
+
+	/* enable prescaler clock */
+	if (!err)
+		err = clk_prepare_enable(clk->base.base.clk);
+	else
+		kfree(clk);
+
+	return err;
+}
+
+int __init at91_pmc_master_clk_register (struct device_node *np) {
+	struct at91_pmc_master_clk *clk;
+	int err;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return -ENOMEM;
+
+	err = of_property_read_u32_array(np, "divisors", clk->div, 4);
+	if (err) {
+		kfree(clk);
+		return -EINVAL;
+	}
+
+	err = at91_pmc_clk_register (np, &at91_pmc_master_clk_ops, &clk->base, CLK_SET_RATE_PARENT);
+
+	/* enable prescaler clock */
+	if (!err)
+		err = clk_prepare_enable(clk->base.base.clk);
+	else
+		kfree(clk);
+
+	return err;
+}
+
+int __init at91_pmc_proc_clk_register (struct device_node *np) {
+	struct at91_pmc_proc_clk *clk;
+	int err;
+	u32 tmp = 0;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return -ENOMEM;
+
+
+
+	of_property_read_u32(np, "divisor", &tmp);
+	clk->div = !!tmp;
+
+	err = at91_pmc_clk_register (np, &at91_pmc_master_clk_ops, &clk->base, CLK_SET_RATE_PARENT);
+
+	if (err)
+		kfree(clk);
+
+	return err;
+}
diff --git a/arch/arm/mach-at91/pmc-osc.c b/arch/arm/mach-at91/pmc-osc.c
new file mode 100644
index 0000000..15ded77
--- /dev/null
+++ b/arch/arm/mach-at91/pmc-osc.c
@@ -0,0 +1,165 @@
+#include <linux/slab.h>
+
+#include "pmc.h"
+
+struct at91_pmc_slow_clk {
+	struct at91_pmc_clk base;
+	u32 frequency;
+};
+
+#define pmc_clk_to_pmc_slow_clk(pmcck) container_of(pmcck, struct at91_pmc_slow_clk, base)
+
+struct at91_pmc_main_clk {
+	struct at91_pmc_clk base;
+	u32 frequency;
+	int bypass;
+};
+
+#define pmc_clk_to_pmc_main_clk(pmcck) container_of(pmcck, struct at91_pmc_main_clk, base)
+
+
+static unsigned long at91_pmc_slow_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_slow_clk *slowclk = pmc_clk_to_pmc_slow_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	unsigned long ret = slowclk->frequency;
+	unsigned long value;
+
+	if (ret)
+		return ret;
+
+	value = at91_pmc_read (pmc, AT91_PMC_SR);
+
+	if (!(value & AT91_PMC_MOSCS)) {
+		/* Internal RC Oscillator is not reliable (22 - 42 KHz) */
+		value = at91_pmc_read (pmc, AT91_CKGR_MCFR);
+
+		if (value & AT91_PMC_MAINRDY) {
+			value &= AT91_PMC_MAINF;
+			ret = parent_rate * 16 / value;
+		}
+
+	}
+
+	return ret;
+}
+
+struct clk_ops at91_pmc_slow_clk_ops = {
+	.recalc_rate = at91_pmc_slow_clk_recalc_rate,
+};
+
+
+static int at91_pmc_main_clk_enable (struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_main_clk *mainclk = pmc_clk_to_pmc_main_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+
+	if (!at91_pmc_supported (pmc, AT91_PMC_MOSCEN))
+		return 0;
+
+	if (!mainclk->bypass) {
+		/* Enable Main oscillator */
+		/* Wait 0xff slow clocks (< 10ms) */
+		at91_pmc_write(pmc, AT91_PMC_MOSCEN, AT91_PMC_OSCOUNT | AT91_PMC_MOSCEN);
+	} else {
+		/* Enable XIN */
+		/* Wait 0xff slow clocks (< 10ms) */
+		at91_pmc_write(pmc, AT91_PMC_MOSCEN, AT91_PMC_OSCBYPASS);
+	}
+
+	/* Wait for osc stabilization */
+	while (!(at91_pmc_read (pmc, AT91_PMC_SR) & AT91_PMC_MOSCS));
+
+	return 0;
+}
+
+static void at91_pmc_main_clk_disable (struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc *pmc = pmcclk->pmc;
+
+	at91_pmc_write(pmc, AT91_PMC_MOSCEN, AT91_PMC_OSCOUNT | AT91_PMC_MOSCEN);
+}
+
+static int at91_pmc_main_clk_is_enabled(struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc *pmc = pmcclk->pmc;
+
+	return at91_pmc_read (pmc, AT91_PMC_SR) & AT91_PMC_MOSCS;
+}
+
+
+static unsigned long at91_pmc_main_clk_recalc_rate (struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_main_clk *mainclk = pmc_clk_to_pmc_main_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	unsigned long value;
+	unsigned long ret = mainclk->frequency;
+
+	if (!mainclk->frequency) {
+		value = at91_pmc_read (pmc, AT91_PMC_SR);
+
+		if (!(value & AT91_PMC_MOSCS)) {
+			/* Internal RC Oscillator is not reliable (22 - 42 KHz) */
+			value = at91_pmc_read (pmc, AT91_CKGR_MCFR);
+
+			if (value & AT91_PMC_MAINRDY) {
+				value &= AT91_PMC_MAINF;
+				ret = parent_rate * value / 16;
+			}
+
+		}
+	}
+
+	return ret;
+}
+
+struct clk_ops at91_pmc_main_clk_ops = {
+	.enable = at91_pmc_main_clk_enable,
+	.disable = at91_pmc_main_clk_disable,
+	.is_enabled = at91_pmc_main_clk_is_enabled,
+	.recalc_rate = at91_pmc_main_clk_recalc_rate,
+};
+
+int __init at91_pmc_slow_clk_register (struct device_node *np) {
+	struct at91_pmc_slow_clk *clk;
+	int err;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return -ENOMEM;
+
+	err = of_property_read_u32(np, "clock-frequency", &clk->frequency);
+	if (err) {
+		clk->frequency = 0;
+	}
+
+	err = at91_pmc_clk_register (np, &at91_pmc_slow_clk_ops, &clk->base, CLK_IS_ROOT);
+	if (err)
+		kfree (clk);
+
+	return err;
+}
+
+int __init at91_pmc_main_clk_register (struct device_node *np) {
+	struct at91_pmc_main_clk *clk;
+	int err;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return -ENOMEM;
+
+	err = of_property_read_u32(np, "clock-frequency", &clk->frequency);
+	if (err) {
+		clk->frequency = 0;
+	}
+
+
+	err = at91_pmc_clk_register (np, &at91_pmc_main_clk_ops, &clk->base, CLK_IS_ROOT);
+	if (err)
+		kfree (clk);
+
+	return err;
+
+
+}
diff --git a/arch/arm/mach-at91/pmc-periph.c b/arch/arm/mach-at91/pmc-periph.c
new file mode 100644
index 0000000..d7004cb
--- /dev/null
+++ b/arch/arm/mach-at91/pmc-periph.c
@@ -0,0 +1,111 @@
+#include <linux/slab.h>
+
+#include "pmc.h"
+
+struct at91_pmc_periph_clk {
+	struct at91_pmc_clk base;
+	u32 index : 5;
+	u32 pcr : 1;
+};
+
+#define pmc_clk_to_pmc_periph_clk(pmcck) container_of(pmcck, struct at91_pmc_periph_clk, base)
+
+
+static int at91_pmc_periph_clk_enable(struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_periph_clk *periphclk = pmc_clk_to_pmc_periph_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+
+	if (periphclk->index < 2)
+		return 0;
+
+	at91_pmc_write(pmc, AT91_PMC_PCER, (1 << periphclk->index));
+
+	return 0;
+}
+
+static void at91_pmc_periph_clk_disable(struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_periph_clk *periphclk = pmc_clk_to_pmc_periph_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+
+	if (periphclk->index < 2)
+		return;
+
+	at91_pmc_write(pmc, AT91_PMC_PCDR, (1 << periphclk->index));
+
+}
+
+static int at91_pmc_periph_clk_is_enabled(struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_periph_clk *periphclk = pmc_clk_to_pmc_periph_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+
+	if (periphclk->index < 2)
+		return 1;
+
+	return !!(at91_pmc_read(pmc, AT91_PMC_PCSR) & (1 << periphclk->index));
+}
+
+static unsigned long at91_pmc_periph_clk_recalc_rate(struct clk_hw *hw, unsigned long irate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_periph_clk *periphclk = pmc_clk_to_pmc_periph_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	unsigned long value;
+
+
+	if (periphclk->pcr) {
+		at91_pmc_write(pmc, AT91_PMC_PCR, periphclk->index);
+		value = (at91_pmc_read(pmc, AT91_PMC_PCR) >> 16) & 0x3;
+
+		irate >>= value;
+	}
+
+	return irate;
+}
+
+struct clk_ops at91_pmc_periph_clk_ops = {
+	.enable = at91_pmc_periph_clk_enable,
+	.disable = at91_pmc_periph_clk_disable,
+	.is_enabled = at91_pmc_periph_clk_is_enabled,
+	.recalc_rate = at91_pmc_periph_clk_recalc_rate,
+};
+
+
+
+
+int __init at91_pmc_periph_clk_register (struct device_node *np) {
+	struct at91_pmc_periph_clk *clk;
+	int err;
+	u32 tmp = 0;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return -ENOMEM;
+
+	err = of_property_read_u32(np, "reg", &tmp);
+	if (err) {
+		kfree(clk);
+		return err;
+	}
+
+	if (tmp > 31) {
+		kfree(clk);
+		return -EINVAL;
+	}
+
+	clk->index = tmp;
+
+	err = of_property_read_u32(np, "pcr", &tmp);
+	if (err)
+		tmp = 0;
+
+	clk->pcr = tmp;
+
+	err = at91_pmc_clk_register (np, &at91_pmc_periph_clk_ops, &clk->base, 0);
+
+	if (err)
+		kfree(clk);
+
+	return err;
+}
diff --git a/arch/arm/mach-at91/pmc-pll.c b/arch/arm/mach-at91/pmc-pll.c
new file mode 100644
index 0000000..9164298
--- /dev/null
+++ b/arch/arm/mach-at91/pmc-pll.c
@@ -0,0 +1,371 @@
+#include <linux/slab.h>
+
+#include "pmc.h"
+
+
+struct at91_pmc_pll_clk {
+	struct at91_pmc_clk base;
+	u32 index : 1;
+	u32 range : 7;
+	u32 mul : 11;
+	u32 div : 11;
+	u32 mask;
+	struct at91_pmc_clk_range output[8];
+	struct at91_pmc_clk_range input;
+};
+
+#define pmc_clk_to_pmc_pll_clk(pmcck) container_of(pmcck, struct at91_pmc_pll_clk, base)
+
+struct at91_pmc_plldiv_clk {
+	struct at91_pmc_clk base;
+};
+
+#define pmc_clk_to_pmc_plldiv_clk(pmcck) container_of(pmcck, struct at91_pmc_plldiv_clk, base)
+
+
+static int at91_pmc_pll_clk_enable (struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_pll_clk *pllclk = pmc_clk_to_pmc_pll_clk (pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	int offset = AT91_CKGR_PLLAR + (pllclk->index * 4);
+	u32 range = pllclk->range;
+	u32 icpll;
+	u32 status = 1 << (1 + pllclk->index);
+	struct clk * parent = __clk_get_parent(hw->clk);
+	unsigned long freq = __clk_get_rate(parent);
+	unsigned long value;
+
+	freq = freq * (pllclk->mul + 1) / pllclk->div;
+
+	if (at91_pmc_supported(pmc, AT91_PMC_PLLICPR)) {
+		value = at91_pmc_read(pmc, AT91_PMC_PLLICPR);
+		icpll = (1 << (16 * pllclk->index));
+		if (range & 0x4) {
+			value |= icpll;
+		} else {
+			value &= ~icpll;
+		}
+
+		at91_pmc_write(pmc, AT91_PMC_PLLICPR, value);
+	}
+
+	value = at91_pmc_read(pmc, offset) & pllclk->mask;
+
+	value |= (unsigned long)(pllclk->mul ? pllclk->mul - 1 : 0) << 16 | (unsigned long)(range & 0x3) << 14 | AT91_PMC_PLLCOUNT | pllclk->div;
+	/* Enable PLL */
+	/* Wait 0x3f slow clocks (< 10ms) */
+	at91_pmc_write(pmc, offset, value);
+
+	/* Wait for osc stabilization */
+	while (!(at91_pmc_read(pmc, AT91_PMC_SR) & status));
+
+	return 0;
+
+}
+
+static void at91_pmc_pll_clk_disable (struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_pll_clk *pllclk = pmc_clk_to_pmc_pll_clk (pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	int offset = AT91_CKGR_PLLAR + (pllclk->index * 4);
+	unsigned long value;
+
+	value = at91_pmc_read(pmc, offset);
+
+	value &= pllclk->mask;
+
+	/* Disable PLL */
+	at91_pmc_write(pmc, offset, value);
+
+}
+
+static long at91_pmc_pll_clk_best_div_mul (struct at91_pmc_pll_clk *pllclk, unsigned long orate, u32 *div, u32 *mul, u32 *index) {
+	struct clk *parent = __clk_get_parent(pllclk->base.base.clk);
+	unsigned long irate = __clk_get_rate(parent);
+	unsigned long maxrate;
+	unsigned long minrate;
+	unsigned long divrate;
+	unsigned long bestdiv = 1;
+	unsigned long bestmul;
+	unsigned long tmpdiv;
+	unsigned long roundup;
+	unsigned long rounddown;
+	unsigned long remainder;
+	unsigned long bestremainder;
+	unsigned long maxmul;
+	unsigned long maxdiv;
+	int i = 0;
+
+	/* Minimum divider = 1 */
+	/* Maximum multiplier = max_mul */
+	maxmul = (~pllclk->mask & AT91_PMC_MUL) >> 16;
+	maxrate = (irate * maxmul) / 1;
+
+	/* Maximum divider = max_div */
+	/* Minimum multiplier = 2 */
+	maxdiv = (~pllclk->mask & AT91_PMC_DIV);
+	minrate = (irate * 2) / maxdiv;
+
+	if (irate < pllclk->input.min || irate < pllclk->input.max)
+		return -ERANGE;
+
+	if (orate < minrate || orate > maxrate)
+		return -ERANGE;
+
+	for (i = 0; i < 8; ++i) {
+		if (orate >= pllclk->output[i].min && orate <= pllclk->output[i].max)
+			break;
+		++i;
+	}
+
+	if (i >= 8)
+		return -ERANGE;
+
+	bestmul = orate / irate;
+	rounddown = orate % irate;
+	roundup = irate - rounddown;
+	bestremainder = roundup < rounddown ? roundup : rounddown;
+
+	if (!bestremainder) {
+		if (div)
+			*div = bestdiv;
+		if (mul)
+			*mul = bestmul;
+		if (index)
+			*index = i;
+		return orate;
+	}
+
+	maxdiv = 255 / (bestmul + 1);
+
+	for (tmpdiv = 2; tmpdiv < maxdiv; ++tmpdiv) {
+		divrate = irate / i;
+
+		rounddown = orate % divrate;
+		roundup = divrate - rounddown;
+		remainder = roundup < rounddown ? roundup : rounddown;
+
+		if (remainder < bestremainder) {
+			bestremainder = remainder;
+			bestmul = orate / divrate;
+			bestdiv = tmpdiv;
+		}
+
+		if (!remainder)
+			break;
+	}
+
+	pllclk->mul = bestmul;
+	pllclk->div = bestdiv;
+
+	orate = (irate / bestdiv) * bestmul;
+
+	if (div)
+		*div = bestdiv;
+	if (mul)
+		*mul = bestmul;
+	if (index)
+		*index = i;
+
+	return orate;
+}
+
+static long at91_pmc_pll_clk_round_rate(struct clk_hw *hw, unsigned long orate, unsigned long *prate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_pll_clk *pllclk = pmc_clk_to_pmc_pll_clk (pmcclk);
+
+	return at91_pmc_pll_clk_best_div_mul (pllclk, orate, NULL, NULL, NULL);
+
+}
+
+static int at91_pmc_pll_clk_set_rate(struct clk_hw *hw, unsigned long orate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_pll_clk *pllclk = pmc_clk_to_pmc_pll_clk (pmcclk);
+	u32 div;
+	u32 mul;
+	u32 range;
+
+	long rate = at91_pmc_pll_clk_best_div_mul (pllclk, orate, &div, &mul, &range);
+
+	if (rate < 0)
+		return rate;
+
+	if (rate != orate)
+		return -EINVAL;
+
+	pllclk->range = range;
+	pllclk->mul = mul;
+	pllclk->div = div;
+
+	return 0;
+}
+
+static unsigned long at91_pmc_pll_clk_recalc_rate(struct clk_hw *hw, unsigned long irate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_pll_clk *pllclk = pmc_clk_to_pmc_pll_clk (pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	int offset = AT91_CKGR_PLLAR + (pllclk->index * 4);
+	unsigned long orate;
+	unsigned long value;
+
+	value = at91_pmc_read(pmc, offset);
+
+	pllclk->div = (value & ~pllclk->mask) & AT91_PMC_DIV;
+	pllclk->mul = ((value & ~pllclk->mask) & AT91_PMC_MUL) >> 16;
+	if (pllclk->mul)
+		pllclk->mul++;
+	pllclk->range = (value & AT91_PMC_OUT) >> 14;
+	if (at91_pmc_supported(pmc, AT91_PMC_PLLICPR)) {
+		if (at91_pmc_read(pmc, AT91_PMC_PLLICPR) & (1 << (16 * pllclk->index)))
+			pllclk->range |= 0x4;
+	}
+
+	if (pllclk->div == 0)
+		return 0;
+
+	orate = (irate / pllclk->div) * pllclk->mul;
+
+	return orate;
+}
+
+static int at91_pmc_pll_clk_is_enabled(struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_pll_clk *pllclk = pmc_clk_to_pmc_pll_clk (pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	int offset = AT91_CKGR_PLLAR + (pllclk->index * 4);
+	unsigned long value;
+
+	value = at91_pmc_read(pmc, offset);
+
+	return !!(value & AT91_PMC_MUL);
+}
+
+
+
+struct clk_ops at91_pmc_pll_clk_ops = {
+	.enable = at91_pmc_pll_clk_enable,
+	.disable = at91_pmc_pll_clk_disable,
+	.is_enabled = at91_pmc_pll_clk_is_enabled,
+	.recalc_rate = at91_pmc_pll_clk_recalc_rate,
+	.round_rate = at91_pmc_pll_clk_round_rate,
+	.set_rate = at91_pmc_pll_clk_set_rate,
+};
+
+
+static long at91_pmc_plldiv_clk_round_rate(struct clk_hw *hw, unsigned long orate, unsigned long *prate) {
+	struct clk *parent = __clk_get_parent(hw->clk);
+	unsigned long irate = __clk_get_rate(parent);
+	unsigned long rate;
+
+	if (orate >= irate)
+		return irate;
+
+	rate = irate >> 1;
+
+	if (rate >= orate)
+		return rate;
+
+	return orate - rate > irate - orate ? irate : rate;
+
+}
+
+static int at91_pmc_plldiv_clk_set_rate(struct clk_hw *hw, unsigned long orate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	struct clk *parent = __clk_get_parent(hw->clk);
+	unsigned long irate = __clk_get_rate(parent);
+	unsigned long value = at91_pmc_read(pmc, AT91_PMC_MCKR);
+
+	if (orate == irate)
+		value &= AT91_PMC_PLLADIV2;
+	else if (irate >> 1 == orate)
+		value |= AT91_PMC_PLLADIV2;
+	else
+		return -EINVAL;
+
+	at91_pmc_write(pmc, AT91_PMC_MCKR, value);
+
+	return 0;
+}
+
+static unsigned long at91_pmc_plldiv_clk_recalc_rate(struct clk_hw *hw, unsigned long irate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	unsigned long value = at91_pmc_read(pmc, AT91_PMC_MCKR);
+	unsigned long orate = irate;
+
+	if (value & AT91_PMC_PLLADIV2)
+		orate >>= 1;
+
+	return orate;
+}
+
+
+struct clk_ops at91_pmc_plldivdiv_clk_ops = {
+	.recalc_rate = at91_pmc_plldiv_clk_recalc_rate,
+	.round_rate = at91_pmc_plldiv_clk_round_rate,
+	.set_rate = at91_pmc_plldiv_clk_set_rate,
+};
+
+
+int __init at91_pmc_pll_clk_register (struct device_node *np) {
+	struct at91_pmc_pll_clk *clk;
+	struct device_node *carac;
+	int err;
+	u32 tmp;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return -ENOMEM;
+
+	err = of_property_read_u32(np, "reg", &tmp);
+	if (err) {
+		kfree(clk);
+		return err;
+	}
+
+	if (tmp > 1) {
+		kfree(clk);
+		return -EINVAL;
+	}
+
+	clk->index = tmp;
+
+	err = of_property_read_u32(np, "mask", &tmp);
+	if (err) {
+		kfree(clk);
+		return err;
+	}
+
+	clk->mask = tmp;
+
+	carac = of_find_node_by_name(np, "characteristics");
+	if (!carac) {
+		of_node_put (carac);
+		kfree(clk);
+		return -EINVAL;
+	}
+
+	err = of_property_read_u32_array(carac, "input", &clk->input.min, 2);
+	if (err) {
+		of_node_put (carac);
+		kfree(clk);
+		return err;
+	}
+
+	err = of_property_read_u32_array(carac, "output", &clk->output[0].min, 16);
+	if (err) {
+		of_node_put (carac);
+		kfree(clk);
+		return err;
+	}
+
+	of_node_put (carac);
+
+	err = at91_pmc_clk_register (np, &at91_pmc_pll_clk_ops, &clk->base, CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE);
+
+	if (err)
+		kfree(clk);
+
+	return err;
+}
diff --git a/arch/arm/mach-at91/pmc-prog.c b/arch/arm/mach-at91/pmc-prog.c
new file mode 100644
index 0000000..903a898
--- /dev/null
+++ b/arch/arm/mach-at91/pmc-prog.c
@@ -0,0 +1,194 @@
+#include <linux/slab.h>
+
+#include "pmc.h"
+
+struct at91_pmc_prog_clk {
+	struct at91_pmc_sys_clk base;
+	u32 csslength : 2;
+	u32 cssmck : 1;
+	u32 presoffset : 5;
+};
+
+#define pmc_sys_clk_to_pmc_prog_clk(sysck) container_of(sysck, struct at91_pmc_prog_clk, base)
+
+static unsigned long at91_pmc_prog_clk_recalc_rate(struct clk_hw *hw, unsigned long irate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_sys_clk *sysclk = pmc_clk_to_pmc_sys_clk(pmcclk);
+	struct at91_pmc_prog_clk *progclk = pmc_sys_clk_to_pmc_prog_clk(sysclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	unsigned long value = at91_pmc_read(pmc, AT91_PMC_PCKR(sysclk->index - 8)) >> progclk->presoffset;
+	value &= 0x7;
+
+	if (value == 0x7)
+		return irate;
+
+	return irate >> value;
+
+}
+
+static long at91_pmc_prog_clk_round_rate (struct clk_hw *hw, unsigned long orate, unsigned long *prate) {
+	struct clk *parent = __clk_get_parent(hw->clk);
+	unsigned long irate = __clk_get_rate(parent);
+	unsigned long rate, prev;
+	int i;
+
+	if (orate > irate) {
+		return irate;
+	}
+
+	prev = irate;
+
+	for (i = 0; i < 7; ++i) {
+		rate = irate >> i;
+		if (rate < orate) {
+			return prev - orate > orate - rate ? rate : prev;
+		}
+		prev = rate;
+	}
+
+	return rate;
+
+}
+
+
+static int at91_pmc_prog_clk_set_parent(struct clk_hw *hw, u8 index) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_sys_clk *sysclk = pmc_clk_to_pmc_sys_clk(pmcclk);
+	struct at91_pmc_prog_clk *progclk = pmc_sys_clk_to_pmc_prog_clk(sysclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	unsigned long value;
+
+	if (index > ((1 << progclk->csslength) - 1))
+		return -EINVAL;
+
+	value = at91_pmc_read(pmc, AT91_PMC_PCKR(sysclk->index - 8)) & ~0x3;
+	value |= (index & 0x3);
+
+	if (progclk->cssmck) {
+		if (index & 0x4)
+			value |= AT91_PMC_CSSMCK;
+		else
+			value &= ~AT91_PMC_CSSMCK;
+	}
+
+	at91_pmc_write(pmc, AT91_PMC_PCKR(sysclk->index - 8), value);
+
+	return 0;
+}
+
+static u8 at91_pmc_prog_clk_get_parent(struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_sys_clk *sysclk = pmc_clk_to_pmc_sys_clk(pmcclk);
+	struct at91_pmc_prog_clk *progclk = pmc_sys_clk_to_pmc_prog_clk(sysclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	unsigned long value;
+	u8 index;
+
+	value = at91_pmc_read(pmc, AT91_PMC_PCKR(sysclk->index - 8));
+
+	index = value & 0x3;
+
+	if (progclk->cssmck && value & AT91_PMC_CSSMCK)
+		index |= 0x4;
+
+	return index;
+}
+
+static int at91_pmc_prog_clk_set_rate(struct clk_hw *hw, unsigned long orate) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_sys_clk *sysclk = pmc_clk_to_pmc_sys_clk(pmcclk);
+	struct at91_pmc_prog_clk *progclk = pmc_sys_clk_to_pmc_prog_clk(sysclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+	struct clk *parent = __clk_get_parent(hw->clk);
+	unsigned long irate = __clk_get_rate(parent);
+	unsigned long rate;
+	int i;
+	unsigned long value;
+
+	for (i = 0; i < 7; ++i) {
+		rate = irate >> i;
+		if (rate == orate) {
+			value = at91_pmc_read(pmc, AT91_PMC_PCKR(sysclk->index - 8)) & ~(0x7 << progclk->presoffset);
+			value |= (i << progclk->presoffset);
+			at91_pmc_write(pmc, AT91_PMC_PCKR(sysclk->index - 8), value);
+			return 0;
+		}
+
+		if (rate < orate)
+			break;
+	}
+
+	return -EINVAL;
+}
+
+static int at91_pmc_prog_clk_enable(struct clk_hw *hw) {
+	int err;
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_sys_clk *sysclk = pmc_clk_to_pmc_sys_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+
+	err = at91_pmc_sys_clk_enable(hw);
+	if (err)
+		return err;
+
+	while (at91_pmc_read(pmc, AT91_PMC_SR) & (1 << sysclk->index));
+
+	return 0;
+}
+
+
+struct clk_ops at91_pmc_prog_clk_ops = {
+	.enable = at91_pmc_prog_clk_enable,
+	.disable = at91_pmc_sys_clk_disable,
+	.is_enabled = at91_pmc_sys_clk_is_enabled,
+	.recalc_rate = at91_pmc_prog_clk_recalc_rate,
+	.round_rate = at91_pmc_prog_clk_round_rate,
+	.set_rate = at91_pmc_prog_clk_set_rate,
+	.set_parent = at91_pmc_prog_clk_set_parent,
+	.get_parent = at91_pmc_prog_clk_get_parent,
+};
+
+
+int __init at91_pmc_prog_clk_register (struct device_node *np) {
+	struct at91_pmc_prog_clk *clk;
+	int err;
+	u32 tmp = 0;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return -ENOMEM;
+
+	err = at91_pmc_sys_clk_init (np, &clk->base);
+	if (err) {
+		kfree(clk);
+		return err;
+	}
+
+	err = of_property_read_u32(np, "css-length", &tmp);
+	if (err) {
+		kfree(clk);
+		return err;
+	}
+
+	err = of_property_read_u32(np, "cssmck", &tmp);
+	if (err)
+		tmp = 0;
+
+	clk->cssmck = tmp;
+
+	err = of_property_read_u32(np, "pres-offset", &tmp);
+	if (err) {
+		kfree(clk);
+		return err;
+	}
+
+	clk->presoffset = tmp;
+
+	err = at91_pmc_clk_register (np, &at91_pmc_prog_clk_ops, &clk->base.base, 0);
+
+	if (err)
+		kfree(clk);
+
+	return err;
+}
+
diff --git a/arch/arm/mach-at91/pmc-sys.c b/arch/arm/mach-at91/pmc-sys.c
new file mode 100644
index 0000000..a17e214
--- /dev/null
+++ b/arch/arm/mach-at91/pmc-sys.c
@@ -0,0 +1,81 @@
+#include <linux/slab.h>
+
+#include "pmc.h"
+
+
+int at91_pmc_sys_clk_enable(struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_sys_clk *sysclk = pmc_clk_to_pmc_sys_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+
+	at91_pmc_write(pmc, AT91_PMC_SCER, (1 << sysclk->index));
+
+	return 0;
+}
+
+void at91_pmc_sys_clk_disable(struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_sys_clk *sysclk = pmc_clk_to_pmc_sys_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+
+	at91_pmc_write(pmc, AT91_PMC_SCDR, (1 << sysclk->index));
+
+}
+
+int at91_pmc_sys_clk_is_enabled(struct clk_hw *hw) {
+	struct at91_pmc_clk *pmcclk = hw_clk_to_pmc_clk(hw);
+	struct at91_pmc_sys_clk *sysclk = pmc_clk_to_pmc_sys_clk(pmcclk);
+	struct at91_pmc *pmc = pmcclk->pmc;
+
+	return !!(at91_pmc_read(pmc, AT91_PMC_SCSR) & (1 << sysclk->index));
+}
+
+static struct clk_ops at91_pmc_sys_clk_ops = {
+	.enable = at91_pmc_sys_clk_enable,
+	.disable = at91_pmc_sys_clk_disable,
+	.is_enabled = at91_pmc_sys_clk_is_enabled,
+};
+
+int at91_pmc_sys_clk_init (struct device_node *np, struct at91_pmc_sys_clk *clk) {
+	int err;
+	u32 tmp = 0;
+
+	err = of_property_read_u32(np, "reg", &tmp);
+	if (err) {
+		kfree(clk);
+		return err;
+	}
+
+	if (tmp > 31) {
+		kfree(clk);
+		return -EINVAL;
+	}
+
+	clk->index = tmp;
+
+	return 0;
+}
+
+
+int __init at91_pmc_sys_clk_register (struct device_node *np) {
+	struct at91_pmc_sys_clk *clk;
+	int err;
+
+	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return -ENOMEM;
+
+	err = at91_pmc_sys_clk_init (np, clk);
+
+	if (err) {
+		kfree(clk);
+		return err;
+	}
+
+	err = at91_pmc_clk_register (np, &at91_pmc_sys_clk_ops, &clk->base, 0);
+
+	if (err)
+		kfree(clk);
+
+	return 0;
+}
diff --git a/arch/arm/mach-at91/pmc.c b/arch/arm/mach-at91/pmc.c
new file mode 100644
index 0000000..9de92ce
--- /dev/null
+++ b/arch/arm/mach-at91/pmc.c
@@ -0,0 +1,260 @@
+#include <linux/clk-private.h>
+#include <asm/io.h>
+#include <mach/at91_pmc.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/bootmem.h>
+#include <linux/list.h>
+#include <linux/printk.h>
+#include <asm/setup.h>
+#include <asm/proc-fns.h>
+#include <linux/clkdev.h>
+
+#include "pmc.h"
+
+void __iomem *at91_pmc_base;
+
+struct at91_pmc_usb_clk_config {
+	char div;
+};
+
+struct at91_pmc_udp_clk_config {
+	u8 offset;
+};
+
+struct at91_pmc_uhp_clk_config {
+	u8 offset;
+};
+
+struct at91_pmc {
+	void __iomem *regs;
+	u32 capabilities[4];
+};
+
+int at91_pmc_supported (struct at91_pmc *pmc, unsigned long offset) {
+	int index = offset / 128;
+	int mask = (1 << ((offset % 128) / 4));
+
+	if (index >= 4)
+		return 0;
+	if (!(pmc->capabilities[index] & mask))
+		return 0;
+
+	return 1;
+}
+
+#undef at91_pmc_read
+#undef at91_pmc_write
+
+unsigned long at91_pmc_read (struct at91_pmc *pmc, unsigned long offset) {
+	return __raw_readl(pmc->regs + offset);
+}
+
+void at91_pmc_write (struct at91_pmc *pmc, unsigned long offset, unsigned long value) {
+	__raw_writel(value, pmc->regs + offset);
+
+}
+
+static struct at91_pmc pmc;
+
+
+static struct of_device_id clk_lookup_ids[] = {
+	{.compatible = "clk-lookup",},
+	{},
+};
+
+
+int at91_pmc_clk_register (struct device_node *np, const struct clk_ops *ops, struct at91_pmc_clk *pmcclk, unsigned long flags) {
+
+	int err;
+	int i;
+	const char *tmp;
+	char *name;
+	const struct of_device_id *match;
+	struct device_node *child;
+	struct clk_lookup *lookup;
+	int num_parents = 0;
+	char **parent_names = NULL;
+	struct clk *clk = NULL;
+
+	if (!np || !pmcclk)
+		return -EINVAL;
+
+	err = of_property_read_string(np, "clock-output-names", &tmp);
+	if (err)
+		return err;
+
+	name = kstrdup(tmp, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+
+	for (num_parents = 0; of_clk_get_parent_name(np, num_parents); ++num_parents);
+
+	if (num_parents) {
+		parent_names = kzalloc (sizeof(*parent_names) * num_parents, GFP_KERNEL);
+		if (!parent_names) {
+			kfree(name);
+			return -ENOMEM;
+		}
+
+		for (i = 0; i < num_parents; ++i) {
+			tmp = of_clk_get_parent_name(np, i);
+			parent_names[i] = kstrdup(tmp, GFP_KERNEL);
+			if (!parent_names[i]) {
+				for (i--; i >= 0; i--) {
+					kfree(parent_names[i]);
+				}
+				kfree(parent_names);
+				kfree(name);
+				return -ENOMEM;
+			}
+		}
+
+	}
+
+	pmcclk->pmc = &pmc;
+	clk = clk_register(NULL, name, ops, &pmcclk->base, parent_names, num_parents, flags);
+
+	if (!clk) {
+		for (i = 0; i < num_parents; ++i) {
+			kfree(parent_names[i]);
+		}
+		kfree(parent_names);
+		kfree(name);
+		return -ENOMEM;
+	}
+
+
+	/*
+	 * FIXUP to reuse existing drivers :
+	 * Each clk must be exposed via clk_lookup.
+	 * Extract clk_lookup info from "clk-lookup" compatible nodes.
+	 */
+	for_each_child_of_node(np, child) {
+		match = of_match_node(clk_lookup_ids, child);
+		if (!match)
+			continue;
+
+		lookup = kzalloc (sizeof(*lookup), GFP_KERNEL);
+		if (!lookup)
+			break;
+
+
+		tmp = NULL;
+		if (!of_property_read_string(child, "conid", &tmp) && tmp) {
+			lookup->con_id = kstrdup(tmp, GFP_KERNEL);
+			if (!lookup->con_id) {
+				kfree (lookup);
+				break;
+			}
+		}
+
+		tmp = NULL;
+		if (!of_property_read_string(np, "devid", &tmp) && tmp) {
+			lookup->dev_id = kstrdup(tmp, GFP_KERNEL);
+			if (!lookup->dev_id) {
+				if (lookup->con_id)
+					kfree(lookup->con_id);
+				kfree (lookup);
+				break;
+			}
+		}
+
+
+
+		if (lookup->con_id || lookup->dev_id) {
+			lookup->clk = clk;
+			clkdev_add(lookup);
+		}
+		else
+			kfree(lookup);
+	}
+
+	/*
+	 * FIXUP to reuse existing drivers :
+	 * Prepare every registered clks to be able to enable it with clk_enable.
+	 * This should be removed (rework each driver to be compatible with common
+	 * clk framework : clk_prepare_enable).
+	 */
+	clk_prepare(clk);
+
+	return 0;
+
+}
+
+
+
+static const struct of_device_id at91_pmc_clk_ids[] __initconst = {
+	{
+		.compatible = "atmel,at91-pmc-slow",
+		.data = at91_pmc_slow_clk_register,
+	}, {
+		.compatible = "atmel,at91-pmc-main",
+		.data = at91_pmc_main_clk_register,
+	}, {
+		.compatible = "atmel,at91-pmc-pll",
+		.data = at91_pmc_pll_clk_register,
+	}, {
+		.compatible = "atmel,at91-pmc-pres",
+		.data = at91_pmc_pres_clk_register,
+	}, {
+		.compatible = "atmel,at91-pmc-master",
+		.data = at91_pmc_master_clk_register,
+	}, {
+		.compatible = "atmel,at91-pmc-proc",
+		.data = at91_pmc_proc_clk_register,
+	}, {
+		.compatible = "atmel,at91-pmc-prog",
+		.data = at91_pmc_prog_clk_register,
+	}, {
+		.compatible = "atmel,at91-pmc-periph",
+		.data = at91_pmc_periph_clk_register,
+	}, {
+		/* sentinel */
+	}
+};
+
+static const struct of_device_id at91_pmc_dt_ids[] __initconst = {
+	{
+		.compatible = "atmel,at91-pmc",
+	}, {
+		/* sentinel */
+	}
+};
+
+
+
+void at91sam9_idle(void)
+{
+	at91_pmc_write(&pmc, AT91_PMC_SCDR, AT91_PMC_PCK);
+	cpu_do_idle();
+}
+
+void __init at91_pmc_of_init(struct device_node *np)
+{
+	const struct of_device_id *match;
+	struct device_node *child;
+	int (*func) (struct device_node *np);
+
+	pmc.regs = of_iomap(np, 0);
+	if (!pmc.regs)
+		panic("unable to map pmc cpu registers\n");
+
+	at91_pmc_base = pmc.regs;
+
+	/* retrieve the capabilities */
+	of_property_read_u32_array(np, "capabilities", pmc.capabilities, sizeof (pmc.capabilities));
+
+	for_each_child_of_node(np, child) {
+		match = of_match_node(at91_pmc_clk_ids, child);
+		if (match) {
+			func = match->data;
+			func (child);
+		}
+	}
+
+}
+
+//arch_initcall(at91_dt_clock_init);
diff --git a/arch/arm/mach-at91/pmc.h b/arch/arm/mach-at91/pmc.h
new file mode 100644
index 0000000..4c0c3f9
--- /dev/null
+++ b/arch/arm/mach-at91/pmc.h
@@ -0,0 +1,70 @@
+#ifndef AT91_PMC_CLK_H
+#define AT91_PMC_CLK_H
+
+#include <linux/clk-provider.h>
+#include <mach/at91_pmc.h>
+#include <linux/of.h>
+
+struct at91_pmc;
+
+struct at91_pmc_clk {
+	struct clk_hw base;
+	struct at91_pmc *pmc;
+};
+
+struct at91_pmc_clk_range {
+	u32 min;
+	u32 max;
+};
+
+#define hw_clk_to_pmc_clk(hw) container_of(hw, struct at91_pmc_clk, base)
+
+int at91_pmc_supported (struct at91_pmc *pmc, unsigned long offset);
+
+#undef at91_pmc_read
+#undef at91_pmc_write
+
+extern unsigned long at91_pmc_read (struct at91_pmc *pmc, unsigned long offset);
+
+extern void at91_pmc_write (struct at91_pmc *pmc, unsigned long offset, unsigned long value);
+
+extern int at91_pmc_clk_register (struct device_node *np, const struct clk_ops *ops, struct at91_pmc_clk *pmcclk, unsigned long flags);
+
+
+struct at91_pmc_sys_clk {
+	struct at91_pmc_clk base;
+	u32 index : 5;
+};
+
+#define pmc_clk_to_pmc_sys_clk(pmcck) container_of(pmcck, struct at91_pmc_sys_clk, base)
+
+extern int at91_pmc_sys_clk_enable(struct clk_hw *hw);
+
+extern void at91_pmc_sys_clk_disable(struct clk_hw *hw);
+
+extern int at91_pmc_sys_clk_is_enabled(struct clk_hw *hw);
+
+extern int __init at91_pmc_sys_clk_register (struct device_node *np);
+
+extern int at91_pmc_sys_clk_init (struct device_node *np, struct at91_pmc_sys_clk *sysclk);
+
+
+
+
+extern int __init at91_pmc_slow_clk_register (struct device_node *np);
+
+extern int __init at91_pmc_main_clk_register (struct device_node *np);
+
+extern int __init at91_pmc_pll_clk_register (struct device_node *np);
+
+extern int __init at91_pmc_pres_clk_register (struct device_node *np);
+
+extern int __init at91_pmc_master_clk_register (struct device_node *np);
+
+extern int __init at91_pmc_proc_clk_register (struct device_node *np);
+
+extern int __init at91_pmc_prog_clk_register (struct device_node *np);
+
+extern int __init at91_pmc_periph_clk_register (struct device_node *np);
+
+#endif /* AT91_PMC_CLK_H */
-- 
1.7.9.5
