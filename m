From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 29 Jun 2016 18:00:53 +0100
Subject: [PATCH 3/5] arm64: efi: avoid block mappings for unaligned UEFI
 memory regions
In-Reply-To: <CAKv+Gu9CxorhWGzx=CaVWnEWZ-AhBt3dh0XU+Vw1gNe=HxkySQ@mail.gmail.com>
References: <1467204690-10790-1-git-send-email-ard.biesheuvel@linaro.org>
 <1467204690-10790-4-git-send-email-ard.biesheuvel@linaro.org>
 <20160629164525.GE2522@e104818-lin.cambridge.arm.com>
 <CAKv+Gu_OUw+WJSNmC8mdAgAK8Nm=UGqtwgt8TBCwhTiBY9+2tg@mail.gmail.com>
 <CAKv+Gu9CxorhWGzx=CaVWnEWZ-AhBt3dh0XU+Vw1gNe=HxkySQ@mail.gmail.com>
Message-ID: <20160629170053.GY22984@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 06:53:18PM +0200, Ard Biesheuvel wrote:
> On 29 June 2016 at 18:50, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 29 June 2016 at 18:45, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> On Wed, Jun 29, 2016 at 02:51:28PM +0200, Ard Biesheuvel wrote:
> >>> +     if (!PAGE_ALIGNED(md->phys_addr) ||
> >>> +         !PAGE_ALIGNED(md->num_pages << EFI_PAGE_SHIFT)) {
> >>> +             /*
> >>> +              * If the end address of this region is not aligned to page
> >>> +              * size, the mapping is rounded up, and may end up sharing a
> >>> +              * page frame with the next UEFI memory region. If we create
> >>> +              * a block entry now, we may need to split it again when mapping
> >>> +              * the next region, and support for that is going to be removed
> >>> +              * from the MMU routines. So avoid block mappings altogether in
> >>> +              * that case.
> >>> +              */
> >>> +             allow_block_mappings = false;
> >>> +     }
> >>
> >> How common is it for large areas to have unaligned start/end? I wonder
> >> whether it's worth implementing my approach to look ahead and explicitly
> >> check the overlap with the next section instead of disabling block
> >> mappings altogether for this region.
> >>
> >
> > Very uncommon. Typically, only MMIO regions that represent NOR flash
> > are larger than a couple of pages. Taken from QEMU:
> 
>   RT_Code   :            640 Pages (2,621,440 Bytes)
>   RT_Data   :            880 Pages (3,604,480 Bytes)
> 
> so all RT_Code regions *combined* are 2.5 MB in total, and all RT_Data
> regions 3.5 MB. Ideally, they are grouped together, but in reality,
> there are always a couple of regions of each type, so there is little
> to gain here from using block mappings

Is this representative for real platforms?

What about efifb and reserved regions?

My (x86) Lenovo workstation has one 64MB and one 16MB Runtime/Uncached
MMIO region. As well as a 3MB and a 4MB RT_Data one.

/
    Leif
