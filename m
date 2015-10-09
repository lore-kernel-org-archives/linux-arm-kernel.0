From: yong.wu@mediatek.com (Yong Wu)
Date: Fri, 9 Oct 2015 10:23:02 +0800
Subject: [PATCH v5 0/6] MT8173 IOMMU SUPPORT
Message-ID: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  This patch set adds support for m4u(Multimedia Memory Management Unit),
Currently it only support the m4u with 2 levels of pagetable on mt8173.

  It's based on Robin Murphy's latest ARM64 DMA-v6[1]. The dsti is based
on MTK clock patch[2].
 
  Please check the hardware block diagram of Mediatek IOMMU.
 
              EMI (External Memory Interface)
               |
              m4u (Multimedia Memory Management Unit)
               |
              smi (Smart Multimedia Interface)
               |
        +---------------+-------
        |               |
        |               |
    vdec larb       disp larb      ... SoCs have different local arbiter(larb).
        |               |
        |               |
   +----+----+    +-----+-----+
   |    |    |    |     |     |    ...
   |    |    |    |     |     |    ...
   |    |    |    |     |     |    ...
  MC   PP   VLD  OVL0 RDMA0 WDMA0  ... There are different ports in each larb.
  
  Normally we specify a local arbiter(larb) for each multimedia hardware like
display, video decode, video encode and camera. And there are different ports in
each larb. Take a example, there are some ports like MC, PP, UFO, VLD, AVC_MV,
PRED_RD in video larb, all the ports are according to the video hardware.
 
  From the diagram, all the multimedia module connect with m4u via smi.
SMI is responsible to enable/disable iommu and control the clocks for each local
arbiter. If we would like to enable the iommu of video decode, the video decode
HW ports have to be configed. And if the video hardware work whether
enable/disable iommu, it need enable the clock of its larb's clock. And smi also
help bandwidth control for each local. So we add a special driver for smi and
locate it drivers/memory.

v5:
-rebase onto v4.3-rc1.
-About MTK iommu: don't return the same domain while domain_alloc, change the
 domain's flow according to the M4U HW.
-About Short-descriptor: Improve many error-handles, NO_PERMS quirk, and 
 add TLBI_MAP quirk following Will's Suggestion; Add io-pgtable don't use 
 dma_to_phys; Add a loop in arm_short_unmap since iommu_unmap don't care the 
 physical address align.
-About SMI driver: Add a help funcion for some similar code. Add PROPRE_DEFER
 for power-domain as MTK SCPSYS is module_init currently.

v4: http://lists.linuxfoundation.org/pipermail/iommu/2015-August/013903.html
-use only one iommu domain here based on the Robin's DMA-v5:
 http://lists.linuxfoundation.org/pipermail/iommu/2015-July/013900.html
-remove flush_pgtable.
-change writel to writel_relaxed.
-about Short-descriptor: move dma_map_single into io-pgtable-arm-short.
 Improve the flow of free pgtable and add NO_XN+NO_PERMS quirk following
 Will's suggestion.
-Change two sytle issues in dtsi according to Daniel's suggestion.

v3: http://lists.linuxfoundation.org/pipermail/iommu/2015-July/013632.html
-rebased onto v4.2-rc1
-improve iommu flow based on the Robin's DMA v3:
 http://lists.linuxfoundation.org/pipermail/iommu/2015-July/013597.html
-change mtk iommu-cells from 1 to 2.
-about Short-descriptor: add split function; add self-test; add some other bits like nG,
 XN according to the spec; add SUPERSECTION and MTK quirk; move io_pgtable_ops_to_pgtable
 out from LPAE to the header file.
-about SMI: move from driver/soc/mediatek to driver/memory; change the clocks from
 clk[2] to clk_apb and clk_smi; add pm.
-add iommu suspend/resume to backup/restore register.

v2: http://lists.linuxfoundation.org/pipermail/iommu/2015-May/013028.html
-add arm short descriptor support.
-seperate smi common from smi and change the clock-names according
 to smi HW.
-delete the hardcode of the port-names in mt8173.
 replace this with larb-portes-nr in dtsi.
-fix some coding style issues.

v1: http://lists.infradead.org/pipermail/linux-mediatek/2015-March/000058.html
-initial version.

[1]: http://lists.linuxfoundation.org/pipermail/iommu/2015-October/014504.html
[2]: http://lists.infradead.org/pipermail/linux-mediatek/2015-August/001962.html

Yong Wu (6):
  dt-bindings: iommu: Add binding for mediatek IOMMU
  dt-bindings: mediatek: Add smi dts binding
  iommu: add ARM short descriptor page table allocator
  memory: mediatek: Add SMI driver
  iommu/mediatek: Add mt8173 IOMMU driver
  dts: mt8173: Add iommu/smi nodes for mt8173

 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  61 ++
 .../memory-controllers/mediatek,smi-larb.txt       |  25 +
 .../bindings/memory-controllers/mediatek,smi.txt   |  24 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |  81 ++
 drivers/iommu/Kconfig                              |  33 +
 drivers/iommu/Makefile                             |   2 +
 drivers/iommu/io-pgtable-arm-short.c               | 827 +++++++++++++++++++++
 drivers/iommu/io-pgtable-arm.c                     |   3 -
 drivers/iommu/io-pgtable.c                         |   3 +
 drivers/iommu/io-pgtable.h                         |  18 +-
 drivers/iommu/mtk_iommu.c                          | 767 +++++++++++++++++++
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/mtk-smi.c                           | 274 +++++++
 include/dt-bindings/memory/mt8173-larb-port.h      | 105 +++
 include/soc/mediatek/smi.h                         |  60 ++
 16 files changed, 2288 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi.txt
 create mode 100644 drivers/iommu/io-pgtable-arm-short.c
 create mode 100644 drivers/iommu/mtk_iommu.c
 create mode 100644 drivers/memory/mtk-smi.c
 create mode 100644 include/dt-bindings/memory/mt8173-larb-port.h
 create mode 100644 include/soc/mediatek/smi.h

-- 
1.8.1.1.dirty
