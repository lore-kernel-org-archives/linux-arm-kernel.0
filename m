From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 22 Nov 2016 13:36:57 +0000
Subject: [RFC PATCH 06/11] ARM: tlbflush: drop dependency on CONFIG_SMP
In-Reply-To: <20161122100345.GV1041@n2100.armlinux.org.uk>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-7-git-send-email-vladimir.murzin@arm.com>
 <20161122100345.GV1041@n2100.armlinux.org.uk>
Message-ID: <583449F9.6060804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/11/16 10:03, Russell King - ARM Linux wrote:
> On Tue, Nov 22, 2016 at 09:26:03AM +0000, Vladimir Murzin wrote:
>> It can be referenced in UP case as well.
> 
> What's missing is an explanation of why you want this change.
> Exposing the local_* stuff doesn't make sense for UP.

It comes from:

arch/arm/mach-mvebu/pmsu.c: In function 'armada_370_xp_pmsu_idle_enter':
arch/arm/mach-mvebu/pmsu.c:291:2: error: implicit declaration of function 'local_flush_tlb_all' [-Werror=implicit-function-declaration]
  local_flush_tlb_all();
  ^

make[1]: *** [arch/arm/mach-mvebu/pmsu.o] Error 1

and

arch/arm/mach-imx/pm-imx5.c: In function 'mx5_suspend_enter':
arch/arm/mach-imx/pm-imx5.c:227:3: error: implicit declaration of function 'local_flush_tlb_all' [-Werror=implicit-function-declaration]

   local_flush_tlb_all();
   ^
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/mach-imx/pm-imx5.o] Error 1

Maybe there are other users, please, let me know if you want me to count them
all.

Cheers
Vladimir

> 
>> Cc: Russell King <linux@armlinux.org.uk>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> ---
>>  arch/arm/include/asm/tlbflush.h |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
>> index def9e57..d9a6e2e 100644
>> --- a/arch/arm/include/asm/tlbflush.h
>> +++ b/arch/arm/include/asm/tlbflush.h
>> @@ -641,7 +641,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>>  
>>  #endif
>>  
>> -#elif defined(CONFIG_SMP)	/* !CONFIG_MMU */
>> +#else /* !CONFIG_MMU */
>>  
>>  #ifndef __ASSEMBLY__
>>  
>> -- 
>> 1.7.9.5
>>
> 
