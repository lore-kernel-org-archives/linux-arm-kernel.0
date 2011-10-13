From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 15:44:11 +0100
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <1316730422-20027-2-git-send-email-mturquette@ti.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
Message-ID: <20111013144411.GC21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 03:26:56PM -0700, Mike Turquette wrote:
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

Eww, no, this really isn't going to scale for platforms like OMAP - to
have all the operations indirected through a set of function pointers
for every clock just because the enable register (or enable bit) is
in a different position is completely absurd.

I'm not soo concerned about the increase in memory usage (for 100 to 200
clock definitions its only 4 to 8k) but what worries me the most is
initializing these damned things.  It's an awful lot of initializers,
which means the potential for an awful lot of conflicts should something
change in this structure.
