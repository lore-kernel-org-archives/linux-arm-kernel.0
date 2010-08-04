From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Wed, 4 Aug 2010 11:52:37 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <4C586348.2050209@codeaurora.org>
References: <20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
	<201007291026.55928.arnd@arndb.de> <20100729084018.GM26098@amd.com>
	<20100729174621W.fujita.tomonori@lab.ntt.co.jp>
	<20100729090607.GN26098@amd.com> <4C586348.2050209@codeaurora.org>
Message-ID: <20100804095237.GH18307@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 03, 2010 at 02:43:20PM -0400, Stepan Moskovchenko wrote:
>   On 8/3/2010 2:23 AM, Roedel, Joerg wrote:
> > A domain is defined by a single page-table which can be modified using
> > the iommu_map/iommu_unmap function calls. I am not completly sure what
> > you mean by an iommu_context. Can you describe what it means in your
> > context?
> 
> Joerg,
> I think with some rework, all my use cases can be handled by your 
> existing iommu API. If the domain is treated basically a page table, 
> there will be some changes, but I think it can be done. I will push a 
> new version of my driver in a few days.
> 
> One thing that may be helpful for the future, however, is maybe 
> something like adding iommu_tlb_flush to the ops. I suppose this would 
> either have to take a device, or the domain would need to keep a list of 
> devices it had been attached to (so that their TLBs can be invalidated). 
> But I suppose on the other hand, iommu_map/unmap may be able to just 
> implicitly invalidate the TLB also, since TLB invalidation often follows 
> map/unmap. What are your thoughts?

Sounds good. I am curious for your patches :-)

For the TLB-flush question, I think it would make sense to add iommu
tlb flushing functions to the IOMMU-API. We currently flush the TLB
implicitly in the map/unmap calls but thats very inefficient. It would
be better to have a seperate function for it in the API. The right
parameter for such a function is a domain. The IOMMU driver knows which
devices are attached to a domain an could easily flush all TLBs.

One alternative I can think of: An iommu_domain_commit() function which
syncs software changes of a domain to the hardware. The map/unmap calls
have to save which parts of the tlb need to be flushed and commit does
flush those parts then (or flush everything).

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
