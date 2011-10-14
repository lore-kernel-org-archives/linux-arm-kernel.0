From: mturquette@ti.com (Turquette, Mike)
Date: Fri, 14 Oct 2011 11:14:19 -0700
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <1316730422-20027-2-git-send-email-mturquette@ti.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
Message-ID: <CAJOA=zM9k7_z_PUoF0tZ_OrgdDTgMjZLftqtW0ra3G9C08Th7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 3:26 PM, Mike Turquette <mturquette@ti.com> wrote:
> From: Jeremy Kerr <jeremy.kerr@canonical.com>
> ?struct clk_hw_ops {
> ? ? ? ?int ? ? ? ? ? ? (*prepare)(struct clk_hw *);
> ? ? ? ?void ? ? ? ? ? ?(*unprepare)(struct clk_hw *);
> ? ? ? ?int ? ? ? ? ? ? (*enable)(struct clk_hw *);
> ? ? ? ?void ? ? ? ? ? ?(*disable)(struct clk_hw *);
> ? ? ? ?unsigned long ? (*recalc_rate)(struct clk_hw *);

In implementing recalc for divider clocks, I started to wonder, "why
not just pass struct clk *clk into the clk_hw_ops func ptrs?".

recalc is an obvious example whereby we need access to parent->rate.
The code usually ends up looking something like:

unsigned long omap_recalc_rate(struct clk_hw *hw)
{
        struct clk *parent;
        struct clk_hw_omap *oclk;

        parent = hw->clk->parent;
        oclk = to_clk_omap(hw);
        ...
}

That's a bit of a song and dance to have to do in almost every op, and
often these ops will need access to stuff like clk->rate also.   Is
there any opposition to just passing in struct clk?  e.g:

unsigned long omap_recalc_rate(struct clk *clk)
{
        struct clk *parent;
        struct clk_hw_omap *oclk;

        parent = clk->parent;
        oclk = to_clk_omap(clk->hw);
        ...
}

It is a small nitpick, but it affects the API for everybody so best to
get it right now before folks start migrating over to it.

Thanks,
Mike

> ? ? ? ?int ? ? ? ? ? ? (*set_rate)(struct clk_hw *,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned long, unsigned long *);
> ? ? ? ?long ? ? ? ? ? ?(*round_rate)(struct clk_hw *, unsigned long);
> ? ? ? ?int ? ? ? ? ? ? (*set_parent)(struct clk_hw *, struct clk *);
> ? ? ? ?struct clk * ? ?(*get_parent)(struct clk_hw *);
> ?};
