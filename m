From: dianders@chromium.org (Doug Anderson)
Date: Thu, 8 May 2014 17:02:02 -0700
Subject: [PATCH] ARM: Don't ever downscale loops_per_jiffy in SMP systems
In-Reply-To: <20140508205556.GJ3693@n2100.arm.linux.org.uk>
References: <1399504982-31181-1-git-send-email-dianders@chromium.org>
 <CAOh2x=kwaoSdj8JO0Vo08Y0dX2UfKFiF3pBV-qtp-YTyN=8H8Q@mail.gmail.com>
 <CAD=FV=UEGJGHrdcXgs3EZ_wFXT8GnNeCOMt7CgdiiUzBzZ5Y0A@mail.gmail.com>
 <alpine.LFD.2.11.1405081149190.980@knanqh.ubzr>
 <CAD=FV=VtcLOh51LCmafzRMdqtDrwKXCqK6gE6V7OOOUe4gjwbA@mail.gmail.com>
 <alpine.LFD.2.11.1405081329010.980@knanqh.ubzr>
 <CAD=FV=X4h0nfO7a10NXe+d76xj5ttBJx=q1pAvW4aPzrc22BoQ@mail.gmail.com>
 <20140508205556.GJ3693@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=ViOie+E_mxgcE51oNL0HY1zF9KYG_TDSbKjMzE2GZZMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russel,

On Thu, May 8, 2014 at 1:55 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, May 08, 2014 at 11:06:24AM -0700, Doug Anderson wrote:
>> I guess I would say that my patch is unhacking the this code.  The
>> code after my patch is simpler.  I would perhaps argue that (ec971ea
>> ARM: add cpufreq transiton notifier to adjust loops_per_jiffy for smp)
>> should never have landed to begin with.
>
> That depends on your point of view.  As I've already pointed out through
> the examples of why udelay() is inaccurate, for driver authors, they
> should assume that udelay() just gives you an "approximate" delay and
> it has no accuracy.

That disagrees with what Thomas Gleixner says at
<http://lkml.iu.edu//hypermail/linux/kernel/1203.1/01034.html>.  It
also seems like perhaps the regulator core is broken, then...  If a
udelay(30) can end up as a udelay(20) then we may return from a
regulator code 10us earlier than we should and we'll assume that a
regulator is ramped before it really is...

I'm out tomorrow but I can confirm on Monday that I was really seeing
udelay(30) be a udelay(20) without this patch.
