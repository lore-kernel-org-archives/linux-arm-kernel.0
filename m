From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 20 Nov 2012 16:57:16 +0800
Subject: [PATCH 3/4] i2c-s3c2410: use exponential back off while polling
 for bus idle
In-Reply-To: <20121120044859.GA10154@sirena.org.uk>
References: <1352981613-2098-1-git-send-email-ch.naveen@samsung.com>
 <1352981613-2098-4-git-send-email-ch.naveen@samsung.com>
 <20121120044859.GA10154@sirena.org.uk>
Message-ID: <CAGS+omCKm+aN9ZXApmQJh1OrST-t2sA8WP7NyDOzKnv-xqJ5vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Nov 20, 2012 at 12:49 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>
> On Thu, Nov 15, 2012 at 05:43:32PM +0530, Naveen Krishna Chatradhi wrote:
>
> > +     iicstat = readl(i2c->regs + S3C2410_IICSTAT);
> > +     delay = 1;
> > +     while ((iicstat & S3C2410_IICSTAT_START) &&
> > +            ktime_us_delta(now, start) < S3C2410_IDLE_TIMEOUT) {
> > +             usleep_range(delay, 2 * delay);
> > +             if (delay < S3C2410_IDLE_TIMEOUT / 10)
> > +                     delay <<= 1;
> > +             now = ktime_get();
> > +             iicstat = readl(i2c->regs + S3C2410_IICSTAT);
> > +     }
>
> > -     /* first, try busy waiting briefly */
> > -     do {
> > -             cpu_relax();
> > -             iicstat = readl(i2c->regs + S3C2410_IICSTAT);
> > -     } while ((iicstat & S3C2410_IICSTAT_START) && --spins);
>
> On the hardware I was using when I wrote the original code here we were
> hitting 1-2 spins often enough to be interesting - starting off with a
> direct busy wait was definitely useful when doing large batches of I/O,
> especially compared to sleeps which might cause us to schedule.

We check the status first to avoid any sleep()/schedule() in the case,
that the CPU is slower than I2C transaction.
Remember, this loop only happens after the event_wait loop has been
woken up by the i2c irq.
Since you are talking about hitting a tiny window of time at some
arbitrary point after an irq, the CPU time to this point & I2C
finishing would have to be very precisely aligned for the 1-2 loops
(at CPU clock rate) to matter.

HTH,
-Dan

>
> > -     /* if that timed out sleep */
> > -     if (!spins) {
> > -             msleep(1);
> > -             iicstat = readl(i2c->regs + S3C2410_IICSTAT);
> > -     }
>
> It seems like it'd be better to do the exponential backoff bit here
> instead of removing the busy wait completely.
