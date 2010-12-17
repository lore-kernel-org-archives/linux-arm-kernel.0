From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Dec 2010 23:14:49 +0000
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
In-Reply-To: <AANLkTimxY0ufwR-nUT_Hx=NkG=9vcuGFrKOBgYpGtvoi@mail.gmail.com>
References: <AANLkTinM524ozYQhHSpCN49LvZLePO6faHJrqxKBtyJe@mail.gmail.com>
	<20101216113407.GO9937@n2100.arm.linux.org.uk>
	<AANLkTikJFdxbXjvWUMmEXoAG4xR8G9jq30ox90Bo4SWe@mail.gmail.com>
	<20101216232849.GY9937@n2100.arm.linux.org.uk>
	<AANLkTimxY0ufwR-nUT_Hx=NkG=9vcuGFrKOBgYpGtvoi@mail.gmail.com>
Message-ID: <20101217231449.GF9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 02:52:29PM -0600, Andrei Warkentin wrote:
> On Thu, Dec 16, 2010 at 5:28 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Thu, Dec 16, 2010 at 05:09:48PM -0600, Andrei Warkentin wrote:
> >> On Thu, Dec 16, 2010 at 5:34 AM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> >
> >> > On Wed, Dec 15, 2010 at 05:45:13PM -0600, Andrei Warkentin wrote:
> >> > > This is my first time on linux-arm-kernel, and while I've read the
> >> > > FAQ, hopefully I don't screw up too badly :).
> >> > >
> >> > > Anyway, we're on a dual-core ARMv7 running 2.6.36, and during
> >> > > stability stress testing saw the following:
> >> > > 1) After a number hotplug iterations, CPU1 fails to set its online bit
> >> > > quickly enough and __cpu_up() times-out.
> >> > > 2) CPU1 eventually completes its startup and sets the bit, however,
> >> > > since _cpu_up() failed, CPU1's active bit is never set.
> >> >
> >> > Why is your CPU taking soo long to come up? ?We wait one second in the
> >> > generic code, which is the time taken from the platform code being happy
> >> > that it has successfully started the CPU. ?Normally, platforms wait an
> >> > additional second to detect the CPU entering the kernel.
> >>
> >> It seems twd_calibrate_rate is the culprit (although in our case,
> >> since the clock is the same to both CPUs, there is no point in
> >> calibrating).
> >
> > twd_calibrate_rate() should only run once at boot. ?Once it's run,
> > taking CPUs offline and back online should not cause the rate to be
> > recalibrated.
> 
> Let's me just see if I understand things correctly for the hotplug case.
> 
> 1) cpu_down calls take_down_cpu
> 2) Idle thread on secondary notices cpu_is_offline, and calls cpu_die()
> 3) cpu_die calls platform_cpu_die, at which point the cpu is dead.

Correct so far.

> If it ever wakes up (because of a cpu_up), it will continue to run in
> cpu_die.

That depends what you have in your cpu_die().  If you return from
cpu_die() then we assume that is because you have been woken up, and
so we re-initialize the CPU.

That's because existing hotplug implementations don't have the necessary
support hardware to reset just one CPU, and the only way to bring a CPU
back online is to jump back to the secondary startup.

> 4) cpu_die jump to secondary_start_kernel.

This is for dumb implementations.  If your code takes the CPU offline via
hardware means, then you must _never_ return from cpu_die(), even if the
hardware fails to take the CPU offline.  I suspect this is where your
problem lies.

> 5) secondary_start_kernel calls percpu_timer_setup
> 6)  percpu_timer_setup calls platform local_timer_setup
> 7) local_timer_setup calls twd_timer_setup_scalable
> 
> ...which calls __twd_timer_setup, which does twd_calibrate_rate among
> other things.

Again, correct, and this is where you claimed that excessive time was
being spent.  Looking at twd_calibrate_rate(), it has this:

        if (twd_timer_rate == 0) {
                printk(KERN_INFO "Calibrating local timer... ");
...
                twd_timer_rate = (0xFFFFFFFFU - count) * (HZ / 5);

                printk("%lu.%02luMHz.\n", twd_timer_rate / 1000000,
                        (twd_timer_rate / 100000) % 100);
        }

which, on the first and _only_ first pass through, initializes
twd_timer_rate.  Because on hotplug cpu-up the timer rate has already
been calibrated, we won't re-run the calibration, and we won't spend
lots of time here.

> #ifdef CONFIG_HOTPLUG_CPU
> static DEFINE_PER_CPU(struct completion, cpu_killed);
> extern void tegra_hotplug_startup(void);
> #endif

You do not need cpu_killed to be a per-cpu thing.  The locking in
cpu_up() and cpu_down() ensures that you can not take more than one
CPU up or down concurrently.  See cpu_maps_update_begin() which
acquires the lock, and cpu_maps_update_done() which drops the lock.

> static DECLARE_BITMAP(cpu_init_bits, CONFIG_NR_CPUS) __read_mostly;
> const struct cpumask *const cpu_init_mask = to_cpumask(cpu_init_bits);
> #define cpu_init_map (*(cpumask_t *)cpu_init_mask)
> 
> #define EVP_CPU_RESET_VECTOR \
> 	(IO_ADDRESS(TEGRA_EXCEPTION_VECTORS_BASE) + 0x100)
> #define CLK_RST_CONTROLLER_CLK_CPU_CMPLX \
> 	(IO_ADDRESS(TEGRA_CLK_RESET_BASE) + 0x4c)
> #define CLK_RST_CONTROLLER_RST_CPU_CMPLX_SET \
> 	(IO_ADDRESS(TEGRA_CLK_RESET_BASE) + 0x340)
> #define CLK_RST_CONTROLLER_RST_CPU_CMPLX_CLR \
> 	(IO_ADDRESS(TEGRA_CLK_RESET_BASE) + 0x344)
> 
> void __cpuinit platform_secondary_init(unsigned int cpu)
> {
> 	trace_hardirqs_off();
> 	gic_cpu_init(0, IO_ADDRESS(TEGRA_ARM_PERIF_BASE) + 0x100);
> 	/*
> 	 * Synchronise with the boot thread.
> 	 */
> 	spin_lock(&boot_lock);
> #ifdef CONFIG_HOTPLUG_CPU
> 	cpu_set(cpu, cpu_init_map);
> 	INIT_COMPLETION(per_cpu(cpu_killed, cpu));

This means you don't need to re-initialize the completion.  Just define
it once using DEFINE_COMPLETION().  Note that this is something that will
be taken care of in core SMP hotplug code during the next merge window.

> #endif
> 	spin_unlock(&boot_lock);
> }
> 
> int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
> {
> 	unsigned long old_boot_vector;
> 	unsigned long boot_vector;
> 	unsigned long timeout;
> 	u32 reg;
> 
> 	/*
> 	 * set synchronisation state between this boot processor
> 	 * and the secondary one
> 	 */
> 	spin_lock(&boot_lock);
> 
> 	/* set the reset vector to point to the secondary_startup routine */
> #ifdef CONFIG_HOTPLUG_CPU
> 	if (cpumask_test_cpu(cpu, cpu_init_mask))
> 		boot_vector = virt_to_phys(tegra_hotplug_startup);
> 	else
> #endif
> 		boot_vector = virt_to_phys(tegra_secondary_startup);

I didn't see the code for these startup functions.

> 
> 	smp_wmb();
> 
> 	old_boot_vector = readl(EVP_CPU_RESET_VECTOR);
> 	writel(boot_vector, EVP_CPU_RESET_VECTOR);
> 
> 	/* enable cpu clock on cpu */
> 	reg = readl(CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
> 	writel(reg & ~(1<<(8+cpu)), CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
> 
> 	reg = 0x1111<<cpu;
> 	writel(reg, CLK_RST_CONTROLLER_RST_CPU_CMPLX_CLR);
> 
> 	/* unhalt the cpu */
> 	writel(0, IO_ADDRESS(TEGRA_FLOW_CTRL_BASE) + 0x14 + 0x8*(cpu-1));
> 
> 	timeout = jiffies + HZ;
> 	while (time_before(jiffies, timeout)) {
> 		if (readl(EVP_CPU_RESET_VECTOR) != boot_vector)

At what point does the hardware change the reset vector?

> 			break;
> 		udelay(10);
> 	}
> 
> 	/* put the old boot vector back */
> 	writel(old_boot_vector, EVP_CPU_RESET_VECTOR);
> 
> 	/*
> 	 * now the secondary core is starting up let it run its
> 	 * calibrations, then wait for it to finish
> 	 */
> 	spin_unlock(&boot_lock);
> 
> 	return 0;
> }
> 
> /*
>  * Initialise the CPU possible map early - this describes the CPUs
>  * which may be present or become present in the system.
>  */
> void __init smp_init_cpus(void)
> {
> 	unsigned int i, ncores = scu_get_core_count(scu_base);
> 
> 	for (i = 0; i < ncores; i++)
> 		cpu_set(i, cpu_possible_map);
> }
> 
> void __init smp_prepare_cpus(unsigned int max_cpus)
> {
> 	unsigned int ncores = scu_get_core_count(scu_base);
> 	unsigned int cpu = smp_processor_id();
> 	int i;
> 
> 	smp_store_cpu_info(cpu);
> 
> 	/*
> 	 * are we trying to boot more cores than exist?
> 	 */
> 	if (max_cpus > ncores)
> 		max_cpus = ncores;
> 
> 	/*
> 	 * Initialise the present map, which describes the set of CPUs
> 	 * actually populated at the present time.
> 	 */
> 	for (i = 0; i < max_cpus; i++)
> 		set_cpu_present(i, true);
> 
> #ifdef CONFIG_HOTPLUG_CPU
> 	for_each_present_cpu(i) {
> 		init_completion(&per_cpu(cpu_killed, i));
> 	}

Again, no need for this with the comments I've made above wrt it.

> #endif
> 
> 	/*
> 	 * Initialise the SCU if there are more than one CPU and let
> 	 * them know where to start. Note that, on modern versions of
> 	 * MILO, the "poke" doesn't actually do anything until each
> 	 * individual core is sent a soft interrupt to get it out of
> 	 * WFI
> 	 */
> 	if (max_cpus > 1) {
> 		percpu_timer_setup();
> 		scu_enable(scu_base);
> 	}
> }
> 
> #ifdef CONFIG_HOTPLUG_CPU
> 
> extern void vfp_sync_state(struct thread_info *thread);
> 
> void __cpuinit secondary_start_kernel(void);
> 
> int platform_cpu_kill(unsigned int cpu)
> {
> 	unsigned int reg;
> 	int e;
> 
> 	e = wait_for_completion_timeout(&per_cpu(cpu_killed, cpu), 100);
> 	printk(KERN_NOTICE "CPU%u: %s shutdown\n", cpu, (e) ? "clean":"forced");

So, this timeout '100' - how long exactly is that?  It's dependent on
the jiffy tick interval rather than being defined in ms.  (Oops, that's
something which should also be fixed in version in the generic code.)

> 
> 	if (e) {
> 		do {
> 			reg = readl(CLK_RST_CONTROLLER_RST_CPU_CMPLX_SET);
> 			cpu_relax();
> 		} while (!(reg & (1<<cpu)));
> 	} else {
> 		writel(0x1111<<cpu, CLK_RST_CONTROLLER_RST_CPU_CMPLX_SET);
> 		/* put flow controller in WAIT_EVENT mode */
> 		writel(2<<29, IO_ADDRESS(TEGRA_FLOW_CTRL_BASE)+0x14 + 0x8*(cpu-1));
> 	}
> 	spin_lock(&boot_lock);
> 	reg = readl(CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
> 	writel(reg | (1<<(8+cpu)), CLK_RST_CONTROLLER_CLK_CPU_CMPLX);
> 	spin_unlock(&boot_lock);
> 	return e;
> }
> 
> void platform_cpu_die(unsigned int cpu)
> {
> #ifdef DEBUG
> 	unsigned int this_cpu = hard_smp_processor_id();
> 
> 	if (cpu != this_cpu) {
> 		printk(KERN_CRIT "Eek! platform_cpu_die running on %u, should be %u\n",
> 			   this_cpu, cpu);
> 		BUG();
> 	}
> #endif
> 
> 	gic_cpu_exit(0);
> 	barrier();
> 	complete(&per_cpu(cpu_killed, cpu));
> 	flush_cache_all();
> 	barrier();
> 	__cortex_a9_save(0);
> 
> 	/* return happens from __cortex_a9_restore */
> 	barrier();
> 	writel(smp_processor_id(), EVP_CPU_RESET_VECTOR);

And here, if the CPU is not _immediately_ stopped, it will return and
restart the bring-up.  If you are using hardware to reset the CPU (which
it seems you are), you should ensure that this function never returns.
You may also wish to add a pr_crit() here to indicate when this failure
happens.

> }
> 
> int platform_cpu_disable(unsigned int cpu)
> {
> 	/*
> 	 * we don't allow CPU 0 to be shutdown (it is still too special
> 	 * e.g. clock tick interrupts)
> 	 */
> 	if (unlikely(!tegra_context_area))
> 		return -ENXIO;
> 
> 	return cpu == 0 ? -EPERM : 0;
> }
> #endif
