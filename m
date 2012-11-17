From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 17 Nov 2012 15:22:26 +0100
Subject: [PATCH v2 5/9] clk: mvebu: add clock gating control provider for DT
In-Reply-To: <1353162150-522-1-git-send-email-andrew@lunn.ch>
References: <1353162150-522-1-git-send-email-andrew@lunn.ch>
Message-ID: <1353162150-522-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

This driver allows to provide DT clocks for clock gates found on
Marvell Dove and Kirkwood SoCs. The clock gates are referenced by
the phandle index of the corresponding bit in the clock gating control
register to ease lookup in the datasheet.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 .../bindings/clock/mvebu-gated-clock.txt           |   76 +++++++++
 drivers/clk/mvebu/Kconfig                          |    2 +
 drivers/clk/mvebu/Makefile                         |    1 +
 drivers/clk/mvebu/clk-gating-ctrl.c                |  177 ++++++++++++++++++++
 include/linux/clk/mvebu.h                          |    1 +
 5 files changed, 257 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
 create mode 100644 drivers/clk/mvebu/clk-gating-ctrl.c

diff --git a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
new file mode 100644
index 0000000..4ad8ccd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
@@ -0,0 +1,76 @@
+* Gated Clock bindings for Marvell Orion SoCs
+
+Marvell Dove and Kirkwood allow some peripheral clocks to be gated to save
+some power. The clock consumer should specify the desired clock by having
+the clock ID in its "clocks" phandle cell. The clock ID is directly mapped to
+the corresponding clock gating control bit in HW to ease manual clock lookup
+in datasheet.
+
+The following is a list of provided IDs for Dove:
+ID	Clock	Peripheral
+-----------------------------------
+0	usb0	USB Host 0
+1	usb1	USB Host 1
+2	ge	Gigabit Ethernet
+3	sata	SATA Host
+4	pex0	PCIe Cntrl 0
+5	pex1	PCIe Cntrl 1
+8	sdio0	SDHCI Host 0
+9	sdio1	SDHCI Host 1
+10	nand	NAND Cntrl
+11	camera	Camera Cntrl
+12	i2s0	I2S Cntrl 0
+13	i2s1	I2S Cntrl 1
+15	crypto	CESA engine
+21	ac97	AC97 Cntrl
+22	pdma	Peripheral DMA
+23	xor0	XOR DMA 0
+24	xor1	XOR DMA 1
+30	gephy	Gigabit Ethernel PHY
+Note: gephy(30) is implemented as a parent clock of ge(2)
+
+The following is a list of provided IDs for Kirkwood:
+ID	Clock	Peripheral
+-----------------------------------
+0	ge0	Gigabit Ethernet 0
+2	pex0	PCIe Cntrl 0
+3	usb0	USB Host 0
+4	sdio	SDIO Cntrl
+5	tsu	Transp. Stream Unit
+6	dunit	SDRAM Cntrl
+7	runit	Runit
+8	xor0	XOR DMA 0
+9	audio	I2S Cntrl 0
+14	sata0	SATA Host 0
+15	sata1	SATA Host 1
+16	xor1	XOR DMA 1
+17	crypto	CESA engine
+18	pex1	PCIe Cntrl 1
+19	ge1	Gigabit Ethernet 0
+20	tdm	Time Division Mplx
+
+Required properties:
+- compatible : shall be one of the following:
+	"marvell,dove-gating-clock" - for Dove SoC clock gating
+	"marvell,kirkwood-gating-clock" - for Kirkwood SoC clock gating
+- reg : shall be the register address of the Clock Gating Control register
+- #clock-cells : from common clock binding; shall be set to 1
+
+Optional properties:
+- clocks : default parent clock phandle (e.g. tclk)
+
+Example:
+
+gate_clk: clock-gating-control at d0038 {
+	compatible = "marvell,dove-gating-clock";
+	reg = <0xd0038 0x4>;
+	/* default parent clock is tclk */
+	clocks = <&core_clk 0>;
+	#clock-cells = <1>;
+};
+
+sdio0: sdio at 92000 {
+	compatible = "marvell,dove-sdhci";
+	/* get clk gate bit 8 (sdio0) */
+	clocks = <&gate_clk 8>;
+};
diff --git a/drivers/clk/mvebu/Kconfig b/drivers/clk/mvebu/Kconfig
index 1dd93ad..57323fd 100644
--- a/drivers/clk/mvebu/Kconfig
+++ b/drivers/clk/mvebu/Kconfig
@@ -4,3 +4,5 @@ config MVEBU_CLK_CORE
 config MVEBU_CLK_CPU
        bool
 
+config MVEBU_CLK_GATING
+       bool
diff --git a/drivers/clk/mvebu/Makefile b/drivers/clk/mvebu/Makefile
index 93da083..58df3dc 100644
--- a/drivers/clk/mvebu/Makefile
+++ b/drivers/clk/mvebu/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_MVEBU_CLK_CORE) 	+= clk.o clk-core.o
 obj-$(CONFIG_MVEBU_CLK_CPU) 	+= clk-cpu.o
+obj-$(CONFIG_MVEBU_CLK_GATING) 	+= clk-gating-ctrl.o
diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
new file mode 100644
index 0000000..424faff
--- /dev/null
+++ b/drivers/clk/mvebu/clk-gating-ctrl.c
@@ -0,0 +1,177 @@
+/*
+ * Marvell MVEBU clock gating control.
+ *
+ * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
+ * Andrew Lunn <andrew@lunn.ch>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/clk/mvebu.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+struct mvebu_gating_ctrl {
+	spinlock_t lock;
+	struct clk **gates;
+	int num_gates;
+};
+
+struct mvebu_soc_descr {
+	const char *name;
+	const char *parent;
+	int bit_idx;
+};
+
+#define to_clk_gate(_hw) container_of(_hw, struct clk_gate, hw)
+
+static struct clk __init *mvebu_clk_gating_get_src(
+	struct of_phandle_args *clkspec, void *data)
+{
+	struct mvebu_gating_ctrl *ctrl = (struct mvebu_gating_ctrl *)data;
+	int n;
+
+	if (clkspec->args_count < 1)
+		return ERR_PTR(-EINVAL);
+
+	for (n = 0; n < ctrl->num_gates; n++) {
+		struct clk_gate *gate =
+			to_clk_gate(__clk_get_hw(ctrl->gates[n]));
+		if (clkspec->args[0] == gate->bit_idx)
+			return ctrl->gates[n];
+	}
+	return ERR_PTR(-ENODEV);
+}
+
+static void __init mvebu_clk_gating_setup(
+	struct device_node *np, const struct mvebu_soc_descr *descr)
+{
+	struct mvebu_gating_ctrl *ctrl;
+	struct clk *clk;
+	void __iomem *base;
+	const char *default_parent = NULL;
+	int n;
+
+	base = of_iomap(np, 0);
+
+	clk = of_clk_get(np, 0);
+	if (!IS_ERR(clk)) {
+		default_parent = __clk_get_name(clk);
+		clk_put(clk);
+	}
+
+	ctrl = kzalloc(sizeof(struct mvebu_gating_ctrl), GFP_KERNEL);
+	if (WARN_ON(!ctrl))
+		return;
+
+	spin_lock_init(&ctrl->lock);
+
+	/*
+	 * Count, allocate, and register clock gates
+	 */
+	for (n = 0; descr[n].name;)
+		n++;
+
+	ctrl->num_gates = n;
+	ctrl->gates = kzalloc(ctrl->num_gates * sizeof(struct clk *),
+			      GFP_KERNEL);
+	if (WARN_ON(!ctrl->gates)) {
+		kfree(ctrl);
+		return;
+	}
+
+	for (n = 0; n < ctrl->num_gates; n++) {
+		const char *parent =
+			(descr[n].parent) ? descr[n].parent : default_parent;
+		ctrl->gates[n] = clk_register_gate(NULL, descr[n].name, parent,
+				   0, base, descr[n].bit_idx, 0, &ctrl->lock);
+		WARN_ON(IS_ERR(ctrl->gates[n]));
+	}
+	of_clk_add_provider(np, mvebu_clk_gating_get_src, ctrl);
+}
+
+/*
+ * SoC specific clock gating control
+ */
+
+#ifdef CONFIG_ARCH_DOVE
+static const struct mvebu_soc_descr __initconst dove_gating_descr[] = {
+	{ "usb0", NULL, 0 },
+	{ "usb1", NULL, 1 },
+	{ "ge", "gephy", 2 },
+	{ "sata", NULL, 3 },
+	{ "pex0", NULL, 4 },
+	{ "pex1", NULL, 5 },
+	{ "sdio0", NULL, 8 },
+	{ "sdio1", NULL, 9 },
+	{ "nand", NULL, 10 },
+	{ "camera", NULL, 11 },
+	{ "i2s0", NULL, 12 },
+	{ "i2s1", NULL, 13 },
+	{ "crypto", NULL, 15 },
+	{ "ac97", NULL, 21 },
+	{ "pdma", NULL, 22 },
+	{ "xor0", NULL, 23 },
+	{ "xor1", NULL, 24 },
+	{ "gephy", NULL, 30 },
+	{ }
+};
+#endif
+
+#ifdef CONFIG_ARCH_KIRKWOOD
+static const struct mvebu_soc_descr __initconst kirkwood_gating_descr[] = {
+	{ "ge0", NULL, 0 },
+	{ "pex0", NULL, 2 },
+	{ "usb0", NULL, 3 },
+	{ "sdio", NULL, 4 },
+	{ "tsu", NULL, 5 },
+	{ "runit", NULL, 7 },
+	{ "xor0", NULL, 8 },
+	{ "audio", NULL, 9 },
+	{ "sata0", NULL, 14 },
+	{ "sata1", NULL, 15 },
+	{ "xor1", NULL, 16 },
+	{ "crypto", NULL, 17 },
+	{ "pex1", NULL, 18 },
+	{ "ge1", NULL, 19 },
+	{ "tdm", NULL, 20 },
+	{ }
+};
+#endif
+
+static const __initdata struct of_device_id clk_gating_match[] = {
+#ifdef CONFIG_ARCH_DOVE
+	{
+		.compatible = "marvell,dove-gating-clock",
+		.data = dove_gating_descr,
+	},
+#endif
+
+#ifdef CONFIG_ARCH_KIRKWOOD
+	{
+		.compatible = "marvell,kirkwood-gating-clock",
+		.data = kirkwood_gating_descr,
+	},
+#endif
+
+	{ }
+};
+
+void __init mvebu_clk_gating_init(void)
+{
+	struct device_node *np;
+
+	for_each_matching_node(np, clk_gating_match) {
+		const struct of_device_id *match =
+			of_match_node(clk_gating_match, np);
+		mvebu_clk_gating_setup(np,
+		       (const struct mvebu_soc_descr *)match->data);
+	}
+}
diff --git a/include/linux/clk/mvebu.h b/include/linux/clk/mvebu.h
index 8c4ae71..70c366f 100644
--- a/include/linux/clk/mvebu.h
+++ b/include/linux/clk/mvebu.h
@@ -18,5 +18,6 @@
 #define __CLK_MVEBU_H_
 
 void __init mvebu_clocks_init(void);
+void mvebu_clk_gating_init(void);
 
 #endif
-- 
1.7.10.4
