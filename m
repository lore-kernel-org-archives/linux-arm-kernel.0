From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 30 Apr 2014 17:00:50 +0900
Subject: [PATCHv4 4/7] ARM: EXYNOS: Enter a15 lowpower mode for Exynos3250
 based on Cortex-a7
In-Reply-To: <535AFCDF.20503@gmail.com>
References: <1398388572-30239-1-git-send-email-cw00.choi@samsung.com>
 <1398388572-30239-5-git-send-email-cw00.choi@samsung.com>
 <535AFCDF.20503@gmail.com>
Message-ID: <5360ADB2.1080600@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 04/26/2014 09:25 AM, Tomasz Figa wrote:
> Hi Chanwoo,
> 
> On 25.04.2014 03:16, Chanwoo Choi wrote:
>> This patch decide proper lowpower mode of either a15 or a9 according to own ID
>> from Main ID register.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Marc Zynigier <marc.zyngier@arm.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>   arch/arm/mach-exynos/hotplug.c | 19 ++++++++++++-------
>>   1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
>> index 5eead53..acf3119 100644
>> --- a/arch/arm/mach-exynos/hotplug.c
>> +++ b/arch/arm/mach-exynos/hotplug.c
>> @@ -135,16 +135,21 @@ void __ref exynos_cpu_die(unsigned int cpu)
>>       int primary_part = 0;
>>
>>       /*
>> -     * we're ready for shutdown now, so do it.
>> -     * Exynos4 is A9 based while Exynos5 is A15; check the CPU part
>> -     * number by reading the Main ID register and then perform the
>> -     * appropriate sequence for entering low power.
>> +     * Prepare the CPU for shutting down. The required sequence of
>> +     * operations depends on core type. CPUID part number can be used to
>> +     * determine the right way.
>>        */
>> -    asm("mrc p15, 0, %0, c0, c0, 0" : "=r"(primary_part) : : "cc");
>> -    if ((primary_part & 0xfff0) == 0xc0f0)
>> +    primary_part = read_cpuid_part_number();
>> +
>> +    switch (primary_part) {
>> +    case ARM_CPU_PART_CORTEX_A7:
>> +    case ARM_CPU_PART_CORTEX_A15:
>>           cpu_enter_lowpower_a15();
>> -    else
>> +        break;
>> +    default:
>>           cpu_enter_lowpower_a9();
>> +        break;
>> +    }
>>
>>       platform_do_lowpower(cpu, &spurious);
>>
>>
> 
> I have noticed Leela Krishna Amudala's patch [1] that removes this distinction completely and simply uses generic code. Could you check if this works on Exynos3250 as well? If yes, then this patch could be dropped and Leela's one would be enough.
> 
> [1] http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg29064.html

OK, I tested this patch[1] to turn on secondary CPu on Exynos3250.
I'll drop following patch on next posting(v5) by using Leela Krishna Amudala's patch [1].
- ARM: EXYNOS: Enter a15 lowpower mode for Exynos3250 based on Cortex-a7

Best Regards,
Chanwoo Choi
