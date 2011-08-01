From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Aug 2011 20:48:09 +0100
Subject: [PATCH] Add sched_clock to AT91 TCB clocksource driver
In-Reply-To: <CANqCtQK=H_B04A7knZSiuE5RLogTgMKxwtMK1HSqSgKA_U2J7A@mail.gmail.com>
References: <1312124593-6088-1-git-send-email-linux@bohmer.net>
	<20110731150707.GA2975@n2100.arm.linux.org.uk>
	<CANqCtQJwUsLXfA408GzAr0rQtc2DRjtKqP8-m2UBUGEy-YP5dg@mail.gmail.com>
	<20110801092806.GD15578@n2100.arm.linux.org.uk>
	<CANqCtQK=H_B04A7knZSiuE5RLogTgMKxwtMK1HSqSgKA_U2J7A@mail.gmail.com>
Message-ID: <20110801194809.GE19079@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2011 at 08:08:19PM +0200, Remy Bohmer wrote:
> Hi,
> 
> > You're forgetting that jiffies doesn't jump about. ?A late initializing
> > sched_clock could jump.
> 
> Agreed. Currently the jiffies based clock does not move at all, thus
> it surely does not jump... ;-)
> 
> >> Anyway, do you have a better suggestion how to fix this? The tcb
> >> clocksource is loaded during a arch_initcall(), perhaps we need
> >> something before that point.
> >> I do not see an easy way to integrate it in MACHINE_START(.timer).
> >> Would 'late_time_init' be a better solution?
> >
> > late_time_init() is not that much better as that still happens after
> > sched_init() has been called. ?sched_init() initializes various
> > structures which involves reading sched_clock().
> 
> But late_time_init does it before the sched_clock is declared stable.
> Until that point sched_clock will always return zero, as such we can
> IMHO safely assume that the scheduler is designed such that it can
> handle fixed zero timestamps for a while.

You're confused.

If you provide your own sched_clock(), that's what is used by everyone
who calls sched_clock() both before and after sched_clock_init() has
been called.

sched_clock_cpu() and cpu_clock() both will return zero up until
sched_clock_init() has been called, but sched_clock() itself may not.

And these parts of the scheduler I'm talking about use sched_clock()
itself, not sched_clock_cpu() nor cpu_clock().
