From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Oct 2016 08:42:57 +0100
Subject: [PATCH] ARM: sti: stih410-clocks: Add PROC_STFE as a critical
 clock
In-Reply-To: <20161024134416.GB10440@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1476804957-24000-1-git-send-email-peter.griffin@linaro.org>
 <20161024085304.GE14477@dell>
 <20161024134416.GB10440@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20161025074257.GF8574@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Oct 2016, Peter Griffin wrote:

> Hi Lee,
> 
> On Mon, 24 Oct 2016, Lee Jones wrote:
> > On Tue, 18 Oct 2016, Peter Griffin wrote:
> > 
> > > Once the ST frontend demux HW IP has been enabled, the clock can't
> > > be disabled otherwise the system will hang and the board will
> > > be unserviceable.
> > > 
> > > To allow balanced clock enable/disable calls in the driver we use
> > > the critical clock infrastructure to take an extra reference on the
> > > clock so the clock will never actually be disabled.
> > 
> > This is an abuse of the critical-clocks framework, and is exactly the
> > type of hack I promised the clk guys I'd try to prevent.
> 
> I expect the best way to do this would be to write some documentation on the
> clock-critical DT binding and/or CRITICAL_CLK flag. The only documentation I can
> find currently is with the initial patch series [1] and the comment in
> clk-provider.h of
> 
>  #define CLK_IS_CRITICAL         BIT(11) /* do not gate, ever */
> 
> Or the patch decription
> 
> "Critical clocks are those which must not be gated, else undefined
> or catastrophic failure would occur.  Here we have chosen to
> ensure the prepare/enable counts are correctly incremented, so as
> not to confuse users with enabled clocks with no visible users."
> 
> Which is the functionality I want for this clock.

No, that's not the functionality you want.  You want for the clock not
to be RE-gated (big difference).  Currently, the STFE clock will never
be gated, even when a) it's not used and b) can actually be disabled.
You're needlessly wasting power here.

Also, in your use-case there is a visible user, and the prepare/enable
counts will be correct.

> > If this, or
> > any other IP has some quirks (i.e. once enabled, if this clock is
> > subsequently disabled it will have a catastrophic effect on the
> > platform), then they should be worked around in the driver.
> > 
> > The correct thing to do here is craft a clk-keep-on flag and ensure it
> > is set to true for the effected platform(s)' platform data.
> 
> I'm always wary of creating a driver specific flag, especially when its
> purpose is to do the same thing as an existing mechanism provided by the
> subsystem of not gating the clock.

Using existing sub-system supplied mechanisms in the way they were not
intended is sub-optimal (read "hacky").

> I can see a couple of problems with what you propose:
> 
> 1) You have to put the clk-keep-on flag in every driver which consumes the
> clock. IMO it is much better to have this knowledge in the SoC's
> clock driver so every consumer of the clock automatically benefits.

That would also be fine(ish).  The issue is that this problem is
board specific, so the platform clock driver would have to contain
board level knowledge.  Also, if you were to implement this, it would
too mess up reference counting in the core.

> 2) You don't benefit from the CLK_IS_CRITICAL reference counting logic in
> clk.c. So then each driver has to also work around that to get sensible reference
> counts. e.g.
> 
> if (!__clk_is_enabled(clk) && pdata->clk-keep-on)
>    clk_enable(clk)
> 
> Which seems to me to be fighting against the subsystem. Given that the only use of
>  _clk_is_enabled() outside drivers/clk is in an old arch/arm/mach-omap2/pm24xx.c
> driver I suspect its use is frowned upon, and it shouldn't really be an EXPORTED_SYMBOL.

In this instance, since the STFE clock is only used by this IP, I
would choose to handle it in the driver.  This can be done using a
single flag stored in pdata which should be fetched using
of_match_device().  This way there is no need for any more API abuse;
either by incorrectly identifying the STFE clock as critical OR
invoking any internal __clk_*() calls.

Enable the clock once in .probe(), which you already do.

Then, whenever you do any power saving do:

suspend()
{
	if (!ddata->enable_clk_once)
		clk_disable(clk);
}

resume()
{
	if (!ddata->enable_clk_once)
		clk_enable(clk);
}

However, looking at your driver, I think this point might even be
moot, since you don't have any power saving.  The only time you
disable the clock is in the error path.  Just replace that with a
comment about the platform's unfortunate errata.

> [1] https://lkml.org/lkml/2016/1/18/272

I'm glad you mentioned this.  Let's take a look:

> Some platforms contain clocks which if gated, will cause undefined or
> catastrophic behaviours.  As such they are not to be turned off, ever.

Not the case here.

This clock *can* be gated and can be turned off *sometimes*.

> Many of these such clocks do not have devices, thus device drivers
> where clocks may be enabled and references taken to ensure they stay
> enabled do not exist.  Therefore, we must handle these such cases in
> the core.

This clock *does* have a driver and correct references *can* be
taken.

[...]

All I'm saying is, and it's the same thing I've said many times; these
types of issues do not exhibit the same set of symptoms as a critical
clock by definition.  Critical clocks are those which references can
not be taken by any other means.  Think of the critical clock
framework as a mechanism to circumvent the requirement of writing a
special driver which would *only* handle clocks i.e. an interconnect
driver in the ST case.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
