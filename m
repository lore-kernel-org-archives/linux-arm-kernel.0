From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 23 Mar 2016 21:26:27 +0530
Subject: [PATCH v2 03/11] ARM: davinci: da850: use clk->set_parent for
 async3
In-Reply-To: <1458181615-27782-4-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
 <1458181615-27782-4-git-send-email-david@lechnology.com>
Message-ID: <56F2BCAB.3040404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 March 2016 07:56 AM, David Lechner wrote:
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
> ---

> +static int da850_async3_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	u32 __iomem *cfgchip3;
> +	u32 val;
> +
> +	/*
> +	 * Can't use DA8XX_SYSCFG0_VIRT() here since this can be called before
> +	 * da8xx_syscfg0_base is initialized.
> +	 */
> +	cfgchip3 = ioremap(DA8XX_SYSCFG0_BASE + DA8XX_CFGCHIP3_REG, 4);

Is this just a theoretical possibility or have you seen this happen? I
would like to see if there are ways of avoiding this rather than throw
away usage of DA8XX_SYSCFG0_VIRT()

> +	val = readl(cfgchip3);
> +
> +	/* Set the USB 1.1 PHY clock mux based on the parent clock. */

Comment is wrong (copy-paste error?)

> +	if (parent == &pll0_sysclk2)
> +		val &= ~CFGCHIP3_ASYNC3_CLKSRC;
> +	else if (parent == &pll1_sysclk2)
> +		val |= CFGCHIP3_ASYNC3_CLKSRC;
> +	else {
> +		pr_err("Bad parent on async3 clock mux.\n");
> +		return -EINVAL;
> +	}
> +
> +	writel(val, cfgchip3);
> +
> +	return 0;
> +}

Thanks,
Sekhar
