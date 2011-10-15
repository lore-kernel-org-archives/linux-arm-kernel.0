From: richard.zhao@linaro.org (Richard Zhao)
Date: Sat, 15 Oct 2011 10:24:49 +0800
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <CAJOA=zM9k7_z_PUoF0tZ_OrgdDTgMjZLftqtW0ra3G9C08Th7g@mail.gmail.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
	<CAJOA=zM9k7_z_PUoF0tZ_OrgdDTgMjZLftqtW0ra3G9C08Th7g@mail.gmail.com>
Message-ID: <20111015022448.GA17872@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2011 at 11:14:19AM -0700, Turquette, Mike wrote:
> On Thu, Sep 22, 2011 at 3:26 PM, Mike Turquette <mturquette@ti.com> wrote:
> > From: Jeremy Kerr <jeremy.kerr@canonical.com>
> > ?struct clk_hw_ops {
> > ? ? ? ?int ? ? ? ? ? ? (*prepare)(struct clk_hw *);
> > ? ? ? ?void ? ? ? ? ? ?(*unprepare)(struct clk_hw *);
> > ? ? ? ?int ? ? ? ? ? ? (*enable)(struct clk_hw *);
> > ? ? ? ?void ? ? ? ? ? ?(*disable)(struct clk_hw *);
> > ? ? ? ?unsigned long ? (*recalc_rate)(struct clk_hw *);
> 
> In implementing recalc for divider clocks, I started to wonder, "why
> not just pass struct clk *clk into the clk_hw_ops func ptrs?".
> 
> recalc is an obvious example whereby we need access to parent->rate.
> The code usually ends up looking something like:
> 
> unsigned long omap_recalc_rate(struct clk_hw *hw)
> {
>         struct clk *parent;
>         struct clk_hw_omap *oclk;
> 
>         parent = hw->clk->parent;
clk drivers can not see struct clk details. I use clk_get_parent.
>         oclk = to_clk_omap(hw);
>         ...
> }
> 
> That's a bit of a song and dance to have to do in almost every op, and
> often these ops will need access to stuff like clk->rate also.   Is
> there any opposition to just passing in struct clk?  e.g:
> 
> unsigned long omap_recalc_rate(struct clk *clk)
> {
>         struct clk *parent;
>         struct clk_hw_omap *oclk;
> 
>         parent = clk->parent;
>         oclk = to_clk_omap(clk->hw);
>         ...
> }
In my understanding, struct clk stores things specific to clk core,
struct clk_hw stores common things needed by clk drivers. For static clk driver
there' some problems:
 - For clocks without mux, I need duplicate a  .parent and set .get_parent.
   Even when we adopt DT and dynamicly create clk, it's still a problem.
   Moving .parent to clk_hw can fix it.
 - When I define a clk array, I don't need to find another place to store .ops.
   It's not problem for dynamic creating clock.
 - As I mentioned in another mail, clk group need no lock version prepare/unprepare
   and enable/disable functions
   Another way is, add a "{struct clk_hw *clks; int count}" in clk_hw, let clk
   core handle it.
   I prefer the second way, but I'm not sure whether it's common enough. It's
   still a problem for dynamic creating clock.

Thanks
Richard
> 
> It is a small nitpick, but it affects the API for everybody so best to
> get it right now before folks start migrating over to it.
> 
> Thanks,
> Mike
> 
> > ? ? ? ?int ? ? ? ? ? ? (*set_rate)(struct clk_hw *,
> > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned long, unsigned long *);
> > ? ? ? ?long ? ? ? ? ? ?(*round_rate)(struct clk_hw *, unsigned long);
> > ? ? ? ?int ? ? ? ? ? ? (*set_parent)(struct clk_hw *, struct clk *);
> > ? ? ? ?struct clk * ? ?(*get_parent)(struct clk_hw *);
> > ?};
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
