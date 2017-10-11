From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 11 Oct 2017 12:13:05 -0700
Subject: [PATCH 00/11] KASan for arm
In-Reply-To: <20171011082227.20546-1-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
Message-ID: <26660524-3b0a-c634-e8ce-4ba7e10c055d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abbott,

On 10/11/2017 01:22 AM, Abbott Liu wrote:
> Hi,all:
>    These patches add arch specific code for kernel address sanitizer 
> (see Documentation/kasan.txt). 
> 
>    1/8 of kernel addresses reserved for shadow memory. There was no 
> big enough hole for this, so virtual addresses for shadow were 
> stolen from user space.
>    
>    At early boot stage the whole shadow region populated with just 
> one physical page (kasan_zero_page). Later, this page reused 
> as readonly zero shadow for some memory that KASan currently 
> don't track (vmalloc). 
> 
>   After mapping the physical memory, pages for shadow memory are 
> allocated and mapped. 
> 
>   KASan's stack instrumentation significantly increases stack's 
> consumption, so CONFIG_KASAN doubles THREAD_SIZE.
>   
>   Functions like memset/memmove/memcpy do a lot of memory accesses. 
> If bad pointer passed to one of these function it is important 
> to catch this. Compiler's instrumentation cannot do this since 
> these functions are written in assembly. 
> 
>   KASan replaces memory functions with manually instrumented variants. 
> Original functions declared as weak symbols so strong definitions 
> in mm/kasan/kasan.c could replace them. Original functions have aliases 
> with '__' prefix in name, so we could call non-instrumented variant 
> if needed. 
> 
>   Some files built without kasan instrumentation (e.g. mm/slub.c). 
> Original mem* function replaced (via #define) with prefixed variants 
> to disable memory access checks for such files. 
> 
>   On arm LPAE architecture,  the mapping table of KASan shadow memory(if 
> PAGE_OFFSET is 0xc0000000, the KASan shadow memory's virtual space is 
> 0xb6e000000~0xbf000000) can't be filled in do_translation_fault function, 
> because kasan instrumentation maybe cause do_translation_fault function 
> accessing KASan shadow memory. The accessing of KASan shadow memory in 
> do_translation_fault function maybe cause dead circle. So the mapping table 
> of KASan shadow memory need be copyed in pgd_alloc function.
> 
> 
> Most of the code comes from:
> https://github.com/aryabinin/linux/commit/0b54f17e70ff50a902c4af05bb92716eb95acefe.

Thanks for putting these patches together, I can't get a kernel to build
with ARM_LPAE=y or ARM_LPAE=n that does not result in the following:

  AS      arch/arm/kernel/entry-common.o
arch/arm/kernel/entry-common.S: Assembler messages:
arch/arm/kernel/entry-common.S:53: Error: invalid constant
(ffffffffb6e00000) after fixup
arch/arm/kernel/entry-common.S:118: Error: invalid constant
(ffffffffb6e00000) after fixup
scripts/Makefile.build:412: recipe for target
'arch/arm/kernel/entry-common.o' failed
make[3]: *** [arch/arm/kernel/entry-common.o] Error 1
Makefile:1019: recipe for target 'arch/arm/kernel' failed
make[2]: *** [arch/arm/kernel] Error 2
make[2]: *** Waiting for unfinished jobs....

This is coming from the increase in TASK_SIZE it seems.

This is on top of v4.14-rc4-84-gff5abbe799e2

Thank you

> 
> These patches are tested on vexpress-ca15, vexpress-ca9
> 
> Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
> Tested-by: Abbott Liu <liuwenliang@huawei.com>
> Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
> 
> Abbott Liu (6):
>   Define the virtual space of KASan's shadow region
>   change memory_is_poisoned_16 for aligned error
>   Add support arm LPAE
>   Don't need to map the shadow of KASan's shadow memory
>   Change mapping of kasan_zero_page int readonly
>   Add KASan layout
> 
> Andrey Ryabinin (5):
>   Initialize the mapping of KASan shadow memory
>   replace memory function
>   arm: Kconfig: enable KASan
>   Disable kasan's instrumentation
>   Avoid cleaning the KASan shadow area's mapping table
> 
>  arch/arm/Kconfig                   |   1 +
>  arch/arm/boot/compressed/Makefile  |   1 +
>  arch/arm/include/asm/kasan.h       |  20 +++
>  arch/arm/include/asm/kasan_def.h   |  51 +++++++
>  arch/arm/include/asm/memory.h      |   5 +
>  arch/arm/include/asm/pgalloc.h     |   5 +-
>  arch/arm/include/asm/pgtable.h     |   1 +
>  arch/arm/include/asm/proc-fns.h    |  33 +++++
>  arch/arm/include/asm/string.h      |  18 ++-
>  arch/arm/include/asm/thread_info.h |   4 +
>  arch/arm/kernel/entry-armv.S       |   7 +-
>  arch/arm/kernel/head-common.S      |   4 +
>  arch/arm/kernel/setup.c            |   2 +
>  arch/arm/kernel/unwind.c           |   3 +-
>  arch/arm/lib/memcpy.S              |   3 +
>  arch/arm/lib/memmove.S             |   5 +-
>  arch/arm/lib/memset.S              |   3 +
>  arch/arm/mm/Makefile               |   5 +
>  arch/arm/mm/init.c                 |   6 +
>  arch/arm/mm/kasan_init.c           | 265 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mm/mmu.c                  |   7 +-
>  arch/arm/mm/pgd.c                  |  12 ++
>  arch/arm/vdso/Makefile             |   2 +
>  mm/kasan/kasan.c                   |  22 ++-
>  24 files changed, 478 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/include/asm/kasan.h
>  create mode 100644 arch/arm/include/asm/kasan_def.h
>  create mode 100644 arch/arm/mm/kasan_init.c
> 


-- 
Florian
