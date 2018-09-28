From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Fri, 28 Sep 2018 18:04:31 +0800
Subject: [PATCH v5 0/9] PCI: mediatek: fixup find_port, enable_msi and add pm,
 module support
Message-ID: <1538129080-8206-1-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

This patchset includes misc patchs:

The patch 1 fixup the mtk_pcie_find_port logic which will cause system
could not touch the EP's configuration space that connected to PCIe slot 1.

The patch 2 fixup the class type for MT7622.
The patch 6 fixup the enable msi logic, the operation to enable msi
should be after system clock is enabled. Call mtk_pcie_enable_msi in
mtk_pcie_startup_port_v2 since the clock was all enabled at that time.

The patch 7 was rebased and refactor of the v4 patch[1], changes are:
 -Add PM support for MT7622.
 -Using mtk_pcie_enable_port to re-establish the link when resumed.
 -Rebased on this patchset.

The patch 9 add loadable kernel module support.

[1] https://patchwork.kernel.org/patch/10479079

Change since v4:
 - Add patch 2 to fixup class type for MT7622.
 - Add patch 3 to remove the redundant dev->pm_domain check
 - Add patch 4 to covert to use pci_host_probe
 - Add patch 5 to re-arrange the function define, this is a prepare patch for
   fixup the enable_msi logic, no functional changed have been made by this one.
 - Add patch 8 to save the GIC IRQ in mtk_pcie_port as a prepare patch for tear
   down the irq when remove the kernel module.
 - Re-arrange the find_port flow suggest by Lorenzo to make the code parse easier
   for the patch 1.
 - Remove the .pm_support in mtk_pcie_soc in patch 7 since if system pm was not
   supported, then those pm callbacks will never be executed for MT7622. So the
   .pm_support is not needed.

Change since v3:
 - Remove pm_runtime_XXX ops in suspend and resume callbacks in the third patch.
 - Rebase to 4.19-rc1.

Change since v2:
 - Fix the list_for_each_entry_safe parameter error.
 - Add Ryder's Acked-by flag.

Change since v1:
 - A bit of code refact of the first patch suggested by Andy Shevchenko, and
   commit message updated.
 - Using __maybe_unused.
 - Remove the redundant list_empty check of the fourth patch.

Honghui Zhang (9):
  PCI: mediatek: Using slot's devfn for compare to fix
    mtk_pcie_find_port logic
  PCI: mediatek: Fixup class ID for MT7622 as PCI_CLASS_BRIDGE_PCI
  PCI: mediatek: Remove the redundant dev->pm_domain check
  PCI: mediatek: Convert to use pci_host_probe()
  PCI: mediatek: Move the mtk_pcie_startup_port_v2 function's define
    after mtk_pcie_setup_irq
  PCI: mediatek: Enable msi after clock enabled
  PCI: mediatek: Add system pm support for MT2712 and MT7622
  PCI: mediatek: Save the GIC IRQ in mtk_pcie_port
  PCI: mediatek: Add loadable kernel module support

 drivers/pci/controller/Kconfig         |   2 +-
 drivers/pci/controller/pcie-mediatek.c | 326 +++++++++++++++++++++------------
 2 files changed, 210 insertions(+), 118 deletions(-)

-- 
2.6.4
