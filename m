From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Tue, 17 Jul 2012 12:10:06 +0900
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <20120713111337.GH18079@mudshark.cambridge.arm.com>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
 <4FFE7DB2.4040702@renesas.com>
 <20120712084432.GA2816@mudshark.cambridge.arm.com>
 <4FFE9A69.3060301@renesas.com> <4FFEFDE3.5000403@codeaurora.org>
 <4FFF8509.2050302@renesas.com>
 <20120713085746.GA18079@mudshark.cambridge.arm.com>
 <CAMQu2gwPm_Y1as6dc4S-f9OEOZA32CCNKv_07MB+U7T4OS6qXg@mail.gmail.com>
 <20120713111337.GH18079@mudshark.cambridge.arm.com>
Message-ID: <5004D78E.4050606@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will, Stephen and Santosh,

On 7/13/2012 8:13 PM, Will Deacon wrote:
> I was anticipating that the platform would set the initial loops_per_jiffy
> value if it requires udelays before loop calibration and the default of 4k
> is wildly off.

I overlooked two different lpj setups were involved at hand.

First one was, the initial loops_per_jiffy value of 4k was too small for
almost all processors running Linux today, so I set up loops_per_jiffy
_early_, calculated from the CPU clock speed.  I didn't mentioned this
before, sorry for confusion.

So my initial loops_per_jiffy is not 4k at this point.  It's optimized
for loop-based delay with the CPU running at 1.2GHz (much bigger than
default 4k).

And later, init_current_timer_delay() got processed.  Actual udelay()
behavior switched from loop-based delay to timer-based one immediately,
while my loops_per_jiffy was not changed/updated to appropriate value.

This is why my udelay()s, used after init_current_timer_delay(), were
taking considerable long time to expire.   Note that my initial tests
for Will's patchset was done using a loadable module dedicated for
udelay tests, that was prepared for 2.6.35/3.0 kernels beforehand.

And this time, I confirmed that updating loops_per_jiffy at the same
time as lpj_fine, works perfectly as expected for me.

> If people need loops_per_jiffy to be updated at the same time as lpj_fine,
> I can post that as a separate patch (below) as Russell has merged v2 of these
> patches into his delay branch. That said, I'd certainly like to know if this
> is actually a real problem (and can't be solved by choosing a compromise value
> as the initial loops_per_jiffy). I think Shinya was doing some tests so
> I'll wait to see how those went.

>From my observations:

(1) loops_per_jiffy can easily be calculated from the CPU clock speed.
If your platform is capable of detecting CPU frequency at run-time,
settingi up loops_per_jiffy _early_ can allow you early use of udelay()s.

Or even if you don't need udelay() early, setting up lpj_fine (or having
calibrate_delay_is_known()) allows you to skip calibrate_delay() later.
This is useful and can be applied to both UP and SMP systems.

(2) For SMP platforms, if you need ealy use of udelay(), you have to
update loops_per_jiffy at the same time as init_current_timer_delay().
It could be done in init_current_timer_delay(), or platforms can take
care of that, that need udelay() available early.  Either one should be
fine with me.
--
Shinya Kuribayashi
Renesas Electronics
