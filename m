From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Mar 2015 10:41:33 +0000
Subject: [PATCH 04/10] ARM: zx: add initial L2CC initialization
In-Reply-To: <1426333785-3952-5-git-send-email-jun.nie@linaro.org>
References: <1426333785-3952-1-git-send-email-jun.nie@linaro.org>
 <1426333785-3952-5-git-send-email-jun.nie@linaro.org>
Message-ID: <20150316104133.GG8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 14, 2015 at 07:49:39PM +0800, Jun Nie wrote:
> +static void __init zx_l2x0_init(void)
> +{
> +	void __iomem *base;
> +	struct device_node *np;
> +	unsigned int val;
> +
> +	np = of_find_compatible_node(NULL, NULL, "arm,pl310-cache");
> +	if (!np)
> +		goto out;
> +
> +	base = of_iomap(np, 0);
> +	if (!base) {
> +		of_node_put(np);
> +		goto out;
> +	}

NAK, really, NAK.  We're trying to get away from platforms doing crap
like this.

> +
> +	val = readl_relaxed(base + L310_PREFETCH_CTRL);
> +	val |= 0x70800000;
> +	writel_relaxed(val, base + L310_PREFETCH_CTRL);

So that's:

	L310_PREFETCH_CTRL_DBL_LINEFILL |
	L310_PREFETCH_CTRL_INSTR_PREFETCH |
	L310_PREFETCH_CTRL_DATA_PREFETCH |
	L310_PREFETCH_CTRL_DBL_LINEFILL_INCR

which you can enable by adding:

	arm,double-linefill
	arm,double-linefill-incr

The prefetch enables are also accessible via the auxillary control
register when the cache is not enabled (see below.)

> +
> +	writel_relaxed(L310_DYNAMIC_CLK_GATING_EN | L310_STNDBY_MODE_EN,
> +		       base + L310_POWER_CTRL);

These should be done by your boot loader - they're highly SoC specific.

> +out:
> +	l2x0_of_init(0x7c433C01, 0x8000c3fe);

Why these random values?

Firstly, the L2 code takes care of bits 0, 26, 27, 30 for you already.
I fail to see why you would want to hard-code the cache size here
either; the cache size is supposed to be configured by the hardware
designers at implementation stage and the aux control register is
supposed to take up that configuration at reset.

You see to be setting bits 10-13 inclusive, which include:

	L310_AUX_CTRL_HIGHPRIO_SO_DEV
	L310_AUX_CTRL_STORE_LIMITATION
	L310_AUX_CTRL_EXCLUSIVE_CACHE

Are you sure you're supposed to be setting these bits?

Bits 28 and 29 are the same as bits 28 and 29 in the prefetch register
(as in, you read or write those bits in either register and you're
accessing the exact same bits.)

The only possible bits you should be playing around with here which
we don't have a way to cater for are bits 22, 28, 29.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
