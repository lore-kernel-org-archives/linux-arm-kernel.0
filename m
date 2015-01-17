From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 17 Jan 2015 13:58:57 +0100
Subject: [PATCH] USB: host: ehci_atmel: Add suspend/resume support
In-Reply-To: <20150117104259.GA24176@gradator.net>
References: <1421437274-31615-1-git-send-email-sylvain.rochet@finsecur.com>
 <20150117013442.GV3843@piout.net>
 <20150117103609.276efecf@bbrezillon>
 <20150117104259.GA24176@gradator.net>
Message-ID: <20150117135857.71dae08f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 17 Jan 2015 11:43:00 +0100
Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:

> Hi Boris,
> 
> 
> On Sat, Jan 17, 2015 at 10:36:09AM +0100, Boris Brezillon wrote:
> > On Sat, 17 Jan 2015 02:34:42 +0100 Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> > > 
> > > We should definitely find a way to get rid of
> > > at91_suspend_entering_slow_clock() at some point in time.
> > 
> > Can't we just disable clocks without testing for target_state ==
> > PM_SUSPEND_MEM (which is exactly what at91_suspend_entering_slow_clock
> > does [1]) when entering suspend ?
> > I mean, IMHO other kind of suspend should still benefit from the power
> > save induced by this PLL deactivation.
> 
> I agree, but it depends on what we mean with standby vs mem, there 
> should be a difference between the two sleep mode.

AFAIU PM_SUSPEND_MEM mode only implies putting the SDRAM in
self-refresh mode to avoid waking the processor up for periodic SDRAM
bank refresh.
IMO this should not impact other peripherals behavior (BTW I haven't
found any USB driver testing for this suspend state before disabling
their clks).

And what if we decide to implement runtime PM for this peripheral ?
Shouldn't we disable these clks (which are one of the main source of
power consumption of this IP) ?

> 
> This behavior follows what the Atmel OHCI driver is currently doing.

Yes, but it doesn't mean we should do the same ;-), especially since
we're trying to remove this at91_suspend_entering_slow_clock function.

> 
> 
> > Is there such a big penalty when resuming the device if the PLL and
> > peripheral clocks are disabled ?
> 
> There is a penalty, starting up a PLL takes about 500 ?s, however I 
> can't decide if this is a small or a big penalty.

That's indeed not negligible, but when one enters suspend, I guess it
does expect some latency to resume from the suspended state.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
