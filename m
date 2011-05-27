From: yong.zhang0@gmail.com (Yong Zhang)
Date: Fri, 27 May 2011 15:01:38 +0800
Subject: [BUG] "sched: Remove rq->lock from the first half of ttwu()"
	locks up on ARM
In-Reply-To: <1306430633.2497.91.camel@laptop>
References: <1306343335.21578.65.camel@twins>
	<1306358128.21578.107.camel@twins>
	<BANLkTi=XbTXQsu3jUEvQyCfBy6-aRnqSpw@mail.gmail.com>
	<1306405979.1200.63.camel@twins>
	<1306407759.27474.207.camel@e102391-lin.cambridge.arm.com>
	<1306409575.1200.71.camel@twins> <1306412511.1200.90.camel@twins>
	<20110526154508.GA13788@redhat.com>
	<1306425584.2497.81.camel@laptop> <1306426148.2497.83.camel@laptop>
	<20110526170422.GA18413@redhat.com>
	<1306430264.2497.88.camel@laptop> <1306430633.2497.91.camel@laptop>
Message-ID: <BANLkTincaA75JR3V2Fd6MDCw6yMhUmDdWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2011 at 1:23 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> We'd end up with something like the below, which isn't too different
> from what I've now got queued.
>
> It has the extra cpu == smp_processor_id() check, but I'm not sure this
> whole case is worth the trouble. I could go stick some counters in to
> verify how often all this happens I guess.
>
> ---
> ?arch/x86/include/asm/system.h | ? ?2 ++
> ?kernel/sched.c ? ? ? ? ? ? ? ?| ? 14 +++++++++++---
> ?kernel/sched_debug.c ? ? ? ? ?| ? ?7 +++++++
> ?3 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/system.h b/arch/x86/include/asm/system.h
> index c2ff2a1..2c597e8 100644
> --- a/arch/x86/include/asm/system.h
> +++ b/arch/x86/include/asm/system.h
> @@ -10,6 +10,8 @@
> ?#include <linux/kernel.h>
> ?#include <linux/irqflags.h>
>
> +#define __ARCH_WANT_INTERRUPTS_ON_CTXSW
> +
> ?/* entries in ARCH_DLINFO: */
> ?#if defined(CONFIG_IA32_EMULATION) || !defined(CONFIG_X86_64)
> ?# define AT_VECTOR_SIZE_ARCH 2
> diff --git a/kernel/sched.c b/kernel/sched.c
> index 2d12893..e4f7a9f 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -2636,9 +2636,17 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> ? ? ? ? ? ? ? ? * to spin on ->on_cpu if p is current, since that would
> ? ? ? ? ? ? ? ? * deadlock.
> ? ? ? ? ? ? ? ? */
> - ? ? ? ? ? ? ? if (p == current) {
> - ? ? ? ? ? ? ? ? ? ? ? ttwu_queue(p, cpu);
> - ? ? ? ? ? ? ? ? ? ? ? goto stat;
> + ? ? ? ? ? ? ? if (cpu == smp_processor_id()) {
> + ? ? ? ? ? ? ? ? ? ? ? struct rq *rq;
> +
> + ? ? ? ? ? ? ? ? ? ? ? rq = __task_rq_lock(p);
> + ? ? ? ? ? ? ? ? ? ? ? if (p->on_cpu) {

As Oleg has said, I also think we don't need this check.

> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ttwu_activate(rq, p, ENQUEUE_WAKEUP);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ttwu_do_wakeup(rq, p, wake_flags);

And the difference with ttwu_queue() is ttwu_queue() calls
ttwu_activate() with another flag ENQUEUE_WAKING, so if
we call ->task_waking() before  ttwu_queue(), I guess it will work
too.
But I like this version, because we call ->task_waking() and
ttwu_activate() on the local cpu, that means the calculations on
vruntime in that two functions are accumulated into noop.

Thanks,
Yong

> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __task_rq_unlock(rq);
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? goto stat;
> + ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? ? ? ? ? __task_rq_unlock(rq);
> ? ? ? ? ? ? ? ?}
> ?#endif
> ? ? ? ? ? ? ? ?cpu_relax();
> diff --git a/kernel/sched_debug.c b/kernel/sched_debug.c
> index a6710a1..f0ff1de 100644
> --- a/kernel/sched_debug.c
> +++ b/kernel/sched_debug.c
> @@ -332,6 +332,13 @@ static int sched_debug_show(struct seq_file *m, void *v)
> ? ? ? ? ? ? ? ?(int)strcspn(init_utsname()->version, " "),
> ? ? ? ? ? ? ? ?init_utsname()->version);
>
> +#ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
> + ? ? ? SEQ_printf(m, "__ARCH_WANT_INTERRUPTS_ON_CTXSW\n");
> +#endif
> +#ifdef __ARCH_WANT_UNLOCKED_CTXSW
> + ? ? ? SEQ_printf(m, "__ARCH_WANT_UNLOCKED_CTXSW\n");
> +#endif
> +
> ?#define P(x) \
> ? ? ? ?SEQ_printf(m, "%-40s: %Ld\n", #x, (long long)(x))
> ?#define PN(x) \
>
>
>



-- 
Only stand for myself
