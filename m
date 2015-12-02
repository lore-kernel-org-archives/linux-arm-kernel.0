From: carlo@caione.org (Carlo Caione)
Date: Wed,  2 Dec 2015 18:22:29 +0100
Subject: [PATCH v2 3/7] clk: Amlogic: Add reset controller for CPU cores for
 Meson8b
In-Reply-To: <1449076953-5058-1-git-send-email-carlo@caione.org>
References: <1449076953-5058-1-git-send-email-carlo@caione.org>
Message-ID: <1449076953-5058-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

In the Amlogic Meson8b SoC we need to soft reset the CPU cores during
the boot to enable the SMP support. With this patch we extend the clock
controller adding a small reset controller in charge of resetting the
cores.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/clk/meson/clk-cpu.c              | 60 +++++++++++++++++++++++++++++++-
 drivers/clk/meson/clkc.c                 |  5 +--
 drivers/clk/meson/clkc.h                 |  6 ++--
 drivers/clk/meson/meson8b-clkc.c         |  4 +--
 include/dt-bindings/clock/meson8b-clkc.h |  5 +++
 5 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/meson/clk-cpu.c b/drivers/clk/meson/clk-cpu.c
index f7c30ea..8836fa9 100644
--- a/drivers/clk/meson/clk-cpu.c
+++ b/drivers/clk/meson/clk-cpu.c
@@ -37,9 +37,14 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/reset.h>
+#include <linux/reset-controller.h>
 
 #define MESON_CPU_CLK_CNTL1		0x00
 #define MESON_CPU_CLK_CNTL		0x40
+#define MESON_CPU_CLK_CNTL_CPU		0x19c
+
+#define MESON_MAX_CPU_RST		4
 
 #define MESON_CPU_CLK_MUX1		BIT(7)
 #define MESON_CPU_CLK_MUX2		BIT(0)
@@ -51,6 +56,11 @@
 
 #include "clkc.h"
 
+struct meson_reset_cpu {
+	void __iomem			*reset_base;
+	struct reset_controller_dev	rcdev;
+};
+
 struct meson_clk_cpu {
 	struct notifier_block		clk_nb;
 	const struct clk_div_table	*div_table;
@@ -182,13 +192,50 @@ static const struct clk_ops meson_clk_cpu_ops = {
 	.set_rate	= meson_clk_cpu_set_rate,
 };
 
-struct clk *meson_clk_register_cpu(const struct clk_conf *clk_conf,
+static int meson_reset_cpu_assert(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	u32 reg;
+	struct meson_reset_cpu *reset_cpu = container_of(rcdev,
+							 struct meson_reset_cpu,
+							 rcdev);
+
+	reg = readl(reset_cpu->reset_base);
+	reg |= BIT(id + 24);
+	writel(reg, reset_cpu->reset_base);
+
+	return 0;
+}
+
+static int meson_reset_cpu_deassert(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	u32 reg;
+	struct meson_reset_cpu *reset_cpu = container_of(rcdev,
+							 struct meson_reset_cpu,
+							 rcdev);
+
+	reg = readl(reset_cpu->reset_base);
+	reg &= ~BIT(id + 24);
+	writel(reg, reset_cpu->reset_base);
+
+	return 0;
+}
+
+static struct reset_control_ops meson_cpu_reset_ops = {
+	.assert		= meson_reset_cpu_assert,
+	.deassert	= meson_reset_cpu_deassert,
+};
+
+struct clk *meson_clk_register_cpu(struct device_node *np,
+				   const struct clk_conf *clk_conf,
 				   void __iomem *reg_base,
 				   spinlock_t *lock)
 {
 	struct clk *clk;
 	struct clk *pclk;
 	struct meson_clk_cpu *clk_cpu;
+	struct meson_reset_cpu *reset_cpu;
 	struct clk_init_data init;
 	int ret;
 
@@ -231,6 +278,17 @@ struct clk *meson_clk_register_cpu(const struct clk_conf *clk_conf,
 		goto unregister_clk_nb;
 	}
 
+	reset_cpu = kzalloc(sizeof(*reset_cpu), GFP_KERNEL);
+	if (!reset_cpu)
+		goto out;
+
+	reset_cpu->reset_base = reg_base + MESON_CPU_CLK_CNTL_CPU;
+	reset_cpu->rcdev.nr_resets = MESON_MAX_CPU_RST;
+	reset_cpu->rcdev.ops = &meson_cpu_reset_ops;
+	reset_cpu->rcdev.of_node = np;
+	reset_controller_register(&reset_cpu->rcdev);
+
+out:
 	return clk;
 
 unregister_clk_nb:
diff --git a/drivers/clk/meson/clkc.c b/drivers/clk/meson/clkc.c
index c83ae13..df71e82 100644
--- a/drivers/clk/meson/clkc.c
+++ b/drivers/clk/meson/clkc.c
@@ -197,7 +197,8 @@ meson_clk_register_fixed_rate(const struct clk_conf *clk_conf,
 	return clk;
 }
 
-void __init meson_clk_register_clks(const struct clk_conf *clk_confs,
+void __init meson_clk_register_clks(struct device_node *np,
+				    const struct clk_conf *clk_confs,
 				    size_t nr_confs,
 				    void __iomem *clk_base)
 {
@@ -221,7 +222,7 @@ void __init meson_clk_register_clks(const struct clk_conf *clk_confs,
 							   clk_base);
 			break;
 		case CLK_CPU:
-			clk = meson_clk_register_cpu(clk_conf, clk_base,
+			clk = meson_clk_register_cpu(np, clk_conf, clk_base,
 						     &clk_lock);
 			break;
 		case CLK_PLL:
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 609ae92..648d41d 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -177,9 +177,11 @@ struct clk_conf {
 	}								\
 
 struct clk **meson_clk_init(struct device_node *np, unsigned long nr_clks);
-void meson_clk_register_clks(const struct clk_conf *clk_confs,
+void meson_clk_register_clks(struct device_node *np,
+			     const struct clk_conf *clk_confs,
 			     unsigned int nr_confs, void __iomem *clk_base);
-struct clk *meson_clk_register_cpu(const struct clk_conf *clk_conf,
+struct clk *meson_clk_register_cpu(struct device_node *np,
+				   const struct clk_conf *clk_conf,
 				   void __iomem *reg_base, spinlock_t *lock);
 struct clk *meson_clk_register_pll(const struct clk_conf *clk_conf,
 				   void __iomem *reg_base, spinlock_t *lock);
diff --git a/drivers/clk/meson/meson8b-clkc.c b/drivers/clk/meson/meson8b-clkc.c
index 61f6d55..98f1ebd 100644
--- a/drivers/clk/meson/meson8b-clkc.c
+++ b/drivers/clk/meson/meson8b-clkc.c
@@ -179,7 +179,7 @@ static void __init meson8b_clkc_init(struct device_node *np)
 		return;
 	}
 
-	meson_clk_register_clks(&meson8b_xtal_conf, 1, clk_base);
+	meson_clk_register_clks(np, &meson8b_xtal_conf, 1, clk_base);
 	iounmap(clk_base);
 
 	/*  Generic clocks and PLLs */
@@ -189,7 +189,7 @@ static void __init meson8b_clkc_init(struct device_node *np)
 		return;
 	}
 
-	meson_clk_register_clks(meson8b_clk_confs,
+	meson_clk_register_clks(np, meson8b_clk_confs,
 				ARRAY_SIZE(meson8b_clk_confs),
 				clk_base);
 }
diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index bd2720d..bbdadca 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -5,6 +5,11 @@
 #ifndef __MESON8B_CLKC_H
 #define __MESON8B_CLKC_H
 
+#define RST_CORE0		0
+#define RST_CORE1		1
+#define RST_CORE2		2
+#define RST_CORE3		3
+
 #define CLKID_UNUSED		0
 #define CLKID_XTAL		1
 #define CLKID_PLL_FIXED		2
-- 
2.5.0
