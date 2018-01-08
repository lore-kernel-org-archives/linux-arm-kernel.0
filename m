From: jolly.shah@xilinx.com (Jolly Shah)
Date: Mon, 8 Jan 2018 14:16:37 -0800
Subject: [RFC PATCH 2/2] drivers: clk: Add ZynqMP clock driver
In-Reply-To: <1515449797-5629-1-git-send-email-jollys@xilinx.com>
References: <1515449797-5629-1-git-send-email-jollys@xilinx.com>
Message-ID: <1515449797-5629-3-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds CCF compliant clock driver for ZynqMP.
Clock driver queries supported clock information from
firmware and regiters pll and output clocks with CCF.

Signed-off-by: Jolly Shah <jollys@xilinx.com>
Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Tejas Patel <tejasp@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 .../devicetree/bindings/clock/zynq_mpsoc.txt       | 163 +++++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/zynqmp/Kconfig                         |   8 +
 drivers/clk/zynqmp/Makefile                        |   3 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c               | 158 +++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c                | 190 ++++++
 drivers/clk/zynqmp/clkc.c                          | 707 +++++++++++++++++++++
 drivers/clk/zynqmp/divider.c                       | 239 +++++++
 drivers/clk/zynqmp/pll.c                           | 384 +++++++++++
 include/linux/clk/zynqmp.h                         |  46 ++
 11 files changed, 1900 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/zynq_mpsoc.txt
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c
 create mode 100644 include/linux/clk/zynqmp.h

diff --git a/Documentation/devicetree/bindings/clock/zynq_mpsoc.txt b/Documentation/devicetree/bindings/clock/zynq_mpsoc.txt
new file mode 100644
index 0000000..9061b57
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/zynq_mpsoc.txt
@@ -0,0 +1,163 @@
+Device Tree Clock bindings for the Zynq Ultrascale+ MPSoC
+
+The Zynq Ultrascale+ MPSoC has several different clk providers,
+each with there own bindings.
+The purpose of this document is to document their usage.
+
+See clock_bindings.txt for more information on the generic clock bindings.
+
+== Clock Controller ==
+The clock controller is a logical abstraction of Zynq Ultrascale+ MPSoC clock
+tree. It reads required input clock frequencies from the devicetree and acts
+as clock provider for all clock consumers of PS clocks.
+
+Required properties:
+ - #clock-cells : Must be 1
+ - compatible : "xlnx,zynqmp-clkc"
+ - clocks : list of clock specifiers which are external input clocks to the
+	    given clock controller. Please refer the next section to find
+	    the input clocks for a given controller.
+ - clock-names : list of names of clocks which are exteral input clocks to the
+		 given clock controller. Please refer to the clock bindings
+		 for more details
+
+Input clocks for zynqmp Ultrascale+ clock controller:
+The Zynq UltraScale+ MPSoC has one primary and four alternative reference clock
+inputs.
+These required clock inputs are the
+ - pss_ref_clk (PS reference clock)
+ - video_clk (reference clock for video system )
+ - pss_alt_ref_clk (alternative PS reference clock)
+ - aux_ref_clk
+ - gt_crx_ref_clk (transceiver reference clock)
+
+The following strings are optional parameters to the 'clock-names' property in
+order to provide an optional (E)MIO clock source.
+ - swdt0_ext_clk
+ - swdt1_ext_clk
+ - gem0_emio_clk
+ - gem1_emio_clk
+ - gem2_emio_clk
+ - gem3_emio_clk
+ - mio_clk_XX		# with XX = 00..77
+ - mio_clk_50_or_51	#for the mux clock to gem tsu from 50 or 51
+
+
+Output clocks for zynqmp Ultrascale+ clock controller:
+Output clocks are registered based on clock information received from firmware.
+Output clock indexes are mentioned below:
+
+Clock ID:	Output clock name:
+-------------------------------------
+0		iopll
+1		rpll
+2		apll
+3		dpll
+4		vpll
+5		iopll_to_fpd
+6		rpll_to_fpd
+7		apll_to_lpd
+8		dpll_to_lpd
+9		vpll_to_lpd
+10		acpu
+11		acpu_half
+12		dbf_fpd
+13		dbf_lpd
+14		dbg_trace
+15		dbg_tstmp
+16		dp_video_ref
+17		dp_audio_ref
+18		dp_stc_ref
+19		gdma_ref
+20		dpdma_ref
+21		ddr_ref
+22		sata_ref
+23		pcie_ref
+24		gpu_ref
+25		gpu_pp0_ref
+26		gpu_pp1_ref
+27		topsw_main
+28		topsw_lsbus
+29		gtgref0_ref
+30		lpd_switch
+31		lpd_lsbus
+32		usb0_bus_ref
+33		usb1_bus_ref
+34		usb3_dual_ref
+35		usb0
+36		usb1
+37		cpu_r5
+38		cpu_r5_core
+39		csu_spb
+40		csu_pll
+41		pcap
+42		iou_switch
+43		gem_tsu_ref
+44		gem_tsu
+45		gem0_ref
+46		gem1_ref
+47		gem2_ref
+48		gem3_ref
+49		gem0_tx
+50		gem1_tx
+51		gem2_tx
+52		gem3_tx
+53		qspi_ref
+54		sdio0_ref
+55		sdio1_ref
+56		uart0_ref
+57		uart1_ref
+58		spi0_ref
+59		spi1_ref
+60		nand_ref
+61		i2c0_ref
+62		i2c1_ref
+63		can0_ref
+64		can1_ref
+65		can0
+66		can1
+67		dll_ref
+68		adma_ref
+69		timestamp_ref
+70		ams_ref
+71		pl0_ref
+72		pl1_ref
+73		pl2_ref
+74		pl3_ref
+75		wdt
+76		iopll_int
+77		iopll_pre_src
+78		iopll_half
+79		iopll_int_mux
+80		iopll_post_src
+81		rpll_int
+82		rpll_pre_src
+83		rpll_half
+84		rpll_int_mux
+85		rpll_post_src
+86		apll_int
+87		apll_pre_src
+88		apll_half
+89		apll_int_mux
+90		apll_post_src
+91		dpll_int
+92		dpll_pre_src
+93		dpll_half
+94		dpll_int_mux
+95		dpll_post_src
+96		vpll_int
+97		vpll_pre_src
+98		vpll_half
+99		vpll_int_mux
+100		vpll_post_src
+101		can0_mio
+102		can1_mio
+
+Example:
+
+clkc: clkc at ff5e0020 {
+	#clock-cells = <1>;
+	compatible = "xlnx,zynqmp-clkc";
+	clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
+	clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk"
+};
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 1c4e1aa..526f4f5 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -239,6 +239,7 @@ source "drivers/clk/samsung/Kconfig"
 source "drivers/clk/sunxi-ng/Kconfig"
 source "drivers/clk/tegra/Kconfig"
 source "drivers/clk/ti/Kconfig"
+source "drivers/clk/zynqmp/Kconfig"
 source "drivers/clk/uniphier/Kconfig"
 
 endmenu
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f7f761b..d7328b4 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -98,3 +98,4 @@ obj-$(CONFIG_X86)			+= x86/
 endif
 obj-$(CONFIG_ARCH_ZX)			+= zte/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
+obj-$(CONFIG_COMMON_CLK_ZYNQMP)         += zynqmp/
diff --git a/drivers/clk/zynqmp/Kconfig b/drivers/clk/zynqmp/Kconfig
new file mode 100644
index 0000000..a6d54e9
--- /dev/null
+++ b/drivers/clk/zynqmp/Kconfig
@@ -0,0 +1,8 @@
+config COMMON_CLK_ZYNQMP
+	bool "Support for Xilinx ZynqMP Ultrascale+ clock controllers"
+	depends on OF
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	help
+	  Support for the Zynqmp Ultrascale clock controller.
+	  It has a dependency on the PMU firmware.
+	  Say Y if you want to support clock support
diff --git a/drivers/clk/zynqmp/Makefile b/drivers/clk/zynqmp/Makefile
new file mode 100644
index 0000000..7d50f7a
--- /dev/null
+++ b/drivers/clk/zynqmp/Makefile
@@ -0,0 +1,3 @@
+# Zynq Ultrascale+ MPSoC clock specific Makefile
+
+obj-$(CONFIG_ARCH_ZYNQMP)	+= pll.o clk-gate-zynqmp.o divider.o clk-mux-zynqmp.o clkc.o
diff --git a/drivers/clk/zynqmp/clk-gate-zynqmp.c b/drivers/clk/zynqmp/clk-gate-zynqmp.c
new file mode 100644
index 0000000..45eeed8
--- /dev/null
+++ b/drivers/clk/zynqmp/clk-gate-zynqmp.c
@@ -0,0 +1,158 @@
+/*
+ * Zynq UltraScale+ MPSoC clock controller
+ *
+ *  Copyright (C) 2016-2017 Xilinx
+ *
+ * SPDX-License-Identifier:     GPL-2.0+
+ *
+ * Gated clock implementation
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clk/zynqmp.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/string.h>
+
+/**
+ * struct clk_gate - gating clock
+ *
+ * @hw:	handle between common and hardware-specific interfaces
+ * @flags:	hardware-specific flags
+ * @clk_id:	Id of clock
+ */
+struct zynqmp_clk_gate {
+	struct clk_hw hw;
+	u8 flags;
+	u32 clk_id;
+};
+
+#define to_zynqmp_clk_gate(_hw) container_of(_hw, struct zynqmp_clk_gate, hw)
+
+/**
+ * zynqmp_clk_gate_enable - Enable clock
+ * @hw: handle between common and hardware-specific interfaces
+ *
+ * Return: 0 always
+ */
+static int zynqmp_clk_gate_enable(struct clk_hw *hw)
+{
+	struct zynqmp_clk_gate *gate = to_zynqmp_clk_gate(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = gate->clk_id;
+	int ret = 0;
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->clock_enable)
+		return -ENXIO;
+
+	ret = eemi_ops->clock_enable(clk_id);
+
+	if (ret)
+		pr_warn_once("%s() clock enabled failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return 0;
+}
+
+/*
+ * zynqmp_clk_gate_disable - Disable clock
+ * @hw: handle between common and hardware-specific interfaces
+ */
+static void zynqmp_clk_gate_disable(struct clk_hw *hw)
+{
+	struct zynqmp_clk_gate *gate = to_zynqmp_clk_gate(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = gate->clk_id;
+	int ret = 0;
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->clock_disable)
+		return;
+
+	ret = eemi_ops->clock_disable(clk_id);
+
+	if (ret)
+		pr_warn_once("%s() clock disable failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+}
+
+/**
+ * zynqmp_clk_gate_is_enable - Check clock state
+ * @hw: handle between common and hardware-specific interfaces
+ *
+ * Return: 1 if enabled
+ *         0 if disabled
+ */
+static int zynqmp_clk_gate_is_enabled(struct clk_hw *hw)
+{
+	struct zynqmp_clk_gate *gate = to_zynqmp_clk_gate(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = gate->clk_id;
+	int state, ret;
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->clock_getstate)
+		return 0;
+
+	ret = eemi_ops->clock_getstate(clk_id, &state);
+	if (ret)
+		pr_warn_once("%s() clock get state failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return state ? 1 : 0;
+}
+
+const struct clk_ops zynqmp_clk_gate_ops = {
+	.enable = zynqmp_clk_gate_enable,
+	.disable = zynqmp_clk_gate_disable,
+	.is_enabled = zynqmp_clk_gate_is_enabled,
+};
+EXPORT_SYMBOL_GPL(zynqmp_clk_gate_ops);
+
+/**
+ * zynqmp_clk_register_gate - register a gate clock with the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @clk_id: Id of this clock
+ * @parents: name of this clock's parents
+ * @num_parents: number of parents
+ * @flags: framework-specific flags for this clock
+ * @clk_gate_flags: gate-specific flags for this clock
+ *
+ * Return: clock handle of the registered clock gate
+ */
+struct clk *zynqmp_clk_register_gate(struct device *dev, const char *name,
+				     u32 clk_id, const char * const *parents,
+				     u8 num_parents, unsigned long flags,
+				     u8 clk_gate_flags)
+{
+	struct zynqmp_clk_gate *gate;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	/* allocate the gate */
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &zynqmp_clk_gate_ops;
+	init.flags = flags;
+	init.parent_names = parents;
+	init.num_parents = num_parents;
+
+	/* struct clk_gate assignments */
+	gate->flags = clk_gate_flags;
+	gate->hw.init = &init;
+	gate->clk_id = clk_id;
+
+	clk = clk_register(dev, &gate->hw);
+
+	if (IS_ERR(clk))
+		kfree(gate);
+
+	return clk;
+}
diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
new file mode 100644
index 0000000..ee36244
--- /dev/null
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -0,0 +1,190 @@
+/*
+ * Zynq UltraScale+ MPSoC mux
+ *
+ *  Copyright (C) 2016-2017 Xilinx
+ *
+ * SPDX-License-Identifier:     GPL-2.0+
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clk/zynqmp.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+
+/*
+ * DOC: basic adjustable multiplexer clock that cannot gate
+ *
+ * Traits of this clock:
+ * prepare - clk_prepare only ensures that parents are prepared
+ * enable - clk_enable only ensures that parents are enabled
+ * rate - rate is only affected by parent switching.  No clk_set_rate support
+ * parent - parent is adjustable through clk_set_parent
+ */
+
+/**
+ * struct zynqmp_clk_mux - multiplexer clock
+ *
+ * @hw: handle between common and hardware-specific interfaces
+ * @flags: hardware-specific flags
+ * @clk_id: Id of clock
+ */
+struct zynqmp_clk_mux {
+	struct clk_hw hw;
+	u8 flags;
+	u32 clk_id;
+};
+
+#define to_zynqmp_clk_mux(_hw) container_of(_hw, struct zynqmp_clk_mux, hw)
+
+/**
+ * zynqmp_clk_mux_get_parent - Get parent of clock
+ * @hw: handle between common and hardware-specific interfaces
+ *
+ * Return: Parent index
+ */
+static u8 zynqmp_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct zynqmp_clk_mux *mux = to_zynqmp_clk_mux(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = mux->clk_id;
+	u32 val;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->clock_getparent)
+		return -ENXIO;
+
+	ret = eemi_ops->clock_getparent(clk_id, &val);
+
+	if (ret)
+		pr_warn_once("%s() getparent failed for clock: %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	if (val && (mux->flags & CLK_MUX_INDEX_BIT))
+		val = ffs(val) - 1;
+
+	if (val && (mux->flags & CLK_MUX_INDEX_ONE))
+		val--;
+
+	return val;
+}
+
+/**
+ * zynqmp_clk_mux_set_parent - Set parent of clock
+ * @hw: handle between common and hardware-specific interfaces
+ * @index: Parent index
+ *
+ * Return: 0 always
+ */
+static int zynqmp_clk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct zynqmp_clk_mux *mux = to_zynqmp_clk_mux(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = mux->clk_id;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->clock_setparent)
+		return -ENXIO;
+
+	if (mux->flags & CLK_MUX_INDEX_BIT)
+		index = 1 << index;
+
+	if (mux->flags & CLK_MUX_INDEX_ONE)
+		index++;
+
+	ret = eemi_ops->clock_setparent(clk_id, index);
+
+	if (ret)
+		pr_warn_once("%s() set parent failed for clock: %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return 0;
+}
+
+const struct clk_ops zynqmp_clk_mux_ops = {
+	.get_parent = zynqmp_clk_mux_get_parent,
+	.set_parent = zynqmp_clk_mux_set_parent,
+	.determine_rate = __clk_mux_determine_rate,
+};
+EXPORT_SYMBOL_GPL(zynqmp_clk_mux_ops);
+
+const struct clk_ops zynqmp_clk_mux_ro_ops = {
+	.get_parent = zynqmp_clk_mux_get_parent,
+};
+EXPORT_SYMBOL_GPL(zynqmp_clk_mux_ro_ops);
+
+/**
+ * zynqmp_clk_register_mux_table - register a mux table with the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @clk_id: Id of this clock
+ * @parent_names: name of this clock's parents
+ * @num_parents: number of parents
+ * @flags: framework-specific flags for this clock
+ * @clk_mux_flags: mux-specific flags for this clock
+ *
+ * Return: clock handle of the registered clock mux
+ */
+struct clk *zynqmp_clk_register_mux_table(struct device *dev, const char *name,
+					  u32 clk_id,
+					  const char * const *parent_names,
+					  u8 num_parents,
+					  unsigned long flags,
+					  u8 clk_mux_flags)
+{
+	struct zynqmp_clk_mux *mux;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	/* allocate the mux */
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	if (clk_mux_flags & CLK_MUX_READ_ONLY)
+		init.ops = &zynqmp_clk_mux_ro_ops;
+	else
+		init.ops = &zynqmp_clk_mux_ops;
+	init.flags = flags;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+
+	/* struct clk_mux assignments */
+	mux->flags = clk_mux_flags;
+	mux->hw.init = &init;
+	mux->clk_id = clk_id;
+
+	clk = clk_register(dev, &mux->hw);
+
+	if (IS_ERR(clk))
+		kfree(mux);
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(zynqmp_clk_register_mux_table);
+
+/**
+ * zynqmp_clk_register_mux - register a mux clock with the clock framework
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @clk_id: Id of this clock
+ * @parent_names: name of this clock's parents
+ * @num_parents: number of parents
+ * @flags: framework-specific flags for this clock
+ * @clk_mux_flags: mux-specific flags for this clock
+ *
+ * Return: clock handle of the registered clock mux
+ */
+struct clk *zynqmp_clk_register_mux(struct device *dev, const char *name,
+				    u32 clk_id, const char **parent_names,
+				    u8 num_parents, unsigned long flags,
+				    u8 clk_mux_flags)
+{
+	return zynqmp_clk_register_mux_table(dev, name, clk_id, parent_names,
+					     num_parents, flags, clk_mux_flags);
+}
+EXPORT_SYMBOL_GPL(zynqmp_clk_register_mux);
diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
new file mode 100644
index 0000000..36bf1c1
--- /dev/null
+++ b/drivers/clk/zynqmp/clkc.c
@@ -0,0 +1,707 @@
+/*
+ * Zynq UltraScale+ MPSoC clock controller
+ *
+ *  Copyright (C) 2016-2017 Xilinx
+ *
+ * SPDX-License-Identifier:     GPL-2.0+
+ *
+ * Based on drivers/clk/zynq/clkc.c
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clk/zynqmp.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#define MAX_PARENT			100
+#define MAX_NODES			6
+#define MAX_NAME_LEN			50
+#define MAX_CLOCK			300
+
+#define CLK_INIT_ENABLE_SHIFT           1
+#define CLK_TYPE_SHIFT                  2
+
+#define PM_API_PAYLOAD_LEN		3
+
+#define NA_PARENT			-1
+#define DUMMY_PARENT			-2
+
+#define CLK_TYPE_FIELD_LEN		4
+#define CLK_TOPOLOGY_NODE_OFFSET	16
+#define NODES_PER_RESP			3
+
+#define CLK_TYPE_FIELD_MASK		0xF
+#define CLK_FLAG_FIELD_SHIFT		8
+#define CLK_FLAG_FIELD_MASK		0x3FFF
+#define CLK_TYPE_FLAG_FIELD_SHIFT	24
+#define CLK_TYPE_FLAG_FIELD_MASK	0xFF
+
+#define CLK_PARENTS_ID_LEN              16
+#define CLK_PARENTS_ID_MASK		0xFFFF
+
+/* Flags for parents */
+#define PARENT_CLK_SELF			0
+#define PARENT_CLK_NODE1		1
+#define PARENT_CLK_NODE2		2
+#define PARENT_CLK_NODE3		3
+#define PARENT_CLK_NODE4		4
+#define PARENT_CLK_EXTERNAL		5
+
+#define END_OF_CLK_NAME			"END_OF_CLK"
+#define RESERVED_CLK_NAME		""
+
+#define CLK_VALID_MASK			0x1
+#define CLK_INIT_ENABLE_MASK		(0x1 << CLK_INIT_ENABLE_SHIFT)
+
+enum clk_type {
+	CLK_TYPE_OUTPUT,
+	CLK_TYPE_EXTERNAL,
+};
+
+/**
+ * struct clock_parent - Structure for parent of clock
+ * @id:	Parent clock ID
+ * @flag: Parent flags
+ */
+struct clock_parent {
+	char name[MAX_NAME_LEN];
+	int id;
+	u32 flag;
+};
+
+/**
+ * struct clock_topology - Structure for topology of clock
+ * @type: Type of topology
+ * @flag: Topology flags
+ * @type_flag: Topology type specific flag
+ */
+struct clock_topology {
+	u32 type;
+	u32 flag;
+	u32 type_flag;
+};
+
+/**
+ * struct zynqmp_clock - Structure for clock
+ * @clk_name: Clock name
+ * @valid: Validity flag of clock
+ * @init_enable: init_enable flag of clock
+ * @topology: structure of topology of clock
+ * @num_node: Number of nodes present in topology
+ * @parent: structure of parent of clock
+ * @num_parents: Number of parents of clock
+ * @type: Type of clock
+ */
+struct zynqmp_clock {
+	char clk_name[MAX_NAME_LEN];
+	u32 valid;
+	u32 init_enable;
+	enum clk_type type;
+	struct clock_topology node[MAX_NODES];
+	u32 num_nodes;
+	struct clock_parent parent[MAX_PARENT];
+	u32 num_parents;
+};
+
+static const char clk_type_postfix[][10] = {
+	[TYPE_INVALID] = "",
+	[TYPE_MUX] = "_mux",
+	[TYPE_GATE] = "",
+	[TYPE_DIV1] = "_div1",
+	[TYPE_DIV2] = "_div2",
+	[TYPE_FIXEDFACTOR] = "_ff",
+	[TYPE_PLL] = ""
+};
+
+static struct zynqmp_clock clock[MAX_CLOCK];
+static struct clk_onecell_data zynqmp_clk_data;
+static struct clk *zynqmp_clks[MAX_CLOCK];
+static unsigned int clock_max_idx;
+static const struct zynqmp_eemi_ops *eemi_ops;
+
+/**
+ * is_valid_clock - Check whether clock is valid or not
+ * @clk_id: Clock Index
+ * @valid: 1: if clock is valid
+ *         0: invalid clock
+ *
+ * Return: 0 Success
+ *         Error code: Failure
+ */
+static int is_valid_clock(u32 clk_id, u32 *valid)
+{
+	if (clk_id < 0 || clk_id > clock_max_idx)
+		return -ENODEV;
+
+	*valid = clock[clk_id].valid;
+
+	return *valid ? 0 : -EINVAL;
+}
+
+/**
+ * zynqmp_get_clock_name - Get name of clock from clock index
+ * @clk_id: Clock index
+ * @clk_name: Name of clock
+ *
+ * Return: 0: Success
+ *         Error code: failure
+ */
+static int zynqmp_get_clock_name(u32 clk_id, char *clk_name)
+{
+	int ret;
+	u32 valid;
+
+	ret = is_valid_clock(clk_id, &valid);
+	if (!ret && valid) {
+		strncpy(clk_name, clock[clk_id].clk_name, MAX_NAME_LEN);
+		return 0;
+	} else {
+		return ret;
+	}
+}
+
+/**
+ * get_clock_type - Get type of clock
+ * @clk_id: Clock Index
+ * @type: Clock type: CLK_TYPE_OUTPUT or CLK_TYPE_EXTERNAL
+ *
+ * Return: 0: Success
+ *         Error code: failure
+ */
+static int get_clock_type(u32 clk_id, u32 *type)
+{
+	int ret;
+	u32 valid;
+
+	ret = is_valid_clock(clk_id, &valid);
+	if (!ret && valid) {
+		*type = clock[clk_id].type;
+		return 0;
+	} else {
+		return ret;
+	}
+}
+
+/**
+ * zynqmp_pm_clock_get_name - Get the name of clock for given id
+ * @clock_id: ID of the clock to be queried
+ * @name: Name of given clock
+ *
+ * This function is used to get name of clock specified by given
+ * clock ID.
+ *
+ * Return: Returns status, in case of error name would be 0.
+ */
+static int zynqmp_pm_clock_get_name(u32 clock_id, char *name)
+{
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	qdata.qid = PM_QID_CLOCK_GET_NAME;
+	qdata.arg1 = clock_id;
+
+	eemi_ops->query_data(qdata, ret_payload);
+	memcpy(name, ret_payload, CLK_GET_NAME_RESP_LEN);
+
+	return 0;
+}
+
+/**
+ * zynqmp_pm_clock_get_topology - Get the topology of clock for given id
+ * @clock_id: ID of the clock to be queried
+ * @index: Node index of clock topology
+ * @topology: Buffer to store nodes in topology and flags
+ *
+ * This function is used to get topology information for the clock
+ * specified by given clock ID.
+ *
+ * This API will return 3 node of topology with a single response. To get
+ * other nodes, master should call same API in loop with new
+ * index till error is returned. E.g First call should have
+ * index 0 which will return nodes 0,1 and 2. Next call, index
+ * should be 3 which will return nodes 3,4 and 5 and so on.
+ *
+ * Return: Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_clock_get_topology(u32 clock_id, u32 index, u32 *topology)
+{
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	qdata.qid = PM_QID_CLOCK_GET_TOPOLOGY;
+	qdata.arg1 = clock_id;
+	qdata.arg2 = index;
+
+	eemi_ops->query_data(qdata, ret_payload);
+	memcpy(topology, &ret_payload[1], CLK_GET_TOPOLOGY_RESP_WORDS * 4);
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
+}
+
+/**
+ * zynqmp_pm_clock_get_fixedfactor_params - Get the clock's fixed factor
+ *					    parameters for fixed clock
+ * @clock_id: Clock ID
+ * @mul: Multiplication value
+ * @div: Divisor value
+ *
+ * This function is used to get fixed factor parameers for the fixed
+ * clock. This API is application only for the fixed clock.
+ *
+ * Return: Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_clock_get_fixedfactor_params(u32 clock_id,
+						  u32 *mul,
+						  u32 *div)
+{
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	qdata.qid = PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS;
+	qdata.arg1 = clock_id;
+
+	eemi_ops->query_data(qdata, ret_payload);
+	*mul = ret_payload[1];
+	*div = ret_payload[2];
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
+}
+
+/**
+ * zynqmp_pm_clock_get_parents - Get the first 3 parents of clock for given id
+ * @clock_id: Clock ID
+ * @index: Parent index
+ * @parents: 3 parents of the given clock
+ *
+ * This function is used to get 3 parents for the clock specified by
+ * given clock ID.
+ *
+ * This API will return 3 parents with a single response. To get
+ * other parents, master should call same API in loop with new
+ * parent index till error is returned. E.g First call should have
+ * index 0 which will return parents 0,1 and 2. Next call, index
+ * should be 3 which will return parent 3,4 and 5 and so on.
+ *
+ * Return: Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_clock_get_parents(u32 clock_id, u32 index, u32 *parents)
+{
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	qdata.qid = PM_QID_CLOCK_GET_PARENTS;
+	qdata.arg1 = clock_id;
+	qdata.arg2 = index;
+
+	eemi_ops->query_data(qdata, ret_payload);
+	memcpy(parents, &ret_payload[1], CLK_GET_PARENTS_RESP_WORDS * 4);
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
+}
+
+/**
+ * zynqmp_pm_clock_get_attributes - Get the attributes of clock for given id
+ * @clock_id: Clock ID
+ * @attributes: Clock attributes
+ *
+ * This function is used to get clock's attributes(e.g. valid, clock type, etc).
+ *
+ * Return: Returns status, either success or error+reason.
+ */
+static int zynqmp_pm_clock_get_attributes(u32 clock_id, u32 *attr)
+{
+	struct zynqmp_pm_query_data qdata = {0};
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+
+	qdata.qid = PM_QID_CLOCK_GET_ATTRIBUTES;
+	qdata.arg1 = clock_id;
+
+	eemi_ops->query_data(qdata, ret_payload);
+	memcpy(attr, &ret_payload[1], CLK_GET_ATTR_RESP_WORDS * 4);
+
+	return zynqmp_pm_ret_code((enum pm_ret_status)ret_payload[0]);
+}
+
+/**
+ * clock_get_topology: Get topology of clock from firmware using PM_API
+ * @clk_id: Clock Index
+ * @clk_topology: Structure of clock topology
+ * @num_nodes: number of nodes
+ *
+ * Return: 0: Success
+ *         Error Code: Failure
+ */
+static int clock_get_topology(u32 clk_id, struct clock_topology *clk_topology,
+			      u32 *num_nodes)
+{
+	int j, k = 0, ret;
+	u32 pm_resp[PM_API_PAYLOAD_LEN] = {0};
+
+	*num_nodes = 0;
+	for (j = 0; j <= MAX_NODES; j += 3) {
+		ret = zynqmp_pm_clock_get_topology(clk_id, j, pm_resp);
+		if (ret)
+			return ret;
+		for (k = 0; k < PM_API_PAYLOAD_LEN; k++) {
+			if (!(pm_resp[k] & CLK_TYPE_FIELD_MASK))
+				goto done;
+			clk_topology[*num_nodes].type = pm_resp[k] &
+							CLK_TYPE_FIELD_MASK;
+			clk_topology[*num_nodes].flag =
+					(pm_resp[k] >> CLK_FLAG_FIELD_SHIFT) &
+					CLK_FLAG_FIELD_MASK;
+			clk_topology[*num_nodes].type_flag =
+				(pm_resp[k] >> CLK_TYPE_FLAG_FIELD_SHIFT) &
+				CLK_TYPE_FLAG_FIELD_MASK;
+			(*num_nodes)++;
+		}
+	}
+done:
+	return 0;
+}
+
+/**
+ * clock_get_parents: Get parents info from firmware using PM_API
+ * @clk_id: Clock Index
+ * @parent: Structure of parent information
+ * @num_parents: Total number of parents
+ *
+ * Return: 0: Success
+ *         Error code: Failure
+ */
+static int clock_get_parents(u32 clk_id, struct clock_parent *parents,
+			     u32 *num_parents)
+{
+	int j = 0, k, ret, total_parents = 0;
+	u32 pm_resp[PM_API_PAYLOAD_LEN] = {0};
+
+	do {
+		/* Get parents from firmware */
+		ret = zynqmp_pm_clock_get_parents(clk_id, j, pm_resp);
+		if (ret)
+			return ret;
+
+		for (k = 0; k < PM_API_PAYLOAD_LEN; k++) {
+			if (pm_resp[k] == (u32)NA_PARENT) {
+				*num_parents = total_parents;
+				return 0;
+			}
+
+			parents[k + j].id = pm_resp[k] & CLK_PARENTS_ID_MASK;
+			if (parents[k + j].id == DUMMY_PARENT) {
+				strncpy(parents[k + j].name,
+					"dummy_name", MAX_NAME_LEN);
+				parents[k + j].flag = 0;
+			} else {
+				parents[k + j].flag = pm_resp[k] >>
+							CLK_PARENTS_ID_LEN;
+				if (zynqmp_get_clock_name(parents[k + j].id,
+							  parents[k + j].name))
+					continue;
+			}
+			total_parents++;
+		}
+		j += PM_API_PAYLOAD_LEN;
+	} while (total_parents <= MAX_PARENT);
+	return 0;
+}
+
+/**
+ * get_parent_list: Create list of parents name
+ * @np:		Device node
+ * @clk_id: Clock Index
+ * @parent_list List of parent's name
+ * @num_parents: Total number of parents
+ *
+ # Return: 0: Success
+ *         Error code: Failure
+ */
+static int get_parent_list(struct device_node *np, u32 clk_id,
+			   const char **parent_list, u32 *num_parents)
+{
+	int i = 0, ret;
+	u32 total_parents = clock[clk_id].num_parents;
+	struct clock_topology *clk_nodes;
+	struct clock_parent *parents;
+
+	clk_nodes = clock[clk_id].node;
+	parents = clock[clk_id].parent;
+
+	for (i = 0; i < total_parents; i++) {
+		if (!parents[i].flag) {
+			parent_list[i] = parents[i].name;
+		} else if (parents[i].flag == PARENT_CLK_EXTERNAL) {
+			ret = of_property_match_string(np, "clock-names",
+						       parents[i].name);
+			if (ret < 0)
+				strncpy(parents[i].name,
+					"dummy_name", MAX_NAME_LEN);
+			parent_list[i] = parents[i].name;
+		} else {
+			strcat(parents[i].name,
+			       clk_type_postfix[clk_nodes[parents[i].flag - 1].
+			       type]);
+			parent_list[i] = parents[i].name;
+		}
+	}
+
+	*num_parents = total_parents;
+	return 0;
+}
+
+/**
+ * zynqmp_register_clk_topology: Register clock topology
+ * @clk_id: Clock Index
+ * @clk_name: Clock Name
+ * @num_parents: Total number of parents
+ * @parent_names: List of parents name
+ *
+ * Return: 0: Success
+ *         Error code: Failure
+ */
+static struct clk *zynqmp_register_clk_topology(int clk_id, char *clk_name,
+						int num_parents,
+						const char **parent_names)
+{
+	int j, ret;
+	u32 num_nodes, mult, div;
+	char *clk_out = NULL;
+	struct clock_topology *nodes;
+	struct clk *clk = NULL;
+
+	nodes = clock[clk_id].node;
+	num_nodes = clock[clk_id].num_nodes;
+
+	for (j = 0; j < num_nodes; j++) {
+		if (j != (num_nodes - 1)) {
+			clk_out = kasprintf(GFP_KERNEL, "%s%s", clk_name,
+					    clk_type_postfix[nodes[j].type]);
+		} else {
+			clk_out = kasprintf(GFP_KERNEL, "%s", clk_name);
+		}
+
+		switch (nodes[j].type) {
+		case TYPE_MUX:
+			clk = zynqmp_clk_register_mux(NULL, clk_out,
+						      clk_id, parent_names,
+						      num_parents,
+						      nodes[j].flag,
+						      nodes[j].type_flag);
+			break;
+		case TYPE_PLL:
+			clk = clk_register_zynqmp_pll(clk_out, clk_id,
+						      parent_names, 1,
+						      nodes[j].flag);
+			break;
+		case TYPE_FIXEDFACTOR:
+			ret = zynqmp_pm_clock_get_fixedfactor_params(clk_id,
+								     &mult,
+								     &div);
+			clk = clk_register_fixed_factor(NULL, clk_out,
+							parent_names[0],
+							nodes[j].flag, mult,
+							div);
+			break;
+		case TYPE_DIV1:
+		case TYPE_DIV2:
+			clk = zynqmp_clk_register_divider(NULL, clk_out, clk_id,
+							  nodes[j].type,
+							  parent_names, 1,
+							  nodes[j].flag,
+							  nodes[j].type_flag);
+			break;
+		case TYPE_GATE:
+			clk = zynqmp_clk_register_gate(NULL, clk_out, clk_id,
+						       parent_names, 1,
+						       nodes[j].flag,
+						       nodes[j].type_flag);
+			break;
+		default:
+			pr_err("%s() Unknown topology for %s\n",
+			       __func__, clk_out);
+			break;
+		}
+		if (IS_ERR(clk))
+			pr_warn_once("%s() %s register fail with %ld\n",
+				     __func__, clk_name, PTR_ERR(clk));
+
+		parent_names[0] = clk_out;
+	}
+	kfree(clk_out);
+	return clk;
+}
+
+/**
+ * zynqmp_register_clocks: Register clocks
+ * @np: Device node
+ *
+ * Return: 0: Success
+ *         Error code: failure
+ */
+static int zynqmp_register_clocks(struct device_node *np)
+{
+	int ret;
+	u32 i, total_parents = 0, type = 0;
+	const char *parent_names[MAX_PARENT];
+
+	for (i = 0; i < clock_max_idx; i++) {
+		char clk_name[MAX_NAME_LEN];
+
+		/* get clock name, continue to next clock if name not found */
+		if (zynqmp_get_clock_name(i, clk_name))
+			continue;
+
+		/* Check if clock is valid and output clock.
+		 * Do not regiter invalid or external clock.
+		 */
+		ret = get_clock_type(i, &type);
+		if (ret || type != CLK_TYPE_OUTPUT)
+			continue;
+
+		/* Get parents of clock*/
+		if (get_parent_list(np, i, parent_names, &total_parents)) {
+			WARN_ONCE(1, "No parents found for %s\n",
+				  clock[i].clk_name);
+			continue;
+		}
+
+		zynqmp_clks[i] = zynqmp_register_clk_topology(i, clk_name,
+							      total_parents,
+							      parent_names);
+
+		/* Enable clock if init_enable flag is 1 */
+		if (clock[i].init_enable)
+			clk_prepare_enable(zynqmp_clks[i]);
+	}
+
+	for (i = 0; i < clock_max_idx; i++) {
+		if (IS_ERR(zynqmp_clks[i])) {
+			pr_err("Zynq Ultrascale+ MPSoC clk %s: register failed with %ld\n",
+			       clock[i].clk_name, PTR_ERR(zynqmp_clks[i]));
+			WARN_ON(1);
+		}
+	}
+	return 0;
+}
+
+/**
+ * zynqmp_get_clock_info - Get clock information from firmware using PM_API
+ */
+static void zynqmp_get_clock_info(void)
+{
+	int i, ret;
+	u32 attr, type = 0;
+
+	memset(clock, 0, sizeof(clock));
+	for (i = 0; i < MAX_CLOCK; i++) {
+		zynqmp_pm_clock_get_name(i, clock[i].clk_name);
+		if (!strncmp(clock[i].clk_name, END_OF_CLK_NAME,
+			     MAX_NAME_LEN)) {
+			clock_max_idx = i;
+			break;
+		} else if (!strncmp(clock[i].clk_name, RESERVED_CLK_NAME,
+				    MAX_NAME_LEN)) {
+			continue;
+		}
+
+		ret = zynqmp_pm_clock_get_attributes(i, &attr);
+		if (ret)
+			continue;
+
+		clock[i].valid = attr & CLK_VALID_MASK;
+		clock[i].init_enable = !!(attr & CLK_INIT_ENABLE_MASK);
+		clock[i].type = attr >> CLK_TYPE_SHIFT ? CLK_TYPE_EXTERNAL :
+							CLK_TYPE_OUTPUT;
+	}
+
+	/* Get topology of all clock */
+	for (i = 0; i < clock_max_idx; i++) {
+		ret = get_clock_type(i, &type);
+		if (ret || type != CLK_TYPE_OUTPUT)
+			continue;
+
+		ret = clock_get_topology(i, clock[i].node, &clock[i].num_nodes);
+		if (ret)
+			continue;
+
+		ret = clock_get_parents(i, clock[i].parent,
+					&clock[i].num_parents);
+		if (ret)
+			continue;
+	}
+}
+
+/**
+ * zynqmp_clk_setup -  Setup the clock framework and register clocks
+ * @np: Device node
+ */
+static void __init zynqmp_clk_setup(struct device_node *np)
+{
+	int idx;
+
+	idx = of_property_match_string(np, "clock-names", "pss_ref_clk");
+	if (idx < 0) {
+		pr_err("pss_ref_clk not provided\n");
+		return;
+	}
+	idx = of_property_match_string(np, "clock-names", "video_clk");
+	if (idx < 0) {
+		pr_err("video_clk not provided\n");
+		return;
+	}
+	idx = of_property_match_string(np, "clock-names", "pss_alt_ref_clk");
+	if (idx < 0) {
+		pr_err("pss_alt_ref_clk not provided\n");
+		return;
+	}
+	idx = of_property_match_string(np, "clock-names", "aux_ref_clk");
+	if (idx < 0) {
+		pr_err("aux_ref_clk not provided\n");
+		return;
+	}
+	idx = of_property_match_string(np, "clock-names", "gt_crx_ref_clk");
+	if (idx < 0) {
+		pr_err("aux_ref_clk not provided\n");
+		return;
+	}
+
+	zynqmp_get_clock_info();
+	zynqmp_register_clocks(np);
+
+	zynqmp_clk_data.clks = zynqmp_clks;
+	zynqmp_clk_data.clk_num = clock_max_idx;
+	of_clk_add_provider(np, of_clk_src_onecell_get, &zynqmp_clk_data);
+}
+
+/**
+ * zynqmp_clock_init -  Initialize zynqmp clocks
+ *
+ * Return: 0 always
+ */
+static int __init zynqmp_clock_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-clkc");
+	if (!np) {
+		pr_err("%s: clkc node not found\n", __func__);
+		of_node_put(np);
+		return 0;
+	}
+
+	eemi_ops = get_eemi_ops();
+	if (!eemi_ops || !eemi_ops->query_data) {
+		pr_err("%s: clk data not found\n", __func__);
+		of_node_put(np);
+		return 0;
+	}
+
+	zynqmp_clk_setup(np);
+
+	return 0;
+}
+arch_initcall(zynqmp_clock_init);
diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
new file mode 100644
index 0000000..1a1473c
--- /dev/null
+++ b/drivers/clk/zynqmp/divider.c
@@ -0,0 +1,239 @@
+/*
+ * Zynq UltraScale+ MPSoC Divider support
+ *
+ *  Copyright (C) 2016-2017 Xilinx
+ *
+ * SPDX-License-Identifier:     GPL-2.0+
+ *
+ * Adjustable divider clock implementation
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clk/zynqmp.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <linux/log2.h>
+
+/*
+ * DOC: basic adjustable divider clock that cannot gate
+ *
+ * Traits of this clock:
+ * prepare - clk_prepare only ensures that parents are prepared
+ * enable - clk_enable only ensures that parents are enabled
+ * rate - rate is adjustable.  clk->rate = ceiling(parent->rate / divisor)
+ * parent - fixed parent.  No clk_set_parent support
+ */
+
+#define to_zynqmp_clk_divider(_hw)		\
+	container_of(_hw, struct zynqmp_clk_divider, hw)
+
+/**
+ * struct zynqmp_clk_divider - adjustable divider clock
+ *
+ * @hw:	handle between common and hardware-specific interfaces
+ * @flags: Hardware specific flags
+ * @clk_id: Id of clock
+ * @div_type: divisor type (TYPE_DIV1 or TYPE_DIV2)
+ */
+struct zynqmp_clk_divider {
+	struct clk_hw hw;
+	u8 flags;
+	u32 clk_id;
+	u32 div_type;
+};
+
+static int zynqmp_divider_get_val(unsigned long parent_rate, unsigned long rate)
+{
+	return DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+}
+
+static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
+						    unsigned long parent_rate)
+{
+	struct zynqmp_clk_divider *divider = to_zynqmp_clk_divider(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = divider->clk_id;
+	u32 div_type = divider->div_type;
+	u32 div, value;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->clock_getdivider)
+		return -ENXIO;
+
+	ret = eemi_ops->clock_getdivider(clk_id, &div);
+
+	if (ret)
+		pr_warn_once("%s() get divider failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	if (div_type == TYPE_DIV1)
+		value = div & 0xFFFF;
+	else
+		value = (div >> 16) & 0xFFFF;
+
+	return zynqmp_divider_get_val((u64)parent_rate, value);
+}
+
+static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
+					  unsigned long rate,
+					  unsigned long *prate)
+{
+	struct zynqmp_clk_divider *divider = to_zynqmp_clk_divider(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = divider->clk_id;
+	u32 div_type = divider->div_type;
+	u32 bestdiv;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->clock_getdivider)
+		return -ENXIO;
+
+	/* if read only, just return current value */
+	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
+		ret = eemi_ops->clock_getdivider(clk_id, &bestdiv);
+
+		if (ret)
+			pr_warn_once("%s() get divider failed for %s, ret = %d\n",
+				     __func__, clk_name, ret);
+		if (div_type == TYPE_DIV1)
+			bestdiv = bestdiv & 0xFFFF;
+		else
+			bestdiv  = (bestdiv >> 16) & 0xFFFF;
+
+		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
+	}
+
+	bestdiv = zynqmp_divider_get_val(*prate, rate);
+
+	if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) &&
+	    ((clk_hw_get_flags(hw) & CLK_FRAC)))
+		bestdiv = rate % *prate ? 1 : bestdiv;
+	*prate = rate * bestdiv;
+
+	return rate;
+}
+
+/**
+ * zynqmp_clk_divider_set_rate - Set rate of divider clock
+ * @hw:	handle between common and hardware-specific interfaces
+ * @rate: rate of clock to be set
+ * @parent_rate: rate of parent clock
+ *
+ * Return: 0 always
+ */
+static int zynqmp_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long parent_rate)
+{
+	struct zynqmp_clk_divider *divider = to_zynqmp_clk_divider(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = divider->clk_id;
+	u32 div_type = divider->div_type;
+	u32 value, div;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->clock_setdivider)
+		return -ENXIO;
+
+	value = zynqmp_divider_get_val(parent_rate, rate);
+	if (div_type == TYPE_DIV1) {
+		div = value & 0xFFFF;
+		div |= ((u16)-1) << 16;
+	} else {
+		div = ((u16)-1);
+		div |= value << 16;
+	}
+
+	ret = eemi_ops->clock_setdivider(clk_id, div);
+
+	if (ret)
+		pr_warn_once("%s() set divider failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return 0;
+}
+
+static const struct clk_ops zynqmp_clk_divider_ops = {
+	.recalc_rate = zynqmp_clk_divider_recalc_rate,
+	.round_rate = zynqmp_clk_divider_round_rate,
+	.set_rate = zynqmp_clk_divider_set_rate,
+};
+
+/**
+ * _register_divider - register a divider clock
+ * @dev: device registering this clock
+ * @name: name of this clock
+ * @clk_id: Id of clock
+ * @div_type: Type of divisor
+ * @parents: name of clock's parents
+ * @num_parents: number of parents
+ * @flags: framework-specific flags
+ * @clk_divider_flags: divider-specific flags for this clock
+ *
+ * Return: handle to registered clock divider
+ */
+static struct clk *_register_divider(struct device *dev, const char *name,
+				     u32 clk_id, u32 div_type,
+				     const char * const *parents,
+				     u8 num_parents, unsigned long flags,
+				     u8 clk_divider_flags)
+{
+	struct zynqmp_clk_divider *div;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	/* allocate the divider */
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &zynqmp_clk_divider_ops;
+	init.flags = flags;
+	init.parent_names = parents;
+	init.num_parents = num_parents;
+
+	/* struct clk_divider assignments */
+	div->flags = clk_divider_flags;
+	div->hw.init = &init;
+	div->clk_id = clk_id;
+	div->div_type = div_type;
+
+	/* register the clock */
+	clk = clk_register(dev, &div->hw);
+
+	if (IS_ERR(clk))
+		kfree(div);
+
+	return clk;
+}
+
+/**
+ * zynqmp_clk_register_divider - register a divider clock
+ * @dev: device registering this clock
+ * @name: name of this clock
+ * @clk_id: Id of clock
+ * @div_type: Type of divisor
+ * @parents: name of clock's parents
+ * @num_parents: number of parents
+ * @flags: framework-specific flags
+ * @clk_divider_flags: divider-specific flags for this clock
+ *
+ * Return: handle to registered clock divider
+ */
+struct clk *zynqmp_clk_register_divider(struct device *dev, const char *name,
+					u32 clk_id, u32 div_type,
+					const char * const *parents,
+					u8 num_parents, unsigned long flags,
+					u8 clk_divider_flags)
+{
+	return _register_divider(dev, name, clk_id, div_type, parents,
+				 num_parents, flags, clk_divider_flags);
+}
+EXPORT_SYMBOL_GPL(zynqmp_clk_register_divider);
diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
new file mode 100644
index 0000000..75def21
--- /dev/null
+++ b/drivers/clk/zynqmp/pll.c
@@ -0,0 +1,384 @@
+/*
+ * Zynq UltraScale+ MPSoC PLL driver
+ *
+ *  Copyright (C) 2016-2017 Xilinx
+ *
+ * SPDX-License-Identifier:     GPL-2.0+
+ */
+#include <linux/clk.h>
+#include <linux/clk/zynqmp.h>
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+
+/**
+ * struct zynqmp_pll - Structure for PLL clock
+ * @hw:		Handle between common and hardware-specific interfaces
+ * @clk_id:	PLL clock ID
+ */
+struct zynqmp_pll {
+	struct clk_hw hw;
+	u32 clk_id;
+};
+
+#define to_zynqmp_pll(_hw)	container_of(_hw, struct zynqmp_pll, hw)
+
+/* Register bitfield defines */
+#define PLLCTRL_FBDIV_MASK	0x7f00
+#define PLLCTRL_FBDIV_SHIFT	8
+#define PLLCTRL_BP_MASK		BIT(3)
+#define PLLCTRL_DIV2_MASK	BIT(16)
+#define PLLCTRL_RESET_MASK	1
+#define PLLCTRL_RESET_VAL	1
+#define PLL_STATUS_LOCKED	1
+#define PLLCTRL_RESET_SHIFT	0
+#define PLLCTRL_DIV2_SHIFT	16
+
+#define PLL_FBDIV_MIN	25
+#define PLL_FBDIV_MAX	125
+
+#define PS_PLL_VCO_MIN 1500000000
+#define PS_PLL_VCO_MAX 3000000000UL
+
+enum pll_mode {
+	PLL_MODE_INT,
+	PLL_MODE_FRAC,
+};
+
+#define FRAC_OFFSET 0x8
+#define PLLFCFG_FRAC_EN	BIT(31)
+#define FRAC_DIV  0x10000  /* 2^16 */
+
+/**
+ * pll_get_mode - Get mode of PLL
+ * @hw: Handle between common and hardware-specific interfaces
+ *
+ * Return: Mode of PLL
+ */
+static inline enum pll_mode pll_get_mode(struct clk_hw *hw)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	u32 clk_id = clk->clk_id;
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->ioctl)
+		return -ENXIO;
+
+	ret = eemi_ops->ioctl(0, IOCTL_GET_PLL_FRAC_MODE, clk_id, 0,
+			      ret_payload);
+	if (ret)
+		pr_warn_once("%s() PLL get frac mode failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return ret_payload[1];
+}
+
+/**
+ * pll_set_mode - Set the PLL mode
+ * @hw:		Handle between common and hardware-specific interfaces
+ * @on:		Flag to determine the mode
+ */
+static inline void pll_set_mode(struct clk_hw *hw, bool on)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	u32 clk_id = clk->clk_id;
+	const char *clk_name = clk_hw_get_name(hw);
+	int ret;
+	u32 mode;
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->ioctl) {
+		pr_warn_once("eemi_ops not found\n");
+		return;
+	}
+
+	if (on)
+		mode = PLL_MODE_FRAC;
+	else
+		mode = PLL_MODE_INT;
+
+	ret = eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_MODE, clk_id, mode, NULL);
+	if (ret)
+		pr_warn_once("%s() PLL set frac mode failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+}
+
+/**
+ * zynqmp_pll_round_rate - Round a clock frequency
+ * @hw:		Handle between common and hardware-specific interfaces
+ * @rate:	Desired clock frequency
+ * @prate:	Clock frequency of parent clock
+ *
+ * Return:	Frequency closest to @rate the hardware can generate
+ */
+static long zynqmp_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long *prate)
+{
+	u32 fbdiv;
+	long rate_div, f;
+
+	/* Enable the fractional mode if needed */
+	rate_div = ((rate * FRAC_DIV) / *prate);
+	f = rate_div % FRAC_DIV;
+	pll_set_mode(hw, !!f);
+
+	if (pll_get_mode(hw) == PLL_MODE_FRAC) {
+		if (rate > PS_PLL_VCO_MAX) {
+			fbdiv = rate / PS_PLL_VCO_MAX;
+			rate = rate / (fbdiv + 1);
+		}
+		if (rate < PS_PLL_VCO_MIN) {
+			fbdiv = DIV_ROUND_UP(PS_PLL_VCO_MIN, rate);
+			rate = rate * fbdiv;
+		}
+		return rate;
+	}
+
+	fbdiv = DIV_ROUND_CLOSEST(rate, *prate);
+	fbdiv = clamp_t(u32, fbdiv, PLL_FBDIV_MIN, PLL_FBDIV_MAX);
+	return *prate * fbdiv;
+}
+
+/**
+ * zynqmp_pll_recalc_rate - Recalculate clock frequency
+ * @hw:			Handle between common and hardware-specific interfaces
+ * @parent_rate:	Clock frequency of parent clock
+ * Return:		Current clock frequency
+ */
+static unsigned long zynqmp_pll_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	u32 clk_id = clk->clk_id;
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 fbdiv, data;
+	unsigned long rate, frac;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->clock_getdivider)
+		return 0;
+
+	/*
+	 * makes probably sense to redundantly save fbdiv in the struct
+	 * zynqmp_pll to save the IO access.
+	 */
+	ret = eemi_ops->clock_getdivider(clk_id, &fbdiv);
+	if (ret)
+		pr_warn_once("%s() get divider failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	rate =  parent_rate * fbdiv;
+	if (pll_get_mode(hw) == PLL_MODE_FRAC) {
+		eemi_ops->ioctl(0, IOCTL_GET_PLL_FRAC_DATA, clk_id, 0,
+				ret_payload);
+		data = ret_payload[1];
+		frac = (parent_rate * data) / FRAC_DIV;
+		rate = rate + frac;
+	}
+
+	return rate;
+}
+
+/**
+ * zynqmp_pll_set_rate - Set rate of PLL
+ * @hw:			Handle between common and hardware-specific interfaces
+ * @rate:		Frequency of clock to be set
+ * @parent_rate:	Clock frequency of parent clock
+ */
+static int zynqmp_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	u32 clk_id = clk->clk_id;
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 fbdiv, data;
+	long rate_div, frac, m, f;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->clock_setdivider)
+		return -ENXIO;
+
+	if (pll_get_mode(hw) == PLL_MODE_FRAC) {
+		unsigned int children;
+
+		/*
+		 * We're running on a ZynqMP compatible machine, make sure the
+		 * VPLL only has one child.
+		 */
+		children = clk_get_children("vpll");
+
+		/* Account for vpll_to_lpd and dp_video_ref */
+		if (children > 2)
+			WARN(1, "Two devices are using vpll which is forbidden\n");
+
+		rate_div = ((rate * FRAC_DIV) / parent_rate);
+		m = rate_div / FRAC_DIV;
+		f = rate_div % FRAC_DIV;
+		m = clamp_t(u32, m, (PLL_FBDIV_MIN), (PLL_FBDIV_MAX));
+		rate = parent_rate * m;
+		frac = (parent_rate * f) / FRAC_DIV;
+
+		ret = eemi_ops->clock_setdivider(clk_id, m);
+		if (ret)
+			pr_warn_once("%s() set divider failed for %s, ret = %d\n",
+				     __func__, clk_name, ret);
+
+		data = (FRAC_DIV * f) / FRAC_DIV;
+		eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_DATA, clk_id, data, NULL);
+
+		return (rate + frac);
+	}
+
+	fbdiv = DIV_ROUND_CLOSEST(rate, parent_rate);
+	fbdiv = clamp_t(u32, fbdiv, PLL_FBDIV_MIN, PLL_FBDIV_MAX);
+	ret = eemi_ops->clock_setdivider(clk_id, fbdiv);
+	if (ret)
+		pr_warn_once("%s() set divider failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return parent_rate * fbdiv;
+}
+
+/**
+ * zynqmp_pll_is_enabled - Check if a clock is enabled
+ * @hw:		Handle between common and hardware-specific interfaces
+ *
+ * Return:	1 if the clock is enabled, 0 otherwise
+ */
+static int zynqmp_pll_is_enabled(struct clk_hw *hw)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = clk->clk_id;
+	unsigned int state;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->clock_getstate)
+		return 0;
+
+	ret = eemi_ops->clock_getstate(clk_id, &state);
+	if (ret)
+		pr_warn_once("%s() clock get state failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return state ? 1 : 0;
+}
+
+/**
+ * zynqmp_pll_enable - Enable clock
+ * @hw:		Handle between common and hardware-specific interfaces
+ *
+ * Return:	0 always
+ */
+static int zynqmp_pll_enable(struct clk_hw *hw)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = clk->clk_id;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->clock_enable)
+		return 0;
+
+	if (zynqmp_pll_is_enabled(hw))
+		return 0;
+
+	pr_info("PLL: enable\n");
+
+	ret = eemi_ops->clock_enable(clk_id);
+	if (ret)
+		pr_warn_once("%s() clock enable failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+
+	return 0;
+}
+
+/**
+ * zynqmp_pll_disable - Disable clock
+ * @hw:		Handle between common and hardware-specific interfaces
+ *
+ */
+static void zynqmp_pll_disable(struct clk_hw *hw)
+{
+	struct zynqmp_pll *clk = to_zynqmp_pll(hw);
+	const char *clk_name = clk_hw_get_name(hw);
+	u32 clk_id = clk->clk_id;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->clock_disable)
+		return;
+
+	if (!zynqmp_pll_is_enabled(hw))
+		return;
+
+	pr_info("PLL: shutdown\n");
+
+	ret = eemi_ops->clock_disable(clk_id);
+	if (ret)
+		pr_warn_once("%s() clock disable failed for %s, ret = %d\n",
+			     __func__, clk_name, ret);
+}
+
+static const struct clk_ops zynqmp_pll_ops = {
+	.enable = zynqmp_pll_enable,
+	.disable = zynqmp_pll_disable,
+	.is_enabled = zynqmp_pll_is_enabled,
+	.round_rate = zynqmp_pll_round_rate,
+	.recalc_rate = zynqmp_pll_recalc_rate,
+	.set_rate = zynqmp_pll_set_rate,
+};
+
+/**
+ * clk_register_zynqmp_pll - Register PLL with the clock framework
+ * @name:	PLL name
+ * @flag:	PLL flags
+ * @parents:	Parent clock names
+ * @num_parents:Number of parents
+ * @pll_ctrl:	Pointer to PLL control register
+ * @pll_status:	Pointer to PLL status register
+ * @lock_index:	Bit index to this PLL's lock status bit in @pll_status
+ *
+ * Return:	Handle to the registered clock
+ */
+struct clk *clk_register_zynqmp_pll(const char *name, u32 clk_id,
+				    const char * const *parents,
+				    u8 num_parents, unsigned long flag)
+{
+	struct zynqmp_pll *pll;
+	struct clk *clk;
+	struct clk_init_data init;
+	int status;
+
+	init.name = name;
+	init.ops = &zynqmp_pll_ops;
+	init.flags = flag;
+	init.parent_names = parents;
+	init.num_parents = num_parents;
+
+	pll = kmalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	/* Populate the struct */
+	pll->hw.init = &init;
+	pll->clk_id = clk_id;
+
+	clk = clk_register(NULL, &pll->hw);
+	if (WARN_ON(IS_ERR(clk)))
+		kfree(pll);
+
+	status = clk_set_rate_range(clk, PS_PLL_VCO_MIN, PS_PLL_VCO_MAX);
+	if (status < 0)
+		pr_err("%s:ERROR clk_set_rate_range failed %d\n", name, status);
+
+	return clk;
+}
diff --git a/include/linux/clk/zynqmp.h b/include/linux/clk/zynqmp.h
new file mode 100644
index 0000000..024ebf8
--- /dev/null
+++ b/include/linux/clk/zynqmp.h
@@ -0,0 +1,46 @@
+/*
+ *  Copyright (C) 2016-2017 Xilinx
+ *
+ * SPDX-License-Identifier:     GPL-2.0+
+ */
+
+#ifndef __LINUX_CLK_ZYNQMP_H_
+#define __LINUX_CLK_ZYNQMP_H_
+
+#include <linux/spinlock.h>
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+
+#define CLK_FRAC	BIT(13) /* has a fractional parent */
+
+struct device;
+
+struct clk *clk_register_zynqmp_pll(const char *name, u32 clk_id,
+				    const char * const *parent, u8 num_parents,
+				    unsigned long flag);
+
+struct clk *zynqmp_clk_register_gate(struct device *dev, const char *name,
+				     u32 clk_id,
+				     const char * const *parent_name,
+				     u8 num_parents, unsigned long flags,
+				     u8 clk_gate_flags);
+
+struct clk *zynqmp_clk_register_divider(struct device *dev, const char *name,
+					u32 clk_id, u32 div_type,
+					const char * const *parent_name,
+					u8 num_parents,
+					unsigned long flags,
+					u8 clk_divider_flags);
+
+struct clk *zynqmp_clk_register_mux(struct device *dev, const char *name,
+				    u32 clk_id,
+				    const char **parent_names,
+				    u8 num_parents, unsigned long flags,
+				    u8 clk_mux_flags);
+
+struct clk *zynqmp_clk_register_mux_table(struct device *dev, const char *name,
+					  u32 clk_id,
+					  const char * const *parent_names,
+					  u8 num_parents, unsigned long flags,
+					  u8 clk_mux_flags);
+
+#endif
-- 
2.7.4
