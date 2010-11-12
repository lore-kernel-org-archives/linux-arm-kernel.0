From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 12 Nov 2010 14:15:05 -0500 (EST)
Subject: [PATCH] RFC: nomadik: expand timesource to 63 bits
In-Reply-To: <20101112095739.GH18358@pengutronix.de>
References: <1289466356-16697-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTi=ysONhPQBTbVNRgTOx5PGEM=STaUYY6RnUpfES@mail.gmail.com>
	<20101112095739.GH18358@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1011121406040.13911@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Nov 2010, Uwe Kleine-K?nig wrote:

> On Thu, Nov 11, 2010 at 01:33:41PM -0800, john stultz wrote:
> > Instead, I'd use this extension at the sched_clock level, where it
> > seems reasonable that it will be called frequently enough to not brake
> > the cnt32_to_63 magic.
> Instead of implementing sched_clock for each architecture seperatly,
> wouldn't it be nice to have a generic sched_clock that uses the
> architecture's clocksource?  I tried to implement that some time ago,
> but tglx shoot it down because of locking problems.

They also have different goals.

sched_clock: fast implementation with a moderate 
accuracy.  Used for things like scheduler time slices and printk 
timestamping, and since it is called often it needs to be as lightweight 
as possible and accuracy is secondary.

clocksource: as accurate as possible, used for POSIX timers and the 
like, and is typically more heavyweight than sched_clock().

> Maybe doing that became easier since then?

Maybe having a fallback sched_clock implementation based on clocksource 
might make sense, but the current fallback is based on jiffies which is 
probably good enough as a fallback.


Nicolas
