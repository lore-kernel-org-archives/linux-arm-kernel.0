From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Sun, 22 Mar 2015 16:30:57 -0700
Subject: [PATCH v2] ARM: Don't use complete() during __cpu_die
In-Reply-To: <20150226010505.GU15405@linux.vnet.ibm.com>
References: <1423131270-24047-1-git-send-email-k.kozlowski@samsung.com>
 <20150205105035.GL8656@n2100.arm.linux.org.uk>
 <20150205142918.GA10634@linux.vnet.ibm.com>
 <20150205161100.GQ8656@n2100.arm.linux.org.uk>
 <20150225125610.GY8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1502250941210.25484@knanqh.ubzr>
 <20150225170011.GC8656@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1502251257410.25484@knanqh.ubzr>
 <alpine.LFD.2.11.1502251427580.25484@knanqh.ubzr>
 <20150226010505.GU15405@linux.vnet.ibm.com>
Message-ID: <20150322233057.GA17605@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 05:05:05PM -0800, Paul E. McKenney wrote:
> On Wed, Feb 25, 2015 at 03:16:59PM -0500, Nicolas Pitre wrote:
> > On Wed, 25 Feb 2015, Nicolas Pitre wrote:
> > 
> > > On Wed, 25 Feb 2015, Russell King - ARM Linux wrote:
> > > 
> > > > We could just use the spin-and-poll solution instead of an IPI, but
> > > > I really don't like that - when you see the complexity needed to
> > > > re-initialise it each time, it quickly becomes very yucky because
> > > > there is no well defined order between __cpu_die() and __cpu_kill()
> > > > being called by the two respective CPUs.
> > > > 
> > > > The last patch I saw doing that had multiple bits to indicate success
> > > > and timeout, and rather a lot of complexity to recover from failures,
> > > > and reinitialise state for a second CPU going down.
> > > 
> > > What about a per CPU state?  That would at least avoid the need to 
> > > serialize things across CPUs.  If only one CPU may write its state, that 
> > > should eliminate the need for any kind of locking.
> > 
> > Something like the following?  If according to $subject it is the 
> > complete() usage that has problems, then this replacement certainly has 
> > it removed while keeping things simple.  And I doubt CPU hotplug is 
> > performance critical so a simple polling is certainly good enough.
> 
> For whatever it is worth, I am proposing the patch below for common code.
> Works on x86.  (Famous last words...)

So I am intending to submit these changes to the upcoming merge window.
Do you guys have something in place for ARM?

							Thanx, Paul

> ------------------------------------------------------------------------
> 
> smpboot: Add common code for notification from dying CPU
> 
> RCU ignores offlined CPUs, so they cannot safely run RCU read-side code.
> (They -can- use SRCU, but not RCU.)  This means that any use of RCU
> during or after the call to arch_cpu_idle_dead().  Unfortunately,
> commit 2ed53c0d6cc99 added a complete() call, which will contain RCU
> read-side critical sections if there is a task waiting to be awakened.
> 
> Which, as it turns out, there almost never is.  In my qemu/KVM testing,
> the to-be-awakened task is not yet asleep more than 99.5% of the time.
> In current mainline, failure is even harder to reproduce, requiring a
> virtualized environment that delays the outgoing CPU by at least three
> jiffies between the time it exits its stop_machine() task at CPU_DYING
> time and the time it calls arch_cpu_idle_dead() from the idle loop.
> However, this problem really can occur, especially in virtualized
> environments, and therefore really does need to be fixed
> 
> This suggests moving back to the polling loop, but using a much shorter
> wait, with gentle exponential backoff instead of the old 100-millisecond
> wait.  Most of the time, the loop will exit without waiting at all,
> and almost all of the remaining uses will wait only five microseconds.
> If the outgoing CPU is preempted, a loop will wait one jiffy, then
> increase the wait by a factor of 11/10ths, rounding up.  As before, there
> is a five-second timeout.
> 
> This commit therefore provides common-code infrastructure to do the
> dying-to-surviving CPU handoff in a safe manner.  This code also
> provides an indication at CPU-online of whether the CPU to be onlined
> previously timed out on offline.  The new cpu_check_up_prepare() function
> returns -EBUSY if this CPU previously took more than five seconds to
> go offline, or -EAGAIN if it has not yet managed to go offline.  The
> rationale for -EAGAIN is that it might still be preempted, so an additional
> wait might well find it correctly offlined.  Architecture-specific code
> can decide how to handle these conditions.  Systems in which CPUs take
> themselves completely offline might respond to an -EBUSY return as if
> it was a zero (success) return.  Systems in which the surviving CPU must
> take some action might take it at this time, or might simply mark the
> other CPU as unusable.
> 
> Note that architectures that take the easy way out and simply pass the
> -EBUSY and -EAGAIN upwards will change the sysfs API.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: <linux-api@vger.kernel.org>
> Cc: <linux-arch@vger.kernel.org>
> 
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 1d58c7a6ed72..ef87e3c2451a 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -97,6 +97,8 @@ enum {
>  					* must not fail */
>  #define CPU_DYING_IDLE		0x000B /* CPU (unsigned)v dying, reached
>  					* idle loop. */
> +#define CPU_BROKEN		0x000C /* CPU (unsigned)v did not die properly,
> +					* perhaps due to preemption. */
>  
>  /* Used for CPU hotplug events occurring while tasks are frozen due to a suspend
>   * operation in progress
> @@ -275,4 +277,12 @@ void arch_cpu_idle_dead(void);
>  
>  DECLARE_PER_CPU(bool, cpu_dead_idle);
>  
> +int cpu_report_state(int cpu);
> +int cpu_check_up_prepare(int cpu);
> +void cpu_set_state_online(int cpu);
> +#ifdef CONFIG_HOTPLUG_CPU
> +bool cpu_wait_death(unsigned int cpu);
> +bool cpu_report_death(void);
> +#endif /* #ifdef CONFIG_HOTPLUG_CPU */
> +
>  #endif /* _LINUX_CPU_H_ */
> diff --git a/kernel/smpboot.c b/kernel/smpboot.c
> index f032fb5284e3..e940f68008db 100644
> --- a/kernel/smpboot.c
> +++ b/kernel/smpboot.c
> @@ -4,6 +4,7 @@
>  #include <linux/cpu.h>
>  #include <linux/err.h>
>  #include <linux/smp.h>
> +#include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/list.h>
>  #include <linux/slab.h>
> @@ -312,3 +313,139 @@ void smpboot_unregister_percpu_thread(struct smp_hotplug_thread *plug_thread)
>  	put_online_cpus();
>  }
>  EXPORT_SYMBOL_GPL(smpboot_unregister_percpu_thread);
> +
> +static DEFINE_PER_CPU(atomic_t, cpu_hotplug_state) = ATOMIC_INIT(CPU_POST_DEAD);
> +
> +/*
> + * Called to poll specified CPU's state, for example, when waiting for
> + * a CPU to come online.
> + */
> +int cpu_report_state(int cpu)
> +{
> +	return atomic_read(&per_cpu(cpu_hotplug_state, cpu));
> +}
> +
> +/*
> + * If CPU has died properly, set its state to CPU_UP_PREPARE and
> + * return success.  Otherwise, return -EBUSY if the CPU died after
> + * cpu_wait_death() timed out.  And yet otherwise again, return -EAGAIN
> + * if cpu_wait_death() timed out and the CPU still hasn't gotten around
> + * to dying.  In the latter two cases, the CPU might not be set up
> + * properly, but it is up to the arch-specific code to decide.
> + * Finally, -EIO indicates an unanticipated problem.
> + */
> +int cpu_check_up_prepare(int cpu)
> +{
> +	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
> +		atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_UP_PREPARE);
> +		return 0;
> +	}
> +
> +	switch (atomic_read(&per_cpu(cpu_hotplug_state, cpu))) {
> +
> +	case CPU_POST_DEAD:
> +
> +		/* The CPU died properly, so just start it up again. */
> +		atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_UP_PREPARE);
> +		return 0;
> +
> +	case CPU_DEAD:
> +
> +		/*
> +		 * Timeout during CPU death, so let caller know.
> +		 * The outgoing CPU completed its processing, but after
> +		 * cpu_wait_death() timed out and reported the error. The
> +		 * caller is free to proceed, in which case the state
> +		 * will be reset properly by cpu_set_state_online().
> +		 * Proceeding despite this -EBUSY return makes sense
> +		 * for systems where the outgoing CPUs take themselves
> +		 * offline, with no post-death manipulation required from
> +		 * a surviving CPU.
> +		 */
> +		return -EBUSY;
> +
> +	case CPU_BROKEN:
> +
> +		/*
> +		 * The most likely reason we got here is that there was
> +		 * a timeout during CPU death, and the outgoing CPU never
> +		 * did complete its processing.  This could happen on
> +		 * a virtualized system if the outgoing VCPU gets preempted
> +		 * for more than five seconds, and the user attempts to
> +		 * immediately online that same CPU.  Trying again later
> +		 * might return -EBUSY above, hence -EAGAIN.
> +		 */
> +		return -EAGAIN;
> +
> +	default:
> +
> +		/* Should not happen.  Famous last words. */
> +		return -EIO;
> +	}
> +}
> +
> +/*
> + * Mark the specified CPU online.
> + */
> +void cpu_set_state_online(int cpu)
> +{
> +	(void)atomic_xchg(&per_cpu(cpu_hotplug_state, cpu), CPU_ONLINE);
> +}
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +
> +/*
> + * Wait for the specified CPU to exit the idle loop and die.
> + */
> +bool cpu_wait_death(unsigned int cpu)
> +{
> +	int jf_left = 5 * HZ;
> +	int oldstate;
> +	bool ret = true;
> +	int sleep_jf = 1;
> +
> +	might_sleep();
> +
> +	/* The outgoing CPU will normally get done quite quickly. */
> +	if (atomic_read(&per_cpu(cpu_hotplug_state, cpu)) == CPU_DEAD)
> +		goto update_state;
> +	udelay(5);
> +
> +	/* But if the outgoing CPU dawdles, wait increasingly long times. */
> +	while (atomic_read(&per_cpu(cpu_hotplug_state, cpu)) != CPU_DEAD) {
> +		schedule_timeout_uninterruptible(sleep_jf);
> +		jf_left -= sleep_jf;
> +		if (jf_left <= 0)
> +			break;
> +		sleep_jf = DIV_ROUND_UP(sleep_jf * 11, 10);
> +	}
> +update_state:
> +	oldstate = atomic_read(&per_cpu(cpu_hotplug_state, cpu));
> +	if (oldstate == CPU_DEAD) {
> +		/* Outgoing CPU died normally, update state. */
> +		smp_mb(); /* atomic_read() before update. */
> +		atomic_set(&per_cpu(cpu_hotplug_state, cpu), CPU_POST_DEAD);
> +	} else {
> +		/* Outgoing CPU still hasn't died, set state accordingly. */
> +		if (atomic_cmpxchg(&per_cpu(cpu_hotplug_state, cpu),
> +				   oldstate, CPU_BROKEN) != oldstate)
> +			goto update_state;
> +		ret = false;
> +	}
> +	return ret;
> +}
> +
> +/*
> + * Called by the outgoing CPU to report its successful death.  Return
> + * false if this report follows the surviving CPU's timing out.
> + */
> +bool cpu_report_death(void)
> +{
> +	int oldstate;
> +	int cpu = smp_processor_id();
> +
> +	oldstate = atomic_xchg(&per_cpu(cpu_hotplug_state, cpu), CPU_DEAD);
> +	return oldstate == CPU_ONLINE;
> +}
> +
> +#endif /* #ifdef CONFIG_HOTPLUG_CPU */
