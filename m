From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 6 Sep 2016 13:42:18 +0100
Subject: [PATCH v2 4/7] ARM: update MPIDR accessors macro
In-Reply-To: <20160905112909.GI26366@cbox>
References: <1471344418-19568-1-git-send-email-vladimir.murzin@arm.com>
 <1471344418-19568-5-git-send-email-vladimir.murzin@arm.com>
 <20160905112909.GI26366@cbox>
Message-ID: <57CEB9AA.6080109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/16 12:29, Christoffer Dall wrote:
> The title of this patch is quite generic, especially the 'update'.
> Perhaps say: 
> 
> "ARM: Change MPIDR_AFFINITY_LEVEL to ignore Aff3"
> 

Fixed.

> On Tue, Aug 16, 2016 at 11:46:55AM +0100, Vladimir Murzin wrote:
>> vgic-v3 driver queries CPU affinity level up to Aff3, which is valid for arm64.
>> However, for arm up to Aff2 levels are supported, so querying for 3rd level
>> ends with upper bits of MPIDR are treated as valid affinity level which
>> is not true. So, report zero for any affinity level above 2.
>>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> ---
>>  arch/arm/include/asm/cputype.h |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
>> index 1ee94c7..96cef49 100644
>> --- a/arch/arm/include/asm/cputype.h
>> +++ b/arch/arm/include/asm/cputype.h
>> @@ -55,9 +55,10 @@
>>  
>>  #define MPIDR_LEVEL_BITS 8
>>  #define MPIDR_LEVEL_MASK ((1 << MPIDR_LEVEL_BITS) - 1)
>> +#define MPIDR_LEVEL_SHIFT(level) (MPIDR_LEVEL_BITS * level)
>>  
>>  #define MPIDR_AFFINITY_LEVEL(mpidr, level) \
>> -	((mpidr >> (MPIDR_LEVEL_BITS * level)) & MPIDR_LEVEL_MASK)
>> +	((level < 3) ? ((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK) : 0)
> 
> Instead of using a conditional here, you could just apply the
> MPIDR_HWID_BITMASK to the mpidr argument instead.
> 

Fixed.

Thanks
Vladimir

>>  
>>  #define ARM_CPU_IMP_ARM			0x41
>>  #define ARM_CPU_IMP_INTEL		0x69
>> -- 
>> 1.7.9.5
>>
> 
> 
