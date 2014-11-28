From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 28 Nov 2014 19:34:48 +0800
Subject: [PATCH 2/4] clk: Add INFRA and PERI clocks for Mediatek MT8135.
In-Reply-To: <1417174490-6845-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1417174490-6845-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1417174490-6845-3-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clock gates support for Mediatek SoCs, and adds clocks of
INFRA sys and PERI sys for MT8135.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/Makefile          |   2 +-
 drivers/clk/mediatek/clk-gate.c        | 151 +++++++++++++++++++
 drivers/clk/mediatek/clk-gate.h        |  48 ++++++
 drivers/clk/mediatek/clk-mt8135.c      | 260 +++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/mt8135-clk.h |  62 ++++++++
 5 files changed, 522 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-gate.c
 create mode 100644 drivers/clk/mediatek/clk-gate.h

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 3c3432b..96a7044 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1,2 +1,2 @@
-obj-y += clk-mtk.o clk-pll.o
+obj-y += clk-mtk.o clk-pll.o clk-gate.o
 obj-y += clk-mt8135.o clk-mt8135-pll.o
diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
new file mode 100644
index 0000000..8f9a9ea
--- /dev/null
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -0,0 +1,151 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/clkdev.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+/*
+ * clk_gate
+ */
+
+static void cg_set_mask(struct mtk_clk_gate *cg, u32 mask)
+{
+	u32 r;
+
+	if (cg->flags & CLK_GATE_NO_SETCLR_REG) {
+		r = readl_relaxed(cg->sta_addr) | mask;
+		writel_relaxed(r, cg->sta_addr);
+	} else
+		writel_relaxed(mask, cg->set_addr);
+}
+
+static void cg_clr_mask(struct mtk_clk_gate *cg, u32 mask)
+{
+	u32 r;
+
+	if (cg->flags & CLK_GATE_NO_SETCLR_REG) {
+		r = readl_relaxed(cg->sta_addr) & ~mask;
+		writel_relaxed(r, cg->sta_addr);
+	} else
+		writel_relaxed(mask, cg->clr_addr);
+}
+
+static int cg_enable(struct clk_hw *hw)
+{
+	unsigned long flags = 0;
+	struct mtk_clk_gate *cg = to_clk_gate(hw);
+	u32 mask = BIT(cg->bit);
+
+	pr_debug("%s, bit: %u\n", __clk_get_name(hw->clk), cg->bit);
+
+	mtk_clk_lock(flags);
+
+	if (cg->flags & CLK_GATE_INVERSE)
+		cg_set_mask(cg, mask);
+	else
+		cg_clr_mask(cg, mask);
+
+	mtk_clk_unlock(flags);
+
+	return 0;
+}
+
+static void cg_disable(struct clk_hw *hw)
+{
+	unsigned long flags = 0;
+	struct mtk_clk_gate *cg = to_clk_gate(hw);
+	u32 mask = BIT(cg->bit);
+
+	pr_debug("%s, bit: %u\n", __clk_get_name(hw->clk), cg->bit);
+
+	mtk_clk_lock(flags);
+
+	if (cg->flags & CLK_GATE_INVERSE)
+		cg_clr_mask(cg, mask);
+	else
+		cg_set_mask(cg, mask);
+
+	mtk_clk_unlock(flags);
+}
+
+static int cg_is_enabled(struct clk_hw *hw)
+{
+	struct mtk_clk_gate *cg = to_clk_gate(hw);
+	u32 mask;
+	u32 val;
+	int r;
+
+	mask = BIT(cg->bit);
+	val = mask & readl(cg->sta_addr);
+
+	r = (cg->flags & CLK_GATE_INVERSE) ? (val != 0) : (val == 0);
+
+	pr_debug("%d, %s, bit[%d]\n", r, __clk_get_name(hw->clk), (int)cg->bit);
+
+	return r;
+}
+
+static const struct clk_ops mtk_clk_gate_ops = {
+	.is_enabled	= cg_is_enabled,
+	.enable		= cg_enable,
+	.disable	= cg_disable,
+};
+
+struct clk *mtk_clk_register_gate(
+		const char *name,
+		const char *parent_name,
+		void __iomem *set_addr,
+		void __iomem *clr_addr,
+		void __iomem *sta_addr,
+		u8 bit,
+		u32 flags)
+{
+	struct mtk_clk_gate *cg;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	pr_debug("name: %s, bit: %d\n", name, (int)bit);
+
+	cg = kzalloc(sizeof(*cg), GFP_KERNEL);
+	if (!cg)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.flags = CLK_IGNORE_UNUSED;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+	init.ops = &mtk_clk_gate_ops;
+
+	cg->set_addr = set_addr;
+	cg->clr_addr = clr_addr;
+	cg->sta_addr = sta_addr;
+	cg->bit = bit;
+	cg->flags = flags;
+
+	cg->hw.init = &init;
+
+	clk = clk_register(NULL, &cg->hw);
+	if (IS_ERR(clk))
+		kfree(cg);
+
+	return clk;
+}
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
new file mode 100644
index 0000000..0d71aad
--- /dev/null
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -0,0 +1,48 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __DRV_CLK_GATE_H
+#define __DRV_CLK_GATE_H
+
+/*
+ * This is a private header file. DO NOT include it except clk-*.c.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+struct mtk_clk_gate {
+	struct clk_hw	hw;
+	void __iomem	*set_addr;
+	void __iomem	*clr_addr;
+	void __iomem	*sta_addr;
+	u8		bit;
+	u32		flags;
+};
+
+#define to_clk_gate(_hw) container_of(_hw, struct mtk_clk_gate, hw)
+
+#define CLK_GATE_INVERSE	BIT(0)
+#define CLK_GATE_NO_SETCLR_REG	BIT(1)
+
+struct clk *mtk_clk_register_gate(
+		const char *name,
+		const char *parent_name,
+		void __iomem *set_addr,
+		void __iomem *clr_addr,
+		void __iomem *sta_addr,
+		u8 bit,
+		u32 flags);
+
+#endif /* __DRV_CLK_GATE_H */
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index fa8dd7d..2496e54 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -18,6 +18,7 @@
 
 #include "clk-mtk.h"
 #include "clk-pll.h"
+#include "clk-gate.h"
 #include "clk-mt8135-pll.h"
 
 #include <dt-bindings/clock/mt8135-clk.h>
@@ -149,6 +150,66 @@
 #define apll_sel		"apll_sel"
 #define hdmipll_sel		"hdmipll_sel"
 
+/* PERI0 */
+#define i2c5_ck			"i2c5_ck"
+#define i2c4_ck			"i2c4_ck"
+#define i2c3_ck			"i2c3_ck"
+#define i2c2_ck			"i2c2_ck"
+#define i2c1_ck			"i2c1_ck"
+#define i2c0_ck			"i2c0_ck"
+#define uart3_ck		"uart3_ck"
+#define uart2_ck		"uart2_ck"
+#define uart1_ck		"uart1_ck"
+#define uart0_ck		"uart0_ck"
+#define irda_ck			"irda_ck"
+#define nli_ck			"nli_ck"
+#define md_hif_ck		"md_hif_ck"
+#define ap_hif_ck		"ap_hif_ck"
+#define msdc30_3_ck		"msdc30_3_ck"
+#define msdc30_2_ck		"msdc30_2_ck"
+#define msdc30_1_ck		"msdc30_1_ck"
+#define msdc20_2_ck		"msdc20_2_ck"
+#define msdc20_1_ck		"msdc20_1_ck"
+#define ap_dma_ck		"ap_dma_ck"
+#define usb1_ck			"usb1_ck"
+#define usb0_ck			"usb0_ck"
+#define pwm_ck			"pwm_ck"
+#define pwm7_ck			"pwm7_ck"
+#define pwm6_ck			"pwm6_ck"
+#define pwm5_ck			"pwm5_ck"
+#define pwm4_ck			"pwm4_ck"
+#define pwm3_ck			"pwm3_ck"
+#define pwm2_ck			"pwm2_ck"
+#define pwm1_ck			"pwm1_ck"
+#define therm_ck		"therm_ck"
+#define nfi_ck			"nfi_ck"
+
+/* PERI1 */
+#define usbslv_ck		"usbslv_ck"
+#define usb1_mcu_ck		"usb1_mcu_ck"
+#define usb0_mcu_ck		"usb0_mcu_ck"
+#define gcpu_ck			"gcpu_ck"
+#define fhctl_ck		"fhctl_ck"
+#define spi1_ck			"spi1_ck"
+#define auxadc_ck		"auxadc_ck"
+#define peri_pwrap_ck		"peri_pwrap_ck"
+#define i2c6_ck			"i2c6_ck"
+
+/* INFRA */
+#define pmic_wrap_ck		"pmic_wrap_ck"
+#define pmicspi_ck		"pmicspi_ck"
+#define ccif1_ap_ctrl		"ccif1_ap_ctrl"
+#define ccif0_ap_ctrl		"ccif0_ap_ctrl"
+#define kp_ck			"kp_ck"
+#define cpum_ck			"cpum_ck"
+#define m4u_ck			"m4u_ck"
+#define mfgaxi_ck		"mfgaxi_ck"
+#define devapc_ck		"devapc_ck"
+#define audio_ck		"audio_ck"
+#define mfg_bus_ck		"mfg_bus_ck"
+#define smi_ck			"smi_ck"
+#define dbgclk_ck		"dbgclk_ck"
+
 struct mtk_fixed_factor {
 	int id;
 	const char *name;
@@ -673,6 +734,157 @@ static void __init init_clk_apmixedsys(void __iomem *apmixed_base,
 	}
 }
 
+struct mtk_gate_regs {
+	u32 sta_ofs;
+	u32 clr_ofs;
+	u32 set_ofs;
+};
+
+struct mtk_gate {
+	int id;
+	const char *name;
+	const char *parent_name;
+	struct mtk_gate_regs *regs;
+	int shift;
+	u32 flags;
+};
+
+#define GATE(_id, _name, _parent, _regs, _shift, _flags) {	\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.regs = &_regs,					\
+		.shift = _shift,				\
+		.flags = _flags,				\
+	}
+
+static void __init init_clk_gates(
+		void __iomem *reg_base,
+		struct mtk_gate *clks, int num,
+		struct clk_onecell_data *clk_data)
+{
+	int i;
+	struct clk *clk;
+
+	for (i = 0; i < num; i++) {
+		struct mtk_gate *gate = &clks[i];
+
+		clk = mtk_clk_register_gate(gate->name, gate->parent_name,
+				reg_base + gate->regs->set_ofs,
+				reg_base + gate->regs->clr_ofs,
+				reg_base + gate->regs->sta_ofs,
+				gate->shift, gate->flags);
+
+		if (IS_ERR(clk)) {
+			pr_err("Failed to register clk %s: %ld\n",
+					gate->name, PTR_ERR(clk));
+			continue;
+		}
+
+		if (clk_data)
+			clk_data->clks[gate->id] = clk;
+
+		pr_debug("gate %3d: %s\n", i, gate->name);
+	}
+}
+
+static struct mtk_gate_regs infra_cg_regs = {
+	.set_ofs = 0x0040,
+	.clr_ofs = 0x0044,
+	.sta_ofs = 0x0048,
+};
+
+static struct mtk_gate infra_clks[] __initdata = {
+	GATE(INFRA_PMIC_WRAP_CK, pmic_wrap_ck, axi_sel, infra_cg_regs, 23, 0),
+	GATE(INFRA_PMICSPI_CK, pmicspi_ck, pmicspi_sel, infra_cg_regs, 22, 0),
+	GATE(INFRA_CCIF1_AP_CTRL, ccif1_ap_ctrl, axi_sel, infra_cg_regs, 21, 0),
+	GATE(INFRA_CCIF0_AP_CTRL, ccif0_ap_ctrl, axi_sel, infra_cg_regs, 20, 0),
+	GATE(INFRA_KP_CK, kp_ck, axi_sel, infra_cg_regs, 16, 0),
+	GATE(INFRA_CPUM_CK, cpum_ck, cpum_tck_in, infra_cg_regs, 15, 0),
+	GATE(INFRA_M4U_CK, m4u_ck, mem_sel, infra_cg_regs, 8, 0),
+	GATE(INFRA_MFGAXI_CK, mfgaxi_ck, axi_sel, infra_cg_regs, 7, 0),
+	GATE(INFRA_DEVAPC_CK, devapc_ck, axi_sel, infra_cg_regs, 6,
+		CLK_GATE_INVERSE),
+	GATE(INFRA_AUDIO_CK, audio_ck, aud_intbus_sel, infra_cg_regs, 5, 0),
+	GATE(INFRA_MFG_BUS_CK, mfg_bus_ck, axi_sel, infra_cg_regs, 2, 0),
+	GATE(INFRA_SMI_CK, smi_ck, smi_sel, infra_cg_regs, 1, 0),
+	GATE(INFRA_DBGCLK_CK, dbgclk_ck, axi_sel, infra_cg_regs, 0, 0),
+};
+
+static void __init init_clk_infrasys(void __iomem *infrasys_base,
+		struct clk_onecell_data *clk_data)
+{
+	pr_debug("init infrasys gates:\n");
+	init_clk_gates(infrasys_base, infra_clks, ARRAY_SIZE(infra_clks),
+		clk_data);
+}
+
+static struct mtk_gate_regs peri0_cg_regs = {
+	.set_ofs = 0x0008,
+	.clr_ofs = 0x0010,
+	.sta_ofs = 0x0018,
+};
+
+static struct mtk_gate_regs peri1_cg_regs = {
+	.set_ofs = 0x000c,
+	.clr_ofs = 0x0014,
+	.sta_ofs = 0x001c,
+};
+
+static struct mtk_gate peri_clks[] __initdata = {
+	/* PERI0 */
+	GATE(PERI_I2C5_CK, i2c5_ck, axi_sel, peri0_cg_regs, 31, 0),
+	GATE(PERI_I2C4_CK, i2c4_ck, axi_sel, peri0_cg_regs, 30, 0),
+	GATE(PERI_I2C3_CK, i2c3_ck, axi_sel, peri0_cg_regs, 29, 0),
+	GATE(PERI_I2C2_CK, i2c2_ck, axi_sel, peri0_cg_regs, 28, 0),
+	GATE(PERI_I2C1_CK, i2c1_ck, axi_sel, peri0_cg_regs, 27, 0),
+	GATE(PERI_I2C0_CK, i2c0_ck, axi_sel, peri0_cg_regs, 26, 0),
+	GATE(PERI_UART3_CK, uart3_ck, axi_sel, peri0_cg_regs, 25, 0),
+	GATE(PERI_UART2_CK, uart2_ck, axi_sel, peri0_cg_regs, 24, 0),
+	GATE(PERI_UART1_CK, uart1_ck, axi_sel, peri0_cg_regs, 23, 0),
+	GATE(PERI_UART0_CK, uart0_ck, axi_sel, peri0_cg_regs, 22, 0),
+	GATE(PERI_IRDA_CK, irda_ck, irda_sel, peri0_cg_regs, 21, 0),
+	GATE(PERI_NLI_CK, nli_ck, axi_sel, peri0_cg_regs, 20, 0),
+	GATE(PERI_MD_HIF_CK, md_hif_ck, axi_sel, peri0_cg_regs, 19, 0),
+	GATE(PERI_AP_HIF_CK, ap_hif_ck, axi_sel, peri0_cg_regs, 18, 0),
+	GATE(PERI_MSDC30_3_CK, msdc30_3_ck, msdc30_4_sel, peri0_cg_regs, 17, 0),
+	GATE(PERI_MSDC30_2_CK, msdc30_2_ck, msdc30_3_sel, peri0_cg_regs, 16, 0),
+	GATE(PERI_MSDC30_1_CK, msdc30_1_ck, msdc30_2_sel, peri0_cg_regs, 15, 0),
+	GATE(PERI_MSDC20_2_CK, msdc20_2_ck, msdc30_1_sel, peri0_cg_regs, 14, 0),
+	GATE(PERI_MSDC20_1_CK, msdc20_1_ck, msdc30_0_sel, peri0_cg_regs, 13, 0),
+	GATE(PERI_AP_DMA_CK, ap_dma_ck, axi_sel, peri0_cg_regs, 12, 0),
+	GATE(PERI_USB1_CK, usb1_ck, usb20_sel, peri0_cg_regs, 11, 0),
+	GATE(PERI_USB0_CK, usb0_ck, usb20_sel, peri0_cg_regs, 10, 0),
+	GATE(PERI_PWM_CK, pwm_ck, axi_sel, peri0_cg_regs, 9, 0),
+	GATE(PERI_PWM7_CK, pwm7_ck, axi_sel, peri0_cg_regs, 8, 0),
+	GATE(PERI_PWM6_CK, pwm6_ck, axi_sel, peri0_cg_regs, 7, 0),
+	GATE(PERI_PWM5_CK, pwm5_ck, axi_sel, peri0_cg_regs, 6, 0),
+	GATE(PERI_PWM4_CK, pwm4_ck, axi_sel, peri0_cg_regs, 5, 0),
+	GATE(PERI_PWM3_CK, pwm3_ck, axi_sel, peri0_cg_regs, 4, 0),
+	GATE(PERI_PWM2_CK, pwm2_ck, axi_sel, peri0_cg_regs, 3, 0),
+	GATE(PERI_PWM1_CK, pwm1_ck, axi_sel, peri0_cg_regs, 2, 0),
+	GATE(PERI_THERM_CK, therm_ck, axi_sel, peri0_cg_regs, 1, 0),
+	GATE(PERI_NFI_CK, nfi_ck, axi_sel, peri0_cg_regs, 0, 0),
+	/* PERI1 */
+	GATE(PERI_USBSLV_CK, usbslv_ck, axi_sel, peri1_cg_regs, 8, 0),
+	GATE(PERI_USB1_MCU_CK, usb1_mcu_ck, axi_sel, peri1_cg_regs, 7, 0),
+	GATE(PERI_USB0_MCU_CK, usb0_mcu_ck, axi_sel, peri1_cg_regs, 6, 0),
+	GATE(PERI_GCPU_CK, gcpu_ck, gcpu_sel, peri1_cg_regs, 5, 0),
+	GATE(PERI_FHCTL_CK, fhctl_ck, clk26m, peri1_cg_regs, 4, 0),
+	GATE(PERI_SPI1_CK, spi1_ck, spi_sel, peri1_cg_regs, 3, 0),
+	GATE(PERI_AUXADC_CK, auxadc_ck, clk26m, peri1_cg_regs, 2, 0),
+	GATE(PERI_PERI_PWRAP_CK, peri_pwrap_ck, axi_sel, peri1_cg_regs, 1, 0),
+	GATE(PERI_I2C6_CK, i2c6_ck, axi_sel, peri1_cg_regs, 0, 0),
+};
+
+static void __init init_clk_perisys(void __iomem *perisys_base,
+		struct clk_onecell_data *clk_data)
+{
+	pr_debug("init perisys gates:\n");
+	init_clk_gates(perisys_base, peri_clks, ARRAY_SIZE(peri_clks),
+		clk_data);
+}
+
 /*
  * device tree support
  */
@@ -750,3 +962,51 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 }
 CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt8135-apmixedsys",
 		mtk_apmixedsys_init);
+
+static void __init mtk_infrasys_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	void __iomem *base;
+	int r;
+
+	pr_debug("%s: %s\n", __func__, node->name);
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("ioremap infrasys failed\n");
+		return;
+	}
+
+	clk_data = alloc_clk_data(INFRA_NR_CLK);
+
+	init_clk_infrasys(base, clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		pr_err("could not register clock provide\n");
+}
+CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8135-infracfg", mtk_infrasys_init);
+
+static void __init mtk_perisys_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	void __iomem *base;
+	int r;
+
+	pr_debug("%s: %s\n", __func__, node->name);
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("ioremap infrasys failed\n");
+		return;
+	}
+
+	clk_data = alloc_clk_data(PERI_NR_CLK);
+
+	init_clk_perisys(base, clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		pr_err("could not register clock provide\n");
+}
+CLK_OF_DECLARE(mtk_perisys, "mediatek,mt8135-pericfg", mtk_perisys_init);
diff --git a/include/dt-bindings/clock/mt8135-clk.h b/include/dt-bindings/clock/mt8135-clk.h
index 674fd1a..a477354 100644
--- a/include/dt-bindings/clock/mt8135-clk.h
+++ b/include/dt-bindings/clock/mt8135-clk.h
@@ -125,4 +125,66 @@
 #define APMIXED_VDECPLL		10
 #define APMIXED_NR_CLK		11
 
+/* INFRA_SYS */
+
+#define INFRA_PMIC_WRAP_CK	1
+#define INFRA_PMICSPI_CK	2
+#define INFRA_CCIF1_AP_CTRL	3
+#define INFRA_CCIF0_AP_CTRL	4
+#define INFRA_KP_CK		5
+#define INFRA_CPUM_CK		6
+#define INFRA_M4U_CK		7
+#define INFRA_MFGAXI_CK		8
+#define INFRA_DEVAPC_CK		9
+#define INFRA_AUDIO_CK		10
+#define INFRA_MFG_BUS_CK	11
+#define INFRA_SMI_CK		12
+#define INFRA_DBGCLK_CK		13
+#define INFRA_NR_CLK		14
+
+/* PERI_SYS */
+
+#define PERI_I2C5_CK		1
+#define PERI_I2C4_CK		2
+#define PERI_I2C3_CK		3
+#define PERI_I2C2_CK		4
+#define PERI_I2C1_CK		5
+#define PERI_I2C0_CK		6
+#define PERI_UART3_CK		7
+#define PERI_UART2_CK		8
+#define PERI_UART1_CK		9
+#define PERI_UART0_CK		10
+#define PERI_IRDA_CK		11
+#define PERI_NLI_CK		12
+#define PERI_MD_HIF_CK		13
+#define PERI_AP_HIF_CK		14
+#define PERI_MSDC30_3_CK	15
+#define PERI_MSDC30_2_CK	16
+#define PERI_MSDC30_1_CK	17
+#define PERI_MSDC20_2_CK	18
+#define PERI_MSDC20_1_CK	19
+#define PERI_AP_DMA_CK		20
+#define PERI_USB1_CK		21
+#define PERI_USB0_CK		22
+#define PERI_PWM_CK		23
+#define PERI_PWM7_CK		24
+#define PERI_PWM6_CK		25
+#define PERI_PWM5_CK		26
+#define PERI_PWM4_CK		27
+#define PERI_PWM3_CK		28
+#define PERI_PWM2_CK		29
+#define PERI_PWM1_CK		30
+#define PERI_THERM_CK		31
+#define PERI_NFI_CK		32
+#define PERI_USBSLV_CK		33
+#define PERI_USB1_MCU_CK	34
+#define PERI_USB0_MCU_CK	35
+#define PERI_GCPU_CK		36
+#define PERI_FHCTL_CK		37
+#define PERI_SPI1_CK		38
+#define PERI_AUXADC_CK		39
+#define PERI_PERI_PWRAP_CK	40
+#define PERI_I2C6_CK		41
+#define PERI_NR_CLK		42
+
 #endif /* _DT_BINDINGS_CLK_MT8135_H */
-- 
1.8.1.1.dirty
