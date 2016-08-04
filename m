From: yt.shen@mediatek.com (YT Shen)
Date: Thu, 4 Aug 2016 19:07:14 +0800
Subject: [PATCH v6 00/10] MT2701 DRM support
Message-ID: <1470308844-20895-1-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is MT2701 DRM support PATCH v6, based on 4.7-rc1.
We add DSI interrupt control, transfer function for MIPI DSI panel support.
Most codes are the same, except some register changed.

For example:
 - DISP_OVL address offset changed, color format definition changed.
 - DISP_RDMA fifo size changed.
 - DISP_COLOR offset changed.
 - MIPI_TX setting changed.

We add a new component DDP_COMPONENT_BLS, and the connections are updated.
OVL -> RDMA -> COLOR -> BLS -> DSI
RDMA -> DPI
And we have shadow register support in MT2701.

Changes since v5:
- Remove DPI device tree and compatible string
- Use one wait queue to handle interrupt status
- Update the interrupt check flow and DSI_INT_ALL_BITS
- Use same function for host read/write command
- various fixes

Changes since v4:
- Add messages when timeout in mtk_disp_mutex_acquire()
- Add descriptions for DISP_REG_MUTEX registers
- Move connection settings for display modules to a separate patch
- Remove 'mt2701-disp-wdma' because it is unused
- Move cleaning up and renaming to a separate patch
- Use wait_event_interruptible_timeout() to replace polling
- Remove irq_num from mtk_dsi structure
- Remove redundant and debug codes

Changes since v3:
- Add DSI support for MIPI DSI panels
- Update BLS binding to PWM nodes
- Remove ufoe device nodes
- Remove redundant parentheses
- Remove global variable initialization

Changes since v2:
- Rename mtk_ddp_mux_sel to mtk_ddp_sout_sel
- Update mt2701_mtk_ddp_ext components
- Changed to prefix naming
- Reorder the patch series
- Use of_device_get_match_data() to get driver private data
- Use iopoll macros to implement mtk_disp_mutex_acquire()
- Removed empty device tree nodes

Changes since v1:
- Removed BLS bindings and codes, which belong to pwm driver
- Moved mtk_disp_mutex_acquire() just before mtk_crtc_ddp_config()
- Split patch into smaller parts
- Added const keyword to constant structure
- Removed codes for special memory align

The PATCH depends on the following patch:
https://patchwork.kernel.org/patch/8832441/ ("dt-bindings: ARM: Mediatek: Document bindings for MT2701")
https://patchwork.kernel.org/patch/9222997/ ("dt-bindings: pwm: Add MediaTek display PWM bindings")
https://patchwork.kernel.org/patch/9164029/ ("dt-bindings: mediatek: add descriptions for mediatek mt2701 iommu and smi")
https://patchwork.kernel.org/patch/9164017/ ("iommu/mediatek: move the common struct into header file")
https://patchwork.kernel.org/patch/9164025/ ("memory/mediatek: add support for mt2701")
https://patchwork.kernel.org/patch/9164041/ ("iommu/mediatek: add support for mtk iommu generation one HW")
https://patchwork.kernel.org/patch/9164013/ ("ARM: dts: mt2701: add iommu/smi dtsi node for mt2701")

Thanks,
yt.shen

YT Shen (8):
  drm/mediatek: rename macros, add chip prefix
  drm/mediatek: add *driver_data for different hardware settings
  drm/mediatek: add shadow register support
  drm/mediatek: update display module connections
  drm/mediatek: cleaning up and refine
  drm/mediatek: update DSI sub driver flow
  drm/mediatek: add support for Mediatek SoC MT2701
  arm: dts: mt2701: Add display subsystem related nodes for MT2701

shaoming chen (2):
  drm/mediatek: add dsi interrupt control
  drm/mediatek: add dsi transfer function

 arch/arm/boot/dts/mt2701.dtsi               |   86 +++++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |   32 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |   17 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |   75 ++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c      |  138 ++++++--
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h      |    2 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   34 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   14 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   54 ++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h      |    9 +
 drivers/gpu/drm/mediatek/mtk_dsi.c          |  506 ++++++++++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_mipi_tx.c      |   71 ++--
 12 files changed, 878 insertions(+), 160 deletions(-)

-- 
1.7.9.5
