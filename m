From: briannorris@chromium.org (Brian Norris)
Date: Mon, 19 Sep 2016 16:14:42 -0700
Subject: [PATCH] clocksource: arm_arch_timer: Don't assume clock runs in
 suspend
In-Reply-To: <57DBA81F.2060404@arm.com>
References: <20160916054917.16930-1-briannorris@chromium.org>
 <57DBA81F.2060404@arm.com>
Message-ID: <20160919231441.GA60928@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 09:06:55AM +0100, Marc Zyngier wrote:
> Hi Brian,

Hi Marc,

Thanks for the quick response.

> On 16/09/16 06:49, Brian Norris wrote:
> > Since commit 4fbcdc813fb9 ("clocksource: arm_arch_timer: Use clocksource
> > for suspend timekeeping"), this driver assumes that the ARM architected
> > timer keeps running in suspend. This is not the case for some ARM SoCs,
> > depending on the HW state used for system suspend. Let's not assume that
> > all SoCs support this, and instead only support this if the device tree
> > explicitly tells us it's "always on". In all other cases, just fall back
> > to the RTC. This should be relatively harmless.
> 
> I'm afraid you're confusing two things:
> - the counter, which *must* carry on counting no matter what, as
> (quoting the ARM ARM) "The system counter must be implemented in an
> always-on power domain"
> - the timer, which is allowed to be powered off, and can be tagged with
> the "always-on" property to indicate that it is guaranteed to stay up
> (which in practice only exists in virtual machines and never on real HW).

Indeed, sorry for that confusion, and thanks for the explanations.

> If your counter does stop counting when suspended, then this is starting
> to either feel like a HW bug, or someone is killing the clock that feeds
> this counter when entering suspend.
> 
> If this is the former, then we need a separate quirk to indicate the
> non-standard behaviour. If it is the latter, don't do it! ;-)

It's beginning to seem more like a HW quirk which yields nonstandard
behavior. AIUI, this SoC normally runs the counter off its 24 MHz clock,
but for low power modes, this "always-on" domain switches over to a 32
KHz alternative clock. Unfortunately, the counter doesn't actually tick
when run this way. I'm trying to confirm with the chip designers
(Rockchip, RK3399) about the nature of the quirk, but I think we'll need
a separate DT flag for this behavior.

Brian
