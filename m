From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 24 Jan 2012 12:36:14 +0100
Subject: [PATCH 2/2] ARM: IOMMU: Tegra30: Add iommu_ops for SMMU driver
In-Reply-To: <20120124110444.GB19255@amd.com>
References: <20120123154310.GC6269@8bytes.org><20120124.115701.2179509760878976509.hdoyu@nvidia.com><20120124110444.GB19255@amd.com>
Message-ID: <20120124.133614.1646093482547685131.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: [PATCH 2/2] ARM: IOMMU: Tegra30: Add iommu_ops for SMMU driver
Date: Tue, 24 Jan 2012 12:04:44 +0100
Message-ID: <20120124110444.GB19255@amd.com>

> > > Hmm, this looks like there is a 1-1 mapping between hardware SMMU
> > > devices and domains. This is not consistent with IOMMU-API semantics
> > > where a domain can contain devices behind different SMMUs. Please fix
> > > that.
> > 
> > I'm a bit confused with the concept of "domain". I thought that
> > "domain" is equivalent to a "virtual address space". Usually a IOMMU
> > device provides a virtual address space for multiple client
> > devices. IOW, a IOMMU device provides a virtual address space, which
> > can be shared with multiple client devices.
> > 
> > Actually Tegra SMMU case, a single IOMMU device has 4 different
> > virtual address speace("smmu_as"). Each "smmu_as" has its own virtual
> > address space. "smmu_as[i]" has mutiple "smmu_client" devices.
> > 
> >   smmu_as[i] == domain[i]
> > 
> > I don't understand why "a domain can contain devices behind different
> > SMMUs" because those client devices belong to different virtual
> > address spaces, and they should belong to different "domains".
> > 
> > Could you please explain a bit more about "domain"?
> 
> A domain is, as you said, a virtual address space for IO devices. But
> the important point is, an arbitrary number of devices can be part of a
> domain. This also means that the devices can be behind different
> hardware SMMUs. In this case your driver needs to program the page-table
> pointer into more than one SMMU to give devices behind different SMMUs
> the same address space.

Thank you for explaining.

Does the above mean that a buffer can be shared with different devices
which belong to different IOMMU devices(virtual address spaces)?

For example, assuming the following:

- We have "struct iommu_domain *domain1".
- "domain1" has iommu device "iommu_dev1" and "iommu_dev2".
- "iommu_dev1" has "client_dev1" and "client_dev2".
- "iommu_dev2" has "client_dev3" and "client_dev4".

"iommu_map(domain1, iova, pa, ...)" will create the following mapping
___at once___:

- (iova)-(pa) mapping in iommu_dev1(iommmu_dev1's virtual address space)
- (iova)-(pa) mapping in iommu_dev2(iommmu_dev2's virtual address space)

Is the above correct?

It seems that the same (iova) is used for different virtual address
spaces. What kind of case is this beneficial most in?
