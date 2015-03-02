From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 2 Mar 2015 10:05:58 +0100
Subject: [PATCH 0/6] ARM: at91: fix irq_pm_install_action WARNING
In-Reply-To: <50911513.ad0Lf8479H@vostro.rjw.lan>
References: <1425049798-5891-1-git-send-email-boris.brezillon@free-electrons.com>
 <50911513.ad0Lf8479H@vostro.rjw.lan>
Message-ID: <20150302100558.2287b6b4@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On Fri, 27 Feb 2015 23:33:35 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Friday, February 27, 2015 04:09:52 PM Boris Brezillon wrote:
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
> Series looks good to me (although admittedly I'm not familiar with the
> drivers in question).
> 
> Do you want me to apply it on top of [2]?

I'd like to wait for Nicolas' ack.
BTW, I realized I didn't send the series to the relevant subsystem
maintainers and I forgot to increment the patch version (I already
posted a v1 a few weeks ago), so I'll probably resend it.

You can take the first patch though.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
