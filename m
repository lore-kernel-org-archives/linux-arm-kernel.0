From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Apr 2010 14:35:07 +0100
Subject: [PATCH 2/7 v4] Add the clock framework for Telechips TCC8xxx
	processors.
In-Reply-To: <20100331145056.GC2035@bluebox.local>
References: <20100331144543.GA2035@bluebox.local>
	<20100331145056.GC2035@bluebox.local>
Message-ID: <20100414133507.GB21526@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 31, 2010 at 04:50:58PM +0200, Hans J. Koch wrote:
> +static void __clk_disable(struct clk *clk)
> +{
> +	if (!clk)
> +		return;
> +
> +	BUG_ON(clk->refcount == 0);
> +
> +	if (!(--clk->refcount) && clk->disable)
> +		clk->disable(clk);
> +	__clk_disable(clk->parent);
> +}
> +
> +static int __clk_enable(struct clk *clk)
> +{
> +	if (!clk)
> +		return -EINVAL;
> +
> +	__clk_enable(clk->parent);

Here, every enable of the child clock causes the parent to be enabled
one more time.  This is a bad idea in conjunction with...

> +
> +	if (clk->refcount++ == 0 && clk->enable)
> +		clk->enable(clk);
> +
> +	return 0;
> +}

> +/* Set the clock's parent to another clock source */
> +int clk_set_parent(struct clk *clk, struct clk *parent)
> +{
> +	int ret = -EINVAL;
> +
> +	if (!clk)
> +		return ret;
> +	if (!clk->set_parent || !parent)
> +		return ret;
> +
> +	mutex_lock(&clocks_mutex);
> +	ret = clk->set_parent(clk, parent);
> +	if (ret == 0)
> +		clk->parent = parent;

... reparenting of clocks.

Reparenting is much easier to deal with if you only enable/disable the
parent clock on the first enable and last disable of the child clock.
Then you can do:

	if (clk->refcount)
		__clk_enable(parent);
	ret = clk->set_parent(clk, parent);
	if (ret == 0) {
		old = clk->parent;
		clk->parent = parent;
	} else {
		old = parent;
	}
	if (clk->refcount)
		__clk_disable(old);

here, which will keep the refcounts straight.

> +	mutex_unlock(&clocks_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(clk_set_parent);

>  /* Clock controller registers */
> -#define CKC_BASE		(APB1_PERI_BASE_VIRT + 0x6000)
> -#define CKC_BASE_PHYS		(APB1_PERI_BASE + 0x6000)
> +#define CKC_BASE	(void __iomem *)(APB1_PERI_BASE_VIRT + 0x6000)

This has the possibility of causing unexpected side effects.  With any
macro which is more than just a number, it's always worth adding a set
of parens around it to ensure that evaluation happens in the order you
expect.
