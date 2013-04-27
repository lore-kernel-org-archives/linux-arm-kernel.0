From: olof@lixom.net (Olof Johansson)
Date: Fri, 26 Apr 2013 17:18:38 -0700
Subject: [PATCH/RESEND] ARM: arch_timer: Silence debug preempt warnings
In-Reply-To: <1366241178-16626-1-git-send-email-sboyd@codeaurora.org>
References: <1366241178-16626-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20130427001838.GA2134@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 04:26:18PM -0700, Stephen Boyd wrote:
> Hot-plugging with CONFIG_DEBUG_PREEMPT=y on a device with arm
> architected timers causes a slew of "using smp_processor_id() in
> preemptible" warnings:
> 
>   BUG: using smp_processor_id() in preemptible [00000000] code: sh/111
>   caller is arch_timer_cpu_notify+0x14/0xc8
> 
> This happens because sometimes the cpu notifier,
> arch_timer_cpu_notify(), is called in preemptible context and
> other times in non-preemptible context but we use this_cpu_ptr()
> to retrieve the clockevent in all cases. We're only going to
> actually use the pointer in non-preemptible context though, so
> push the this_cpu_ptr() access down into the cases to force the
> checks to occur only in non-preemptible contexts.
> 
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Marc Zyngier <Marc.Zyngier@arm.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> Resending to arm-soc maintainers instead of timekeeping maintainers. Who
> maintains this driver?

Subsystem is maintained by John and Thomas, but given the recent moves of ARM
drivers there (which mostly has been acked by them), we'll take the patch at
this time.

Applied on top of late/clksrc in arm-soc. Thanks.


-Olof
