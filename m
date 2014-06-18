From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Wed, 18 Jun 2014 19:27:20 +0400
Subject: [PATCH] arm: get rid of hardcoded assumptions about kernel stack
 size
In-Reply-To: <alpine.LFD.2.11.1406181039310.16842@knanqh.ubzr>
References: <1403099422-850-1-git-send-email-a.ryabinin@samsung.com>
 <alpine.LFD.2.11.1406181039310.16842@knanqh.ubzr>
Message-ID: <53A1AFD8.1080808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/14 18:40, Nicolas Pitre wrote:
> On Wed, 18 Jun 2014, Andrey Ryabinin wrote:
> 
>> Changing kernel stack size on arm is not as simple as it should be:
>> 1) THRED_SIZE macro doen't respect PAGE_SIZE and THREAD_SIZE_ORDER
>> 2) stack size is hardcoded in get_thread_info macro
>>
>> This patch fixes it by caculating THREAD_SIZE and thread_info address
>> taking into account PAGE_SIZE and THREAD_SIZE_ORDER.
>>
>> Now changing stack size becomes simply changing THREAD_SIZE_ORDER.
>>
>> Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> 

Thanks. Patch with fixes in commit message pushed to Russel's patch tracking system, #8078/1.
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8078/1


>> ---
>>  arch/arm/include/asm/assembler.h   | 8 +++++---
>>  arch/arm/include/asm/thread_info.h | 3 ++-
>>  2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
>> index 57f0584..906703a 100644
>> --- a/arch/arm/include/asm/assembler.h
>> +++ b/arch/arm/include/asm/assembler.h
>> @@ -24,6 +24,8 @@
>>  #include <asm/domain.h>
>>  #include <asm/opcodes-virt.h>
>>  #include <asm/asm-offsets.h>
>> +#include <asm/page.h>
>> +#include <asm/thread_info.h>
>>  
>>  #define IOMEM(x)	(x)
>>  
>> @@ -179,10 +181,10 @@
>>   * Get current thread_info.
>>   */
>>  	.macro	get_thread_info, rd
>> - ARM(	mov	\rd, sp, lsr #13	)
>> + ARM(	mov	\rd, sp, lsr #THREAD_SIZE_ORDER + PAGE_SHIFT	)
>>   THUMB(	mov	\rd, sp			)
>> - THUMB(	lsr	\rd, \rd, #13		)
>> -	mov	\rd, \rd, lsl #13
>> + THUMB(	lsr	\rd, \rd, #THREAD_SIZE_ORDER + PAGE_SHIFT	)
>> +	mov	\rd, \rd, lsl #THREAD_SIZE_ORDER + PAGE_SHIFT
>>  	.endm
>>  
>>  /*
>> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
>> index f989d7c..f85d2b0 100644
>> --- a/arch/arm/include/asm/thread_info.h
>> +++ b/arch/arm/include/asm/thread_info.h
>> @@ -14,9 +14,10 @@
>>  
>>  #include <linux/compiler.h>
>>  #include <asm/fpstate.h>
>> +#include <asm/page.h>
>>  
>>  #define THREAD_SIZE_ORDER	1
>> -#define THREAD_SIZE		8192
>> +#define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
>>  #define THREAD_START_SP		(THREAD_SIZE - 8)
>>  
>>  #ifndef __ASSEMBLY__
>> -- 
>> 1.8.5.5
>>
> 
