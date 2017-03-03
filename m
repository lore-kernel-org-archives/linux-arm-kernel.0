From: Jean-Philippe.Brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 3 Mar 2017 18:39:58 +0000
Subject: [RFC PATCH 22/30] iommu: Bind/unbind tasks to/from devices
In-Reply-To: <1488534044.6234.14.camel@infradead.org>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-23-jean-philippe.brucker@arm.com>
 <1488534044.6234.14.camel@infradead.org>
Message-ID: <20170303183958.GA15146@e106794-lin.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Fri, Mar 03, 2017 at 09:40:44AM +0000, David Woodhouse wrote:
> On Mon, 2017-02-27 at 19:54 +0000, Jean-Philippe Brucker wrote:
> > Add three functions to the IOMMU API. iommu_bind_task takes a device and a
> > task as argument. If the IOMMU, the device and the bus support it, attach
> > task to device and create a Process Address Space ID (PASID) unique to the
> > device. DMA from the device can then use the PASID to read or write into
> > the address space. iommu_unbind_task removes a bond created with
> > iommu_bind_task. iommu_set_svm_ops allows a device driver to set some
> > callbacks for specific SVM-related operations.
> > 
> > Try to accommodate current implementations (AMD, Intel and ARM), by
> > letting the IOMMU driver do all the work, but attempt by the same occasion
> > to find intersections between implementations.
> > 
> > * amd_iommu_v2 expects the device to allocate a PASID and pass it to the
> > ? IOMMU. The driver also provides separate functions to register callbacks
> > ? that handles failed PRI requests and invalidate PASIDs.
> > 
> > ? int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
> > 			???struct task_struct *task)
> > ? void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid)
> > ? int amd_iommu_set_invalid_ppr_cb(struct pci_dev *pdev,
> > 				???amd_iommu_invalid_ppr_cb cb)
> > ? int amd_iommu_set_invalidate_ctx_cb(struct pci_dev *pdev,
> > 				??????amd_iommu_invalidate_ctx cb)
> > 
> > * intel-svm allocates a PASID, and requires the driver to pass
> > ? "svm_dev_ops", which currently contains a fault callback. It also
> > ? doesn't take a task as argument, but uses 'current'.
> > 
> > ? int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
> > 			struct svm_dev_ops *ops)
> > ? int intel_svm_unbind_mm(struct device *dev, int pasid)
> > 
> > * For arm-smmu-v3, PASID must be allocated by the SMMU driver since it
> > ? indexes contexts in an array handled by the SMMU device.
> 
> Right. The Intel version was designed with all of the above three in
> mind. It was discussed at the Kernel Summit and LPC on more than one
> occasion as it took shape, and what I implemented for Intel basicall
> represents the consensus of what we thought it should look like.

Good to know. I didn't intend to deviate much from the Intel version.

> I meant to convert the AMD driver to the same API, but don't have
> access to test hardware. Note that the amdkfd code will need careful
> attention here.
> 
> Intel slightly deviates from the "one PASID per process" vision too,
> because it currently has a PASID allocator idr per IOMMU. That wants
> making system-wide. And probably not Intel-specific.

Yes, it would be nice to have a common PASID allocator. But I don't
think that a system-wide PASID space is workable for us. At the moment
systems might have a few identical devices all supporting 20 bits of
PASID. But consider the case where one odd device can only handle four
address spaces, and supports a maximum of two PASID bits. We'd quickly
run out of PASIDs to hand to such devices, even though we could easily
have one PASID space per endpoint (from a quick glance at the specs, I
assume that both Intel and AMD IOMMUs offer one PASID table per RID.)

For example, we could have three devices, all with different PASID
capabilities, attached to process B. Device X was already bound to
process A, so it gets PASID 2 for process B. Devices Y and Z get PASID 1
for process B:

                        .-- PASID 1 ----- process A
              device X -+-- PASID 2 ---.
              device Y ---- PASID 1 ---+- process B
              device Z ---- PASID 1 ---'

This is the model I implemented for ARM, as I wanted to keep the RFC
simple before getting a chance to discuss the API. This is the finest
granularity, but history shows that some systems cannot isolate all
devices/RIDs from each others, be it by accident (bug, missing ACS) or
by design (NTB). Arguably this hasn't come up with SVM yet, and it might
never do. However, bringing IOMMU groups in the picture early seems
preferable than having to redesign everything five years from now. We
would have PASID spaces for each group, capped to the lowest common
denominator in the group, pasid_bits = min(pasid_bits of each device):

                               .- PASID 1 ----- process A
           device W -+- group -+- PASID 2 ---.
           device X -'                       |
           device X --- group --- PASID 1 ---+- process B
           device Z --- group --- PASID 1 ---'

Finally, to get in line with the core API, we could make the
iommu_domain hold the PASID space instead of the group. The API would
then look like this:

int iommu_bind(domain, task, &pasid, flags, priv)
int iommu_unbind(domain, task, flags)

IOMMU drivers would then call into a common PASID allocator and return a
PASID unique to the domain.

We can accept any number of attach_group on the domain prior to a bind.
The IOMMU driver can enable PASIDs as late as the first bind, so we
don't know the domain capacity. After the first bind, the number of
PASIDs is fixed to pasid_bits = min(pasid_bits of each group) for the
domain, and we should refuse to attach a new group with less PASIDs.

     device W -+- group --- domain --- PASID 1 ---.
     device X -'                                  |
     device X --- group -+- domain -+- PASID 1 ---+- process B
     device Z --- group -'          '- PASID 2 ----- process A

I could try that for next version. If it doesn't seem acceptable for the
core API, I guess we can always keep the per-device interface and have
IOMMU drivers manage either one or multiple PASID spaces.

> Some other comments...
> 
> The callbacks and fault handlers could perhaps be deprecated. In an
> ideal world nobody would ever use them ? the device itself is supposed
> to be able to communicate with its driver about the request that
> failed; we don't need a dirty hook into the IOMMU code from when *it*
> handles the fault.

Agreed.

> In the Intel IOMMU fault reports, there are some additional bits in the
> descriptor which are 'context private' bits. For built-in devices like
> the graphics engine, this contains further information about precisely
> which context was performing the failing access. But again I don't
> think we should need it in an ideal world. It's a horrid thing to have
> to feed through a generic IOMMU API.
>
> One thing which might help us *avoid* needing it is the
> SVM_FLAG_PRIVATE_PASID option, which asks for a *new* PASID. So a
> single process can have more than one PASID. That's still OK on ARM,
> isn't it? As long as they're all allocated from the same pool and we
> never use a given PASID for more than one address space simultaneously
> on different devices.

Yes, multiple PASIDs per task for the same device should be fine, and
I wouldn't have any objection to adding the PRIVATE_PASID flag into the
core API.

> We also have SVM_FLAG_SUPERVISOR_MODE, which gives access to kernel
> address space. Yes, people use it.

Argh, that seems dodgy :( I'm hoping we won't need this on ARM, since
drivers can always go through the DMA API for accessing kernel memory,
even for a domain that has SVM enabled.

> > ? PASID invalidation
> > ? ------------------
> > 
> > Next, we need to let the IOMMU driver notify the device driver before it
> > attempts to unbind a PASID. Subsequent patches discuss PASID invalidation
> > in more details, so we'll simply propose the following interface for now.
> > 
> > AMD has:
> > 
> > void (*amd_iommu_invalidate_ctx)(struct pci_dev *pdev, int pasid);
> > 
> > We put the following in iommu_svm_ops:
> > 
> > int (*invalidate_pasid)(struct device *dev, int pasid, void *priv);
> 
> These can basically take for ever, right? You're asking the *device* to
> tell you when it's finished using that PASID.

Theoretically yes, this could take forever. PCI doesn't give any time
boundary for the stop PASID mechanism (and PCI isn't the whole story on
ARM). But the device driver could simply return 0 after a timeout,
telling us that it was unable to invalidate the PASID. In which case the
IOMMU has to decide whether it is ready to risk having pending
transactions for this PASID access the next address space, or if it
should just throw the PASID away and never use it again.

> > ? Capability detection
> > ? ====================
> > ...
> > 
> > int iommu_svm_capable(struct device *dev, int flags);
> 
> We already had this for Intel. It basically goes through *all* the
> enabling checks that it needs to for really setting up SVM, and that's
> why it's actually the *same* call, but with a NULL pasid argument:
> 
> #define intel_svm_available(dev) (!intel_svm_bind_mm((dev), NULL, 0, NULL))

Right, Alex proposed a similar interface for VFIO, and I like the idea.
Perhaps we could add a flag IOMMU_BIND_PROBE for the core API instead of
relying on NULL pointers, to make it more clear?

Thanks,
Jean-Philippe
