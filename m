From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 6 Jan 2016 15:23:51 +0100
Subject: [PATCHv2 00/18] arm64: mm: rework page table creation
In-Reply-To: <20160106113637.GD563@leverpostej>
References: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
 <20160106102448.GI6301@e104818-lin.cambridge.arm.com>
 <20160106113637.GD563@leverpostej>
Message-ID: <CAKv+Gu8xYgHGHGdohNZydhAnY+DGo+xjEAqajD6witbehrn7pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 January 2016 at 12:36, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Jan 06, 2016 at 10:24:49AM +0000, Catalin Marinas wrote:
>> On Mon, Jan 04, 2016 at 05:56:33PM +0000, Mark Rutland wrote:
>> > Mark Rutland (18):
>> >   asm-generic: make __set_fixmap_offset a static inline
>> >   arm64: mm: specialise pagetable allocators
>> >   arm64: mm: place empty_zero_page in bss
>> >   arm64: unify idmap removal
>> >   arm64: unmap idmap earlier
>> >   arm64: add function to install the idmap
>> >   arm64: mm: add code to safely replace TTBR1_EL1
>> >   arm64: kasan: avoid TLB conflicts
>> >   arm64: mm: move pte_* macros
>> >   arm64: mm: add functions to walk page tables by PA
>> >   arm64: mm: avoid redundant __pa(__va(x))
>> >   arm64: mm: add __{pud,pgd}_populate
>> >   arm64: mm: add functions to walk tables in fixmap
>> >   arm64: mm: use fixmap when creating page tables
>> >   arm64: mm: allocate pagetables anywhere
>> >   arm64: mm: allow passing a pgdir to alloc_init_*
>> >   arm64: ensure _stext and _etext are page-aligned
>> >   arm64: mm: create new fine-grained mappings at boot
>>
>> The patches look fine (once you fix the issues Laura raised). Thanks for
>> putting them together.
>>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
> Thanks!
>
> I assume that applies to everything even without the suggested
> split_{pmd,pud} removal [1], for which I'll cook up a follow-up patch.
>
>> I'll queue them sometime after -rc1, in the meantime keep you branch up
>> to date so that Ard and Jeremy can base their patches on top.
>
> Will do.
>
> FWIW I've just updated the branch [2] with said fixes and your
> Reviewed-by. I won't send out a v3 just yet to give people time to
> digest this version.
>
> Ard, you'll find when rebasing that the compiler will scream at you due
> to the p??_fixmap* function renaming. It's fairly mechanical, and if you
> have vim handy you just need to run:
>
> :%s /\(pgd\|pud\|pmd\|pte\)_fixmap_unmap/\1_clear_fixmap/g
> :%s /\(pgd\|pud\|pmd\|pte\)_fixmap/\1_set_fixmap/g
>

Thanks. That went without a hitch, in fact. I don't actually call any
of these in the KASLR code, just the p??_offset_phys() accessors.

FYI I pushed my latest here

https://git.linaro.org/people/ard.biesheuvel/linux-arm.git/shortlog/refs/heads/arm64-kaslr-v3
git://git.linaro.org/people/ard.biesheuvel/linux-arm.git arm64-kaslr-v3

I'll probably hold off from [rebasing and] sending out my v3 until
your stuff hits post-rc1

-- 
Ard.
