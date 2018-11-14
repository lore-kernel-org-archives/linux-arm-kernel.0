From: schmitzmic@gmail.com (Michael Schmitz)
Date: Wed, 14 Nov 2018 14:35:29 +1300
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <20181113234336.GP30658@n2100.armlinux.org.uk>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk>
Message-ID: <d9be7418-cc4a-f92f-1aa8-d92a58cd68a4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 14/11/18 12:43 PM, Russell King - ARM Linux wrote:
> On Wed, Nov 14, 2018 at 08:55:37AM +1100, Finn Thain wrote:
>> On Tue, 13 Nov 2018, Russell King - ARM Linux wrote:
>>
>>> On Tue, Nov 13, 2018 at 02:39:00PM +1100, Finn Thain wrote:
>>>> You could remove the old arch_gettimeoffset API without dropping any
>>>> platforms.
>>>>
>>>> If no-one converts a given platform to the clocksource API it would mean
>>>> that the default 'jiffies' clocksource will get used on that platform.
>>>>
>>>> Clock resolution and timer precision would be degraded, but that might not
>>>> matter.
>>>>
>>>> Anyway, if someone who has this hardware is willing to test a clocksource
>>>> API conversion, they can let me know and I'll attempt that patch.
>>> There's reasons why that's not appropriate - such as not having two
>>> separate timers in order to supply a clocksource and separate clock
>>> event.
>>>
>>> Not all hardware is suited to the clocksource + clockevent idea.
>>>
>> Sorry, I don't follow.
>>
>> AFAIK, clocksources and clock event devices are orthogonal concepts. There
>> are platforms with !ARCH_USES_GETTIMEOFFSET && !GENERIC_CLOCKEVENTS (and
>> every other combination).
>>
>> A clocksource read method just provides a cycle count, and in this sense
>> arch_gettimeoffset() is equivalent to a clocksource.
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

So we'd still have to use jiffies + interpolation from the current timer 
rundown counter as clocksource (since that will be monotonous and won't 
wrap)?

The way Finn did the clocksource for m68k, the clocksource counter does 
behave as it should (monotonous, doesn't wrap) at least so far as I've 
tested. Using the same timer for clocksource and clock events will 
degrade timekeeping based on timer events to jiffies resolution, as you 
point out. That would already have been the case before, so no gain in 
resolution. Other timekeeping would have worked at higher resolution 
before (interpolating through arch_gettimeoffset) just the same as now 
(interpolating through clocksource reads). Finn's clocksource read code 
essentially is arch_gettimeoffset under a new name.

Are you saying that's not possible on arm, because the current timer 
rundown counter can't be read while the timer is running?

If I were to run a second timer at higher rate for clocksource, but 
keeping the 10 ms timer as clock event (could easily do that by using 
timer D on Atari Falcon) - how would that improve my timekeeping? Clock 
events still only happen 10 ms apart ...

Cheers,

 ??? Michael

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
