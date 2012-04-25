From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 25 Apr 2012 05:48:04 +0000
Subject: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree data
In-Reply-To: <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com>
 <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FD175@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 06:33:26, Paul Walmsley wrote:
> Hello Vaibhav, Afzal, Vaibhav,
> 
> On Tue, 3 Apr 2012, Vaibhav Hiremath wrote:
> 
> > AM33XX clock implementation is different than any existing OMAP
> > family of devices. Although DPLL module is similar to OMAP4
> > device, but the usage is very much different than OMAP4.
> > AM33XX has different peripheral set and each module gets
> > integrated to the clock framework differently than OMAP
> > family of devices.
> > 
> > This patch adds full Clock tree data for AM33XX family
> > of devices and also integrates it into existing OMAP framework.
> 
> What do you think about the possibility of removing all of the leaf clocks
> that have AM33XX_MODULEMODE_SWCTRL as their .enable_bit, assuming there 
> are no .fixed_div or .clksel* fields associated with the clocks?
> 
> In theory, I don't think they are needed.  The drivers should be using 
> runtime PM, and that should enable and disable the module via the hwmod 
> code, rather than the clock code.
> 
> Of course some clocks would still be needed for the main_clk fields for 
> the hwmods, but the hwmods should be able to use the leaf clock's parent 
> clocks for that.
> 
> That would save quite a few lines of data.  And I think Beno?t is planning 
> to do that for OMAP4+.
> 
> What do you think?
> 

Paul,

Yes, theoretically it is possible to do it. But it will also break some of 
the existing things, like,

1. DebugFS clock interface

I believe, with this change, you will not have all the leaf nodes as part of clock tree, so they will not be populated in /debug/clock/

2. Enable and disable of the module is one part, but what about, changing 
   the rate of the clock (followparent_recalc)? 
   With the proper and complete clock tree, you can traverse the clock and 
   driver code doesn't need to know about parent. 
   Driver can simply call clk_set_rate() on leaf clock, and clock tree will 
   handle it.

If at all we take this path, we have to build the clk node runtime 
(on-the-fly), AND/OR add new pm_runtime_set_rate() api.

Are you available on IRC chat anytime? We can discuss on this and align 
quickly.
I am available on linux-omap irc channel (with the name = "hvaibhav")

Thanks,
Vaibhav

> 
> - Paul
> 
