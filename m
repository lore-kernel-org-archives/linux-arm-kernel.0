From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Oct 2015 17:06:06 +0100
Subject: [PATCH v4 2/2] arm64: Expand the stack trace feature to support
 IRQ stack
In-Reply-To: <6E0DDC4D-9A97-4EAE-868C-B1271F02D3E0@gmail.com>
References: <1444231692-32722-3-git-send-email-jungseoklee85@gmail.com>
 <5617CE26.10604@arm.com>
 <07A53E87-C562-48D1-86DF-A373EAAA73F9@gmail.com>
 <561BE111.7@arm.com>
 <3CAA206D-3A3A-49A9-BDAD-4206D6F9BAA8@gmail.com>
 <561CE454.7080201@arm.com>
 <04D64B22-8EF5-400E-A7F0-1CD0AB48184D@gmail.com>
 <B6AB90B9-3AA9-413A-B357-137710E89C7C@gmail.com>
 <561FCD59.1090600@arm.com>
 <6E0DDC4D-9A97-4EAE-868C-B1271F02D3E0@gmail.com>
Message-ID: <20151016160606.GE6613@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2015 at 10:01:20PM +0900, Jungseok Lee wrote:
> On Oct 16, 2015, at 12:59 AM, James Morse wrote:
> > My concern is there could be push-back from the maintainer of
> > kernel/fork.c, saying "define CONFIG_ARCH_THREAD_INFO_ALLOCATOR if the
> > generic code isn't what you need", and push-back from the arm64 maintainers
> > about copy-pasting that chunk into arch/arm64.... both of which are fair,
> > hence my initial version created a second kmem_cache.
> 
> Same concern. I believe now is the time to get feedbacks from maintainers.
> It will help us to decide the next step.

I'll push back now to avoid further doubts in changing kernel/fork.c ;).

A reason to define a kmem_cache is performance for repeated allocations.
But here you only do it once during boot. So you could simply use
kmalloc() when THREAD_SIZE < PAGE_SIZE. BTW, the IRQ stack size doesn't
even need to be the same as THREAD_SIZE, though we could initially keep
them the same. But it's worth defining an IRQ_STACK_SIZE macro if we
ever need to change it.

BTW, a static allocation (DEFINE_PER_CPU for the whole irq stack) would
save us from another stack address reading on the IRQ entry path. I'm
not sure exactly where the 16K image increase comes from but@least it
doesn't grow with NR_CPUS, so we can probably live with this.

-- 
Catalin
