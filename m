From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Wed, 09 Nov 2016 15:08:44 +0530
Subject: [RESPIN-PATCH v2 1/2] ARM: EXYNOS: Remove static mapping of SCU
 SFR
In-Reply-To: <20161108190446.GA4608@kozik-lap>
References: <1478603984-504-1-git-send-email-pankaj.dubey@samsung.com>
 <1478603984-504-2-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161108190454epcas3p22128ae11877fd52d4e1065cef2b4a73a@epcas3p2.samsung.com>
 <20161108190446.GA4608@kozik-lap>
Message-ID: <3674bb7e-8442-4960-b95f-cec1517e4929@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Wednesday 09 November 2016 12:34 AM, Krzysztof Kozlowski wrote:
> On Tue, Nov 08, 2016 at 04:49:43PM +0530, Pankaj Dubey wrote:
>> Lets remove static mapping of SCU SFR mainly used in CORTEX-A9 SoC based boards.
>> Instead use mapping from device tree node of SCU.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>  arch/arm/mach-exynos/common.h                |  1 +
>>  arch/arm/mach-exynos/exynos.c                | 22 ------------------
>>  arch/arm/mach-exynos/include/mach/map.h      |  2 --
>>  arch/arm/mach-exynos/platsmp.c               | 34 +++++++++++++++++++++-------
>>  arch/arm/mach-exynos/pm.c                    |  5 ++--
>>  arch/arm/mach-exynos/suspend.c               | 13 ++++-------
>>  arch/arm/plat-samsung/include/plat/map-s5p.h |  4 ----
>>  7 files changed, 34 insertions(+), 47 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
>> index 9424a8a..dd5d8e8 100644
>> --- a/arch/arm/mach-exynos/common.h
>> +++ b/arch/arm/mach-exynos/common.h
>> @@ -161,6 +161,7 @@ extern void exynos_cpu_restore_register(void);
>>  extern void exynos_pm_central_suspend(void);
>>  extern int exynos_pm_central_resume(void);
>>  extern void exynos_enter_aftr(void);
>> +extern int exynos_scu_enable(void);
>>  
>>  extern struct cpuidle_exynos_data cpuidle_coupled_exynos_data;
>>  
>> diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
>> index 757fc11..fa08ef9 100644
>> --- a/arch/arm/mach-exynos/exynos.c
>> +++ b/arch/arm/mach-exynos/exynos.c
>> @@ -28,15 +28,6 @@
>>  
>>  #include "common.h"
>>  
>> -static struct map_desc exynos4_iodesc[] __initdata = {
>> -	{
>> -		.virtual	= (unsigned long)S5P_VA_COREPERI_BASE,
>> -		.pfn		= __phys_to_pfn(EXYNOS4_PA_COREPERI),
>> -		.length		= SZ_8K,
>> -		.type		= MT_DEVICE,
>> -	},
>> -};
>> -
>>  static struct platform_device exynos_cpuidle = {
>>  	.name              = "exynos_cpuidle",
>>  #ifdef CONFIG_ARM_EXYNOS_CPUIDLE
>> @@ -99,17 +90,6 @@ static int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
>>  	return 1;
>>  }
>>  
>> -/*
>> - * exynos_map_io
>> - *
>> - * register the standard cpu IO areas
>> - */
>> -static void __init exynos_map_io(void)
>> -{
>> -	if (soc_is_exynos4())
>> -		iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
>> -}
>> -
>>  static void __init exynos_init_io(void)
>>  {
>>  	debug_ll_io_init();
>> @@ -118,8 +98,6 @@ static void __init exynos_init_io(void)
>>  
>>  	/* detect cpu id and rev. */
>>  	s5p_init_cpu(S5P_VA_CHIPID);
>> -
>> -	exynos_map_io();
>>  }
>>  
>>  /*
>> diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
>> index 5fb0040..0eef407 100644
>> --- a/arch/arm/mach-exynos/include/mach/map.h
>> +++ b/arch/arm/mach-exynos/include/mach/map.h
>> @@ -18,6 +18,4 @@
>>  
>>  #define EXYNOS_PA_CHIPID		0x10000000
>>  
>> -#define EXYNOS4_PA_COREPERI		0x10500000
>> -
>>  #endif /* __ASM_ARCH_MAP_H */
>> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
>> index a5d6841..94405c7 100644
>> --- a/arch/arm/mach-exynos/platsmp.c
>> +++ b/arch/arm/mach-exynos/platsmp.c
>> @@ -168,6 +168,27 @@ int exynos_cluster_power_state(int cluster)
>>  		S5P_CORE_LOCAL_PWR_EN);
>>  }
>>  
>> +/**
>> + * exynos_scu_enable : enables SCU for Cortex-A9 based system
>> + * returns 0 on success else non-zero error code
>> + */
>> +int exynos_scu_enable(void)
>> +{
>> +	struct device_node *np;
>> +	void __iomem *scu_base;
>> +
>> +	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
>> +	scu_base = of_iomap(np, 0);
>> +	of_node_put(np);
>> +	if (!scu_base) {
>> +		pr_err("%s failed to map scu_base\n", __func__);
>> +		return -ENOMEM;
>> +	}
>> +	scu_enable(scu_base);
>> +	iounmap(scu_base);
>> +	return 0;
>> +}
>> +
>>  static void __iomem *cpu_boot_reg_base(void)
>>  {
>>  	if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_1_1)
>> @@ -224,11 +245,6 @@ static void write_pen_release(int val)
>>  	sync_cache_w(&pen_release);
>>  }
>>  
>> -static void __iomem *scu_base_addr(void)
>> -{
>> -	return (void __iomem *)(S5P_VA_SCU);
>> -}
>> -
>>  static DEFINE_SPINLOCK(boot_lock);
>>  
>>  static void exynos_secondary_init(unsigned int cpu)
>> @@ -393,9 +409,11 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
>>  
>>  	exynos_set_delayed_reset_assertion(true);
>>  
>> -	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9)
>> -		scu_enable(scu_base_addr());
>> -
>> +	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
>> +		/* if exynos_scu_enable fails, return */
>> +		if (exynos_scu_enable())
>> +			return;
> 
> Ohhh, someone (e.g. out-of-tree DTS) might be surprised with this.
> Please mention such change of behaviour in the commit log (describe the
> possible impact of this commit).
> 

OK, I will add small note, for this change of behavior in commit log.

>> +	}
>>  	/*
>>  	 * Write the address of secondary startup into the
>>  	 * system-wide flags register. The boot monitor waits
>> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
>> index 487295f..23db2af 100644
>> --- a/arch/arm/mach-exynos/pm.c
>> +++ b/arch/arm/mach-exynos/pm.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/cpu_pm.h>
>>  #include <linux/io.h>
>>  #include <linux/of.h>
>> +#include <linux/of_address.h>
> 
> Why do you need this include? Was it coming from mach/map.h?
> 

Its not required. This is leftover of patchset v1, and can be removed.

>>  #include <linux/soc/samsung/exynos-regs-pmu.h>
>>  #include <linux/soc/samsung/exynos-pmu.h>
>>  
>> @@ -26,8 +27,6 @@
>>  #include <asm/suspend.h>
>>  #include <asm/cacheflush.h>
>>  
>> -#include <mach/map.h>
>> -
>>  #include "common.h"
>>  
>>  static inline void __iomem *exynos_boot_vector_addr(void)
>> @@ -177,7 +176,7 @@ void exynos_enter_aftr(void)
>>  	cpu_suspend(0, exynos_aftr_finisher);
>>  
>>  	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9) {
>> -		scu_enable(S5P_VA_SCU);
>> +		exynos_scu_enable();
>>  		if (call_firmware_op(resume) == -ENOSYS)
>>  			exynos_cpu_restore_register();
>>  	}
>> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
>> index 06332f6..c73c857 100644
>> --- a/arch/arm/mach-exynos/suspend.c
>> +++ b/arch/arm/mach-exynos/suspend.c
>> @@ -34,8 +34,6 @@
>>  #include <asm/smp_scu.h>
>>  #include <asm/suspend.h>
>>  
>> -#include <mach/map.h>
>> -
>>  #include <plat/pm-common.h>
>>  
>>  #include "common.h"
>> @@ -461,12 +459,11 @@ static void exynos_pm_resume(void)
>>  	/* For release retention */
>>  	exynos_pm_release_retention();
>>  
>> -	if (cpuid == ARM_CPU_PART_CORTEX_A9)
>> -		scu_enable(S5P_VA_SCU);
>> -
>> -	if (call_firmware_op(resume) == -ENOSYS
>> -	    && cpuid == ARM_CPU_PART_CORTEX_A9)
>> -		exynos_cpu_restore_register();
>> +	if (cpuid == ARM_CPU_PART_CORTEX_A9) {
>> +		exynos_scu_enable();
>> +		if (call_firmware_op(resume) == -ENOSYS)
>> +			exynos_cpu_restore_register();
> 
> It does not look right. I think you changed the logic here. Previously
> if CPU != A9, then call_firmware_op() was executed. Now it won't be.
> 

Yes, my bad, I understood it in different way. I will correct this and
submit V3, after addressing all your comments.

> BTW, don't respin patchset with the same version number. This is
> basically v3. To me, increasing version number is always welcomed. It
> makes dealign with patches easier.
> 

OK. I will take care in future.


Thanks,
Pankaj Dubey
