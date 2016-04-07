From: alex.williamson@redhat.com (Alex Williamson)
Date: Thu, 7 Apr 2016 11:50:01 -0600
Subject: [PATCH v6 0/7] KVM PCIe/MSI passthrough on ARM/ARM64: kernel
 part 1/3: iommu changes
In-Reply-To: <5706528B.2010906@linaro.org>
References: <1459757222-2668-1-git-send-email-eric.auger@linaro.org>
 <20160406171534.794c6824@t450s.home> <5706528B.2010906@linaro.org>
Message-ID: <20160407115001.25de7d1e@t450s.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Apr 2016 14:28:59 +0200
Eric Auger <eric.auger@linaro.org> wrote:

> Hi Alex,
> On 04/07/2016 01:15 AM, Alex Williamson wrote:
> > On Mon,  4 Apr 2016 08:06:55 +0000
> > Eric Auger <eric.auger@linaro.org> wrote:
> >   
> >> This series introduces the dma-reserved-iommu api used to:
> >> - create/destroy an iova domain dedicated to reserved iova bindings
> >> - map/unmap physical addresses onto reserved IOVAs.
> >> - unmap and destroy all IOVA reserved bindings  
> > 
> > Why are we making the decision to have an unbalanced map vs unmap, we
> > can create individual mappings, but only unmap the whole thing and
> > start over?  That's a strange interface.  Thanks,  
> The "individual" balanced unmap also exists (iommu_put_reserved_iova)
> and this is the "normal" path. This happens on msi_domain_deactivate
> (and possibly on msi_domain_set_affinity).
> 
> I added iommu_unmap_reserved to handle the case where the userspace
> registers a reserved iova domain and fails to unregister it. In that
> case one need to handle the cleanup on kernel-side and I chose to
> implement this on vfio_iommu_type1 release. All the reserved IOMMU
> bindings get destroyed on that event.
> 
> Any advice to handle this situation?

If we want to model it similar to regular iommu domains, then
iommu_free_reserved_iova_domain() should release all the mappings and
destroy the iova domain.  Additionally, since the reserved iova domain
is just a construct on top of an iommu domain, it should be sufficient
to call iommu_domain_free() to also remove the reserved iova domain if
one exists.  Thanks,

Alex
