From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Aug 2011 10:28:06 +0100
Subject: [PATCH] Add sched_clock to AT91 TCB clocksource driver
In-Reply-To: <CANqCtQJwUsLXfA408GzAr0rQtc2DRjtKqP8-m2UBUGEy-YP5dg@mail.gmail.com>
References: <1312124593-6088-1-git-send-email-linux@bohmer.net>
	<20110731150707.GA2975@n2100.arm.linux.org.uk>
	<CANqCtQJwUsLXfA408GzAr0rQtc2DRjtKqP8-m2UBUGEy-YP5dg@mail.gmail.com>
Message-ID: <20110801092806.GD15578@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2011 at 10:42:35AM +0200, Remy Bohmer wrote:
> OK, I know that too, but the jiffies based fallback does it even
> worse, since it does not run at all...  (It only updates in steps of a
> couple of 100msecs and stops after a while, and even does not display
> a real time...) This sched_clock implementation at least works before
> the drivers are being initialised...

You're forgetting that jiffies doesn't jump about.  A late initializing
sched_clock could jump.

> Anyway, do you have a better suggestion how to fix this? The tcb
> clocksource is loaded during a arch_initcall(), perhaps we need
> something before that point.
> I do not see an easy way to integrate it in MACHINE_START(.timer).
> Would 'late_time_init' be a better solution?

late_time_init() is not that much better as that still happens after
sched_init() has been called.  sched_init() initializes various
structures which involves reading sched_clock().

Why can't it initialize itself at the standard point during the boot
sequence, which is time_init() - which in turn is as you say the
.timer callback?
