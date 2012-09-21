From: cyril@ti.com (Cyril Chemparathy)
Date: Fri, 21 Sep 2012 18:25:28 -0400
Subject: [PATCH v3 02/17] ARM: add self test for runtime patch mechanism
In-Reply-To: <alpine.LFD.2.02.1209211331320.6667@xanadu.home>
References: <1347385155-11643-1-git-send-email-cyril@ti.com>
 <1347385155-11643-3-git-send-email-cyril@ti.com>
 <alpine.LFD.2.02.1209211331320.6667@xanadu.home>
Message-ID: <505CE958.5020808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/21/2012 1:40 PM, Nicolas Pitre wrote:
> On Tue, 11 Sep 2012, Cyril Chemparathy wrote:
>
>> This patch adds basic sanity tests to ensure that the instruction patching
>> results in valid instruction encodings.  This is done by verifying the output
>> of the patch process against a vector of assembler generated instructions at
>> init time.
>>
>> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
>> ---
>>   arch/arm/Kconfig                |   12 +++++++
>>   arch/arm/kernel/runtime-patch.c |   75 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 87 insertions(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 36de4ea..bfcd29d 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -207,6 +207,18 @@ config ARM_PATCH_PHYS_VIRT
>>   	  this feature (eg, building a kernel for a single machine) and
>>   	  you need to shrink the kernel to the minimal size.
>>
>> +config ARM_RUNTIME_PATCH_TEST
>> +	bool "Self test runtime patching mechanism" if ARM_RUNTIME_PATCH
>> +	default y
>
> Here you probably want this instead:
>
> 	bool "Self test runtime patching mechanism"
> 	default y
> 	depends on ARM_RUNTIME_PATCH
>
> Otherwise ARM_RUNTIME_PATCH_TEST will be forced to y whenever
> ARM_RUNTIME_PATCH is unset.  That doesn't currently affect the build
> since the containing .c file is only compiled when ARM_RUNTIME_PATCH is
> set but that is still not strictly right.
>

Indeed.  Excellent.  Thanks.

> [...]
>> @@ -189,5 +261,8 @@ void __init runtime_patch_kernel(void)
>>   	const void *start = &__runtime_patch_table_begin;
>>   	const void *end   = &__runtime_patch_table_end;
>>
>> +#ifdef CONFIG_ARM_RUNTIME_PATCH_TEST
>> +	runtime_patch_test();
>> +#endif
>>   	BUG_ON(runtime_patch(start, end - start));
>
> I think you shoulld have runtime_patch_test() return a possible error
> code and use BUG_ON() with it as well.
>

Sure.  Will do in v4.

> With those minor changes you can add...
>
> Reviewed-by: Nicolas Pitre <nico@linaro.org>
>

Thanks.

-- 
- Cyril
