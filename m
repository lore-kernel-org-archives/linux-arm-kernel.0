From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Jan 2012 11:37:08 +0000
Subject: [PATCH] ARM: PXA: Zipit Z2: Fix oops in z2_power_off
In-Reply-To: <201201081140.29275.marek.vasut@gmail.com>
References: <1326011616-3546-1-git-send-email-anarsoul@gmail.com>
 <201201080956.51789.marek.vasut@gmail.com>
 <CA+E=qVfYMwV_TuAdaDAZVfQfcx5-g-JEr1tUQsuwBcPpvCav+g@mail.gmail.com>
 <201201081140.29275.marek.vasut@gmail.com>
Message-ID: <20120108113708.GC21765@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 11:40:28AM +0100, Marek Vasut wrote:
> > 2012/1/8 Marek Vasut <marek.vasut@gmail.com>:
> > > That's why I said this patch (suspend the device to make it feel like
> > > powerdown) is bullshit in the first place.
> > 
> > Marek, 'deepsleep' suspend on Z2 is a way to save battery power for
> > monthes. I blew the dust off my Z2 recently (did not touch it for
> > ~2monthes), it was in fake poweroff (deepsleep), and battery is still
> > charged (not full however). I believe it can't be achieved with
> > 'sleep' suspend.
> 
> But you can put the device into this deepsleep-suspend without faking shutdown, 
> right?
> 
> > I agree that it looks weird, but it's hardware bizzarity. Btw, do you
> > have suggestions how to make it clean?
> 
> Yea ... why won't deepsleep suspend work via standard suspend interface?

Have you looked to see what pxa27x_cpu_pm_enter() does before calling
the CPU suspend function?

It appears to do some SoC setup first, to ensure that things are correctly
set before entering low power mode.  I'd be willing to bet that some of
that is still necessary (eg, ensuring that the voltage sequencer is not
running and there are no edge detect events pending) so that the SoC
really does hit the desired sleep mode.

I think the simplest, cheapest and easiest solution would be to remove the
__init on the function.


As for using sleep modes to fake shutdown - I see nothing diabolically
wrong with that.  There's been devices doing that kind of stuff for
years and years.  iPAQs for example have no way to 'power off'.

However, I'm not saying it's a good idea: iPAQs ended up in that situation
after lots of Compaq iPAQ customers complained about the little switch
beneath the cover being 'too easy' to turn off!

The result of that clever complaint is that you have to keep iPAQs
connected to their charger and plugged into the mains while you're not
expecting to use them, otherwise you end up killing the battery.  Even
if you place them in so called 'off' mode, the battery will be drained
in about a month, and if left like that the battery life suffers.

(I have two iPAQs with dead batteries because of this, which as a
result are utterly useless.  I have one other which is permanently
connected to its charger for about 350 days a year to preserve its
battery - just so it can be used for reasonable periods without
external power and losing the programs and data loaded onto it.)
