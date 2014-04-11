From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Fri, 11 Apr 2014 10:18:39 +0200
Subject: [PATCH RESEND 2/5] pinctrl: berlin: add a pinctrl driver for
 Marvell Berlin SoCs
In-Reply-To: <20140411144431.04fb148d@xhacker>
References: <1397135274-10764-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397135274-10764-3-git-send-email-antoine.tenart@free-electrons.com>
 <20140411144431.04fb148d@xhacker>
Message-ID: <20140411081839.GB20147@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

On Fri, Apr 11, 2014 at 02:44:31PM +0800, Jisheng Zhang wrote:
> On Thu, 10 Apr 2014 06:07:51 -0700
> Antoine T?nart <antoine.tenart@free-electrons.com> wrote:
> 
> ...
> > +static int berlin_pinmux_enable(struct pinctrl_dev *pctrl_dev,
> > +                               unsigned function,
> > +                               unsigned group)
> > +{
> > +       struct berlin_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctrl_dev);
> > +       struct berlin_pinctrl_group *group_desc = pctrl->groups + group;
> > +       struct berlin_pinctrl_function *function_desc =
> > +               pctrl->functions + function;
> > +       unsigned long flags;
> > +       u32 regval;
> > +
> > +       spin_lock_irqsave(&pctrl->lock, flags);
> > +
> > +       regval = readl(group_desc->reg);
> > +       regval &= group_desc->mask;
> > +       regval |= function_desc->muxval << group_desc->lsb;
> > +       writel(regval, group_desc->reg);
> 
> Could we use relaxed version instead?

We could, but this is not a performance issue here at all, so I guess we can
keep writel().

Thanks for the feedback !

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
