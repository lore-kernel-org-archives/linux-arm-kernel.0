From: Varun.Sethi@freescale.com (Varun Sethi)
Date: Mon, 15 Dec 2014 16:35:12 +0000
Subject: [PATCH 2/4] iommu: add ARM LPAE page table allocator
In-Reply-To: <20141215154317.GL20738@arm.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
 <1417089078-22900-3-git-send-email-will.deacon@arm.com>
 <BN3PR0301MB12198CE5D736CDC6A221EDC2EA790@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <20141205184802.GH1203@arm.com>
 <BN3PR0301MB1219D3161E4E9DB314FDD8FAEA6E0@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <20141215133020.GJ20738@arm.com> <20141215154317.GL20738@arm.com>
Message-ID: <BN3PR0301MB12194A8F5CFF870B7A124623EA6F0@BN3PR0301MB1219.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

-----Original Message-----
From: Will Deacon [mailto:will.deacon at arm.com] 
Sent: Monday, December 15, 2014 9:13 PM
To: Sethi Varun-B16395
Cc: linux-arm-kernel at lists.infradead.org; iommu at lists.linux-foundation.org; prem.mallappa at broadcom.com; Robin Murphy; lauraa at codeaurora.org; mitchelh at codeaurora.org; laurent.pinchart at ideasonboard.com; joro at 8bytes.org; m.szyprowski at samsung.com
Subject: Re: [PATCH 2/4] iommu: add ARM LPAE page table allocator

On Mon, Dec 15, 2014 at 01:30:20PM +0000, Will Deacon wrote:
> On Sun, Dec 14, 2014 at 05:45:49PM +0000, Varun Sethi wrote:
> > [varun] ok, but you could potentially end up splitting mapping to 
> > the least possible page size e.g. 4K. You, don't seem to take in to 
> > account the possibility of using the block size at the next level. 
> > For example, take a case where we have a huge page mapping using 1G 
> > page size and we have an unmap request for 4K. We could still split 
> > maximum part of the mapping using 2M pages at the next level. The 
> > entry where we need to unmap the 4K region would potentially go to the next level.
> 
> Aha, I see what you mean here, thanks. I'll take a look...

Scratch that, I think the code is fine as it is. For the case you highlight, we iterate over the 1GB region remapping it using 4k pages, but skipping the one we want to unmap, so I don't think there's a problem (__arm_lpae_map will create the relevant table entries).


[[varun]]  But you can split 1G in 2M mappings and then split up the unmapped region using 4K pages. In this case you split up the entire region using 4K pages.

Thanks,
Varun
