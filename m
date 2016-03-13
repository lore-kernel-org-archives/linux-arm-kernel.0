From: yong.wu@mediatek.com (Yong Wu)
Date: Mon, 14 Mar 2016 06:01:09 +0800
Subject: [PATCH v2 0/2] MT8173 IOMMU 4GB MODE SUPPORT
Message-ID: <1457906471-31549-1-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set add MTK 4GB mode support on the Short-Descriptor.

Normally, the memory map in mt8173 looks like below:

Physical addr
| 1st GB |    ->  HW SRAM and Regs
|--------
| 2nd GB |    ->  Dram 1st GB
|--------
| 3rd GB |    ->  Dram 2nd GB
|--------
| 4th GB |    ->  Dram 3rd GB
|--------

Then if the dram size is 4GB, we have to add bit33 in the physical
address. We have a "DRAM 4GB mode" toggle bit for this.
If it is enabled, from CPU's point of view, the dram will
be shifted to start from PA 0x1_00000000. Then the dram PA is from
0x1_00000000~0x1_ffffffff.

MTK extend the bit9 of the standard pgtable descriptor as the 4GB mode.
we add a special quirk for this.

v2:
- Rebase on next-20160310.
- Rename IO_PGTABLE_QUIRK_MTK_4GB_EXT to IO_PGTABLE_QUIRK_ARM_MTK_4GB.
- Improve the comment of this "4GB mode".

Yong Wu (2):
  iommu/io-pgtable: Add MTK 4GB mode in Short-descriptor
  iommu/mediatek: Add 4GB mode support

 drivers/iommu/io-pgtable-arm-v7s.c | 13 ++++++++++++-
 drivers/iommu/io-pgtable.h         |  6 ++++++
 drivers/iommu/mtk_iommu.c          | 14 +++++++++++---
 3 files changed, 29 insertions(+), 4 deletions(-)

-- 
1.8.1.1.dirty
