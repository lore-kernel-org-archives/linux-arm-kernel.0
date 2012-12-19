From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 19 Dec 2012 10:03:26 +0100
Subject: common clock framwork: clk_set_rate issue
In-Reply-To: <CADApbej8ddpgQAgr3ghMJaQfwcKk_bQe++MaHiRECzpPZNCuXg@mail.gmail.com>
References: <CADApbej+f9P1sgLMR8_McoCCSLDjJt_qitWdNd8X1v6PwZqsnQ@mail.gmail.com>
 <20121217201945.GA19651@pengutronix.de>
 <CADApbej17udzpStNeY+tsSkeOy_Fv2+o+zKs4zBLV8+ST4DWTg@mail.gmail.com>
 <20121218074711.GU26326@pengutronix.de>
 <CADApbej8ddpgQAgr3ghMJaQfwcKk_bQe++MaHiRECzpPZNCuXg@mail.gmail.com>
Message-ID: <20121219090326.GX26326@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 02:49:25PM +0800, Chao Xie wrote:
> On Tue, Dec 18, 2012 at 3:47 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >> There is already a flag to do it.
> >> CLK_SET_RATE_PARENT
> >
> > That flag has another meaning. It means that a clock is allowed to
> > change the parents rate when a rate change is requested. What I meant
> > is a flag that allows a mux to change its parent when a rate change is
> > requested.
> >
> another flag can help it. what i mean is that i can clear the flag
> CLK_SET_RATE_PARENT of MUX's children, so when clock changing will not
> impact the MUX.
> 
> >> if the mux does not want to changes the input for clk_set_rate called
> >> by its child, it can clear this flag.
> >> The question is whether we need add the round_rate/recalc_rate for MUX
> >> type of clock? Is there any special issue about it that why current
> >> MUX implementation does not have these callbacks?
> >
> > They currently do not need these callbacks. When a clock does not have
> > round_rate propagates up to the parent if CLK_SET_RATE_PARENT is set or
> > it returns the parents rate if this flag is not set. The situation with
> > set_rate is similar.
> >
> So it means that for a uart clock  that get its clock from
> MUX --> DIV --> UART
> when uart want to change its rate, the driver has to know the topology
> of clock tree. It can not directly clk_set_rate(uart), because it only
> change the DIV settings, and if we want to change the MUX input, we
> have to invoke clk_set_parent(MUX). So the uart driver need to know
> the clock tree topology, and it is not good for sharing a driver
> between mutiple SOCs that has same UART controller IP.
> That is what i am confused about.

A driver shouldn't need to know the clock topology. If you have a setup
like described above and want to have the mux look for the best parent
during rate change, then a new flag for the mux is needed, something
like:

CLK_SET_RATE_SWITCH_PARENT (1 << x) /* allow to change parent on clk_set_rate /*

For the reasons I described earlier in this thread this would have to be
optional as on i.MX I don't want magic parent changes to happen on a
rate change.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
