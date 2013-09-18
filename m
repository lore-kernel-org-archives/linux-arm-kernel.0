From: john.stultz@linaro.org (John Stultz)
Date: Wed, 18 Sep 2013 08:25:00 -0500
Subject: [RFC][PATCH] rtc: rtc-pl031: Set wakeup flag prior to registering
 rtcdev
In-Reply-To: <CACRpkdY-6eUWG6CWpBMi=yy2m158xwsF4h48yqZNzvBe_LW14Q@mail.gmail.com>
References: <1379442550-24860-1-git-send-email-john.stultz@linaro.org>
 <CACRpkdY-6eUWG6CWpBMi=yy2m158xwsF4h48yqZNzvBe_LW14Q@mail.gmail.com>
Message-ID: <CALAqxLXtBj_DhiDr=BcU__E8g+FyeDGP+ZJjh0Mp+rrFZ6cJUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 6:30 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Sep 17, 2013 at 8:29 PM, John Stultz <john.stultz@linaro.org> wrote:
>
> > In some recent testing, I noticed the CLOCK_REALTIME_ALARM clockid
> > wasn't functioning on my vexpress qemu environment. Looking into it
> > I noticed the pl031 rtc driver doesn't set the wakeup flag on the
> > device until after registering the device with the RTC subsystem.
> >
> > This causes the alarmtimer subsystem to not see the pl031 driver
> > as a valid backing device, and that resuls in alarm clockids
> > getting ENOTSUPP errors.
> >
> > Thus be sure to set the wakeup flag on the device prior to
> > registering the rtcdev so the pl031 rtc driver can be used as
> > the backing alarmtimer device.
> >
> > Let me know if you have any feedback or objections to this.
> > If it looks ok, I'll queue it for 3.13. I suspect there
> > may be other RTC drivers with the same problem.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Alessandro Zummo <a.zummo@towertech.it>
> > Cc: "Jon Medhurst (Tixy)" <tixy@linaro.org>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
>
> Makes perfect sense. I have only tested the driver from regular
> userspace using ioctl()s. Is these a simple way to test
> an alarmtimer on a barebones system?

The easiest way is to try to read CLOCK_REALTIME_ALARM which will only
function if there's a backing rtc.

I've got some further timekeeping tests here that will test timers etc
on the _ALARM clockids:
https://github.com/johnstultz-work/timetests


> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Are you sure this should not be for -rc:s and stable?

Its not a regression (never worked before), so I don't think so,
unless someone finds the functionality critical for long-term kernels.

thanks
-john
