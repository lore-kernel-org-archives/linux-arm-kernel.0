From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Wed, 27 Jun 2018 17:21:34 +0800
Subject: [PATCH 0/4] PCI: mediatek: fixup find_port, enable_msi and add pm,
 module support
Message-ID: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

This patchset includes misc patchs:

The first patch fixup the mtk_pcie_find_port logical which will cause system
could not touch the EP's configuration space which was connected to PCIe slot 1.

The second patch fixup the enable msi logical, the operation to enable msi
should be after system clock is enabled. The function of mtk_pcie_startup_port_v2's
define location is re-arranged to avoid mtk_pcie_enable_msi's forward declaration.
And call mtk_pcie_enable_msi in mtk_pcie_startup_port_v2 since the clock was all
enabled at that time.

The third patch was rebased and refactor of the v4 patch[1], changes are:
 -Add PM support for MT7622.
 -Using mtk_pcie_enable_port to re-establish the link when resumed.
 -Rebase on the previous two patches.

The fourth patch add loadable kernel module support.

Those patches was already reviewed-by Ryder Lee <ryder.lee@mediatek.com> so
I just add the Reviewed-by tags in those patches.

[1] https://patchwork.kernel.org/patch/10479079

Honghui Zhang (4):
  PCI: mediatek: fixup mtk_pcie_find_port logical
  PCI: mediatek: enable msi after clock enabled
  PCI: mediatek: Add system pm support for MT2712 and MT7622
  PCI: mediatek: Add loadable kernel module support

 drivers/pci/controller/Kconfig         |   2 +-
 drivers/pci/controller/pcie-mediatek.c | 291 ++++++++++++++++++++++++---------
 2 files changed, 215 insertions(+), 78 deletions(-)

-- 
2.6.4
