From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sat, 17 Jan 2015 17:03:04 +0100
Subject: [PATCH] USB: host: ehci_atmel: Add suspend/resume support
In-Reply-To: <20150117135857.71dae08f@bbrezillon>
References: <1421437274-31615-1-git-send-email-sylvain.rochet@finsecur.com>
 <20150117013442.GV3843@piout.net>
 <20150117103609.276efecf@bbrezillon>
 <20150117104259.GA24176@gradator.net>
 <20150117135857.71dae08f@bbrezillon>
Message-ID: <20150117160304.GA21820@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Boris,


On Sat, Jan 17, 2015 at 01:58:57PM +0100, Boris Brezillon wrote:
> On Sat, 17 Jan 2015 11:43:00 +0100 Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:
> > 
> > I agree, but it depends on what we mean with standby vs mem, there 
> > should be a difference between the two sleep mode.
> 
> AFAIU PM_SUSPEND_MEM mode only implies putting the SDRAM in
> self-refresh mode to avoid waking the processor up for periodic SDRAM
> bank refresh.
> IMO this should not impact other peripherals behavior (BTW I haven't
> found any USB driver testing for this suspend state before disabling
> their clks).

This is my understanding as well.


> And what if we decide to implement runtime PM for this peripheral ?
> Shouldn't we disable these clks (which are one of the main source of
> power consumption of this IP) ?

Of course we should, disengaging clocks and stopping unused PLL and 
crystals is almost the only way to save power.


Should I have added the "Acked-by: Alexandre Belloni 
<alexandre.belloni@free-electrons.com>" on 1/2 ?


> > This behavior follows what the Atmel OHCI driver is currently doing.
> 
> Yes, but it doesn't mean we should do the same ;-), especially since
> we're trying to remove this at91_suspend_entering_slow_clock function.

Arrg, this is not what I meant ;-), anyway, proposing as well a change 
which remove the at91_suspend_entering_slow_clock() from OHCI.

I am not so happy with the global clocked boolean, but I guess this is 
necessary if a suspended device gets removed.


> > > Is there such a big penalty when resuming the device if the PLL and
> > > peripheral clocks are disabled ?
> > 
> > There is a penalty, starting up a PLL takes about 500 ?s, however I 
> > can't decide if this is a small or a big penalty.
> 
> That's indeed not negligible, but when one enters suspend, I guess it
> does expect some latency to resume from the suspended state.

Overall resume of all drivers takes about 300 ms, whichever chosen 
suspend mode. Suspend to ram with slow clock mode enabled adds about 15 ms
of resume time.

As a side note, unfortunately AT91 slow clock mode only work on "recent" 
boards with Wenyou changes on linux4sam/linux-at91/linux-3.10-at91 
branch and is why I am still stuck to this branch (and the HLCDC FB 
driver, but this is going to be merged soon from what I saw, YAY !).


Sylvain
