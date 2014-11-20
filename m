From: vincent.yang.fujitsu@gmail.com (Vincent Yang)
Date: Thu, 20 Nov 2014 20:36:15 +0800
Subject: [PATCH 4/9] clk: Add clock driver for mb86s7x
In-Reply-To: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <1416486975-25385-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 The CRG11 clock controller is managed by remote f/w.
This driver simply maps Linux CLK ops onto mailbox api.

Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
---
 .../bindings/clock/fujitsu,mb86s70-clk.txt         |  34 ++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-mb86s7x.c                          | 359 +++++++++++++++++++++
 include/dt-bindings/clock/mb86s70-clk.h            |  22 ++
 4 files changed, 416 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fujitsu,mb86s70-clk.txt
 create mode 100644 drivers/clk/clk-mb86s7x.c
 create mode 100644 include/dt-bindings/clock/mb86s70-clk.h

diff --git a/Documentation/devicetree/bindings/clock/fujitsu,mb86s70-clk.txt b/Documentation/devicetree/bindings/clock/fujitsu,mb86s70-clk.txt
new file mode 100644
index 0000000..7aeb1ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fujitsu,mb86s70-clk.txt
@@ -0,0 +1,34 @@
+Fujitsu CRG11 clock driver bindings
+-----------------------------------
+
+Required properties :
+- compatible : Shall contain "fujitsu,mb86s70-clk"
+- #clock-cells : Shall be 0
+- cntrlr : 0->ALW, 1->DDR3, 2->MAIN, 3->CA15, 4->HDMI, 5->DPHY
+- domain : [0, 15]
+- port : [0,7] -> Gateable Clock Ports.  [8]->UngatedCLK
+	  The UngatedCLK is the source of 8 maskable clock ports
+	  as well as having its own output port which can't be masked.
+
+The consumer specifies the desired clock pointing to its phandle.
+
+Example:
+
+	clk_alw_2_1: clk_alw_2_1 {
+		compatible = "fujitsu,mb86s70-clk";
+		#clock-cells = <0>;
+		cntrlr = <0>;
+		domain = <2>;
+		port = <1>;
+	};
+
+	mhu: mhu0 at 2b1f0000 {
+		#mbox-cells = <1>;
+		compatible = "arm,mbox-mhu";
+		reg = <0 0x2B1F0000 0x1000>;
+		interrupts = <0 36 4>, /* LP Non-Sec */
+			     <0 35 4>, /* HP Non-Sec */
+			     <0 37 4>; /* Secure */
+		clocks = <&clk_alw_2_1>;
+		clock-names = "clk";
+	};
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index d5fba5b..19d73a1 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_MACH_LOONGSON1)		+= clk-ls1x.o
 obj-$(CONFIG_COMMON_CLK_MAX_GEN)	+= clk-max-gen.o
 obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
 obj-$(CONFIG_COMMON_CLK_MAX77802)	+= clk-max77802.o
+obj-$(CONFIG_ARCH_MB86S7X)		+= clk-mb86s7x.o
 obj-$(CONFIG_ARCH_MOXART)		+= clk-moxart.o
 obj-$(CONFIG_ARCH_NOMADIK)		+= clk-nomadik.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
diff --git a/drivers/clk/clk-mb86s7x.c b/drivers/clk/clk-mb86s7x.c
new file mode 100644
index 0000000..e585fb3
--- /dev/null
+++ b/drivers/clk/clk-mb86s7x.c
@@ -0,0 +1,359 @@
+/*
+ * Copyright (C) 2013-2014 FUJITSU SEMICONDUCTOR LIMITED
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clkdev.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/cpu.h>
+#include <linux/clk-provider.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <linux/topology.h>
+#include <linux/mailbox_client.h>
+#include <linux/platform_device.h>
+
+#include <soc/mb86s7x/scb_mhu.h>
+
+#include <dt-bindings/clock/mb86s70-clk.h>
+
+#define to_crg_clk(p) container_of(p, struct crg_clk, hw)
+#define to_clc_clk(p) container_of(p, struct cl_clk, hw)
+
+struct mb86s7x_peri_clk {
+	u32 payload_size;
+	u32 cntrlr;
+	u32 domain;
+	u32 port;
+	u32 en;
+	u64 freqency;
+} __packed __attribute__((aligned(4)));
+
+struct hack_rate {
+	unsigned clk_id;
+	unsigned long rate;
+	int gated;
+};
+
+struct crg_clk {
+	struct clk_hw hw;
+	u8 cntrlr, domain, port;
+};
+
+static int crg_gate_control(struct clk_hw *hw, int en)
+{
+	struct crg_clk *crgclk = to_crg_clk(hw);
+	struct mb86s7x_peri_clk cmd;
+	int ret;
+
+	cmd.payload_size = sizeof(cmd);
+	cmd.cntrlr = crgclk->cntrlr;
+	cmd.domain = crgclk->domain;
+	cmd.port = crgclk->port;
+	cmd.en = en;
+
+	/* Port is UngatedCLK */
+	if (cmd.port == MB86S70_CRG11_UNGPRT)
+		return en ? 0 : -EINVAL;
+
+	pr_debug("%s:%d CMD Cntrlr-%u Dom-%u Port-%u En-%u}\n",
+		 __func__, __LINE__, cmd.cntrlr,
+		 cmd.domain, cmd.port, cmd.en);
+
+	ret = mb86s7x_send_packet(CMD_PERI_CLOCK_GATE_SET_REQ,
+				  &cmd, sizeof(cmd));
+	if (ret < 0) {
+		pr_err("%s:%d failed!\n", __func__, __LINE__);
+		return ret;
+	}
+
+	pr_debug("%s:%d REP Cntrlr-%u Dom-%u Port-%u En-%u}\n",
+		 __func__, __LINE__, cmd.cntrlr,
+		 cmd.domain, cmd.port, cmd.en);
+
+	/* If the request was rejected */
+	if (cmd.en != en)
+		ret = -EINVAL;
+	else
+		ret = 0;
+
+	return ret;
+}
+
+static int crg_port_prepare(struct clk_hw *hw)
+{
+	return crg_gate_control(hw, 1);
+}
+
+static void crg_port_unprepare(struct clk_hw *hw)
+{
+	crg_gate_control(hw, 0);
+}
+
+static int
+crg_rate_control(struct clk_hw *hw, int set, unsigned long *rate)
+{
+	struct crg_clk *crgclk = to_crg_clk(hw);
+	struct mb86s7x_peri_clk cmd;
+	int code, ret;
+
+	cmd.payload_size = sizeof(cmd);
+	cmd.cntrlr = crgclk->cntrlr;
+	cmd.domain = crgclk->domain;
+	cmd.port = crgclk->port;
+	cmd.freqency = *rate;
+
+	if (set) {
+		code = CMD_PERI_CLOCK_RATE_SET_REQ;
+		pr_debug("%s:%d CMD Cntrlr-%u Dom-%u Port-%u Rate-SET %lluHz}\n",
+			 __func__, __LINE__, cmd.cntrlr,
+			 cmd.domain, cmd.port, cmd.freqency);
+	} else {
+		code = CMD_PERI_CLOCK_RATE_GET_REQ;
+		pr_debug("%s:%d CMD Cntrlr-%u Dom-%u Port-%u Rate-GET}\n",
+			 __func__, __LINE__, cmd.cntrlr,
+			 cmd.domain, cmd.port);
+	}
+
+	ret = mb86s7x_send_packet(code, &cmd, sizeof(cmd));
+	if (ret < 0) {
+		pr_err("%s:%d failed!\n", __func__, __LINE__);
+		return ret;
+	}
+
+	if (set)
+		pr_debug("%s:%d REP Cntrlr-%u Dom-%u Port-%u Rate-SET %lluHz}\n",
+			 __func__, __LINE__, cmd.cntrlr,
+			 cmd.domain, cmd.port, cmd.freqency);
+	else
+		pr_debug("%s:%d REP Cntrlr-%u Dom-%u Port-%u Rate-GOT %lluHz}\n",
+			 __func__, __LINE__, cmd.cntrlr,
+			 cmd.domain, cmd.port, cmd.freqency);
+
+	*rate = cmd.freqency;
+	return 0;
+}
+
+static unsigned long
+crg_port_recalc_rate(struct clk_hw *hw,	unsigned long parent_rate)
+{
+	unsigned long rate;
+
+	crg_rate_control(hw, 0, &rate);
+
+	return rate;
+}
+
+static long
+crg_port_round_rate(struct clk_hw *hw,
+		    unsigned long rate, unsigned long *pr)
+{
+	return rate;
+}
+
+static int
+crg_port_set_rate(struct clk_hw *hw,
+		  unsigned long rate, unsigned long parent_rate)
+{
+	return crg_rate_control(hw, 1, &rate);
+}
+
+const struct clk_ops crg_port_ops = {
+	.prepare = crg_port_prepare,
+	.unprepare = crg_port_unprepare,
+	.recalc_rate = crg_port_recalc_rate,
+	.round_rate = crg_port_round_rate,
+	.set_rate = crg_port_set_rate,
+};
+
+static void __init crg_port_init(struct device_node *node)
+{
+	struct clk_init_data init;
+	u32 cntrlr, domain, port;
+	struct crg_clk *crgclk;
+	struct clk *clk;
+	char clkp[20];
+	int rc;
+
+	rc = of_property_read_u32(node, "cntrlr", &cntrlr);
+	if (WARN_ON(rc))
+		return;
+	rc = of_property_read_u32(node, "domain", &domain);
+	if (WARN_ON(rc))
+		return;
+	rc = of_property_read_u32(node, "port", &port);
+	if (WARN_ON(rc))
+		return;
+
+	if (port > 7)
+		snprintf(clkp, 20, "UngatedCLK%d_%X", cntrlr, domain);
+	else
+		snprintf(clkp, 20, "CLK%d_%X_%d", cntrlr, domain, port);
+
+	clk = __clk_lookup(clkp);
+	if (clk)
+		return;
+
+	crgclk = kzalloc(sizeof(*crgclk), GFP_KERNEL);
+	if (!crgclk)
+		return;
+	init.name = clkp;
+	init.num_parents = 0;
+	init.ops = &crg_port_ops;
+	init.flags = CLK_IS_ROOT;
+	crgclk->hw.init = &init;
+	crgclk->cntrlr = cntrlr;
+	crgclk->domain = domain;
+	crgclk->port = port;
+	clk = clk_register(NULL, &crgclk->hw);
+	if (IS_ERR(clk))
+		pr_err("%s:%d Error!\n", __func__, __LINE__);
+	else
+		pr_debug("Registered %s\n", clkp);
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	clk_register_clkdev(clk, clkp, NULL);
+}
+CLK_OF_DECLARE(crg11_gate, "fujitsu,mb86s70-clk", crg_port_init);
+
+struct cl_clk {
+	struct clk_hw hw;
+	int cluster;
+};
+
+struct mb86s7x_cpu_freq {
+	u32 payload_size;
+	u32 cluster_class;
+	u32 cluster_id;
+	u32 cpu_id;
+	u64 freqency;
+};
+
+static void mhu_cluster_rate(struct clk_hw *hw, unsigned long *rate, int get)
+{
+	struct cl_clk *clc = to_clc_clk(hw);
+	struct mb86s7x_cpu_freq cmd;
+	int code, ret;
+
+	cmd.payload_size = sizeof(cmd);
+	cmd.cluster_class = 0;
+	cmd.cluster_id = clc->cluster;
+	cmd.cpu_id = 0;
+	cmd.freqency = *rate;
+
+	if (get)
+		code = CMD_CPU_CLOCK_RATE_GET_REQ;
+	else
+		code = CMD_CPU_CLOCK_RATE_SET_REQ;
+
+	pr_debug("%s:%d CMD Cl_Class-%u CL_ID-%u CPU_ID-%u Freq-%llu}\n",
+		 __func__, __LINE__, cmd.cluster_class,
+		 cmd.cluster_id, cmd.cpu_id, cmd.freqency);
+
+	ret = mb86s7x_send_packet(code, &cmd, sizeof(cmd));
+	if (ret < 0) {
+		pr_err("%s:%d failed!\n", __func__, __LINE__);
+		return;
+	}
+
+	pr_debug("%s:%d REP Cl_Class-%u CL_ID-%u CPU_ID-%u Freq-%llu}\n",
+		 __func__, __LINE__, cmd.cluster_class,
+		 cmd.cluster_id, cmd.cpu_id, cmd.freqency);
+
+	*rate = cmd.freqency;
+}
+
+static unsigned long
+clc_recalc_rate(struct clk_hw *hw, unsigned long unused)
+{
+	unsigned long rate;
+
+	mhu_cluster_rate(hw, &rate, 1);
+	return rate;
+}
+
+static long
+clc_round_rate(struct clk_hw *hw, unsigned long rate,
+	       unsigned long *unused)
+{
+	return rate;
+}
+
+static int
+clc_set_rate(struct clk_hw *hw, unsigned long rate,
+	     unsigned long unused)
+{
+	unsigned long res = rate;
+
+	mhu_cluster_rate(hw, &res, 0);
+
+	return (res == rate) ? 0 : -EINVAL;
+}
+
+static struct clk_ops clk_clc_ops = {
+	.recalc_rate = clc_recalc_rate,
+	.round_rate = clc_round_rate,
+	.set_rate = clc_set_rate,
+};
+
+struct clk *mb86s7x_clclk_register(struct device *cpu_dev)
+{
+	struct clk_init_data init;
+	struct cl_clk *clc;
+
+	clc = kzalloc(sizeof(*clc), GFP_KERNEL);
+	if (!clc)
+		return ERR_PTR(-ENOMEM);
+
+	clc->hw.init = &init;
+	clc->cluster = topology_physical_package_id(cpu_dev->id);
+
+	init.name = dev_name(cpu_dev);
+	init.ops = &clk_clc_ops;
+	init.flags = CLK_IS_ROOT | CLK_GET_RATE_NOCACHE;
+	init.num_parents = 0;
+
+	return devm_clk_register(cpu_dev, &clc->hw);
+}
+
+static int mb86s7x_clclk_of_init(void)
+{
+	int cpu;
+	struct clk *clk;
+
+	for_each_possible_cpu(cpu) {
+		struct device *cpu_dev = get_cpu_device(cpu);
+
+		if (!cpu_dev) {
+			pr_err("failed to get cpu%d device\n", cpu);
+			continue;
+		}
+
+		clk = mb86s7x_clclk_register(cpu_dev);
+		if (IS_ERR(clk)) {
+			pr_err("failed to register cpu%d clock\n", cpu);
+			continue;
+		}
+		if (clk_register_clkdev(clk, NULL, dev_name(cpu_dev))) {
+			pr_err("failed to register cpu%d clock lookup\n", cpu);
+			continue;
+		}
+		pr_debug("registered clk for %s\n", dev_name(cpu_dev));
+	}
+
+	platform_device_register_simple("arm-bL-cpufreq-dt", -1, NULL, 0);
+
+	return 0;
+}
+module_init(mb86s7x_clclk_of_init);
diff --git a/include/dt-bindings/clock/mb86s70-clk.h b/include/dt-bindings/clock/mb86s70-clk.h
new file mode 100644
index 0000000..d6f370b
--- /dev/null
+++ b/include/dt-bindings/clock/mb86s70-clk.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2013-2014 FUJITSU SEMICONDUCTOR LIMITED
+ * Copyright (C) 2014 Linaro Ltd.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2 of the License.
+ */
+
+#ifndef	__DTS_MB86S70_CLK_H
+#define __DTS_MB86S70_CLK_H
+
+#define MB86S70_CRG11_ALW	0
+#define MB86S70_CRG11_DDR3	1
+#define MB86S70_CRG11_MAIN	2
+#define MB86S70_CRG11_CA15	3
+#define MB86S70_CRG11_HDMI	4
+#define MB86S70_CRG11_DPHY	5
+
+#define MB86S70_CRG11_UNGPRT	8
+
+#endif
-- 
1.9.0
