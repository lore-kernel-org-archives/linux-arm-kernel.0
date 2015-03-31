From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 31 Mar 2015 17:07:01 +0100
Subject: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
 iommu_ops
In-Reply-To: <20150331142440.GD22683@8bytes.org>
References: <20150327171946.GL1562@arm.com> <20150331142440.GD22683@8bytes.org>
Message-ID: <551AC625.6000200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On 31/03/15 15:24, Joerg Roedel wrote:
> Hi Will,
>
> On Fri, Mar 27, 2015 at 05:19:46PM +0000, Will Deacon wrote:
>> Please can you pull the following IOMMU changes for 4.1? They move the
>> per-iommu_ops pgsize_bitmap field into the iommu_domain, which allows
>> IOMMUs such as the ARM SMMU to support different page sizes within a
>> given SoC.
>
> I have some concerns about the direction taken with this patch-set. The
> goal for the IOMMU-API is still to have domains that can be attached to
> arbitrary devices (even when mappings already exist). But with this
> patch-set we move into a direction where a domain can only be used on
> IOMMUs that support the page-sizes required by the domain. In the end
> this would be visible to the user of the IOMMU-API, which is not what we
> want.

I think the notion of sharing domains between arbitrary devices is 
already broken for systems with multiple IOMMU devices - with the 
iommu_domain itself now embedded in a private data structure, it's 
certainly not safe to pass it to two different drivers, should the 
client devices be behind heterogeneous IOMMUs. Furthermore, since most 
of those private data structures contain instance-specific data, that 
prevents a domain spanning even two homogeneous IOMMU devices.

If the goal is for iommu_domains to be a hardware-independent 
abstraction, then shouldn't we be looking to move the other 
instance-specific features like attributes and geometry out of them? 
Perhaps the answer is the opposite; accept the existing iommu_domain as 
what it appears to be used as - a fairly thin abstraction of one or more 
context banks/uTLBs/DMARs/whatever on a single IOMMU device - and 
consider some higher-level interface for grouping one or more of these 
"device domains" together and sharing a single IOVA space between them.


Robin.

> I can understand the motivation behind these patches, but we need to
> think about how this could work with the desired semantics of the
> IOMMU-API.
>
>
> 	Joerg
>
