From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Feb 2012 13:18:33 +0000
Subject: [PATCH] sched: generalize CONFIG_IRQ_TIME_ACCOUNTING for X86
 and ARM
In-Reply-To: <1328705314-20978-1-git-send-email-dmitry.antipov@linaro.org>
References: <1328705314-20978-1-git-send-email-dmitry.antipov@linaro.org>
Message-ID: <20120208131833.GK889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 04:48:34AM -0800, Dmitry Antipov wrote:
> Generalize CONFIG_IRQ_TIME_ACCOUNTING  between X86 and
> ARM, move "noirqtime=" option to common debugging code.
> For a bit of backward compatibility, "tsc=noirqtime"
> is preserved, but issues a warning.
> 
> Suggested-by: Venki Pallipadi <venki@google.com>
> Signed-off-by: Dmitry Antipov <dmitry.antipov@linaro.org>
> ---
>  arch/arm/kernel/sched_clock.c |    3 +++
>  arch/x86/Kconfig              |   11 -----------
>  arch/x86/kernel/tsc.c         |    7 ++++---
>  include/linux/sched.h         |    2 ++
>  lib/Kconfig.debug             |   12 ++++++++++++
>  lib/Makefile                  |    2 ++
>  lib/irqtime.c                 |   12 ++++++++++++
>  7 files changed, 35 insertions(+), 14 deletions(-)
>  create mode 100644 lib/irqtime.c
> 
> diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
> index 5416c7c..56d2a9d 100644
> --- a/arch/arm/kernel/sched_clock.c
> +++ b/arch/arm/kernel/sched_clock.c
> @@ -162,5 +162,8 @@ void __init sched_clock_postinit(void)
>  	if (read_sched_clock == jiffy_sched_clock_read)
>  		setup_sched_clock(jiffy_sched_clock_read, 32, HZ);
>  
> +	if (!no_sched_irq_time)
> +		enable_sched_clock_irqtime();

Why are you placing this here?  sched_clock is available from the point
that it's registered, which should be before the first sched_clock()
call.

> +config IRQ_TIME_ACCOUNTING
> +	bool "Fine granularity task level IRQ time accounting"
> +	depends on (X86 || (ARM && HAVE_SCHED_CLOCK))

Even though it's not bad here, please get out of the habbit of throwing
unnecessary parens into the mix.  It can make stuff more difficult to
read and therefore confirm correctness.  (I've spent many a time
rewriting if() statements because of paren overuse.)

This could have been written:

	depends on X86 || (ARM && HAVE_SCHED_CLOCK)

However, ARM will always have HAVE_SCHED_CLOCK after the next merge window,
so this can become a much simpler:

	depends on X86 || ARM

Apart from these two points, the rest of the patch looks fine to me but
the ultimate decision about its acceptability is up to other people.
