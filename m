From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 03 Jun 2013 18:19:37 +0800
Subject: [PATCH v2] arch: arm: plat-samsung: dependency, S5P_SLEEP depends
 on ARM_CPU_SUSPEND
In-Reply-To: <51A9E8A0.3050906@gmail.com>
References: <5199E4AF.7040607@asianux.com> <51A32FD4.4000001@asianux.com>
 <158201ce5ac2$a7843de0$f68cb9a0$%kim@samsung.com>
 <51A33A53.1050502@asianux.com> <51A33C1F.3000804@asianux.com>
 <51A9E8A0.3050906@gmail.com>
Message-ID: <51AC6DB9.1080407@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2013 08:27 PM, Sylwester Nawrocki wrote:
> On 05/27/2013 12:57 PM, Chen Gang wrote:
>>
>> When randconfig with MMU for arm s5pv210 (and select all cpu type),
>> need let S5P_SLEEP depend on ARM_CPU_SUSPEND, or will cause issue below:
>>
>>    arch/arm/plat-samsung/built-in.o: In function `s3c_cpu_resume':
>>    arch/arm/plat-samsung/s5p-sleep.S:83: undefined reference to
>> `cpu_resume'
>>
>>
>> Signed-off-by: Chen Gang<gang.chen@asianux.com>
>> ---
>>   arch/arm/plat-samsung/Kconfig |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-samsung/Kconfig
>> b/arch/arm/plat-samsung/Kconfig
>> index f8ed2de..b388d93 100644
>> --- a/arch/arm/plat-samsung/Kconfig
>> +++ b/arch/arm/plat-samsung/Kconfig
>> @@ -483,6 +483,7 @@ config S5P_PM
>>
>>   config S5P_SLEEP
>>       bool
>> +    select ARM_CPU_SUSPEND if PM
>>       help
>>         Internal config node to apply common S5P sleep management code.
>>         Can be selected by S5P and newer SoCs with similar sleep
>> procedure.
> 
> We have discussed this about two months ago [1] and the conclusion was
> to also
> remove "select ARM_CPU_SUSPEND if PM" line from
> arch/arm/mach-exynos/Kconfig.
> It is still unresolved then, I'm getting similar linker errors with
> s3c2410_defconfig...
> 

I do not think they are the same.

This patch says: S5P_SLEEP need ARM_CPU_SUSPEND, or can not pass
compiling (S5P_SLEEP need some functions in ARM_CPU_SUSPEND).

Your patch means PLAT_SAMSUNG need ARM_CPU_SUSPEND, but in fact,
PLAT_SAMSUNG may not need ARM_CPU_SUSPEND.


>   LD      init/built-in.o
> arch/arm/mach-s3c24xx/built-in.o: In function `s3c_cpu_resume':
> /home/snawrocki/linux/media_tree/arch/arm/mach-s3c24xx/sleep.S:83:
> undefined reference to `cpu_resume'
> arch/arm/plat-samsung/built-in.o: In function `s3c_pm_enter':
> /home/snawrocki/linux/media_tree/arch/arm/plat-samsung/pm.c:305:
> undefined reference to `cpu_suspend'
> make: *** [vmlinux] Error 1
> 
> 

I guess, this error output means S5P_SLEEP and PM need ARM_CPU_SUSPEND
(which has the implementation of 'cpu_resume' and 'cpu_suspend')


Thanks.
-- 
Chen Gang

Asianux Corporation
