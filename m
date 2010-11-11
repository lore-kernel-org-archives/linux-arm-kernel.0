From: johnstul@us.ibm.com (john stultz)
Date: Thu, 11 Nov 2010 13:33:41 -0800
Subject: [PATCH] RFC: nomadik: expand timesource to 63 bits
In-Reply-To: <1289466356-16697-1-git-send-email-linus.walleij@stericsson.com>
References: <1289466356-16697-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTi=ysONhPQBTbVNRgTOx5PGEM=STaUYY6RnUpfES@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 11, 2010 at 1:05 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> After wraparound-problems in sched_clock() we expand the 32bit
> timer in the MTU from 32 to 63 bits so the scheduling and
> timeline is more stable. At current max operating frequency for
> the MTU, 133 MHz, this should be sufficient for rougly 2200
> years.
>
[snip]
> What we need to know is whether it's OK to simply blow up
> clocksource to 63 bits like this. In that case this
> simplification should also apply to Orion, meaning that it
> would base it's sched_clock() on the clocksource, using
> simply clocksource_cyc2ns() cutting down the code
> significantly.

I would advise against expanding the hardware counter to 63bits via
software at the clocksource layer. This breaks the
CLOCK_SOURCE_IS_CONTINUOUS flag rule (since the hardware will wrap
below the mask value if not updated in the software layer). And as
Thomas said, this will cause problems in the nohz idle limiting code
(which makes sure we wake up before the clocksource wraps).

Instead, I'd use this extension at the sched_clock level, where it
seems reasonable that it will be called frequently enough to not brake
the cnt32_to_63 magic.

thanks
-john
