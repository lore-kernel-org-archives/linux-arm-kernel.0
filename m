From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 19 Jun 2013 20:21:35 +0200
Subject: [PATCH v6 2/7] clk: samsung: Define a common
 samsung_clk_register_pll()
In-Reply-To: <CAKew6eXMERhqiJOz0vLeK-38U04kAxfJqfFVz+31nZcMCxhxNA@mail.gmail.com>
References: <1370870659-10929-1-git-send-email-yadi.brar@samsung.com>
 <2209237.a9mepGgblz@flatron>
 <CAKew6eXMERhqiJOz0vLeK-38U04kAxfJqfFVz+31nZcMCxhxNA@mail.gmail.com>
Message-ID: <2309646.YHfr82EFWa@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 of June 2013 23:44:47 Yadwinder Singh Brar wrote:
> On Wed, Jun 19, 2013 at 10:24 PM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > Hi Yadwinder,
> > 
> > Generally looks really good, but some comments inline.
> > 
> > On Monday 10 of June 2013 18:54:14 Yadwinder Singh Brar wrote:
> >> This patch defines a common samsung_clk_register_pll() and its
> >> migrating the PLL35xx & PLL36xx to use it. Other samsung PLL can
> >> also be migrated to it. It also adds exynos5250 & exynos5420 PLLs to
> >> unique id list of clocks. Since pll2550 & pll35xx and pll2650 &
> >> pll36xx have exactly same clk ops implementation, added pll2550 and
> >> pll2650 also.
> >> 
> >> +void __init samsung_clk_register_pll(struct samsung_pll_clock
> >> *clk_list, +                          unsigned int nr_pll, void
> >> __iomem
> > 
> > *base)
> > 
> >> +{
> >> +     struct samsung_clk_pll *pll;
> >> +     struct clk *clk;
> >> +     struct clk_init_data init;
> >> +     struct samsung_pll_clock *list = clk_list;
> >> +     int cnt;
> >> +
> >> +     for (cnt = 0; cnt < nr_pll; cnt++, list++) {
> > 
> > I'd suggest moving contents of this loop to a function like following?
> > 
> > static int __init _samsung_clk_register_pll(struct samsung_pll_clock
> > *pll,> 
> >                                             void __iomem *base)
> > 
> > This will make the code less indented and so more readable.
> 
> Yes, will do it.
> 
> >> +             pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> >> +             if (!pll) {
> >> +                     pr_err("%s: could not allocate pll clk %s\n",
> >> +                             __func__, list->name);
> >> +                     continue;
> >> +             }
> >> +
> >> +             init.name = list->name;
> >> +             init.flags = list->flags;
> >> +             init.parent_names = &list->parent_name;
> >> +             init.num_parents = 1;
> >> +
> >> +             switch (list->type) {
> >> +             /* clk_ops for 35xx and 2550 are similar */
> >> +             case pll_35xx:
> >> +             case pll_2550:
> >> +                     init.ops = &samsung_pll35xx_clk_ops;
> >> +                     break;
> >> +             /* clk_ops for 36xx and 2650 are similar */
> >> +             case pll_36xx:
> >> +             case pll_2650:
> >> +                     init.ops = &samsung_pll36xx_clk_ops;
> >> +                     break;
> >> +             default:
> >> +                     pr_warn("%s: Unknown pll type for pll clk
> >> %s\n",
> >> +                             __func__, list->name);
> >> +             }
> >> +
> >> +             pll->hw.init = &init;
> >> +             pll->type = list->type;
> >> +             pll->lock_reg = base + list->lock_offset;
> >> +             pll->con_reg = base + list->con_offset;
> >> +
> >> +             clk = clk_register(NULL, &pll->hw);
> >> +             if (IS_ERR(clk)) {
> >> +                     pr_err("%s: failed to register pll clock %s\n",
> >> +                             __func__, list->name);
> >> +                     kfree(pll);
> >> +                     continue;
> >> +             }
> >> +
> >> +             samsung_clk_add_lookup(clk, list->id);
> >> +
> >> +             if (list->alias)
> >> +                     if (clk_register_clkdev(clk, list->alias,
> >> +                             list->dev_name))
> > 
> > What about
> > 
> >                 if (!list->alias)
> >                 
> >                         return;
> >                 
> >                 ret = clk_register_clkdev(clk, list->alias, list-
> >>
> >>dev_name);
> >>
> >                 if (ret)
> >                 
> >                         pr_err("%s: failed to register lookup for %s",
> >                         
> >                                                 __func__, list->name);
> 
> its ok, but to me it looks more clear and precise inside if(){ },
> as its length and indentation is not much deep.
> If you really insist we can do it ?

Well, you can read the code as the CPU does - if you are not interested in 
the alias you can see instantly that you don't have to read this function 
any more, because it returns if alias is NULL.

And it's always good to have lower indentation level. :)

> >> +                             pr_err("%s: failed to register lookup
> >> for
> > 
> > %s",
> > 
> >> +                                     __func__, list->name);
> >> +     }
> >> +}
> >> 
> >> +struct samsung_pll_clock {
> >> +     unsigned int            id;
> >> +     const char              *dev_name;
> >> +     const char              *name;
> >> +     const char              *parent_name;
> >> +     unsigned long           flags;
> >> +     const int               con_offset;
> >> +     const int               lock_offset;
> > 
> > I don't see any point of having all those const qualifiers of non-
> > pointers. This makes the struct useless for creating and initializing
> > at runtime.
> 
> OK, will remove it.
> 
> >> +     enum                    samsung_pll_type type;
> > 
> > IMHO the enum keyword shouldn't be separated from enum name like this.
> 
> Any specific reason?  Just to keep indentation same for all members, I
> used tabs :).

Well, "enum samsung_pll_type" is the type name, not "enum" and "type" is 
name of the member, not "samsung_pll_type type".

Just imagine "unsigned long x" separated to "unsigned" "long x". Isn't it 
a bit awkward?

Anyway, thanks for your good work on improving this patch series 
continuously. :)

Best regards,
Tomasz

> > Otherwise the patch looks fine. Maybe it's a bit too big - things
> > could be done a bit more gradually, like:
> > 1) first add required structs and functions,
> > 2) then move existing clock drivers to use the new API, possibly one
> > patch per driver,
> > 3) remove the old API.
> > 
> > This would make the whole change easier to review and, in case of any
> > regressions, easier to track down the problem.
> 
> OK, I will split it.
> 
> Thanks,
> Yadwinder
