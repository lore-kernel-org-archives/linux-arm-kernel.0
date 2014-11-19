From: carlo@caione.org (Carlo Caione)
Date: Wed, 19 Nov 2014 11:32:21 +0100
Subject: [PATCH 2/4] ARM: meson: add reset controller
In-Reply-To: <1416393143-20434-1-git-send-email-carlo@caione.org>
References: <1416393143-20434-1-git-send-email-carlo@caione.org>
Message-ID: <1416393143-20434-3-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modules and submodules within Meson6 and Meson8 SoCs can be disabled by
shutting off the clock. The control for these clocks comes from several
registers that are mapped contiguously except a special register that
controls peripherals in the AO (Always-On) power domain. The reset
controller manages both the cases according to the reset ID.

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 drivers/clk/meson/Makefile      |   1 +
 drivers/clk/meson/clkc.h        |  15 ++++
 drivers/clk/meson/meson6-clkc.c |  18 +++++
 drivers/clk/meson/rstc.c        | 152 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 186 insertions(+)
 create mode 100644 drivers/clk/meson/rstc.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 8f102e4..a962d57 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -5,3 +5,4 @@
 obj-y += clkc.o
 obj-y += meson6-clkc.o
 obj-y += clk-pll.o
+obj-$(CONFIG_RESET_CONTROLLER)  += rstc.o
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 6c0f611..41e92df 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -157,3 +157,18 @@ void meson_clk_register_pll_div(struct pll_div_conf *pll_div_conf,
 void meson_clk_register_clks(struct clk_conf *clk_confs,
 			     unsigned int nr_confs,
 			     void __iomem *clk_base);
+
+#ifdef CONFIG_RESET_CONTROLLER
+void meson_register_rstc(struct device_node *np, unsigned int num_regs,
+			 void __iomem *ao_base, void __iomem *ot_base,
+			 unsigned int ao_off_id, u8 flags);
+#else
+static inline void meson_register_rstc(struct device_node *np,
+				       unsigned int num_regs,
+				       void __iomem *ao_base,
+				       void __iomem *ot_base,
+				       unsigned int ao_off_id, u8 flags)
+{
+}
+#endif
+#endif /* __CLKC_H */
diff --git a/drivers/clk/meson/meson6-clkc.c b/drivers/clk/meson/meson6-clkc.c
index 9f809e1..177c6fa 100644
--- a/drivers/clk/meson/meson6-clkc.c
+++ b/drivers/clk/meson/meson6-clkc.c
@@ -30,9 +30,16 @@
 #define MESON6_REG_DPLL_VID2	0x011c
 #define MESON6_REG_HPLL		0x0270
 #define MESON6_REG_HHI_MPEG	0x0174
+#define MESON6_REG_RSTC		0x0140
 
 #define MESON6_XTAL		"xtal"
 
+/*
+ * Every reset ID >= 163 is mapped to the AO domain register
+ */
+#define MESON6_RSTC_N_REGS	6
+#define MESON6_AO_OFF		((MESON6_RSTC_N_REGS - 1) * BITS_PER_LONG + 3)
+
 static struct pll_conf dpll_conf = PLL_CONF2(750, 1512, PARM(0x00, 0, 9),
 							PARM(0x00, 9, 5));
 
@@ -129,6 +136,7 @@ static struct clk_conf meson_clk_confs[] __initdata = {
 static void __init meson_clkc_init(struct device_node *np)
 {
 	void __iomem *clk_base;
+	void __iomem *ao_base;
 	u32 xtal_rate;
 
 	/* XTAL */
@@ -156,5 +164,15 @@ static void __init meson_clkc_init(struct device_node *np)
 				clk_base);
 	meson_clk_register_pll_divs(meson_pll_divs, ARRAY_SIZE(meson_pll_divs),
 				    clk_base);
+
+	/* Reset controller */
+	ao_base = of_iomap(np, 2);
+	if (!ao_base) {
+		pr_warn("%s: Unable to map ao domain base for reset controller\n", __func__);
+		return;
+	}
+
+	meson_register_rstc(np, MESON6_RSTC_N_REGS, ao_base,
+			    clk_base + MESON6_REG_RSTC, MESON6_AO_OFF, 0);
 }
 CLK_OF_DECLARE(meson6_clock, "amlogic,meson6-clkc", meson_clkc_init);
diff --git a/drivers/clk/meson/rstc.c b/drivers/clk/meson/rstc.c
new file mode 100644
index 0000000..493f789
--- /dev/null
+++ b/drivers/clk/meson/rstc.c
@@ -0,0 +1,152 @@
+/*
+ * Copyright (c) 2014 Carlo Caione <carlo@caione.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/io.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include "clkc.h"
+
+/*
+ * Modules and submodules within the chip can be reset by disabling the
+ * clock and enabling it again.
+ * The modules in the AO (Always-On) domain are controlled by a different
+ * register mapped in a different memory region accessed by the ao_base.
+ *
+ */
+
+struct meson_rstc {
+	struct reset_controller_dev	rcdev;
+	void __iomem			*ao_base;
+	void __iomem			*ot_base;
+	unsigned int			num_regs;
+	unsigned int			ao_off_id;
+	u8				flags;
+	spinlock_t			lock;
+};
+
+static int meson_rstc_assert(struct reset_controller_dev *rcdev,
+			     unsigned long id)
+{
+	struct meson_rstc *rstc = container_of(rcdev,
+					       struct meson_rstc,
+					       rcdev);
+	int bank = id / BITS_PER_LONG;
+	int offset;
+	void __iomem *rstc_mem;
+	unsigned long flags;
+	u32 reg;
+
+	/*
+	 * The higher IDs are used for the AO domain register
+	 */
+	if (id >= rstc->ao_off_id) {
+		offset = id - rstc->ao_off_id;
+		rstc_mem = rstc->ao_base;
+	} else {
+		offset = id % BITS_PER_LONG;
+		rstc_mem = rstc->ot_base + (bank << 2);
+	}
+
+	spin_lock_irqsave(&rstc->lock, flags);
+
+	reg = readl(rstc_mem);
+	writel(reg & ~BIT(offset), rstc_mem);
+
+	spin_unlock_irqrestore(&rstc->lock, flags);
+
+	return 0;
+}
+
+static int meson_rstc_deassert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct meson_rstc *rstc = container_of(rcdev,
+					       struct meson_rstc,
+					       rcdev);
+	int bank = id / BITS_PER_LONG;
+	int offset;
+	void __iomem *rstc_mem;
+	unsigned long flags;
+	u32 reg;
+
+	if (id >= rstc->ao_off_id) {
+		offset = id - rstc->ao_off_id;
+		rstc_mem = rstc->ao_base;
+	} else {
+		offset = id % BITS_PER_LONG;
+		rstc_mem = rstc->ot_base + (bank << 2);
+	}
+
+	spin_lock_irqsave(&rstc->lock, flags);
+
+	reg = readl(rstc_mem);
+	writel(reg | BIT(offset), rstc_mem);
+
+	spin_unlock_irqrestore(&rstc->lock, flags);
+
+	return 0;
+
+}
+
+static int meson_rstc_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	int err;
+
+	err = meson_rstc_assert(rcdev, id);
+	if (err)
+		return err;
+
+	return meson_rstc_deassert(rcdev, id);
+}
+
+static struct reset_control_ops meson_rstc_ops = {
+	.assert		= meson_rstc_assert,
+	.deassert	= meson_rstc_deassert,
+	.reset		= meson_rstc_reset,
+};
+
+void __init meson_register_rstc(struct device_node *np, unsigned int num_regs,
+				void __iomem *ao_base, void __iomem *ot_base,
+				unsigned int ao_off_id, u8 flags)
+{
+	struct meson_rstc *rstc;
+	int ret;
+
+	rstc = kzalloc(sizeof(*rstc), GFP_KERNEL);
+	if (!rstc)
+		return;
+
+	spin_lock_init(&rstc->lock);
+
+	rstc->ao_base = ao_base;
+	rstc->ot_base = ot_base;
+	rstc->num_regs = num_regs;
+	rstc->flags = flags;
+
+	rstc->rcdev.owner = THIS_MODULE;
+	rstc->rcdev.nr_resets = num_regs * BITS_PER_LONG;
+	rstc->rcdev.of_node = np;
+	rstc->rcdev.ops = &meson_rstc_ops;
+
+	ret = reset_controller_register(&rstc->rcdev);
+	if (ret) {
+		pr_err("%s: could not register reset controller: %d\n",
+		       __func__, ret);
+		kfree(rstc);
+	}
+}
-- 
1.9.1
