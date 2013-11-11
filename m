From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 11 Nov 2013 20:01:52 +0000
Subject: [PATCH v3 3/4] ARM: EXYNOS: add Exynos Dual Cluster Support
In-Reply-To: <alpine.LFD.2.10.1311111107040.9667@knanqh.ubzr>
References: <20131108184036.GD2602@localhost.localdomain>
 <alpine.LFD.2.03.1311081356300.15571@syhkavp.arg>
 <52808E09.9060902@samsung.com> <5280FB9A.7030500@samsung.com>
 <alpine.LFD.2.10.1311111107040.9667@knanqh.ubzr>
Message-ID: <20131111200152.GF3166@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 11, 2013 at 11:27:46AM -0500, Nicolas Pitre wrote:
> On Mon, 11 Nov 2013, Tarek Dakhran wrote:
> 
> > Hi,
> > 
> > On 11.11.2013 11:58, Tarek Dakhran wrote:
> > > 
> > > > On Thu, Nov 07, 2013 at 11:51:49AM -0500, Nicolas Pitre wrote:
> > > > Samsung people: could you give us more info on the behavior of the power
> > > > controller please?
> > > > 
> > > > 
> > > > Nicolas
> > > > 
> > > This is how the power controller works on exynos5410. For example for CORE0.
> > > 
> > > ARM_CORE0_STATUS register indicates the power state of Core 0 part of
> > > processor core.
> > > 0x3 indicates that power to Core 0 is turned-on. 0x0 indicates that power to
> > > Core 0 is turned-off.
> > > All other values indicate that the power On/Off sequence of Core 0 in
> > > progress.
> > > 
> > > To turn Off the power of Core 0 power domain:
> > > 
> > > 1. Set the LOCAL_POWER_CFG field of ARM_CORE0_CONFIGURATION register to 0x3.
> > > 2. After PMU detects a change in the LOCAL_POWER_CFG field, it waits for the
> > > execution of WFI.
> > > 3. After Core 0 executes the WFI instruction, PMU starts the power-down
> > > sequence.
> > > 4. The Status field of ARM_CORE0_STATUS register indicates the completion of
> > > the sequence.
> > > 
> > > That's why in the v1 of this patch exynos_core_power_control function was
> > > implemented as:
> > > 
> > > static int exynos_core_power_control(unsigned int cpu, unsigned int cluster,
> > > int enable)
> > > {
> > >        unsigned long timeout = jiffies + msecs_to_jiffies(10);
> > >        unsigned int offset = cluster * MAX_CPUS_PER_CLUSTER + cpu;
> > >        int value = enable ? S5P_CORE_LOCAL_PWR_EN : 0;
> > > 
> > >        if ((__raw_readl(EXYNOS5410_CORE_STATUS(offset)) & 0x3) == value)
> > >                return 0;
> > > 
> > >        __raw_writel(value, EXYNOS5410_CORE_CONFIGURATION(offset));
> > >        do {
> > >                if ((__raw_readl(EXYNOS5410_CORE_STATUS(offset)) & 0x3)
> > >                                == value)
> > >                        return 0;
> > >        } while (time_before(jiffies, timeout));
> > > 
> > >        return -EDEADLK;
> > > }
> > > 
> > > But, as i mentioned, this is no good using while here.
> > > Now thinking about the problem.
> > > 
> > > Thank you,
> > >         Tarek Dakhran
> > 
> > What do you think about this way of solving the problem with races?
> > 
> > Add new edcs_power_controller_wait function.
> > 
> > static void edcs_power_controller_wait(unsigned int cpu, unsigned int
> > cluster){
> > 
> >         unsigned long timeout = jiffies + msecs_to_jiffies(10);
> >         unsigned int offset = cluster * EDCS_CPUS_PER_CLUSTER + cpu;
> >         void __iomem *status_reg = EDCS_CORE_STATUS(offset);
> > 
> >         /* wait till core power controller finish the work */
> > 
> >         do {
> >                 if ((readl_relaxed(status_reg) & 3) ==
> > edcs_use_count[cpu][cluster] ? 3 : 0)

While we're making these changes, it would be good to take to opportunity
to add a #define for these bits too.

The magic numbers here meant that I had to do some guesswork to
understand the real behaviour here, and someone reading the code in the
future is likely to have the same problem...

> >                         return;
> >         } while (time_before(jiffies, timeout));
> > 
> >         /* Should never get here */
> >         BUG();
> > }
> > 
> > Use it in:
> > 
> > static void exynos_core_power_up(unsigned int cpu, unsigned int cluster)
> > {
> >         exynos_core_power_control(cpu, cluster, true);
> >         edcs_power_controller_wait(cpu, cluster);
> > }
> > 
> > and in:
> > 
> > static void exynos_power_down(void)
> > {
> >         bool last_man = false, skip_wfi = false;
> >         unsigned int mpidr = read_cpuid_mpidr();
> >         unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> >         unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> > 
> > 
> >         pr_debug("%s: CORE%d on CLUSTER %d\n", __func__, cpu, cluster);
> >         BUG_ON(cpu >= EDCS_CPUS_PER_CLUSTER  || cluster >= EDCS_CLUSTERS);
> > 
> >         __mcpm_cpu_going_down(cpu, cluster);
> > 
> >         arch_spin_lock(&edcs_lock);
> >         BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
> >         edcs_use_count[cpu][cluster]--;
> >         if (edcs_use_count[cpu][cluster] == 0) {
> >                 exynos_core_power_down(cpu, cluster);
> >                 --core_count[cluster];
> >                 if (core_count[cluster] == 0)
> >                         last_man = true;
> > [snip]
> >         __mcpm_cpu_down(cpu, cluster);
> > 
> >         if (!skip_wfi){
> >                 wfi();
> >         }
> >         edcs_power_controller_wait(cpu, cluster);
> > }
> 
> It is preferable if the power_up and power_down don't wait.

I agree with this.

If a wait is needed anywhere, it is

 a) in power_down_finish(), and
 b) *before* the call to exynos_core_power_control() in
        exynos_core_power_up() (see below for explanation)

Any waits should not be busy-waits either: we should use msleep or
similar.  This is fine that we only wait from contexts that can sleep --
I think this is OK for the power_up() and power_down_finish() paths
(which aren't executed on the target CPU), but not on the power_down()
path.

Busy-waiting for 1ms every time we power a CPU down is not great for
power-saving...

In both cases, we should check the PMU status bits first, and only
wait if they are not already in the desired state.  The most likely
case will always by that the target CPU already caught up.


Nico currently disagrees with me on (b), so we need to explore that
(below).

> No need to wait for a power_up to be complete as the only CPU that can 
> do a power_down is the CPU being powered up itself.

To extend this argument further, there is no conceiveable situation
where we would need to wait for power_up to complete explicitly.

We will only ever need to wait for power_down to complete.

> 
> The exynos_core_power_down call is now appropriately located i.e. within 
> the lock protected area.  That's fine because we know power won't be cut 
> until the lock is released and WFI is executed.
> 
> Also, if exynos_core_power_up() is called from another CPU right after 
> the lock is released on the CPU trying to shut itself down but before it 
> actually executes WFI then the WFI will not be effective and the 
> power_down method is expected to return in that case.  So no problem 
> there either.
> 
> The only case where it is important to really wait for the power down to 
> be effective is for kexec.  This is why Dave introduced the 
> power_down_finish method (you may find this in linux-next at the 
> moment).  That would be the place where to use your controller_wait 
> code.

For (b), I think we're still missing some information here...

Suppose CPU0 is powering down.  The PMU has been told to power the CPU
down, and CPU0 has released edcs_lock.  Suppose soon afterwards, CPU1
wants to turn CPU0 back on again.

Now, unless CPU1 checks the power controller status, CPU1 has no way
to know whether the power-down request is still in progress before CPU1
issues a new power-up request for CPU0.

Now, what behaviour does the power controller guarantee when it is still
in this state, and a new power-up request is issued to it?

I worry that the power controller may not cope with a new request while
in this state, or may not guarantee predictable behaviour.  If so then
the new power-up request may just get lost -- avoiding that problem
requires power_up() to wait for a pending power_down() to finish before
issuing a new command to the power controller.

Only the hardware documentation can answer this question.

Cheers
---Dave
