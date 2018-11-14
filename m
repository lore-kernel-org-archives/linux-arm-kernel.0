From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Nov 2018 14:16:32 +0000
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <alpine.LNX.2.21.1811141142490.8@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811141142490.8@nippy.intranet>
Message-ID: <20181114141632.GT30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2018 at 02:17:09PM +1100, Finn Thain wrote:
> On Tue, 13 Nov 2018, Russell King - ARM Linux wrote:
> 
> > 
> > A clocksource provides a cycle counter that monotonically changes and 
> > does not wrap between clockevent events.
> > 
> > A clock event is responsible for providing events to the system when 
> > some work is needing to be done, limited by the wrap interval of the 
> > clocksource.
> > 
> > Each time the clock event triggers an interrupt, the clocksource is
> > read to determine how much time has passed, using:
> > 
> > 	count = (new_value - old_value) & available_bits
> > 	nanosecs = count * scale >> shift;
> > 
> > If you try to combine the clocksource and clockevent because you only
> > have a single counter, and the counter has the behaviour of:
> > - counting down towards zero
> > - when reaching zero, triggers an interrupt, and reloads with N
> > 
> > then this provides your clockevent, but you can't use this as a clock
> > source, because each time you receive an interrupt and try to read the
> > counter value, it will be approximately the same value.  This means
> > that the above calculation fails to register the correct number of
> > nanoseconds passing.  Hence, this does not work.
> > 
> > Also note where I said above that the clock event device must be able
> > to provide an interrupt _before_ the clocksource wraps - clearly with
> > such a timer, that is utterly impossible.
> > 
> > The simple solution is to not use such a counter as the clocksource,
> > which means you fall back to using the jiffies clocksource, and your
> > timekeeping has jiffy resolution - so 10ms, or possibly 1ms if you
> > want a 1kHz timer interval.  For most applications, that's simply way
> > to coarse, as was realised in the very early days of Linux.
> > 
> > If only there was a way to interpolate between timer interrupts...
> > which is exactly what arch_gettimeoffset() does, and is a historical
> > reminant of the pre-clocksource/clockevent days of the kernel - but
> > it is the only way to get better resolution from this sort of setup.
> > 
> 
> Both of the platforms in question (RPC and EBSA110) have not 
> defined(CONFIG_GENERIC_CLOCKEVENTS) and have not defined any struct 
> clock_event_device, AFAICT.

Correct, because they don't use clockevents.  This is pre-clocksource,
pre-clockevent code, it uses the old timekeeping infrastructure,
which is xtime_update() and providing a gettimeoffset implementation.

> So, even assuming that you're right about the limitations of single-timer 
> platforms in general, removal of arch_gettimeoffset wouldn't require the 
> removal of any platforms, AFAICT.

I haven't proposed removing platforms.

I'm just objecting to the idea of removing arch_gettimeoffset(),
thereby causing a regression by changing the resolution of
gettimeofday() without any sign of equivalent functionality.

However, I now see (having searched mailing lists) what you are
trying to do - you have _not_ copied me or the mailing lists I'm
on with your cover message, so I'm *totally* lacking in the context
of your patch series, particularly where you are converting m68k
to use clocksources without needing the gettimeoffset() stuff.

You have failed to explain that in this thread - probably assuming
that I've read your cover message.  I haven't until now, because
you never sent it to me or the linux-arm-kernel mailing list.

I have found this thread _very_ frustrating, and frankly a waste of
my time discussing the finer points because of this lack of context.
Please ensure that if you're going to be sending a patch series,
that the cover message at least finds its way to the intended
audience of your patches, so that everyone has the context they
need when looking at (eg) the single patch they may receive.

Alternatively, if someone raises a problem with the patch, and you
_know_ you haven't done that, then please consider informing them
where they can get more context, eg, by providing a link to your
archived cover message.  It would help avoid misunderstandings.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
