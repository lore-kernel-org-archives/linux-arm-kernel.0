From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 03 Mar 2017 09:40:44 +0000
Subject: [RFC PATCH 22/30] iommu: Bind/unbind tasks to/from devices
In-Reply-To: <20170227195441.5170-23-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-23-jean-philippe.brucker@arm.com>
Message-ID: <1488534044.6234.14.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-02-27 at 19:54 +0000, Jean-Philippe Brucker wrote:
> Add three functions to the IOMMU API. iommu_bind_task takes a device and a
> task as argument. If the IOMMU, the device and the bus support it, attach
> task to device and create a Process Address Space ID (PASID) unique to the
> device. DMA from the device can then use the PASID to read or write into
> the address space. iommu_unbind_task removes a bond created with
> iommu_bind_task. iommu_set_svm_ops allows a device driver to set some
> callbacks for specific SVM-related operations.
> 
> Try to accommodate current implementations (AMD, Intel and ARM), by
> letting the IOMMU driver do all the work, but attempt by the same occasion
> to find intersections between implementations.
> 
> * amd_iommu_v2 expects the device to allocate a PASID and pass it to the
> ? IOMMU. The driver also provides separate functions to register callbacks
> ? that handles failed PRI requests and invalidate PASIDs.
> 
> ? int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
> 			???struct task_struct *task)
> ? void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid)
> ? int amd_iommu_set_invalid_ppr_cb(struct pci_dev *pdev,
> 				???amd_iommu_invalid_ppr_cb cb)
> ? int amd_iommu_set_invalidate_ctx_cb(struct pci_dev *pdev,
> 				??????amd_iommu_invalidate_ctx cb)
> 
> * intel-svm allocates a PASID, and requires the driver to pass
> ? "svm_dev_ops", which currently contains a fault callback. It also
> ? doesn't take a task as argument, but uses 'current'.
> 
> ? int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
> 			struct svm_dev_ops *ops)
> ? int intel_svm_unbind_mm(struct device *dev, int pasid)
> 
> * For arm-smmu-v3, PASID must be allocated by the SMMU driver since it
> ? indexes contexts in an array handled by the SMMU device.

Right. The Intel version was designed with all of the above three in
mind. It was discussed at the Kernel Summit and LPC on more than one
occasion as it took shape, and what I implemented for Intel basicall
represents the consensus of what we thought it should look like.

I meant to convert the AMD driver to the same API, but don't have
access to test hardware. Note that the amdkfd code will need careful
attention here.

Intel slightly deviates from the "one PASID per process" vision too,
because it currently has a PASID allocator idr per IOMMU. That wants
making system-wide. And probably not Intel-specific.

Some other comments...

The callbacks and fault handlers could perhaps be deprecated. In an
ideal world nobody would ever use them ? the device itself is supposed
to be able to communicate with its driver about the request that
failed; we don't need a dirty hook into the IOMMU code from when *it*
handles the fault.

In the Intel IOMMU fault reports, there are some additional bits in the
descriptor which are 'context private' bits. For built-in devices like
the graphics engine, this contains further information about precisely
which context was performing the failing access. But again I don't
think we should need it in an ideal world. It's a horrid thing to have
to feed through a generic IOMMU API.

One thing which might help us *avoid* needing it is the
SVM_FLAG_PRIVATE_PASID option, which asks for a *new* PASID. So a
single process can have more than one PASID. That's still OK on ARM,
isn't it? As long as they're all allocated from the same pool and we
never use a given PASID for more than one address space simultaneously
on different devices.

We also have SVM_FLAG_SUPERVISOR_MODE, which gives access to kernel
address space. Yes, people use it.



> ? PASID invalidation
> ? ------------------
> 
> Next, we need to let the IOMMU driver notify the device driver before it
> attempts to unbind a PASID. Subsequent patches discuss PASID invalidation
> in more details, so we'll simply propose the following interface for now.
> 
> AMD has:
> 
> void (*amd_iommu_invalidate_ctx)(struct pci_dev *pdev, int pasid);
> 
> We put the following in iommu_svm_ops:
> 
> int (*invalidate_pasid)(struct device *dev, int pasid, void *priv);

These can basically take for ever, right? You're asking the *device* to
tell you when it's finished using that PASID.

> ? Capability detection
> ? ====================
> ...
> 
> int iommu_svm_capable(struct device *dev, int flags);

We already had this for Intel. It basically goes through *all* the
enabling checks that it needs to for really setting up SVM, and that's
why it's actually the *same* call, but with a NULL pasid argument:

#define intel_svm_available(dev) (!intel_svm_bind_mm((dev), NULL, 0, NULL))

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170303/9107d62f/attachment.bin>
