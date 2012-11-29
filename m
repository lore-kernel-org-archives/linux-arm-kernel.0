From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Thu, 29 Nov 2012 16:38:46 -0500
Subject: [PATCH v4 03/14] ARM: Factor out cpuid implementor and part number
In-Reply-To: <20121119142126.GV3205@mudshark.cambridge.arm.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154231.2836.24377.stgit@chazy-air>
 <20121119142126.GV3205@mudshark.cambridge.arm.com>
Message-ID: <CANM98qLDLRdaOWWOU-zUs38+0A4YjSWLMUeuF=1KteFnyQyDsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 9:21 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Sat, Nov 10, 2012 at 03:42:31PM +0000, Christoffer Dall wrote:
>> Decoding the implementor and part number of the CPU id in the CPU ID
>> register is needed by KVM, so we factor it out to share the code.
>>
>> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>
> [...]
>
>> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
>> index cb47d28..306fb2c 100644
>> --- a/arch/arm/include/asm/cputype.h
>> +++ b/arch/arm/include/asm/cputype.h
>> @@ -51,6 +51,22 @@ extern unsigned int processor_id;
>>  #define read_cpuid_ext(reg) 0
>>  #endif
>>
>> +#define IMPLEMENTOR_ARM              0x41
>> +#define IMPLEMENTOR_INTEL    0x69
>> +
>> +#define PART_NUMBER_ARM1136  0xB360
>> +#define PART_NUMBER_ARM1156  0xB560
>> +#define PART_NUMBER_ARM1176  0xB760
>> +#define PART_NUMBER_ARM11MPCORE      0xB020
>> +#define PART_NUMBER_CORTEX_A8        0xC080
>> +#define PART_NUMBER_CORTEX_A9        0xC090
>> +#define PART_NUMBER_CORTEX_A5        0xC050
>> +#define PART_NUMBER_CORTEX_A15       0xC0F0
>> +#define PART_NUMBER_CORTEX_A7        0xC070
>> +
>> +#define PART_NUMBER_XSCALE1  0x1
>> +#define PART_NUMBER_XSCALE2  0x2
>
> We should probably prefix these with ARM_CPU_ and make the current names
> shorter to compensate. e.g. ARM_CPU_PART_1136, ARM_CPU_IMP_ARM ?
>
>>  /*
>>   * The CPU ID never changes at run time, so we might as well tell the
>>   * compiler that it's constant.  Use this function to read the CPU ID
>> @@ -61,6 +77,16 @@ static inline unsigned int __attribute_const__ read_cpuid_id(void)
>>       return read_cpuid(CPUID_ID);
>>  }
>>
>> +static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
>> +{
>> +     return (read_cpuid_id() & 0xFF000000) >> 24;
>> +}
>> +
>> +static inline unsigned int __attribute_const__ read_cpuid_part_number(void)
>> +{
>> +     return (read_cpuid_id() & 0xFFF0);
>> +}
>
> Perhaps this should take the implementor as an argument, given that the
> part number is described differently between implementors. The xscale
> stuff can then move in here (we'll need to check the xscale docs in case
> perf is using a subfield -- I can't remember off-hand).
>
>>  static inline unsigned int __attribute_const__ read_cpuid_cachetype(void)
>>  {
>>       return read_cpuid(CPUID_CACHETYPE);
>> diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
>> index 8d7d8d4..ff18566 100644
>> --- a/arch/arm/kernel/perf_event_cpu.c
>> +++ b/arch/arm/kernel/perf_event_cpu.c
>> @@ -200,46 +200,46 @@ static struct arm_pmu *__devinit probe_current_pmu(void)
>>       struct arm_pmu *pmu = NULL;
>>       int cpu = get_cpu();
>>       unsigned long cpuid = read_cpuid_id();
>> -     unsigned long implementor = (cpuid & 0xFF000000) >> 24;
>> -     unsigned long part_number = (cpuid & 0xFFF0);
>> +     unsigned long implementor = read_cpuid_implementor();
>> +     unsigned long part_number = read_cpuid_part_number();
>>
>>       pr_info("probing PMU on CPU %d\n", cpu);
>>
>>       /* ARM Ltd CPUs. */
>> -     if (0x41 == implementor) {
>> +     if (implementor == IMPLEMENTOR_ARM) {
>>               switch (part_number) {
>> -             case 0xB360:    /* ARM1136 */
>> -             case 0xB560:    /* ARM1156 */
>> -             case 0xB760:    /* ARM1176 */
>> +             case PART_NUMBER_ARM1136:
>> +             case PART_NUMBER_ARM1156:
>> +             case PART_NUMBER_ARM1176:
>>                       pmu = armv6pmu_init();
>>                       break;
>> -             case 0xB020:    /* ARM11mpcore */
>> +             case PART_NUMBER_ARM11MPCORE:
>>                       pmu = armv6mpcore_pmu_init();
>>                       break;
>> -             case 0xC080:    /* Cortex-A8 */
>> +             case PART_NUMBER_CORTEX_A8:
>>                       pmu = armv7_a8_pmu_init();
>>                       break;
>> -             case 0xC090:    /* Cortex-A9 */
>> +             case PART_NUMBER_CORTEX_A9:
>>                       pmu = armv7_a9_pmu_init();
>>                       break;
>> -             case 0xC050:    /* Cortex-A5 */
>> +             case PART_NUMBER_CORTEX_A5:
>>                       pmu = armv7_a5_pmu_init();
>>                       break;
>> -             case 0xC0F0:    /* Cortex-A15 */
>> +             case PART_NUMBER_CORTEX_A15:
>>                       pmu = armv7_a15_pmu_init();
>>                       break;
>> -             case 0xC070:    /* Cortex-A7 */
>> +             case PART_NUMBER_CORTEX_A7:
>>                       pmu = armv7_a7_pmu_init();
>>                       break;
>>               }
>>       /* Intel CPUs [xscale]. */
>> -     } else if (0x69 == implementor) {
>> +     } else if (implementor == IMPLEMENTOR_INTEL) {
>>               part_number = (cpuid >> 13) & 0x7;
>>               switch (part_number) {
>> -             case 1:
>> +             case PART_NUMBER_XSCALE1:
>>                       pmu = xscale1pmu_init();
>>                       break;
>> -             case 2:
>> +             case PART_NUMBER_XSCALE2:
>>                       pmu = xscale2pmu_init();
>>                       break;
>>               }
>
> If you stick this one in a separate patch, I can take it via the perf
> tree (along with the CPUID rework above).
>
thanks,
I sent a separate patch.

-Christoffer
