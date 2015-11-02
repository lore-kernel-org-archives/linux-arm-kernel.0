From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Nov 2015 22:44:56 +0100
Subject: [PATCH 03/22] clocksource/drivers/rockchip: Make the driver more
 compatible
In-Reply-To: <56379016.1080601@linaro.org>
References: <1446469011-22710-1-git-send-email-daniel.lezcano@linaro.org>
 <5093304.EN6Bc2EjLr@wuerfel> <56379016.1080601@linaro.org>
Message-ID: <26365416.grsdrqtSNb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 November 2015 17:32:22 Daniel Lezcano wrote:
> On 11/02/2015 04:33 PM, Arnd Bergmann wrote:
> > On Monday 02 November 2015 13:56:31 Daniel Lezcano wrote:
> >>   static inline void rk_timer_disable(struct clock_event_device *ce)
> >>   {
> >>          writel_relaxed(TIMER_DISABLE, rk_base(ce) + TIMER_CONTROL_REG);
> >> -       dsb();
> >> +       dsb(sy);
> >>   }
> >>
> >>   static inline void rk_timer_enable(struct clock_event_device *ce, u32 flags)
> >>   {
> >>          writel_relaxed(TIMER_ENABLE | TIMER_INT_UNMASK | flags,
> >>                         rk_base(ce) + TIMER_CONTROL_REG);
> >> -       dsb();
> >> +       dsb(sy);
> >>   }
> >>
> >>
> >
> > This will fail the compile test, because dsb() is not available on non-ARM
> > architectures. Would it be enough to just use the normal writel() accessor
> > here?
> 
> That's a good question and I believe we can remove it but I have to 
> setup a rockchip board before doing the changes in order to test.
> 
> I the meantime added the COMPILE_TEST option but restricted it to ARM 
> and ARM64.
> 

Ok. I saw that addition after commenting here, it looks correct this
way, I was just slightly confused by seeing patch 2 first and thought
it was for the same driver.

In general, it would of course be best to allow all drivers to be built
on x86, but your series is already a huge improvement as it is.

	Arnd
