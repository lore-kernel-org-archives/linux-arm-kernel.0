From: briannorris@chromium.org (Brian Norris)
Date: Tue, 27 Sep 2016 18:23:11 -0700
Subject: [PATCH] clocksource: arm_arch_timer: Don't assume clock runs in
 suspend
In-Reply-To: <57E0E97B.5000106@arm.com>
References: <20160916054917.16930-1-briannorris@chromium.org>
 <57DBA81F.2060404@arm.com> <20160919231441.GA60928@google.com>
 <57E0E97B.5000106@arm.com>
Message-ID: <20160928012309.GA29518@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Thanks again for the help. I was checking with Rockchip on the details.

On Tue, Sep 20, 2016 at 08:47:07AM +0100, Marc Zyngier wrote:
> The counter is allowed to be clocked at a different rate, as long as it
> is incremented by the frequency ratio on each tick of the new frequency.
> In your case, the counter should increment by 750 on each tick of the
> 32kHz clock. If the rk3399 implementation doesn't do this, then this is
> a bug, and we need a quirk to work around it.

I had hope that we could find a switch that would do the above for
rk3399, since other parts of the system (e.g., the PMU itself) support
switching from the 24MHz to 32KHz clock, but Rockchip confirmed that it
is indeed a HW quirk that the arch timer's counter does not support
clocking out ticks based on the 32KHz clock. So I'm planning to send a
v2 that adds a "arm,no-tick-in-suspend" property.

<Begin side note>
rk3288 (ARMv7 system widely used for our Chromebooks) has the same
issue, except the kernel we're using for production (based on v3.14)
doesn't have the following commit, which stopped utilizing the RTC:

commit 0fa88cb4b82b5cf7429bc1cef9db006ca035754e
Author: Xunlei Pang <pang.xunlei@linaro.org>
Date:   Wed Apr 1 20:34:38 2015 -0700

    time, drivers/rtc: Don't bother with rtc_resume() for the nonstop clocksource

And any mainline testing on rk3288 doesn't see the problem, because
mainline doesn't support its lowest-power sleep modes well enough (see
ROCKCHIP_ARM_OFF_LOGIC_DEEP in arch/arm/mach-rockchip/pm.c).
<End side note>

> Note that such a quirk will have some other impacts, such as the
> gettimeofday implementation in the VDSO (which relies on the counter
> making forward progress). There could be other issues in the timer
> subsystem as well... This doesn't look like a pleasant thing to fix.

How sure are you of these problems? I'm a bit new to the kernel
timekeeping subsystem, but doesn't this kind of code already have to
handle time adjustments like this when reprogramming the system time
(settimeofday())? And might we be covered for the suspend/resume case
when we allow the kernel to fall back to the RTC instead, which adjusts
the sleep delta with timekeeping_inject_sleeptime64()? And (weaker
evidence here) we haven't seen problems on rk3288 so far, at least
without the above referenced rtc commit 0fa88cb4b82. But admittedly
there are some differences between arch/{arm,arm64}/.

Regards,
Brian
