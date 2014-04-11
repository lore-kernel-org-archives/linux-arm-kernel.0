From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 11 Apr 2014 16:27:16 +0800
Subject: [PATCH RESEND 2/5] pinctrl: berlin: add a pinctrl driver for
 Marvell Berlin SoCs
In-Reply-To: <20140411081839.GB20147@kwain>
References: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397135274-10764-3-git-send-email-antoine.tenart@free-electrons.com>
 <20140411144431.04fb148d@xhacker> <20140411081839.GB20147@kwain>
Message-ID: <20140411162716.74e739e1@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

On Fri, 11 Apr 2014 01:18:39 -0700
Antoine T?nart <antoine.tenart@free-electrons.com> wrote:

> Hi Jisheng,
> 
> On Fri, Apr 11, 2014 at 02:44:31PM +0800, Jisheng Zhang wrote:
> > On Thu, 10 Apr 2014 06:07:51 -0700
> > Antoine T?nart <antoine.tenart@free-electrons.com> wrote:
> > 
> > ...
> > > +static int berlin_pinmux_enable(struct pinctrl_dev *pctrl_dev,
> > > +                               unsigned function,
> > > +                               unsigned group)
> > > +{
> > > +       struct berlin_pinctrl *pctrl =
> > > pinctrl_dev_get_drvdata(pctrl_dev);
> > > +       struct berlin_pinctrl_group *group_desc = pctrl->groups + group;
> > > +       struct berlin_pinctrl_function *function_desc =
> > > +               pctrl->functions + function;
> > > +       unsigned long flags;
> > > +       u32 regval;
> > > +
> > > +       spin_lock_irqsave(&pctrl->lock, flags);
> > > +
> > > +       regval = readl(group_desc->reg);
> > > +       regval &= group_desc->mask;
> > > +       regval |= function_desc->muxval << group_desc->lsb;
> > > +       writel(regval, group_desc->reg);
> > 
> > Could we use relaxed version instead?
> 
> We could, but this is not a performance issue here at all, so I guess we can
> keep writel().

Yes it's not a performance issue here but an issue for the system which is doing
PL310 L2 cache maintenance. If pinmux operation hold the l2x0_lock due to writel()
the important video/audio process which is cleaning PL310 cache must wait, thus
cause jitter. So I'd like relaxed version if we can. Then I don't need to add this
patch to mainline kernel when we upgrade internal tree.

Thanks,
Jisheng
