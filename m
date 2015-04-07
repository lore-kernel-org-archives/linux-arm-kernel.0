From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 07 Apr 2015 10:58:00 -0700
Subject: [PATCH v4] ARM: smp: Only expose /sys/.../cpuX/online if
 hotpluggable
In-Reply-To: <CANMBJr4OrCL61Z__Xy2ZRj9zUS=nsj3iNezB1dpc-154buXr7A@mail.gmail.com>
References: <1428351853-5844-1-git-send-email-sboyd@codeaurora.org>
 <CANMBJr4OrCL61Z__Xy2ZRj9zUS=nsj3iNezB1dpc-154buXr7A@mail.gmail.com>
Message-ID: <55241AA8.8060208@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/15 09:18, Tyler Baker wrote:
> Hi Stephen,
>
> On 6 April 2015 at 13:24, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> Writes to /sys/.../cpuX/online fail if we determine the platform
>> doesn't support hotplug for that CPU. Furthermore, if the cpu_die
>> op isn't specified the system hangs when we try to offline a CPU
>> and it comes right back online unexpectedly. Let's figure this
>> stuff out before we make the sysfs nodes so that the online file
>> doesn't even exist if it isn't (at least sometimes) possible to
>> hotplug the CPU.
>>
>> Add a new 'cpu_can_disable' op and repoint all 'cpu_disable'
>> implementations at it because all implementers use the op to
>> indicate if a CPU can be hotplugged or not in a static fashion.
>> With PSCI we may need to add a 'cpu_disable' op so that the
>> secure OS can be migrated off the CPU we're trying to hotplug.
>> In this case, the 'cpu_can_disable' op will indicate that all
>> CPUs are hotpluggable by returning true, but the 'cpu_disable' op
>> will make a PSCI migration call and occasionally fail, denying
>> the hotplug of a CPU. This shouldn't be any worse than x86 where
>> we may indicate that all CPUs are hotpluggable but occasionally
>> we can't offline a CPU due to check_irq_vectors_for_cpu_disable()
>> failing to find a CPU to move vectors to.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Nicolas Pitre <nico@linaro.org>
>> Cc: Dave Martin <Dave.Martin@arm.com>
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: <linux-sh@vger.kernel.org>
>> Cc: Tyler Baker <tyler.baker@linaro.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>
>> Changes since v3:
>>  * Return bool instead of int from 'cpu_can_disable' op
>>
>> Changes since v2:
>>  * Left cpu_disable op in place
>>  * Split out shmobile function deletion
>>
>>  arch/arm/common/mcpm_platsmp.c       | 12 ++++--------
>>  arch/arm/include/asm/smp.h           | 10 ++++++++++
>>  arch/arm/kernel/setup.c              |  2 +-
>>  arch/arm/kernel/smp.c                | 15 ++++++++++++++-
>>  arch/arm/mach-shmobile/common.h      |  2 +-
>>  arch/arm/mach-shmobile/platsmp.c     |  4 ++--
>>  arch/arm/mach-shmobile/smp-r8a7790.c |  2 +-
>>  arch/arm/mach-shmobile/smp-r8a7791.c |  2 +-
>>  arch/arm/mach-shmobile/smp-sh73a0.c  |  2 +-
>>  9 files changed, 35 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm/common/mcpm_platsmp.c b/arch/arm/common/mcpm_platsmp.c
>> index 92e54d7c6f46..2b25b6038f66 100644
>> --- a/arch/arm/common/mcpm_platsmp.c
>> +++ b/arch/arm/common/mcpm_platsmp.c
>> @@ -65,14 +65,10 @@ static int mcpm_cpu_kill(unsigned int cpu)
>>         return !mcpm_wait_for_cpu_powerdown(pcpu, pcluster);
>>  }
>>
>> -static int mcpm_cpu_disable(unsigned int cpu)
>> +static bool mcpm_cpu_can_disable(unsigned int cpu)
>>  {
>> -       /*
>> -        * We assume all CPUs may be shut down.
>> -        * This would be the hook to use for eventual Secure
>> -        * OS migration requests as described in the PSCI spec.
>> -        */
>> -       return 0;
>> +       /* We assume all CPUs may be shut down. */
>> +       return true;
>>  }
>>
>>  static void mcpm_cpu_die(unsigned int cpu)
>> @@ -92,7 +88,7 @@ static struct smp_operations __initdata mcpm_smp_ops = {
>>         .smp_secondary_init     = mcpm_secondary_init,
>>  #ifdef CONFIG_HOTPLUG_CPU
>>         .cpu_kill               = mcpm_cpu_kill,
>> -       .cpu_disable            = mcpm_cpu_disable,
>> +       .cpu_can_disable        = mcpm_cpu_can_disable,
>>         .cpu_die                = mcpm_cpu_die,
>>  #endif
>>  };
>> diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
>> index 18f5a554134f..e15856a1a380 100644
>> --- a/arch/arm/include/asm/smp.h
>> +++ b/arch/arm/include/asm/smp.h
>> @@ -104,6 +104,7 @@ struct smp_operations {
>>  #ifdef CONFIG_HOTPLUG_CPU
>>         int  (*cpu_kill)(unsigned int cpu);
>>         void (*cpu_die)(unsigned int cpu);
>> +       bool  (*cpu_can_disable)(unsigned int cpu);
>>         int  (*cpu_disable)(unsigned int cpu);
>>  #endif
>>  #endif
>> @@ -123,4 +124,13 @@ struct of_cpu_method {
>>   */
>>  extern void smp_set_ops(struct smp_operations *);
>>
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +extern int platform_can_hotplug_cpu(unsigned int cpu);
>> +#else
>> +static inline int platform_can_hotplug_cpu(unsigned int cpu)
>> +{
>> +       return 0;
>> +}
>> +#endif
>> +
>>  #endif /* ifndef __ASM_ARM_SMP_H */
>> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
>> index 6c777e908a24..955d45d0f70c 100644
>> --- a/arch/arm/kernel/setup.c
>> +++ b/arch/arm/kernel/setup.c
>> @@ -992,7 +992,7 @@ static int __init topology_init(void)
>>
>>         for_each_possible_cpu(cpu) {
>>                 struct cpuinfo_arm *cpuinfo = &per_cpu(cpu_data, cpu);
>> -               cpuinfo->cpu.hotpluggable = 1;
>> +               cpuinfo->cpu.hotpluggable = platform_can_hotplug_cpu(cpu);
>>                 register_cpu(&cpuinfo->cpu, cpu);
>>         }
>>
> When I tested this patch before I only tried building
> multi_v7_defconfig (which built fine) however I've added this patch to
> my to-build branch and sent it through the CI loop. It appears that
> there quite a few build errors on the other defconfigs[0][1].
>
> ../arch/arm/kernel/setup.c: In function 'topology_init':
> ../arch/arm/kernel/setup.c:977:3: error: implicit declaration of
> function 'platform_can_hotplug_cpu'
> [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[2]: *** [arch/arm/kernel/setup.o] Error 1
>

Ah right. asm/smp.h is not included unless CONFIG_SMP=y. We can move it
into smp_plat.h. I'll wait to see if there any other comments before
sending an update.

---8<---

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index e15856a1a380..2563453d7b37 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -124,13 +124,4 @@ struct of_cpu_method {
  */
 extern void smp_set_ops(struct smp_operations *);
 
-#ifdef CONFIG_HOTPLUG_CPU
-extern int platform_can_hotplug_cpu(unsigned int cpu);
-#else
-static inline int platform_can_hotplug_cpu(unsigned int cpu)
-{
-	return 0;
-}
-#endif
-
 #endif /* ifndef __ASM_ARM_SMP_H */
diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index 0ad7d490ee6f..ebadc9956ffc 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -106,4 +106,13 @@ static inline u32 mpidr_hash_size(void)
 
 extern int platform_can_cpu_hotplug(void);
 
+#ifdef CONFIG_HOTPLUG_CPU
+extern int platform_can_hotplug_cpu(unsigned int cpu);
+#else
+static inline int platform_can_hotplug_cpu(unsigned int cpu)
+{
+	return 0;
+}
+#endif
+
 #endif



-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
