From: vikram186@gmail.com (Vikram Narayanan)
Date: Thu, 28 Apr 2011 19:24:41 +0530
Subject: Architecture specific implementations for tickless kernel and
	deferrable timers
In-Reply-To: <20110428133826.GM17290@n2100.arm.linux.org.uk>
References: <BANLkTi=q8-1ybXNky04A6WA7+VA5ZgOB-g@mail.gmail.com>
	<4DB0F249.6000307@codeaurora.org>
	<BANLkTinkkMkyy3OnSiOqgUBHiytFPparbQ@mail.gmail.com>
	<20110426203756.GD17290@n2100.arm.linux.org.uk>
	<BANLkTi=Y0CdRt1ktCs7NwG4pLqWeZeLQPg@mail.gmail.com>
	<alpine.LFD.2.02.1104271015000.3323@ionos>
	<BANLkTi=WRw9pphieBAnDRhSH_WSdyUdb_A@mail.gmail.com>
	<20110428133826.GM17290@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=rG8y=OeF8jc8R48tMLm=eH1=gqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 7:08 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Apr 28, 2011 at 07:01:53PM +0530, Vikram Narayanan wrote:
>> On Wed, Apr 27, 2011 at 1:47 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> > On Wed, 27 Apr 2011, Vikram Narayanan wrote:
>> >> On Wed, Apr 27, 2011 at 2:07 AM, Russell King - ARM Linux
>> >> > The only way to have a stable time source is to have a stable clocksource
>> >> > - one which is never stopped or otherwise messed around with. ?If you
>> >> > try to combine clocksource and clockevent with one-shot mode, where
>> >> > the clocksource part is reset each time a new event is set, you'll probably
>> >> > soon end up with time going screwy.
>> >> >
>> >> Thanks for the insight.
>> >> My another question is that, where can I find some examples of dynamic
>> >> tick implementation. Are there any documents for implementing the
>> >> functionality?
>> >> Also the struct dyn_tick_timer in the file include/asm-arm/mach/time.h
>> >> is removed since 2.6.27. So how do I achieve this?
>> >> If you refer me to some documentation on this, that would be great.
>> >
>> > Provide a functional clocksource plus a clockevent device which is
>> > oneshot capable. Enable CONFIG_NOHZ and there you go.
>> >
>> I am still confused about the terms clocksource and clockevents. Can
>> someone please explain it in simple terms or lead me to a good
>> documentation that elaborates clearly about this?
>
> A clocksource is a monotonically incrementing counter which measures the
> passing of time.
So, this is the timer that keeps the wall time always up as long as
the system is running. If the system isn't running, a backup RTC
should take care of the time. When the system is back, again
clocksource will be having the control.
Even if the above timer count overflows, that should be taken care of.
> This counter should never be reset.
So this timer should always be on, no matter what happens to the system.
>
> A clockevent device is some sort of timer which it used to trigger either
> a periodic interrupt or a one-shot interrupt to cause CPUs to do some
> maintainence task (such as reading the clock source, comparing that with
> the previous reading, and using the delta to update the kernels idea of
> current time.)
This is used for setting up the next event by using the set_next_event
callback and set the mode(one shot or periodic) by set_mode callback.
So, this timer is the heart of tickless kernel functionality(NO_HZ).

These are my understandings, correct me if I am wrong.

If my understandings are right, it would be a very bad idea to use the
same timer for clocksource and clockevent device, as the clockevent
device may alter the counter value of clocksource.

Thanks for the quick response,
Vikram
