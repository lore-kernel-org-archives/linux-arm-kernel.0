From: pmladek@suse.com (Petr Mladek)
Date: Mon, 8 Aug 2016 15:57:11 +0200
Subject: [PATCH v6 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
In-Reply-To: <1468529432-28026-2-git-send-email-cmetcalf@mellanox.com>
References: <1468529432-28026-1-git-send-email-cmetcalf@mellanox.com>
 <1468529432-28026-2-git-send-email-cmetcalf@mellanox.com>
Message-ID: <20160808135711.GA13300@pathway.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2016-07-14 16:50:29, Chris Metcalf wrote:
> Currently you can only request a backtrace of either all cpus, or
> all cpus but yourself.  It can also be helpful to request a remote
> backtrace of a single cpu, and since we want that, the logical
> extension is to support a cpumask as the underlying primitive.
> 
> This change modifies the existing lib/nmi_backtrace.c code to take
> a cpumask as its basic primitive, and modifies the linux/nmi.h code
> to use either the old "all/all_but_self" arch methods, or the new
> "cpumask" method, depending on which is available.

> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -31,38 +31,75 @@ static inline void hardlockup_detector_disable(void) {}
>  #endif
>  
>  /*
> - * Create trigger_all_cpu_backtrace() out of the arch-provided
> - * base function. Return whether such support was available,
> + * Create trigger_all_cpu_backtrace() etc out of the arch-provided
> + * base function(s). Return whether such support was available,
>   * to allow calling code to fall back to some other mechanism:
>   */
> -#ifdef arch_trigger_all_cpu_backtrace
>  static inline bool trigger_all_cpu_backtrace(void)
>  {
> +#if defined(arch_trigger_all_cpu_backtrace)
>  	arch_trigger_all_cpu_backtrace(true);
> -
>  	return true;
> +#elif defined(arch_trigger_cpumask_backtrace)
> +	arch_trigger_cpumask_backtrace(cpu_online_mask);
> +	return true;
> +#else
> +	return false;
> +#endif
>  }
> +
>  static inline bool trigger_allbutself_cpu_backtrace(void)
>  {
> +#if defined(arch_trigger_all_cpu_backtrace)
>  	arch_trigger_all_cpu_backtrace(false);
>  	return true;
> -}
> -
> -/* generic implementation */
> -void nmi_trigger_all_cpu_backtrace(bool include_self,
> -				   void (*raise)(cpumask_t *mask));
> -bool nmi_cpu_backtrace(struct pt_regs *regs);
> +#elif defined(arch_trigger_cpumask_backtrace)
> +	cpumask_var_t mask;
> +	int cpu = get_cpu();
>  
> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
> +		return false;

I tested this patch by the following change:

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 52bbd27e93ae..404a32699554 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -242,6 +242,7 @@ static void sysrq_handle_showallcpus(int key)
 	 * backtrace printing did not succeed or the
 	 * architecture has no support for it:
 	 */
+	printk("-----------  All CPUs: ---------------------\n");
 	if (!trigger_all_cpu_backtrace()) {
 		struct pt_regs *regs = get_irq_regs();
 
@@ -251,6 +252,10 @@ static void sysrq_handle_showallcpus(int key)
 		}
 		schedule_work(&sysrq_showallcpus);
 	}
+	printk("-----------  All but itself: ---------------------\n");
+	trigger_allbutself_cpu_backtrace();
+	printk("-----------  Only two: ---------------------\n");
+	trigger_single_cpu_backtrace(2);
 }
 
 static struct sysrq_key_op sysrq_showallcpus_op = {


Then I triggered this function using

  echo l >/proc/sysrq-trigger


and got

[  270.791328] -----------  All but itself: ---------------------

[  270.791331] ===============================
[  270.791331] [ INFO: suspicious RCU usage. ]
[  270.791333] 4.8.0-rc1-4-default+ #3086 Not tainted
[  270.791333] -------------------------------
[  270.791335] ./include/linux/rcupdate.h:556 Illegal context switch in RCU read-side critical section!
[  270.791339] 
               other info that might help us debug this:

[  270.791340] 
               rcu_scheduler_active = 1, debug_locks = 0
[  270.791341] 2 locks held by bash/3720:
[  270.791347]  #0:  (sb_writers#5){.+.+.+}, at: [<ffffffff8122c9e1>] __sb_start_write+0xd1/0xf0
[  270.791351]  #1:  (rcu_read_lock){......}, at: [<ffffffff8152d8a5>] __handle_sysrq+0x5/0x220
[  270.791352] 
               stack backtrace:
[  270.791354] CPU: 3 PID: 3720 Comm: bash Not tainted 4.8.0-rc1-4-default+ #3086
[  270.791355] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[  270.791359]  0000000000000000 ffff88013688fc58 ffffffff8143ddac ffff880135748600
[  270.791362]  0000000000000001 ffff88013688fc88 ffffffff810c9727 ffff88013fd98c00
[  270.791365]  0000000000018c00 00000000024000c0 0000000000000000 ffff88013688fce0
[  270.791366] Call Trace:
[  270.791369]  [<ffffffff8143ddac>] dump_stack+0x85/0xc9
[  270.791372]  [<ffffffff810c9727>] lockdep_rcu_suspicious+0xe7/0x120
[  270.791374]  [<ffffffff81951beb>] __schedule+0x4eb/0x820
[  270.791377]  [<ffffffff819521b7>] preempt_schedule_common+0x18/0x31
[  270.791379]  [<ffffffff819521ec>] _cond_resched+0x1c/0x30
[  270.791382]  [<ffffffff81201164>] kmem_cache_alloc_node_trace+0x224/0x340
[  270.791385]  [<ffffffff812012f1>] __kmalloc_node+0x31/0x40
[  270.791388]  [<ffffffff8143db64>] alloc_cpumask_var_node+0x24/0x30
[  270.791391]  [<ffffffff8143db9e>] alloc_cpumask_var+0xe/0x10
[  270.791393]  [<ffffffff8152d64b>] sysrq_handle_showallcpus+0x4b/0xd0
[  270.791395]  [<ffffffff8152d9d6>] __handle_sysrq+0x136/0x220
[  270.791398]  [<ffffffff8152d8a5>] ? __handle_sysrq+0x5/0x220
[  270.791401]  [<ffffffff8152dee6>] write_sysrq_trigger+0x46/0x60
[  270.791403]  [<ffffffff8129cc1d>] proc_reg_write+0x3d/0x70
[  270.791406]  [<ffffffff810e770f>] ? rcu_sync_lockdep_assert+0x2f/0x60
[  270.791408]  [<ffffffff81229028>] __vfs_write+0x28/0x120
[  270.791411]  [<ffffffff810c6e59>] ? percpu_down_read+0x49/0x80
[  270.791412]  [<ffffffff8122c9e1>] ? __sb_start_write+0xd1/0xf0
[  270.791414]  [<ffffffff8122c9e1>] ? __sb_start_write+0xd1/0xf0
[  270.791416]  [<ffffffff81229722>] vfs_write+0xb2/0x1b0
[  270.791419]  [<ffffffff810ca5f9>] ? trace_hardirqs_on_caller+0xf9/0x1c0
[  270.791423]  [<ffffffff8122aa79>] SyS_write+0x49/0xa0
[  270.791427]  [<ffffffff8195867c>] entry_SYSCALL_64_fastpath+0x1f/0xbd
[  270.791502] Sending NMI from CPU 3 to CPUs 0-2:


I guess that you allocate the mask because you do not want
to have the mask twice on the stack.

Hmm, people might want to call this function in different context
and also when the system is somehow borked. Having huge variables
on stack might be dangerous but allocation is dangerous as well.
I think that we should not combine both dangers here.

I would try using local variable. If it causes problems, we could
always add some more complexity to avoid copying the mask later.


> +	cpumask_copy(mask, cpu_online_mask);
> +	cpumask_clear_cpu(cpu, mask);
> +	arch_trigger_cpumask_backtrace(mask);
> +	put_cpu();
> +	free_cpumask_var(mask);
> +	return true;

Also this looks too much code for an inlined function.
It is rather slow and there is not a big gain. I would move
the definition to lib/nmi_backtrace.c.

>  #else
> -static inline bool trigger_all_cpu_backtrace(void)
> -{
>  	return false;
> +#endif
>  }
> -static inline bool trigger_allbutself_cpu_backtrace(void)
> +
> +static inline bool trigger_cpumask_backtrace(struct cpumask *mask)
>  {
> +#if defined(arch_trigger_cpumask_backtrace)
> +	arch_trigger_cpumask_backtrace(mask);
> +	return true;
> +#else
>  	return false;
> +#endif
>  }
> +
> +static inline bool trigger_single_cpu_backtrace(int cpu)
> +{
> +#if defined(arch_trigger_cpumask_backtrace)
> +	cpumask_var_t mask;
> +
> +	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
> +		return false;
> +	cpumask_set_cpu(cpu, mask);
> +	arch_trigger_cpumask_backtrace(mask);
> +	free_cpumask_var(mask);

I would avoid the allocation here as well. Also I would move
this into lib/nmi_backtrace.c.


Best Regards,
Petr

PS: I am sorry for sending this so late in the game. I was
curious why the patch had not been upstream yet and. I made
a closer look to give a Reviewed-by tag...
