From: vikram186@gmail.com (Vikram Narayanan)
Date: Wed, 27 Apr 2011 09:00:54 +0530
Subject: Architecture specific implementations for tickless kernel and
	deferrable timers
In-Reply-To: <20110426203756.GD17290@n2100.arm.linux.org.uk>
References: <BANLkTi=q8-1ybXNky04A6WA7+VA5ZgOB-g@mail.gmail.com>
	<4DB0F249.6000307@codeaurora.org>
	<BANLkTinkkMkyy3OnSiOqgUBHiytFPparbQ@mail.gmail.com>
	<20110426203756.GD17290@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=Y0CdRt1ktCs7NwG4pLqWeZeLQPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 2:07 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Apr 24, 2011 at 07:50:55PM +0530, Vikram Narayanan wrote:
>> On Fri, Apr 22, 2011 at 8:43 AM, Jeff Ohlstein <johlstei@codeaurora.org> wrote:
>> > Vikram Narayanan wrote:
>> >> And also, are clocksoure and clockevents dependent on each other? I
>> >> see in some platforms, that they have used 2 different timers for the
>> >> above. Can a same clock be used for both clocksource and clockevents?
>> >> Please throw some light on this. If it can be used so, what ties up
>> >> the clocksource and clockevent?
>> >
>> > You can look at msm for an example of a single timer being used both as
>> > a clocksource and a clockevent. We end up shutting off the clocksource
>> > whenever we shut down the clockevent. This does cause some issues.
>> > Switching clocksources at runtime does not work. It will also cause
>> > problems if you implement your own sched_clock function, as it will have
>> > little choice but to return a stale cached value whenever the clockevent
>> > is disabled, such as in the suspend path.
>> Thanks for the example. I will refer to that. And I have another
>> question, If dynamic ticks are implemented, say if I am using the same
>> clocksource and clockevent, the wall time will only be updated at that
>> dyn_tick interval. Will that create any issue? or should I use a
>> constant source for the clocksource? or how to handle this in an
>> effective way.
>> * Clocksource and clockevents with the same timer.
>> * Also I want to make use of the tickless kernel functionality.
>
> The only way to have a stable time source is to have a stable clocksource
> - one which is never stopped or otherwise messed around with. ?If you
> try to combine clocksource and clockevent with one-shot mode, where
> the clocksource part is reset each time a new event is set, you'll probably
> soon end up with time going screwy.
>
Thanks for the insight.
My another question is that, where can I find some examples of dynamic
tick implementation. Are there any documents for implementing the
functionality?
Also the struct dyn_tick_timer in the file include/asm-arm/mach/time.h
is removed since 2.6.27. So how do I achieve this?
If you refer me to some documentation on this, that would be great.

-
Thanks
Vikram
