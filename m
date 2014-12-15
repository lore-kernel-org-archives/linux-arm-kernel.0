From: Varun.Sethi@freescale.com (Varun Sethi)
Date: Mon, 15 Dec 2014 16:43:59 +0000
Subject: [PATCH 2/4] iommu: add ARM LPAE page table allocator
In-Reply-To: <20141215133020.GJ20738@arm.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
 <1417089078-22900-3-git-send-email-will.deacon@arm.com>
 <BN3PR0301MB12198CE5D736CDC6A221EDC2EA790@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <20141205184802.GH1203@arm.com>
 <BN3PR0301MB1219D3161E4E9DB314FDD8FAEA6E0@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <20141215133020.GJ20738@arm.com>
Message-ID: <BN3PR0301MB12199C5CAD33E745CC7E51F4EA6F0@BN3PR0301MB1219.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



-----Original Message-----
From: Will Deacon [mailto:will.deacon at arm.com] 
Sent: Monday, December 15, 2014 7:00 PM
To: Sethi Varun-B16395
Cc: linux-arm-kernel at lists.infradead.org; iommu at lists.linux-foundation.org; prem.mallappa at broadcom.com; Robin Murphy; lauraa at codeaurora.org; mitchelh at codeaurora.org; laurent.pinchart at ideasonboard.com; joro at 8bytes.org; m.szyprowski at samsung.com
Subject: Re: [PATCH 2/4] iommu: add ARM LPAE page table allocator

On Sun, Dec 14, 2014 at 05:45:49PM +0000, Varun Sethi wrote:
> Please find my response inline. Search for "varun".

This is getting fiddly now that you've already replied once. Any chance you could sort your mail client out, please?


[[varun]]  Yes I need to do that, this is painful.

> > +       if (!data)
> > +               return NULL;
> > +
> > +       data->pages_per_pgd = 1;
> > +       data->pg_shift = __ffs(cfg->pgsize_bitmap);
> > +       data->bits_per_level = data->pg_shift - 
> > + ilog2(sizeof(arm_lpae_iopte));
> > +
> > +       va_bits = cfg->ias - data->pg_shift;
> > +       data->levels = DIV_ROUND_UP(va_bits, data->bits_per_level);
> >
> > [[varun]]  Not related to the patch, but this would be applicable to 
> > the CPU tables as well i.e, we can't support 48bit VA with 64 KB 
> > page tables, right? The AR64 memory maps shows possibility of using 
> > 6 bits for the first level page table.
> 
> Sure we can support 48-bit VAs with 64k pages. Why do you think we can't?
> 
> [varun]  My concern was with respect to the bits per level, which is 
> uneven for the 64 K page sizes. Just wondering how would things work 
> with 64K pages when we do a 3 level page lookup.

Well, it's uneven (9) for the 4k case too. Do you actually see an issue here?

48-bit VA with 64k pages gives us:

  va_bits = (48 - 16) = 32
  bits_per_level = (16 - 3) = 13
  levels = ceil(32/13) = 3

so the starting level is 1, which resolves 32-(13*2) = 6 bits.

Does that make sense?

[[varun]]Yes, but what I meant was, is that in case of 4K pages you have 9 bits per level, but for 64K pages you have 6 bits for the first  level and 13 each for second and third. So, bits per level would not work in case of 64 K pages?

Thanks,
Varun
