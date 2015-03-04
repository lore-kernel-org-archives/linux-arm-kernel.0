From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 04 Mar 2015 02:43:08 +0100
Subject: [PATCH v2 0/6] ARM: at91: fix irq_pm_install_action WARNING
In-Reply-To: <54F5D4CC.3090805@atmel.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
 <54F5D4CC.3090805@atmel.com>
Message-ID: <1459461.VrAQVInSTR@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 03, 2015 04:35:40 PM Nicolas Ferre wrote:
> Le 02/03/2015 10:18, Boris Brezillon a ?crit :
> > My apologies to those of you who already received this series, but I
> > didn't increment the patch version and forgot some subsystem maintainers
> > and MLs.
> > 
> > Commit cab303be91dc47942bc25de33dc1140123540800 [1] introduced a WARN_ON
> > test which triggers a WARNING backtrace on at91 platforms.
> > While this WARN_ON is absolutely necessary to warn users that they should
> > not mix request with and without IRQF_NO_SUSPEND flags on shared IRQs,
> > there is no easy way to solve this issue on at91 platforms.
> > 
> > The main reason is that the init timer is often using a shared irq line
> > and thus request this irq with IRQF_NO_SUSPEND flag set, while other
> > peripherals request the same irq line without this flag.
> > 
> > This problem has recently been addressed by this patch [2] which adds
> > a new IRQF_COND_SUSPEND flag, that authorize mixing IRQF_NO_SUSPEND and
> > !IRQF_NO_SUSPEND as long as irq handlers setting IRQF_COND_SUSPEND
> > can safely be called in suspended state.
> > 
> > Doing this also implies taking care of system wakeup in devices handlers
> > if they tag the IRQ line as a wakeup source.
> > The first patch of this series exports the pm_system_wakeup symbol so
> > that drivers can call pm_system_wakeup from their interrupt handler.
> > 
> > This series then patches all at91 drivers that can have devices sharing
> > their IRQ line with a timer.
> > 
> > This series depends on [2].
> 
> I'm okay with all the patches:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> As it seems easier to keep the whole series together, I'll let Rafael
> take it.

OK, I'll queue up the patches for the next PM pull request.

Thanks!
