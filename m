From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Oct 2016 11:01:41 +0100
Subject: [PATCH] ARM: sti: stih410-clocks: Add PROC_STFE as a critical
 clock
In-Reply-To: <20161025093926.GA3206@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1476804957-24000-1-git-send-email-peter.griffin@linaro.org>
 <20161024085304.GE14477@dell>
 <20161024134416.GB10440@griffinp-ThinkPad-X1-Carbon-2nd>
 <20161025074257.GF8574@dell>
 <20161025093926.GA3206@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20161025100141.GH8574@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Oct 2016, Peter Griffin wrote:

> Hi Lee,
> 
> On Tue, 25 Oct 2016, Lee Jones wrote:
> 
> > On Mon, 24 Oct 2016, Peter Griffin wrote:
> > 
> > > Hi Lee,
> > > 
> > > On Mon, 24 Oct 2016, Lee Jones wrote:
> > > > On Tue, 18 Oct 2016, Peter Griffin wrote:
> > > > 
> > > > > Once the ST frontend demux HW IP has been enabled, the clock can't
> > > > > be disabled otherwise the system will hang and the board will
> > > > > be unserviceable.
> > > > > 
> > > > > To allow balanced clock enable/disable calls in the driver we use
> > > > > the critical clock infrastructure to take an extra reference on the
> > > > > clock so the clock will never actually be disabled.
> > > > 
> > > > This is an abuse of the critical-clocks framework, and is exactly the
> > > > type of hack I promised the clk guys I'd try to prevent.
> > > 
> > > I expect the best way to do this would be to write some documentation on the
> > > clock-critical DT binding and/or CRITICAL_CLK flag. The only documentation I can
> > > find currently is with the initial patch series [1] and the comment in
> > > clk-provider.h of
> > > 
> > >  #define CLK_IS_CRITICAL         BIT(11) /* do not gate, ever */
> > > 
> > > Or the patch decription
> > > 
> > > "Critical clocks are those which must not be gated, else undefined
> > > or catastrophic failure would occur.  Here we have chosen to
> > > ensure the prepare/enable counts are correctly incremented, so as
> > > not to confuse users with enabled clocks with no visible users."
> > > 
> > > Which is the functionality I want for this clock.
> > 
> > No, that's not the functionality you want.
> 
> Yes it is :)

No, it's the functionally that is most convenient.

> >  You want for the clock not
> > to be RE-gated (big difference).  Currently, the STFE clock will never
> > be gated, even when a) it's not used and b) can actually be disabled.
> > You're needlessly wasting power here.
> 
> IMO it is *never* safe for Linux to gate this clock, as you have no idea
> on the state of the hardware from the primary and secondary bootloaders.

You can say that with any of the clocks on this platform.

> If the clock is enabled when Linux boots, the Linux clock framework *needs*
> to assume the hardware may have been used in previous boot stages, and it should
> not attempt to disable the clock.

None of the boot loaders we use do this.

I have never seen the STFE clock crash a platform.

> > Also, in your use-case there is a visible user, and the prepare/enable
> > counts will be correct.
> 
> Your correct there is a visible user, but this is the same as CLK_EXT2F_A9 where
> there are multiple users of the clock (SPI, I2C, UART etc).

Right, but their clocks can not be turned off, ever.  So all the boxes
are ticked for criticalness.  Not the case with your clock.

> > > > If this, or
> > > > any other IP has some quirks (i.e. once enabled, if this clock is
> > > > subsequently disabled it will have a catastrophic effect on the
> > > > platform), then they should be worked around in the driver.
> > > > 
> > > > The correct thing to do here is craft a clk-keep-on flag and ensure it
> > > > is set to true for the effected platform(s)' platform data.
> > > 
> > > I'm always wary of creating a driver specific flag, especially when its
> > > purpose is to do the same thing as an existing mechanism provided by the
> > > subsystem of not gating the clock.
> > 
> > Using existing sub-system supplied mechanisms in the way they were not
> > intended is sub-optimal (read "hacky").
> 
> I think the scope of this flag has been defined in a very narrow way, which is
> making you want to suggest lots of hacks in the client driver.

The scope was narrowed intentionally, buy the maintainers.  I am
merely reflecting their views.  If you really wish to contend these,
you should take it up with them.

> > > I can see a couple of problems with what you propose:
> > > 
> > > 1) You have to put the clk-keep-on flag in every driver which consumes the
> > > clock. IMO it is much better to have this knowledge in the SoC's
> > > clock driver so every consumer of the clock automatically benefits.
> > 
> > That would also be fine(ish).  The issue is that this problem is
> > board specific, so the platform clock driver would have to contain
> > board level knowledge.
> 
> It is not board specific. It is a SoC HW bug, so by definition present on all
> boards which have this SoC.

Okay SoC specific.  Is there a SoC specific clock driver?

> >  Also, if you were to implement this, it would
> > too mess up reference counting in the core.

This still stands.

> > > 2) You don't benefit from the CLK_IS_CRITICAL reference counting logic in
> > > clk.c. So then each driver has to also work around that to get sensible reference
> > > counts. e.g.
> > > 
> > > if (!__clk_is_enabled(clk) && pdata->clk-keep-on)
> > >    clk_enable(clk)
> > > 
> > > Which seems to me to be fighting against the subsystem. Given that the only use of
> > >  _clk_is_enabled() outside drivers/clk is in an old arch/arm/mach-omap2/pm24xx.c
> > > driver I suspect its use is frowned upon, and it shouldn't really be an EXPORTED_SYMBOL.
> > 
> > In this instance, since the STFE clock is only used by this IP, I
> > would choose to handle it in the driver.
> 
> There are other IPs within this IP block for which upstream drivers don't yet exist.

If they are many and various, we can discuss alternative solutions.

What are they?

> >  This can be done using a
> > single flag stored in pdata which should be fetched using
> > of_match_device().  This way there is no need for any more API abuse;
> > either by incorrectly identifying the STFE clock as critical OR
> > invoking any internal __clk_*() calls.
> > 
> > Enable the clock once in .probe(), which you already do.
> 
> But these drivers are by default built as modules, so when you rmmod, and insmod the
> driver you now have an ever increasing clock reference count. This is the
> problem I was describing in the previous email, and why what you propose is a
> bad idea.

Then the variable would have to be exported.

> > Then, whenever you do any power saving do:
> > 
> > suspend()
> > {
> > 	if (!ddata->enable_clk_once)
> > 		clk_disable(clk);
> > }
> > 
> > resume()
> > {
> > 	if (!ddata->enable_clk_once)
> > 		clk_enable(clk);
> > }
> > 
> > However, looking at your driver, I think this point might even be
> > moot, since you don't have any power saving.  The only time you
> > disable the clock is in the error path.  Just replace that with a
> > comment about the platform's unfortunate errata.
> 
> This is exactly what I want to avoid doing. The driver already has these
> hacks as it was waiting for the critical clock patches to land so I could remove
> them and fix the problem properly.
> 
> Much like you did with the I2C and SPI drivers, where you removed similar hacks
> and added the clock to the critical clock list.

Right, see above.

> > > [1] https://lkml.org/lkml/2016/1/18/272
> > 
> > I'm glad you mentioned this.  Let's take a look:
> > 
> > > Some platforms contain clocks which if gated, will cause undefined or
> > > catastrophic behaviours.  As such they are not to be turned off, ever.
> > 
> > Not the case here.
> > 
> > This clock *can* be gated and can be turned off *sometimes*.
> 
> See above, if the clock is on when Linux boots it can never be assumed that it
> is safe to disable it.

See above.

> > > Many of these such clocks do not have devices, thus device drivers
> > > where clocks may be enabled and references taken to ensure they stay
> > > enabled do not exist.  Therefore, we must handle these such cases in
> > > the core.
> > 
> > This clock *does* have a driver and correct references *can* be
> > taken.
> 
> As above this is the same for CLK_EXT2F_A9, which has multiple users in the
> kernel.
> 
> The point is we don't wish to have the knowledge in the individual drivers that
> this clock is critical and can destroy the system if it is disabled.
> 
> > 
> > [...]
> > 
> > All I'm saying is, and it's the same thing I've said many times; these
> > types of issues do not exhibit the same set of symptoms as a critical
> > clock by definition.  Critical clocks are those which references can
> > not be taken by any other means.
> 
> That is not how you are using it currently. See CLK_EXT2F_A9 and
> CLK_TX_ICN_DMU.
> 
> >  Think of the critical clock
> > framework as a mechanism to circumvent the requirement of writing a
> > special driver which would *only* handle clocks i.e. an interconnect
> > driver in the ST case.
> > 
> 
> You didn't need a new flag for that. CLK_IGNORE_UNUSED already allowed you to not
> write a specical driver which only handled for example an interconnect clock and
> would ensure it wouldn't be gated by the disable_unused logic.
> 
> IMO the point of the critical clock stuff, and what CLK_IGNORE_UNUSED *did not* allow
> you to do is for situations like CLK_EXT2F_A9, CLK_TX_ICN_DMU and PROC_STFE where users
>  *do* exist in the kernel, but the SoC clock driver has *special* knowledge of the
> clock tree on the SoC and knows that despite what the drivers are doing with
> their enable/disable calls the clock should never be disabled.
> 
> In fact out of what we currently mark as clock-critical on STi platform most
> of the clocks could have been handled perfectly fine with the CLK_IGNORE_UNUSED
> flag (apart from the fact that there is no way to set the flag from DT). It is
> only CLK_EXT2F_A9 and CLK_TX_ICN_DMU which *do* have kernel users where the
> extra functionality of critical clocks is required (we need the additional
> reference taken by the clk framework to avoid the kernel drivers from disabling
> the clock).

Probably best to take your special use-case up with the Clock
Maintainers.  As the author of the critical-clocks patch-set, I would
say that your use-case does not tick all the boxes for use of the
critical-clock mechanism, but at the end of the day, it really isn't
my train-set.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
