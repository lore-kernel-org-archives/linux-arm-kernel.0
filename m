From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Mar 2015 18:43:18 +0000
Subject: [PATCH v2 0/6] ARM: at91: fix irq_pm_install_action WARNING
In-Reply-To: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150304184318.GE22156@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Other than the watchdog patch, which I'm a little confused by, this all
looks fine to me. So for the other patches:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Sorry I haven't replied to anything for the last few days, and thanks
for digging into this.

Thanks,
Mark.

On Mon, Mar 02, 2015 at 09:18:12AM +0000, Boris Brezillon wrote:
> My apologies to those of you who already received this series, but I
> didn't increment the patch version and forgot some subsystem maintainers
> and MLs.
> 
> Commit cab303be91dc47942bc25de33dc1140123540800 [1] introduced a WARN_ON
> test which triggers a WARNING backtrace on at91 platforms.
> While this WARN_ON is absolutely necessary to warn users that they should
> not mix request with and without IRQF_NO_SUSPEND flags on shared IRQs,
> there is no easy way to solve this issue on at91 platforms.
> 
> The main reason is that the init timer is often using a shared irq line
> and thus request this irq with IRQF_NO_SUSPEND flag set, while other
> peripherals request the same irq line without this flag.
> 
> This problem has recently been addressed by this patch [2] which adds
> a new IRQF_COND_SUSPEND flag, that authorize mixing IRQF_NO_SUSPEND and
> !IRQF_NO_SUSPEND as long as irq handlers setting IRQF_COND_SUSPEND
> can safely be called in suspended state.
> 
> Doing this also implies taking care of system wakeup in devices handlers
> if they tag the IRQ line as a wakeup source.
> The first patch of this series exports the pm_system_wakeup symbol so
> that drivers can call pm_system_wakeup from their interrupt handler.
> 
> This series then patches all at91 drivers that can have devices sharing
> their IRQ line with a timer.
> 
> This series depends on [2].
> 
> Best Regards,
> 
> Boris
> 
> [1]https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/kernel/irq/pm.c?id=cab303be91dc47942bc25de33dc1140123540800
> [2]https://lkml.org/lkml/2015/2/26/675
> 
> Changes since v1:
>  - replaced the IRQF_SUSPEND_NOACTION flag by IRQF_COND_SUSPEND
>  - properly addressed wakeup handling in drivers
> 
> Boris Brezillon (6):
>   PM / wakeup: export pm_system_wakeup symbol
>   rtc: at91sam9: rework wakeup and interrupt handling
>   rtc: at91rm9200: rework wakeup and interrupt handling
>   clk: at91: implement suspend/resume for the PMC irqchip
>   watchdog: at91sam9: request the irq with IRQF_NO_SUSPEND
>   tty: serial: atmel: rework interrupt and wakeup handling
> 
>  drivers/base/power/wakeup.c       |  1 +
>  drivers/clk/at91/pmc.c            | 20 ++++++++++-
>  drivers/clk/at91/pmc.h            |  1 +
>  drivers/rtc/rtc-at91rm9200.c      | 62 +++++++++++++++++++++++++--------
>  drivers/rtc/rtc-at91sam9.c        | 73 ++++++++++++++++++++++++++++++++-------
>  drivers/tty/serial/atmel_serial.c | 49 +++++++++++++++++++++++---
>  drivers/watchdog/at91sam9_wdt.c   |  3 +-
>  7 files changed, 177 insertions(+), 32 deletions(-)
> 
> -- 
> 1.9.1
> 
> 
