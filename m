From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 24 Oct 2016 14:44:16 +0100
Subject: [PATCH] ARM: sti: stih410-clocks: Add PROC_STFE as a critical
 clock
In-Reply-To: <20161024085304.GE14477@dell>
References: <1476804957-24000-1-git-send-email-peter.griffin@linaro.org>
 <20161024085304.GE14477@dell>
Message-ID: <20161024134416.GB10440@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, 24 Oct 2016, Lee Jones wrote:

> On Tue, 18 Oct 2016, Peter Griffin wrote:
> 
> > Once the ST frontend demux HW IP has been enabled, the clock can't
> > be disabled otherwise the system will hang and the board will
> > be unserviceable.
> > 
> > To allow balanced clock enable/disable calls in the driver we use
> > the critical clock infrastructure to take an extra reference on the
> > clock so the clock will never actually be disabled.
> 
> This is an abuse of the critical-clocks framework, and is exactly the
> type of hack I promised the clk guys I'd try to prevent.

I expect the best way to do this would be to write some documentation on the
clock-critical DT binding and/or CRITICAL_CLK flag. The only documentation I can
find currently is with the initial patch series [1] and the comment in
clk-provider.h of

 #define CLK_IS_CRITICAL         BIT(11) /* do not gate, ever */

Or the patch decription

"Critical clocks are those which must not be gated, else undefined
or catastrophic failure would occur.  Here we have chosen to
ensure the prepare/enable counts are correctly incremented, so as
not to confuse users with enabled clocks with no visible users."

Which is the functionality I want for this clock.

> If this, or
> any other IP has some quirks (i.e. once enabled, if this clock is
> subsequently disabled it will have a catastrophic effect on the
> platform), then they should be worked around in the driver.
> 
> The correct thing to do here is craft a clk-keep-on flag and ensure it
> is set to true for the effected platform(s)' platform data.

I'm always wary of creating a driver specific flag, especially when its
purpose is to do the same thing as an existing mechanism provided by the
subsystem of not gating the clock.

I can see a couple of problems with what you propose:

1) You have to put the clk-keep-on flag in every driver which consumes the
clock. IMO it is much better to have this knowledge in the SoC's
clock driver so every consumer of the clock automatically benefits.

2) You don't benefit from the CLK_IS_CRITICAL reference counting logic in
clk.c. So then each driver has to also work around that to get sensible reference
counts. e.g.

if (!__clk_is_enabled(clk) && pdata->clk-keep-on)
   clk_enable(clk)

Which seems to me to be fighting against the subsystem. Given that the only use of
 _clk_is_enabled() outside drivers/clk is in an old arch/arm/mach-omap2/pm24xx.c
driver I suspect its use is frowned upon, and it shouldn't really be an EXPORTED_SYMBOL.

regards,

Peter.

[1] https://lkml.org/lkml/2016/1/18/272
