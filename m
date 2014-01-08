From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 08 Jan 2014 16:01:03 +0000
Subject: [RFC 02/18] power/reset: vexpress: Use sched_clock as the time
 source
In-Reply-To: <CANcMJZALQ0khcqkdQA5Tnr6_9kfWK=UUmrUB4mCv2MEkmLv0sg@mail.gmail.com>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-3-git-send-email-pawel.moll@arm.com>
 <CANcMJZALQ0khcqkdQA5Tnr6_9kfWK=UUmrUB4mCv2MEkmLv0sg@mail.gmail.com>
Message-ID: <1389196863.23721.20.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-12-23 at 19:28 +0000, John Stultz wrote:
> On Mon, Dec 23, 2013 at 8:23 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> > At this stage of system shutdown procedure the jiffies may
> > not be updated anymore, so have to base on raw sched_clock
> > values.
> >
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > Cc: Anton Vorontsov <anton@enomsg.org>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > ---
> >  drivers/power/reset/vexpress-poweroff.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
> > index 476aa49..d752233 100644
> > --- a/drivers/power/reset/vexpress-poweroff.c
> > +++ b/drivers/power/reset/vexpress-poweroff.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/sched.h>
> >  #include <linux/stat.h>
> >  #include <linux/vexpress.h>
> >
> > @@ -27,12 +28,12 @@ static void vexpress_reset_do(struct device *dev, const char *what)
> >                         vexpress_config_func_get_by_dev(dev);
> >
> >         if (func) {
> > -               unsigned long timeout;
> > +               unsigned long long timeout_ns;
> >
> >                 err = vexpress_config_write(func, 0, 0);
> >
> > -               timeout = jiffies + HZ;
> > -               while (time_before(jiffies, timeout))
> > +               timeout_ns = sched_clock() + 50000000;
> > +               while (!err && time_before64(sched_clock(), timeout_ns))
> >                         cpu_relax();
> >         }
> 
> So this may not be a problem in this particular case, but sched_clock
> could be backed by jiffies on some hardware, causing the same problem
> to appear.

Uh, right. As you guessed, on vexpress sched_clock, once registered, is
always available. But of course I shouldn't fully rely on this.

> Might udelay/mdelay be a better fit for this sort of case (since
> udelay may be counter backed, but may also be loop backed on hardware
> without continuous counters)?

I'm sure I though about udelay, but for some reason decided against it.
The reason may be already invalid, so I'll check it again :-)

Thanks!

Pawe?
