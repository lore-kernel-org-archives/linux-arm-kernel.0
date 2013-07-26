From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 26 Jul 2013 16:18:39 +0100
Subject: [PATCH 05/13] ARM: bL_switcher: move to dedicated threads rather
 than workqueues
In-Reply-To: <1374550289-25305-6-git-send-email-nicolas.pitre@linaro.org>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
 <1374550289-25305-6-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130726151838.GC28084@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 04:31:21AM +0100, Nicolas Pitre wrote:
> The workqueues are problematic as they may be contended.
> They can't be scheduled with top priority either.  Also the optimization
> in bL_switch_request() to skip the workqueue entirely when the target CPU
> and the calling CPU were the same didn't allow for bL_switch_request() to
> be called from atomic context, as might be the case for some cpufreq
> drivers.
> 
> Let's move to dedicated kthreads instead.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  arch/arm/common/bL_switcher.c      | 101 ++++++++++++++++++++++++++++---------
>  arch/arm/include/asm/bL_switcher.h |   2 +-
>  2 files changed, 79 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
> index d6f7e507d9..c2355cafc9 100644
> --- a/arch/arm/common/bL_switcher.c
> +++ b/arch/arm/common/bL_switcher.c
> @@ -15,8 +15,10 @@
>  #include <linux/sched.h>
>  #include <linux/interrupt.h>
>  #include <linux/cpu_pm.h>
> +#include <linux/cpu.h>
>  #include <linux/cpumask.h>
> -#include <linux/workqueue.h>
> +#include <linux/kthread.h>
> +#include <linux/wait.h>
>  #include <linux/clockchips.h>
>  #include <linux/hrtimer.h>
>  #include <linux/tick.h>
> @@ -225,15 +227,48 @@ static int bL_switch_to(unsigned int new_cluster_id)
>  	return ret;
>  }
>  
> -struct switch_args {
> -	unsigned int cluster;
> -	struct work_struct work;
> +struct bL_thread {
> +	struct task_struct *task;
> +	wait_queue_head_t wq;
> +	int wanted_cluster;
>  };
>  
> -static void __bL_switch_to(struct work_struct *work)
> +static struct bL_thread bL_threads[MAX_CPUS_PER_CLUSTER];
> +
> +static int bL_switcher_thread(void *arg)
> +{
> +	struct bL_thread *t = arg;
> +	struct sched_param param = { .sched_priority = 1 };
> +	int cluster;
> +
> +	sched_setscheduler_nocheck(current, SCHED_FIFO, &param);
> +
> +	do {
> +		if (signal_pending(current))
> +			flush_signals(current);
> +		wait_event_interruptible(t->wq,
> +				t->wanted_cluster != -1 ||
> +				kthread_should_stop());
> +		cluster = xchg(&t->wanted_cluster, -1);
> +		if (cluster != -1)
> +			bL_switch_to(cluster);
> +	} while (!kthread_should_stop());
> +
> +	return 0;
> +}
> +
> +static struct task_struct * __init bL_switcher_thread_create(int cpu, void *arg)
>  {
> -	struct switch_args *args = container_of(work, struct switch_args, work);
> -	bL_switch_to(args->cluster);
> +	struct task_struct *task;
> +
> +	task = kthread_create_on_node(bL_switcher_thread, arg,
> +				      cpu_to_node(cpu), "kswitcher_%d", cpu);
> +	if (!IS_ERR(task)) {
> +		kthread_bind(task, cpu);
> +		wake_up_process(task);
> +	} else
> +		pr_err("%s failed for CPU %d\n", __func__, cpu);
> +	return task;
>  }
>  
>  /*
> @@ -242,26 +277,46 @@ static void __bL_switch_to(struct work_struct *work)
>   * @cpu: the CPU to switch
>   * @new_cluster_id: the ID of the cluster to switch to.
>   *
> - * This function causes a cluster switch on the given CPU.  If the given
> - * CPU is the same as the calling CPU then the switch happens right away.
> - * Otherwise the request is put on a work queue to be scheduled on the
> - * remote CPU.
> + * This function causes a cluster switch on the given CPU by waking up
> + * the appropriate switcher thread.  This function may or may not return
> + * before the switch has occurred.
>   */
> -void bL_switch_request(unsigned int cpu, unsigned int new_cluster_id)
> +int bL_switch_request(unsigned int cpu, unsigned int new_cluster_id)
>  {
> -	unsigned int this_cpu = get_cpu();
> -	struct switch_args args;
> +	struct bL_thread *t;
>  
> -	if (cpu == this_cpu) {
> -		bL_switch_to(new_cluster_id);
> -		put_cpu();
> -		return;
> +	if (cpu >= MAX_CPUS_PER_CLUSTER) {
> +		pr_err("%s: cpu %d out of bounds\n", __func__, cpu);
> +		return -EINVAL;
>  	}
> -	put_cpu();
>  
> -	args.cluster = new_cluster_id;
> -	INIT_WORK_ONSTACK(&args.work, __bL_switch_to);
> -	schedule_work_on(cpu, &args.work);
> -	flush_work(&args.work);
> +	t = &bL_threads[cpu];
> +	if (IS_ERR(t->task))
> +		return PTR_ERR(t->task);
> +	if (!t->task)
> +		return -ESRCH;
> +
> +	t->wanted_cluster = new_cluster_id;
> +	wake_up(&t->wq);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(bL_switch_request);
> +
> +static int __init bL_switcher_init(void)
> +{
> +	int cpu;
> +
> +	pr_info("big.LITTLE switcher initializing\n");
> +
> +	for_each_online_cpu(cpu) {
> +		struct bL_thread *t = &bL_threads[cpu];
> +		init_waitqueue_head(&t->wq);

Dereferencing &bL_threads[cpu] is wrong without checking the cpu index against
MAX_CPUS_PER_CLUSTER. I know you hotplug out half of the CPUs in a later patch but
still, this code needs fixing.

> +		t->wanted_cluster = -1;
> +		t->task = bL_switcher_thread_create(cpu, t);
> +	}
> +
> +	pr_info("big.LITTLE switcher initialized\n");
> +	return 0;
> +}
> +
> +late_initcall(bL_switcher_init);
> diff --git a/arch/arm/include/asm/bL_switcher.h b/arch/arm/include/asm/bL_switcher.h
> index 72efe3f349..e0c0bba70b 100644
> --- a/arch/arm/include/asm/bL_switcher.h
> +++ b/arch/arm/include/asm/bL_switcher.h
> @@ -12,6 +12,6 @@
>  #ifndef ASM_BL_SWITCHER_H
>  #define ASM_BL_SWITCHER_H
>  
> -void bL_switch_request(unsigned int cpu, unsigned int new_cluster_id);
> +int bL_switch_request(unsigned int cpu, unsigned int new_cluster_id);

We probably discussed this before, and it is not strictly related to
this patch, but is locking/queuing necessary when requesting a switch ? I do
not remember the outcome of the discussion so I am asking again.

I will go through this patch in details later.

Lorenzo
