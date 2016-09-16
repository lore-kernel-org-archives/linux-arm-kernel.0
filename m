From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 16 Sep 2016 10:10:33 +0200
Subject: [PATCH] clocksource: arm_arch_timer: Don't assume clock runs in
 suspend
In-Reply-To: <57DBA81F.2060404@arm.com>
References: <20160916054917.16930-1-briannorris@chromium.org>
 <57DBA81F.2060404@arm.com>
Message-ID: <dacd2461-8989-323d-d2ad-b20d10c9282b@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/09/2016 10:06, Marc Zyngier wrote:
> Hi Brian,
> 
> On 16/09/16 06:49, Brian Norris wrote:
>> Since commit 4fbcdc813fb9 ("clocksource: arm_arch_timer: Use clocksource
>> for suspend timekeeping"), this driver assumes that the ARM architected
>> timer keeps running in suspend. This is not the case for some ARM SoCs,
>> depending on the HW state used for system suspend. Let's not assume that
>> all SoCs support this, and instead only support this if the device tree
>> explicitly tells us it's "always on". In all other cases, just fall back
>> to the RTC. This should be relatively harmless.
> 
> I'm afraid you're confusing two things:
> - the counter, which *must* carry on counting no matter what, as
> (quoting the ARM ARM) "The system counter must be implemented in an
> always-on power domain"
> - the timer, which is allowed to be powered off, and can be tagged with
> the "always-on" property to indicate that it is guaranteed to stay up
> (which in practice only exists in virtual machines and never on real HW).
> 
> If your counter does stop counting when suspended, then this is starting
> to either feel like a HW bug, or someone is killing the clock that feeds
> this counter when entering suspend.
> 
> If this is the former, then we need a separate quirk to indicate the
> non-standard behaviour. If it is the latter, don't do it! ;-)

+1

  -- Daniel


 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
