From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jun 2012 17:39:56 +0200
Subject: [PATCH 2/3] clk: add ICST307 driver
Message-ID: <1339429196-32584-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ICST307 VCO clock has a shared driver in the ARM
architecture. This patch provides a wrapper into the common
clock framework so we can use the implementation in the
ARM architecture without duplicating the code until all
ARM platforms using this VCO are moved over. At that point
we can merge the driver from the ARM platform into the
generic file altogether.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Mike Turquette <mturquette@ti.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/Kconfig    |    5 ++
 drivers/clk/Makefile   |    1 +
 drivers/clk/clk-icst.c |   99 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-icst.h |   10 +++++
 4 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/clk-icst.c
 create mode 100644 drivers/clk/clk-icst.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4864407..32e745e 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -34,4 +34,9 @@ config COMMON_CLK_DEBUG
 	  clk_flags, clk_prepare_count, clk_enable_count &
 	  clk_notifier_count.
 
+config CLK_ICST
+	bool "ICST307 VCO clock driver"
+	depends on COMMON_CLK
+	depends on ICST
+
 endmenu
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index b9a5158..a7a7cf8 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-fixed-rate.o clk-gate.o \
 # SoCs specific
 obj-$(CONFIG_ARCH_MXS)		+= mxs/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
+obj-$(CONFIG_CLK_ICST)		+= clk-icst.o
diff --git a/drivers/clk/clk-icst.c b/drivers/clk/clk-icst.c
new file mode 100644
index 0000000..ba003de
--- /dev/null
+++ b/drivers/clk/clk-icst.c
@@ -0,0 +1,99 @@
+/*
+ * Driver for the ICST307 VCO clock found in the ARM Reference designs.
+ * We wrap the custom interface from <asm/hardware/icst.h> into the generic
+ * clock framework.
+ *
+ * TODO: when all ARM reference designs are migrated to generic clocks, the
+ * ICST clock code from the ARM tree should probably be merged into this
+ * file.
+ */
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/err.h>
+#include <linux/clk-provider.h>
+
+#include "clk-icst.h"
+
+/**
+ * struct clk_icst - ICST VCO clock wrapper
+ * @hw: corresponding clock hardware entry
+ * @params: parameters for this ICST instance
+ * @rate: current rate
+ * @setvco: function to commit ICST settings to hardware
+ */
+struct clk_icst {
+	struct clk_hw hw;
+	const struct icst_params *params;
+	unsigned long rate;
+	struct icst_vco (*getvco)(void);
+	void (*setvco)(struct icst_vco);
+};
+
+#define to_icst(_hw) container_of(_hw, struct clk_icst, hw)
+
+static unsigned long icst_recalc_rate(struct clk_hw *hw,
+				      unsigned long parent_rate)
+{
+	struct clk_icst *icst = to_icst(hw);
+	struct icst_vco vco;
+
+	vco = icst->getvco();
+	icst->rate = icst_hz(icst->params, vco);
+	return icst->rate;
+}
+
+static long icst_round_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long *prate)
+{
+	struct clk_icst *icst = to_icst(hw);
+	struct icst_vco vco;
+
+	vco = icst_hz_to_vco(icst->params, rate);
+	return icst_hz(icst->params, vco);
+}
+
+static int icst_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long parent_rate)
+{
+	struct clk_icst *icst = to_icst(hw);
+	struct icst_vco vco;
+
+	vco = icst_hz_to_vco(icst->params, rate);
+	icst->rate = icst_hz(icst->params, vco);
+	icst->setvco(vco);
+	return 0;
+}
+
+static const struct clk_ops icst_ops = {
+	.recalc_rate = icst_recalc_rate,
+	.round_rate = icst_round_rate,
+	.set_rate = icst_set_rate,
+};
+
+struct clk * __init icst_clk_init(struct device *dev, const struct clk_icst_desc *desc)
+{
+	struct clk *clk;
+	struct clk_icst *icst;
+	struct clk_init_data init;
+
+	icst = kzalloc(sizeof(struct clk_icst), GFP_KERNEL);
+	if (!icst) {
+		pr_err("could not allocate ICST clock!\n");
+		return ERR_PTR(-ENOMEM);
+	}
+	init.name = "icst";
+	init.ops = &icst_ops;
+	init.flags = CLK_IS_ROOT;
+	init.parent_names = NULL;
+	init.num_parents = 0;
+	icst->hw.init = &init;
+	icst->params = desc->params;
+	icst->getvco = desc->getvco;
+	icst->setvco = desc->setvco;
+
+	clk = clk_register(dev, &icst->hw);
+	if (IS_ERR(clk))
+		kfree(icst);
+
+	return clk;
+}
diff --git a/drivers/clk/clk-icst.h b/drivers/clk/clk-icst.h
new file mode 100644
index 0000000..1deaa86
--- /dev/null
+++ b/drivers/clk/clk-icst.h
@@ -0,0 +1,10 @@
+#include <asm/hardware/icst.h>
+
+struct clk_icst_desc {
+	const struct icst_params *params;
+	struct icst_vco (*getvco)(void);
+	void (*setvco)(struct icst_vco);
+};
+
+struct clk *icst_clk_init(struct device *dev,
+			  const struct clk_icst_desc *desc);
-- 
1.7.7.6
