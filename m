From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 15 Apr 2014 18:57:24 +0200
Subject: [PATCH] driver: clocksource: fix age-old arch timer C3STOP
 detection issue
In-Reply-To: <1396947872-6673-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1396947872-6673-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <534D64F4.3060808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2014 11:04 AM, Lorenzo Pieralisi wrote:
> ARM arch timers are tightly coupled with the CPU logic and lose context
> on platform implementing HW power management when cores are powered
> down at run-time. Marking the arch timers as C3STOP regardless of power
> management capabilities causes issues on platforms with no power management,
> since in that case the arch timers cannot possibly enter states where the
> timer loses context at runtime and therefore can always be used as a high
> resolution clockevent device.
>
> In order to fix the C3STOP issue in a way compliant with how real HW
> works, this patch adds a boolean property to the arch timer bindings
> to define if the arch timer is managed by an always-on power domain.
>
> This power domain is present on all ARM platforms to date, and manages
> HW that must not be turned off, whatever the state of other HW
> components (eg power controller). On platforms with no power management
> capabilities, it is the only power domain present, which encompasses
> and manages power supply for all HW components in the system.
>
> If the timer is powered by the always-on power domain, the always-on
> property must be present in the bindings which means that the timer cannot
> be shutdown at runtime, so it is not a C3STOP clockevent device.
> If the timer binding does not contain the always-on property, the timer is
> assumed to be power-gateable, hence it must be defined as a C3STOP
> clockevent device.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Magnus Damm <damm@opensource.se>
> Cc: Marc Carino <marc.ceeeee@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---

Applied as 3.15 fix.

Thanks

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
