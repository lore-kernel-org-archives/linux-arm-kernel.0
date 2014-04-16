From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Thu, 17 Apr 2014 00:41:22 +0530
Subject: [PATCH 5/5] arm: exynos: Add MCPM call-back functions
In-Reply-To: <20140414104116.GA3844@e103592.cambridge.arm.com>
References: <1397239311-27717-1-git-send-email-a.kesavan@samsung.com>
 <1397239311-27717-6-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1404111426510.980@knanqh.ubzr>
 <20140414104116.GA3844@e103592.cambridge.arm.com>
Message-ID: <CAM4voa=-29EsNRCebri1C9D5cWopTT4Ux_0UPGAvdjP60ADZZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave.
On Mon, Apr 14, 2014 at 4:11 PM, Dave Martin <Dave.Martin@arm.com> wrote:
> On Fri, Apr 11, 2014 at 04:23:04PM -0400, Nicolas Pitre wrote:
>> On Fri, 11 Apr 2014, Abhilash Kesavan wrote:
>>
>> > Add machine-dependent MCPM call-backs for Exynos5420. These are used
>> > to power up/down the secondary CPUs during boot, shutdown, s2r and
>> > switching.
>> >
>> > Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> > Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
>> > Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>
>> See comments inline.
>
> I won't duplicate Nico's review, but I have a couple of extra comments/
> questions, below.
>
> [...]
>
>> > diff --git a/arch/arm/mach-exynos/mcpm-exynos.c b/arch/arm/mach-exynos/mcpm-exynos.c
>> > new file mode 100644
>> > index 0000000..46d4968
>> > --- /dev/null
>> > +++ b/arch/arm/mach-exynos/mcpm-exynos.c
>> > @@ -0,0 +1,444 @@
>
> [...]
>
>> > +static void exynos_cluster_power_control(unsigned int cluster, int enable)
>> > +{
>> > +   unsigned long timeout = jiffies + msecs_to_jiffies(20);
>> > +   unsigned int status, val = EXYNOS_CORE_LOCAL_PWR_DIS;
>> > +
>> > +   if (enable)
>> > +           val = EXYNOS_CORE_LOCAL_PWR_EN;
>> > +
>> > +   status = __raw_readl(EXYNOS_COMMON_STATUS(cluster));
>> > +   if ((status & EXYNOS_CORE_LOCAL_PWR_EN) == val)
>> > +           return;
>> > +
>> > +   __raw_writel(val, EXYNOS_COMMON_CONFIGURATION(cluster));
>> > +   /* Wait until cluster power control is applied */
>> > +   while (time_before(jiffies, timeout)) {
>> > +           status = __raw_readl(EXYNOS_COMMON_STATUS(cluster));
>> > +
>> > +           if ((status & EXYNOS_CORE_LOCAL_PWR_EN) == val)
>> > +                   return;
>> > +
>> > +           cpu_relax();
>> > +   }
>> > +   pr_warn("timed out waiting for cluster %u to power %s\n", cluster,
>> > +           enable ? "on" : "off");
>>
>> You should not have to wait for the power status to change here.
>> Simply signaling the desired state and returning is all that is
>> expected.  And because IRQs are turned off, it is likely that
>> time_before(jiffies, timeout) will always be true anyway because jiffies
>> are not updated if there is no other CPU to service the timer interrupt.
>>
>> The actual power status should be polled for in the mcpm_finish()
>> method only.
>
> Depending on the power controller, it might be possible for writes to
> the controller to be lost or not acted upon, if a previous change is
> still pending.
>
> Does this issue apply to the exynos power controller?
>
> If this is the case, it might be necessary to ensure before a power-up
> request, that the power controller has caught up and reports the
> cluster/CPU as down.  Putting this poll before the write to the
> power controller maximises the chance of pipelining useful work
> in the meantime.  Putting the poll after the write is the worst case.
>
>>
>> > +}
>> > +
>> > +static int exynos_power_up(unsigned int cpu, unsigned int cluster)
>> > +{
>> > +   unsigned long mpidr;
>> > +
>> > +   pr_debug("%s: cpu %u cluster %u\n", __func__, cpu, cluster);
>> > +   if (cpu >= EXYNOS5420_CPUS_PER_CLUSTER ||
>> > +           cluster >= EXYNOS5420_NR_CLUSTERS)
>> > +           return -EINVAL;
>> > +
>> > +   /*
>> > +    * Since this is called with IRQs enabled, and no arch_spin_lock_irq
>> > +    * variant exists, we need to disable IRQs manually here.
>> > +    */
>> > +   local_irq_disable();
>> > +   arch_spin_lock(&bl_lock);
>> > +
>> > +   cpu_use_count[cpu][cluster]++;
>> > +   if (cpu_use_count[cpu][cluster] == 1) {
>> > +           bool was_cluster_down =
>> > +                   __mcpm_cluster_state(cluster) == CLUSTER_DOWN;
>> > +
>> > +           if (was_cluster_down)
>> > +                   exynos_cluster_power_control(cluster, 1);
>> > +           exynos_core_power_control(cpu, cluster, 1);
>> > +
>> > +           if (was_cluster_down) {
>> > +                   mpidr = read_cpuid_mpidr();
>> > +                   udelay(10);
>> > +                   cci_control_port_by_cpu(mpidr, true);
>> > +           }
>>
>> This is completely wrong.  Is this why you created the patch to
>> introduce cci_control_port_by_cpu()?  If so I'm NAKing that other patch
>> as well.
>>
>> This is going to be completely ineffective with concurrent usage by
>> cpuidle where CPUs in the other cluster are awaken by an interrupt and
>> not by calling the cpu_up method.  The current cluster will therefore
>> not be aware of the other cluster coming online and system memory
>> corruption will occur.
>>
>> I see below that you do turn off the CCI port for the current cluster
>> and the other cluster together, hence the need to enable back the CCI
>> for the current cluster here.  Please don't do that.  That's not the
>> proper way to achieve that and there are many race conditions to take
>> care of before this can be done.  And if we were to go that route, I
>> want to be convinced it is worth the needed complexity first i.e. I want
>> to see evidence this actually does save power or improve performance by
>> a non negligible margin.
>
> Agreed.
>
> The fact that there is no C interface for enabling ACE ports is
> deliberate.  For CPUs connected to ACE and managed via MCPM,
> it is incorrect to enable CCI via C code, since the safe window
> is the window during which all outbound CPUs have reached CLUSTER_DOWN
> and all inbound CPUs have not turned their MMU on yet (and thus cannot
> execute any general Linux C code).
>
> There might be scenarios involving GPUs and other non-CPU devices
> connected to ACE ports where the device cannot enable CCI snoops
> for itself -- but this would require a holding-pen protocol to enable
> the device to wait and signal a CPU to enable CCI snoops on the device's
> behalf before the device proceeds.  It is not the correct solution for
> CPU clusters attached to ACE, precisely because we can be more efficient
> in that case.
>
> In fact, because you implement a power_up_setup method that calls
> cci_enable_port_for_self, CCI snoops are actually enabled twice, making
> the above code appear redundant.   Have I missed something?
When a cluster is being turned off the snoops for both the clusters
are being turned off. When the other cluster comes back the snoops are
being turned on for the incoming cluster via power_up_setup and here
for the other cluster. As previously mentioned, I will be dropping
this change.

Regards,
Abhilash
>
> Cheers
> ---Dave
>
>>
>> > +           /* CPU should be powered up there */
>> > +           /* Also setup Cluster Power Sequence here */
>> > +   } else if (cpu_use_count[cpu][cluster] != 2) {
>> > +           /*
>> > +            * The only possible values are:
>> > +            * 0 = CPU down
>> > +            * 1 = CPU (still) up
>> > +            * 2 = CPU requested to be up before it had a chance
>> > +            *     to actually make itself down.
>> > +            * Any other value is a bug.
>> > +            */
>> > +           BUG();
>> > +   }
>> > +
>> > +   arch_spin_unlock(&bl_lock);
>> > +   local_irq_enable();
>> > +
>> > +   return 0;
>> > +}
>
> [...]
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
