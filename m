From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Aug 2013 21:30:34 +0100
Subject: [PATCH v2 1/4] clk: add common __clk_get(), __clk_put()
 implementations
In-Reply-To: <1377020063-30213-2-git-send-email-s.nawrocki@samsung.com>
References: <1377020063-30213-1-git-send-email-s.nawrocki@samsung.com>
 <1377020063-30213-2-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20130820203034.GC17845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 07:34:20PM +0200, Sylwester Nawrocki wrote:
> +int __clk_get(struct clk *clk)
> +{
> +	if (WARN_ON((!clk)))
> +		return 0;

This changes the behaviour of clk_get()

> +
> +	if (!try_module_get(clk->owner))
> +		return 0;

If you want this to be safe against NULL pointers, just do this:

	if (clk && !try_module_get(clk->owner))
		return 0;

> +
> +	return 1;
> +}
> +EXPORT_SYMBOL(__clk_get);
> +
> +void __clk_put(struct clk *clk)
> +{
> +	if (!clk || IS_ERR(clk))
> +		return;
> +
> +	module_put(clk->owner);

Calling clk_put() with an error-pointer should be a Bad Thing and something
that shouldn't be encouraged, so trapping it is probably unwise.  So, just
do here:

	if (clk)
		module_put(clk->owner);

If we do have some callers of this with ERR pointers, then we could add:

	if (WARN_ON_ONCE(IS_ERR(clk)))
		return;

and remove it after a full kernel cycle or so.
