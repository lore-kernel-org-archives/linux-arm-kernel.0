From: t.dakhran@samsung.com (Tarek Dakhran)
Date: Mon, 11 Nov 2013 19:45:30 +0400
Subject: [PATCH v3 3/4] ARM: EXYNOS: add Exynos Dual Cluster Support
In-Reply-To: <52808E09.9060902@samsung.com>
References: <20131108184036.GD2602@localhost.localdomain>
 <alpine.LFD.2.03.1311081356300.15571@syhkavp.arg>
 <52808E09.9060902@samsung.com>
Message-ID: <5280FB9A.7030500@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11.11.2013 11:58, Tarek Dakhran wrote:
>
>> On Thu, Nov 07, 2013 at 11:51:49AM -0500, Nicolas Pitre wrote:
>> Samsung people: could you give us more info on the behavior of the power
>> controller please?
>>
>>
>> Nicolas
>>
> This is how the power controller works on exynos5410. For example for 
> CORE0.
>
> ARM_CORE0_STATUS register indicates the power state of Core 0 part of 
> processor core.
> 0x3 indicates that power to Core 0 is turned-on. 0x0 indicates that 
> power to Core 0 is turned-off.
> All other values indicate that the power On/Off sequence of Core 0 in 
> progress.
>
> To turn Off the power of Core 0 power domain:
>
> 1. Set the LOCAL_POWER_CFG field of ARM_CORE0_CONFIGURATION register 
> to 0x3.
> 2. After PMU detects a change in the LOCAL_POWER_CFG field, it waits 
> for the execution of WFI.
> 3. After Core 0 executes the WFI instruction, PMU starts the 
> power-down sequence.
> 4. The Status field of ARM_CORE0_STATUS register indicates the 
> completion of the sequence.
>
> That's why in the v1 of this patch exynos_core_power_control function 
> was implemented as:
>
> static int exynos_core_power_control(unsigned int cpu, unsigned int 
> cluster,  int enable)
> {
>        unsigned long timeout = jiffies + msecs_to_jiffies(10);
>        unsigned int offset = cluster * MAX_CPUS_PER_CLUSTER + cpu;
>        int value = enable ? S5P_CORE_LOCAL_PWR_EN : 0;
>
>        if ((__raw_readl(EXYNOS5410_CORE_STATUS(offset)) & 0x3) == value)
>                return 0;
>
>        __raw_writel(value, EXYNOS5410_CORE_CONFIGURATION(offset));
>        do {
>                if ((__raw_readl(EXYNOS5410_CORE_STATUS(offset)) & 0x3)
>                                == value)
>                        return 0;
>        } while (time_before(jiffies, timeout));
>
>        return -EDEADLK;
> }
>
> But, as i mentioned, this is no good using while here.
> Now thinking about the problem.
>
> Thank you,
>         Tarek Dakhran

What do you think about this way of solving the problem with races?

Add new edcs_power_controller_wait function.

static void edcs_power_controller_wait(unsigned int cpu, unsigned int 
cluster){

         unsigned long timeout = jiffies + msecs_to_jiffies(10);
         unsigned int offset = cluster * EDCS_CPUS_PER_CLUSTER + cpu;
         void __iomem *status_reg = EDCS_CORE_STATUS(offset);

         /* wait till core power controller finish the work */

         do {
                 if ((readl_relaxed(status_reg) & 3) == 
edcs_use_count[cpu][cluster] ? 3 : 0)
                         return;
         } while (time_before(jiffies, timeout));

         /* Should never get here */
         BUG();
}

Use it in:

static void exynos_core_power_up(unsigned int cpu, unsigned int cluster)
{
         exynos_core_power_control(cpu, cluster, true);
         edcs_power_controller_wait(cpu, cluster);
}

and in:

static void exynos_power_down(void)
{
         bool last_man = false, skip_wfi = false;
         unsigned int mpidr = read_cpuid_mpidr();
         unsigned int cpu = MPIDR_AFFINITY_LEVEL(mpidr, 0);
         unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);


         pr_debug("%s: CORE%d on CLUSTER %d\n", __func__, cpu, cluster);
         BUG_ON(cpu >= EDCS_CPUS_PER_CLUSTER  || cluster >= EDCS_CLUSTERS);

         __mcpm_cpu_going_down(cpu, cluster);

         arch_spin_lock(&edcs_lock);
         BUG_ON(__mcpm_cluster_state(cluster) != CLUSTER_UP);
         edcs_use_count[cpu][cluster]--;
         if (edcs_use_count[cpu][cluster] == 0) {
                 exynos_core_power_down(cpu, cluster);
                 --core_count[cluster];
                 if (core_count[cluster] == 0)
                         last_man = true;
[snip]
         __mcpm_cpu_down(cpu, cluster);

         if (!skip_wfi){
                 wfi();
         }
         edcs_power_controller_wait(cpu, cluster);
}

Comments appreciated. Thanks.

Best regards,
     Tarek Dakhran.
