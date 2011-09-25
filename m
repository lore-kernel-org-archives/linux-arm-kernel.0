From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 24 Sep 2011 21:55:36 -0600
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <1316730422-20027-2-git-send-email-mturquette@ti.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
Message-ID: <20110925035536.GN24631@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 03:26:56PM -0700, Mike Turquette wrote:
> From: Jeremy Kerr <jeremy.kerr@canonical.com>
> 
> We currently have ~21 definitions of struct clk in the ARM architecture,
> each defined on a per-platform basis. This makes it difficult to define
> platform- (or architecture-) independent clock sources without making
> assumptions about struct clk, and impossible to compile two
> platforms with different struct clks into a single image.
> 
> This change is an effort to unify struct clk where possible, by defining
> a common struct clk, and a set of clock operations. Different clock
> implementations can set their own operations, and have a standard
> interface for generic code. The callback interface is exposed to the
> kernel proper, while the clock implementations only need to be seen by
> the platform internals.
> 
> The interface is split into two halves:
> 
>  * struct clk, which is the generic-device-driver interface. This
>    provides a set of functions which drivers may use to request
>    enable/disable, query or manipulate in a hardware-independent manner.
> 
>  * struct clk_hw and struct clk_hw_ops, which is the hardware-specific
>    interface. Clock drivers implement the ops, which allow the core
>    clock code to implement the generic 'struct clk' API.
> 
> This allows us to share clock code among platforms, and makes it
> possible to dynamically create clock devices in platform-independent
> code.
> 
> Platforms can enable the generic struct clock through
> CONFIG_GENERIC_CLK. In this case, the clock infrastructure consists of a
> common, opaque struct clk, and a set of clock operations (defined per
> type of clock):
> 
>   struct clk_hw_ops {
>   	int		(*prepare)(struct clk_hw *);
>   	void		(*unprepare)(struct clk_hw *);
>   	int		(*enable)(struct clk_hw *);
>   	void		(*disable)(struct clk_hw *);
>   	unsigned long	(*recalc_rate)(struct clk_hw *);
>   	int		(*set_rate)(struct clk_hw *,
>   					unsigned long, unsigned long *);
>   	long		(*round_rate)(struct clk_hw *, unsigned long);
>   	int		(*set_parent)(struct clk_hw *, struct clk *);
>   	struct clk *	(*get_parent)(struct clk_hw *);
>   };
> 
> Platform clock code can register a clock through clk_register, passing a
> set of operations, and a pointer to hardware-specific data:
> 
>   struct clk_hw_foo {
>   	struct clk_hw clk;
>   	void __iomem *enable_reg;
>   };
> 
>   #define to_clk_foo(c) offsetof(c, clk_hw_foo, clk)
> 
>   static int clk_foo_enable(struct clk_hw *clk)
>   {
>   	struct clk_foo *foo = to_clk_foo(clk);
>   	raw_writeb(foo->enable_reg, 1);
>   	return 0;
>   }
> 
>   struct clk_hw_ops clk_foo_ops = {
>   	.enable = clk_foo_enable,
>   };
> 
> And in the platform initialisation code:
> 
>   struct clk_foo my_clk_foo;
> 
>   void init_clocks(void)
>   {
>   	my_clk_foo.enable_reg = ioremap(...);
> 
>   	clk_register(&clk_foo_ops, &my_clk_foo, NULL);

Shouldn't this be:

	clk_register(&clk_foo_ops, &my_clk_foo->clk, NULL);

?

Also, this documentation would be good to have in the Documentation
directory instead of lost in a commit header.

Otherwise looks okay to me.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
