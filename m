From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 25 Oct 2016 11:34:36 -0700
Subject: [PATCH v3] drivers: psci: PSCI checker module
In-Reply-To: <20161025154535.GA3107@red-moon>
References: <20161020145115.6326-1-kevin.brodsky@arm.com>
 <20161025154535.GA3107@red-moon>
Message-ID: <20161025183436.GF3716@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 04:45:35PM +0100, Lorenzo Pieralisi wrote:
> [ +Paul, James ]
> 
> Left most of the patch content in place so that they can follow it even
> if they weren't CC'ed.
> 
> On Thu, Oct 20, 2016 at 03:51:15PM +0100, Kevin Brodsky wrote:
> > On arm and arm64, PSCI is one of the possible firmware interfaces
> > used for power management. This includes both turning CPUs on and off,
> > and suspending them (entering idle states).
> > 
> > This patch adds a PSCI checker module that enables basic testing of
> > PSCI operations during startup. There are two main tests: CPU
> > hotplugging and suspending.
> > 
> > In the hotplug tests, the hotplug API is used to turn off and on again
> > all CPUs in the system, and then all CPUs in each cluster, checking
> > the consistency of the return codes.
> > 
> > In the suspend tests, a high-priority thread is created on each core
> > and uses low-level cpuidle functionalities to enter suspend, in all
> > the possible states and multiple times. This should allow a maximum
> > number of CPUs to enter the same sleep state at the same or slightly
> > different time.
> > 
> > In essence, the suspend tests use a principle similar to that of the
> > intel_powerclamp driver (drivers/thermal/intel_powerclamp.c), but the
> > threads are only kept for the duration of the test (they are already
> > gone when userspace is started).
> > 
> > While in theory power management PSCI functions (CPU_{ON,OFF,SUSPEND})
> > could be directly called, this proved too difficult as it would imply
> > the duplication of all the logic used by the kernel to allow for a
> > clean shutdown/bringup/suspend of the CPU (the deepest sleep states
> > implying potentially the shutdown of the CPU).
> > 
> > Note that this file cannot be compiled as a loadable module, since it
> > uses a number of non-exported identifiers (essentially for
> > PSCI-specific checks and direct use of cpuidle) and relies on the
> > absence of userspace to avoid races when calling hotplug and cpuidle
> > functions.
> > 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> > ---
> 
> [...]
> 
> > +static int find_clusters(const struct cpumask *cpus,
> > +			 const struct cpumask **clusters)
> > +{
> > +	unsigned int nb = 0;
> > +	cpumask_var_t tmp;
> > +
> > +	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
> > +		return -ENOMEM;
> > +	cpumask_copy(tmp, cpus);
> > +
> > +	while (!cpumask_empty(tmp)) {
> > +		const struct cpumask *cluster =
> > +			topology_core_cpumask(cpumask_any(tmp));
> > +
> > +		clusters[nb++] = cluster;
> > +		cpumask_andnot(tmp, tmp, cluster);
> > +	}
> > +
> > +	free_cpumask_var(tmp);
> > +	return nb;
> > +}
> > +
> > +/*
> > + * offlined_cpus is a temporary array but passing it as an argument avoids
> > + * multiple allocations.
> > + */
> > +static unsigned int down_and_up_cpus(const struct cpumask *cpus,
> > +				     struct cpumask *offlined_cpus)
> > +{
> > +	int cpu;
> > +	int err = 0;
> > +
> > +	cpumask_clear(offlined_cpus);
> > +
> > +	/* Try to power down all CPUs in the mask. */
> > +	for_each_cpu(cpu, cpus) {
> > +		int ret = cpu_down(cpu);
> > +
> > +		/*
> > +		 * cpu_down() checks the number of online CPUs before the TOS
> > +		 * resident CPU.
> > +		 */
> > +		if (cpumask_weight(offlined_cpus) + 1 == nb_available_cpus) {
> > +			if (ret != -EBUSY) {
> > +				pr_err("Unexpected return code %d while trying "
> > +				       "to power down last online CPU %d\n",
> > +				       ret, cpu);
> > +				++err;
> > +			}
> > +		} else if (cpu == tos_resident_cpu) {
> > +			if (ret != -EPERM) {
> > +				pr_err("Unexpected return code %d while trying "
> > +				       "to power down TOS resident CPU %d\n",
> > +				       ret, cpu);
> > +				++err;
> > +			}
> > +		} else if (ret != 0) {
> > +			pr_err("Error occurred (%d) while trying "
> > +			       "to power down CPU %d\n", ret, cpu);
> > +			++err;
> > +		}
> > +
> > +		if (ret == 0)
> > +			cpumask_set_cpu(cpu, offlined_cpus);
> > +	}
> > +
> > +	/* Try to power up all the CPUs that have been offlined. */
> > +	for_each_cpu(cpu, offlined_cpus) {
> > +		int ret = cpu_up(cpu);
> > +
> > +		if (ret != 0) {
> > +			pr_err("Error occurred (%d) while trying "
> > +			       "to power up CPU %d\n", ret, cpu);
> > +			++err;
> > +		} else {
> > +			cpumask_clear_cpu(cpu, offlined_cpus);
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * Something went bad at some point and some CPUs could not be turned
> > +	 * back on.
> > +	 */
> > +	WARN_ON(!cpumask_empty(offlined_cpus) ||
> > +		num_online_cpus() != nb_available_cpus);
> > +
> > +	return err;
> > +}
> > +
> > +static int hotplug_tests(void)
> > +{
> > +	int err;
> > +	cpumask_var_t offlined_cpus;
> > +	int i, nb_cluster;
> > +	const struct cpumask **clusters;
> > +	char *page_buf;
> > +
> > +	err = -ENOMEM;
> > +	if (!alloc_cpumask_var(&offlined_cpus, GFP_KERNEL))
> > +		return err;
> > +	/* We may have up to nb_available_cpus clusters. */
> > +	clusters = kmalloc_array(nb_available_cpus, sizeof(*clusters),
> > +				 GFP_KERNEL);
> > +	if (!clusters)
> > +		goto out_free_cpus;
> > +	page_buf = (char *)__get_free_page(GFP_KERNEL);
> > +	if (!page_buf)
> > +		goto out_free_clusters;
> > +
> > +	err = 0;
> > +	nb_cluster = find_clusters(cpu_online_mask, clusters);
> > +
> > +	/*
> > +	 * Of course the last CPU cannot be powered down and cpu_down() should
> > +	 * refuse doing that.
> > +	 */
> > +	pr_info("Trying to turn off and on again all CPUs\n");
> > +	err += down_and_up_cpus(cpu_online_mask, offlined_cpus);
> > +
> > +	/*
> > +	 * Take down CPUs by cluster this time. When the last CPU is turned
> > +	 * off, the cluster itself should shut down.
> > +	 */
> > +	for (i = 0; i < nb_cluster; ++i) {
> > +		int cluster_id =
> > +			topology_physical_package_id(cpumask_any(clusters[i]));
> > +		ssize_t len = cpumap_print_to_pagebuf(true, page_buf,
> > +						      clusters[i]);
> > +		/* Remove trailing newline. */
> > +		page_buf[len - 1] = '\0';
> > +		pr_info("Trying to turn off and on again cluster %d "
> > +			"(CPUs %s)\n", cluster_id, page_buf);
> > +		err += down_and_up_cpus(clusters[i], offlined_cpus);
> > +	}
> > +
> > +	free_page((unsigned long)page_buf);
> > +out_free_clusters:
> > +	kfree(clusters);
> > +out_free_cpus:
> > +	free_cpumask_var(offlined_cpus);
> > +	return err;
> > +}
> > +
> > +static void dummy_callback(unsigned long ignored) {}
> > +
> > +static int suspend_cpu(int index, bool broadcast)
> > +{
> > +	int ret;
> > +
> > +	arch_cpu_idle_enter();
> > +
> > +	if (broadcast) {
> > +		/*
> > +		 * The local timer will be shut down, we need to enter tick
> > +		 * broadcast.
> > +		 */
> > +		ret = tick_broadcast_enter();
> > +		if (ret) {
> > +			/*
> > +			 * In the absence of hardware broadcast mechanism,
> > +			 * this CPU might be used to broadcast wakeups, which
> > +			 * may be why entering tick broadcast has failed.
> > +			 * There is little the kernel can do to work around
> > +			 * that, so enter WFI instead (idle state 0).
> > +			 */
> > +			cpu_do_idle();
> > +			ret = 0;
> > +			goto out_arch_exit;
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * Replicate the common ARM cpuidle enter function
> > +	 * (arm_enter_idle_state).
> > +	 */
> > +	ret = CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, index);
> > +
> > +	if (broadcast)
> > +		tick_broadcast_exit();
> > +
> > +out_arch_exit:
> > +	arch_cpu_idle_exit();
> > +
> > +	return ret;
> > +}
> > +
> > +static int suspend_test_thread(void *arg)
> > +{
> > +	int cpu = (long)arg;
> > +	int i, nb_suspend = 0, nb_shallow_sleep = 0, nb_err = 0;
> > +	struct sched_param sched_priority = { .sched_priority = MAX_RT_PRIO-1 };
> > +	struct cpuidle_device *dev;
> > +	struct cpuidle_driver *drv;
> > +	/* No need for an actual callback, we just want to wake up the CPU. */
> > +	struct timer_list wakeup_timer =
> > +		TIMER_INITIALIZER(dummy_callback, 0, 0);
> > +
> > +	/* Wait for the main thread to give the start signal. */
> > +	wait_for_completion(&suspend_threads_started);
> > +
> > +	/* Set maximum priority to preempt all other threads on this CPU. */
> > +	if (sched_setscheduler_nocheck(current, SCHED_FIFO, &sched_priority))
> > +		pr_warn("Failed to set suspend thread scheduler on CPU %d\n",
> > +			cpu);
> > +
> > +	dev = this_cpu_read(cpuidle_devices);
> > +	drv = cpuidle_get_cpu_driver(dev);
> > +
> > +	pr_info("CPU %d entering suspend cycles, states 1 through %d\n",
> > +		cpu, drv->state_count - 1);
> > +
> > +	for (i = 0; i < NUM_SUSPEND_CYCLE; ++i) {
> > +		int index;
> > +		/*
> > +		 * Test all possible states, except 0 (which is usually WFI and
> > +		 * doesn't use PSCI).
> > +		 */
> > +		for (index = 1; index < drv->state_count; ++index) {
> > +			struct cpuidle_state *state = &drv->states[index];
> > +			bool broadcast = state->flags & CPUIDLE_FLAG_TIMER_STOP;
> > +			int ret;
> > +
> > +			/*
> > +			 * Set the timer to wake this CPU up in some time (which
> > +			 * should be largely sufficient for entering suspend).
> > +			 * If the local tick is disabled when entering suspend,
> > +			 * suspend_cpu() takes care of switching to a broadcast
> > +			 * tick, so the timer will still wake us up.
> > +			 */
> > +			mod_timer(&wakeup_timer, jiffies +
> > +				  usecs_to_jiffies(state->target_residency));
> > +
> > +			/* IRQs must be disabled during suspend operations. */
> > +			local_irq_disable();
> > +
> > +			ret = suspend_cpu(index, broadcast);
> > +
> > +			/*
> > +			 * We have woken up. Re-enable IRQs to handle any
> > +			 * pending interrupt, do not wait until the end of the
> > +			 * loop.
> > +			 */
> > +			local_irq_enable();
> > +
> > +			if (ret == index) {
> > +				++nb_suspend;
> > +			} else if (ret >= 0) {
> > +				/* We did not enter the expected state. */
> > +				++nb_shallow_sleep;
> > +			} else {
> > +				pr_err("Failed to suspend CPU %d: error %d "
> > +				       "(requested state %d, cycle %d)\n",
> > +				       cpu, ret, index, i);
> > +				++nb_err;
> > +			}
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * Disable the timer to make sure that the timer will not trigger
> > +	 * later.
> > +	 */
> > +	del_timer(&wakeup_timer);
> > +
> > +	if (atomic_dec_return_relaxed(&nb_active_threads) == 0)
> > +		complete(&suspend_threads_done);
> > +
> > +	/* Give up on RT scheduling and wait for termination. */
> > +	sched_priority.sched_priority = 0;
> > +	if (sched_setscheduler_nocheck(current, SCHED_NORMAL, &sched_priority))
> > +		pr_warn("Failed to set suspend thread scheduler on CPU %d\n",
> > +			cpu);
> > +	for (;;) {
> > +		/* Needs to be set first to avoid missing a wakeup. */
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		if (kthread_should_stop()) {
> > +			__set_current_state(TASK_RUNNING);
> > +			break;
> > +		}
> > +		schedule();
> > +	}
> > +
> > +	pr_info("CPU %d suspend test results: success %d, shallow states %d, errors %d\n",
> > +		cpu, nb_suspend, nb_shallow_sleep, nb_err);
> > +
> > +	return nb_err;
> > +}
> > +
> > +static int suspend_tests(void)
> > +{
> > +	int i, cpu, err = 0;
> > +	struct task_struct **threads;
> > +	int nb_threads = 0;
> > +
> > +	threads = kmalloc_array(nb_available_cpus, sizeof(*threads),
> > +				GFP_KERNEL);
> > +	if (!threads)
> > +		return -ENOMEM;
> > +
> > +	for_each_online_cpu(cpu) {
> > +		struct task_struct *thread;
> > +		/* Check that cpuidle is available on that CPU. */
> > +		struct cpuidle_device *dev = per_cpu(cpuidle_devices, cpu);
> > +		struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> > +
> > +		if (cpuidle_not_available(drv, dev)) {
> > +			pr_warn("cpuidle not available on CPU %d, ignoring\n",
> > +				cpu);
> > +			continue;
> > +		}
> > +
> > +		thread = kthread_create_on_cpu(suspend_test_thread,
> > +					       (void *)(long)cpu, cpu,
> > +					       "psci_suspend_test");
> > +		if (IS_ERR(thread))
> > +			pr_err("Failed to create kthread on CPU %d\n", cpu);
> > +		else
> > +			threads[nb_threads++] = thread;
> > +	}
> > +	if (nb_threads < 1) {
> > +		kfree(threads);
> > +		return -ENODEV;
> > +	}
> > +
> > +	atomic_set(&nb_active_threads, nb_threads);
> > +
> > +	/*
> > +	 * Stop cpuidle to prevent the idle tasks from entering a deep sleep
> > +	 * mode, as it might interfere with the suspend threads on other CPUs.
> > +	 * This does not prevent the suspend threads from using cpuidle (only
> > +	 * the idle tasks check this status).
> > +	 */
> > +	cpuidle_pause();
> > +
> > +	/*
> > +	 * Wake up the suspend threads. To avoid the main thread being preempted
> > +	 * before all the threads have been unparked, the suspend threads will
> > +	 * wait for the completion of suspend_threads_started.
> > +	 */
> > +	for (i = 0; i < nb_threads; ++i)
> > +		wake_up_process(threads[i]);
> > +	complete_all(&suspend_threads_started);
> > +
> > +	wait_for_completion(&suspend_threads_done);
> > +
> > +	cpuidle_resume();
> > +
> > +	/* Stop and destroy all threads, get return status. */
> > +	for (i = 0; i < nb_threads; ++i)
> > +		err += kthread_stop(threads[i]);
> > +
> > +	kfree(threads);
> > +	return err;
> > +}
> > +
> > +static int __init psci_checker(void)
> > +{
> > +	int ret;
> > +
> > +	/*
> > +	 * Since we're in an initcall, we assume that all the CPUs that all
> > +	 * CPUs that can be onlined have been onlined.
> > +	 *
> > +	 * The tests assume that hotplug is enabled but nobody else is using it,
> > +	 * otherwise the results will be unpredictable. However, since there
> > +	 * is no userspace yet in initcalls, that should be fine.
> 
> I do not think it is. If you run a kernel with, say,
> CONFIG_LOCK_TORTURE_TEST, cpus may disappear from the radar while
> running the PSCI checker test itself; that at least would confuse the
> checker, and that's just an example.
> 
> I added Paul to check what are the assumptions behind the torture test
> hotplug tests, in particular if there are any implicit assumptions for
> it to work (ie it is the only kernel test hotplugging cpus in and out
> (?)), what I know is that the PSCI checker assumptions are not correct.

Both CONFIG_LOCK_TORTURE_TEST and CONFIG_RCU_TORTURE_TEST can and will
hotplug CPUs.  The locktorture.onoff_holdoff and rcutorture.onoff_holdoff
kernel parameters can delay the start of CPU-hotplug testing, and in
my testing I set this delay to 30 seconds after boot.

One approach would be to make your test refuse to run if either of
the lock/RCU torture tests was running.  Or do what Lorenzo suggests
below.  The torture tests aren't crazy enough to offline the last CPU.
Though they do try, just for effect, in cases where the last CPU is
marked cpu_is_hotpluggable().  ;-)

						Thanx, Paul

> There is something simple you can do to get this "fixed".
> 
> You can use the new API James implemented for hibernate,
> that allows you to disable (ie PSCI CPU OFF) all "secondary" cpus
> other than the primary one passed in as parameter:
> 
> freeze_secondary_cpus(int primary);
> 
> that function will _cpu_down() all online cpus other than "primary"
> in one go, without any interference allowed from other bits of the
> kernel. It requires an enable_nonboot_cpus() counterpart, and you
> can do that for every online cpus you detect (actually you can even
> avoid using the online cpu mask and use the present mask to carry
> out the test). If there is a resident trusted OS you can just
> trigger the test with primary == tos_resident_cpu, since all
> others are bound to fail (well, you can run them and check they
> do fail, it is a checker after all).
> 
> You would lose the capability of hotplugging a "cluster" at a time, but
> I do not think it is a big problem, the test above would cover it
> and more importantly, it is safe to execute.
> 
> Or we can augment the torture test API to restrict the cpumask
> it actually uses to offline/online cpus (I am referring to
> torture_onoff(), kernel/torture.c).
> 
> Further comments appreciated since I am not sure I grokked the
> assumption the torture tests make about hotplugging cpus in and out,
> I will go through the commits logs again to find more info.
> 
> Thanks !
> Lorenzo
> 
> > +	 */
> > +	nb_available_cpus = num_online_cpus();
> > +
> > +	/* Check PSCI operations are set up and working. */
> > +	ret = psci_ops_check();
> > +	if (ret)
> > +		return ret;
> > +
> > +	pr_info("PSCI checker started using %u CPUs\n", nb_available_cpus);
> > +
> > +	pr_info("Starting hotplug tests\n");
> > +	ret = hotplug_tests();
> > +	if (ret == 0)
> > +		pr_info("Hotplug tests passed OK\n");
> > +	else if (ret > 0)
> > +		pr_err("%d error(s) encountered in hotplug tests\n", ret);
> > +	else {
> > +		pr_err("Out of memory\n");
> > +		return ret;
> > +	}
> > +
> > +	pr_info("Starting suspend tests (%d cycles per state)\n",
> > +		NUM_SUSPEND_CYCLE);
> > +	ret = suspend_tests();
> > +	if (ret == 0)
> > +		pr_info("Suspend tests passed OK\n");
> > +	else if (ret > 0)
> > +		pr_err("%d error(s) encountered in suspend tests\n", ret);
> > +	else {
> > +		switch (ret) {
> > +		case -ENOMEM:
> > +			pr_err("Out of memory\n");
> > +			break;
> > +		case -ENODEV:
> > +			pr_warn("Could not start suspend tests on any CPU\n");
> > +			break;
> > +		}
> > +	}
> > +
> > +	pr_info("PSCI checker completed\n");
> > +	return ret < 0 ? ret : 0;
> > +}
> > +late_initcall(psci_checker);
> > -- 
> > 2.10.0
> > 
> 
