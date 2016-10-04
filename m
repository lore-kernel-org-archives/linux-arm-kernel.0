From: briannorris@chromium.org (Brian Norris)
Date: Tue, 4 Oct 2016 10:49:04 -0700
Subject: [PATCH] clocksource: arm_arch_timer: Don't assume clock runs in
 suspend
In-Reply-To: <20160929170847.1227a312@arm.com>
References: <20160916054917.16930-1-briannorris@chromium.org>
 <57DBA81F.2060404@arm.com> <20160919231441.GA60928@google.com>
 <57E0E97B.5000106@arm.com> <20160928012309.GA29518@localhost>
 <20160929170847.1227a312@arm.com>
Message-ID: <20161004174903.GA3098@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Thu, Sep 29, 2016 at 05:08:47PM +0100, Marc Zyngier wrote:
> On Tue, 27 Sep 2016 18:23:11 -0700
> Brian Norris <briannorris@chromium.org> wrote:
> > On Tue, Sep 20, 2016 at 08:47:07AM +0100, Marc Zyngier wrote:
> > <Begin side note>
> > rk3288 (ARMv7 system widely used for our Chromebooks) has the same
> > issue, except the kernel we're using for production (based on v3.14)
> > doesn't have the following commit, which stopped utilizing the RTC:
> > 
> > commit 0fa88cb4b82b5cf7429bc1cef9db006ca035754e
> > Author: Xunlei Pang <pang.xunlei@linaro.org>
> > Date:   Wed Apr 1 20:34:38 2015 -0700
> > 
> >     time, drivers/rtc: Don't bother with rtc_resume() for the nonstop clocksource
> > 
> > And any mainline testing on rk3288 doesn't see the problem, because
> > mainline doesn't support its lowest-power sleep modes well enough (see
> > ROCKCHIP_ARM_OFF_LOGIC_DEEP in arch/arm/mach-rockchip/pm.c).
> 
> Arghh... So even my favourite Chromebook (from which I'm typing this
> email) is affected? Not very nice...

Yep. But if you're running mainline, you just get to have high S3 power
consumption instead!

> > <End side note>

> As for the 64bit kernel, it would be interesting to verify that on
> resume, the VDSO does return the right (corrected) value, and not
> something stale.

It would be interesting, except all my current user spaces are built for
32-bit, so it's not too easy for me to test. Perhaps I could pull in
this [1]. (On the bright side, this means that VDSO can't possibly be
breaking on my systems!)

Brian

[1] http://www.spinics.net/lists/arm-kernel/msg530185.html
