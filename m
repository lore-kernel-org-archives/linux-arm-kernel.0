From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 1 May 2015 12:06:44 +0100
Subject: [Linaro-acpi] [PATCH 2/2] ACPI / scan: Parse _CCA and setup
 device coherency
In-Reply-To: <2817500.sgztgK2NzB@wuerfel>
References: <D1665A4F.19E17%suravee.suthikulpanit@amd.com>
 <2817500.sgztgK2NzB@wuerfel>
Message-ID: <20150501110644.GF27755@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 05:54:02PM +0200, Arnd Bergmann wrote:
> On Wednesday 29 April 2015 14:57:10 Suthikulpanit, Suravee wrote:
> > Otherwise, it would seem inconsistent with what states in the ACPI spec:
> >  
> >   CCA objects are only relevant for devices that can access
> >   CPU-visible memory, such as devices that are DMA capable. On ARM
> >   based systems, the _CCA object must be supplied all such devices.
> >   On Intel platforms, if the _CCA object is not supplied, the OSPM
> >   will assume the devices are hardware cache coherent.
> > 
> > From the statement above, I interpreted as if it is not present, it would
> > be non-coherent.
> 
> My guess is that this section was included for Windows Phone, which runs
> on embedded SoCs that usually have noncoherent DMA in a particular way.
> 
> Linux however only uses ACPI for servers, so that case does not happen.
> 
> I guess it would be reasonable to add a run-time warning here if you
> try to do DMA on a device that does not have CCA set, and you should
> probably set the DMA mask to 0 in that case as well.

I agree, if _CCA isn't present, we should not allow DMA. With DT, the
default dma_ops point to non-coherent but with ACPI, we could change
the default to a dummy set of dma_ops which don't do anything (or just
return NULL). Something like below, untested:


diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 9437e3dc5833..3fd6ef019c8f 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -31,10 +31,14 @@ extern struct dma_map_ops *dma_ops;
 
 static inline struct dma_map_ops *__generic_dma_ops(struct device *dev)
 {
-	if (unlikely(!dev) || !dev->archdata.dma_ops)
+	if (!dev)
 		return dma_ops;
-	else
+	else if (dev->archdata.dma_ops)
 		return dev->archdata.dma_ops;
+	else if (!acpi_disabled)
+		return dummy_dma_ops;
+	else
+		return dma_ops;
 }
 
 static inline struct dma_map_ops *get_dma_ops(struct device *dev)
@@ -48,6 +52,8 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 				      struct iommu_ops *iommu, bool coherent)
 {
+	if (!acpi_disabled && !dev->archdata.dma_ops)
+		dev->archdata.dma_ops = dma_ops;
 	dev->archdata.dma_coherent = coherent;
 }
 #define arch_setup_dma_ops	arch_setup_dma_ops


The core code should not call arch_setup_dma_ops() if no _CCA option is
found.

> Note that there are lots of ways in which you could have noncoherent DMA:
> the default on ARM32 is that it requires uncached access or explicit
> cache flushes, but it's also possible to have an SMP system where a device
> is only coherent with some of the CPUs and requires explicit synchronization
> (not flushes) otherwise. In a multi-level cache hierarchy, there could be
> all sorts of combinations of flushes and syncs you would need to do.
> 
> With DT, we handle this using SoC-specific overrides for platforms that
> are noncoherent in funny ways, see
> http://lxr.free-electrons.com/source/arch/arm/mach-mvebu/coherency.c?v=3.18#L263
> for instance.

It looks like mach-mvebu no longer needs this, according to commit
1bd4d8a6de5c (ARM: mvebu: use arm_coherent_dma_ops and re-enable hardware
I/O coherency).

Even if some hardware needs this, it's usually because it has some
broken assumptions about barriers which most likely are architecture
non-compliant. We can work around it on a case by case basis (SoC
quirks). One option would be to disable coherency altogether for that
device, even if the performance is affected (e.g. no partial coherency).
Another possibility may be to add a bus driver for that broken
interconnect which installs its own dma ops for each device attached.

> If we just disallow DMA to devices that are marked with _CCA=0
> in ACPI, we can avoid this case, or discuss it by the time someone has hardware
> that wants it, and then make a more informed decision about it.

I don't think we should disallow DMA to devices with _CCA == 0 (only to
those that don't have a _CCA property at all) as long as _CCA == 0 has
clear semantics like only architected cache maintenance required (and
that's what the ARMv8 ARM requires from compliant system caches).

-- 
Catalin
