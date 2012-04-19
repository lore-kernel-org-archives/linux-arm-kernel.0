From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 19 Apr 2012 15:00:33 +0800
Subject: [PATCH 23/40] ARM i.MX: Add common clock support for 2bit gate
In-Reply-To: <1334065553-7565-24-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-24-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120419070032.GA22773@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 03:45:36PM +0200, Sascha Hauer wrote:
[snip]
> +struct clk *clk_register_gate2(struct device *dev, const char *name,
> +		const char *parent_name, unsigned long flags,
> +		void __iomem *reg, u8 bit_idx,
> +		u8 clk_gate2_flags, spinlock_t *lock)
> +{
> +	struct clk_gate *gate;
> +	struct clk *clk;
> +
> +	gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
> +
> +	if (!gate) {
> +		pr_err("%s: could not allocate gated clk\n", __func__);
> +		return NULL;
> +	}
> +
> +	/* struct clk_gate assignments */
> +	gate->reg = reg;
> +	gate->bit_idx = bit_idx;
> +	gate->flags = clk_gate2_flags;
> +	gate->lock = lock;
> +
> +	if (parent_name) {
> +		gate->parent[0] = kstrdup(parent_name, GFP_KERNEL);
> +		if (!gate->parent[0])
> +			goto out;
> +	}
> +
> +	clk = clk_register(dev, name,
> +			&clk_gate2_ops, &gate->hw,
> +			gate->parent,
> +			(parent_name ? 1 : 0),
> +			flags);
Why do you re-use struct clk_gate while you don't use clk_gate_ops?
It doesn't follow object oriented thought. struct clk_gate may change
according to clk_gate_ops changes.

Thanks
Richard
 
