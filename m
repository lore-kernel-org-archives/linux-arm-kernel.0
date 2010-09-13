From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 13 Sep 2010 23:52:00 +0800
Subject: [PATCH 2/2] ARM: update HARDIRQ_BITS
In-Reply-To: <1284357078-16248-2-git-send-email-haojian.zhuang@marvell.com>
References: <1284357078-16248-1-git-send-email-haojian.zhuang@marvell.com>
	<1284357078-16248-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <AANLkTi=2QEi+RbeEvLjBr-ptiGjcOn9aEur6HLKzZrQ=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 13, 2010 at 1:51 PM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> Remove the direct dependancy between HARDIRQ_BITS and NR_IRQS since SPARSE IRQ
> is introduced in ARM architecture already.
>
> Now if CONFIG_SPARSE_IRQ is enabled, check whether nr_irqs beyond the
> limitation of HARDIRQ_BITS. If CONFIG_SPARSE_IRQ isn't enabled, check
> whether HARDIRQ_BITS beyond the limitation of NR_IRQS.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Eric Miao <eric.y.miao@gmail.com>

Checking the following comments in "include/linux/hardirqs.h":

/*
 * We put the hardirq and softirq counter into the preemption
 * counter. The bitmask has the following meaning:
 *
 * - bits 0-7 are the preemption count (max preemption depth: 256)
 * - bits 8-15 are the softirq count (max # of softirqs: 256)
 *
 * The hardirq count can in theory reach the same as NR_IRQS.
 * In reality, the number of nested IRQS is limited to the stack
 * size as well. For archs with over 1000 IRQS it is not practical
 * to expect that they will all nest. We give a max of 10 bits for
 * hardirq nesting. An arch may choose to give less than 10 bits.
 * m68k expects it to be 8.
 *
......

We defined HARDIRQ_BITS because we want to optimize the cases where NR_IRQS
is a small number and that HARDIRQ_BITS doesn't need to be at its maximum.
And apparently 8 is a nicer number than 10. My understanding of this is: 10
is not a big deal, and unless there are some other significant benefits, we
could just remove all the HARDIRQ_BITS here and just let it fall back to the
default MAX_HARDIRQ_BITS (even no run-time checking is necessary, because we
have already made an assumption that the nested hard IRQs could never exceed
MAX_HARDIRQ_BITS).

> ---
> ?arch/arm/include/asm/hardirq.h | ? ?9 +++------
> ?arch/arm/kernel/irq.c ? ? ? ? ?| ? ?4 ++++
> ?2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
> index 6d7485a..52c5624 100644
> --- a/arch/arm/include/asm/hardirq.h
> +++ b/arch/arm/include/asm/hardirq.h
> @@ -12,14 +12,10 @@ typedef struct {
>
> ?#include <linux/irq_cpustat.h> /* Standard mappings for irq_cpustat_t above */
>
> -#if NR_IRQS > 512
> +/* Restrict hardirq numbers not to exceed 1024. */
> ?#define HARDIRQ_BITS ? 10
> -#elif NR_IRQS > 256
> -#define HARDIRQ_BITS ? 9
> -#else
> -#define HARDIRQ_BITS ? 8
> -#endif
>
> +#ifndef CONFIG_SPARSE_IRQ
> ?/*
> ?* The hardirq mask has to be large enough to have space
> ?* for potentially all IRQ sources in the system nesting
> @@ -28,6 +24,7 @@ typedef struct {
> ?#if (1 << HARDIRQ_BITS) < NR_IRQS
> ?# error HARDIRQ_BITS is too low!
> ?#endif
> +#endif
>
> ?#define __ARCH_IRQ_EXIT_IRQS_DISABLED ?1
>
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index c0d5c3b..82c9219 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -169,6 +169,10 @@ void __init init_IRQ(void)
> ?int __init arch_probe_nr_irqs(void)
> ?{
> ? ? ? ?nr_irqs = arch_nr_irqs ? arch_nr_irqs : NR_IRQS;
> + ? ? ? if (nr_irqs < (1 << HARDIRQ_BITS)) {
> + ? ? ? ? ? ? ? printk(KERN_ERR "HARD_IRQBITS is too low. nr_irqs is %d\n", nr_irqs);
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> ? ? ? ?return 0;
> ?}
> ?#endif
> --
> 1.5.6.5
>
>
