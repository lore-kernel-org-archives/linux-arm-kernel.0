From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Mon, 10 Dec 2012 06:29:14 -0800
Subject: [PATCH RT 2/2][RFC] let RCU stall messages escape with
 CONFIG_PREEMPT_RT_FULL
In-Reply-To: <50BED305.9090308@am.sony.com>
References: <50BED1DA.7070907@am.sony.com>
 <50BED305.9090308@am.sony.com>
Message-ID: <20121210142914.GP2516@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 08:52:21PM -0800, Frank Rowand wrote:
> 
> The printk()s in RCU stall warnings do not get flushed to the console
> on ARM.  Add the oops_in_progress flag back into the special trylock case in
> console_trylock_for_printk(), and set the flag using "bust_spinlocks(1)".
> This allows the printk() output to be flushed to the console.
> 
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>

Is bust_spinlocks(1) appropriate for all architectures, or should this
be conditioned on architectures that need oops_in_progress to be set?

							Thanx, Paul

> ---
>  kernel/printk.c  |    5 	3 +	2 -	0 !
>  kernel/rcutree.c |   14 	14 +	0 -	0 !
>  2 files changed, 17 insertions(+), 2 deletions(-)
> 
> Index: b/kernel/printk.c
> ===================================================================
> --- a/kernel/printk.c
> +++ b/kernel/printk.c
> @@ -1390,8 +1390,9 @@ static int console_trylock_for_printk(un
>  {
>  	int retval = 0, wake = 0;
>  #ifdef CONFIG_PREEMPT_RT_FULL
> -	int lock = !early_boot_irqs_disabled && !irqs_disabled_flags(flags) &&
> -		(preempt_count() <= 1);
> +	int lock = oops_in_progress || (
> +		!early_boot_irqs_disabled && !irqs_disabled_flags(flags) &&
> +		(preempt_count() <= 1));
>  #else
>  	int lock = 1;
>  #endif
> Index: b/kernel/rcutree.c
> ===================================================================
> --- a/kernel/rcutree.c
> +++ b/kernel/rcutree.c
> @@ -758,6 +758,11 @@ static void print_other_cpu_stall(struct
>  	raw_spin_unlock_irqrestore(&rnp->lock, flags);
> 
>  	/*
> +	 * Allow printk() to flush to device
> +	 */
> +	bust_spinlocks(1);
> +
> +	/*
>  	 * OK, time to rat on our buddy...
>  	 * See Documentation/RCU/stallwarn.txt for info on how to debug
>  	 * RCU CPU stall warnings.
> @@ -799,6 +804,8 @@ static void print_other_cpu_stall(struct
> 
>  	rcu_print_detail_task_stall(rsp);
> 
> +	bust_spinlocks(0);
> +
>  	force_quiescent_state(rsp, 0);  /* Kick them all. */
>  }
> 
> @@ -808,6 +815,11 @@ static void print_cpu_stall(struct rcu_s
>  	struct rcu_node *rnp = rcu_get_root(rsp);
> 
>  	/*
> +	 * Allow printk() to flush to device
> +	 */
> +	bust_spinlocks(1);
> +
> +	/*
>  	 * OK, time to rat on ourselves...
>  	 * See Documentation/RCU/stallwarn.txt for info on how to debug
>  	 * RCU CPU stall warnings.
> @@ -820,6 +832,8 @@ static void print_cpu_stall(struct rcu_s
>  	if (!trigger_all_cpu_backtrace())
>  		dump_stack();
> 
> +	bust_spinlocks(0);
> +
>  	raw_spin_lock_irqsave(&rnp->lock, flags);
>  	if (ULONG_CMP_GE(jiffies, rsp->jiffies_stall))
>  		rsp->jiffies_stall = jiffies +
> 
