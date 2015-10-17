From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sat, 17 Oct 2015 22:38:16 +0900
Subject: [PATCH v4 2/2] arm64: Expand the stack trace feature to support
 IRQ stack
In-Reply-To: <20151016160606.GE6613@e104818-lin.cambridge.arm.com>
References: <1444231692-32722-3-git-send-email-jungseoklee85@gmail.com>
 <5617CE26.10604@arm.com> <07A53E87-C562-48D1-86DF-A373EAAA73F9@gmail.com>
 <561BE111.7@arm.com> <3CAA206D-3A3A-49A9-BDAD-4206D6F9BAA8@gmail.com>
 <561CE454.7080201@arm.com> <04D64B22-8EF5-400E-A7F0-1CD0AB48184D@gmail.com>
 <B6AB90B9-3AA9-413A-B357-137710E89C7C@gmail.com> <561FCD59.1090600@arm.com>
 <6E0DDC4D-9A97-4EAE-868C-B1271F02D3E0@gmail.com>
 <20151016160606.GE6613@e104818-lin.cambridge.arm.com>
Message-ID: <3AD5938C-4109-4B95-A13B-5D45525B39FB@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 17, 2015, at 1:06 AM, Catalin Marinas wrote:

Hi Catalin,

> On Fri, Oct 16, 2015 at 10:01:20PM +0900, Jungseok Lee wrote:
>> On Oct 16, 2015, at 12:59 AM, James Morse wrote:
>>> My concern is there could be push-back from the maintainer of
>>> kernel/fork.c, saying "define CONFIG_ARCH_THREAD_INFO_ALLOCATOR if the
>>> generic code isn't what you need", and push-back from the arm64 maintainers
>>> about copy-pasting that chunk into arch/arm64.... both of which are fair,
>>> hence my initial version created a second kmem_cache.
>> 
>> Same concern. I believe now is the time to get feedbacks from maintainers.
>> It will help us to decide the next step.
> 
> I'll push back now to avoid further doubts in changing kernel/fork.c ;).

Thanks a lot!

> A reason to define a kmem_cache is performance for repeated allocations.
> But here you only do it once during boot. So you could simply use
> kmalloc() when THREAD_SIZE < PAGE_SIZE. BTW, the IRQ stack size doesn't
> even need to be the same as THREAD_SIZE, though we could initially keep
> them the same. But it's worth defining an IRQ_STACK_SIZE macro if we
> ever need to change it.

I will update the series using IRQ_* macro.

> BTW, a static allocation (DEFINE_PER_CPU for the whole irq stack) would
> save us from another stack address reading on the IRQ entry path. I'm
> not sure exactly where the 16K image increase comes from but at least it
> doesn't grow with NR_CPUS, so we can probably live with this.

I've tried the approach, a static allocation using DEFINE_PER_CPU, but
it dose not work on a top-bit comparison method (for IRQ re-entrance
check). The top-bit idea is based on the assumption that IRQ stack is
aligned with THREAD_SIZE. But, tpidr_el1 is PAGE_SIZE aligned. It leads
to IRQ re-entrance failure in case of 4KB page system.

IMHO, it is hard to avoid 16KB size increase for 64KB page support.
Secondary cores can rely on slab.h, but a boot core cannot. So, IRQ
stack for at least a boot cpu should be allocated statically.

Best Regards
Jungseok Lee
