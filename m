From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 3 Aug 2015 14:37:52 -0700
Subject: [PATCH v3 4/5] clk: Hi6220: add stub clock driver
In-Reply-To: <1438564418-15948-5-git-send-email-leo.yan@linaro.org>
References: <1438564418-15948-1-git-send-email-leo.yan@linaro.org>
 <1438564418-15948-5-git-send-email-leo.yan@linaro.org>
Message-ID: <20150803213752.GB21068@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03, Leo Yan wrote:
> diff --git a/drivers/clk/hisilicon/clk-hi6220-stub.c b/drivers/clk/hisilicon/clk-hi6220-stub.c
> new file mode 100644
> index 0000000..0931666
> --- /dev/null
> +++ b/drivers/clk/hisilicon/clk-hi6220-stub.c
> @@ -0,0 +1,279 @@
> +/*
> + * Hi6220 stub clock driver
> + *
> + * Copyright (c) 2015 Hisilicon Limited.
> + * Copyright (c) 2015 Linaro Limited.
> + *
> + * Author: Leo Yan <leo.yan@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/clkdev.h>

Is this include used?

> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>

Is this include used?

> +#include <linux/err.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +
> +#include <dt-bindings/clock/hi6220-clock.h>
> +
> +/* Stub clocks id */
> +#define HI6220_STUB_ACPU0		0
> +#define HI6220_STUB_ACPU1		1
> +#define HI6220_STUB_GPU			2
> +#define HI6220_STUB_DDR			5
> +
> +/* Mailbox message */
> +#define HI6220_MBOX_MSG_LEN		8
> +
> +#define HI6220_MBOX_FREQ		(0xA)
> +#define HI6220_MBOX_CMD_SET		(0x3)
> +#define HI6220_MBOX_OBJ_AP		(0x0)
> +
> +/* CPU dynamic frequency scaling */
> +#define ACPU_DFS_FREQ_MAX		(0x1724)
> +#define ACPU_DFS_CUR_FREQ		(0x17CC)
> +#define ACPU_DFS_FLAG			(0x1B30)
> +#define ACPU_DFS_FREQ_REQ		(0x1B34)
> +#define ACPU_DFS_FREQ_LMT		(0x1B38)
> +#define ACPU_DFS_LOCK_FLAG		(0xAEAEAEAE)

We don't need parenthesis around single values in these macros.

> +
> +#define to_stub_clk(hw) container_of(hw, struct hi6220_stub_clk, hw)
> +
> +struct hi6220_stub_clk {
> +	u32 id;
> +	u32 rate;
> +
> +	struct device *dev;
> +	struct clk_hw hw;
> +
> +	struct regmap *dfs_map;
> +	struct mbox_client cl;
> +	struct mbox_chan *mbox;
> +};
> +
> +struct hi6220_mbox_msg {
> +	unsigned char type;
> +	unsigned char cmd;
> +	unsigned char obj;
> +	unsigned char src;
> +	unsigned char para[4];
> +};
> +
> +union hi6220_mbox_data {
> +	unsigned int data[HI6220_MBOX_MSG_LEN];
> +	struct hi6220_mbox_msg msg;
> +};
> +
> +static unsigned int hi6220_acpu_get_freq(struct hi6220_stub_clk *stub_clk)
> +{
> +	unsigned int freq;
> +
> +	regmap_read(stub_clk->dfs_map, ACPU_DFS_CUR_FREQ, &freq);
> +	return freq;
> +}
> +
> +static int hi6220_acpu_set_freq(struct hi6220_stub_clk *stub_clk,
> +				unsigned int freq)
> +{
> +	union hi6220_mbox_data data;
> +
> +	stub_clk->mbox = mbox_request_channel(&stub_clk->cl, 0);

Why not request the channel once in probe?

> +	if (IS_ERR(stub_clk->mbox)) {
> +		dev_err(stub_clk->dev, "failed get mailbox channel\n");
> +		return PTR_ERR(stub_clk->mbox);
> +	};
> +
> +	/* set the frequency in sram */
> +	regmap_write(stub_clk->dfs_map, ACPU_DFS_FREQ_REQ, freq);
> +
> +	/* compound mailbox message */
> +	data.msg.type = HI6220_MBOX_FREQ;
> +	data.msg.cmd  = HI6220_MBOX_CMD_SET;
> +	data.msg.obj  = HI6220_MBOX_OBJ_AP;
> +	data.msg.src  = HI6220_MBOX_OBJ_AP;
> +
> +	mbox_send_message(stub_clk->mbox, &data);
> +	mbox_free_channel(stub_clk->mbox);
> +	return 0;
> +}
> +
> +static int hi6220_acpu_round_freq(struct hi6220_stub_clk *stub_clk,
> +				  unsigned int freq)
> +{
> +	unsigned int limit_flag, limit_freq = UINT_MAX;
> +	unsigned int max_freq;
> +
> +	/* check the constrainted frequency */

s/constrainted/constrained/ ?

> +	regmap_read(stub_clk->dfs_map, ACPU_DFS_FLAG, &limit_flag);
> +	if (limit_flag == ACPU_DFS_LOCK_FLAG)
> +		regmap_read(stub_clk->dfs_map, ACPU_DFS_FREQ_LMT, &limit_freq);
> +
> +	/* check the supported maximum frequency */
> +	regmap_read(stub_clk->dfs_map, ACPU_DFS_FREQ_MAX, &max_freq);
> +
> +	/* calculate the real maximum frequency */
> +	max_freq = min(max_freq, limit_freq);
> +
> +	if (WARN_ON(freq > max_freq))
> +		freq = max_freq;
> +
> +	return freq;
> +}
> +
> +static unsigned long hi6220_stub_clk_recalc_rate(struct clk_hw *hw,
> +		unsigned long parent_rate)
> +{
> +	u32 rate = 0;
> +	struct hi6220_stub_clk *stub_clk = to_stub_clk(hw);
> +
> +	switch (stub_clk->id) {
> +	case HI6220_STUB_ACPU0:
> +		rate = hi6220_acpu_get_freq(stub_clk);
> +
> +		/* convert from KHz to Hz */

s/KHz/kHz/ ?

> +		rate *= 1000;
> +		break;
> +
> +	default:
> +		dev_err(stub_clk->dev, "%s: un-supported clock id %d\n",
> +			__func__, stub_clk->id);
> +		break;
> +	}
> +
> +	return rate;
> +}
> +
> +static int hi6220_stub_clk_set_rate(struct clk_hw *hw, unsigned long rate,
> +                    unsigned long parent_rate)
> +{
> +	struct hi6220_stub_clk *stub_clk = to_stub_clk(hw);
> +	unsigned long new_rate = rate / 1000;  /* Khz */

s/KHz/kHz/ ?

> +	int ret = 0;
> +
> +	switch (stub_clk->id) {
> +	case HI6220_STUB_ACPU0:
> +		ret = hi6220_acpu_set_freq(stub_clk, new_rate);
> +		if (ret < 0)
> +			return ret;
> +
> +		break;
> +
> +	default:
> +		dev_err(stub_clk->dev, "%s: un-supported clock id %d\n",
> +			__func__, stub_clk->id);
> +		break;
> +	}
> +
> +	stub_clk->rate = new_rate;

Why do we store away the rate? Is this used anywhere?

> +
> +	pr_debug("%s: set rate=%ldKhz\n", __func__, new_rate);
> +	return ret;
> +}
> +
> +static long hi6220_stub_clk_round_rate(struct clk_hw *hw, unsigned long rate,
> +		unsigned long *parent_rate)
> +{
> +	struct hi6220_stub_clk *stub_clk = to_stub_clk(hw);
> +	unsigned long new_rate = rate / 1000;  /* Khz */

s/KHz/kHz/ ?

> +
> +	switch (stub_clk->id) {
> +	case HI6220_STUB_ACPU0:
> +		new_rate = hi6220_acpu_round_freq(stub_clk, new_rate);
> +
> +		/* convert from KHz to Hz */

s/KHz/kHz/ ?

> +		new_rate *= 1000;
> +		break;
> +
> +	default:
> +		dev_err(stub_clk->dev, "%s: un-supported clock id %d\n",
> +			__func__, stub_clk->id);
> +		break;
> +	}
> +
> +	return new_rate;
> +}
> +
> +static struct clk_ops hi6220_stub_clk_ops = {

const?

> +	.recalc_rate	= hi6220_stub_clk_recalc_rate,
> +	.round_rate	= hi6220_stub_clk_round_rate,
> +	.set_rate	= hi6220_stub_clk_set_rate,
> +};
> +
> +static int hi6220_stub_clk_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct clk_init_data init;
> +	struct hi6220_stub_clk *stub_clk;
> +	struct clk *clk;
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	stub_clk = devm_kzalloc(&pdev->dev, sizeof(*stub_clk), GFP_KERNEL);

just use dev?

> +	if (!stub_clk)
> +		return -ENOMEM;
> +
> +	stub_clk->dfs_map = syscon_regmap_lookup_by_phandle(np,
> +				"hisilicon,hi6220-clk-sram");
> +	if (IS_ERR(stub_clk->dfs_map)) {
> +		dev_err(dev, "failed to get sram regmap\n");
> +		return PTR_ERR(stub_clk->dfs_map);
> +	}
> +
> +	stub_clk->hw.init = &init;
> +	stub_clk->dev = dev;
> +	stub_clk->id = HI6220_STUB_ACPU0;
> +
> +	/* Use mailbox client with blocking mode */
> +	stub_clk->cl.dev = &pdev->dev;

just use dev?

> +	stub_clk->cl.tx_done = NULL;
> +	stub_clk->cl.tx_block = true;
> +	stub_clk->cl.tx_tout = 500;
> +	stub_clk->cl.knows_txdone = false;
> +
> +	init.name = "acpu0";
> +	init.ops = &hi6220_stub_clk_ops;
> +	init.num_parents = 0;
> +	init.flags = CLK_IS_ROOT;
> +
> +	clk = clk_register(NULL, &stub_clk->hw);

why not devm_clk_register?

> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	of_clk_add_provider(pdev->dev.of_node, of_clk_src_simple_get, clk);

And check this for an error return value? Also, just use dev?

> +
> +	/* initialize buffer to zero */
> +	regmap_write(stub_clk->dfs_map, ACPU_DFS_FLAG, 0x0);
> +	regmap_write(stub_clk->dfs_map, ACPU_DFS_FREQ_REQ, 0x0);
> +	regmap_write(stub_clk->dfs_map, ACPU_DFS_FREQ_LMT, 0x0);
> +
> +	dev_dbg(&pdev->dev, "Registered clock '%s'\n", init.name);

just use dev?

> +	return 0;
> +}
> +
> +static const struct of_device_id hi6220_stub_clk_of_match[] = {
> +	{ .compatible = "hisilicon,hi6220-stub-clk", },
> +	{}
> +};
> +
> +static struct platform_driver hi6220_stub_clk_driver = {
> +	.driver	= {
> +		.name = "hi6220-stub-clk",
> +		.of_match_table = of_match_ptr(hi6220_stub_clk_of_match),

We can leave off of_match_ptr() here.

> +	},
> +	.probe = hi6220_stub_clk_probe,
> +};

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
