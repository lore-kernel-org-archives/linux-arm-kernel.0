From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 7 Oct 2015 11:23:04 +0100
Subject: [PATCH 11/15] arm64: Cleanup VTCR_EL2 computation
In-Reply-To: <5614EFD0.20709@arm.com>
References: <1442331684-28818-1-git-send-email-suzuki.poulose@arm.com>
 <1442331684-28818-12-git-send-email-suzuki.poulose@arm.com>
 <5614EFD0.20709@arm.com>
Message-ID: <5614F288.6000901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/15 11:11, Marc Zyngier wrote:
> On 15/09/15 16:41, Suzuki K. Poulose wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>

>> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
>> index bdf139e..699554d 100644
>> --- a/arch/arm64/include/asm/kvm_arm.h
>> +++ b/arch/arm64/include/asm/kvm_arm.h
>> @@ -138,6 +138,9 @@
>>    * The magic numbers used for VTTBR_X in this patch can be found in Tables
>>    * D4-23 and D4-25 in ARM DDI 0487A.b.
>>    */
>> +#define VTCR_EL2_COMMON_BITS	(VTCR_EL2_SH0_INNER | VTCR_EL2_ORGN0_WBWA | \
>> +				 VTCR_EL2_IRGN0_WBWA | VTCR_EL2_T0SZ_40B)
>> +
>>   #ifdef CONFIG_ARM64_64K_PAGES
>>   /*
>>    * Stage2 translation configuration:
>> @@ -145,9 +148,8 @@
>>    * 64kB pages (TG0 = 1)
>>    * 2 level page tables (SL = 1)
>>    */
>> -#define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SH0_INNER | \
>> -				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
>> -				 VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B)
>> +#define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SL0_LVL1 | \
>> +				 VTCR_EL2_COMMON_BITS)
>>   #define VTTBR_X		(38 - VTCR_EL2_T0SZ_40B)
>>   #else
>>   /*
>> @@ -156,9 +158,8 @@
>>    * 4kB pages (TG0 = 0)
>>    * 3 level page tables (SL = 1)
>>    */
>> -#define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SH0_INNER | \
>> -				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
>> -				 VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B)
>> +#define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SL0_LVL1 | \
>> +				 VTCR_EL2_COMMON_BITS)
>>   #define VTTBR_X		(37 - VTCR_EL2_T0SZ_40B)
>>   #endif
>>
>>
>
> This looks OK, but is going to clash badly with 857d1a9 ("arm64: KVM:
> set {v,}TCR_EL2 RES1 bits"). Nothing we can't fix though.
>

As discussed, I will rebase my series on top of 4.3-rc4 to avoid this.

Thanks
Suzuki
