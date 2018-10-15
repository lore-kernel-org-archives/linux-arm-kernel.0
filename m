From: honghui.zhang@mediatek.com (Honghui Zhang)
Date: Mon, 15 Oct 2018 14:49:39 +0800
Subject: [PATCH v7 0/9] PCI: mediatek: fixup find_port, enable_msi and
 add PM, module support
In-Reply-To: <1539583554.20626.2.camel@mtkswgap22>
References: <1539582287-9171-1-git-send-email-honghui.zhang@mediatek.com>
 <1539583554.20626.2.camel@mtkswgap22>
Message-ID: <1539586179.10857.1.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-10-15 at 14:05 +0800, Ryder Lee wrote:
> On Mon, 2018-10-15 at 13:44 +0800, honghui.zhang at mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > This patchset includes misc patchs:
> > 
> > The patch 1 fixup the mtk_pcie_find_port logic which will cause system
> > could not touch the EP's configuration space that connected to PCIe slot 1.
> > 
> > The patch 2 fixup the class type for MT7622.
> > The patch 6 fixup the enable msi logic, the operation to enable MSI
> > should be after system clock is enabled. Call mtk_pcie_enable_msi in
> > mtk_pcie_startup_port_v2 since the clock was all enabled at that time.
> > 
> > The patch 7 was rebased and refactor of the v4 patch[1], changes are:
> >  -Add PM support for MT7622.
> >  -Using mtk_pcie_enable_port to re-establish the link when resumed.
> >  -Rebased on this patchset.
> > 
> > The patch 9 add loadable kernel module support.
> > 
> > [1] https://patchwork.kernel.org/patch/10479079
> > 
> > Change since v6:
> >  - Remove the pci_unmap_iospace when remove the device since the
> >    devm_pci_remap_iospace is an devm_ version.
> >  - Commit message changed for patch 2(Fix class type for MT7622 as PCI_CLASS_BRIDGE_PCI).
> >  - Capitilizing "MSI" and "PM" in the patch title.
> > 
> > Change since v5:
> >  - A bit improvement of mtk_pcie_find_port suggest by Lorenzo.
> >  - Add fixup tags of fix enable MSI logic in patch 6.
> >  - Add Acked-by tags from Ryder.
> > 
> > Change since v4:
> >  - Add patch 2 to fixup class type for MT7622.
> >  - Add patch 3 to remove the redundant dev->pm_domain check
> >  - Add patch 4 to covert to use pci_host_probe
> >  - Add patch 5 to re-arrange the function define, this is a prepare patch for
> >    fixup the enable_msi logic, no functional changed have been made by this one.
> >  - Add patch 8 to save the GIC IRQ in mtk_pcie_port as a prepare patch for tear
> >    down the irq when remove the kernel module.
> >  - Re-arrange the find_port flow suggest by Lorenzo to make the code parse easier
> >    for the patch 1.
> >  - Remove the .pm_support in mtk_pcie_soc in patch 7 since if system pm was not
> >    supported, then those pm callbacks will never be executed for MT7622. So the
> >    .pm_support is not needed.
> > 
> > Change since v3:
> >  - Remove pm_runtime_XXX ops in suspend and resume callbacks in the third patch.
> >  - Rebase to 4.19-rc1.
> > 
> > Change since v2:
> >  - Fix the list_for_each_entry_safe parameter error.
> >  - Add Ryder's Acked-by flag.
> > 
> > Change since v1:
> >  - A bit of code refact of the first patch suggested by Andy Shevchenko, and
> >    commit message updated.
> > 
> > Honghui Zhang (9):
> >   PCI: mediatek: Using slot's devfn for compare to fix
> >     mtk_pcie_find_port logic
> >   PCI: mediatek: Fix class type for MT7622 as PCI_CLASS_BRIDGE_PCI
> >   PCI: mediatek: Remove the redundant dev->pm_domain check
> >   PCI: mediatek: Convert to use pci_host_probe()
> >   PCI: mediatek: Move the mtk_pcie_startup_port_v2 function's define
> >     after mtk_pcie_setup_irq
> >   PCI: mediatek: Fixup enable MSI logic by enable MSI after clock
> >     enabled
> >   PCI: mediatek: Add system PM support for MT2712 and MT7622
> >   PCI: mediatek: Save the GIC IRQ in mtk_pcie_port
> >   PCI: mediatek: Add loadable kernel module support
> > 
> >  drivers/pci/controller/Kconfig         |   2 +-
> >  drivers/pci/controller/pcie-mediatek.c | 319 +++++++++++++++++++++------------
> >  2 files changed, 204 insertions(+), 117 deletions(-)
> 
> 
> You forgot to add my Acked-by tags in v7.
> 
> Acked-by: Ryder Lee <ryder.lee@mediatek.com> for the series.

Sorry about that,

Lorenzo, do I need to re-send this series with Ryder's Acked-by tags?

Thanks.
> 
> Thanks.
> 
