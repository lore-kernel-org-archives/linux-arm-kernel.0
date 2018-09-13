From: kevin.tian@intel.com (Tian, Kevin)
Date: Thu, 13 Sep 2018 07:15:54 +0000
Subject: [PATCH v2 01/40] iommu: Introduce Shared Virtual Addressing API
In-Reply-To: <20180907142504.5034351e@jacob-builder>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-2-jean-philippe.brucker@arm.com>
 <bf42affd-e9d0-e4fc-6d28-f3c3f7795348@redhat.com>
 <03d31ba5-1eda-ea86-8c0c-91d14c86fe83@arm.com>
 <ed39159c-087e-7e56-7d29-d1de9fa1677f@amd.com>
 <f0b317d5-e2e9-5478-952c-05e8b97bd68b@arm.com>
 <2fd4a0a1-1a35-bf82-df84-b995cce011d9@amd.com>
 <65e7accd-4446-19f5-c667-c6407e89cfa6@arm.com>
 <5bbc0332-b94b-75cc-ca42-a9b196811daf@amd.com>
 <20180907142504.5034351e@jacob-builder>
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191301CAC@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Jacob Pan [mailto:jacob.jun.pan at linux.intel.com]
> Sent: Saturday, September 8, 2018 5:25 AM
> > > iommu-sva expects everywhere that the device has an iommu_domain,
> > > it's the first thing we check on entry. Bypassing all of this would
> > > call idr_alloc() directly, and wouldn't have any code in common
> > > with the current iommu-sva. So it seems like you need a layer on
> > > top of iommu-sva calling idr_alloc() when an IOMMU isn't present,
> > > but I don't think it should be in drivers/iommu/
> >
> > In this case I question if the PASID handling should be under
> > drivers/iommu at all.
> >
> > See I can have a mix of VM context which are bound to processes (some
> > few) and VM contexts which are standalone and doesn't care for a
> > process address space. But for each VM context I need a distinct
> > PASID for the hardware to work.

I'm confused about VM context vs. process. Is VM referring to Virtual
Machine or something else? If yes, I don't understand the binding part
- what VM context is bound to (host?) process?

> >
> > I can live if we say if IOMMU is completely disabled we use a simple
> > ida to allocate them, but when IOMMU is enabled I certainly need a
> > way to reserve a PASID without an associated process.
> >
> VT-d would also have such requirement. There is a virtual command
> register for allocate and free PASID for VM use. When that PASID
> allocation request gets propagated to the host IOMMU driver, we need to
> allocate PASID w/o mm.
> 

VT-d is a bit different. In host side, PASID allocation always happens in
Qemu's context, so those PASIDs are recorded with Qemu process, 
though the entries may point to guest page tables instead of host mm
of Qemu.

Thanks
Kevin
