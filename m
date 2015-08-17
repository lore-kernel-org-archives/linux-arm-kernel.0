From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Aug 2015 12:11:30 +0100
Subject: [PATCH] arm64: ignore memory outside of the linear range
In-Reply-To: <CAKv+Gu__o9ZFyx_nnQWm2zfacVvN7B6W-DUhLqfW8xrMeFJp_Q@mail.gmail.com>
References: <1439640824-30498-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150817094307.GD1688@arm.com>
 <CAKv+Gu8yspV+QtDP=iAas5J99+PezmXgC1_keEKO3zGeziRi6A@mail.gmail.com>
 <20150817105311.GF1688@arm.com>
 <CAKv+Gu__o9ZFyx_nnQWm2zfacVvN7B6W-DUhLqfW8xrMeFJp_Q@mail.gmail.com>
Message-ID: <20150817111130.GG1688@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 17, 2015 at 11:55:33AM +0100, Ard Biesheuvel wrote:
> On 17 August 2015 at 12:53, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Aug 17, 2015 at 11:35:46AM +0100, Ard Biesheuvel wrote:
> >> On 17 August 2015 at 11:43, Will Deacon <will.deacon@arm.com> wrote:
> >> > On Sat, Aug 15, 2015 at 01:13:44PM +0100, Ard Biesheuvel wrote:
> >> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> >> index ad87ce826cce..c65e57d4c3e7 100644
> >> >> --- a/arch/arm64/mm/init.c
> >> >> +++ b/arch/arm64/mm/init.c
> >> >> @@ -158,6 +158,19 @@ early_param("mem", early_mem);
> >> >>
> >> >>  void __init arm64_memblock_init(void)
> >> >>  {
> >> >> +     /*
> >> >> +      * Remove the memory that we will not be able to cover
> >> >> +      * with the linear mapping.
> >> >> +      */
> >> >> +     const s64 linear_region_size = -(s64)PAGE_OFFSET;
> >> >> +
> >> >> +     if (memstart_addr + linear_region_size < memblock_end_of_DRAM()) {
> >> >> +             pr_warn("Ignoring memory outside of linear range (0x%012llx - 0x%012llx)\n",
> >> >> +                     memstart_addr + linear_region_size,
> >> >> +                     (u64)memblock_end_of_DRAM() - 1);
> >> >> +             memblock_remove(memstart_addr + linear_region_size, ULLONG_MAX);
> >> >> +     }
> >> >> +
> >> >
> >> > I think this will interact badly with Mark Salter's patches to relocate
> >> > the initrd if it falls outside of the linear mapping (which relies on the
> >> > memblocks remaining intact after paging_init):
> >> >
> >> >   https://lkml.org/lkml/2015/8/16/75
> >> >
> >>
> >> Are you sure? By the looks of it, these patches combined would
> >> correctly address the case where no mem= is passed, but the initial
> >> ramdisk is loaded past the end of the linear region.
> >>
> >> I.e., memblock_end_of_DRAM() will return the clipped value, which
> >> would be smaller than orig_end, triggering the relocation machinery
> >> which moves it inside the linear region.
> >
> > Ok. I was trying to consider the case where the initrd is outside of the
> > linear mapping not because of a restrictive "mem=", but because its out
> > of range of our page tables. AFAICT, we'll end up attempting to memcpy
> > the thing back down (but I appreciate that things won't work without
> > your patch too).
> >
> 
> But isn't the whole point of Mark's patches that the source initrd is
> memremap()'d and copied to a destination that is covered by the kernel
> direct mapping? I.e., mem= is enforced in the exact same place where
> this code is added, and so the initrd will not be mapped if it is
> outside of mem=

Yes, you're right. I'd somehow confused myself with the to_free case,
but it all falls out in the wash and we'll map what we need to map
before copying the initrd down.

Will
