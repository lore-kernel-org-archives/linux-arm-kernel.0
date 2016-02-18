From: alex.williamson@redhat.com (Alex Williamson)
Date: Thu, 18 Feb 2016 09:06:08 -0700
Subject: [RFC v3 05/15] iommu/arm-smmu: implement
 alloc/free_reserved_iova_domain
In-Reply-To: <56C5A65D.5010401@arm.com>
References: <1455264797-2334-1-git-send-email-eric.auger@linaro.org>
 <1455264797-2334-6-git-send-email-eric.auger@linaro.org>
 <56C5A65D.5010401@arm.com>
Message-ID: <20160218090608.025a5103@t450s.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Feb 2016 11:09:17 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> Hi Eric,
> 
> On 12/02/16 08:13, Eric Auger wrote:
> > Implement alloc/free_reserved_iova_domain for arm-smmu. we use
> > the iova allocator (iova.c). The iova_domain is attached to the
> > arm_smmu_domain struct. A mutex is introduced to protect it.  
> 
> The IOMMU API currently leaves IOVA management entirely up to the caller 
> - VFIO is already managing its own IOVA space, so what warrants this 
> being pushed all the way down to the IOMMU driver? All I see here is 
> abstract code with no hardware-specific details that'll have to be 
> copy-pasted into other IOMMU drivers (e.g. SMMUv3), which strongly 
> suggests it's the wrong place to do it.
> 
> As I understand the problem, VFIO has a generic "configure an IOMMU to 
> point at an MSI doorbell" step to do in the process of attaching a 
> device, which hasn't needed implementing yet due to VT-d's 
> IOMMU_CAP_I_AM_ALSO_ACTUALLY_THE_MSI_CONTROLLER_IN_DISGUISE flag, which 
> most of us have managed to misinterpret so far. AFAICS all the IOMMU 
> driver should need to know about this is an iommu_map() call (which will 
> want a slight extension[1] to make things behave properly). We should be 
> fixing the abstraction to be less x86-centric, not hacking up all the 
> ARM drivers to emulate x86 hardware behaviour in software.

The gap I see is that, that the I_AM_ALSO_ACTUALLY_THE_MSI...
solution transparently fixes, is that there's no connection between
pci_enable_msi{x}_range and the IOMMU API.  If I want to allow a device
managed by an IOMMU API domain to perform MSI, I need to go scrape the
MSI vectors out of the device, setup a translation into my IOVA space,
and re-write those vectors.  Not to mention that as an end user, I
have no idea what might be sharing the page where those vectors are
targeted and what I might be allowing the user DMA access to.  MSI
setup is necessarily making use of the IOVA space of the device, so
there's clearly an opportunity to interact with the IOMMU API to manage
that IOVA usage.  x86 has an implicit range of IOVA space for MSI, this
makes an explicit range, reserved by the IOMMU API user for this
purpose.  At the vfio level, I just want to be able to call the PCI
MSI/X setup routines and have them automatically program vectors that
make use of IOVA space that I've already marked reserved for this
purpose.  I don't see how that's x86-centric other than x86 has already
managed to make this transparent and spoiled users into expecting
working IOVAs on the device after using standard MSI vector setup
callbacks.  That's the goal I'm looking for.  Thanks,

Alex
