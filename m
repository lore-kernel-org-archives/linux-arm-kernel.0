From: jnair@caviumnetworks.com (Jayachandran C)
Date: Wed, 22 Mar 2017 08:51:09 +0000
Subject: [PATCH v3 0/2] Handle Cavium ThunderX2 PCI topology quirk
Message-ID: <1490172671-2648-1-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn, Alex,

Here is v3 of the patchset to handle the PCIe topology quirk of
Cavium ThunderX2 (previously called Broadcom Vulcan).

The earlier discussions on this can be seen at:
http://www.spinics.net/lists/linux-pci/msg51001.html
https://patchwork.ozlabs.org/patch/582633/ and
https://lists.linuxfoundation.org/pipermail/iommu/2016-June/017681.html

The earlier discussion on this patchset had stalled with a suggestion
that it may be possible to fix up this quirk by handling the issue in
the function argument of pci_for_each_dma_alias(). But at that point
all the ACPI and OF code for SMMU and GIC was to merged, and we did not
have reasonable codebase to make the changes.

For 4.11, I tried to fix it in both the SMMU and the GIC ITS code based
on this suggestion, but after going thru the effort, that does not look
like the right approach. I have the code changes at:
https://github.com/jchandra-cavm/linux/commits/rid-xlate-fixup
if anyone want to look over the code.

The problems with that approach is:
 - of the 14 uses of pci_for_each_dma_alias in the function in the kernel
   tree, I have to fixup 6 callers (which is all but one ofthe callers
   outside x86)
 - 4 of these can be reasonably handled (please see the github repo above),
   but the calls in drivers/irqchip/irq-gic-v3-its-pci-msi.c and
   drivers/iommu/iommu.c cannot be reasonably fixed up.
 - Even without the 2 above two changes I can get it to work for now.
   But pci_for_each_dma_alias does not work as expected on this platform
   and we have to be aware of that for all future uses of the function.
  
For now, I have ruled out that approach, and I have rebased the earlier
patch on to 4.11-rc and submitting again for review. The changes are:

v2>v3:
 - changed device flag name from PCI_DEV_FLAGS_DMA_ALIAS_ROOT to
   PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT
 - updated commit message to make the quirk clearer.

Let me know your comments and suggestions.

Thanks,
JC.

Jayachandran C (2):
  PCI: Add device flag PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT
  PCI: quirks: Fix ThunderX2 dma alias handling

 drivers/pci/quirks.c | 14 ++++++++++++++
 drivers/pci/search.c |  4 ++++
 include/linux/pci.h  |  2 ++
 3 files changed, 20 insertions(+)

-- 
2.7.4
