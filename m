From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 11 Apr 2016 16:19:30 +0530
Subject: [PATCH v3 06/16] ARM: davinci: da850: use clk->set_parent for
 async3
In-Reply-To: <1458863503-31121-7-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-7-git-send-email-david@lechnology.com>
Message-ID: <570B813A.1030907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 March 2016 05:21 AM, David Lechner wrote:
> The da850 family of processors has an async3 clock domain that can be
> muxed to either pll0_sysclk2 or pll1_sysclk2. Now that the davinci clocks
> have a set_parent callback, we can use this to control the async3 mux
> instead of a stand-alone function.
> 
> This adds a new async3_clk and sets the appropriate child clocks. The
> default is use to pll1_sysclk2 since it is not affected by processor
> frequency scaling.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

> +static int da850_async3_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	u32 val;
> +
> +	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
> +
> +	/* Set the Async3 clock domain mux based on the parent clock. */
> +	if (parent == &pll0_sysclk2)
> +		val &= ~CFGCHIP3_ASYNC3_CLKSRC;
> +	else if (parent == &pll1_sysclk2)
> +		val |= CFGCHIP3_ASYNC3_CLKSRC;
> +	else {
> +		pr_err("Bad parent on async3 clock mux.\n");
> +		return -EINVAL;
> +	}

Since else has braces, need braces on all arm of the if-else construct.

Applied this patch with this fixed locally. checkpatch complains about
this too when --strict option is passed.

Thanks,
Sekhar
