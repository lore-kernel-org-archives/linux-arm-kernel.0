From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Oct 2014 15:40:46 +0200
Subject: [PATCH v4 1/2] iopoll: Introduce memory-mapped IO polling macros
In-Reply-To: <vnkwoatngwmo.fsf@mitchelh-linux.qualcomm.com>
References: <1412126893-15796-1-git-send-email-mitchelh@codeaurora.org>
 <23910474.oJQUXZsx4W@wuerfel> <vnkwoatngwmo.fsf@mitchelh-linux.qualcomm.com>
Message-ID: <2434048.k6JtGScJfe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 October 2014 18:47:59 Mitchel Humpherys wrote:
> On Wed, Oct 01 2014 at 01:25:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 30 September 2014 18:28:12 Mitchel Humpherys wrote:
> >> + */
> >> +#define readl_poll_timeout(addr, val, cond, sleep_us, timeout_us) \
> >> +({ \
> >> +       ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
> >> +       might_sleep_if(timeout_us); \
> >
> > Does it make sense to call this with timeout_us = 0?
> 
> Yes, the idea there being to "never timeout".  That mode should, of
> course, be used with extreme caution since never timing out is not
> really "playing nice" with the system.

But then you certainly still 'might_sleep' here. The
might_sleep_if(timeout_us) line suggests that it won't sleep, but
that isn't the case.

> >
> >> +       for (;;) { \
> >> +               (val) = readl(addr); \
> >> +               if (cond) \
> >> +                       break; \
> >> +               if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) { \
> >> +                       (val) = readl(addr); \
> >> +                       break; \
> >> +               } \
> >> +               if (sleep_us) \
> >> +                       usleep_range(DIV_ROUND_UP(sleep_us, 4), sleep_us); \
> >> +       } \
> >> +       (cond) ? 0 : -ETIMEDOUT; \
> >> +})
> >
> > I think it would be better to tie the 'range' argument to the timeout. Also
> > doing a division seems expensive here.
> 
> We may have cases where the HW spec says something like "the foo widget
> response time is on average 5us, with a worst case of 100us."  In such a
> case we may want to poll the bit very frequently to optimize for the
> common case of a very fast lock time, but we may not want to error out
> due to a timeout unless we've been waiting 100us.

Ok.

> Regarding the division, for the overwhelmingly common case where the
> user of the API passes in a constant for sleep_us the compiler optimizes
> out this calculation altogether and just sticks the final result in (I
> verified this with gcc 4.9 and the kernel build system's built-in
> support for generating .s files).  Conveying semantic meaning by using
> `DIV_ROUND_UP' is nice but if you feel strongly about it we can make
> this a shift instead.

The more important question is probably if you want to keep the _ROUND_UP
part. If that's not significant, I think a shift would be better.

	Arnd
