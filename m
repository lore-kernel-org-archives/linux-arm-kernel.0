From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 3 Nov 2016 16:57:40 +0000
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 4.9
In-Reply-To: <20161103162943.GS3541@8bytes.org>
References: <20161028160148.GD1076@arm.com> <20161103153303.GA837@8bytes.org>
 <20161103160006.GS22791@arm.com> <20161103161407.GR3541@8bytes.org>
 <0dbf2665-4292-d49a-b9e7-688bcdf29c6e@arm.com>
 <20161103162943.GS3541@8bytes.org>
Message-ID: <a6ded15c-5eea-70b8-61a1-b40873af8699@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/16 16:29, Joerg Roedel wrote:
> On Thu, Nov 03, 2016 at 04:22:04PM +0000, Robin Murphy wrote:
>> But bus_set_iommu() is already checking whether another SMMU (in this
>> case) has probed, by virtue of bus->iommu_ops being non-NULL, and
>> returning without doing anything if so. What's the value of adding a
>> whole  bunch more code to effectively duplicate that in a less elegant
>> manner?
> 
> No, bus_set_iommu() checks whether there is _any_ other IOMMU already
> registered. This doesn't need to be an smmu. So I think the return value
> of bus_set_iommu shouldn't be generally ignored.

But if it is someone else's ops, then all that means is that the SMMU
driver isn't going to get notified about devices on that bus, or get
called with them later, so I still don't see where the problem is. If
there are devices on that bus which the SMMU *is* supposed to be
managing, then that system can't be supported with the current API anyway.

Robin.
