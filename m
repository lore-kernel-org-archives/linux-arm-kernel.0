From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Wed, 4 Feb 2015 09:57:31 -0800
Subject: [PATCH] ARM: Don't use complete() during __cpu_die
In-Reply-To: <1423068835-25470-1-git-send-email-k.kozlowski@samsung.com>
References: <1423068835-25470-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150204175731.GH5370@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 05:53:55PM +0100, Krzysztof Kozlowski wrote:
> The complete() should not be used on offlined CPU. Rewrite the
> wait-complete mechanism with wait_on_bit_timeout().
> 
> The CPU triggering hot unplug (e.g. CPU0) will loop until some bit is
> cleared. In each iteration schedule_timeout() is used with initial sleep
> time of 1 ms.  Later it is increased to 10 ms.
> 
> The dying CPU will clear the bit which is safe in that context.
> 
> This fixes following RCU warning on ARMv8 (Exynos 4412, Trats2) during
> suspend to RAM:
> 
> [   31.113925] ===============================
> [   31.113928] [ INFO: suspicious RCU usage. ]
> [   31.113935] 3.19.0-rc7-next-20150203 #1914 Not tainted
> [   31.113938] -------------------------------
> [   31.113943] kernel/sched/fair.c:4740 suspicious rcu_dereference_check() usage!
> [   31.113946]
> [   31.113946] other info that might help us debug this:
> [   31.113946]
> [   31.113952]
> [   31.113952] RCU used illegally from offline CPU!
> [   31.113952] rcu_scheduler_active = 1, debug_locks = 0
> [   31.113957] 3 locks held by swapper/1/0:
> [   31.113988]  #0:  ((cpu_died).wait.lock){......}, at: [<c005a114>] complete+0x14/0x44
> [   31.114012]  #1:  (&p->pi_lock){-.-.-.}, at: [<c004a790>] try_to_wake_up+0x28/0x300
> [   31.114035]  #2:  (rcu_read_lock){......}, at: [<c004f1b8>] select_task_rq_fair+0x5c/0xa04
> [   31.114038]
> [   31.114038] stack backtrace:
> [   31.114046] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.19.0-rc7-next-20150203 #1914
> [   31.114050] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [   31.114076] [<c0014ce4>] (unwind_backtrace) from [<c0011c30>] (show_stack+0x10/0x14)
> [   31.114091] [<c0011c30>] (show_stack) from [<c04dc048>] (dump_stack+0x70/0xbc)
> [   31.114105] [<c04dc048>] (dump_stack) from [<c004f83c>] (select_task_rq_fair+0x6e0/0xa04)
> [   31.114118] [<c004f83c>] (select_task_rq_fair) from [<c004a83c>] (try_to_wake_up+0xd4/0x300)
> [   31.114129] [<c004a83c>] (try_to_wake_up) from [<c00598a0>] (__wake_up_common+0x4c/0x80)
> [   31.114140] [<c00598a0>] (__wake_up_common) from [<c00598e8>] (__wake_up_locked+0x14/0x1c)
> [   31.114150] [<c00598e8>] (__wake_up_locked) from [<c005a134>] (complete+0x34/0x44)
> [   31.114167] [<c005a134>] (complete) from [<c04d6ca4>] (cpu_die+0x24/0x84)
> [   31.114179] [<c04d6ca4>] (cpu_die) from [<c005a508>] (cpu_startup_entry+0x328/0x358)
> [   31.114189] [<c005a508>] (cpu_startup_entry) from [<40008784>] (0x40008784)
> [   31.114226] CPU1: shutdown
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

One suggestion below, but either way:

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

(If you would rather that I carried the patch, please let me know.)

> ---
>  arch/arm/kernel/smp.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 86ef244c5a24..bb8ff465975f 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -26,6 +26,7 @@
>  #include <linux/completion.h>
>  #include <linux/cpufreq.h>
>  #include <linux/irq_work.h>
> +#include <linux/wait.h>
> 
>  #include <linux/atomic.h>
>  #include <asm/smp.h>
> @@ -76,6 +77,9 @@ enum ipi_msg_type {
> 
>  static DECLARE_COMPLETION(cpu_running);
> 
> +#define CPU_DIE_WAIT_BIT		0
> +static unsigned long wait_cpu_die;
> +
>  static struct smp_operations smp_ops;
> 
>  void __init smp_set_ops(struct smp_operations *ops)
> @@ -133,6 +137,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>  		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
>  	}
> 
> +	set_bit(CPU_DIE_WAIT_BIT, &wait_cpu_die);
> +	smp_mb__after_atomic();
> 
>  	memset(&secondary_data, 0, sizeof(secondary_data));
>  	return ret;
> @@ -213,7 +219,40 @@ int __cpu_disable(void)
>  	return 0;
>  }
> 
> -static DECLARE_COMPLETION(cpu_died);
> +/*
> + * Wait for 5000*1 ms for 'wait_cpu_die' bit to be cleared.
> + * Actually the real wait time will be longer because of schedule()
> + * called bit_wait_timeout.
> + *
> + * Returns 0 if bit was cleared (CPU died) or non-zero
> + * otherwise (1 or negative ERRNO).
> + */
> +static int wait_for_cpu_die(void)
> +{
> +	int retries = 5000, sleep_ms = 1, ret = 0;
> +
> +	might_sleep();
> +
> +	smp_mb__before_atomic();
> +	while (test_bit(CPU_DIE_WAIT_BIT, &wait_cpu_die)) {
> +		ret = out_of_line_wait_on_bit_timeout(&wait_cpu_die,
> +				CPU_DIE_WAIT_BIT, bit_wait_timeout,
> +				TASK_UNINTERRUPTIBLE,
> +				msecs_to_jiffies(sleep_ms));
> +		if (!ret || (--retries <= 0))
> +			break;
> +
> +		if (retries < 4000) {
> +			/* After ~1000 ms increase sleeping time to 10 ms */
> +			retries = 400;
> +			sleep_ms = 10;
> +		}

Another approach that gets roughly the same response times with fewer
wakeups (and a bit less code) would be something like this:

	int ms_left = 5000, sleep_ms = 1, ret = 0;

	might_sleep();

	smp_mb__before_atomic();
	while (test_bit(CPU_DIE_WAIT_BIT, &wait_cpu_die)) {
		ret = out_of_line_wait_on_bit_timeout(&wait_cpu_die,
				CPU_DIE_WAIT_BIT, bit_wait_timeout,
				TASK_UNINTERRUPTIBLE,
				msecs_to_jiffies(sleep_ms));
		ms_left -= sleep_ms;
		if (!ret || (ms_left <= 0))
			break;
		sleep_ms = DIV_ROUND_UP(sleep_ms * 11, 10);

This would result in less than 50 wakeups compared to more than 4000,
with little added latency in the common case.

But either way works for me.

> +
> +		smp_mb__before_atomic(); /* For next test_bit() in loop */
> +	}
> +
> +	return ret;
> +}
> 
>  /*
>   * called on the thread which is asking for a CPU to be shutdown -
> @@ -221,7 +260,7 @@ static DECLARE_COMPLETION(cpu_died);
>   */
>  void __cpu_die(unsigned int cpu)
>  {
> -	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
> +	if (wait_for_cpu_die()) {
>  		pr_err("CPU%u: cpu didn't die\n", cpu);
>  		return;
>  	}
> @@ -236,6 +275,10 @@ void __cpu_die(unsigned int cpu)
>  	 */
>  	if (!platform_cpu_kill(cpu))
>  		pr_err("CPU%u: unable to kill\n", cpu);
> +
> +	/* Prepare the bit for some next CPU die */
> +	set_bit(CPU_DIE_WAIT_BIT, &wait_cpu_die);
> +	smp_mb__after_atomic();
>  }
> 
>  /*
> @@ -250,6 +293,8 @@ void __ref cpu_die(void)
>  {
>  	unsigned int cpu = smp_processor_id();
> 
> +	WARN_ON(!test_bit(CPU_DIE_WAIT_BIT, &wait_cpu_die));
> +
>  	idle_task_exit();
> 
>  	local_irq_disable();
> @@ -267,7 +312,8 @@ void __ref cpu_die(void)
>  	 * this returns, power and/or clocks can be removed at any point
>  	 * from this CPU and its cache by platform_cpu_kill().
>  	 */
> -	complete(&cpu_died);
> +	clear_bit(CPU_DIE_WAIT_BIT, &wait_cpu_die);
> +	smp_mb__after_atomic();
> 
>  	/*
>  	 * Ensure that the cache lines associated with that completion are
> -- 
> 1.9.1
> 
