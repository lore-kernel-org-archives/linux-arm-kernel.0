From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 14 Sep 2015 15:20:25 +0200
Subject: at91sam9 Main crystal frequency problems
In-Reply-To: <55F6C07C.8080803@overkiz.com>
References: <55ED3D3B.8060700@overkiz.com> <20150908181212.0b4336f0@bbrezillon>
 <55F6C07C.8080803@overkiz.com>
Message-ID: <20150914152025.059e2c8d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

On Mon, 14 Sep 2015 14:41:32 +0200
Antoine Aubert <a.aubert@overkiz.com> wrote:

> Hi Boris,
> 
> Thank you for your help. I have some news thanks to traces in clk driver.
> 
> 
> Le 08/09/2015 18:12, Boris Brezillon a ?crit :
> > Hi Antoine,
> > 
> > On Mon, 7 Sep 2015 09:31:07 +0200
> > Antoine Aubert <a.aubert@overkiz.com> wrote:
> > 
> >> Hi,
> >>
> >> I currently bring up a board based on AT91SAM9G25cu, and I having
> >> problems of watchdogs resets.
> >>
> >> We use linux-4.04 mainline, and i found some weird warnings on kernel
> >> traces, concerning main clk.
> >>
> >> [    0.000000] Main crystal frequency not set, using approximate value
> >> [    0.000000] master clk is overclocked
> >> [    0.000000] sched_clock: 32 bits at 128 Hz, resolution 7812500ns,
> >> wraps every 16777216000000000ns
> >> [    0.007812] Calibrating delay loop... 198.76 BogoMIPS (lpj=775168)
> >>
> >> I set crystal clock in the DT, but it doesn't seems to work.. I feel
> >> that the board works out of the specified range.
> > 
> > According to your clk_summary dump that's not the case.
> > 
> >>
> >> So here comes my questions:
> >> Can there be a relationship with watchdog problems ? (1 per day)
> > 
> > I'd say no, but could you tell me more about your watchdog issues.
> 
> Yet, we did not take the analysis. We just observed these resets.
> 
> But, I found a clue:
> We recently removed the slow clock to the PCB. I forgot to disabled the
> slow_xtal. :/
>  Can there be a link ? (I think so...)

Yep. The watchdog timer is based on the slow clock, which is taking its
source from the crystal oscillator (requires a 32KHz external crystal),
or the internal RC oscillator.
Since the internal RC oscillator is not as accurate as the one using an
external crystal (+-5%), you might just reset the watchdog a bit too
late.

Also, if you don't have this crystal, the clk event device is not
reliable (unless you made a patch to change its source to one of the
main clk divisor instead of the slow clk), but that should not impact
the watchdog part.

> 
> > 
> >> Why is it that the frequency of Crystal is not found ?
> > 
> > That's a good question, and honestly I don't. Everything seems to be
> > defined properly in your device tree.
> > 
> > Could you add some traces in the fixed-rate clk driver [1] to see if the
> > main_xtal is correctly registered and if its registration occurs before
> > the main_osc registration?
> 
> On our board, there is two kernel boot phases.
> 
> First, we boot from at91-bootstrap.
> Second we launched kexec with an other kernel.

Yes, I kinda know this workflow :-).

> 
> I found that the device tree is well loaded from the at91-bootstrap. Any
> crystal issues. But, on kexec --exec, (with the same kernel) those
> issues appears. (see dmesg attached)
> 
> If I launch kexec with --dtb, it's working ...
> I thought kexec keep old dtb. Was I wrong ?

AFAIR, kexec is able to use the content of /proc/device-tree and create
a dtb image to pass to the new kernel, but are you using the same
kernel (4.0.4) for your "linux-based" bootloader?
If that's not the case, then you're not supposed to pass the same
device tree (see this note [1]).

Best Regards,

Boris


[1]http://lxr.free-electrons.com/source/Documentation/arm/Atmel/README#L105

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
