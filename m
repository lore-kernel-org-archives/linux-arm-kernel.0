From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Dec 2014 15:43:17 +0000
Subject: [PATCH 2/4] iommu: add ARM LPAE page table allocator
In-Reply-To: <20141215133020.GJ20738@arm.com>
References: <1417089078-22900-1-git-send-email-will.deacon@arm.com>
 <1417089078-22900-3-git-send-email-will.deacon@arm.com>
 <BN3PR0301MB12198CE5D736CDC6A221EDC2EA790@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <20141205184802.GH1203@arm.com>
 <BN3PR0301MB1219D3161E4E9DB314FDD8FAEA6E0@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <20141215133020.GJ20738@arm.com>
Message-ID: <20141215154317.GL20738@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 01:30:20PM +0000, Will Deacon wrote:
> On Sun, Dec 14, 2014 at 05:45:49PM +0000, Varun Sethi wrote:
> > [varun] ok, but you could potentially end up splitting mapping to the
> > least possible page size e.g. 4K. You, don't seem to take in to account
> > the possibility of using the block size at the next level. For example,
> > take a case where we have a huge page mapping using 1G page size and we
> > have an unmap request for 4K. We could still split maximum part of the
> > mapping using 2M pages at the next level. The entry where we need to unmap
> > the 4K region would potentially go to the next level.
> 
> Aha, I see what you mean here, thanks. I'll take a look...

Scratch that, I think the code is fine as it is. For the case you highlight,
we iterate over the 1GB region remapping it using 4k pages, but skipping
the one we want to unmap, so I don't think there's a problem
(__arm_lpae_map will create the relevant table entries).

Will
