From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 12 Nov 2010 10:57:39 +0100
Subject: [PATCH] RFC: nomadik: expand timesource to 63 bits
In-Reply-To: <AANLkTi=ysONhPQBTbVNRgTOx5PGEM=STaUYY6RnUpfES@mail.gmail.com>
References: <1289466356-16697-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTi=ysONhPQBTbVNRgTOx5PGEM=STaUYY6RnUpfES@mail.gmail.com>
Message-ID: <20101112095739.GH18358@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On Thu, Nov 11, 2010 at 01:33:41PM -0800, john stultz wrote:
> On Thu, Nov 11, 2010 at 1:05 AM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
> > After wraparound-problems in sched_clock() we expand the 32bit
> > timer in the MTU from 32 to 63 bits so the scheduling and
> > timeline is more stable. At current max operating frequency for
> > the MTU, 133 MHz, this should be sufficient for rougly 2200
> > years.
> >
> [snip]
> > What we need to know is whether it's OK to simply blow up
> > clocksource to 63 bits like this. In that case this
> > simplification should also apply to Orion, meaning that it
> > would base it's sched_clock() on the clocksource, using
> > simply clocksource_cyc2ns() cutting down the code
> > significantly.
> 
> I would advise against expanding the hardware counter to 63bits via
> software at the clocksource layer. This breaks the
> CLOCK_SOURCE_IS_CONTINUOUS flag rule (since the hardware will wrap
> below the mask value if not updated in the software layer). And as
> Thomas said, this will cause problems in the nohz idle limiting code
> (which makes sure we wake up before the clocksource wraps).
> 
> Instead, I'd use this extension at the sched_clock level, where it
> seems reasonable that it will be called frequently enough to not brake
> the cnt32_to_63 magic.
Instead of implementing sched_clock for each architecture seperatly,
wouldn't it be nice to have a generic sched_clock that uses the
architecture's clocksource?  I tried to implement that some time ago,
but tglx shoot it down because of locking problems.

Maybe doing that became easier since then?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
