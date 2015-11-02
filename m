From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Nov 2015 16:33:27 +0100
Subject: [PATCH 03/22] clocksource/drivers/rockchip: Make the driver more
 compatible
In-Reply-To: <1446469011-22710-3-git-send-email-daniel.lezcano@linaro.org>
References: <1446469011-22710-1-git-send-email-daniel.lezcano@linaro.org>
 <1446469011-22710-3-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <5093304.EN6Bc2EjLr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 November 2015 13:56:31 Daniel Lezcano wrote:
>  static inline void rk_timer_disable(struct clock_event_device *ce)
>  {
>         writel_relaxed(TIMER_DISABLE, rk_base(ce) + TIMER_CONTROL_REG);
> -       dsb();
> +       dsb(sy);
>  }
>  
>  static inline void rk_timer_enable(struct clock_event_device *ce, u32 flags)
>  {
>         writel_relaxed(TIMER_ENABLE | TIMER_INT_UNMASK | flags,
>                        rk_base(ce) + TIMER_CONTROL_REG);
> -       dsb();
> +       dsb(sy);
>  }
>  
> 

This will fail the compile test, because dsb() is not available on non-ARM
architectures. Would it be enough to just use the normal writel() accessor
here?

	Arnd
