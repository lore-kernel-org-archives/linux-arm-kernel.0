From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Aug 2015 11:53:12 +0100
Subject: [PATCH] arm64: ignore memory outside of the linear range
In-Reply-To: <CAKv+Gu8yspV+QtDP=iAas5J99+PezmXgC1_keEKO3zGeziRi6A@mail.gmail.com>
References: <1439640824-30498-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150817094307.GD1688@arm.com>
 <CAKv+Gu8yspV+QtDP=iAas5J99+PezmXgC1_keEKO3zGeziRi6A@mail.gmail.com>
Message-ID: <20150817105311.GF1688@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 17, 2015 at 11:35:46AM +0100, Ard Biesheuvel wrote:
> On 17 August 2015 at 11:43, Will Deacon <will.deacon@arm.com> wrote:
> > Hi Ard,
> >
> > On Sat, Aug 15, 2015 at 01:13:44PM +0100, Ard Biesheuvel wrote:
> >> We need to ensure that we don't try to map system RAM ranges whose
> >> offset relative to the start of the kernel image exceeds the size of
> >> the linear range. This may happen even on systems that don't have
> >> huge amounts of RAM if it is laid out very sparsely.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>
> >> This is the minimal fix for addressing the issue we discussed. I dropped
> >> the other changes for now, let's revisit those when (if) my patches for
> >> decoupling the kernel mapping from the linear mapping are back under
> >> discussion.
> >>
> >> I will leave it up to the maintainers whether this constitutes a bugfix or
> >> not, but since this has never worked from the beginning afaict, I don't
> >> think it belongs in stable per se.
> >>
> >>  arch/arm64/mm/init.c | 13 +++++++++++++
> >>  1 file changed, 13 insertions(+)
> >>
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index ad87ce826cce..c65e57d4c3e7 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -158,6 +158,19 @@ early_param("mem", early_mem);
> >>
> >>  void __init arm64_memblock_init(void)
> >>  {
> >> +     /*
> >> +      * Remove the memory that we will not be able to cover
> >> +      * with the linear mapping.
> >> +      */
> >> +     const s64 linear_region_size = -(s64)PAGE_OFFSET;
> >> +
> >> +     if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {
> >> +             pr_warn("Ignoring memory outside of linear range (0x%012llx - 0x%012llx)\n",
> >> +                     memstart_addr + linear_region_size,
> >> +                     (u64)memblock_end_of_DRAM() - 1);
> >> +             memblock_remove(memstart_addr + linear_region_size, ULLONG_MAX);
> >> +     }
> >> +
> >
> > I think this will interact badly with Mark Salter's patches to relocate
> > the initrd if it falls outside of the linear mapping (which relies on the
> > memblocks remaining intact after paging_init):
> >
> >   https://lkml.org/lkml/2015/8/16/75
> >
> 
> Are you sure? By the looks of it, these patches combined would
> correctly address the case where no mem= is passed, but the initial
> ramdisk is loaded past the end of the linear region.
> 
> I.e., memblock_end_of_DRAM() will return the clipped value, which
> would be smaller than orig_end, triggering the relocation machinery
> which moves it inside the linear region.

Ok. I was trying to consider the case where the initrd is outside of the
linear mapping not because of a restrictive "mem=", but because its out
of range of our page tables. AFAICT, we'll end up attempting to memcpy
the thing back down (but I appreciate that things won't work without
your patch too).

Will
