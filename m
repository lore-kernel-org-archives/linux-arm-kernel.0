From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 13 Feb 2018 10:40:38 -0800
Subject: [PATCH 00/11] KASan for arm
In-Reply-To: <20171011082227.20546-1-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
Message-ID: <09f86876-2247-1d2c-b195-76d8b34d0aff@gmail.com>
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

Are you planning on picking up these patches and sending a second
version? I would be more than happy to provide test results once you
have something, this is very useful, thank you!
-- 
Florian
