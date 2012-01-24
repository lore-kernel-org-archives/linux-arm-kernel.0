From: joerg.roedel@amd.com (Joerg Roedel)
Date: Tue, 24 Jan 2012 12:04:44 +0100
Subject: [PATCH 2/2] ARM: IOMMU: Tegra30: Add iommu_ops for SMMU driver
In-Reply-To: <20120124.115701.2179509760878976509.hdoyu@nvidia.com>
References: <1325747509-29665-1-git-send-email-hdoyu@nvidia.com>
 <1325747509-29665-3-git-send-email-hdoyu@nvidia.com>
 <20120123154310.GC6269@8bytes.org>
 <20120124.115701.2179509760878976509.hdoyu@nvidia.com>
Message-ID: <20120124110444.GB19255@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 10:57:01AM +0100, Hiroshi Doyu wrote:
> > Why do you completly ignore the size parameter in this function (and
> > in the unmap part below)?
> > According to the page-sizes you export to the generic layer size can be
> > 4k or 4M. You need to take care of that in this function.
> 
> I'll drop 4MB support here once. I'll make another patch for 4MB page
> support later.

Okay, so when you only export 4k everything should be fine.

> > Hmm, this looks like there is a 1-1 mapping between hardware SMMU
> > devices and domains. This is not consistent with IOMMU-API semantics
> > where a domain can contain devices behind different SMMUs. Please fix
> > that.
> 
> I'm a bit confused with the concept of "domain". I thought that
> "domain" is equivalent to a "virtual address space". Usually a IOMMU
> device provides a virtual address space for multiple client
> devices. IOW, a IOMMU device provides a virtual address space, which
> can be shared with multiple client devices.
> 
> Actually Tegra SMMU case, a single IOMMU device has 4 different
> virtual address speace("smmu_as"). Each "smmu_as" has its own virtual
> address space. "smmu_as[i]" has mutiple "smmu_client" devices.
> 
>   smmu_as[i] == domain[i]
> 
> I don't understand why "a domain can contain devices behind different
> SMMUs" because those client devices belong to different virtual
> address spaces, and they should belong to different "domains".
> 
> Could you please explain a bit more about "domain"?

A domain is, as you said, a virtual address space for IO devices. But
the important point is, an arbitrary number of devices can be part of a
domain. This also means that the devices can be behind different
hardware SMMUs. In this case your driver needs to program the page-table
pointer into more than one SMMU to give devices behind different SMMUs
the same address space.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
