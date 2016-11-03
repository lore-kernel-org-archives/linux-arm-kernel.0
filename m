From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 3 Nov 2016 16:22:04 +0000
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 4.9
In-Reply-To: <20161103161407.GR3541@8bytes.org>
References: <20161028160148.GD1076@arm.com> <20161103153303.GA837@8bytes.org>
 <20161103160006.GS22791@arm.com> <20161103161407.GR3541@8bytes.org>
Message-ID: <0dbf2665-4292-d49a-b9e7-688bcdf29c6e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/16 16:14, Joerg Roedel wrote:
> On Thu, Nov 03, 2016 at 04:00:06PM +0000, Will Deacon wrote:
>> We're basically doing that already, since the bus_set_iommu call happens in
>> the probe routine, which won't run unless an SMMUv3 has been found in the
>> DT. The issue we're trying to avoid is failing the probe of a second SMMUv3
>> in the system, because the bus will already have the iommu ops set by the
>> first SMMUv3 that probed.
>>
>> I suppose we could go and compare bus->iommu_ops with &arm_smmu_ops, but
>> given that we can't support different IOMMU types on a single bus, I don't
>> think we gain anything from that.
> 
> Can you instead check whether there is already another smmu probed and
> skip the bus_set_iommu call then?

But bus_set_iommu() is already checking whether another SMMU (in this
case) has probed, by virtue of bus->iommu_ops being non-NULL, and
returning without doing anything if so. What's the value of adding a
whole  bunch more code to effectively duplicate that in a less elegant
manner?

Robin.

> 
> 
> 	Joerg
> 
