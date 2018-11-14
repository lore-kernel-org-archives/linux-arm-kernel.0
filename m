From: fthain@telegraphics.com.au (Finn Thain)
Date: Wed, 14 Nov 2018 14:17:09 +1100 (AEDT)
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <20181113234336.GP30658@n2100.armlinux.org.uk>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk>
Message-ID: <alpine.LNX.2.21.1811141142490.8@nippy.intranet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Nov 2018, Russell King - ARM Linux wrote:

> 
> A clocksource provides a cycle counter that monotonically changes and 
> does not wrap between clockevent events.
> 
> A clock event is responsible for providing events to the system when 
> some work is needing to be done, limited by the wrap interval of the 
> clocksource.
> 
> Each time the clock event triggers an interrupt, the clocksource is
> read to determine how much time has passed, using:
> 
> 	count = (new_value - old_value) & available_bits
> 	nanosecs = count * scale >> shift;
> 
> If you try to combine the clocksource and clockevent because you only
> have a single counter, and the counter has the behaviour of:
> - counting down towards zero
> - when reaching zero, triggers an interrupt, and reloads with N
> 
> then this provides your clockevent, but you can't use this as a clock
> source, because each time you receive an interrupt and try to read the
> counter value, it will be approximately the same value.  This means
> that the above calculation fails to register the correct number of
> nanoseconds passing.  Hence, this does not work.
> 
> Also note where I said above that the clock event device must be able
> to provide an interrupt _before_ the clocksource wraps - clearly with
> such a timer, that is utterly impossible.
> 
> The simple solution is to not use such a counter as the clocksource,
> which means you fall back to using the jiffies clocksource, and your
> timekeeping has jiffy resolution - so 10ms, or possibly 1ms if you
> want a 1kHz timer interval.  For most applications, that's simply way
> to coarse, as was realised in the very early days of Linux.
> 
> If only there was a way to interpolate between timer interrupts...
> which is exactly what arch_gettimeoffset() does, and is a historical
> reminant of the pre-clocksource/clockevent days of the kernel - but
> it is the only way to get better resolution from this sort of setup.
> 

Both of the platforms in question (RPC and EBSA110) have not 
defined(CONFIG_GENERIC_CLOCKEVENTS) and have not defined any struct 
clock_event_device, AFAICT.

So, even assuming that you're right about the limitations of single-timer 
platforms in general, removal of arch_gettimeoffset wouldn't require the 
removal of any platforms, AFAICT.

-- 
