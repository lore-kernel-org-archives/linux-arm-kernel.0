From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 16 Apr 2014 11:41:13 +0200 (CEST)
Subject: [PATCH 1/3] clocksource: exynos_mct: Fix stall after CPU
 hotplugging
In-Reply-To: <1397638263.6147.7.camel@AMDC1943>
References: <1396011962-4467-1-git-send-email-k.kozlowski@samsung.com>
 <1397554445.29169.21.camel@AMDC1943> <534D25DC.4050400@linaro.org>
 <1397566023.29169.31.camel@AMDC1943>
 <alpine.DEB.2.02.1404151711250.22697@ionos.tec.linutronix.de>
 <1397576515.752.5.camel@AMDC1943>
 <alpine.DEB.2.02.1404151753090.22697@ionos.tec.linutronix.de>
 <1397638263.6147.7.camel@AMDC1943>
Message-ID: <alpine.DEB.2.02.1404161137100.22697@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Apr 2014, Krzysztof Kozlowski wrote:
> On wto, 2014-04-15 at 18:20 +0200, Thomas Gleixner wrote:
> > Here is a complete solution to the problem. We really want the drivers
> > to be fast and clean and not work around such issues.
> > 
> > I'm quite happy that I kept the 'force' argument of set_affinity
> > callbacks. I knew that I'd need it at some point.
> > 
> > So with the flag set we can disable the online mask check and force
> > the interrupt to the proper cpu.
> 
> Thanks for the solution.
> 
> I tested your patch on Exynos 3250 and it is still not sufficient. After
> hotplugging CPU1 ~10 times the stall happens (set_next_event is called
> on wrong CPU).
> 
> The patch 3/3 ("clocksource: exynos_mct: Fix too early ISR fire up on
> wrong CPU") is needed as the clockevents_config_and_register should be
> called a little later.

Ok. That makes sense.
 
> Do you have rest of patches (2/3 and 3/3) or should I resend them?
> 
> And one minor nit in your patch: 'cpu' local variable in
> exynos4_mct_cpu_notify() is no longer used so it can be removed.

Right.

I'm going to create a proper patch for the interrupt side and stick
that into irq/urgent. It's trivial enough to go in right away and I'll
tag it stable as well. You can build your changes on top then.

Thanks,

	tglx
