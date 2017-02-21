From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 21 Feb 2017 13:03:29 +0000
Subject: [PATCH 6/7] ARM: NOMMU: Set ARM_DMA_MEM_BUFFERABLE for M-class
 cpus
In-Reply-To: <63bebf6f-8dc5-7a03-ba7b-e05d83fdfce8@arm.com>
References: <1487152792-34214-1-git-send-email-vladimir.murzin@arm.com>
 <1487152792-34214-7-git-send-email-vladimir.murzin@arm.com>
 <63bebf6f-8dc5-7a03-ba7b-e05d83fdfce8@arm.com>
Message-ID: <f3af75f3-2f75-195d-eeb4-5fbe04f98573@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/02/17 12:57, Robin Murphy wrote:
> On 15/02/17 09:59, Vladimir Murzin wrote:
>> Now, we have dedicated non-cacheable region for consistent DMA
>> operations. However, that region can still be marked as bufferable by
>> MPU, so it'd be safer to have barriers by default.
> 
> Makes sense - plenty of cases want their DMA buffers to still be
> write-combining (e.g. framebuffers have already been mentioned here),
> for which strongly-ordered mappings won't do. Plus you don't exactly
> have a choice if you've no MPU and have fixed Normal attributes for your
> RAM region.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks!

Vladimir

> 
>> Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>> Tested-by: Andras Szemzo <sza@esh.hu>
>> Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> ---
>>  arch/arm/mm/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
>> index 0b79f12..64a1465c 100644
>> --- a/arch/arm/mm/Kconfig
>> +++ b/arch/arm/mm/Kconfig
>> @@ -1029,7 +1029,7 @@ config ARM_L1_CACHE_SHIFT
>>  
>>  config ARM_DMA_MEM_BUFFERABLE
>>  	bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !CPU_V7
>> -	default y if CPU_V6 || CPU_V6K || CPU_V7
>> +	default y if CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7M
>>  	help
>>  	  Historically, the kernel has used strongly ordered mappings to
>>  	  provide DMA coherent memory.  With the advent of ARMv7, mapping
>>
> 
> 
