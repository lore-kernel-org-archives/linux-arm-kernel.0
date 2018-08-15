From: shunyong.yang@hxt-semitech.com (Yang, Shunyong)
Date: Wed, 15 Aug 2018 01:43:37 +0000
Subject: [PATCH v3 4/6] iommu/io-pgtable-arm: add support for non-strict
 mode
In-Reply-To: <feabf4a3-db1e-a22b-daab-fad831b473f9@arm.com>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
 <1531376312-2192-5-git-send-email-thunder.leizhen@huawei.com>
 <89cc2201-99ab-3f3b-a2d1-1766515d4375@arm.com>
 <5B597628.2020103@huawei.com>
 <04239cfa-bcf2-a33a-e662-ebc75e66782b@arm.com>
 <1d24541340334954969c58980ef85444@HXTBJIDCEMVIW01.hxtcorp.net>
 <5B7293E5.7040702@huawei.com> <20180814083500.GA28101@arm.com>
 <feabf4a3-db1e-a22b-daab-fad831b473f9@arm.com>
Message-ID: <7a2dedda98aa9e677eb7f85b6b55e34e0128d2d9.camel@hxt-semitech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Robin,

On Tue, 2018-08-14 at 11:02 +0100, Robin Murphy wrote:
> On 14/08/18 09:35, Will Deacon wrote:
> > On Tue, Aug 14, 2018 at 04:33:41PM +0800, Leizhen (ThunderTown)
> > wrote:
> > > On 2018/8/6 9:32, Yang, Shunyong wrote:
> > > > On 2018/7/26 22:37, Robin Murphy wrote:
> > > > > Because DMA code is not the only caller of iommu_map/unmap.
> > > > > It's
> > > > > perfectly legal in the IOMMU API to partially unmap a
> > > > > previous mapping
> > > > > such that a block entry needs to be split. The DMA API,
> > > > > however, is a
> > > > > lot more constrined, and thus by construction the iommu-dma
> > > > > layer will
> > > > > never generate a block-splitting iommu_unmap() except as a
> > > > > result of
> > > > > illegal DMA API usage, and we obviously do not need to
> > > > > optimise for that
> > > > > (you will get a warning about mismatched unmaps under dma-
> > > > > debug, but
> > > > > it's a bit too expensive to police in the general case).
> > > > > 
> > > > 
> > > > When I was reading the code around arm_lpae_split_blk_unmap(),
> > > > I was
> > > > curious in which scenario a block will be split. Now with your
> > > > comments
> > > > "Because DMA code is not the only caller of iommu_map/unmap",
> > > > it seems
> > > > depending on the user.
> > > > 
> > > > Would you please explain this further? I mean besides DMA,
> > > > which user
> > > > will use iommu_map/umap and how it split a block.
> > > 
> > > I also think that arm_lpae_split_blk_unmap() scenario is not
> > > exist, maybe
> > > we should remove it, and give a warning for this wrong usage.
> > 
> > Can't it happen with VFIO?
> 
> ...or GPU drivers, or anyone else managing their own IOMMU domain 
> directly. A sequence like this is perfectly legal:
> 
> 	iommu_map(domain, iova, paddr, SZ_8M, prot);
> 	...
> 	iommu_unmap(domain, iova + SZ_1M * 5, SZ_1M * 3);
> 
> where if iova and paddr happen to be suitably aligned, the map will
> lay 
> down blocks, and the unmap will then have to split one of them into 
> pages to remove half of it. We don't tear our hair out maintaining 
> split_blk_unmap() for the fun of it :(

Thank you for the GPU example. But for VFIO, I remember all memory will
be   pinned in the early stage of emulator (such as qemu) start. So,
the split will occur at which operation? Maybe virtio balloon inflate?

Thanks.
Shunyong.

> 
> Robin.
