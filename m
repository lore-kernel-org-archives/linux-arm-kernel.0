From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 Dec 2009 12:24:47 +0000
Subject: [PATCH 3/6] Fix a race in the vfp_notifier() function on SMP
	systems
In-Reply-To: <20091207141325.30429.13315.stgit@pc1117.cambridge.arm.com>
References: <20091207135603.30429.74812.stgit@pc1117.cambridge.arm.com>
	<20091207141325.30429.13315.stgit@pc1117.cambridge.arm.com>
Message-ID: <20091212122447.GA30537@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2009 at 02:13:34PM +0000, Catalin Marinas wrote:
> The vfp_notifier(THREAD_NOTIFY_RELEASE) maybe be called with thread->cpu
> different from the current one, causing a race condition with both the
> THREAD_NOTIFY_SWITCH path and vfp_support_entry().

The only call where thread->cpu may not be the current CPU is in the
THREAD_NOFTIFY_RELEASE case.

When called in the THREAD_NOTIFY_SWITCH case, we are switching to the
specified thread, and thread->cpu better be smp_processor_id() or else
we're saving our CPUs VFP state into some other CPUs currently running
thread.

Not only that, but the thread we're switching away from will still be
'owned' by the CPU we're running on, and can't be scheduled onto another
CPU without this function first completing, nor can it be flushed nor
released.

> @@ -49,14 +50,21 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
>  
>  #ifdef CONFIG_SMP

		BUG_ON(cpu != smp_processor_id());

since it would be very bad if this was any different.  Note that this is
also a non-preemptible context - we're called from the scheduler, and the
scheduler can't be preempted mid-thead switch.

>  		/*
> +		 * RCU locking is needed in case last_VFP_context[cpu] is
> +		 * released on a different CPU.
> +		 */
> +		rcu_read_lock();

Given that we're modifying our CPUs last_VFP_context here, I don't see
what the RCU locks give us - the thread we're switching to can _not_
be being released at this time - we can't be switching to a dead task.
Not only that, but this notifier is already called under the RCU lock,
so this is a no-op.

> +		vfp = last_VFP_context[cpu];
> +		/*
>  		 * On SMP, if VFP is enabled, save the old state in
>  		 * case the thread migrates to a different CPU. The
>  		 * restoring is done lazily.
>  		 */
> -		if ((fpexc & FPEXC_EN) && last_VFP_context[cpu]) {
> -			vfp_save_state(last_VFP_context[cpu], fpexc);
> -			last_VFP_context[cpu]->hard.cpu = cpu;
> +		if ((fpexc & FPEXC_EN) && vfp) {
> +			vfp_save_state(vfp, fpexc);
> +			vfp->hard.cpu = cpu;
>  		}
> +		rcu_read_unlock();
>  		/*
>  		 * Thread migration, just force the reloading of the
>  		 * state on the new CPU in case the VFP registers
> @@ -91,8 +99,19 @@ static int vfp_notifier(struct notifier_block *self, unsigned long cmd, void *v)
>  	}
>  
>  	/* flush and release case: Per-thread VFP cleanup. */
> +#ifndef CONFIG_SMP
>  	if (last_VFP_context[cpu] == vfp)
>  		last_VFP_context[cpu] = NULL;
> +#else
> +	/*
> +	 * Since release_thread() may be called from a different CPU, we use
> +	 * cmpxchg() here to avoid a race with the vfp_support_entry() code
> +	 * which modifies last_VFP_context[cpu]. Note that on SMP systems, a
> +	 * STR instruction on a different CPU clears the global exclusive
> +	 * monitor state.
> +	 */
> +	(void)cmpxchg(&last_VFP_context[cpu], vfp, NULL);
> +#endif

I think this hunk is the only part which makes sense.
