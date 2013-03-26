From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 26 Mar 2013 05:39:13 +0000
Subject: [PATCH] ARM: AM33XX: Add missing .clkdm_name to clkdiv32k_ick
 clock
In-Reply-To: <51513034.6020105@ti.com>
References: <1364211443-27536-1-git-send-email-hvaibhav@ti.com>
 <515044E6.5070503@ti.com>
 <79CD15C6BA57404B839C016229A409A83EC3A7BD@DBDE01.ent.ti.com>
 <51513034.6020105@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC3A7EB@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Nayak, Rajendra
> Sent: Tuesday, March 26, 2013 10:51 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap at vger.kernel.org; Tony Lindgren; Paul Walmsley; linux-
> arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: AM33XX: Add missing .clkdm_name to
> clkdiv32k_ick clock
> 
> On Tuesday 26 March 2013 10:42 AM, Hiremath, Vaibhav wrote:
> >> -----Original Message-----
> >> From: Nayak, Rajendra
> >> Sent: Monday, March 25, 2013 6:07 PM
> >> To: Hiremath, Vaibhav
> >> Cc: linux-omap at vger.kernel.org; Tony Lindgren; Paul Walmsley; linux-
> >> arm-kernel at lists.infradead.org
> >> Subject: Re: [PATCH] ARM: AM33XX: Add missing .clkdm_name to
> >> clkdiv32k_ick clock
> >>
> >> On Monday 25 March 2013 05:07 PM, Vaibhav Hiremath wrote:
> >>> During common-clock migration, .clkdm_name field got missed
> >>> for "clkdiv32k_ick" clock, which leaves "clk_24mhz_clkdm"
> >>> unused; so boot process will try to disable the clockdomain
> >>> even childs of this clock is enabled, which keeps child modules
> >>> in idle mode.
> >>
> >> The patch looks fine but I feel the change log certainly needs an
> >> update. The clkdm association with the clks is maintained for those
> >> clks which have a hard requirement that the clkdm be force woken up
> >> before the clk can be enabled. If thats the case for clkdiv32k_ick,
> >> then what you are doing makes sense,
> >
> > Yes, that?s correct. Just again to put more clarity on this,
> >
> > AM33xx clock-tree is slightly deviated compared to OMAP3/4, where
> > We do not have MODULE_MODE clock nodes populated in tree, since
> > HWMOD is handing it. CLKDIV32K_CLK is special clock gate, where
> > it is being used as MODULE_MODE, but in reality it is simple
> > clock_gate. We had multiple discussion in the past related to this
> > and infact I went back to design team on this, explained about
> > how this inconsistency is hampering SW design and recommended to fix
> > this in next SoC.
> >
> > More discussion can be found @
> > http://www.mail-archive.com/linux-omap at vger.kernel.org/msg69087.html
> >
> >
> > Coming back to your comment, I will change commit description
> > And also try to add above details.
> 
> Great, thanks. I also had a brief look at the am335x clock data
> yesterday
> and found most clocks with clkdm associations are actually mux clocks.
> Do you really need those? clkdm associations make sense for gate
> clocks.
> You should be very easily able to convert these over to generic mux
> types
> if you can drop the clkdm handling part for those muxes.
> 
We need that, and for the exact same reason you pointed out in last response
We need to enabled the clockdomain before enabling the module clock.
With not having leaf clocks in clock-tree HWMOD data points to parent clock,
Which in most of the cases ends up into clock mux. So in order to have
Link between hwmod<->clock<->clock-domain we need that entry.

Thanks,
Vaibhav
