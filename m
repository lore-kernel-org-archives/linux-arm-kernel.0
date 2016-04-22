From: alex.williamson@redhat.com (Alex Williamson)
Date: Fri, 22 Apr 2016 13:07:28 -0600
Subject: [PATCH v7 00/10] KVM PCIe/MSI passthrough on ARM/ARM64: kernel
 part 1/3: iommu changes
In-Reply-To: <571A1996.5010009@linaro.org>
References: <1461084994-2355-1-git-send-email-eric.auger@linaro.org>
 <5718C501.20906@linaro.org> <20160421133222.76e45596@t450s.home>
 <571A1996.5010009@linaro.org>
Message-ID: <20160422130728.62afe3a0@t450s.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Apr 2016 14:31:18 +0200
Eric Auger <eric.auger@linaro.org> wrote:

> Hi Alex,
> On 04/21/2016 09:32 PM, Alex Williamson wrote:
> > On Thu, 21 Apr 2016 14:18:09 +0200
> > Eric Auger <eric.auger@linaro.org> wrote:
> >   
> >> Hi Alex, Robin,
> >> On 04/19/2016 06:56 PM, Eric Auger wrote:  
> >>> This series introduces the dma-reserved-iommu api used to:
> >>>
> >>> - create/destroy an iova domain dedicated to reserved iova bindings
> >>> - map/unmap physical addresses onto reserved IOVAs.
> >>> - search for an existing reserved iova mapping matching a PA window
> >>> - determine whether an msi needs to be iommu mapped
> >>> - translate an msi_msg PA address into its IOVA counterpart    
> >>
> >> Following Robin's review, I understand one important point we have to
> >> clarify is how much this API has to be generic.
> >>
> >> I agree with Robin on the fact there is quite a lot of duplication
> >> between this dma-reserved-iommu implementation and dma-iommu
> >> implementation. Maybe we could consider an msi-mapping API
> >> implementation upon dma-iommu.c. This implementation would add MSI
> >> doorbell binding list management, including, ref counting and locking.
> >>
> >> We would need to add a map/unmap function taking an iova/pa/size as
> >> parameters in current dma-iommu.c
> >>
> >> An important assumption is that the dma-mapping API and the msi-mapping
> >> API must not be used concurrently (be would be trying to use the same
> >> cookie to store a different iova_domain).
> >>
> >> Any thought/suggestion?  
> > 
> > Hi Eric,
> > 
> > I'm not attached to a generic interface, the important part for me is
> > that if we have an iommu domain with space reserved for MSI, the MSI
> > setup and allocation code should handle that so we don't need to play
> > the remapping tricks between vfio-pci and a vfio iommu driver that we
> > saw in early drafts of this.  My first inclination is always to try to
> > make a generic, re-usable interface, but I apologize if that's led us
> > astray here and we really do want the more simple, MSI specific
> > interface.
> > 
> > For the IOMMU API, rather than just a DOMAIN_ATTR_MSI_MAPPING flag,
> > what about DOMAIN_ATTR_MSI_GEOMETRY with both a get and set attribute?
> > Maybe something like:
> > 
> > struct iommu_domain_msi_geometry {
> > 	dma_addr_t	aperture_start;
> > 	dma_addr_t	aperture_end;
> > 	bool		fixed; /* or 'programmable' depending on your polarity preference */
> > };
> > 
> > Calling \get\ on arm would return { 0, 0, false }, indicating it's
> > programmable, \set\ would allocate the iovad as specified.  That would
> > make it very easy to expand the API to x86 with reporting of the fixed
> > MSI range and it operates within the existing IOMMU API interfaces.
> > Thanks,  
> Yes I would be happy to handle this x86 query requirement. I would be
> more inclined to define it at "MSI mapping API" level since the IOMMU
> API implementation does not handle iova allocation, as Robin argued as
> the beginning. When "MSI MAPPING API" CONFIG is unset I would return
> default x86 aperture.
> 
> Does it make sense?

It's not entirely clear to me if x86 would be participating in this MSI
mapping API given the implicit handling within iommu/irq-remapping.
It might make sense if x86 iommus simply left a gap in their existing
geometry reporting through the iommu api.  I guess we'll see in your
next draft ;)  Thanks,

Alex
