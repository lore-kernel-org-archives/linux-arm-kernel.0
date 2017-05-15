From: yanjiang.jin@windriver.com (yjin)
Date: Mon, 15 May 2017 17:05:49 +0800
Subject: [PATCH] socfpga_a10: reset CPU1 in socfpga_cpu_kill()
In-Reply-To: <20170512143600.GB18818@leverpostej>
References: <20170510051304.131042-1-yanjiang.jin@windriver.com>
 <20170510051304.131042-2-yanjiang.jin@windriver.com>
 <20170512143600.GB18818@leverpostej>
Message-ID: <59196F6D.40400@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2017?05?12? 22:36, Mark Rutland wrote:
> On Wed, May 10, 2017 at 01:13:04AM -0400, yanjiang.jin at windriver.com wrote:
>> From: Yanjiang Jin <yanjiang.jin@windriver.com>
>>
>> Kexec's second kernel would hang if CPU1 isn't reset.
>>
>> Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
>> ---
>>   arch/arm/mach-socfpga/platsmp.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
>> index 0ee7677..db3940e 100644
>> --- a/arch/arm/mach-socfpga/platsmp.c
>> +++ b/arch/arm/mach-socfpga/platsmp.c
>> @@ -117,6 +117,16 @@ static int socfpga_cpu_kill(unsigned int cpu)
>>   {
>>   	return 1;
>>   }
>> +
>> +static int socfpga_a10_cpu_kill(unsigned int cpu)
>> +{
>> +	/* This will put CPU #1 into reset. */
>> +	if (socfpga_cpu1start_addr)
>> +		writel(RSTMGR_MPUMODRST_CPU1, rst_manager_base_addr +
>> +			SOCFPGA_A10_RSTMGR_MODMPURST);
>> +
>> +	return 1;
>> +}
>>   #endif
> I agree that currently, socfpga_cpu_die is completely bogus, as the CPU is just
> sat in WFI with the MMU, caches, etc enabled, and not actually off:
>
> static void socfpga_cpu_die(unsigned int cpu)
> {
>          /* Do WFI. If we wake up early, go back into WFI */
>          while (1)
>                  cpu_do_idle();
> }
>
> ... so that goes wrong as soon as the kerenl text gets ovewritten.
>
> However, AFAICT, this patch forcibly resets is without any teardown
> having happened. That will surely result in data being lost from the
> caches, for example.
>
> So I think this is incomplete.
Hi Mark,

I think I got what you mean. So far, flush_cache is the only thing that 
I can think of.
Can we just add flush_cache_all in cpu_die() now, and add other missing 
parts(if have) in the future.

Thanks!
Yanjiang

> Thanks,
> Mark.
>
>>   
>>   static const struct smp_operations socfpga_smp_ops __initconst = {
>> @@ -133,7 +143,7 @@ static int socfpga_cpu_kill(unsigned int cpu)
>>   	.smp_boot_secondary	= socfpga_a10_boot_secondary,
>>   #ifdef CONFIG_HOTPLUG_CPU
>>   	.cpu_die		= socfpga_cpu_die,
>> -	.cpu_kill		= socfpga_cpu_kill,
>> +	.cpu_kill		= socfpga_a10_cpu_kill,
>>   #endif
>>   };
>>   
>> -- 
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
