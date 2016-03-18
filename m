From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 18 Mar 2016 13:47:27 +0800
Subject: [RFC PATCH] arm64: Expose physical/virtual address bits through
 cpuinfo
In-Reply-To: <56EA959C.8080005@arm.com>
References: <1458209283-44999-1-git-send-email-wangkefeng.wang@huawei.com>
 <56EA959C.8080005@arm.com>
Message-ID: <56EB966F.1030609@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/3/17 19:31, Suzuki K. Poulose wrote:
> On 17/03/16 10:08, Kefeng Wang wrote:
>> AArch64 support six types Physical Address range, permitted values
[...]
>> +static inline int id_aa64mmfr0_parange_bits(void)
>> +{
>> +    /*
>> +     * PARange[3:0] allows 0~5, other values are reserved,
>> +     * convert to physical address bits with a simple formula.
>> +     */
>> +    u32 parange = read_system_reg(SYS_ID_AA64MMFR0_EL1) & 0xf;
>> +
>> +    return parange < 3 ? 32 + parange * 4 : 42 + (parange - 3) * (parange - 2);
> 
> This breaks for 52bit PA support added in ARMv8.2 [1]. It may be a good idea
> to use an array here.

Thanks for your reminder, will use array.

> 
>> +}
>> +
>>   #endif /* __ASSEMBLY__ */
>>
>>   #endif
>> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
>> index 212ae63..f6b49db 100644
>> --- a/arch/arm64/kernel/cpuinfo.c
>> +++ b/arch/arm64/kernel/cpuinfo.c
>> @@ -146,7 +146,9 @@ static int c_show(struct seq_file *m, void *v)
>>           seq_printf(m, "CPU architecture: 8\n");
>>           seq_printf(m, "CPU variant\t: 0x%x\n", MIDR_VARIANT(midr));
>>           seq_printf(m, "CPU part\t: 0x%03x\n", MIDR_PARTNUM(midr));
>> -        seq_printf(m, "CPU revision\t: %d\n\n", MIDR_REVISION(midr));
>> +        seq_printf(m, "CPU revision\t: %d\n", MIDR_REVISION(midr));
>> +        seq_printf(m, "address sizes\t: %d bits physical, %d bits virtual\n\n",
>> +               id_aa64mmfr0_parange_bits(), VA_BITS);
> 
> VA_BITS is an attribute of your running kernel and doesn't have anything to do with what
> the CPU can support. (e.g, it is 48bit on 8.0, 8.1, but could go upto 52 in 8.2)

After check the new id register id_aa64mmfr2 in armv8.2, I think we can use the LVA(larger
virtual address) bit of id_aa64mmfr2 to get virtual address bits supported by cpu, what's
opinion?

BTW, is it allowed to post patch by me to add more field of id_aa64mmfr2, if not, please let
me know, thanks.

BRs,
Kefeng

> 
> [1] https://community.arm.com/groups/processors/blog/2016/01/05/armv8-a-architecture-evolution
> 
> Also, I am not sure if the change above would break userspace parsing the info. Ideally
> it shouldn't , but...
> 
> Thanks
> Suzuki
> 
> .
> 
