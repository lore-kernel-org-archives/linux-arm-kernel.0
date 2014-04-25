From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 26 Apr 2014 01:07:37 +0200
Subject: [PATCH v8 1/3] ARM: EXYNOS: Add support for EXYNOS5410 SoC
In-Reply-To: <7hwqedf2d5.fsf@paris.lan>
References: <1397459860-21869-1-git-send-email-t.dakhran@samsung.com>	<1397459860-21869-2-git-send-email-t.dakhran@samsung.com>
 <7hwqedf2d5.fsf@paris.lan>
Message-ID: <535AEAB9.6020707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On 26.04.2014 00:52, Kevin Hilman wrote:
> Tarek Dakhran <t.dakhran@samsung.com> writes:
>
>> EXYNOS5410 is SoC in Samsung's Exynos5 SoC series.
>> Add initial support for this SoC.
>>
>> Signed-off-by: Tarek Dakhran <t.dakhran@samsung.com>
>> Signed-off-by: Vyacheslav Tyrtov <v.tyrtov@samsung.com>
>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>
> [...]
>
>> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
>> index 5eead53..83ae5fb 100644
>> --- a/arch/arm/mach-exynos/hotplug.c
>> +++ b/arch/arm/mach-exynos/hotplug.c
>> @@ -95,8 +95,8 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
>>   	for (;;) {
>>
>>   		/* make cpu1 to be turned off at next WFI command */
>> -		if (cpu == 1)
>> -			__raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
>> +		if (cpu > 0)
>> +			__raw_writel(0, S5P_ARM_CORE_CONFIGURATION(cpu));
>
> This looks like a fix that's probably not specific to the 5410 and maybe
> deserves it's own patch?
>
> [...]
>
>> @@ -107,14 +111,14 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
>>   	 */
>>   	write_pen_release(phys_cpu);
>>
>> -	if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
>> +	if (!(__raw_readl(S5P_ARM_CORE_STATUS(cpu)) & S5P_CORE_LOCAL_PWR_EN)) {
>>   		__raw_writel(S5P_CORE_LOCAL_PWR_EN,
>> -			     S5P_ARM_CORE1_CONFIGURATION);
>> +			     S5P_ARM_CORE_CONFIGURATION(cpu));
>>
>>   		timeout = 10;
>>
>>   		/* wait max 10 ms until cpu1 is on */
>> -		while ((__raw_readl(S5P_ARM_CORE1_STATUS)
>> +		while ((__raw_readl(S5P_ARM_CORE_STATUS(cpu))
>>   			& S5P_CORE_LOCAL_PWR_EN) != S5P_CORE_LOCAL_PWR_EN) {
>>   			if (timeout-- == 0)
>>   				break;
>
> ...and this hunk too?

Yes, they do, but we are currently refactoring this code anyway.

Best regards,
Tomasz
