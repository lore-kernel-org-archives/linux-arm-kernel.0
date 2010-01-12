From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jan 2010 16:25:39 +0000
Subject: [RFC,PATCH 3/7 v2] arm/versatile: use generic struct clk
In-Reply-To: <1263279511.161193.484965724912.3.gpush@pororo>
References: <1263279511.160127.576969496193.0.gpush@pororo>
	<1263279511.161193.484965724912.3.gpush@pororo>
Message-ID: <20100112162539.GH27771@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 05:58:31PM +1100, Jeremy Kerr wrote:
> diff --git a/arch/arm/common/clkdev.c b/arch/arm/common/clkdev.c
> index aae5bc0..71e7596 100644
> --- a/arch/arm/common/clkdev.c
> +++ b/arch/arm/common/clkdev.c
> @@ -85,11 +85,13 @@ struct clk *clk_get(struct device *dev, const char *con_id)
>  }
>  EXPORT_SYMBOL(clk_get);
>  
> +#ifndef CONFIG_USE_COMMON_STRUCT_CLK
>  void clk_put(struct clk *clk)
>  {
>  	__clk_put(clk);
>  }
>  EXPORT_SYMBOL(clk_put);
> +#endif /* CONFIG_USE_COMMON_STRUCT_CLK */

This doesn't make any sense.  What are you trying to do here?

The get/put operations go together as one logical set - that's why you
get both if you're using clkdev, and why you're asked to implement both
__clk_get() and __clk_put() in arch code to do whatever's necessary
with the clock.

Let me guess, and say that clk_put() is not a release method.  It's a
method for drivers to say "I'm done with this clock" and for the arch
code to reverse the effects of __clk_get()/clk_get().

Currently, its only user is to balance module counts.
