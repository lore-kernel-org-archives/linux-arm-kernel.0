From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Jun 2014 16:25:26 +0100
Subject: [RFC PATCH v6 04/20] iommu/arm-smmu: add capability
 IOMMU_CAP_INTR_REMAP
In-Reply-To: <20140616152157.GB31771@8bytes.org>
References: <1401987808-23596-1-git-send-email-a.motakis@virtualopensystems.com>
 <1401987808-23596-5-git-send-email-a.motakis@virtualopensystems.com>
 <20140608103129.GC3279@lvm> <20140616145344.GD18986@8bytes.org>
 <20140616151329.GQ16758@arm.com>
 <20140616152157.GB31771@8bytes.org>
Message-ID: <20140616152526.GR16758@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 04:21:58PM +0100, Joerg Roedel wrote:
> On Mon, Jun 16, 2014 at 04:13:29PM +0100, Will Deacon wrote:
> > MSIs look just like memory accesses made by the device, so the SMMU
> > will translate them to point at the GIC ITS (doorbell). The ITS then
> > has tables to work out how to route the MSI.
> > 
> > So, if IOMMU_CAP_INTR_REMAP is simply supposed to indicate that the
> > SMMU can translate MSIs to point somewhere else, then the ARM SMMU can
> > always do it.  If it's supposed to indicate that the actual MSI
> > payload can be filtered/routed, then that requires the GIC ITS.
> > 
> > The part I'm unsure of is how VFIO knows where to map the MSIs to.
> > That requires knowledge of the physical and virtual doorbell pages --
> > is that discoverable in the API?
> 
> VFIO does not care about the actual routing, it only cares that the
> device can not send interrupts it is not allowed to send (e.g.
> interrupts to vectors used by other devices or, on x86, exception vectors).
> If that is guaranteed by the SMMU or the GIC ITS hardware and driver
> then it is fine to set this flag.

Ok, thanks. In which case, I think this is really a combined property of
the SMMU and the interrupt controller, so we might need some extra code
so that the SMMU can check that the interrupt controller for the device
is also capable of interrupt remapping.

Will
