From: jacob.jun.pan@linux.intel.com (Jacob Pan)
Date: Tue, 22 May 2018 09:43:34 -0700
Subject: [PATCH v2 03/40] iommu/sva: Manage process address spaces
In-Reply-To: <de478769-9f7a-d40b-a55e-e2c63ad883e8@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-4-jean-philippe.brucker@arm.com>
 <20180516163117.622693ea@jacob-builder>
 <de478769-9f7a-d40b-a55e-e2c63ad883e8@arm.com>
Message-ID: <20180522094334.71f0e36b@jacob-builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 May 2018 11:02:42 +0100
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 17/05/18 00:31, Jacob Pan wrote:
> > On Fri, 11 May 2018 20:06:04 +0100
> > I am a little confused about domain vs. pasid relationship. If
> > each domain represents a address space, should there be a domain for
> > each pasid?  
> 
> I don't think there is a formal definition, but from previous
> discussion the consensus seems to be: domains are a collection of
> devices that have the same virtual address spaces (one or many).
> 
> Keeping that definition makes things easier, in my opinion. Some time
> ago, I did try to represent PASIDs using "subdomains" (introducing a
> hierarchy of struct iommu_domain), but it required invasive changes in
> the IOMMU subsystem and probably all over the tree.
> 
> You do need some kind of "root domain" for each device, so that
> "iommu_get_domain_for_dev()" still makes sense. That root domain
> doesn't have a single address space but a collection of subdomains.
> If you need this anyway, representing a PASID with an iommu_domain
> doesn't seem preferable than using a different structure (io_mm),
> because they don't have anything in common.
> 
My main concern is the PASID table storage. If PASID table storage
is tied to domain, it is ok to scale up, i.e. multiple devices in a
domain share a single PASID table. But to scale down, e.g. further
partition device with VFIO mdev for assignment, each mdev may get its
own domain via vfio. But there is no IOMMU storage for PASID table at
mdev device level. Perhaps we do need root domain or some parent-child
relationship to locate PASID table.

> Thanks,
> Jean

[Jacob Pan]
