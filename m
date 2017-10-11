From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 11 Oct 2017 09:49:09 +0100
Subject: [PATCH 1/3] arm64: mm: Support Common Not Private translations
In-Reply-To: <59DCE512.8010106@arm.com>
References: <1507553734-27854-1-git-send-email-vladimir.murzin@arm.com>
 <1507553734-27854-2-git-send-email-vladimir.murzin@arm.com>
 <59DCE512.8010106@arm.com>
Message-ID: <4df8125d-c4a4-bb1b-0858-cab57dccdea9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/17 16:19, James Morse wrote:
> Hi Vladimir,
> 
> On 09/10/17 13:55, Vladimir Murzin wrote:
>> Common Not Private (CNP) is a feature of ARMv8.2 extension which
>> allows translation table entries to be shared between different PEs in
>> the same inner shareable domain, so the hardware can use this fact to
>> optimise the caching of such entries in the TLB.
> 
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 21e2c95..8d098a1 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1211,6 +1224,14 @@ cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused)
>>  	return (cpus_have_const_cap(ARM64_HAS_PAN) && !cpus_have_const_cap(ARM64_HAS_UAO));
>>  }
>>  
>> +#ifdef CONFIG_ARM64_CNP
>> +static int cpu_enable_cnp(void *__unused)
>> +{
>> +	cpu_replace_ttbr1(swapper_pg_dir);
> 
> All the other callers of cpu_replace_ttbr1() wrap swapper_pg_dir in lm_alias().
> I'm pretty sure this is so that virt_to_phys() works when swapper_pg_dir's
> address is in the vmalloc range.
> 
> CONFIG_DEBUG_VIRTUAL should catch problems like this.

Indeed it did!

> 
> 
> (Nit: you shouldn't need the #ifdeffery, the only caller of this function is in
> the same file, so the compiler should do the right thing)
> 

I'll look into it.

Thanks
Vladimir

> 
>> +	return 0;
>> +}
>> +#endif /* CONFIG_ARM64_CNP */
>> +
>>  /*
>>   * We emulate only the following system register space.
>>   * Op0 = 0x3, CRn = 0x0, Op1 = 0x0, CRm = [0, 4 - 7]
> 
> 
> 
