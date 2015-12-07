From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Dec 2015 16:43:57 +0000
Subject: [PATCH v3 7/7] arm64: allow kernel Image to be loaded anywhere
 in physical memory
In-Reply-To: <CAKv+Gu_azSnKUtuC5GgWyvEDznqGP4HR3WpUfA58BfPnFijg4A@mail.gmail.com>
References: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447672998-20981-8-git-send-email-ard.biesheuvel@linaro.org>
 <20151207153012.GB7083@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_azSnKUtuC5GgWyvEDznqGP4HR3WpUfA58BfPnFijg4A@mail.gmail.com>
Message-ID: <20151207164356.GG7083@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 04:40:20PM +0100, Ard Biesheuvel wrote:
> On 7 December 2015 at 16:30, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Nov 16, 2015 at 12:23:18PM +0100, Ard Biesheuvel wrote:
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index b3b0175d7135..29a7dc5327b6 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -158,9 +159,55 @@ static int __init early_mem(char *p)
> >>  }
> >>  early_param("mem", early_mem);
> >>
> >> +static void __init enforce_memory_limit(void)
> >> +{
> >> +     const phys_addr_t kbase = round_down(__pa(_text), MIN_KIMG_ALIGN);
> >> +     u64 to_remove = memblock_phys_mem_size() - memory_limit;
> >> +     phys_addr_t max_addr = 0;
> >> +     struct memblock_region *r;
> >> +
> >> +     if (memory_limit == (phys_addr_t)ULLONG_MAX)
> >> +             return;
> >> +
> >> +     /*
> >> +      * The kernel may be high up in physical memory, so try to apply the
> >> +      * limit below the kernel first, and only let the generic handling
> >> +      * take over if it turns out we haven't clipped enough memory yet.
> >> +      */
> >> +     for_each_memblock(memory, r) {
> >> +             if (r->base + r->size > kbase) {
> >> +                     u64 rem = min(to_remove, kbase - r->base);
> >> +
> >> +                     max_addr = r->base + rem;
> >> +                     to_remove -= rem;
> >> +                     break;
> >> +             }
> >> +             if (to_remove <= r->size) {
> >> +                     max_addr = r->base + to_remove;
> >> +                     to_remove = 0;
> >> +                     break;
> >> +             }
> >> +             to_remove -= r->size;
> >> +     }
> >> +
> >> +     memblock_remove(0, max_addr);
> >
> > I don't fully get the reason for this function. Do you want to keep the
> > kernel around in memblock? How do we guarantee that the call below
> > wouldn't remove it anyway?
> 
> The problem is that the ordinary memblock_enforce_memory_limit()
> removes memory from the top, which means it will happily remove the
> memory that covers your kernel image if it happens to be loaded high
> up in physical memory.

We could fix the memblock_reserve() call on the kernel image but apart
from that we don't care about memblock's knowledge of the kernel text. A
potential problem is freeing the init memory which assumes it's present
in the linear mapping, though we could add additional checks here as
well. Is memblock_end_of_DRAM() adjusted to the new maximum address
after memblock_enforce_memory_limit()?

> >> +
> >> +     if (to_remove)
> >> +             memblock_enforce_memory_limit(memory_limit);
> >
> > Shouldn't this be memblock_enforce_memory_limit(to_remove)?
> 
> No, it takes the memory limit as input. 'to_remove + memory_limit'
> will be exactly the remaining memory at this point.

You are right, I thought it's the memory to remove.

-- 
Catalin
