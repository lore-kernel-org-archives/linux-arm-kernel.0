From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 25 Apr 2012 10:20:35 +0000
Subject: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree data
In-Reply-To: <4F97B891.1020601@ti.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FD175@DBDE01.ent.ti.com>
 <4F97B891.1020601@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FD707@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 14:10:49, Cousson, Benoit wrote:
> Hi Vaibhav,
> 
> On 4/25/2012 7:48 AM, Hiremath, Vaibhav wrote:
> > On Wed, Apr 25, 2012 at 06:33:26, Paul Walmsley wrote:
> >> Hello Vaibhav, Afzal, Vaibhav,
> >>
> >> On Tue, 3 Apr 2012, Vaibhav Hiremath wrote:
> >>
> >>> AM33XX clock implementation is different than any existing OMAP
> >>> family of devices. Although DPLL module is similar to OMAP4
> >>> device, but the usage is very much different than OMAP4.
> >>> AM33XX has different peripheral set and each module gets
> >>> integrated to the clock framework differently than OMAP
> >>> family of devices.
> >>>
> >>> This patch adds full Clock tree data for AM33XX family
> >>> of devices and also integrates it into existing OMAP framework.
> >>
> >> What do you think about the possibility of removing all of the leaf clocks
> >> that have AM33XX_MODULEMODE_SWCTRL as their .enable_bit, assuming there
> >> are no .fixed_div or .clksel* fields associated with the clocks?
> >>
> >> In theory, I don't think they are needed.  The drivers should be using
> >> runtime PM, and that should enable and disable the module via the hwmod
> >> code, rather than the clock code.
> >>
> >> Of course some clocks would still be needed for the main_clk fields for
> >> the hwmods, but the hwmods should be able to use the leaf clock's parent
> >> clocks for that.
> >>
> >> That would save quite a few lines of data.  And I think Beno?t is planning
> >> to do that for OMAP4+.
> >>
> >> What do you think?
> >>
> >
> > Paul,
> >
> > Yes, theoretically it is possible to do it. But it will also break some of
> > the existing things, like,
> >
> > 1. DebugFS clock interface
> >
> > I believe, with this change, you will not have all the leaf nodes as part of clock tree, so they will not be populated in /debug/clock/
> >
> > 2. Enable and disable of the module is one part, but what about, changing
> >     the rate of the clock (followparent_recalc)?
> >     With the proper and complete clock tree, you can traverse the clock and
> >     driver code doesn't need to know about parent.
> >     Driver can simply call clk_set_rate() on leaf clock, and clock tree will
> >     handle it.
> >
> > If at all we take this path, we have to build the clk node runtime
> > (on-the-fly), AND/OR add new pm_runtime_set_rate() api.
> 
> Not at all. You just have to get the fck of that hwmod and use the clock 
> API.
> 
> > Are you available on IRC chat anytime? We can discuss on this and align
> > quickly.
> > I am available on linux-omap irc channel (with the name = "hvaibhav")
> 
> That will not change anything, the point is that MODULEMODE_SWCTRL is 
> uses for module control, not for clock directly, and that's why it is 
> handled by the hwmod.
> 
> That will just replace the main_clk from the hwmod with the parent of 
> the current modulemode nodes. Only the enable/disable part will be 
> handled, if that node used to have a div, then the parent will handle that.
> 
> Today this module mode clock node is just a duplication of the hwmod 
> node. By removing it, you will reduce the size of the data and have a 
> much mode accurate representation of the reality.
> 
> Using the clock tree to handle these nodes was a hack we had to do 
> because the hwmod fmwk was not ready when OMAP4 was introduced and 
> because most drivers were not using pm_runtime.
> 

Benoit,

I completely understand what are trying to explain here, and I completely agree with you on the fact that, MODULEMODE_SWCTRL is for module control and is clock node is just a duplication. 

Module enable and disable is one part, and I am not at all referring to this.
My point is, more from other piece of code which are dependent on clocktree.
In order to have proper and complete debugfs representation of all the 
clocks, somebody has to maintain the information of leaf clocks to parent 
relation, Isn't it?

For example, take OMAP44xx "dss_dss_clk" clock, OR any clock with "followparent_recalc" field, the question I am raising here is,

How would I know the rate of this clock in driver? Say for example, I want 
to configure my internal divider based on input rate? 
OR 
I want to change the rate of dss_clk itself?
OR
Looking at debugfs, would I get the rate of dss_clk? 
OR
Will I have dss_clk present in /debug/clock/?
OR 
Are we expecting user to know parent of such leaf clocks?
OR
Are we planning to export hwmod->main_clk (which is parent clk here) to
User in debugfs or something?

Thanks,
Vaibhav
> Regards,
> Benoit
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
