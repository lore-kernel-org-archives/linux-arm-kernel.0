From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 16 Feb 2015 10:49:46 +0100
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150211171313.GS9154@leverpostej>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150211155720.GQ9154@leverpostej>
 <20150211171515.55d5066f@bbrezillon>
 <2067295.NbJCftPPli@vostro.rjw.lan>
 <20150211171313.GS9154@leverpostej>
Message-ID: <20150216094946.GG7119@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Please change the Subject to start with [PATCH] again when including
patches, otherwise its too easy for them to get lost. Esp. with
excessive quoting on top.

I nearly missed the patch here, seeing nothing in the first page of
text.

On Wed, Feb 11, 2015 at 05:13:13PM +0000, Mark Rutland wrote:
> ---
>  include/linux/interrupt.h |  5 +++++
>  kernel/irq/pm.c           | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index d9b05b5..2b8ff50 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -57,6 +57,9 @@
>   * IRQF_NO_THREAD - Interrupt cannot be threaded
>   * IRQF_EARLY_RESUME - Resume IRQ early during syscore instead of at device
>   *                resume time.
> + * IRQF_SHARED_TIMER_OK - Interrupt is safe to be shared with a timer. The
> + *                        handler may be called spuriously during suspend
> + *                        without issue.

I feel we should do better documenting this; at the very least refer to
Documentation/power/suspend-and-interrupts.txt and ideally put a scary
note in telling people that if they use this as a bandaid to make the
warn go away, they will end up with a broken system.

Now ideally every driver that employs this should also have a comment
next to it how it does indeed behave nicely, such that we can 'quickly'
see people have indeed thought about things and not just slapped it on
to make the WARN go away.

> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index 3ca5325..e4ec91a 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -28,6 +28,47 @@ bool irq_pm_check_wakeup(struct irq_desc *desc)

> +	for (action = desc->action; action; action = action->next)
> +		if (!(action->flags & safe_flags))
> +			return false;

In general I prefer braces around the for loop even though C does not
strictly require it. Its just too easy to confuse multi-line statements
with multiple statements. Extra braces comfort the brain in this case.
