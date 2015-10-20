From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Tue, 20 Oct 2015 22:13:39 +0900
Subject: [PATCH v5] arm64: Introduce IRQ stack
In-Reply-To: <562493C1.1080805@linaro.org>
References: <1445092053-12319-1-git-send-email-jungseoklee85@gmail.com>
 <562493C1.1080805@linaro.org>
Message-ID: <FA416ED5-40F5-4A08-A1DB-13EC90A52037@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 19, 2015, at 3:54 PM, AKASHI Takahiro wrote:

Hi Akashi,

> On 10/17/2015 11:27 PM, Jungseok Lee wrote:
>> Currently, kernel context and interrupts are handled using a single
>> kernel stack navigated by sp_el1. This forces a system to use 16KB
>> stack, not 8KB one. This restriction makes low memory platforms
>> suffer from memory pressure accompanied by performance degradation.
>> 
>> This patch addresses the issue as introducing a separate percpu IRQ
>> stack to handle both hard and soft interrupts with two ground rules:
>> 
>>   - Utilize sp_el0 in EL1 context, which is not used currently
>>   - Do not complicate current_thread_info calculation
>> 
>> It is a core concept to directly retrieve struct thread_info from
>> sp_el0. This approach helps to prevent text section size from being
>> increased largely as removing masking operation using THREAD_SIZE
>> in tons of places.
>> 
>> [Thanks to James Morse for his valuable feedbacks which greatly help
>> to figure out a better implementation. - Jungseok]
>> 
>> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Cc: James Morse <james.morse@arm.com>
>> Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
>> ---
>> I've used Cc', not Tested-by tag, from James, since there is a gap
>> between v4 and v5.
>> 
>> Changes since v4:
>> - Supported 64KB page system
>> - Introduced IRQ_STACK_* macro, per Catalin
>> - Rebased on top of for-next/core
>> 
>> Changes since v3:
>> - Expanded stack trace to support IRQ stack
>> - Added more comments
>> 
>> Changes since v2:
>> - Optmised current_thread_info function as removing masking operation
>>   and volatile keyword, per James and Catalin
>> - Reworked irq re-enterance check logic using top-bit comparison of
>>   stacks, per James
>> - Added sp_el0 update in cpu_resume, per James
>> - Selected HAVE_IRQ_EXIT_ON_IRQ_STACK to expose this feature explicitly
>> - Added a Tested-by tag from James
>> - Added comments on sp_el0 as a helper messeage
>> 
>> Changes since v1:
>> - Rebased on top of v4.3-rc1
>> - Removed Kconfig about IRQ stack, per James
>> - Used PERCPU for IRQ stack, per James
>> - Tried to allocate IRQ stack when CPU is about to start up, per James
>> - Moved sp_el0 update into kernel_entry macro, per James
>> - Dropped S_SP removal patch, per Mark and James
>> 
>>  arch/arm64/Kconfig                   |  1 +
>>  arch/arm64/include/asm/irq.h         | 27 ++++++++++
>>  arch/arm64/include/asm/thread_info.h | 10 +++-
>>  arch/arm64/kernel/entry.S            | 42 ++++++++++++++--
>>  arch/arm64/kernel/head.S             |  5 ++
>>  arch/arm64/kernel/irq.c              | 24 +++++++++
>>  arch/arm64/kernel/sleep.S            |  3 ++
>>  arch/arm64/kernel/smp.c              | 13 ++++-
>>  8 files changed, 116 insertions(+), 9 deletions(-)
>> 
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 2782c11..3855fd2 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -69,6 +69,7 @@ config ARM64
>>  	select HAVE_FUNCTION_GRAPH_TRACER
>>  	select HAVE_GENERIC_DMA_COHERENT
>>  	select HAVE_HW_BREAKPOINT if PERF_EVENTS
>> +	select HAVE_IRQ_EXIT_ON_IRQ_STACK
>>  	select HAVE_MEMBLOCK
>>  	select HAVE_PATA_PLATFORM
>>  	select HAVE_PERF_EVENTS
>> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
>> index 0916929..2755b2f 100644
>> --- a/arch/arm64/include/asm/irq.h
>> +++ b/arch/arm64/include/asm/irq.h
>> @@ -1,14 +1,40 @@
>>  #ifndef __ASM_IRQ_H
>>  #define __ASM_IRQ_H
>> 
>> +#ifndef CONFIG_ARM64_64K_PAGES
>> +#define IRQ_STACK_SIZE_ORDER	2
>> +#endif
>> +
>> +#define IRQ_STACK_SIZE		16384
>> +#define IRQ_STACK_START_SP	(IRQ_STACK_SIZE - 16)
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#include <linux/gfp.h>
>>  #include <linux/irqchip/arm-gic-acpi.h>
>> +#include <linux/slab.h>
>> 
>>  #include <asm-generic/irq.h>
>> 
>> +#if IRQ_STACK_SIZE >= PAGE_SIZE
>> +static inline void *__alloc_irq_stack(void)
>> +{
>> +       return (void *)__get_free_pages(THREADINFO_GFP | __GFP_ZERO,
>> +                                       IRQ_STACK_SIZE_ORDER);
>> +}
>> +#else
>> +static inline void *__alloc_irq_stack(void)
>> +{
>> +       return kmalloc(IRQ_STACK_SIZE, THREADINFO_GFP | __GFP_ZERO);
>> +}
>> +#endif
>> +
> 
> Spaces are at the beginning of lines.
> and it seems that this patch cannot be cleanly applied.

!!! I will fix it.

Best Regards
Jungseok Lee
