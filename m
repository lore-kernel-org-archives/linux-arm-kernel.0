From: xuyiping@hisilicon.com (Xu YiPing)
Date: Fri, 17 Nov 2017 17:27:31 +0800
Subject: [PATCH v3 2/3] clk: hisilicon: Add support for Hi3660 stub clocks
In-Reply-To: <1510910852-2175-1-git-send-email-xuyiping@hisilicon.com>
References: <1510910852-2175-1-git-send-email-xuyiping@hisilicon.com>
Message-ID: <1510910852-2175-3-git-send-email-xuyiping@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kaihua Zhong <zhongkaihua@huawei.com>

Hi3660 has four stub clocks, which are big and LITTLE cluster clocks,
GPU clock and DDR clock.  These clocks ask MCU for frequency scaling
by sending message through mailbox.

This commit adds support for stub clocks, it requests the dedicated
mailbox channel at initialization; then later uses this channel to send
message to MCU to execute frequency scaling. The four stub clocks share
the same mailbox channel, but every stub clock has its own command id so
MCU can distinguish the requirement coming for which clock.

A shared memory is used to present effective frequency value, so the
clock driver uses I/O mapping for the memory and reads back rate value.

Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Kai Zhao <zhaokai1@hisilicon.com>
Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>
---
 drivers/clk/hisilicon/Kconfig           |   6 ++
 drivers/clk/hisilicon/Makefile          |   1 +
 drivers/clk/hisilicon/clk-hi3660-stub.c | 186 ++++++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/clk/hisilicon/clk-hi3660-stub.c

diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
index 7098bfd..1bd4355 100644
--- a/drivers/clk/hisilicon/Kconfig
+++ b/drivers/clk/hisilicon/Kconfig
@@ -49,3 +49,9 @@ config STUB_CLK_HI6220
 	default ARCH_HISI
 	help
 	  Build the Hisilicon Hi6220 stub clock driver.
+
+config STUB_CLK_HI3660
+	bool "Hi3660 Stub Clock Driver"
+	depends on COMMON_CLK_HI3660 && MAILBOX
+	help
+	  Build the Hisilicon Hi3660 stub clock driver.
diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
index 1e4c3dd..0a5b499 100644
--- a/drivers/clk/hisilicon/Makefile
+++ b/drivers/clk/hisilicon/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_COMMON_CLK_HI3798CV200)	+= crg-hi3798cv200.o
 obj-$(CONFIG_COMMON_CLK_HI6220)	+= clk-hi6220.o
 obj-$(CONFIG_RESET_HISI)	+= reset.o
 obj-$(CONFIG_STUB_CLK_HI6220)	+= clk-hi6220-stub.o
+obj-$(CONFIG_STUB_CLK_HI3660)	+= clk-hi3660-stub.o
diff --git a/drivers/clk/hisilicon/clk-hi3660-stub.c b/drivers/clk/hisilicon/clk-hi3660-stub.c
new file mode 100644
index 0000000..607efa4
--- /dev/null
+++ b/drivers/clk/hisilicon/clk-hi3660-stub.c
@@ -0,0 +1,186 @@
+/*
+ * Hisilicon clock driver
+ *
+ * Copyright (c) 2013-2017 Hisilicon Limited.
+ * Copyright (c) 2017 Linaro Limited.
+ *
+ * Author: Kai Zhao <zhaokai1@hisilicon.com>
+ *	    Tao Wang <kevin.wangtao@hisilicon.com>
+ *	    Leo Yan <leo.yan@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/hi3660-clock.h>
+
+#define HI3660_STUB_CLOCK_DATA		(0x70)
+#define MHZ				(1000 * 1000)
+
+#define DEFINE_CLK_STUB(_id, _cmd, _name)			\
+	{							\
+		.id = (_id),					\
+		.cmd = (_cmd),					\
+		.hw.init = &(struct clk_init_data) {		\
+			.name = #_name,				\
+			.ops = &hi3660_stub_clk_ops,		\
+			.num_parents = 0,			\
+			.flags = CLK_GET_RATE_NOCACHE,		\
+		},						\
+	},
+
+#define to_stub_clk(_hw) container_of(_hw, struct hi3660_stub_clk, hw)
+
+struct hi3660_stub_clk_chan {
+	struct mbox_client cl;
+	struct mbox_chan *mbox;
+};
+
+struct hi3660_stub_clk {
+	unsigned int id;
+	struct clk_hw hw;
+	unsigned int cmd;
+	unsigned int msg[8];
+	unsigned int rate;
+};
+
+static void __iomem *freq_reg;
+static struct hi3660_stub_clk_chan stub_clk_chan;
+
+static unsigned long hi3660_stub_clk_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct hi3660_stub_clk *stub_clk = to_stub_clk(hw);
+
+	/*
+	 * LPM3 writes back the CPU frequency in shared SRAM so read
+	 * back the frequency.
+	 */
+	stub_clk->rate = readl(freq_reg + (stub_clk->id << 2)) * MHZ;
+	return stub_clk->rate;
+}
+
+static long hi3660_stub_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long *prate)
+{
+	/*
+	 * LPM3 handles rate rounding so just return whatever
+	 * rate is requested.
+	 */
+	return rate;
+}
+
+static int hi3660_stub_clk_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	struct hi3660_stub_clk *stub_clk = to_stub_clk(hw);
+
+	stub_clk->msg[0] = stub_clk->cmd;
+	stub_clk->msg[1] = rate / MHZ;
+
+	dev_dbg(stub_clk_chan.cl.dev, "set rate msg[0]=0x%x msg[1]=0x%x\n",
+		stub_clk->msg[0], stub_clk->msg[1]);
+
+	mbox_send_message(stub_clk_chan.mbox, stub_clk->msg);
+	mbox_client_txdone(stub_clk_chan.mbox, 0);
+
+	stub_clk->rate = rate;
+	return 0;
+}
+
+static const struct clk_ops hi3660_stub_clk_ops = {
+	.recalc_rate    = hi3660_stub_clk_recalc_rate,
+	.round_rate     = hi3660_stub_clk_round_rate,
+	.set_rate       = hi3660_stub_clk_set_rate,
+};
+
+static struct hi3660_stub_clk hi3660_stub_clks[HI3660_CLK_STUB_NUM] = {
+	DEFINE_CLK_STUB(HI3660_CLK_STUB_CLUSTER0, 0x0001030A, "cpu-cluster.0")
+	DEFINE_CLK_STUB(HI3660_CLK_STUB_CLUSTER1, 0x0002030A, "cpu-cluster.1")
+	DEFINE_CLK_STUB(HI3660_CLK_STUB_GPU, 0x0003030A, "clk-g3d")
+	DEFINE_CLK_STUB(HI3660_CLK_STUB_DDR, 0x00040309, "clk-ddrc")
+};
+
+static struct clk_hw *hi3660_stub_clk_hw_get(struct of_phandle_args *clkspec,
+					     void *data)
+{
+	unsigned int idx = clkspec->args[0];
+
+	if (idx > HI3660_CLK_STUB_NUM) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return &hi3660_stub_clks[idx].hw;
+}
+
+static int hi3660_stub_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	unsigned int i;
+	int ret;
+
+	/* Use mailbox client without blocking */
+	stub_clk_chan.cl.dev = dev;
+	stub_clk_chan.cl.tx_done = NULL;
+	stub_clk_chan.cl.tx_block = false;
+	stub_clk_chan.cl.knows_txdone = false;
+
+	/* Allocate mailbox channel */
+	stub_clk_chan.mbox = mbox_request_channel(&stub_clk_chan.cl, 0);
+	if (IS_ERR(stub_clk_chan.mbox))
+		return PTR_ERR(stub_clk_chan.mbox);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	freq_reg = devm_ioremap(dev, res->start, resource_size(res));
+	if (IS_ERR(freq_reg))
+		return -ENOMEM;
+
+	freq_reg += HI3660_STUB_CLOCK_DATA;
+
+	for (i = 0; i < HI3660_CLK_STUB_NUM; i++) {
+		ret = devm_clk_hw_register(&pdev->dev, &hi3660_stub_clks[i].hw);
+		if (ret)
+			return ret;
+	}
+
+	ret = of_clk_add_hw_provider(pdev->dev.of_node, hi3660_stub_clk_hw_get,
+				     hi3660_stub_clks);
+	return ret;
+}
+
+static const struct of_device_id hi3660_stub_clk_of_match[] = {
+	{ .compatible = "hisilicon,hi3660-stub-clk", },
+	{}
+};
+
+static struct platform_driver hi3660_stub_clk_driver = {
+	.probe	= hi3660_stub_clk_probe,
+	.driver = {
+		.name = "hi3660-stub-clk",
+		.of_match_table = hi3660_stub_clk_of_match,
+	},
+};
+
+static int __init hi3660_stub_clk_init(void)
+{
+	return platform_driver_register(&hi3660_stub_clk_driver);
+}
+subsys_initcall(hi3660_stub_clk_init);
-- 
1.9.1
