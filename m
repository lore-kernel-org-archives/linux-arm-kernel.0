From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Tue, 03 Aug 2010 11:43:20 -0700
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <20100803092325.GD18307@amd.com>
References: <20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
	<201007291026.55928.arnd@arndb.de> <20100729084018.GM26098@amd.com>
	<20100729174621W.fujita.tomonori@lab.ntt.co.jp>
	<20100729090607.GN26098@amd.com>
	<d493494df33aaf65e526181b1dbafce3.squirrel@www.codeaurora.org>
	<20100802075802.GN24084@amd.com>
	<20100802202935.GA26214@codeaurora.org>
	<20100803092325.GD18307@amd.com>
Message-ID: <4C586348.2050209@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  On 8/3/2010 2:23 AM, Roedel, Joerg wrote:
> On Mon, Aug 02, 2010 at 04:29:38PM -0400, Zach Pfeffer wrote:
>> On Mon, Aug 02, 2010 at 09:58:02AM +0200, Roedel, Joerg wrote:
>>> In the means of the IOMMU-API the domain is the abstraction of an
>>> address space (in other words a page table). The IOMMU(s) which this domain
>>> is later assigned to are determined by the iommu_attach_device calls.
>>> I think the right way to go here is to create the concept of a
>>> device-context in the IOMMU-API and add functions like
>>>
>>> 	iommu_attach_context(struct iommu_domain *domain,
>>> 			     struct iommu_context *ctxt);
>>> 	iommu_detach_context(struct iommu_context *ctxt);
>>>
>>> This would work if you can determine in your iommu-driver which iommu
>>> you need to program for which device. What do you think?
>>>
>> Joerg, I'd like to make sure I understand this. A domain is an address
>> space separate from the actual page-tables that may be part of an
>> iommu_context, correct? After I iommu_attach_context the ctxt will
>> reflect the address space of the domain, correct?
> A domain is defined by a single page-table which can be modified using
> the iommu_map/iommu_unmap function calls. I am not completly sure what
> you mean by an iommu_context. Can you describe what it means in your
> context?
>
> 	Joerg
>

Joerg,
I think with some rework, all my use cases can be handled by your 
existing iommu API. If the domain is treated basically a page table, 
there will be some changes, but I think it can be done. I will push a 
new version of my driver in a few days.

One thing that may be helpful for the future, however, is maybe 
something like adding iommu_tlb_flush to the ops. I suppose this would 
either have to take a device, or the domain would need to keep a list of 
devices it had been attached to (so that their TLBs can be invalidated). 
But I suppose on the other hand, iommu_map/unmap may be able to just 
implicitly invalidate the TLB also, since TLB invalidation often follows 
map/unmap. What are your thoughts?

Thanks
Steve
